Return-Path: <linux-kernel+bounces-237599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A927923B50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0919E282B1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031491586CF;
	Tue,  2 Jul 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jkf/U+ZC"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452F154449
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915767; cv=none; b=hrjU6Zeg7hICNVTdFAvtL0mMG+Eco48YCkEaCpWrQyn5OEbknlRzklKWDb6fAx416V9MY+6EDiuz5Yj/kczvzZyIhSB8FQq8hgXTwRL6veJdeYnfzqzputUsMjYV4C6QRlAxoptiq4LieUseSSFLIgi2fP/obki3SM1IR4Sgg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915767; c=relaxed/simple;
	bh=JJrKf2EqZipr9Fo2V6bixUGsWVwCnm/mevS1/eqoBq0=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=Gxn5V/WKkA2hsTZZOfWaTSPOgGW/LD3kH3jswT2GMBGVw0dwoxgaQFS0uRHsxmCcBhQ0laLPe+BUiZ5qeSGy92iWDgw3RwufWSnARKGTCX2i0TMWJbjtJfMSCAeHKuRuUtihkGezwUT9CQ3nuA4vto7Qo1MGzIZjVL9ydi6gco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jkf/U+ZC; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719915754; bh=/U9ki8QTbnBFMrAZkAEq4eYvse/267OSoIx74fK3Oqo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=jkf/U+ZCrM/Km02Zfa77VjOp5r2z/GYL1wR9qke2EdbiQRO322WptToRHBXfHKyt9
	 G8HF1u3epBRpLldq1mPpzqgW24Dp0rtSoLY2NNYetCR2lIus0Ri5KPrHveh1Vc3M0j
	 gEz96xblCbVrYCXtaw7dhY3rtPrqfTEyDrsXQZ4c=
Received: from smtpclient.apple ([2408:8207:18a1:c8bf:61da:261f:a4a6:7856])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 59F3FAB8; Tue, 02 Jul 2024 18:22:31 +0800
X-QQ-mid: xmsmtpt1719915751t27dj1zzm
Message-ID: <tencent_371517268623E4A61194EF4C70497BDC5105@qq.com>
X-QQ-XMAILINFO: NR0nbiez9+manSc+6LdgIjmx+e3Up48OY7NzymnQNYKtO5R3vEv+LqY1/vgE2T
	 wR7fIsXNYBhX2ydcbYjuwcMTWNkyU1wU+T7/EWn1ujeB7mWeyKRKxX3+sJJcX8ETvvn4M+2/SWxh
	 Bpe4GmFzVMuaevKSBj7yQnJDKz6izOXLsFcfIKTsatnLiDatdzIngE/NDQo2SNDV/cSMyeBoARvk
	 lZ9jhSaWSqvQXWsgWlokXYetOKs9syw+oqmFz4cPSB+wOY+3Gxl69gik27IGC44WKfYjSG37zJti
	 rBxDE2oCpyq/fu07c1yOOZERkf8stIeuykVEwfMAgLMgQfmlNpBSagv9BbeuVBeYOpTjJQ2H+YwH
	 OnwubV0OSs7klfx9KjAhBYLnxFXwo56t6DqnvpqxbxmJ3rEtZlz2Vl3PCcdzkGr5vNtiazk+rb1X
	 meAssdqq8gZWxR0fnknDFf+9pmL4iYsVdcCe5NzTNrRvOOo/V7qwsa6vBgKNV3Y+gJXAZOME7oEB
	 N9V8+705qFY9ToDhE2woBbd6oxIVLU1uIi5lA/Gg1n5uyDCuEihDTPPxA1HFdGuip2R9qmXhfqTm
	 Y/Ihz7SoUzDZTG4DelLtyduZJedtK3Rle92K2Il+lVjTCDthIzN0ZpuQcqbVcz5JYSIHcdilcWdg
	 yF0b0X8fWq/k0Mvtxu9ACwVPpbCwNNNz183fy20/CQP6WmwsRDi8WcZYcEY1N9fyIaEwxVecB0j4
	 PzqA37Tnlno8eGtptjIHaGAqvxbXNntaKS8fhdL79dhqKTUrz6VWUH/JSEdms05udpJqTTavrvwC
	 l9fPMKQb1EusX44wfoEjrpBNzbwtwKAC/PBGT1pxklGtwlpX95ZrdtA88xHrpDUSQ+O2603vkU+m
	 5y3dSuCgKzvcsIftxclp+jDBqlhrKB2Ng77CtGrh2F1TGQ9eDKd25v9g8P/3j4DF1hxkvM739Lvi
	 mwlVEmAdck9J5Ak+muJc62M1PCZ1H+sv4oCi1GymPB75Y4mEeDh02ZG6QlYwv1b08KHcwC1NyJCN
	 Lt4XW1Ig==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1] drivers/perf: apple_m1: fix affinity table for event
 0x96 and 0x9b
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <87bk3hp3z7.wl-maz@kernel.org>
Date: Tue, 2 Jul 2024 18:22:21 +0800
Cc: Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>,
 Janne Grunau <j@jannau.net>,
 Hector Martin <marcan@marcan.st>,
 Asahi Lina <lina@asahilina.net>,
 asahi@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <40F8C382-ACCE-4BA0-8C1C-3225D121A93F@cyyself.name>
References: <tencent_7B71486CE305DF8AE084B6BB6313EE550C06@qq.com>
 <20240701140148.GE2250@willie-the-truck> <87cynxp52o.wl-maz@kernel.org>
 <87bk3hp3z7.wl-maz@kernel.org>
To: Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

> Yangyu, can you please clarify how you came to the conclusion that
> these events didn't count anywhere other than counter 7?
> 

IIRC, I came across some web page that says events 0x96 and 0x9b
can only be installed on counter 7 to count Apple AMX, but I can't
find the page now. Since AMX is not usable in Linux, I don't know
if this will affect some other instructions that are usable in
Linux.

There are some other reasons, but I can't say in public.

Even though I can't find the actual usage, I think using count 7
only for these 2 events is safer. If this reason is insufficient,
we can ignore this patch until we find other evidence that this
affinity affects some instructions usable in Linux.

Thanks,
Yangyu Chen


