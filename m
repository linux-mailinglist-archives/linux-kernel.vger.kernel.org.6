Return-Path: <linux-kernel+bounces-335579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B493F97E7AB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C504281C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822CD19408C;
	Mon, 23 Sep 2024 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Cx0woNXK"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A52F2D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080696; cv=none; b=hnuGkk7oOAMQ6pjc1iMj7onhR1Shgjs+aFGpxyrf/cQAzTnT/lONC6uUHNXCCSWP3KnF9K7GCcRSGic7+KBU02Dl4AdHYexTp14NNvKbypXKnIM8rNwvg1LuG/QMAlfBV23mca4lQyykLWLBi1YDAGZXPAmBv/89BQc0R1hunFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080696; c=relaxed/simple;
	bh=snprog1cnqB9l7O0+/twVmWz0+1DjeHX4YvYaq3tSJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6Vl83IK+6rwuaEpyFMk7GQkaGP1XM5f98yZzO4k0orqGbFMIY9hS4nHjElXjvcYiKH6pZuuwnhLHfiDRSK8ylR6+Ssg+/DFZtrthfoocSnjV4lhNUcSltndwjNHZqWJCAe6e87CA8fy/hhFXkxlpuZQrJYNUZ+uN+IBGx+t9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Cx0woNXK; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8A0BA4061E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727080686;
	bh=u/g+9gNxCJhyUAnefkfxXjk409lvoPewKlQ1M7Y4tlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Cx0woNXKDiyfyW86puDP0X49f4SRQ231qtWnFKAhIsNDRsbyL5cGE1A3oo5CHy79g
	 BJS2V1uzRUMveGZvUaKV0isnVMbdf6f6ZC1GIx4scTDvujn07mQaPxXW8nf9JeLR4D
	 CKt/UCYJW9k5IakYgVVVBf7l7TON7eSuLU6NY7TN5EJk3iZ15Cw39lefX13kQV7M+Q
	 nSzsnIWUph5FvmReX8xJV96O5hm1HJNC2Afr7l+dOWLjysVt0c2CVTMWhyy4v2ZZ/W
	 RpjZFUY4LQgRrTaDRr15JxZxzOspLDCbIn1mMH8UJ++9WX2jXdd+MQZ442KOJ7H/mK
	 UGfjSWgys4hQA==
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-849363a1924so1119808241.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727080685; x=1727685485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/g+9gNxCJhyUAnefkfxXjk409lvoPewKlQ1M7Y4tlI=;
        b=h1HxzlazTiTWbD24J7BdBW9ivx3i1WSSi07pwLfEDWoCO25a8qujJh/BVhI0SeebCm
         7sR/129w0lf10BPsU8HAekcPzu6kk2OytN2ISOelr2g4tfswSWhh4f1hnLKZnWxlHLqI
         rH4j0y54/cr0objFJP7X3hR9su3DqS5GnXfbEwxi8jL6+WQJzGpq9YcXGSK57ZIzuZk5
         KdDkPYVyh6gjPqLut33QRi4vfzhUsQRaT0krzGg4PVziECHA80yKCaCNww/y6UfUhdyx
         NbU+lxdi8oxVK+5hBDtZtPzqY9GzdsiclOgcHKuGlDKskK2DTTrIQiTm2GY6evJr2X1f
         hgQQ==
X-Gm-Message-State: AOJu0YwmoF+jfKXc91+UmYvzvh19r4rnaqYyLKWRP6nqluXYh9JX4t4Y
	f1VID5oAIsheSTL8tZN3A7DYzHBUJG5z/xSeAoQxHEeE8XhvBh5pNc+EaIJnnFymit06Eq0D5gn
	gd0pt2X2bsteXfq5nkmUt7T/DcVoN3ZfgRc+SOV/HfEDU/vRIA1mUXqGNBK/xXr/mHel9wKKSPd
	5RO0hradPIsYO7fFBGClZfkrCw5FHsTyjlY6I5DMHxVEiPKLETWe0afHwfTbMD
X-Received: by 2002:a05:6122:903:b0:502:af87:1a91 with SMTP id 71dfb90a1353d-503e04d91bemr7777275e0c.10.1727080685243;
        Mon, 23 Sep 2024 01:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNL0UPVF8X7fWGpDF1rrA8ckhmK7YkUMbIqjXnGk6hQ+5w23nVd9e+ggArORKmtGyMJYtxBznNkvt5HcHTUjk=
X-Received: by 2002:a05:6122:903:b0:502:af87:1a91 with SMTP id
 71dfb90a1353d-503e04d91bemr7777270e0c.10.1727080684894; Mon, 23 Sep 2024
 01:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com> <20240906143453.179506-2-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240906143453.179506-2-aleksandr.mikhalitsyn@canonical.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 23 Sep 2024 10:37:54 +0200
Message-ID: <CAEivzxfqT7OSNK-1y6az6DTHf8enD3xMJbdAVjQjO7JOj+z80A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fs/mnt_idmapping: introduce an invalid_mnt_idmap
To: mszeredi@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping :)

On Fri, Sep 6, 2024 at 4:35=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Link: https://lore.kernel.org/linux-fsdevel/20240904-baugrube-erhoben-b3c=
1c49a2645@brauner/
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  fs/mnt_idmapping.c            | 22 ++++++++++++++++++++--
>  include/linux/mnt_idmapping.h |  1 +
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index 3c60f1eaca61..cbca6500848e 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -32,6 +32,15 @@ struct mnt_idmap nop_mnt_idmap =3D {
>  };
>  EXPORT_SYMBOL_GPL(nop_mnt_idmap);
>
> +/*
> + * Carries the invalid idmapping of a full 0-4294967295 {g,u}id range.
> + * This means that all {g,u}ids are mapped to INVALID_VFS{G,U}ID.
> + */
> +struct mnt_idmap invalid_mnt_idmap =3D {
> +       .count  =3D REFCOUNT_INIT(1),
> +};
> +EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
> +
>  /**
>   * initial_idmapping - check whether this is the initial mapping
>   * @ns: idmapping to check
> @@ -75,6 +84,8 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
>
>         if (idmap =3D=3D &nop_mnt_idmap)
>                 return VFSUIDT_INIT(kuid);
> +       if (idmap =3D=3D &invalid_mnt_idmap)
> +               return INVALID_VFSUID;
>         if (initial_idmapping(fs_userns))
>                 uid =3D __kuid_val(kuid);
>         else
> @@ -112,6 +123,8 @@ vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
>
>         if (idmap =3D=3D &nop_mnt_idmap)
>                 return VFSGIDT_INIT(kgid);
> +       if (idmap =3D=3D &invalid_mnt_idmap)
> +               return INVALID_VFSGID;
>         if (initial_idmapping(fs_userns))
>                 gid =3D __kgid_val(kgid);
>         else
> @@ -140,6 +153,8 @@ kuid_t from_vfsuid(struct mnt_idmap *idmap,
>
>         if (idmap =3D=3D &nop_mnt_idmap)
>                 return AS_KUIDT(vfsuid);
> +       if (idmap =3D=3D &invalid_mnt_idmap)
> +               return INVALID_UID;
>         uid =3D map_id_up(&idmap->uid_map, __vfsuid_val(vfsuid));
>         if (uid =3D=3D (uid_t)-1)
>                 return INVALID_UID;
> @@ -167,6 +182,8 @@ kgid_t from_vfsgid(struct mnt_idmap *idmap,
>
>         if (idmap =3D=3D &nop_mnt_idmap)
>                 return AS_KGIDT(vfsgid);
> +       if (idmap =3D=3D &invalid_mnt_idmap)
> +               return INVALID_GID;
>         gid =3D map_id_up(&idmap->gid_map, __vfsgid_val(vfsgid));
>         if (gid =3D=3D (gid_t)-1)
>                 return INVALID_GID;
> @@ -296,7 +313,7 @@ struct mnt_idmap *alloc_mnt_idmap(struct user_namespa=
ce *mnt_userns)
>   */
>  struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
>  {
> -       if (idmap !=3D &nop_mnt_idmap)
> +       if (idmap !=3D &nop_mnt_idmap && idmap !=3D &invalid_mnt_idmap)
>                 refcount_inc(&idmap->count);
>
>         return idmap;
> @@ -312,7 +329,8 @@ EXPORT_SYMBOL_GPL(mnt_idmap_get);
>   */
>  void mnt_idmap_put(struct mnt_idmap *idmap)
>  {
> -       if (idmap !=3D &nop_mnt_idmap && refcount_dec_and_test(&idmap->co=
unt))
> +       if (idmap !=3D &nop_mnt_idmap && idmap !=3D &invalid_mnt_idmap &&
> +           refcount_dec_and_test(&idmap->count))
>                 free_mnt_idmap(idmap);
>  }
>  EXPORT_SYMBOL_GPL(mnt_idmap_put);
> diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.=
h
> index cd4d5c8781f5..b1b219bc3422 100644
> --- a/include/linux/mnt_idmapping.h
> +++ b/include/linux/mnt_idmapping.h
> @@ -9,6 +9,7 @@ struct mnt_idmap;
>  struct user_namespace;
>
>  extern struct mnt_idmap nop_mnt_idmap;
> +extern struct mnt_idmap invalid_mnt_idmap;
>  extern struct user_namespace init_user_ns;
>
>  typedef struct {
> --
> 2.34.1
>

