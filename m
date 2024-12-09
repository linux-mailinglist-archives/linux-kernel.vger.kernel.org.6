Return-Path: <linux-kernel+bounces-438096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F239E9CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3E9282A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911BC14A60F;
	Mon,  9 Dec 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="g2G2BVnp"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F914D283
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764350; cv=none; b=LKkFgfXuX1UjIpChujWIGOFxnUPUCmW9BL1GoD7GNl66m7u4G/meRqdcW/rIrvEfh2XG/8RcoMrjCSwc3CjSGm4sdjY684maJsROgoT4RY4ucSMuWfHMRCTINwE2MbDh6BXkyPYXp3YY/MB8XjIcF0Z+gGZ/E2rsBiUC6zUYr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764350; c=relaxed/simple;
	bh=cOzd8+7H/GN0o1zps3NAZOOuJnioPUq6sgRKP597Lz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQnuCC+vyFgGX3z6mybNjk/I2r2kj1rwJ7hwmhGh1v8X7mpwSGhbrcFm15Audhxcoko1cuXXLXvtCCzpkT7jTVTOQ7PsJywb8DPtRXEYIeKhZOzI1vKkp3zP1QInarNhr4sgrJtTF1fjfD2yEuYN07pVoLWTcU/3GKyIjMglykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=g2G2BVnp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ec267b879so891312966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733764347; x=1734369147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaWyuI+1zfgRvLafZXYRvDDVpYcT2uiI1jU4yIWvFaI=;
        b=g2G2BVnp/ZCX9zQOKJVBL4UQ7g1WMuWzYTZ3VIC8OvHT/E8XJpCT2fzbglAUes1nAj
         3MuC2xtpwLl1IE1SzKEs+P+jK5vbpsfeVQSL+xso9TJ5mUAAUh8A6GKEp82jshbFLwVZ
         WC6vr3X/wcrBQU85U2ah/SE6z6UrXhh6Mas7LaEnpGJWvflQ6N9I8dK0pSSsXN2r7pBd
         0KvrPzgX0mAtbSmaNtL2YN4yUeeFfUFs6fRlFnPQhOeQ0JIS02nz2XbZuxvT3zq1J3RN
         aOUioIf+DuYgpW8J5WkSgg0foDmx4ZvClvILOLG3encu5W97MVTXHgRv/iLWif3J5yjB
         oYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764347; x=1734369147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaWyuI+1zfgRvLafZXYRvDDVpYcT2uiI1jU4yIWvFaI=;
        b=cuTIoHf+ipswQhhFYKqKmxs9UeVSqSRGvTmhXvVNHCmPnTyd8z9DH6YGUWtEZA7UWW
         tMDicCZm77k6h9CaXMPsVyL8C4lNx5XCE5wpyf3uvwQuX1Fg4JJodC3dB3unCppPjhOz
         KXLpE254dzlsk9Hjth0t6SKbGbwERoVMDullf0d2rzFb8WH87IHSPqcNBfrAWAmtBHFq
         4M36JZOMN+j/WYXeDh2eREBQ/D6UiYA7F4XLxvzpHw/gRvNmpMsUzuymzVuKFAyrijVg
         tn9WexrlqeCKDiVbcsc92/3HWxvOrUXOOczr4r/6Ao37f1RSMugdj7iD3yOoopcewa3K
         7+cA==
X-Forwarded-Encrypted: i=1; AJvYcCVhNHllrq48J+2iGV48GpRJ2AocL5OkzEBfZmhsUNideo87OaS7OhecPBK/Sl2gyMGp7h3qRklErw24yvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypdCQodoCvT1IFws8Gn0AXAo8YZd8l5LmbdtaHu1uOFRaPIlZq
	i/6Yo5aFP1UVfXI9F1pfA3vAQNd0/3/Gfs1Ed8Cq7fdOJKUDW6MsRitS47fIMXqIrgG4ogoaY5N
	2VWGqFhW31+IYaahYJ6sHhA8P9Vdc2WSN8EsI7g==
X-Gm-Gg: ASbGncsJmGVBucuyIc7sW7DwhWiKAT1lhQfdbwbtaH9CecMpwcC9PiTz6VxgnzcCSFZ
	BKjpds+ozmd161cMH0uny7J2WKrvFjRKjDjTdMddDEYfhs1q0DxtSTQnQGxEk
X-Google-Smtp-Source: AGHT+IGjhgia80GwIq5GYW/J/My9MoNCTxyL/+qNp0qo2eVT8TVjbjcgPbng+OjrTZMWEUN4ktGPt5mr5dUK2s5wNHQ=
X-Received: by 2002:a17:906:c38b:b0:aa6:7b34:c1a8 with SMTP id
 a640c23a62f3a-aa69ce8deddmr107306866b.55.1733764346946; Mon, 09 Dec 2024
 09:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+986mTt1i9xGBXiQPVOmu4ZJTskrCt6f-99EL_s0rhz_A@mail.gmail.com>
 <2128544.1733755560@warthog.procyon.org.uk>
In-Reply-To: <2128544.1733755560@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Dec 2024 18:12:15 +0100
Message-ID: <CAKPOu+8LSKtGmtjwRpY9tMnt=1Y7RvrhDxVsfSRQW02_g5-6XA@mail.gmail.com>
Subject: Re: [PATCH] nfs: Fix oops in nfs_netfs_init_request() when copying to cache
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Dave Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:46=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> Does this fix the issue?

The issue is with 6.11, but this patch fails to build with 6.11 and
I'm not sure how to backport that part:

 fs/nfs/fscache.c: In function =E2=80=98nfs_netfs_init_request=E2=80=99:
 fs/nfs/fscache.c:267:50: error: =E2=80=98NETFS_PGPRIV2_COPY_TO_CACHE=E2=80=
=99
undeclared (first use in this function); did you mean
=E2=80=98NETFS_RREQ_COPY_TO_CACHE=E2=80=99?
   267 |                 if (WARN_ON_ONCE(rreq->origin !=3D
NETFS_PGPRIV2_COPY_TO_CACHE))
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~

Our production machines are all 6.11, because 6.12 has that other
netfs regression that freezes all transfers immediately
(https://lore.kernel.org/netfs/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=3Dgcmkz=
wYSY4syqw@mail.gmail.com/).
I guess this other bug only affects Ceph and not NFS, but after
experiencing so many kernel regressions recently, I had to become more
cautious with kernel updates (the past 2 months had more
netfs/NFS/Ceph regression than the last 20 years combined).


>
> David
> ---
> nfs: Fix oops in nfs_netfs_init_request() when copying to cache
>
> When netfslib wants to copy some data that has just been read on behalf o=
f
> nfs, it creates a new write request and calls nfs_netfs_init_request() to
> initialise it, but with a NULL file pointer.  This causes
> nfs_file_open_context() to oops - however, we don't actually need the nfs
> context as we're only going to write to the cache.
>
> Fix this by just returning if we aren't given a file pointer and emit a
> warning if the request was for something other than copy-to-cache.
>
> Further, fix nfs_netfs_free_request() so that it doesn't try to free the
> context if the pointer is NULL.
>
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Reported-by: Max Kellermann <max.kellermann@ionos.com>
> Closes: https://lore.kernel.org/r/CAKPOu+986mTt1i9xGBXiQPVOmu4ZJTskrCt6f-=
99EL_s0rhz_A@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Trond Myklebust <trondmy@kernel.org>
> cc: Anna Schumaker <anna@kernel.org>
> cc: Dave Wysochanski <dwysocha@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-nfs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/nfs/fscache.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index 810269ee0a50..d49e4ce27999 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -263,6 +263,12 @@ int nfs_netfs_readahead(struct readahead_control *ra=
ctl)
>  static atomic_t nfs_netfs_debug_id;
>  static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct =
file *file)
>  {
> +       if (!file) {
> +               if (WARN_ON_ONCE(rreq->origin !=3D NETFS_PGPRIV2_COPY_TO_=
CACHE))
> +                       return -EIO;
> +               return 0;
> +       }
> +
>         rreq->netfs_priv =3D get_nfs_open_context(nfs_file_open_context(f=
ile));
>         rreq->debug_id =3D atomic_inc_return(&nfs_netfs_debug_id);
>         /* [DEPRECATED] Use PG_private_2 to mark folio being written to t=
he cache. */
> @@ -274,7 +280,8 @@ static int nfs_netfs_init_request(struct netfs_io_req=
uest *rreq, struct file *fi
>
>  static void nfs_netfs_free_request(struct netfs_io_request *rreq)
>  {
> -       put_nfs_open_context(rreq->netfs_priv);
> +       if (rreq->netfs_priv)
> +               put_nfs_open_context(rreq->netfs_priv);
>  }
>
>  static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequ=
est *sreq)
>

