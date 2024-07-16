Return-Path: <linux-kernel+bounces-254424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED2933308
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A32B1C226B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C53258210;
	Tue, 16 Jul 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXw5uS0+"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E453D3BD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162738; cv=none; b=sUOgCr8h2KE/uEPN8U+M11MEBhLlSRNX0X1m7q76ILAg3IDdmMh1ynQVCdKPCjG+qiu1qVrVknMsDJIayAj9hCgqgUyZcXRE2yVmN7PYTyI26kCt1GRD1w4YvlOVXJ3GCmjpjQbQom9k7KlYEPxOKj7Njft4IKZwj/wIM+3nLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162738; c=relaxed/simple;
	bh=iW0FGJyWPUMoCTPJ87BeXQntpaZoDXyTNW9HRfL2Gm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqph+nbW2Pua9JBUnplohS56rJ4OjvYz2vu+b2Ad9nvMwUDWo/90kImMbkky7hePkEyYUX5xfhzIXtLkLXhTYJwR5wMiU0ziGJeQpU+OGjuOGDqLl/HTwugGy0kw2dg3PooovaApb4BiSOxoDQBJRcwec8dj4E8H7kJPJArxQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XXw5uS0+; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c66909738fso67249eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721162736; x=1721767536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JacPEkGGGsxMEwr6rUWgBfgGlLH9sSrjcqgHkLxEgWA=;
        b=XXw5uS0+hmOypn89+LMtJuzVk/somVc6RE5e2IE6xNFyC1m0obATa7+8T+ytwe9Pkg
         7Q0PRni8C38JRqgP+p4op2e0/D73GI5m4JI7A5nP0Cwx8mC/8O7g1Ps11SxqHJRnu9G/
         HPKRLV82CbVQgCZD38slvRIEkB2gNs2pGdtvU2MDl9lKe21S+moys4jy5ciGkh+YbmeV
         NLsfPyHw2qVbMreZ1o/tuha+gc3LM8GpoHC+GNrPSfuvL9Tq86Bxx+1CDxfkfIFXJOow
         PNCZgFPDzRaBn4bJOg/uDtIOPLLUy08pYVqCQzAn1l6k9WVvpGBGAm05lQHwvSDudyQ9
         WRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721162736; x=1721767536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JacPEkGGGsxMEwr6rUWgBfgGlLH9sSrjcqgHkLxEgWA=;
        b=rZrLYmuUH+NKNsnBx9lv89iRU1O5Sitrshd+NzGf4kLWeNRN9BEVIEwAfIrOSNKIeP
         MbnekbHMnm/9hhmFDQQVITI38ZoZQywgK+SrNe6XgoolSGAXMl7RX1MeLVkTuU8JRd8Y
         M7ACi94GEBp7JXsTrnhf44K5L033mf5OI0wBRNkhGwJkmK3ED1zV9D9ZlR3/r7i3EDB0
         xXgPiVVLDihTiHwYwZjhtcRwmd2wjoD5QB5g09KACsc8YblDWJ4kbv/cXTvjYOyvLkEQ
         x3rENC0UhG6UZ8R0/zAHJAa8rwByEhbymPbFxYryReeznJRKJgGbOjrY/7eTiwN1MqLR
         4Mhg==
X-Forwarded-Encrypted: i=1; AJvYcCUoMjgk06e1WLE0uYe3q9kzAm0VHaHympOEBbQQLwOfQHY2qwwxvomi28QOzxeQodOid4QJZL4I6KwahvP7FpwlUwVOhj4XXz+b2OPa
X-Gm-Message-State: AOJu0Yz2LyRoH05Qsj5Y+giLRiIlULm6DxcioP/Bf3sAFLuGIqkmtk/E
	WKXu2fRpnXjGHbb0ncWqf9sc612RUCuu9io7cMMe5ydD6jZogcwDwZsLXHPwTDY=
X-Google-Smtp-Source: AGHT+IHCjy42xDuBC5UQWJtltJ9p82Idts+EMBtihlCpniaKr5WerzVsRCSCFN3IA2e0wGXoOszWmQ==
X-Received: by 2002:a05:6871:5c03:b0:25e:2b75:1f89 with SMTP id 586e51a60fabf-260bf549d30mr1278907fac.22.1721162735984;
        Tue, 16 Jul 2024 13:45:35 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:b5d2:9b28:de1e:aebb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0d1f628sm1424013a34.67.2024.07.16.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 13:45:35 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:45:33 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 5.15 000/144] 5.15.163-rc1 review
Message-ID: <c7beb899-91dc-4fcd-816e-fa7ba6f956e4@suswa.mountain>
References: <20240716152752.524497140@linuxfoundation.org>
 <CA+G9fYvVaSX9Ot2vekBOkLjUqCx=SbQqW4vWhypCnGwwBmX4xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvVaSX9Ot2vekBOkLjUqCx=SbQqW4vWhypCnGwwBmX4xg@mail.gmail.com>

On Wed, Jul 17, 2024 at 01:49:12AM +0530, Naresh Kamboju wrote:
> On Tue, 16 Jul 2024 at 21:37, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.15.163 release.
> > There are 144 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.163-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> The s390 builds failed on stable-rc 5.15.163-rc1 review due to following build
> warnings / errors.
> 
> First time seen on stable-rc 5.15 branch.
> 
>   GOOD: ba1631e1a5cc ("Linux 5.15.162-rc1")
>   BAD:  b9a293390e62 ("Linux 5.15.163-rc1")
> 
> * s390, build
>   - clang-18-allnoconfig
>   - clang-18-defconfig
>   - clang-18-tinyconfig
>   - clang-nightly-allnoconfig
>   - clang-nightly-defconfig
>   - clang-nightly-tinyconfig
>   - gcc-12-allnoconfig
>   - gcc-12-defconfig
>   - gcc-12-tinyconfig
>   - gcc-8-allnoconfig
>   - gcc-8-defconfig-fe40093d
>   - gcc-8-tinyconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build regressions:
> --------
> arch/s390/include/asm/processor.h:253:11: error: expected ';' at end
> of declaration
>   253 |         psw_t psw __uninitialized;
>       |                  ^
>       |                  ;
> 1 error generated.

Need to cherry-pick commit fd7eea27a3ae ("Compiler Attributes: Add __uninitialized macro")

regards,
dan carpenter


