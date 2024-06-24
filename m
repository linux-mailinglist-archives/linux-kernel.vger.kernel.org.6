Return-Path: <linux-kernel+bounces-226656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF939141C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083D3280E09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31B617BCA;
	Mon, 24 Jun 2024 05:04:52 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B7179A7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205492; cv=none; b=B+UALowGAqPCvbojI2dNkPq+8JGjSK9pLn74vIzXQhwUac5ng78PcpJQLgsqV/Ky7deVTYbPcnDFm2cJKbbBVdpGmJknZczNOQWEMOb+9qUl69STmnl3+0ffJeCrThWrkEarFQ244wnm218beYPeQDQukoIgbhTxuwEbuSwlYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205492; c=relaxed/simple;
	bh=hu+GpDY/IU7PqdgB+K4XcFL1q/q3jNHapXpDur+yJp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7KYAUIhLG0CHGG0S83xTXkTEFcI+Xk+Dbxfl2AAE8vqipHFn/5wy9mUu2gBUH6OO2j4khINoZMobCxVn5otUiN5yddfBzBnL55IJaxGf/RjhiExFmUxAqAafrK2b6aVSYtBda2eayeR1fAdwsa0oa7z4OLtCVPBUgGdiIZ86E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 21206900112;
	Mon, 24 Jun 2024 13:04:40 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (117.240.211.222.broad.my.sc.dynamic.163data.com.cn [222.211.240.117])
	by smtp.cecloud.com (postfix) whith ESMTP id P1340310T281473348858224S1719205479165669_;
	Mon, 24 Jun 2024 13:04:39 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:andrew@lunn.ch
X-RCPT-COUNT:7
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:222.211.240.117
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<e6051a2db4a8e4fe2bcdcfef502cae8f>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: andrew@lunn.ch,
	Liu Wei <liuwei09@cestc.cn>
Cc: catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	prarit@redhat.com,
	will@kernel.org
Subject: Re: [PATCH V3] ACPI: Add acpi=nospcr to disable ACPI SPCR as default console on arm64
Date: Mon, 24 Jun 2024 13:04:04 +0800
Message-ID: <20240624050404.84512-1-liuwei09@cestc.cn>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <f706cb73-4219-47fb-a075-e591502be7c2@lunn.ch>
References: <f706cb73-4219-47fb-a075-e591502be7c2@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Lunn <andrew@lunn.ch>

> On Sat, Jun 22, 2024 at 05:35:21PM +0800, Liu Wei wrote:
> > For varying privacy and security reasons, sometimes we would like to
> > completely silence the serial console, and only enable it when needed.
> > 
> > But there are many existing systems that depend on this console,
> > so add acpi=nospcr for this situation.
> 
> Maybe it is just me, but i see nospcr and my brain expands it to "no
> speaker". Adding to that, your commit message says "completely
> silence"...
> 
> > +			nospcr -- disable ACPI SPCR as default console on ARM64
> > +			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
> > +			"acpi=nospcr" are available
> > +			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
> > +			are available
> 
> How about putting the word 'serial' in here somewhere, just to give
> users an additional clue you are not talking about a speaker, CTRL-G
> etc.

Thank you for your suggestion. 

You mean acpi=nospcr_serial or acpi=no_spcrserial? However, it appears 
somewhat unconventional compared to the original acpi=* parameter.

How about introducing a new one, such as acpi_no_spcr_serial or 
acpi_no_spcr_console?

Best wishes,
Liu Wei

> 	Andrew 



