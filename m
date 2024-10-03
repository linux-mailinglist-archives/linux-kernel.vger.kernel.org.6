Return-Path: <linux-kernel+bounces-348461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BD98E800
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2DB1F25D74
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FCD1401B;
	Thu,  3 Oct 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEVayczP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB609479
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917699; cv=none; b=H1/X8oNf22PXXvbsBHBvyDpkEXR6/tZLOvEdjzQ9alFeuKt7Y4eQiw6mkJrXLhX+lGEPjWMlsffsPkL+Ke6PWmGXWKNEc49rOTO3zRUcv+JbE+jN2GM2TFYMqlqU0xF36uG6wT+7AMZiF3qZd/5L82iDl/pU0Aq1qI4RcKR1hc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917699; c=relaxed/simple;
	bh=+sPP1SjcipQTOOMvkAWvmegFg+ZNySyVNo6IDNNi0x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/arSLyU7GYSOvVDqMToixgKGSc5fXJf6RZ/VdjC1fvZuGMV6cW3JiGE4K2w3Ut3rMds38BdQxksYsffKbHf48UjjRZN5yqm3odlCafVljHlt2DGx8g29OvFpKFQe4XiAXvGltoKSQ7xgqJfqQ1gqQIXtLQ0fCl44pHxChOKhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEVayczP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727917696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TePBjAcl7OVgGhBRXtKyMh/Mzzfydzh6ym9fI03+LkM=;
	b=QEVayczP8rAWQQxQXGYlKGqJjFgENkIPExMWWGv5uQbc9pcvsSDs11a90ZLk7jcgR5wYBP
	TC56o2jrJhoryRHkiOmIk+A8Hffhadh1U6Og+GOsqVCFc142BDLj2rJIyVXXtJCRc2ljxu
	K4eWa3U5te/Ri9cA6LYiC6cNHT5dIRk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-1HB8pOBRPQulZKalVaCS3Q-1; Wed, 02 Oct 2024 21:08:15 -0400
X-MC-Unique: 1HB8pOBRPQulZKalVaCS3Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7acdd745756so72195285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 18:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727917695; x=1728522495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TePBjAcl7OVgGhBRXtKyMh/Mzzfydzh6ym9fI03+LkM=;
        b=MvDDl5YkApX9eM6G94Xt08gpUbwLz2RUiAGzIAUX8j4ZjlpiQ4i6NYBGkvp9s56uCD
         ejiK69z2PRJstjveYTUom7E7+TdhYU6uTtZ72pUtlhZ5GKgmQI8Q4RAXE51Q6U6c+QqM
         P+YK/MFbbq4z1pMH6mSt0Y0Bv+Eqb2CH1GH5eJiRjsSi0EUvGJLAZn0M/0D37+B6OZIK
         YzdZzSl3sunf6cII0YhEmOg9NIFVTtRzJRO1oglB3iTZji5jW7TBQU01lFEE5U17SPuS
         E6sRgtmMdf9Ye+NaiHydRA2QfmBVEemyi05hLBJ3aP/LaUF5/6H73HOKHgI6enmd8RB5
         AU2w==
X-Forwarded-Encrypted: i=1; AJvYcCUcg+uEzWjSg2NLmJIkeYpezd8I9bzLbzKfUdQgFEz3s3158m0tPlpA9kZNYmGa8MyZ5SUIooV22dJlC6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9eFcnB92Cts1SaLi1cpniDDKSP8I5GZx6MQaptA/rEhKFkih
	I5tv/tnQYbuA6gofR7pHKa8OoiOfCScbZjqYrltTPzQ+Ax1jPyOLdpqAlbxgTeWFpmE96Z+DOis
	Xc8p5sKfbWSa31S8AGbn37Lz65bBEdrmn1+Ybp/Ty/Yjh9ma1f35JOqIpMxrkHjjBfUEzhaX9Lu
	ayq5iuWInlOwgSzp1diMi+jRGArnz/zDnbRdAs
X-Received: by 2002:a05:620a:2991:b0:7a7:deb7:6d9a with SMTP id af79cd13be357-7ae626ac2cdmr752778885a.11.1727917694890;
        Wed, 02 Oct 2024 18:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3zAy2xiIv5VdrtML9L302HbfvRYyL/skRauQ08ks7vZMHpbCH+0rw4c3QWRwhdytILtpZUG3YHa4pftxRd8Q=
X-Received: by 2002:a05:620a:2991:b0:7a7:deb7:6d9a with SMTP id
 af79cd13be357-7ae626ac2cdmr752776985a.11.1727917694560; Wed, 02 Oct 2024
 18:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002200805.34376-1-batrick@batbytes.com> <CAOi1vP_Y0BDxNR9_y_1aMtqKovf5zz8h65b1U+vserFgoc4heA@mail.gmail.com>
In-Reply-To: <CAOi1vP_Y0BDxNR9_y_1aMtqKovf5zz8h65b1U+vserFgoc4heA@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 2 Oct 2024 21:07:48 -0400
Message-ID: <CA+2bHPYsoZCJJG_s3u6Q0TWoAxYPZsVsQm=zHh7LRjCq5RWcyw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix cap ref leak via netfs init_request
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <batrick@batbytes.com>, Xiubo Li <xiubli@redhat.com>, 
	David Howells <dhowells@redhat.com>, stable@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:52=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> wr=
ote:
>
> On Wed, Oct 2, 2024 at 10:08=E2=80=AFPM Patrick Donnelly <batrick@batbyte=
s.com> wrote:
> >
> > From: Patrick Donnelly <pdonnell@redhat.com>
> >
> > Log recovered from a user's cluster:
> >
> >     <7>[ 5413.970692] ceph:  get_cap_refs 00000000958c114b ret 1 got Fr
> >     <7>[ 5413.970695] ceph:  start_read 00000000958c114b, no cache cap
>
> Hi Patrick,
>
> Noting that start_read() was removed in kernel 5.13 in commit
> 49870056005c ("ceph: convert ceph_readpages to ceph_readahead").
>
> >     ...
> >     <7>[ 5473.934609] ceph:   my wanted =3D Fr, used =3D Fr, dirty -
> >     <7>[ 5473.934616] ceph:  revocation: pAsLsXsFr -> pAsLsXs (revoking=
 Fr)
> >     <7>[ 5473.934632] ceph:  __ceph_caps_issued 00000000958c114b cap 00=
000000f7784259 issued pAsLsXs
> >     <7>[ 5473.934638] ceph:  check_caps 10000000e68.fffffffffffffffe fi=
le_want - used Fr dirty - flushing - issued pAsLsXs revoking Fr retain pAsL=
sXsFsr  AUTHONLY NOINVAL FLUSH_FORCE
> >
> > The MDS subsequently complains that the kernel client is late releasing=
 caps.
> >
> > Closes: https://tracker.ceph.com/issues/67008
> > Fixes: a5c9dc4451394b2854493944dcc0ff71af9705a3 ("ceph: Make ceph_init_=
request() check caps on readahead")
>
> I think it's worth going into a bit more detail here because
> superficially this commit just replaced
>
>     ret =3D ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
>     if (ret < 0)
>             dout("start_read %p, error getting cap\n", inode);
>     else if (!(got & want))
>             dout("start_read %p, no cache cap\n", inode);
>
>     if (ret <=3D 0)
>             return;
>
> in ceph_readahead() with
>
>     ret =3D ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
>     if (ret < 0) {
>             dout("start_read %p, error getting cap\n", inode);
>             return ret;
>     }
>
>     if (!(got & want)) {
>             dout("start_read %p, no cache cap\n", inode);
>             return -EACCES;
>     }
>     if (ret =3D=3D 0)
>             return -EACCES;
>
> in ceph_init_request().  Neither called ceph_put_cap_refs() before
> bailing.  It was commit 49870056005c ("ceph: convert ceph_readpages to
> ceph_readahead") that turned a direct call to ceph_put_cap_refs() in
> start_read() to one in ceph_readahead_cleanup() (later renamed to
> ceph_netfs_free_request()).
>
> The actual problem is that netfs_alloc_request() just frees rreq if
> init_request() callout fails and ceph_netfs_free_request() is never
> called, right?  If so, I'd mention that explicitly and possibly also
> reference commit 2de160417315 ("netfs: Change ->init_request() to
> return an error code") which introduced that.

Yes, this looks right. To be clear, we were passing "got" as the
"priv" pointer but it was thrown out when 2de160417315 changed the
error handling. Furthermore, a5c9dc445 made it even worse by
discarding "got" completely on error.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


