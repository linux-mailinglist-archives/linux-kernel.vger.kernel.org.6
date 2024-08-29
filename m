Return-Path: <linux-kernel+bounces-307126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF99648B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15301C22D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332C41B1404;
	Thu, 29 Aug 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LM3hr3H+"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F61B012C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942385; cv=none; b=u26uwNgU88dVnzoIWOfJNEUq7CyuTd44UiWzTqEUfgUSFnWmswjfoaZBm888R9tr2cuKxBPoUe04XkaU29SBQv4/0Ueip++n98Rd5lH/P2ee1v2aBTjSiGGrQ1Cg05PQloLc3R++uzySR9eKeesh6BE4LenT6BHH3/tuyzD+hj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942385; c=relaxed/simple;
	bh=cp+zB7tKJc1mu7PWarcDKT9nIFFxk2Iar1il4LvBW60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj2k8lUzgFj4QxnqOsKLrxkoKn7UxWA+JdGs+uLpa/e+5iFnoo/2YcBF3xHPBpQ+te9kU7x3dUlhHP0mxr/nSRW4KkrDAWX/uYdI+TA2ghhK1UwzYW7evCZPBqhomt6c76kn/6/dRi2LjwUY9mtRwgdmzIvmk65FJITTOXi8oEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LM3hr3H+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 72A073F63C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724942381;
	bh=pkgEy8dNYJhtYxqa1erl6UdbvivyKkm8FEs1QuDoV2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=LM3hr3H+jvjiIlW1B4Z7mKj85KtgRuzFrj48ZOD2EYMbDMfueIZD/u99rIbnujGjU
	 4ArHJacK3DGyidZl3pEF1RoKhN6G7r/n8ls6p4/+2UsRU0iR7MpWVvd/MNhuu+wH45
	 7wtNFXeBbw9OqDH60Ej4qj3lP+g7HFGh5rx44Ienjc4OMWZMeOPhlWMV3o9Zt4HgAC
	 rZJJlPjjUHdFSYJ1D4+gOEQyndbH68acmdLGX1aZnSt1EWUjzrnFMDgMxwt8vUUPTD
	 AOm9fEqERxfZydHoZOWrf8LsKpjIi2/xqGrpKpSA5TxEHL79wMarPt9j1vL/aaFN89
	 n/4Cz9Uhu3oYQ==
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-70f5e0c3b79so919499a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942380; x=1725547180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkgEy8dNYJhtYxqa1erl6UdbvivyKkm8FEs1QuDoV2E=;
        b=ZyoE3xX+QIC1njUgsc9fQeJvLV0IzebMfAA3joXpLr0bE+ttPedPzuPYmJV0z0VgGs
         eW7v7ej8gfTsWwezVDWg9Bew+05c239ksVclehkp9OGbL2LxwfBAYOAnuJyp59kLmyV/
         cOTfFAWCh23Bhei8uIGFUsikPgj95A8grbitEJczqJj53EHKKkUFQtASzBe4hClVagv9
         qfUq6yalZgWBX9IHbiNNTefq16dVjGfaPmJWw+k+HvLflpRjkjs1AbptgLA3CJJQDvNm
         PRfWIUw09mZWtBBkdFHPATxDp/BZNV7OSRWTxW2MOebWu4t8b6qIFm3CEnKZ+DMa8iHu
         scVw==
X-Forwarded-Encrypted: i=1; AJvYcCXc1LEWotovy1XyOIP1Z8NggBUXl6aJtikBvWIIWAklNTIQYhhCDeRbh3L5uKIU4sHnQEmzOVFlTMEWJxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6EAgeZptPi6v0dKP1l/76/9D+gvSkY21BTa2Q2c+qyARAZcOV
	0bz3q0jAz5AJgPdW7RTARkTG0aFa+hzajmhvTwyjE65Nx3k6xWuUC5mMjb5B07rwjC9ona9ffDl
	Rul6SbMrPmls6AGyi9honJxR8ZRq6dD03qbt177alg76tCLFTEuSWkJanamz8+2KVaMJ76OepAU
	j3EludgdeHdYyJ2HNxbW7eTiT3LKkIYeHg87DeMo0TAEqbeecn4cHo
X-Received: by 2002:a05:6359:4590:b0:1ac:f577:db25 with SMTP id e5c5f4694b2df-1b603be30afmr414526555d.6.1724942380275;
        Thu, 29 Aug 2024 07:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3lTy/0SzqBHDrVLeVHxS/eYo35QPfix7ei9UvZx0OmEC+gCIjR8LYO4jLas5BaQdIa5J2xOT/6k3Kf7u/ABc=
X-Received: by 2002:a05:6359:4590:b0:1ac:f577:db25 with SMTP id
 e5c5f4694b2df-1b603be30afmr414523255d.6.1724942379980; Thu, 29 Aug 2024
 07:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
 <20240829-hurtig-vakuum-5011fdeca0ed@brauner> <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
In-Reply-To: <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 29 Aug 2024 16:39:29 +0200
Message-ID: <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:30=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 29 Aug 2024 at 14:08, Christian Brauner <brauner@kernel.org> wrot=
e:
>
> > Fwiw, that's what the patchset is doing. It's only supported if the
> > server sets "default_permissions".
>
> My specific issue is with FUSE_EXT_OWNER_UID_GID, which I think is
> unnecessary.  Just fill the header with the mapped uid/gid values,
> which most servers already use for creating the file with the correct
> st_uid/st_gid and not for checking permission.  When the mapped values
> are unavailable, set the uid/gid in the header -1.  Should be better
> than sending nonsense values to userspace, no?

Hi Miklos,

yeah, we have a discussion like that while discussing cephfs idmapped mount=
s.
And yes, it's a really good question and it's not obvious at all which
solution is the best.
( I believe that I have replied on that question already there:
https://lore.kernel.org/all/CAEivzxeva5ipjihSrMa4u=3Duk9sDm9DNg9cLoYg0O6=3D=
eU2jLNQQ@mail.gmail.com/
)

A main argument against mapping uid/gid values in fuse header is
consistency. We can map these
values in symlink/mknod/mkdir/create/tmpfile. But we don't have access
to idmapping information in
lookup, read, write, etc. What should we do for these inode operations
then? Send an unmapped uid/gid?
But then it is an inconsistency - in one inode ops we have mapped
values, in another ones - we have unmapped ones.

>When the mapped values
> are unavailable, set the uid/gid in the header -1.  Should be better
> than sending nonsense values to userspace, no?

So, your point is to set uid/gid to -1 for FUSE_{READ,WRITE,LOOKUP,RELEASE,=
...}?

Kind regards,
Alex

>
> Thanks,
> Miklos

