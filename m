Return-Path: <linux-kernel+bounces-570061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C2A6AB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56ACF484321
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4CF22256B;
	Thu, 20 Mar 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lo97g4dS"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A6221F33
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489807; cv=none; b=H32j9yMFcEobpoaNO9vbrvcgDCRghqoAsuUcqU4N35QGk4/ZCVnbpNJNKT+R1YfnH3gYO2uPb/1Gdixu9U/DasuAsHzhdslYJqvaMJ6WQExGAefGDd9kG4aD9442NpKcGW2WMZ2CkbafB+fe4axOqsHHKBgUHc9d2v8dyoq4Cl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489807; c=relaxed/simple;
	bh=BZCAuvyAuh427/jqJ7i8WLQxzNgqBc9VwdV0og5Ob6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsrG/6vdf+6sgBtzWaWGtygHeTYOURQndBLLEKeGAm+3X3NUUP3+UBmPpPEqqUx4qpEFTON3rhRudyQX9I5/pdVVx4L5PX/TGq6Tqa77a0kcey4VX1CZplR9sv85n1jl6kIMN9VlaQRMlbGxslCIAeZl0WR7lXR8RUQtOoYm6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lo97g4dS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso1875153a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742489803; x=1743094603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2zHPC0+oDiCij/J+i4bLXS/34pdN6zNqLkvL10z8n2k=;
        b=Lo97g4dSyT+pmyd+wbpoSg/GNKCHFsWmUsKexyT6psKUX5KK1TSt9MwWTXxyCcSIYz
         Y6vqEXL/KERWawNW2u0qoVqh1sQKIN5q9FtcBITAAsi7DWzh1fpoP2r8YVC9Lu6pQ2cp
         kn+SvIreJsrPHHgWW0d5kY1DT4CzwyUWqSLMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742489803; x=1743094603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zHPC0+oDiCij/J+i4bLXS/34pdN6zNqLkvL10z8n2k=;
        b=d9aFOQZ814gZAMDShZcyf0Ydsm6PZ7+Koa1McfAlKNl1oyijU2xi9TeFiS+DmVujYQ
         0zlksXI8Pf+ffaypU1XcmkZdg+ndWpoRQJ9d2lyHbGhsTbh+U3Ayuy6YiyLlmmw+lUkO
         92yKUT8EsQYUe0xFOhz62mrKJANncM3cZQXHxj0+AUbb/tPugaRjex3oBAkJM0vqHarK
         vH9hFDLiA1huhe5l8pw05FdtyZk0wmb78IQm8YUReBV5j6C727GP3ViLUSjGU62yOHFj
         Yqhi78+4rlkw/cheRtrQkN7vv02SIeDYE+l7sq59g3rmphjmVoVFvGqoKyZccbcAOmSv
         Ijog==
X-Forwarded-Encrypted: i=1; AJvYcCWDkBq11x/PqJlyitlMvttqVK4mFjX6MNrQDCqKqW3Q3d7c/YK3xKHeo8P0ezALa68FQ3rRTL1aq1XLezg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCPmAeag0IS/VAh9W6Cgq2T8aG8LtdwI4Cb/KE30Vhb2BcI6k
	0PEsaj/+yCIEFF3SD+Rn/Ac8oyTL+NCkSStYZf/zdw8rgwa1m53BZKw4xOexDJnQ30S6mgnOnJQ
	zBtk=
X-Gm-Gg: ASbGncv454z/cMB6BI/m1jpXk6lIKmT4/xbaa6NibIQ3ZDUAsCRN3HsKMkF5h/5Pnwn
	sOvKm6mhToJeKAoNxwogriAAChg1oQgJ/lffwrpuU8ZZe4bQrVlYjuq6d2tyHl+hLXiRoQI909v
	0vnT4KOSiDT9zP3XY2a8Z6y3PRqzcEpYKDqRQleUDkRbT0ls8UDfjzhoeH2Uo8p8xZNjjZoK5ga
	5ge8dZGgB0fFKgaI5RGShefxle5fz/jINe5uLkh5C6/K+eS2IJDjxeDhUB7XRPaCd3ByFQikCKA
	3Si65mHXFeSWz1h6Ow3jJOmihVJcsxSvevhhKQonEDN9GF5J3wfS4CmXBAEqe2+vAd54l5k4kR0
	sRd/QToQ2JThp3zL1R9s=
X-Google-Smtp-Source: AGHT+IHeWEmNA+UZqeJ0VZS3zJ/tNRwHrOFpe9MBFFtruW2Qc9D+YKiyCA1ToOE4LP4a7vNQ8EeUyA==
X-Received: by 2002:a05:6402:2349:b0:5e5:c0e7:f43a with SMTP id 4fb4d7f45d1cf-5ebcd266bd7mr79203a12.0.1742489803375;
        Thu, 20 Mar 2025 09:56:43 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf67e70sm53615a12.6.2025.03.20.09.56.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 09:56:42 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abec8b750ebso198974266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:56:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEuB9edesPjxwYdc6qqwB6P8SDwenfPQlpOSOKSCdomKUWWAB3ovD7WKNYRS2kDq7HWfNvDToAhPqxsfM=@vger.kernel.org
X-Received: by 2002:a17:907:3f22:b0:ac3:b115:21b8 with SMTP id
 a640c23a62f3a-ac3b7fc29bfmr693107266b.47.1742489801561; Thu, 20 Mar 2025
 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305184725.3341760-3-xin@zytor.com> <174238223959.14745.6970497940010271580.tip-bot2@tip-bot2>
 <SN6PR02MB415756D1829740F6E8AC11D1D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB415756D1829740F6E8AC11D1D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Mar 2025 09:56:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whChrRQ0kuRuZo2+9D+J2BO9Q=1CV2eEk_yjrNi8kdjBg@mail.gmail.com>
X-Gm-Features: AQ5f1JqY6OnCDsFq8Ok1LIZALH8Jq5AGqzokPrGi8Ig_OGjTFwRqyz0s8l8vPrw
Message-ID: <CAHk-=whChrRQ0kuRuZo2+9D+J2BO9Q=1CV2eEk_yjrNi8kdjBg@mail.gmail.com>
Subject: Re: [tip: x86/core] x86/cpufeatures: Generate the <asm/cpufeaturemasks.h>
 header based on build config
To: Michael Kelley <mhklinux@outlook.com>
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 09:23, Michael Kelley <mhklinux@outlook.com> wrote:
>
> With this commit, changing the modified time on .config causes cpufeaturemasks.h
> to be rebuilt, and then all dependencies on cpufeaturemasks.h are also rebuilt. It
> doesn't figure out that nothing has changed in .config. A fair amount of
> unnecessary rebuilding is done.

Hmm. Normally it is the tools that *create* the config file that
should notice that it hasn't changed, and not write a new one.

See conf_write() in scripts/kconfig/confdata.c for the particular case
of the regular "make *config*'

> I'm seeing this changed behavior specifically with the make-kpkg script on
> Ubuntu 20.04. It's not clear why make-kpkg is updating the modified time
> on .config, but prior to this commit, that update had no negative effect.

It sounds like the make-kpkg script should probably be fixed to not
overwrite the config file unconditionally, and do that "make
oldconfig" and friends do, which is to notice when it hasn't changed
and leave it alone.

                   Linus

