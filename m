Return-Path: <linux-kernel+bounces-390809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656CA9B7EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E37E1C2161D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DAC1B5337;
	Thu, 31 Oct 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYQcSpdB"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5319DF4C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389417; cv=none; b=FRJDRpyv4u7wS5AK4dj+FTumWjf4+Tm2aiKIXUpPt25fHUvPISaWEjsIeBX7obdP3oJQc6U7EYCCu1WOXhk7STdlFAh/TPAESEN4TzRyMCT4SxNj4T6p3O+9wfp6MsrAK8Vvk8FKvsEfdWga4u+4g5MRVIuJaWnfJ37DEEzOvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389417; c=relaxed/simple;
	bh=vfsB3Thfd6DUJWh0LyamNbEnTDENOiTplgjgv49TJj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skO+pa9tMbqraLykQvzwGUdGw2xNBLMwS3LKEkIvVfZNqcchWvoRwnYknEuceLmkj1TY0gBn9Th/brwA/aAZpUSdAltMKOuhFtoRHB+ZnUEsmy+oRr/6i6TWet+hY2IRpPu6ejN5BQof6ato1EPJRf6y8y1Ul50q48CZvTDoY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYQcSpdB; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso235325ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730389415; x=1730994215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gak7b2hQidOQibyX7hkapEVVPckTY1xPlBaffa3Vjaw=;
        b=pYQcSpdBOzo9l7fELgiR3gmQiAZNk0irHfm7MRiIfVBb9oYa+ca64vrNP8crsLtm+f
         vpQaTBwf/qH/GODGdUH1oJcYEYXPr9B7J5JwHRqP5ZY8VxOKrlKw1wcm0KKtBJzvFSxx
         wZy8nZjQmriJ3kdJGv3pOVRIVWwknNAjmZtcKYZ3bXyC+PAmYiDk25poet6B2agcw6aD
         Trd3i2PqwCt3CUbzwefRD6r6uKCSx3W958CEYZu6aP6ETh3SsR1Z1jSdhlL0F4JKp8Qw
         TKzSeUUoiNp4swVd5qChYspRHF/FFwELYLJLozV1zP1vy/7Lo/kb3lZJ7s+KM/c1tLpk
         Sk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389415; x=1730994215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gak7b2hQidOQibyX7hkapEVVPckTY1xPlBaffa3Vjaw=;
        b=LOCWvJl4G3J/IR3JGZP99YoXtkosVRd1gV+zjUQOCGB/8rnQBUCdTDtEGHPvD31ez7
         Tsxk3kjZhDPmOzNkOMwqxiihC9hqqM9dccYta5vk7cKtVUEUAUjeiXcHPHF3m4hwBkhr
         aVlSsbwmcVWoJVQaXM+60nIbVn4Mqa3RUhvFwYwByyZU8wSIQD0PThWjpdb6nqTDOhVN
         Tc+Rfn1xd9o3tBIKKUIGG+LoX3mVjpI89mxTAn+a5UfiQmfPMzir9uQ+5tGg25jQJ4lI
         C0IVO9eC1TLtvZZb3FEK0c3li0PkaiP8cIx4GqxshRNMWAUsM04/S3I7EOxzr+MQgBTO
         FSBg==
X-Forwarded-Encrypted: i=1; AJvYcCWv/ALS73fsdrfts8+2CBEkMe/RvFhnF72YaK0IpGO0B+qpllRTVdZ3PEVzf7/0bBMdUWqZC5CWSoC/C2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5IfgNIma7grClUPbezRcaH5JAA//DtdVnwHk3Sny3N8Cg41RO
	iUB9lsMy+3nKL3aUHJ4PVSfz4xROqZB6qYBoc2/0Ayj1vQLqERPGckrJna/AlzGjmKwik0csiDv
	bLKtkLcR6J46vShY5JqBsBGwPmV8ZKhaaVQE5
X-Gm-Gg: ASbGnctJJNsU+4NRU5OSZWKXNFDyGt4CnHQEuoHlG4vau/VFoJZxKPKzssaMbNiJLHl
	eEwPPLxmuWRti5C6Vu0sdkLYTOFII3o8=
X-Google-Smtp-Source: AGHT+IFGBxBwu0pfOalxBOWa30kiZgTlDKwbfWjgsTYFAPFbqK7EZY7RwXMvypzXV/9plNHmg5dzWx3tW+rk7khqIv4=
X-Received: by 2002:a05:6e02:1a08:b0:3a3:dab0:2399 with SMTP id
 e9e14a558f8ab-3a6a9414a07mr3022335ab.27.1730389414309; Thu, 31 Oct 2024
 08:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031045602.309600-1-avagin@google.com> <ZyNS9J7TOQ84AkYz@example.org>
In-Reply-To: <ZyNS9J7TOQ84AkYz@example.org>
From: Andrei Vagin <avagin@google.com>
Date: Thu, 31 Oct 2024 08:43:22 -0700
Message-ID: <CAEWA0a7W4u189wViEk2P9ZBgUe7DFGmSA8UKW0gKvCC8_pRiHw@mail.gmail.com>
Subject: Re: [PATCH] ucounts: fix counter leak in inc_rlimit_get_ucounts()
To: Alexey Gladkov <legion@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:50=E2=80=AFAM Alexey Gladkov <legion@kernel.org> =
wrote:
>
> On Thu, Oct 31, 2024 at 04:56:01AM +0000, Andrei Vagin wrote:
> > The inc_rlimit_get_ucounts() increments the specified rlimit counter an=
d
> > then checks its limit. If the value exceeds the limit, the function
> > returns an error without decrementing the counter.
> >
> > Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
> > Tested-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Co-debugged-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Andrei Vagin <avagin@google.com>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Alexey Gladkov <legion@kernel.org>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
> > ---
> >  kernel/ucount.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > index 8c07714ff27d..16c0ea1cb432 100644
> > --- a/kernel/ucount.c
> > +++ b/kernel/ucount.c
> > @@ -328,13 +328,12 @@ long inc_rlimit_get_ucounts(struct ucounts *ucoun=
ts, enum rlimit_type type)
> >               if (new !=3D 1)
> >                       continue;
> >               if (!get_ucounts(iter))
> > -                     goto dec_unwind;
> > +                     goto unwind;
> >       }
> >       return ret;
> > -dec_unwind:
> > +unwind:
> >       dec =3D atomic_long_sub_return(1, &iter->rlimit[type]);
> >       WARN_ON_ONCE(dec < 0);
> > -unwind:
> >       do_dec_rlimit_put_ucounts(ucounts, iter, type);
> >       return 0;
> >  }
>
> Agree. The do_dec_rlimit_put_ucounts() decreases rlimit up to iter but
> does not include it.
>
> Except for a small NAK because the patch changes goto for get_ucounts()
> and not for rlimit overflow check.

Do you think it is better to rename the label and use dec_unwind? I don't
think it makes a big difference, but if you think it does, I can send
this version.

BTW, while investigating this, we found another one. Currently,
sigqueue_alloc enforces a counter limit even when override_rlimit is set
to true. This was introduced by commit f3791f4df569ea ("Fix
UCOUNT_RLIMIT_SIGPENDING counter leak"). This change in behavior has
introduced regressions, causing failures in applications that previously
functioned correctly.

For example, if the limit is reached and a process receives a SIGSEGV
signal, sigqueue_alloc fails to allocate the necessary resources for the
signal delivery, preventing the signal from being delivered with
siginfo. This prevents the process from correctly identifying the fault
address and handling the error. From the user-space perspective,
applications are unaware that the limit has been reached and that the
siginfo is effectively 'corrupted'. This can lead to unpredictable
behavior and crashes, as we observed with java applications.

To address this, we think to restore the original logic for
override_rlimit. This will ensure that kernel signals are always
delivered correctly, regardless of the counter limit.  Does this
approach seem reasonable? Do you have any concerns?

Thanks,
Andrei

>
> Acked-by: Alexey Gladkov <legion@kernel.org>
>
> --
> Rgrds, legion
>

