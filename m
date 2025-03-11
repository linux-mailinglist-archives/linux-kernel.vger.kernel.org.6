Return-Path: <linux-kernel+bounces-556169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A957A5C1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629D216C193
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA41EB2F;
	Tue, 11 Mar 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3cqm1M5K"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F552F56
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698038; cv=none; b=bwAFzPbuFfP18Lr9XsbDKWl+7y04ASsZF2FqrrqyPhP5f89EsA6kM+Ertm7TVwWbrPgBDJC0YGFLwyqRM0Bx+5T0pnhiePj4wU6uoOFODf17bC22EFi2oRtERF/kK1Fm5pv3HtQh9/VdYPG5iS0U6BEo9V6X5yZ/PPLWpwKMPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698038; c=relaxed/simple;
	bh=yIpxJDcYAls4A+23wuwEwSo9LSvMNE6FKOtlsMqjj84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufI+o91SKOpMEYXQsWHyT0k+sPPK2xshbqaDTaTN6Sxt0ZQjYQBPx2J9MkRpHzj2SKWpqDEFyUpFvtyjrk4z3ku4z1RQHtCL8yzaj9WWJVwQLNqylMCKnzcTOGI22b41dUnair2vBZ27HSmJhbhF9oC2fL7PxQGJ1GWKiuA9oyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3cqm1M5K; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4769e30af66so183971cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741698036; x=1742302836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4VHQhu5V4TeRvh0NUCJQSxM18BZB2qvN8uXFXJh7n+Y=;
        b=3cqm1M5K55z681zzj9d60o9NM5Z7GNg4QcLyrAQczVswM3xpNoeuSvRYWzAGCx6Ql2
         9QbrWpmpDCuCrL4VPJ3b5b30rZ/nJfZV6DeCH5VCtGE+Fq8SR9tyZZH/Ajsobv41qsvX
         DXlfI3fLNReDQilS0zdvvffVZW6O+LBok89io0GAtbhQklV148SDSWB04YWTfhJGpGXC
         8dKqjfcEOddUDnOMdNUOr0NpGzoAeJ/7AykruON3WjBu/v+nfL+TXKZDBDENZnKjKRsi
         xlzi6hXT1FLr1juLXMsuaN6kf1j8j0f7RFYgvsyIaLyqjhMzUcGa/4NO/M1vuWDyv+OR
         J6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741698036; x=1742302836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VHQhu5V4TeRvh0NUCJQSxM18BZB2qvN8uXFXJh7n+Y=;
        b=l8u9EN55X1+7GJCA3pzVVwyI2lCk1Tkzu5UngGJmYFrV5QGraRcmn7hmVloz3M4yBj
         rY2M6/7BCm+rxxtAEHYJozqkeoY98dRZ7wJyJHVDhtO1Wk+dyB3x8uKfZ3QDOTAqq2l+
         pcvAOJK8D0g7zthDH7tFTe0CaNrmUn74/WuJpLtdUGwp3vgYPJWvRpiGRr3dYslssymZ
         9/IKg0a57hDHGvGpdqDp9Fw9zcDRmUv8INLgOEqicCDHkh3cBLqGsRpTSHfWZCTayFkE
         P2Gbsx88BIeTi5kIDnxPq5A9QbFuYWKkVI99cgaz4lo+t/N5r0uiZ5Gk3iNjb+VT5HhF
         5KHw==
X-Forwarded-Encrypted: i=1; AJvYcCUVUIVVrmkE9Ie5s7KEb83lPt3iSI3PIUtRdHs9XvorazaOnBoXKRNvmibr58bhh9ngfCIBmpUuOH/TEFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+b4QOZElfU89Fxvx5+1wm1mg/p6/ti9Tcw+8FIxkbHhWRy0aQ
	ksP2X8ykRqi0hR1rJArfWrOl2hhUP1Jyl2bb1jJmEG/G2EyPylXQUWCjovhG2JDPz+ssDKsqT0I
	OhgBRB/KN6iDb7uXEjAETBvH7HEyAE0BsMIy3
X-Gm-Gg: ASbGncsCmRWfG2cLKCxUhENixX9x3T6diKG6gWpHaGdxG5YkDgfTqPpW5OO4JVZ+c/8
	eH3M+FDPw4ikwzDGa6d/RSoktk/daThxPZNh9YKf54NLVQxoPMqGWN/ua9aZQpvOA7+QzSgFmuo
	kW4Rjvs09Ha3sYP1/ck4Ah/TqwHiv4xhUticnyXuqI7kcyNBpW+JnRgpCx
X-Google-Smtp-Source: AGHT+IHjbvoyGhYxZy+5DnhAXj+weZD+odUEYuzByCq9hSqciyG94OAwXLnaCEx0Sp1sFSDatHVUQxyRQdN8oDCn60M=
X-Received: by 2002:a05:622a:53cd:b0:474:b44f:bb88 with SMTP id
 d75a77b69052e-47668af5d7cmr11461811cf.27.1741698035462; Tue, 11 Mar 2025
 06:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com> <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com> <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
In-Reply-To: <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Tue, 11 Mar 2025 14:00:24 +0100
X-Gm-Features: AQ5f1JqAOw6spu6AMy4R-fMyLCvyaVsj-m1jqaL8Pde_lEnMc-b72Se9VM50FPs
Message-ID: <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird filesystems
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 15:40, David Hildenbrand <david@redhat.com> wrote:
> Yes, just skip 9pfs early, and mention in the commit message that 9pfs
> has a history of being probematic with "use-after-unlink", maybe
> mentioning the discussion I linked above.
>
> Maybe something like this would work?
>
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index 9423ad439a614..349e40d3979f2 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -47,6 +47,16 @@ static __fsword_t get_fs_type(int fd)
>          return ret ? 0 : fs.f_type;q
>   }
>
> +static bool fs_is_problematic(__fsword_t fs_type)
> +{
> +       switch (fs_type) {
> +       case V9FS_MAGIC:
> +               return false;
> +       default:
> +               return true;
> +       }
> +}

Ugh, some fun discoveries.

1. fstatfs() seems to have the same bug as ftruncate() i.e. it doesn't
work on unlinked files on 9pfs. This can be worked around by calling
it on the parent directory, but...

2. 9pfs seems to pass the f_type through from the host. So you can't
detect it this way anyway.

[3. I guess overlayfs & friends would also be an issue here although
that doesn't affect my usecase.]

Anyway, I think we would have to scrape /proc/mounts to do this :(

I think the proper way to deal with this is something like what I've
described here[0]. I.e. have a central facility as part of kselftest
to detect relevant characteristics of the platform. This logic could
be written in a proper programming language or in Bash, then the
relevant info could be passed in via the environment or whatever (e.g.
export KSFT_SYSENV_cwd_ftruncate_unlinked_works=1).

[0] https://lore.kernel.org/all/Z8WJEsEAwUPeMkqy@google.com/

But, to find an immediate way to get these tests working, I think we
are stuck with just peeking at errno and guessing for the time being.

