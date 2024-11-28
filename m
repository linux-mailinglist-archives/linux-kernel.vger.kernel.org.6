Return-Path: <linux-kernel+bounces-424980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473169DBC09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB67B2148F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CCA1C1AB1;
	Thu, 28 Nov 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPHqnloR"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3801BD9D3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732816714; cv=none; b=hVIUbDzpTuME/fjqDnZa+pHDwdGtf2NgGn7+5s3W+I6FKDMHLjtaoZd3V5AmrivN4+Wi9aOiapX1PDFYUkCzRolu6UmN0z+TlPE2TvAIVC6te/yfabHWExBECvRgreX4wUMbtPLlzx67Z8/kTzyi31KGGsd0iP4ZPDRCCHsYRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732816714; c=relaxed/simple;
	bh=T6RLN8HoPiYT3cM8ia7YAAZtHbp+Vo69fflIdtAi/MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qB1xlaNouWpWUkadhdHkbrjuJlFBWD6MDv+m1abz6e2U1f5XZ+kmta3asoRqNiaUYTzlOPkZoK9vww1cXhgi36hBrxtoAwSoiijoj9k03qAO6/uhhJFXoz440WdnyRZKuQeKrz7ehi8NCmkVadiq5UsxHLJOZC3iQq1XYJnAyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPHqnloR; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ef4a03052cso11689617b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732816712; x=1733421512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6RLN8HoPiYT3cM8ia7YAAZtHbp+Vo69fflIdtAi/MA=;
        b=TPHqnloRWE7JvjURnUxqpVtvVNwvspw4jexbH88vvKiUDfVID9fyVx7pa66SbREd/t
         d+B691PLaYyVVwfs9sR5Y4Nfmfr9pORK5EH4sYLFHMOdNl7nNejnsgb9oq3ljKSxnYUa
         aYIbEbSBnlChS288SHaPVwS1x0T55+jpcMccci+KaBjE/GvwzpizkBWOs7oruZjn7fuH
         7BAoiUCcmq5vAswv3rPnlPeCRcxZnV0f5j91iczhv97RjflNALc7TXk84D3nI/6qbwhZ
         RxB4mkT8M7qVwhmo0MqIY/6Lq7NyXsgIgYgk9D1NmZUMJYuN7DVMvpKGSjU88G7HK02k
         VdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732816712; x=1733421512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6RLN8HoPiYT3cM8ia7YAAZtHbp+Vo69fflIdtAi/MA=;
        b=ig3DOkb5JZcRGAoj8OnbJvYBAIzxo2RA9kxnjm3U9MSZjRZOX2p0VPn15BVJvaJJ2r
         JYR01XgzF00iZZ0x1yBX+J4f48jQLvLqH38KFeUwZrcGnEDDqme4RyQbQPX+wLaDcUzt
         EcRpW0wQpt3Q15V16PgS39K/mAd6MtlhZREK6aQm1jvo2dnvBBb1CMTIs3FoyIj8N8oD
         S1CLVqbAZcjcYgMYIpjVpi6owcUiMf8CVqc683I5sClixMK6DBQevmKrfpNT8xaX1Jw5
         Awvns3QqwwvvhBv9bgbbgt85AqZJsOhzTao7SM8JRip9hifGTppYPoxOuwDWvuVLKGE2
         qckg==
X-Forwarded-Encrypted: i=1; AJvYcCVl7h0bEophvShEYA3W0xgNlC8+aZnnt0JwXNKxeFPIaR0tdoG+Juw6xpTHWZOdsrKU8/UaMM+FYN+WwwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTntPldhN5/ZmgKE15xRosiClJNrXDo6MN3DmqK+amVBGKYkRU
	x8MyUuW/wjeXMMwvgo+K2UyXP9SDHQyKuJ8l/JL1yZ0YI3BZd4HEueWNVQTNc9E6AbfRHiHU4sv
	3UM43RC1dclErBeDS+0nGLRLgMrifItFnaPw=
X-Gm-Gg: ASbGnctCfRfRBUmva82nQZebx0TXbMEoksgGFEnlRZknU/L1tHdOnkwu0PXRFHdMHKw
	9dmqGbA5oj6BLwVpKgQLpeRMSQDM1dfCfxjoT89oC
X-Google-Smtp-Source: AGHT+IGqtQMx2ADzvHfeedR0IXoeNkzKLsvmqGsHgy19ZsJLIAZxEgv4vqJSui9pa4nfYEe/P+jKNPMf/jUw8eirlt8=
X-Received: by 2002:a05:690c:6e0d:b0:6ea:c928:771 with SMTP id
 00721157ae682-6ef37274fadmr112213167b3.28.1732816712033; Thu, 28 Nov 2024
 09:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
 <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
 <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
In-Reply-To: <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Thu, 28 Nov 2024 18:58:21 +0100
Message-ID: <CAHijbEV6wtTQy01djSfWBJksq4AEoZ=KYUsaKEKNSXbTTSM-Ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
To: Jann Horn <jannh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Re-sending the message below since I forgot to reply-all)

On Thu, Nov 28, 2024 at 6:46=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Nov 28, 2024 at 4:06=E2=80=AFPM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > In commit 158978945f31 ("mm: perform the mapping_map_writable() check a=
fter
> > call_mmap()") (and preceding changes in the same series) it became poss=
ible
> > to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> >
> > This was previously unnecessarily disallowed, despite the man page
> > documentation indicating that it would be, thereby limiting the usefuln=
ess
> > of F_SEAL_WRITE logic.
> >
> > We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRIT=
E
> > seal (one which disallows future writes to the memfd) to also be used f=
or
> > F_SEAL_WRITE.
> >
> > For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
> > read-only mapping to disallow mprotect() from overriding the seal - an
> > operation performed by seal_check_write(), invoked from shmem_mmap(), t=
he
> > f_op->mmap() hook used by shmem mappings.
> >
> > By extending this to F_SEAL_WRITE and critically - checking
> > mapping_map_writable() to determine if we may map the memfd AFTER we in=
voke
> > shmem_mmap() - the desired logic becomes possible. This is because
> > mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
> > have cleared.
> >
> > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > behaviour") unintentionally undid this logic by moving the
> > mapping_map_writable() check before the shmem_mmap() hook is invoked,
> > thereby regressing this change.
> >
> > We reinstate this functionality by moving the check out of shmem_mmap()=
 and
> > instead performing it in do_mmap() at the point at which VMA flags are
> > being determined, which seems in any case to be a more appropriate plac=
e in
> > which to make this determination.
> >
> > In order to achieve this we rework memfd seal logic to allow us access =
to
> > this information using existing logic and eliminate the clearing of
> > VM_MAYWRITE from seal_check_write() which we are performing in do_mmap(=
)
> > instead.
>
> If we already check is_readonly_sealed() and strip VM_MAYWRITE in
> do_mmap(), without holding any kind of lock or counter on the file
> yet, then this check is clearly racy somehow, right? I think we have a
> race where we intermittently reject shared-readonly mmap() calls?

Apropos race, some time ago I reported a way to get a mutable mapping
for a write-sealed memfd via a race:

https://bugzilla.kernel.org/show_bug.cgi?id=3D219106

>
> Like:
>
> process 1: calls mmap(PROT_READ, MAP_PRIVATE), checks is_readonly_sealed(=
)
> process 2: adds a F_SEAL_WRITE seal
> process 1: enters mmap_region(), is_shared_maywrite() is true,
> mapping_map_writable() fails
>
> But even if we fix that, the same scenario would result in
> F_SEAL_WRITE randomly failing depending on the ordering, so it's not
> like we can actually do anything particularly sensible if these two
> operations race. Taking a step back, read-only shared mappings of
> F_SEAL_WRITE-sealed files are just kind of a bad idea because if
> someone first creates a read-only shared mapping and *then* tries to
> apply F_SEAL_WRITE, that won't work because the existing mapping will
> be VM_MAYWRITE.
>
> And the manpage is just misleading on interaction with shared mappings
> in general, it says "Using the F_ADD_SEALS operation to set the
> F_SEAL_WRITE seal fails with EBUSY if any writable, shared mapping
> exists" when actually, it more or less fails if any shared mapping
> exists at all.
>
> @Julian Orth: Did you report this regression because this change
> caused issues with existing userspace code?

I noticed this because it broke one of my testcases. It would also
affect production code but making that code work on pre-6.6 kernels is
probably a good idea anyway.

>
> > Reported-by: Julian Orth <ju.orth@gmail.com>
> > Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=3DU7s=
4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
> > Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behav=
iour")
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

