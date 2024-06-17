Return-Path: <linux-kernel+bounces-218036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0396690B865
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4C2B233D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5718A933;
	Mon, 17 Jun 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YFtRy7uX"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134C18A922;
	Mon, 17 Jun 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646258; cv=none; b=hOeeGCrbdkrERY6Q85q6rlk2zp969ea3KcE1x1L5dlQQuDRHwWVJKy5u3crVkUMOx4ms9lqBC9ry3Q7UH+ZCwGoWqSknMK00twSR0Z1ZHBfSq4RR+wgXCFg0CDweXb1XouwbchowuMCr+Zsw6ytZF6TgiozyqRUo9AEDq0xqf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646258; c=relaxed/simple;
	bh=ZW81xIG74/pws4gnTAm5H30wvlITx6Vaz7+uqpMz3WA=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=oyL4gpB34pG6HtPQjJI2CWDstX0+RErgEExNpUxvxVI46QboGV9d/oaHVUXAL0QQW4qdwrDCs1ujpc1UZ9y4bGrzXU5x790cU/LS/95mL6S2Otlo+o8aC+rBgqx16hOPCAj7/kIFQTp+tl806UnzJcAnAoS2kXkMIVimrNtsUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YFtRy7uX; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718646244; bh=lSfFb7+k557rhRi20IR9VIL7t+SDEJaWgmE3dAg5WgI=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=YFtRy7uXqOal+oMCijajPrRyCIdSP3JEBrtHG5sNJB4NBC8jnLQ7DzUE3ZUk+e8td
	 6+R7eETeMsCj41KPxsAsb3SkE1W4UlgSJYYlsCJ8SYtNtZeV+oTSN04EDzLtKgwjpK
	 Zki9Yot2tg+RcCSrA04/WxqWGzz+KqhtPYsdEaoI=
Received: from smtpclient.apple ([2408:8207:18a1:9700:9c85:7ae:3ee:45fe])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id AAE8FC0D; Tue, 18 Jun 2024 01:42:46 +0800
X-QQ-mid: xmsmtpt1718646166t17e0u07v
Message-ID: <tencent_53226D39C76ADCAA1883109DC6213E5EC107@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH39YSGtA2DuQ1+IsvjerQWoRzDVzuacvLBMv26KpHergvu9Ti+QK
	 /xNryMTLRsr8MZTplkDQJXfxq8QGCo8ChBXf9pacuNdnNyVHnUbSNdzDWvHBL7gyO9cDrAf9b3C+
	 6T6VkSaIN6bsywuMTy/hVi3HP15/6mC6EK7en0iKYX8jD+bTYA1Fgg3aaBUIVqZmAoOj9II/vHHT
	 4GlKtbgWE+EgBxPMJz6eSXSiTE67eItWvyUqLhmsV5FItVlhZrzP1LYHkR8J4qQCqWxeR6NIekfW
	 o9gJNfmfeyLY6+qaHchOK9iOsqoTdv3CjeK2a5ibIenncxr/W1xBqas9nUomJ5u3GKe5OsMQK6wB
	 9Wml9CYCTvUO5b89aVue/R/csfWfS1s5qkgZH9YOskAevqFkKnDrrzlcfFEDaQbdsUIWhKVM9iar
	 QiQMb/PHK+1mWIRM6WBjQVNR7NunK+y0N5skHnJBKV1dapCuA0ckWctCMuwZAEpvrE6LcBMi3Mfh
	 +MDl//+Lvazr71vT/Tmshup5BkGPIS//K43W9gG1W6JlfIf0ylof7Pbdr5FDNE++PJCeRGPihUOT
	 Ak/cZd5ZjcYO3dq37EfkDPce8ANQITJb5UPsEvxJeRWhS1wl/6EeMRdX5v/8WGr9eyM3Ej06MCQO
	 aw65nIBCfE8JW1Ho+SAmMoK48KG4KNu7zlZqtthvwGKmFTb9b3rvO6AB11LwmcXfbwNzkAYNwoko
	 5BlHPs+P/Riv8eWtuITwmDDTbNrskgGMHGFzRFplLs+p6QuFOxOsLa4WOo8SoHvPwkRrcWIDyGM/
	 x2EdqohEPCOf07CDnBGmpEvil6/gwwBj1T/52EFZGI33h9XF/sMHNoNSfR0q0JvP0JOFAAsFF8Hy
	 gSuy5M3KOyZHWd2d01f659w5pDisw7yvgaVDQ7uqID/Xj70xCwEuQ/AkTloih4Vau0AtzVhGrqcJ
	 EGV6P6W5HkzVuifQxtKL9+79zXfjAdo+ln+NRBSXbN1MA7kcUqBYipJa+jbAn8svfXwzIhp1U=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240617-connected-avoid-82f0bdc05cdf@spud>
Date: Tue, 18 Jun 2024 01:42:34 +0800
Cc: Jisheng Zhang <jszhang@kernel.org>,
 Yixun Lan <dlan@gentoo.org>,
 linux-riscv@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Anup Patel <anup.patel@wdc.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jesse Taube <jesse@rivosinc.com>
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <99CEE9EB-EEC2-4538-9378-D9AAD8CD240B@cyyself.name>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar> <ZnBEBQjTQtFs-fXt@xhacker>
 <20240617-synapse-carmaker-0a59c7c6edb7@spud>
 <tencent_26E7381EE1F6C5188428359AF3F908CA680A@qq.com>
 <20240617-connected-avoid-82f0bdc05cdf@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jun 18, 2024, at 01:14, Conor Dooley <conor@kernel.org> wrote:
> 
> On Tue, Jun 18, 2024 at 12:39:30AM +0800, Yangyu Chen wrote:
>> 
>> The vendor uses a special intel pxa uart driver, marked deprecated
>> in the kernel and incompatible with ns16550. If we use ns16550 in
>> the dt, the behavior of uart is like the uart has no interrupt and
>> stops working permanently when fifo overruns, making many developers
>> not know how to start unless they use the SBI HVC console, which
>> needs to turn on CONFIG_NONPORTABLE.
> 
> This I just do not understand. Why did they use this IP? Is it free?
> Did they use it before for something else? It's a rather strange design
> choice to me.

I don't know either. However, PXA is a subfamily of XScale. The
kernel also probed the UART as an XScale. So, using XScale compatible
string is OK.


