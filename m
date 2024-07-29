Return-Path: <linux-kernel+bounces-266035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC8593F998
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904251F22D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5A15B13C;
	Mon, 29 Jul 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WHw1wrHq"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F01494CA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267371; cv=none; b=lTSfztEubDiKkBat/+0XUrAxC0/pTa31DQhJFkYTFG3d9jbZ1PEg8qQCbXi3rHG1YltsoZCvF2FBN6vx2V35DpTHNH+8+rWTCyj9K857SSKqWc6LJe5UEiyX0PMZVeYVn3stHsGkaAJfhpP6C4Q6vYO1+25MWXv/CVoMATX6NQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267371; c=relaxed/simple;
	bh=ocxWEMAgXfcr9s1eHy+pgOW2BSzmq6AtWSWNCH4xXoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kmm5Zw5kpguRviSKTH6ZTKJ9G/Ue9we96VHn1ZSsWyE+vCcxMw2El9l4hr5HFvBLKHbI8xgA69zrhWl8cOkbz1arU2ooVO6nfre9Ly0i1sSkcm5NR89sYFCpqZaefEjH9NWG08/VhTtQ9YBTK0G03RNKOrxUPzKSyXiki1m4Al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WHw1wrHq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso477470766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722267367; x=1722872167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocxWEMAgXfcr9s1eHy+pgOW2BSzmq6AtWSWNCH4xXoI=;
        b=WHw1wrHqBPJ+zZ0PwHxGHDESdNdToLjkHGKhRGIlNmWtyaazePZwF/EDa2wM53kczX
         3Jc1bXKHbopbQHJuokvrgQf2087o0rmT8Xh830J+PjbggoJSEFKLPMUx8zBTWPMZ4p9I
         Kp4WnnsoCZODr1zavcojUuoX+1BDrRVYJRmfcg/cjK6EUWuDso8j9i41s2wcteSOszeR
         tRBEpRBKp7eVHZrKx66GoAxuZe7nYALw8xvyLDfhiBsQSk0kUgnGjOftvpf0TiWtO3B7
         rvzQHFs9w5pXIV3TYWxKQwmd3gIxwV+o/RSVS2zXj9Zq5IXo0dv3wqG/XFNAU1aw4eNy
         0jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722267367; x=1722872167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocxWEMAgXfcr9s1eHy+pgOW2BSzmq6AtWSWNCH4xXoI=;
        b=hyE3ElFM4SYlgAV93Otkef0oalLeHgQTqvxDe6/a3hDxYJK7tCthyOyTUKpd4moW0J
         I4ILtA35SQ8DAu5Tea8GKKTwR4Xf7vckDkL72SKC4lj6bTeca2vi26mjDr4RTAh0yz2P
         XLDfFHmgkl5OXKh6VMxPHvYOyI9QFrzt2ut/uH61/pQzTaHvphop9rzlzeImXScivFlo
         +DFzrqwRQTVF+feHCgCqL+LPUdz9xClbiIoJr7lLlRmzVCV5FwrZHOLG4DDR7PEKJqWD
         cgaIkOybYh1iwBHzNIWuGAb12vFV66XoiOv8K89uQljrZIepcECTOMrShw6DbQUrDKzv
         0cuw==
X-Forwarded-Encrypted: i=1; AJvYcCWh0bG+MMHkw9lQtZUahH81Cf1Yy6yR535LL9w2GN19YSw+HZex3KU0yoId/Rc6ms0KtSpkQCU48dEljKyFDSu+DMTNmwk5WfkJ379w
X-Gm-Message-State: AOJu0YwXFke4ae7FplMOiOBsbgPcUjN0AvCP4M6erL8S9DWRP9OrSng/
	KEyroLUtTmAmxo1c52SJTvRJASj45lgMH2Pyz2VSnq4H+FKgFr3cQj6qnbsoxOt9tlWtLAIr8NA
	xfMwed5k4ql6C4jBCSZw5MZrJfhX2new5hdv4SA==
X-Google-Smtp-Source: AGHT+IFKGWOaf1XB1ZjzjA0Mr1+q4/qtfehNJNYG4kNlUncpGLDTuedMctPdToKvZVjv5J+J5MEk7dLKDeTfIxGpGLI=
X-Received: by 2002:a17:907:7205:b0:a7a:9ca6:527 with SMTP id
 a640c23a62f3a-a7d3ff7cce8mr575337166b.8.1722267366583; Mon, 29 Jul 2024
 08:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com> <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
In-Reply-To: <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 17:35:55 +0200
Message-ID: <CAKPOu+8fgsNi3UVfrZQf9WBHwrXq_D=6oauqWJeiOqSeQedgaw@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, willy@infradead.org, linux-cachefs@redhat.com, 
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, xiubli@redhat.com, 
	Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> Either way, you can add this to both patches:
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Stop the merge :-)

I just found that my patch introduces another lockup; copy_file_range
locks up this way:

 [<0>] folio_wait_private_2+0xd9/0x140
 [<0>] ceph_write_begin+0x56/0x90
 [<0>] generic_perform_write+0xc0/0x210
 [<0>] ceph_write_iter+0x4e2/0x650
 [<0>] iter_file_splice_write+0x30d/0x550
 [<0>] splice_file_range_actor+0x2c/0x40
 [<0>] splice_direct_to_actor+0xee/0x270
 [<0>] splice_file_range+0x80/0xc0
 [<0>] ceph_copy_file_range+0xbb/0x5b0
 [<0>] vfs_copy_file_range+0x33e/0x5d0
 [<0>] __x64_sys_copy_file_range+0xf7/0x200
 [<0>] do_syscall_64+0x64/0x100
 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

Turns out that there are still private_2 users left in both fs/ceph
and fs/netfs. My patches fix one problem, but cause another problem.
Too bad!

This leaves me confused again: how shall I fix this? Can all
folio_wait_private_2() calls simply be removed?
This looks like some refactoring gone wrong, and some parts don't make
sense (like netfs and ceph claim ownership of the folio_private
pointer). I could try to fix the mess, but I need to know how this is
meant to be. David, can you enlighten me?

Max

