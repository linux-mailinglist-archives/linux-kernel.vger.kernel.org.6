Return-Path: <linux-kernel+bounces-225916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E772191376B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FE71F2256B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 02:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FF0D268;
	Sun, 23 Jun 2024 02:41:57 +0000 (UTC)
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8BA23;
	Sun, 23 Jun 2024 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719110516; cv=none; b=bIHse9GuLkmIei3YkmCOmBtYoqkCXe/yyV/EK1+yVNUiSHL1NcW3bsF3Qlr+kASQ2Y5eOfCJe510QkSpAwvZ+kjkEpEtctZC14wIqWMs/FBcB7kf4yhPoXONR66SDWhB7wdClkJNcJp7yU5OWCTV4Pz1eSZi+1H/Bn6WaZntg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719110516; c=relaxed/simple;
	bh=HiI9F3L1Thv7663MMmZOO+rudF2uZH75oGW+XT7h+MA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnCkxUpsJCm7gsZKA2DUXIDQAt9SS7eyVIF8UTmRjTo41ta7c4en+dfWjql2SYpvpwj2HN1DIWIiikrZRo31NC72a/oubf529+SMYqy/mJ2hOLiGZfYFmzAhdm6ENWDFVB1VrG8Pzl2LL2/v5AvW01yOntuyAj/y/E0rZgLnDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08635762|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.313904-0.00171844-0.684378;FP=0|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068155186;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Y7uvvUK_1719109571;
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.Y7uvvUK_1719109571)
          by smtp.aliyun-inc.com;
          Sun, 23 Jun 2024 10:26:12 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: bhelgaas@google.com,
	zhoushengqing@ttyinfo.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] PCI: Enable io space 1k granularity for intel cpu root port
Date: Sun, 23 Jun 2024 02:26:11 +0000
Message-Id: <20240623022611.41696-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240622175205.GA1432837@bhelgaas>
References: <20240622175205.GA1432837@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On Sat, Jun 22, 2024 at 11:06:18PM +0800, zhoushengqing@ttyinfo.com wrote:
>> >> This patch add 1k granularity for intel root port bridge.Intel latest
>>
>>
>>
>> >> server CPU support 1K granularity,And there is an BIOS setup item named
>>
>>
>>
>
>I don't know what your email agent is doing to add all these extra
>blank lines, but it makes it painful to read/reply:
>https://lore.kernel.org/all/2024062223061743562815@ttyinfo.com/
>

I'm sorry for the mistake I made in my email client settings.

>> >Can you implement this as a quirk similar to quirk_p64h2_1k_io()?
>> >
>> >I don't want to clutter the generic code with device-specific
>> >things like this.
>>
>> I have attempted to implement this patch in quirks.c.But there
>> doesn't seem to be a suitable DECLARE_PCI_FIXUP* to do this.because
>> the patch is not targeting the device itself, It targets other P2P
>> devices with the same bus number.
>
>If I understand the patch correctly, if a [8086:09a2] device on a root
>bus has EN1K set, *every* bridge (every Root Port in this case because
>I assume this is a PCIe configuration) on the same bus supports 1K
>granularity?
>
>That seems like a really broken kind of encapsulation.  I'd be
>surprised if there were not a bit in each of those Root Ports that
>indicates this.

Your understanding is completely correct.intel ICX SPR RMR (even GNR) 
CPU EDS Vol2(register) spec says "This bit when set, enables 1K granularity
for I/O space decode in each of the virtual P2P bridges corresponding to 
root ports,and DMI ports." it targets all P2P bridges within the same root bus,
not the root port itself.The root ports configuration space doesn't have a 
"EN1K" bit. 

