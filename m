Return-Path: <linux-kernel+bounces-357279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2467C996EE5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FA61F22581
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0521A3020;
	Wed,  9 Oct 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHZbORjr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E01A257D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485792; cv=none; b=eigYOhMHczXkZlPFIvzDcx3M9UxMh08C4r0wLBbeBSTc2QXvmshoRSZwIPipfiVD7YTKINOD6zKzWYORQeoPXyh6ARIT6C7CoDg0cQz/+lbiPPkIHWBc2YT/cWk0oqKF+sTyrIhu6EGJ+9bj4xAZq/vuHdQsS2lw4NL900yyATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485792; c=relaxed/simple;
	bh=/tgJyGOWgs44BJBgryDmR2dJiQ41bYyC9nITu+aA4RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sl9g2RDdIirmcss6/g5GAi1TFsCTBwq6rf9oQiG0dP0t/NTxGMQ1heLLbcodDLGZsCNPXHpstkmtkFL4DqdRm1GvP4clzirWeoqtMc/G5Tjp/80a4ewDG9bv1w44URZzIbVt9JlzC8PZql27N/rEzHYxhp42kRM/zEUsFtI5a2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHZbORjr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728485790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PLE7VP4A55O5HT6SFbDpqUQK1BXhXp/AsPnei2699E=;
	b=cHZbORjrpJ3flqYhRUUu2I8gVE7iRQ68PevKK/c+AFy9Av21HUZh8ASCTWccy0pm+Rjs/e
	/fiJKm+k5w2O8oxK0IIbf6FNdVr0cRezlGdPGcsX69CJGW93mU0G9fFadQvdat1hUNcJ5m
	y4OMITPS0jPGxm6JL109WSC0tN7L4RM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-WgjtPOBmNgissldCvSLocg-1; Wed, 09 Oct 2024 10:56:28 -0400
X-MC-Unique: WgjtPOBmNgissldCvSLocg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fabce3125fso54950741fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485787; x=1729090587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PLE7VP4A55O5HT6SFbDpqUQK1BXhXp/AsPnei2699E=;
        b=a2X/KPDLPEVvwbxakY9CnohjHdRlxtr8KAkNNJbQtklkURgnwhPRvVIPtLYGjQaDnc
         DIydcsWxD4mkJBtvWr8JhCk04qElHvs5jgba5yOIXROXVxmg8M/ZOXQ5Jh+am+Nvpilv
         cSPrfsKCFGNby9MenZFkwkVPgCF3ugQR0jXaNytSF6JFjqhhvpris2xMyTus1lli0RQD
         AP6/+gQNqUH8zYIPh4LTvY+uxEG9VcOobSAZQ4xnamE2N/9Xfmd59vpP5g+3tOqtqXaG
         ovLH1dgR6cXHjLIjA1DmAVkhGtyiJx3oyQm3fqKxviYBPuQGyrSaw4OleRXpGWYk6W4d
         CC9A==
X-Forwarded-Encrypted: i=1; AJvYcCWelh4OTcsjzhf5fAIlJ2H4aKmCHevRQKbrKx+7hRQ4rRYSehKK3mv0IP5Tw7t0+RMTd3UNdsMYyfs/EqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzlu9Uxq4pZbW7NKscnS2x2biD3Qd+N+am1wYeKRHIviw4LgiJ
	vMbPOmUc9B6PIx5CMBQBQ/scm6fYvLZoR15P26Y+Or4iu+yF8uIGDJtW7zNY1TvMztH+9hTXQcR
	WaQX9WliOlbSCLQFsFuECZS2CBF6uLL7R2hNx3+gINHJLZ1zaFH6W2YwFXWn/Ei45XQR15JZ4cu
	rblSVwc1LMQzcrt8EBv+0oNJ7yIYVP7o1BqjUG
X-Received: by 2002:a2e:bea3:0:b0:2fa:e658:27b4 with SMTP id 38308e7fff4ca-2fb18720a67mr19369011fa.4.1728485787102;
        Wed, 09 Oct 2024 07:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzmz6GlJFxJZGY+qLLAzphRbOgwssQ5wLeuGH+fl8u7i2WGipZw80Xr8tyG5lV1AvCAzvO6tH6a9X0aOIQE5o=
X-Received: by 2002:a2e:bea3:0:b0:2fa:e658:27b4 with SMTP id
 38308e7fff4ca-2fb18720a67mr19368761fa.4.1728485786705; Wed, 09 Oct 2024
 07:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003151435.3753959-1-aahringo@redhat.com> <20241003151435.3753959-5-aahringo@redhat.com>
 <ECD4A28B-9987-42BC-91DC-8DED8CAEED21@redhat.com>
In-Reply-To: <ECD4A28B-9987-42BC-91DC-8DED8CAEED21@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 9 Oct 2024 10:56:15 -0400
Message-ID: <CAK-6q+h4rsitB5C-dh=gpF5wG_1P2M=qT0wSVhTjLjkHLEsXsg@mail.gmail.com>
Subject: Re: [PATCH 4/4] nfs: sysfs: use default get_ownership() callback
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, linux-nfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 4:09=E2=80=AFPM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 3 Oct 2024, at 11:14, Alexander Aring wrote:
>
> > Since commit 5f81880d5204 ("sysfs, kobject: allow creating kobject
> > belonging to arbitrary users") it seems that there could be cases for
> > kobjects belonging to arbitrary users. This callback is set by default
> > when using kset_create_and_add() to allow creating kobjects with
> > different ownerships according to its parent.
> >
> > This patch will assign the default callback now for nfs kobjects for
> > cases when the parent has different ownership than the default one.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/nfs/sysfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> > index a6584203b7ff..b5737464b892 100644
> > --- a/fs/nfs/sysfs.c
> > +++ b/fs/nfs/sysfs.c
> > @@ -27,6 +27,7 @@ static const struct kobj_ns_type_operations *nfs_netn=
s_object_child_ns_type(
> >  }
> >
> >  static struct kobj_type nfs_kset_type =3D {
> > +     .get_ownership =3D kset_get_ownership,
> >       .release =3D kset_release,
> >       .sysfs_ops =3D &kobj_sysfs_ops,
> >       .child_ns_type =3D nfs_netns_object_child_ns_type,
> > --
> > 2.43.0
>
> Hi Alex, if I understand this correctly, this patch just punts the owners=
hip
> callback up to fs_kobj, which, because it has no .get_ownership is just
> going to be the same result: root.
>

Yes, from my understanding this has to do with user namespaces and
being able to write to the related sysfs/kobject files?

> Does this patch add value?
>

For me no, but it is there now as default and I think somebody
probably forgot to update all the other users that created their kset
in a more low-level kind of way.
I think the whole "transitioning process" to make the same things with
namespaces created under root vs user is still kind of still in
process.

I am not sure if any of the nfs userspace namespace aware tools are
also limited by other things that require additional changes to do
something else as a "normal" user.

For me it's fine to drop this patch series and if somebody wants to
make a user namespace working with nfs tooling can come back again and
find out such patch might be necessary?

Thanks.

- Alex


