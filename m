Return-Path: <linux-kernel+bounces-224423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41459912234
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDA12861B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC091176224;
	Fri, 21 Jun 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMlJsY+n"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AD175548
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965140; cv=none; b=P50xkTgztLWogkRw+hS2ThS9VSR+QWoFBcguwBCFqDvL/cGRal0D3hih7cOgX3FGSHdkW7MT+mOeoK0vNm+laZspw/yv3m/Qhz6tvEoBX+j6ueic9+5GTbpaX9M+wbXSPMZpFPr65RYZOAPe4g59scX1UFNGakTj4/uxM5XAUDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965140; c=relaxed/simple;
	bh=Irh6LKeHFMit3xI3LCk0mLIKhIax0dw+R2mZ1n2BkN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EryTtYBw4p7V0h30Oeu2PV+ksQTQFRszyDkznc1pGaDRYO7HzIoVYQMz7+2OqFTXcrFDplR6oHW50bGlPFvsRxyDUSXmNWm6kBx8y/e5UoDVx4jIsPgn8Mxg3t3NVByZarJqAEtFhvnmOAJLQrrvTBNc+G5V+/Rrppt7hC4cFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMlJsY+n; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f70fdc9645so105985ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718965137; x=1719569937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU1bg2dMVQ265vEPTNKmS8g5kwwQUrFLWWoCI3lVA/k=;
        b=MMlJsY+nS58hXGWw7wS39cSa95htA+oUVst1qp/iuUT5GEuihrNZ/miDM461cZzZ3I
         WK44uOIXePeJKRittwvynKoSOK/U8wXhmNrHBPvtBDQ9vgbknrZUFUt0WLi2tH8XPtsj
         ccGmBxCOL1owcnXxnUM7iCFAi2KcYWpK4zSSu+a0fHEnc7Ghlm/akEXxNVz8g8n5q4Eb
         xUMEOSIAlbAgZRzK8XPZZkm1/jVmy4Uky01TiEhd6EgZa0v6MpUp5rAZ05ihX5v5k63E
         0mEM2TqYvIx+QywCASHbS3VotP5GFiyNCR1XnEjDfkV5pfLc+z/FyjJdahGt4xaXZlIj
         UVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718965137; x=1719569937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU1bg2dMVQ265vEPTNKmS8g5kwwQUrFLWWoCI3lVA/k=;
        b=r6rQaWOKIHwhNTVz/h+sTSkLT2uyOATdjjYLfdCCbzLzcvM1uxq5vV6HUC/NGCibwJ
         jLbKAQCvz3R1cnb0pieL+2n6VG/fNIOaUerUcfCt1+4N6xHLMurEGDysjqE06fsuEDye
         eVfux10CejAQmg2oUPAXORAJG7P3TwodpdlVM0MdMjjZ/metsSgkiglWBHOjoYE0/MzU
         bnDUvbQDmyPRfy5ycpKN+5zqEa5glq5uhEAoEVJ2DRdvlDfol30A+i1Ne5AvDBrAGRdv
         dUL7XN05BmZgMWgLsZWRuxcneoDzpc374ZxyAZXCAo7+a5nYDRi3utyAbzhzDhHleSBv
         TN2g==
X-Forwarded-Encrypted: i=1; AJvYcCWvG+FL6cf/pjvJIGnR0aY13aOd8SKw4to/a1JWzjjvTHKo7hHv0RZvJF9iaFlurYCXT47koinOAZy7nc0jrQcKbDyeFWCAthGUPzDf
X-Gm-Message-State: AOJu0YxiwGggSnYYcjYaHxcefrDoCM3SqjhfXdD+mW5LrglkmkOLH/ia
	sdCdWHoUZDipq8QrWfIKRzyPGkqu+C1D/3iUX7NSO0aZcug9mI4gyUFZ/ifSr3/KYKxBW8ZYjDM
	+WiN5XigzdChCuu5vX+o/n0rW7fqSvS+6fUTRWOtIYtEYTp0X0EA6
X-Google-Smtp-Source: AGHT+IHBJXlLTJPiymH4cuxAVsfUWreoKvT/nu29ZPC0PHACuKcDP0Sp21CPPYTfVUgc3FyAkwe3NO5WwDh83Ty4pvk=
X-Received: by 2002:a17:902:6a8c:b0:1f7:1c96:d2e8 with SMTP id
 d9443c01a7336-1f9e7f8a31fmr2557535ad.10.1718965136334; Fri, 21 Jun 2024
 03:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406201538.SMBucNWT-lkp@intel.com>
In-Reply-To: <202406201538.SMBucNWT-lkp@intel.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 21 Jun 2024 12:18:44 +0200
Message-ID: <CANp29Y5Nz_nf1HPfr_dY4Nrg=S6w0gJgWe0uS1d90GLDZsd0ZA@mail.gmail.com>
Subject: Re: kernel/kcov.c:635:32: error: 'KCOV_MODE_REMOTE' undeclared
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 9:53=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
> commit: 01c8f9806bde438ca1c8cbbc439f0a14a6694f6c kcov: don't lose track o=
f remote references during softirqs
> date:   5 days ago
> config: x86_64-randconfig-014-20240202 (https://download.01.org/0day-ci/a=
rchive/20240620/202406201538.SMBucNWT-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240620/202406201538.SMBucNWT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406201538.SMBucNWT-lkp=
@intel.com/
>

I was unable to reproduce the problem with the attached config/script.

> All errors (new ones prefixed by >>):
>
>          |                     ^~
>    include/asm-generic/rwonce.h:55:27: note: in definition of macro '__WR=
ITE_ONCE'
>       55 |         *(volatile typeof(x) *)&(x) =3D (val);                =
            \
>          |                           ^
>    kernel/kcov.c:363:9: note: in expansion of macro 'WRITE_ONCE'
>      363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
>          |         ^~~~~~~~~~
>    kernel/kcov.c:363:21: error: 'struct task_struct' has no member named =
'kcov_mode'
>      363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);

It looks as if CONFIG_KCOV is not enabled, but
1) It is enabled in the attached config file.
2) If it's not enabled, the kernel/kcov.c file should not have been
compiled in the first place.

>          |                     ^~
>    include/asm-generic/rwonce.h:55:34: note: in definition of macro '__WR=
ITE_ONCE'
>       55 |         *(volatile typeof(x) *)&(x) =3D (val);                =
            \
>          |                                  ^
>    kernel/kcov.c:363:9: note: in expansion of macro 'WRITE_ONCE'
>      363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
>          |         ^~~~~~~~~~
>    kernel/kcov.c:363:34: error: 'KCOV_MODE_DISABLED' undeclared (first us=
e in this function); did you mean 'KCOV_DISABLE'?
>      363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);

This looks again as if CONFIG_KCOV is not set (and there follow the
same two conclusions).

--=20
Aleksandr

