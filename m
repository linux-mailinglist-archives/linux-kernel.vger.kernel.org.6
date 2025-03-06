Return-Path: <linux-kernel+bounces-548947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D16A54B3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFE5171BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FBA208989;
	Thu,  6 Mar 2025 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="jQi8hZqX"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F71D9A79
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265717; cv=none; b=atOZrOlst0Q+bx8W19kqKTLiCgTsuT7F79YpgUMrlwibgbP5TW0dV7OHyz7HnIQTthNgkb+MpMali5hSLJSATZ9SZ7P0IUtd1RDXbueS7pHgQGGyEtWzhK/3SiNeCw1aMD58umv59zTl6BW9q080GLQ9H9oIVGmYahH1OX1oono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265717; c=relaxed/simple;
	bh=CL8xqMbDSfXJhqryd6RGNfCVZzu0ssYGv1JLaVXfKDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRb/prV3Y3dTxs/SEXm5R0v1Grmf3e41Ax40lUg2K9sqERKICe0Vej9IacglEB/bvVJ3nVsq0jnlgoLOK2iK92i/0jK312rImCRwwV1qvdArF/Q8vGB6ZLNDxyY4+Buus8hkNoyk71EFkT7G+hKGHtleGnizjHABPvxFopQH6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=jQi8hZqX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f44353649aso986258a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1741265714; x=1741870514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccc/H2dnyXMFfYeHkIhobLxEoO1aevmdpjSTBRDha2k=;
        b=jQi8hZqX+1fmPbgQm5Cxx8eDfA9IEDvxuZXTmdqS1PclWw+rp5Zs12L3KhE5Gj5wjk
         Eb1L+yGE+J5z4vHP3ISDoFMaAXGmChxxGUm3r13QhHsVmAcygKlQdow8Y1A93z1lZCHY
         0My/e0PGIxH2idRBNMhWC28qVLg/sB/xmeeuMDDCl3PjZ6EVK5KNEvssHuZy3M2cT2GB
         FomNtajXkrpT6CKtjDP5EJAkL53MClvHlyfJQ37lNXhOR9c6ZWXFsldaYXzuBJ79RRc0
         Fp56QFfG+4Gw+dYxg+AUFUwlgjNqZLuZjSsKeZqO/nimAxxxctoT5HzSdwtSGyps28SG
         qVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741265714; x=1741870514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ccc/H2dnyXMFfYeHkIhobLxEoO1aevmdpjSTBRDha2k=;
        b=pNYOFyM6TouBZvq093ntKxiRHmscZNuyq6lZefNz/ceFd8N4q1SvBXaGZAM8pshBJn
         +Kd1G6heOAVtvDrFAd00cUCXF6E6GrF6j1+zCLGSS4qS++yRuLi0v9QwNpsSOAxtWd3W
         kIrVExhjUi08A7dah0WhBoHxHyeQU+NjELNtvqCxT0L/f+KZSDzDlnY01D+Z+wiAHow5
         6st6D2BxpYjBigX2DkqDbptoszp8het/XzuMhnEI4QDVPBtR+p7jOD/mqM5B8Wy1fNNd
         7KsRAMpLIUr8pEyF+o4QeDIx0zKP1/G53EpzOzhkwGIo4tzCFSHW0avHZMyQyealGjM9
         viHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeHX5lCDqRpqZxoPd1Nn3F1TWDMKfeg/dcD+uSKf/fUN3Q/YRaZ6fmSMVFOHPKpm6ps3VytaHPizwal+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEu+eyURX9i9oGH0GL+fh6DzHYOQTBQgq3bZ6rSsFgknGyZGzY
	12nGTMBoWZdGWjy9Vj/KMbZ0TeTflCGvDS1LFklqFpISGSPObJZqoZGu2sbD8vX7MEQ9ozPQu5K
	TloWVCPwRfDz4dokxnU217Nc3a0LPcbganx9o0g==
X-Gm-Gg: ASbGncsR8monyQG+BvsZaE9Dsrt61jr7P79EihQoaneC1bfUzVJ2PfowyC3DkfhBWdj
	/DOKHRfaWh2vQSAo//SJYmLW+FYDcy+I3zVF4oX9bO6CIVUoMOzZvK3EUZeYTt57xHJos604DT1
	5Q/AP1S9o3dTFkSDLK5wp80YQq
X-Google-Smtp-Source: AGHT+IF7OiPlaCSQEnsXNBjhCDFUemUvQa+NRtTs/JSJ9+1Qyh4+kePAcg2WzwOWcgqtz8B61BAqo3R1eMqK+BSPwLY=
X-Received: by 2002:a17:90a:8c18:b0:2ff:5e4e:861 with SMTP id
 98e67ed59e1d1-2ff5e4e0a25mr6281780a91.24.1741265713650; Thu, 06 Mar 2025
 04:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305174505.268725418@linuxfoundation.org>
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 6 Mar 2025 21:54:56 +0900
X-Gm-Features: AQ5f1Jpv_EZBxAwkR3XhpjU0MlJG0w8trjkFHUomYWnS5F4PAVsYZYvVmcl5D4U
Message-ID: <CAKL4bV4TstXsNOuvqKb7shhdykg73r+zAP3MLQsf0nvGYYT0Rg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/157] 6.13.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Mar 6, 2025 at 3:14=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.13.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.6-rc1rv-g30be4aa8b957
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Thu Mar  6 20:52:49 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

