Return-Path: <linux-kernel+bounces-524282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910ACA3E16C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20981888AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0D4212D6E;
	Thu, 20 Feb 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="H/Y5QNnQ";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="UOOWd59+"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80F2116F4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070093; cv=none; b=Fw5caDUVygEdEm1cgVBuuDf8paeTtjRC7yO8BaChpH5Io7rlBFHAwwx4NLvBpBQ9ITzYFesCXMHp/mfQL9AVi4M8z48JXoIaDV+bStMyFpH669oTH8vsYxNyLD2Fr/1WDsMkgFZT3+gkxiO5qvz81/qXOlejdJ/NbTNgAjxsiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070093; c=relaxed/simple;
	bh=pbdR7nxvueo2TLaKE5sF10t2b+oN0pSH5FKcIBPg2yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8ago8pRuWnPu2QfKG/RJbEUEEDZqBxZOTU44+2X4vfNOOPet4r4C09z7u0tmjruHuJ+NLeHbXKDLi+gh3+ToUwIiVpQTMUhU1EMEOahmWmN0vIwvlkJ/EMDXoOUxf0b+qyLagEUvTCp0LHDhuj7UjjltQZ3IxLvtCCxXybE6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=H/Y5QNnQ; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=UOOWd59+; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=UtFu/7rrHv4X5KOTvsXatoIKvP38Td4ByIZSHbNhxXM=;
 b=H/Y5QNnQSdKVkGKUBSTSBmttqgIjVEe22rsEDSKU8dDUSQA2Ftiza2zkwLPXL9vktGDaC2LrNl0/ph5AA31veXHm+rggUejAGdgcaxpupxnQimmgcg7b3da/nbKqbPcum2N8H+90iLmZyIqdQOWwQ3cNzzjleRgSi6F/2jU9DD8YEiSnxVS+8teeOG9aAZPmDofL2hk2yjPMcPAbylFakkwLqX1pgqMFyKgzjGViZnQtTTxv9cnMqkswVBQBfxN9m7hofdqlu7veQeunjTBF86TdA2Y0RgRHylX1Ib6O6dLIwycum0Qgvhvva3ilj1DMp3u3zbmsWsTGCcVDNmznWA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 766576C0087
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:48:09 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394b2c19ccso12457745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740070088; x=1740674888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtFu/7rrHv4X5KOTvsXatoIKvP38Td4ByIZSHbNhxXM=;
        b=UOOWd59+P3yQtU+IYbKge1b0W5670XnbgMRo7+aS3eA8mwSS04yH+s6Dp2BTas/Pv9
         c7+SvQPz3n2KaGpJU8SVusdPt+P/nUT5CWucYrWwJ6DDHW1chWXolpOsS915CLHvVXCi
         oZorGvH7q/sWZvtoDGXuuFOFfSRfMoQZMuXm9AIYuCkTt8Gse7dPXnoKAzl78Z3e71SG
         bt4u2sztPbrbwQ6bR1/6igOTVCT1hTgBTkaneIiIIKNPaAJ+pZbwbZ7RMIBzia9LRX2O
         cGoyA5eD/6K5F/MQnW8O+bHWsNzJq2cwSe2p6FqMOfHKf3iuhhLWfcq0O5Hmmztw38lX
         sgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070088; x=1740674888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtFu/7rrHv4X5KOTvsXatoIKvP38Td4ByIZSHbNhxXM=;
        b=bmFI86L34I1bmwHglgpJTQYrdz3dCS5gdYNzap6SbgIYGT6fgqX6YdCbPAKHT/MnmS
         hHq1zUTwEjV9JCgAhbl7ueRy2EMfoR5gBlq8RTT/o2hrVuGoENStcXzu3R66RhmlZcJz
         9isEA41IOIEcn3/iALKAG4bHs2TIBmCTaZ80Nb7W8yJXoZy0ChVM7EPP8YxqMBZv2gE/
         /rzywKVVeluUyB/fyCfg21LuyNUavv/mdG1Jl257Ay/Ww5PPwdg9at66TWEZs3RwZ9IA
         0eavnmZkn1vWbJPrxs3iq7CDCH0NKXJgE9wfUZ5M2XHQ8XJVHW82cs3Ctcg+oCW6Vu4F
         xoiA==
X-Forwarded-Encrypted: i=1; AJvYcCU2qcsGffpadY4DPZIlkHk0iAq7X8h4ipWm1/grDgEFJK4ahRGUkS/8bvYCOJ4sQA0nSo3vlb9Di2Glmb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/F2dXzAVtgF+B9n2tUcFsKwHC1LYA3n2pkTcO6JEP/yyug4x
	IHReFRMxAfOwYF3DS4u618QcaIAiBcFWaxvPkCKnCVhde6wLMB9AYuU/qwsloZdTZBpQ69pg/HP
	tR15fJbi6gcgfrnclelT2PwghaW7JCGt1Cf4DTC105/lEMaQ06YMfL0pJ7qZrWhxciw82dtk78L
	0espj8ttceShkLI5dWSmcTPqEoy5P58mCC0CYcokuFBrkXcCI6CPymbvDcsuiPVZBjM0mghf4=
X-Gm-Gg: ASbGnctthjyi1tak2K6Llxt2HZBpMi3xhXmZdB2ihQVmfAennXrl+jFXv8ub0Bmgp7h
	OkxH6Eeu8jBheQ1Y4QEpiKNGkYGO1z1aY2FLBzyiLgrRL9kaEazuHTBCUMM5GOA==
X-Received: by 2002:adf:fa08:0:b0:38f:2a99:b377 with SMTP id ffacd0b85a97d-38f33f57459mr20939204f8f.53.1740070087968;
        Thu, 20 Feb 2025 08:48:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFt+whvKVaXX4I4RkLMql6Zr2BmHhgEb6V9Rei8o5LVi/60bat3GQTyh1ZxROF61Yi6yE/rBBG1TCfUYx/5lc=
X-Received: by 2002:adf:fa08:0:b0:38f:2a99:b377 with SMTP id
 ffacd0b85a97d-38f33f57459mr20939161f8f.53.1740070087628; Thu, 20 Feb 2025
 08:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082550.014812078@linuxfoundation.org>
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Thu, 20 Feb 2025 11:47:55 -0500
X-Gm-Features: AWEUYZm2jJ2bUAqU74OstkcJ9PoKvhhiK-1kP45Z94_5LauCnETdKls3QCUt_rY
Message-ID: <CA+pv=HM3XK=ceOVcTQJPQp2SH0KhU9pT0LwrWBwjobeq36B3NA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/152] 6.6.79-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MDID: 1740070090-4TocXbKuDb2d
X-MDID-O:
 us5;at1;1740070090;4TocXbKuDb2d;<slade@sladewatkins.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-PPE-TRUSTED: V=1;DIR=OUT;

On Wed, Feb 19, 2025 at 3:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.79 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

