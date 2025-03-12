Return-Path: <linux-kernel+bounces-558081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF8CA5E166
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CE018896CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4221AF4E9;
	Wed, 12 Mar 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PInQDyQ4"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A29B2033A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795576; cv=none; b=j/V/UrrCLo21r5ldvVJGKAa3flspb2LOR3BRpUBfHoRY96Tb0V+W+XHVUL41RG8NrkSe02SyMnSeHE/k8dEAa78Wte1lHA/gyiQPCrIvPAAgXIKqNnSDvWv8tcDl7ToO+p4vWBZj4rNpHYnXBMqEMc9fbP1g2WFXiOhK37SnTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795576; c=relaxed/simple;
	bh=pI0/d6VWhb3rHB70TMDWtb5UFpEepPzY4oFcPVKsnh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHc4wyfyXG5o2+oXx7AquFsy0NnVCY64KexV3/2AH5Z25eNgcA8FIR2YYQ2MsJZ+4DACYlrwb6LMldcjTu9mkVyd2TpPeSmUgW0YZQIWqqo9haXclHM0Co9VocJ/6hAWdhr/iMYeEtaqRmWG8lRc7Sk2BUgOy7FUJSn9ZWwlhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PInQDyQ4; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47666573242so349911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741795574; x=1742400374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrwYv4hV0FSY3G0vHHh7TMbzsgf3mwWBIi9HSSg420o=;
        b=PInQDyQ4dIr1GHpBncgGK5/XRGNFnPfFQtC2uexqDz9zyoUoT7JHfgt4Zps+a1IoLZ
         9F1mzQnt6W5doUKmDd3e20dkC7Ys8+W3pzRK4cJbI8G2/r8cs/ybZ6Q0mDW6zPbMVesT
         EyCx8FWWfKeM7vvve82uFHtXGJvcDuIh0VeFi0QEWbuKFoRFM9iGdcsX3nGslKBZw9lS
         fZz+OjsDV6ah/px1rP0ONs8U4a0EeBrqaExqrHCnXPzyp7kZCESYxC/grSM4my1k2BMR
         j6NSyspAxJ408QBxd9RHOsVIY90ZWqwdxqFzGSBV6sRYp1wczk6ERHOUo0JkLLHFR0IZ
         ZdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795574; x=1742400374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrwYv4hV0FSY3G0vHHh7TMbzsgf3mwWBIi9HSSg420o=;
        b=GEnMGtbEC5PWQ0sN6QMfefHBnCjukGem03USq1b2fs4K9TB8xhOsqDG3LcyC1eqoMc
         FVpIov8Cou3BAa1S6Xam3pAWemIsZqbnedC9R3s+FwOxX3UJwskVL5Ps0wHv84lJKf1l
         0GGRQ29U7W3vlQrm7mQmNQIfA82pPrdvx9btSODl9j1q/p7aJMMzGMdtaWyX3rGef9gZ
         N+kQdzWiuloo+KCKRx1HMiqa23CKJqh56ZrsFFVWtDGGWG2FhN522EE5SlQ7z9mAwZY5
         EytNQkpJSFNCJgxeAtFcsDaFgN36D+SSnh+u8kFwPy/RHEHXYnrMl6KJGv3gdhJCXQlB
         3k5A==
X-Forwarded-Encrypted: i=1; AJvYcCW1eCZjztQqtvvci2gDz269/MFI2xRKoIAsZ/miFylyEbiYi/76tO1lrORhNQCn8F3Hb2MIyaIZXeEFGn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29bzxcttVHq/NyVTVEGVtBxuHJZfENSSqK8xBhV6d2+X6poBn
	HL7agGUuRqSJ1rwK5tFCfir5Zj9qlL+AIOFiFdPbHkDAWBPyyhfgVR4ohgz00ra8T1oXfn5dSk7
	vL9VdCK2LlO8sO2y5u+2c6NjlBQKLDoOvXxs6
X-Gm-Gg: ASbGncsgDVfhgFSBxBFfqnWJvv2Vg82GqfCPCBvvYYVnbAmRJVW334+AxEPTVX0yTgQ
	4havyJoITr7HqlGoLkBycZve+GrYg/2Z60R9hdnUn5T0B9fTS5VmAhLF579lPva0c6qxeeM8FYa
	8FuPkfYyiwzWI4A7urt6+qh5ncdb2jDA+M9OI6xowGG0qJGJ0hOaKHHJxz
X-Google-Smtp-Source: AGHT+IFGXoN107iRcKAaMfh5q54qUSWhsZqDVFmtSnv/zuzK/6+/d0yI2gmYWt4umU7mYkJ4NKdYWUinvN1PCsVQ9g4=
X-Received: by 2002:ac8:5846:0:b0:467:8416:d99e with SMTP id
 d75a77b69052e-476b7ade14dmr390451cf.21.1741795573844; Wed, 12 Mar 2025
 09:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
 <848301db8f05$a1d79430$e586bc90$@samsung.com> <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
 <Z9Gld_s3XYic8-dG@infradead.org> <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
 <Z9GnUaUD-iaFre_i@infradead.org> <CAJuCfpEpWQV8y1RKb3hH+-kxczTUvpvCBNNzGJufsAxpkhB4_A@mail.gmail.com>
 <Z9Gty3Ax-2RslqDX@infradead.org>
In-Reply-To: <Z9Gty3Ax-2RslqDX@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Mar 2025 09:06:02 -0700
X-Gm-Features: AQ5f1Joz69JkjpPsTbZTRmJZtQx_aT9cYAZCenCDm6y3j32d7IR3YQveqxicKU4
Message-ID: <CAJuCfpHG9EWAC9p7hcOH6oPMWMMSDr91HDt7ZuX2M7=j6bxuGw@mail.gmail.com>
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
To: Christoph Hellwig <hch@infradead.org>
Cc: Sooyong Suk <s.suk@samsung.com>, Jaewon Kim <jaewon31.kim@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	spssyr@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	dhavale@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 8:52=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Mar 12, 2025 at 08:38:07AM -0700, Suren Baghdasaryan wrote:
> > I might be wrong but my understanding is that we should try to
> > allocate from CMA when the allocation is movable (not pinned), so that
> > CMA can move those pages if necessary. I understand that in some cases
> > a movable allocation can be pinned and we don't know beforehand
> > whether it will be pinned or not. But in this case we know it will
> > happen and could avoid this situation.
>
> Any file or anonymous folio can be temporarily pinned for I/O and only
> moved once that completes.  Direct I/O is one use case for that but there
> are plenty others.  I'm not sure how you define "beforehand", but the
> pinning is visible in the _pincount field.

Well, by "beforehand" I mean that when allocating for Direct I/O
operation we know this memory will be pinned, so we could tell the
allocator to avoid CMA. However I agree that FOLL_LONGTERM is a wrong
way to accomplish that.

>
> > Yeah, low latency usecases for CMA are problematic and I think the
> > only current alternative (apart from solutions involving HW change) is
> > to use a memory carveouts. Device vendors hate that since carved-out
> > memory ends up poorly utilized. I'm working on a GCMA proposal which
> > hopefully can address that.
>
> I'd still like to understand what the use case is.  Who does CMA
> allocation at a time where heavy direct I/O is in progress?

I'll let Samsung folks clarify their usecase.

>

