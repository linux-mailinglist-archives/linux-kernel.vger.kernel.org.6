Return-Path: <linux-kernel+bounces-515574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E7A3665F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FE23B2B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339E1C84C4;
	Fri, 14 Feb 2025 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins-com.20230601.gappssmtp.com header.i=@sladewatkins-com.20230601.gappssmtp.com header.b="CkZjHObf"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABE1C84B3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562196; cv=none; b=dBLTmAFcgqxzkfC7PdnLsupL5I67z96fe7hYWVt2xAMnCw+2ThqNHLiwpEpcB/0lEgCn6IBdowQC6F1eKtPc1XPOPiv427Jagjw2Sqky9A9lC3DOFc4KL0buKb2Ng7pgQG+4hO3RHBwPAlR3TaVMZxkEdbxcgWGhhAVMsJCZi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562196; c=relaxed/simple;
	bh=Q56QkAqSvsIKQBhKc9/nl5EaiJ4PZsSBDuJjpKC1AuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZzBuKNZI5tqFcUuUhdKvWowyes9AmFkMOT2AzabG2ceMSadIHxAbQQeAL4zx7wNxTFakxMmT9JbrHH+TfQq4ym42FWpPd7QWKhkPlgtaJc6MkYXqOc4Z77DKi8s53vBThhqX0kEp/7JMw7QdjVMeJSUaYTOnNodLxhd+KPpCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins-com.20230601.gappssmtp.com header.i=@sladewatkins-com.20230601.gappssmtp.com header.b=CkZjHObf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so489572166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins-com.20230601.gappssmtp.com; s=20230601; t=1739562192; x=1740166992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY0DoOA/s8kkBWd88tL/y1YZXdpMeL10h/GY/yl8oOg=;
        b=CkZjHObf6CNCu0YdKm6iSbEEn+kRFr1EhsE0n6RhBQp2FjNX07d2WyyBztKawFF7CP
         DlHl5URlo2km7DSfNL2oe+Ky4MWA4Gn6/M0Boq2qaoM25WindlcGrLmJi+Au5nABM780
         gmM8yuv6WV16UAs4RjDkAXrMIYLSR8GIc6WnEAFzxwLvuQOohmVn6a6whI5skigRH76+
         adYvJWr+IedJcPJkpKGIOR4Kt0SzKqmCe+/NqjiFUBEKcGNsjalptJwlUROTXEW4hZX9
         ofOi9XA/oUZHPz3BBdvn60qYVW0FI6sECZ0PzNT/A5Zr0/lIolXjc0+PeWi+kkzY0uw/
         Rnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562192; x=1740166992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY0DoOA/s8kkBWd88tL/y1YZXdpMeL10h/GY/yl8oOg=;
        b=a7oCW0+g7nOUX/kSXJuKrljAESjM+xRzu4KtZhRL33iiFr8r34zoOSl0BC3naMwYuP
         OOlRgSCcL1PoMlAif9lJScpZW53QVBs4YT87MjNY+8vIPWzxXySd1Xuki3d0z0V/dGGo
         mNHxZILEJSSV7O4UHmwHYDC5YiMDHSa2ZbpvHZMb0RZoTDddAURXSKWIhy4tXXrybCfe
         t/GVXzSHiqsVyZ8dvVWFeLkbBP+egUP14lNTE167cEcTxbUzh0q5uBUGUsP7h0IkWPsn
         PLOdnGu+hRVOWBQJVS5P6j6eEmoqGuvIQ1ITrbVkq3M6cF13XIELfw0pmyfaRvJo26S9
         PUGg==
X-Forwarded-Encrypted: i=1; AJvYcCVHd7uPhAZafkfDU8vnuymysVexm1ePpW3YjITpeiDEzgfh/OrMKmJd7aSPIXvfDRONA8l+QsHTM8BiVJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGpk/MbOrq4FBr0WC1U0WwcHHcfWmK8lOn9gJw0V4A8eHcPX4
	r/6h4hDe7eg8aEVayVg0gdJRLnQhuh0Zp29Epj205uNH+oWlLHMAEbqRElUNaL7TSt7e9OBOnXx
	VvGqPqSDq2ldQXh5eACqQoZTx777xptBeylVkWA==
X-Gm-Gg: ASbGncuOh3Vno3p6o9igsHfYxxFxCoQ8M7KIUaPBa04wKa0MeSGkL34KrJd6TnOrgBZ
	nWkuzqiqURMazUbh7qo9Q/kgEk49nOvN+d3HwUh6BPp8kuFyakZXRhBJj8CyuDeFWB/r1SRk=
X-Google-Smtp-Source: AGHT+IE1oGc2ZQExbVhQL+yj7D6/9XuOay+H9ZYPuFBGVhs2U2fRcRQf9e/FV030JbpAF4s0bLXtmTSrCHVrj20z6WY=
X-Received: by 2002:a17:907:784b:b0:aba:6055:9f5b with SMTP id
 a640c23a62f3a-abb70c01eadmr33484666b.2.1739562192539; Fri, 14 Feb 2025
 11:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214133845.788244691@linuxfoundation.org>
In-Reply-To: <20250214133845.788244691@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Fri, 14 Feb 2025 14:43:00 -0500
X-Gm-Features: AWEUYZnRv0kmWQ8Wfq4_P-n3RgbAjB3ZTI3Gtrs3oZe14Y2S4Ma3FjndvU69qsQ
Message-ID: <CA+pv=HMHE=uB2ya2_bd43H5H__Nay0nXG6cQH93ueC-R1K7YrA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/419] 6.12.14-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 419 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 16 Feb 2025 13:37:21 +0000.
> Anything received after that time might be too late.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

