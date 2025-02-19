Return-Path: <linux-kernel+bounces-522073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7CA3C588
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B371885B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D107214227;
	Wed, 19 Feb 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Sl9gdCQP"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7121421B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984188; cv=none; b=EDo/2f0+ymCen7Em+op3Y4heb4yhvDu4ps7w2GITuKkzPW0C9dwnH5usIWmEMOvJvOESAqH40HRmU4MhyNDjU36L9LmdW3MUwiQr7ZqAOw8Y1KB+0mBgPwCJWLuPtGuLllAPUMFRORnPjv8LPtGn4Xa653WH7X/GrPFqPkx1so4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984188; c=relaxed/simple;
	bh=djm6asLrjuw5aWgEtBZDDtUKUeR53SCIzswapEdC6S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfGwARTLHMJCbPNQhnub7dLQKzVtJ5V3krT3rOFjMU/HcBfqZofSl4ImGsdqBtEvzrxV3voF8SynREcKdOICFcE8qSbY8fjz0x8pO/O8jfa/KJiOZuonFDA2FGMKgqcVxeFATIJ5GNc9r7m/WR8mGTiCsFbrcDwd7Kzi1W8ncmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Sl9gdCQP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mMql8KYiWH+c+lYpthTy/7Bw8ahN0iWeZq/Ll0qDnnA=; b=Sl9gdCQPtE9cOUeQU9r7dWbN8o
	YTHvDfTnCZe/KEl59VvE/dFnVzlajwC7x3Z5g8RIb/ptrYNa5U6l+BpauUQlAypuaqBOkkRGwzjW6
	jej6ACZoJci1jlZyUzqpCS30dgWQyOX2OoBenOajS2587k/NGvvjAuoJ6s8QIoUmSEC3aG89DBHov
	s836CjytoPGmyyo09QN9trvwp7Crmo/hpkQC/UqivJO+RSQe0mvN7TAU+AEmSiuijYsT2IvxPbJj2
	tDl/uNbvqT7E9JY6J77y9PPEdh0L6HdVdtxVFDO5MM7USXbFRYU/Ugr5Lnlu1HkUdHfRcxgsCxkA+
	SMkJKC0w==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tknMw-00037a-0c; Wed, 19 Feb 2025 17:56:18 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, lukasz.czechowski@thaumatec.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 1/2] arm64: dts: rockchip: remove supports-cqe from rk3588 jaguar
Date: Wed, 19 Feb 2025 17:56:17 +0100
Message-ID: <17063984.geO5KgaWL5@diego>
In-Reply-To: <da11da79-11f1-4251-8fb1-3079c3b0da64@cherry.de>
References:
 <20250219093303.2320517-1-heiko@sntech.de>
 <da11da79-11f1-4251-8fb1-3079c3b0da64@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 19. Februar 2025, 17:06:52 MEZ schrieb Quentin Schulz:
> Hi Heiko,
> 
> On 2/19/25 10:33 AM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > The sdhci controller supports cqe it seems and necessary code also is in
> > place - in theory.
> > 
> > At this point Jaguar and Tiger are the only boards enabling cqe support
> > on the rk3588 and we are seeing reliability issues under load.
> > 
> > This can be caused by either a controller-, hw- or driver-issue and
> > definitly needs more investigation to work properly it seems.
> > 
> > So disable cqe support on Jaguar for now.
> > 
> 
> Seems more reasonable to me for the time being.
> 
> Aside from the reliability issues, I could also trigger a stack trace with:
> 
> $ mmc rpmb read-counter /dev/mmcblk0rpmb
> [ 1119.647435] mmc0: Timeout waiting for hardware interrupt.
> [ 1119.653480] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 1119.660676] mmc0: sdhci: Sys addr:  0x00000001 | Version:  0x00000005
> [ 1119.667871] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
> [ 1119.675066] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0000002b
> [ 1119.682261] mmc0: sdhci: Present:   0x03f701f6 | Host ctl: 0x00000035
> [ 1119.689455] mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
> [ 1119.696649] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000407
> [ 1119.703845] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> [ 1119.711039] mmc0: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
> [ 1119.718235] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [ 1119.725429] mmc0: sdhci: Caps:      0x226dc881 | Caps_1:   0x08000007
> [ 1119.732624] mmc0: sdhci: Cmd:       0x0000193a | Max curr: 0x00000000
> [ 1119.739819] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
> [ 1119.747014] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x000007d9
> [ 1119.754209] mmc0: sdhci: Host ctl2: 0x0000000f
> [ 1119.759169] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0057b200
> [ 1119.766363] mmc0: sdhci: ============================================
> [ 1119.773595] sdhci-dwcmshc fe2e0000.mmc: __mmc_blk_ioctl_cmd: data 
> error -110

I can reproduce this timeout with CQE enabled.

After disabling CQE, this goes away to the regularly expected response.


> FWIW, the changes that Rockchip seems to have done on top of that driver 
> in their 6.1 vendor fork are the following commits:
> 
> https://git.theobroma-systems.com/jaguar-linux.git/commit/drivers/mmc/host/sdhci-of-dwcmshc.c?id=2ef0767967138d333360ec0f399f1d68646741c3&h=linux-6.1-stan-rkr3.2-jaguar
> https://git.theobroma-systems.com/jaguar-linux.git/commit/drivers/mmc/host/sdhci-of-dwcmshc.c?id=75dfde714bbe81e938190142d07307fa864fda34&h=linux-6.1-stan-rkr3.2-jaguar
> 
> Maybe something worth having a look at some time in the future.
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin
> 





