Return-Path: <linux-kernel+bounces-286993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FBF952156
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC4228176F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C11B32D2;
	Wed, 14 Aug 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/tNz8Ht"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E071BC06F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656919; cv=none; b=UlracmMiovzEHAef/MjuMVae61rdZhNoigD2qRJjWjf3LjJZ57tUDOPwsZhBbaaHurFr1LoIlssbglGH7YLujxyKDk6R67Gv6Yzf3WJfhQ+kVY7NZxhOLtO3s3KlKDSYg9Ohgo17KAxLbPN+6Sob+9RQrHEWS66vKIpMy9KZotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656919; c=relaxed/simple;
	bh=xWbitBG4Vy57q6SFKYvH/+aIN3UK4pDJiwGhdEeSOtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPBdrN46JJbLUVJvuLN3I+qjkZo81S4b30h7zMjBmMvcY9vDXX2RovxE7PWAi7RGnSXIZZgZ1hguLUfhkSql0i1UVaq9j/gSpWkE5B49rmpFSu/wlwWJFG0/aw8NGKBryJ7xeeCENkSS7PAw3DhIr1074hAvNhYcSsJzwZD+Q6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H/tNz8Ht; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so1739411fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723656915; x=1724261715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWbitBG4Vy57q6SFKYvH/+aIN3UK4pDJiwGhdEeSOtA=;
        b=H/tNz8HtkGiGMKcPN+qSt5RnpqVA9WH2BkwImL0krz6Fua4FH9X/Ppt1QilJ9B4Ql7
         M4b5j91OMzPo9u/ZJdJgBY9XQBnQr5PhsHYl1z29hVnt/hvSGsfiXUxW8uWwIpmeJUb8
         rImxKi1pjrV7IxFX4WW6zW+Sn6XyNFTUitj6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656915; x=1724261715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWbitBG4Vy57q6SFKYvH/+aIN3UK4pDJiwGhdEeSOtA=;
        b=N2SWH+dX25cA5XMejHxI5w/84+eAb6db0usM65ZJFVzifS9w9PplBI7uWF2bb/mZ4y
         qYuznSbcxZhX7ZI4Jokeb0XYM4R1FGULQ4lCFDkBcmCQPN98oc4tj130NKi9PG+g++xf
         eBrhcHAafPf3dHos9K2YdKyFv/UPgi1XJbESabmbDdZSkF/PStp49xoDTejKDvtXzaDK
         HemalL6fCQrKSEvVEtTMILtnxYC+fbBwI1AGQVANtURzXMZS5RBZISRafWpjZtvTPc0u
         PomCrIBPKVbVS2r1RkPYvvEP8TfrupTZEpbzV4zsOT3b9WYM8Sv18HdF9TELy1hZgPor
         uvGA==
X-Forwarded-Encrypted: i=1; AJvYcCVFtwcEMKH8INCKFS5ctoglWj7tIsf5j/ar5jBmPEC7r0O6dsew6V5jfd8AFB7QSQlWFrqhYcqDQ9spE/tQ2Zj7VSwz1O7SUbaEyjoo
X-Gm-Message-State: AOJu0YwxLWX8jHpbPpAaaaHW1I5qbc1FfNdCrlukUal+sQUXmcSEtF8G
	lFKcIKThPJgrk27FW/e3yJWs7V2KPmb6cK/agjo35S7Z38+z3Or2VOrazvSUekJEbvao3/P7qbs
	=
X-Google-Smtp-Source: AGHT+IGZkRKWEI5sIniQmiBMHwvZtJHUtyI8DG5fx/Ykz5++dMq+TvOp/g0N6JwMF13mBqNwP+YKXQ==
X-Received: by 2002:a05:651c:2203:b0:2ef:2dfd:15dc with SMTP id 38308e7fff4ca-2f3aa1c941bmr32502471fa.9.1723656915084;
        Wed, 14 Aug 2024 10:35:15 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f29203d82dsm15198311fa.87.2024.08.14.10.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:35:14 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f00ad303aso114777e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:35:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKNc/jomKLwHehC9Oi9zlfbkIEgEqsHTRMA2gO4joVlc71NRvtYa/avF0raa0rKG3/slLquGptc5YkqEqm7skWFtwPJOzODOlF5ygG
X-Received: by 2002:a05:6512:10c6:b0:52c:dc6f:75a3 with SMTP id
 2adb3069b0e04-532edba89e2mr2666679e87.40.1723656913739; Wed, 14 Aug 2024
 10:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814173021.3726785-1-agordeev@linux.ibm.com>
In-Reply-To: <20240814173021.3726785-1-agordeev@linux.ibm.com>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 14 Aug 2024 10:35:00 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMafY_w5Cm5EWS+dUn59kL3d_h4ZBW9w_Hn=7OZ=5n8kQ@mail.gmail.com>
Message-ID: <CA+ASDXMafY_w5Cm5EWS+dUn59kL3d_h4ZBW9w_Hn=7OZ=5n8kQ@mail.gmail.com>
Subject: Re: [PATCH] tools build: Provide consistent build options for fixdep
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 10:30=E2=80=AFAM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> The fixdep binary is being compiled and linked in one step since commit
> ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues").
> While the host linker flags are passed to the compiler the host compiler
> flags are missed.
>
> That might lead to failures as result of the compiler vs linker flags
> inconsistency. For example, during RPM package build redhat-hardened-ld
> script is provided to gcc, while redhat-hardened-cc1 script is missed.
> That leads to an error on s390:
>
> /usr/bin/ld: /tmp/ccUT8Rdm.o: `stderr@@GLIBC_2.2' non-PLT reloc for
> symbol defined in shared library and accessed from executable (rebuild
> file with -fPIC ?)
>
> Provide both KBUILD_HOSTCFLAGS and KBUILD_HOSTLDFLAGS to avoid that.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

FWIW, I already fielded some reports about this, and proposed a very
similar (but not identical) fix:

https://lore.kernel.org/lkml/20240814030436.2022155-1-briannorris@chromium.=
org/

Frankly, I wasn't sure about HOSTxxFLAGS vs KBUILD_HOSTxxFLAGS -- and
that's the difference between yours and mine. If yours works, that
looks like the cleaner solution. So:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Either way, it might be good to also include some of these tags if
this is committed:

Closes: https://lore.kernel.org/lkml/99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@l=
eemhuis.info/
Fixes: ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues")

Brian

