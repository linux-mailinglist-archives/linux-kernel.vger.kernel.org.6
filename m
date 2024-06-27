Return-Path: <linux-kernel+bounces-232760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5520F91AE08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873521C23C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2619A2AA;
	Thu, 27 Jun 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ml9rmd4w"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29519A290
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509195; cv=none; b=qap67eQCQpwKdw6VHTzq98elfSlCvRuJKEGIAUkbqmnMXT+NZvXnZLtDvrGMSekmHNDjqwdvHb4HgcyRLi2olzvlhewa6ySwwozJKeRfwl2vJ0BLt2pGw/TFvcaFsTocZ55sqmVXkGCzZPdMakwFBrKqWcu6OoJZnISrgBZ88Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509195; c=relaxed/simple;
	bh=+JSD7zPCyP+seLtEHsOyOFtvu0SipabmuDyxuqRoZXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=qI6ME+U6/ewLm+1A5NxyAESTs9/9od8eiN145ipeHklmZmh1Wg4M0J/Hxvx3b9gOA9Yk6cTdkY0AnqEbl7je2QB25A969xWEyMTz21s/o9NWtMSSfrZeatoPmYKozrhjbc0iGik6cewmxdleNAeSbpR4HVqyKczscbdkRf31RyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ml9rmd4w; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-375bb80e5b8so4755ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719509193; x=1720113993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG0d9P09i9DuBsLa5XC/aW7vKh1cVtfIv4ydt8vzMS8=;
        b=Ml9rmd4wfgoQcqIPl5Jr1+mSuTSCIdMVInt1qHTdEH0cxC8QEG0dKuTcX3YUiJPmVG
         4AnWkIy7rSA0kPM2qmW7zt225E9gY+HlqDCLVZ2VxTF2mn+W/zqCbz6Ib4x2i90+OWqd
         PNKmEz31ulMo9b707mD48f/hI1LMrXtsuGyCpLJzPdF/g9II81fZkoYB3PtrQn2ZwCIj
         DOO9FT8/19skUCMhJu0r04U5XXPzzAdp2NdJfh5anPhXh8ZzJzCuhZqHp3L6Xps2Jc0G
         ySuwk/xZwhwzexgcl8oF2qaJnqlJVayF9RPeB/5PF6Kdb5K7fMnJnva6Ztd9LiHdvhWU
         O4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509193; x=1720113993;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG0d9P09i9DuBsLa5XC/aW7vKh1cVtfIv4ydt8vzMS8=;
        b=iKC5NakJjp6YgqOtHO28RM5w1NH8n/E7mccgvkjymc4iZG81M4yVMlgZzW1VYTifhW
         aokvaiPKDTPnetKddk2VFFTttpBPlIpxcr8ji6j42hDH+Uy3gZ8bo0dvnG0ymrQNWL1z
         O74JSazj68EQYsSOe20ZlkY0SsMmEWedszoXIBQC6veWpOS58FvLfVVetegT/S8yY7IU
         6LnizcUp7RQNfmmRle5buextlN3Toaf8lYyiZSDyVWwioeCbWBAkcUZJsSmCMe3Zib6E
         AOGU7wQ1Oh+tC3+crZws066fs93Enr0fr6/MAqKB4ef6h7VYrc5pXP9pjgpO96civs19
         42OA==
X-Forwarded-Encrypted: i=1; AJvYcCVpXOsw0litPIi1d6CYOmFQDQURINJOETe8tXubFzNRZKhxWpa0HgZFcTAiEWgV/UCSoeVpeVc+lg1hxoNwertFqY4w7o1MOoRMN5jW
X-Gm-Message-State: AOJu0YwBM9efn+SPpNlb79bnW8IPySOOQKWGZ1L1CBRcRiEVZvrBVkpR
	dgGY6vtjlLi58Wh21l1KqvYgO6IIZ/vovmD4AzfYq4qnxlDMuzzWuO3O8PNK7Vu+iM+TGs1szuT
	lTrbvSnuhoCMoovoLDdzZPmsalIvkE8npePRM
X-Received: by 2002:a05:6e02:12e9:b0:375:bb49:930d with SMTP id
 e9e14a558f8ab-379897f6cd4mt5415515ab.23.1719509192944; Thu, 27 Jun 2024
 10:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627150606.2224888-1-amadio@gentoo.org> <20240627150606.2224888-2-amadio@gentoo.org>
In-Reply-To: <20240627150606.2224888-2-amadio@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Jun 2024 10:26:21 -0700
Message-ID: <CAP-5=fVvc612rGoE3xXYqRornKZgTLgnyQH8jfJ2D9x0pDDcPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf build: warn if libtracefs is not found
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:07=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org=
> wrote:
>
> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> ---
>  tools/perf/Makefile.config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 987b48f242d3..e99afc7eb4b5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1204,6 +1204,8 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>      LIBTRACEFS_VERSION_3 :=3D $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION=
)))
>      LIBTRACEFS_VERSION_CPP :=3D $(shell expr $(LIBTRACEFS_VERSION_1) \* =
255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
>      CFLAGS +=3D -DLIBTRACEFS_VERSION=3D$(LIBTRACEFS_VERSION_CPP)
> +  else
> +    $(warning libtracefs is missing. Please install libtracefs-dev/libtr=
acefs-devel)

This all makes sense and looks good to me. I believe perf isn't
directly depending on libtracefs and gets the dependency from
libtraceevent. Older libtraceevents didn't have libtracefs so just
warning in this case makes sense to me. I just wanted to speak my
thoughts out loud in case I was missing something.

Thanks,
Ian

>    endif
>  endif
>
> --
> 2.45.2
>

