Return-Path: <linux-kernel+bounces-215438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141829092B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A550285F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50071A0B04;
	Fri, 14 Jun 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="USXno9Zr"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1C49638
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391984; cv=none; b=Eup4GrqsydwNjLqvqKQ4+yrrLDIDdbpJFyz3LNCUFumFua/Df7ZGost6DYiZAOVeSzHYZjYlBFjMWgIJrKGC7dG1kOZAp3lI+JzwwL0VYevBwRWy2pdlg6L3uXbSQPYZE8VHwd0EmGTvwaVqNvBKudKox5Zt17735mDbvBB5LBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391984; c=relaxed/simple;
	bh=c9Ux3bqzl9GHyPBD1TY4m76hVvQG7ocXz2ANNIGVf0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6RDT+pTHz6VZkVHk9BADah1EusmpL9tqzYz/mJD8jtOGfvnx4ysj5AouZ3c+Kqo4M0uY9VdrRIR2jaFfxrV0ld+Nse0/spcjUTWTvraCMix/3OsbvE21fcBFveTIFVME3oWIkfIIR6v7ORSIZfDsHSAzEDYF/WAgbF9HmZtGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=USXno9Zr; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-24c9f91242dso1048386fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718391982; x=1718996782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0TJEOcNJd1xwR22jFo2JVoKZiKDMvsOPZwNxtWEx8s=;
        b=USXno9Zre4AasGZYhM01wrmwdn9uyNhgY/3Nb6+Pg/U1mmRcJkb+WKK4j2CwH6+B1U
         9v4Tsd6nnBhhceWt2T14yWvIeEB9HWhMrd4W5gice0+/NaFkK85DGMkGI4lJS0++hGAs
         z26qhhm/LuYZSliTFT1mCDj+djBYCXoNx96rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391982; x=1718996782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0TJEOcNJd1xwR22jFo2JVoKZiKDMvsOPZwNxtWEx8s=;
        b=Y9QhnqYmasiE4vDI87VOv3SBC564rm5JcazruYoDwQ1QmiaEbjdtP8si2oEyGso5s6
         CqmmfaFjc2cxY7u5lAy31HakADLwcLu99qFgfrpzF74L0B6yQ+2CZejT4nsOtbOVLkuH
         x/h9TsgTCbCzZrRXjyFhK7bixOICOclbrTfRQkG7BHUdEyBRmWqDrme2niqYGEu9N9Kx
         ARkq1FxTqzmN3GrHEsYU6i+Ab9WQghQyXxG+eSk83ItaHOg7dncEYzt2KSqT2+mzyQhV
         DLMtNKHY0tcMlQHpL1A8lPEPA2jGYc2pqIY08kEs+o+Xb6d2kwPtyJlS1d61x6ayFzMU
         oyIA==
X-Forwarded-Encrypted: i=1; AJvYcCVDmRWoV22CIJ5OO/RVLfrKg7W0uKzO0BmR1Pl5OC+6XGEtPwHiVjktENRsy5ws9XYaRwZJt5dHXmkHVCQzP7IEpHUPCOOv9bA+hBDT
X-Gm-Message-State: AOJu0YzfA1QbuisqIeK5XVtVutsGCSkC86DGqRgqWiml3Sxb30Mxojj3
	Aahi/KjsuSMKNrn0PtFUdnBWuiGWxvT5MNIYS+VxDn2/lbNV5ZX5ACFZvFPLAlrblv6uRPONqBx
	GqIhI2x4L7+PGBX10QMoEh1OfM4+/1S6fJ+8G
X-Google-Smtp-Source: AGHT+IEnYyWlUFMDzpA+R3mwPoXBRpl06vTGYRw15zdN4N400M20GylA3GpdGaiw8FmgosrqAA9ZzqFzJktTzXHlSnM=
X-Received: by 2002:a05:6871:3412:b0:24c:5bd5:1934 with SMTP id
 586e51a60fabf-25842b79581mr4126132fac.39.1718391982489; Fri, 14 Jun 2024
 12:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614182327.752156-1-jeffxu@google.com> <20240614182327.752156-2-jeffxu@google.com>
 <CAG48ez0c3PyXhaW78tCXW0_e45YJtfOGj=shKZrLu5RZJ66vGg@mail.gmail.com>
In-Reply-To: <CAG48ez0c3PyXhaW78tCXW0_e45YJtfOGj=shKZrLu5RZJ66vGg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 14 Jun 2024 12:06:10 -0700
Message-ID: <CABi2SkXrK5TkQZOvekjevQiMFhPWrVXyEAVRkjs5m6Xg8ncDXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] /proc/pid/smaps: add mseal info for vma
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, sroettger@google.com, rdunlap@infradead.org, 
	david@redhat.com, adhemerval.zanella@linaro.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 11:43=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> Hi!
>
> On Fri, Jun 14, 2024 at 8:24=E2=80=AFPM <jeffxu@chromium.org> wrote:
> > Add sp in /proc/pid/smaps to indicate vma is sealed
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/filesystems/proc.rst | 1 +
> >  fs/proc/task_mmu.c                 | 3 +++
> >  include/linux/mm.h                 | 5 +++++
> >  mm/internal.h                      | 5 -----
> >  4 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index 7c3a565ffbef..400217a1589c 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -571,6 +571,7 @@ encoded manner. The codes are the following:
> >      um    userfaultfd missing tracking
> >      uw    userfaultfd wr-protect tracking
> >      ss    shadow stack page
> > +    sp    sealed page
>
> Nit: Why "page"? The sealing is a property of the VMA, not of the
> pages mapped into it. Maybe "sealed area" and an abbreviation like
> "sl" would make sense?
>
ok. Maybe just sealed for short:

sl  "sealed"

Thanks
-Jeff

