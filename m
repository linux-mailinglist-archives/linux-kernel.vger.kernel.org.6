Return-Path: <linux-kernel+bounces-332010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9183397B42C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85951C23214
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A539188A0A;
	Tue, 17 Sep 2024 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rB18qoh2"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39E13A258
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726598776; cv=none; b=NrDBaQ/11hN6IJnfQ7vbKTLHyicWthHanPwQtMUShIpak7ytceZSfLypG6GRNsczl/XJ77kvQ/pkAvvJSD1M9kn0mBzXkItELQ9XcEmdShiDmS0cWKo1v31+JkjXflzeqwX3HcoaX3F0eVeNQ9ksSsDcTLqTSqv861q/N73ZRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726598776; c=relaxed/simple;
	bh=8Nvg8tRbjaJqbsXew6gH87/CAiT6BfTGGgUBHODXed8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VWoHPy/0o9y/L9uF84hLnYorZv9k/XTk2owo9/nHhWOVhDARFF4hyxYOSnwF6AsmGDwbD+UF0HQwDmWkK4XXG6mIDrcGn7miHfMSuRkcYkDKoH1iuhnhINpmPxUp8HsTg77SrrfHV/BMVu46vAZh3xDbr56ywNvG4xuw5YSs/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=rB18qoh2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([185.44.53.103])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 48HIj1Ga873143
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 17 Sep 2024 11:45:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 48HIj1Ga873143
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1726598704;
	bh=3MYJXPpoikiIBdQpTF90TJu134PRABdfHbENTXuj1ls=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rB18qoh2VfkX5BAaJHcAGIuPNGusLjM9VU4WO4UpKFku1SNakT1qV1HQpvzoBIL6r
	 61LGcdoFVnz9TTCzu+1fxlbRZ0t9ZSKUzeqh/Lx+8fmsbzXoHQ9pXFj3tEBybt9EjA
	 tdcnpzW46gS0vCTh94SsxiwQG/PSzvuked9cxi7nqeMetu0sz7psLm8+YwRC6G5pv+
	 VFy6tLkAeSf1BPMglIH3X66Zaf8O1nATR0sg1cqlp/QaMdOopDh6+4eRc/glTIkK+D
	 YXBiKOaiMjD4vY16xcbcBJk5vM9mUEGJYeVcZZCnA2bntl3EzAUpMcUa+WNHTrYpk5
	 0D18G7dCxYPpQ==
Date: Tue, 17 Sep 2024 20:45:00 +0200
From: "H. Peter Anvin" <hpa@zytor.com>
To: John <therealgraysky@proton.me>
CC: Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
User-Agent: K-9 Mail for Android
In-Reply-To: <yePf3dKBhN5-MT4j8MbstYrbVupKBUlpBQ-Oo4kXHVTWaCcWMAMgvY9_e2RPbB-tv4U30Hg33aaziplcL-T9ovY8aFNYdihMdiL7ysifliI=@proton.me>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me> <e5081e3b-0f14-4e1e-975a-a4fd22944fc7@intel.com> <XngBYmNlmx5HynQiady8B6MsNyjWhWsWHhjmEIw4vhFYS_Pyi082MCXetLK66amn2j2XQiRlzFVdrUu3V0UN-3yDWOSOv9Dpr7sAgShOme0=@proton.me> <yePf3dKBhN5-MT4j8MbstYrbVupKBUlpBQ-Oo4kXHVTWaCcWMAMgvY9_e2RPbB-tv4U30Hg33aaziplcL-T9ovY8aFNYdihMdiL7ysifliI=@proton.me>
Message-ID: <F366439E-3A1E-4897-AE35-05B82B186529@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 17, 2024 8:22:38 PM GMT+02:00, John <therealgraysky@proton=2Em=
e> wrote:
>On Sunday, September 15th, 2024 at 2:42 PM, John wrote:
>> I like this approach much better, it is more streamlined and clean=2E I=
 ran with your suggestions and the attached seems to work=2E I am grateful =
for my feedback and suggestions on the syntax=2E
>
>I pushed my draft incorporating your suggestions out to my github at the =
following link=2E  I am going to unsubscribe from lkml now (hundreds of ema=
ils per day) so please cc me on any replies or use the github=2E  Thanks=2E
>
>https://github=2Ecom/graysky2/kernel_compiler_patch/blob/master/lite-more=
-uarches-for-kernel-6=2E8-rc4%2B=2Epatch
>

Also, these are *not* uarch levels, they are ISA levels=2E=2E=2E

