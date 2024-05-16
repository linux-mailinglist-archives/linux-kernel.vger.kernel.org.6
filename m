Return-Path: <linux-kernel+bounces-181309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDE18C7A42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90363B21ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6014E2C6;
	Thu, 16 May 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YrVEFcX1"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3E14E2CB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876629; cv=none; b=C5hq+CzzRjis40PzIM9rSusEYXW42/jwIbcEL7peTzJ9DF/pRyfa1Z7q6yfvRy/1ilDlX+Oz4R5LEQYlQfWTwdok3AmiizFi34zwqWCuv/Glqyt2GfwhIjn3SYWCdbucLLfAxT5Wpcl2IPPM3DVAk3OT67dyM678/Jb0yeObDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876629; c=relaxed/simple;
	bh=EZ7K4NzPBe6mgvmzDvgcN0o2b/NCkPR6fbfbuMDf1ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYzmPFzwaZQHPlsuByqxGkr0ALulpXBPfXqHM+2py7vvVQOucdMyM8zv1i59YRL5kJPC64KpyXh5nN1MrqZ9dvG4NtOFOxJXKlqIWWRhfX79liCd7BfCs/m6pXyY26wAR9Lf+D8Yspimkv6pfYPFDtd92eUqhnxm2JMDyhHyClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YrVEFcX1; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-df457d734abso1172525276.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715876626; x=1716481426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Razho7lHGpyap1v7dPaP5qSSISsR7xC/uw6XBXBKDDs=;
        b=YrVEFcX1ds2TXr7XCZ5Fzp/kPwxTFs9f70qlsY7O0tR1s3pk7uoWBqDKnlqm7TdF3A
         CgAwIvtI9e1GzcSarlc1Z1YlgQmC0ZX/v8R3TQANXQddY8NiRSDggauIINJbBJ0Iczpz
         lMA709PVe5DCeKreg6yFIWlK1ceEEOINXkvutC3N3ClIByNvxJHHktZbCppgco7VocEQ
         wcbaksZwQtESir+rhGAsuKMbpk+95a7W7ODxrfoo7Z614SZzjzJd3/W4Q+HyXywn49CG
         tAgvnx4f3fpDjXR4CBJfglcTrAXsLHgZsdGw70QYisGLauQc0yRzF2aL0Wrrb+Hi6q4K
         cgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876626; x=1716481426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Razho7lHGpyap1v7dPaP5qSSISsR7xC/uw6XBXBKDDs=;
        b=AHz7D7OZZaGBJXJNV/TmtN5horWbeVDf0ehe7facSkjwcyd+Yck7pRU+cQ94pDNCzB
         7orQXJIQAtM0x78njty7ISDhdspPGgJK/4Tl18fVzxZoCHMDJYzK1s5qYmq+xa6T6NHD
         HhA0JtBKolF7Ruo+NgkbDG2/fWjsbJEqqsfenx2xQcMMvkHx5rA8a/vDtIQ7b+pSKa03
         cq7g8kZHF48tHydQ2+p2Jdd8AUOdkAIL9rZ5sgiCEEhtdY6ls2GQKFAloNq/eVvIgRTt
         a+F055AwTfjV4dI+0+cRthWqqqoe9gjwhZTJkmd1xo64hiaj+v9U58Tj4JYQ73dk0zYE
         UrVA==
X-Forwarded-Encrypted: i=1; AJvYcCWg1xWeXbgjhXn1IPyH5i46TpoRNOTocOf0pxFXI3BUW9Jn8OY1tm86i9s529vFAyIVAQEKdFp2JZOm/CAdU7NDGufti6lxUGN93c3g
X-Gm-Message-State: AOJu0Yyog2sJHtPxu5AJoLJMqKffBqFltOJqn8reYRGjFxPJyGqU1H2X
	lb4ufmOBoXG9kTrA0Xeoiocz9EeMxH20Sv6RDCuCxHgGrxiG4FbRH6O9Mbe4k2wKk+ABd2KXo8s
	CIX5WiQfxa2pml+kUKBia0dmIYlc7cFdjeXtG
X-Google-Smtp-Source: AGHT+IEe/+V1bbRxOWwuKMKyGJUCyojV3Orv/M9T3K8RKww9g1UJdluzqC20c4o+/xI6Shg9MmTrzyhw8zyqu2pFzkc=
X-Received: by 2002:a25:ade7:0:b0:dcd:5c7:8466 with SMTP id
 3f1490d57ef6-dee4f3a9f30mr20073221276.44.1715876626618; Thu, 16 May 2024
 09:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
In-Reply-To: <20240516092213.6799-1-jcalmels@3xx0.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 May 2024 12:23:35 -0400
Message-ID: <CAHC9VhQ=nNPLRHF8RAMxArT1CESei+qYsnGse6--ixPhACAWTA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
To: Jonathan Calmels <jcalmels@3xx0.net>, Serge Hallyn <serge@hallyn.com>
Cc: brauner@kernel.org, ebiederm@xmission.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:21=E2=80=AFAM Jonathan Calmels <jcalmels@3xx0.net=
> wrote:
>
> It's that time of the year again where we debate security settings for us=
er
> namespaces ;)
>
> I=E2=80=99ve been experimenting with different approaches to address the =
gripe
> around user namespaces being used as attack vectors.
> After invaluable feedback from Serge and Christian offline, this is what =
I
> came up with.

As Serge is the capabilities maintainer it would be good to hear his
thoughts on-list about this proposal.

> There are obviously a lot of things we could do differently but I feel th=
is
> is the right balance between functionality, simplicity and security. This
> also serves as a good foundation and could always be extended if the need
> arises in the future.
>
> Notes:
>
> - Adding a new capability set is far from ideal, but trying to reuse the
>   existing capability framework was deemed both impractical and
>   questionable security-wise, so here we are.
>
> - We might want to add new capabilities for some of the checks instead of
>   reusing CAP_SETPCAP every time. Serge mentioned something like
>   CAP_SYS_LIMIT?
>
> - In the last patch, we could decide to have stronger requirements and
>   perform checks inside cap_capable() in case we want to retroactively
>   prevent capabilities in old namespaces, this might be an overreach thou=
gh
>   so I left it out.
>
>   I'm also not fond of the ulong logic for setting the sysctl parameter, =
on
>   the other hand, the usermodhelper code always uses two u32s which makes=
 it
>   very confusing to set in userspace.
>
>
> Jonathan Calmels (3):
>   capabilities: user namespace capabilities
>   capabilities: add securebit for strict userns caps
>   capabilities: add cap userns sysctl mask
>
>  fs/proc/array.c                 |  9 ++++
>  include/linux/cred.h            |  3 ++
>  include/linux/securebits.h      |  1 +
>  include/linux/user_namespace.h  |  7 +++
>  include/uapi/linux/prctl.h      |  7 +++
>  include/uapi/linux/securebits.h | 11 ++++-
>  kernel/cred.c                   |  3 ++
>  kernel/sysctl.c                 | 10 ++++
>  kernel/umh.c                    | 16 +++++++
>  kernel/user_namespace.c         | 83 ++++++++++++++++++++++++++++++---
>  security/commoncap.c            | 59 +++++++++++++++++++++++
>  security/keys/process_keys.c    |  3 ++
>  12 files changed, 204 insertions(+), 8 deletions(-)

--=20
paul-moore.com

