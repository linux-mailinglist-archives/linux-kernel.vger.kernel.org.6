Return-Path: <linux-kernel+bounces-228227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F83915D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2C21C21843
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F061FF4;
	Tue, 25 Jun 2024 02:50:14 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA545023
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719283813; cv=none; b=mwrtnNa6Xn/35q1SQGMU3bmoga3fo8yzN3L+b20kaelhmGi7jDJYGRgaENw89XRTg+RiO749zszMCOLyDc1TtUvHk13GGoTvjE2pC8IuVoFtJcPc9IDtuS1AxMLoa0S6Qeo6NNe1eSbVDPsbZxTXnrqqMlitSEnRYWoaKwXxqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719283813; c=relaxed/simple;
	bh=hphWL4LNHPleLs22s2Z+DEu9G6barzrzdD4CUOhkxHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVgBeBeEkd26F1EOTgvqvoV6CfOGh610vRbQ2qBI6upnV4qh6aB9CwhMOxbKsw70Nnx3sVhGaC45xxUOTT8qk2JmKVIrdTMMZN6L9bHaIuAwKIuUwo0P9U4BTtN8F14EyewzmjTXHppeG65yZ9ltpab9cTDpM/C31VSOAQpB1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id D97437C0112;
	Tue, 25 Jun 2024 10:50:01 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (unknown [111.48.69.245])
	by smtp.cecloud.com (postfix) whith ESMTP id P2702681T281466040545648S1719283800599769_;
	Tue, 25 Jun 2024 10:50:01 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:andrew@lunn.ch
X-RCPT-COUNT:7
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.69.245
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<a1f9b6a1f1069daf027d5f7b2f293e68>
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
Date: Tue, 25 Jun 2024 10:48:48 +0800
Message-ID: <20240625024848.56950-1-liuwei09@cestc.cn>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <5741452f-2a54-4239-a5c3-f13286726780@lunn.ch> (raw)
References: <5741452f-2a54-4239-a5c3-f13286726780@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Lunn <andrew@lunn.ch>

> On Mon, Jun 24, 2024 at 01:04:04PM +0800, Liu Wei wrote:
> > From: Andrew Lunn <andrew@lunn.ch>
> > 
> > > On Sat, Jun 22, 2024 at 05:35:21PM +0800, Liu Wei wrote:
> > > > For varying privacy and security reasons, sometimes we would like to
> > > > completely silence the serial console, and only enable it when needed.
> > > > 
> > > > But there are many existing systems that depend on this console,
> > > > so add acpi=nospcr for this situation.
> > > 
> > > Maybe it is just me, but i see nospcr and my brain expands it to "no
> > > speaker". Adding to that, your commit message says "completely
> > > silence"...
> > > 
> > > > +			nospcr -- disable ACPI SPCR as default console on ARM64
> > > > +			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
> > > > +			"acpi=nospcr" are available
> > > > +			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
> > > > +			are available
> > > 
> > > How about putting the word 'serial' in here somewhere, just to give
> > > users an additional clue you are not talking about a speaker, CTRL-G
> > > etc.
> > 
> > Thank you for your suggestion. 
> > 
> > You mean acpi=nospcr_serial or acpi=no_spcrserial? However, it appears 
> > somewhat unconventional compared to the original acpi=* parameter.
> 
> How about:
> 
> nospcr -- disable ACPI SPCR as default _serial_ console on ARM64
> 
> Please as Will suggested, add a definition somewhere.
>

Ok, I will send the v4 version later.

Thanks for all suggestion.

Liu Wei
 
>        Andrew



