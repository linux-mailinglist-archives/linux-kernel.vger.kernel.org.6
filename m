Return-Path: <linux-kernel+bounces-307186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6710D9649A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFB31C230D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA61B0107;
	Thu, 29 Aug 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqYxJ9Nj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC81487F1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944560; cv=none; b=YF7EGPVRL36rW6qkIB6sFxzzo+ji8kM+o+4IgtxEuw5fVMYx6C19EVqltTyjsWGUzYU4tJ6hB8QCNLEnSSzA0FsyRR7ooVQkb5DPoOahgPDcT8ssqnWexf6LbfetevuRJQjscril9F+pCWiOW8HQGBCgIsfmQwF6f0My+N+qn/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944560; c=relaxed/simple;
	bh=vdLEYwn3hyH0yYINE9e21Zqj01ES2SNI5IJDGg/dBag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZEskFKiZ/6w/2UL791p2tOg8KEIYMQNTLnAVDBrzOx8bDUGE6JjKWL3VO6/oShw+dnNM2p5llij8lx1k12j4hHBzoV9Nf0rtqzTFZhw23MjTLLvhUxwWauBf38c/iwuBaJiSUrTi8yACA/quCniXo42IbxGS5WNaeteUUm7oHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqYxJ9Nj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emt4Aa5SKw7SFyxXUt2WM0K5CmZW1m3fJVEf3z1rDFo=;
	b=LqYxJ9NjA/knLb0TXBGsc2tNzgfVcOKgn5SY5mgHXfpLGaD6vXIzd7vlRa2GS5a+z04XZW
	jrblPMt2/V0OkU1oBGwF2ClOWgJE7dqhA2fzOT3APtAvNHnbhXLt7i+DQ2IIqo+WF2csEt
	Az4BpD7R6KMzAoHEG3PAO/zBA+iueD4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-_MVsV3EiMWeyuYkQkCpKsg-1; Thu, 29 Aug 2024 11:15:56 -0400
X-MC-Unique: _MVsV3EiMWeyuYkQkCpKsg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3f9517948so7216541fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944551; x=1725549351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emt4Aa5SKw7SFyxXUt2WM0K5CmZW1m3fJVEf3z1rDFo=;
        b=ACbtwJeVD1uiTbExYfngrjFfD6jajpB0V+pjhpuW4Q5QzFdUjYkQji/zCI98a28aMB
         SkB7gvSVk97InY97zU0pEmJlP5QvHkPFIwLFWFRZCt7fXXz2YjegjNu9a0i/Zu3BYMk2
         wnVI6cEEx5sddFQ/68kPKdR1ltaO6Nlb/VGyWfERQfokU19uD+S+T7u0Fo9k0FiVo5zG
         vczPhLqFcu4XWvy1kKoXYTwN7MDkY7c/EosFt4PnG5idoQj/sdorZCI6H8f+ulnUs4zt
         5ZDzISOnpgT87IOk/l6AjqqZlSOqtRT9tZzT1hC7qgBKjEgMuZqmllANCgn7z0LgiqJI
         ttlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnzjDeQiA+PQ4K2BTcAW6vJ1nacSjVN1x2hnNt3bF9KVZ0fQFJ4d5zXXDp63YZbgRowK4a/mqE7B2Yd+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/989aK9dr+aEiAWork5SkPkXb9bi0jDUaJVJLUX0GfpF/wCQW
	ScE5BuQd5b26sCyr2hYquGltlD62OGDzatPOH2wiOTZQckPX++ZuapNR8JYTvpEhRoAWZvMHMPm
	iY7HqULvjJGUDB/KyIXYCOgWQFnT3vy0Qadt5t2ep/iTsJfD1kRmKOQ6qSXO20mPPf2PBulU0qI
	XyoxFDxZ8aAroTFYon8FKE8AbE283e4s8L0RAA4cY98Q9weS8=
X-Received: by 2002:ac2:4e07:0:b0:52c:850b:cfc6 with SMTP id 2adb3069b0e04-5353e5b8216mr1957954e87.38.1724944550644;
        Thu, 29 Aug 2024 08:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF8w/FaX9C3ZPUAUun6keBH6CcxT9mb81J79vRsiAKre8bMCAbeIvA/LIXR16ficN/CS2MtvD/ssp4SVq+k7w=
X-Received: by 2002:a17:907:9688:b0:a86:b789:164b with SMTP id
 a640c23a62f3a-a897fad4543mr271625966b.58.1724944538225; Thu, 29 Aug 2024
 08:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-3-dtatulea@nvidia.com>
 <CAJaqyWcFVLXg=nUdOJOviWA+TDfbqBeEHrVROVC1nYrO8+ZmhA@mail.gmail.com> <6935f3aa-9de5-4781-b823-30c17817cc86@nvidia.com>
In-Reply-To: <6935f3aa-9de5-4781-b823-30c17817cc86@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 17:15:00 +0200
Message-ID: <CAJaqyWcW2r9bos3CPxE4yZfZDORzki1SKSyODSgJRLXocOam1w@mail.gmail.com>
Subject: Re: [PATCH vhost 1/7] vdpa/mlx5: Create direct MKEYs in parallel
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, Gal Pressman <gal@nvidia.com>, 
	kvm list <kvm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Michael Tsirkin <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:54=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 29.08.24 15:10, Eugenio Perez Martin wrote:
> > On Wed, Aug 21, 2024 at 1:41=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> >>
> >> Use the async interface to issue MTT MKEY creation.
> >> Extra care is taken at the allocation of FW input commands
> >> due to the MTT tables having variable sizes depending on
> >> MR.
> >>
> >> The indirect MKEY is still created synchronously at the
> >> end as the direct MKEYs need to be filled in.
> >>
> >> This makes create_user_mr() 3-5x faster, depending on
> >> the size of the MR.
> >>
> >> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> >> ---
> >>  drivers/vdpa/mlx5/core/mr.c | 118 +++++++++++++++++++++++++++++------=
-
> >>  1 file changed, 96 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> >> index 4758914ccf86..66e6a15f823f 100644
> >> --- a/drivers/vdpa/mlx5/core/mr.c
> >> +++ b/drivers/vdpa/mlx5/core/mr.c
> >> @@ -49,17 +49,18 @@ static void populate_mtts(struct mlx5_vdpa_direct_=
mr *mr, __be64 *mtt)
> >>         }
> >>  }
> >>
> >> -static int create_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_=
vdpa_direct_mr *mr)
> >> +struct mlx5_create_mkey_mem {
> >> +       u8 out[MLX5_ST_SZ_BYTES(create_mkey_out)];
> >> +       u8 in[MLX5_ST_SZ_BYTES(create_mkey_in)];
> >> +       DECLARE_FLEX_ARRAY(__be64, mtt);
> >
> > I may be missing something obvious, but why do we need
> > DECLARE_FLEX_ARRAY here? My understanding is that it is only needed in
> > special cases like uapi headers and we can use "__be64 mtt[]" here.
> >
> checkpatch.pl was complaining about it because in my initial version I
> used the "[0]" version of zero length based arrays.
>
> My impression was that DECLARE_FLEX_ARRAY is preferred option because it
> triggers a compiler error if the zero lenth array is not at the end of
> the struct. But on closer inspection I see that using the right C99
> empty brackets notation is enough to trigger this error.
> DECLARE_FLEX_ARRAY seems to be useful for the union case.
>
> I will change it in a v2.
>
> >> +};
> >> +
> >> +static void fill_create_direct_mr(struct mlx5_vdpa_dev *mvdev,
> >> +                                 struct mlx5_vdpa_direct_mr *mr,
> >> +                                 struct mlx5_create_mkey_mem *mem)
> >>  {
> >> -       int inlen;
> >> +       void *in =3D &mem->in;
> >>         void *mkc;
> >> -       void *in;
> >> -       int err;
> >> -
> >> -       inlen =3D MLX5_ST_SZ_BYTES(create_mkey_in) + roundup(MLX5_ST_S=
Z_BYTES(mtt) * mr->nsg, 16);
> >> -       in =3D kvzalloc(inlen, GFP_KERNEL);
> >> -       if (!in)
> >> -               return -ENOMEM;
> >>
> >>         MLX5_SET(create_mkey_in, in, uid, mvdev->res.uid);
> >>         mkc =3D MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry=
);
> >> @@ -76,18 +77,25 @@ static int create_direct_mr(struct mlx5_vdpa_dev *=
mvdev, struct mlx5_vdpa_direct
> >>         MLX5_SET(create_mkey_in, in, translations_octword_actual_size,
> >>                  get_octo_len(mr->end - mr->start, mr->log_size));
> >>         populate_mtts(mr, MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt=
));
> >> -       err =3D mlx5_vdpa_create_mkey(mvdev, &mr->mr, in, inlen);
> >> -       kvfree(in);
> >> -       if (err) {
> >> -               mlx5_vdpa_warn(mvdev, "Failed to create direct MR\n");
> >> -               return err;
> >> -       }
> >>
> >> -       return 0;
> >> +       MLX5_SET(create_mkey_in, in, opcode, MLX5_CMD_OP_CREATE_MKEY);
> >> +       MLX5_SET(create_mkey_in, in, uid, mvdev->res.uid);
> >> +}
> >> +
> >> +static void create_direct_mr_end(struct mlx5_vdpa_dev *mvdev,
> >> +                                struct mlx5_vdpa_direct_mr *mr,
> >> +                                struct mlx5_create_mkey_mem *mem)
> >> +{
> >> +       u32 mkey_index =3D MLX5_GET(create_mkey_out, mem->out, mkey_in=
dex);
> >> +
> >> +       mr->mr =3D mlx5_idx_to_mkey(mkey_index);
> >>  }
> >>
> >>  static void destroy_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx=
5_vdpa_direct_mr *mr)
> >>  {
> >> +       if (!mr->mr)
> >> +               return;
> >> +
> >>         mlx5_vdpa_destroy_mkey(mvdev, mr->mr);
> >>  }
> >>
> >> @@ -179,6 +187,74 @@ static int klm_byte_size(int nklms)
> >>         return 16 * ALIGN(nklms, 4);
> >>  }
> >>
> >> +static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx=
5_vdpa_mr *mr)
> >> +{
> >> +       struct mlx5_vdpa_async_cmd *cmds =3D NULL;
> >> +       struct mlx5_vdpa_direct_mr *dmr;
> >> +       int err =3D 0;
> >> +       int i =3D 0;
> >> +
> >> +       cmds =3D kvcalloc(mr->num_directs, sizeof(*cmds), GFP_KERNEL);
> >> +       if (!cmds)
> >> +               return -ENOMEM;
> >
> > Nit: this could benefit from Scope-based Cleanup Helpers [1], as it
> > would make clear that memory is always removed at the end of the
> > function & could prevent errors if the function is modified in the
> > future. I'm a big fan of them so my opinion may be biased though :).
> >
> > It would be great to be able to remove the array members with that
> > too, but I think the kernel doesn't have any facility for that.
> >
> I didn't know about those. It sounds like a good idea! I will try
> to use them in v2.
>
> >> +
> >> +       list_for_each_entry(dmr, &mr->head, list) {
> >> +               struct mlx5_create_mkey_mem *cmd_mem;
> >> +               int mttlen, mttcount;
> >> +
> >> +               mttlen =3D roundup(MLX5_ST_SZ_BYTES(mtt) * dmr->nsg, 1=
6);
> >
> > I don't get the roundup here, I guess it is so the driver does not
> > send potentially uninitialized memory to the device? Maybe the 16
> > should be a macro?
> >
> The roundup is a hw requirement. A define would be a good idea. Will add
> it.
>
> >> +               mttcount =3D mttlen / sizeof(cmd_mem->mtt[0]);
> >> +               cmd_mem =3D kvcalloc(1, struct_size(cmd_mem, mtt, mttc=
ount), GFP_KERNEL);
> >> +               if (!cmd_mem) {
> >> +                       err =3D -ENOMEM;
> >> +                       goto done;
> >> +               }
> >> +
> >> +               cmds[i].out =3D cmd_mem->out;
> >> +               cmds[i].outlen =3D sizeof(cmd_mem->out);
> >> +               cmds[i].in =3D cmd_mem->in;
> >> +               cmds[i].inlen =3D struct_size(cmd_mem, mtt, mttcount);
> >> +
> >> +               fill_create_direct_mr(mvdev, dmr, cmd_mem);
> >> +
> >> +               i++;
> >> +       }
> >> +
> >> +       err =3D mlx5_vdpa_exec_async_cmds(mvdev, cmds, mr->num_directs=
);
> >> +       if (err) {
> >> +
> >> +               mlx5_vdpa_err(mvdev, "error issuing MTT mkey creation =
for direct mrs: %d\n", err);
> >> +               goto done;
> >> +       }
> >> +
> >> +       i =3D 0;
> >> +       list_for_each_entry(dmr, &mr->head, list) {
> >> +               struct mlx5_vdpa_async_cmd *cmd =3D &cmds[i++];
> >> +               struct mlx5_create_mkey_mem *cmd_mem;
> >> +
> >> +               cmd_mem =3D container_of(cmd->out, struct mlx5_create_=
mkey_mem, out);
> >> +
> >> +               if (!cmd->err) {
> >> +                       create_direct_mr_end(mvdev, dmr, cmd_mem);
> >
> > The caller function doesn't trust the result if we return an error.
> > Why not use the previous loop to call create_direct_mr_end? Am I
> > missing any side effect?
> >
> Which previous loop? We have the mkey value only after the command has
> been executed.

Ok, now I see what I proposed didn't make sense, thanks!

> I added the if here (instead of always calling
> create_direct_mr_end()) just to make things more explicit for the
> reader.
>
> >> +               } else {
> >> +                       err =3D err ? err : cmd->err;
> >> +                       mlx5_vdpa_err(mvdev, "error creating MTT mkey =
[0x%llx, 0x%llx]: %d\n",
> >> +                               dmr->start, dmr->end, cmd->err);
> >> +               }
> >> +       }
> >> +
> >> +done:
> >> +       for (i =3D i-1; i >=3D 0; i--) {
> >> +               struct mlx5_create_mkey_mem *cmd_mem;
> >> +
> >> +               cmd_mem =3D container_of(cmds[i].out, struct mlx5_crea=
te_mkey_mem, out);
> >> +               kvfree(cmd_mem);
> >> +       }
> >> +
> >> +       kvfree(cmds);
> >> +       return err;
> >> +}
> >> +
> >>  static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct ml=
x5_vdpa_mr *mr)
> >>  {
> >>         int inlen;
> >> @@ -279,14 +355,8 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mv=
dev, struct mlx5_vdpa_direct_mr
> >>                 goto err_map;
> >>         }
> >>
> >> -       err =3D create_direct_mr(mvdev, mr);
> >> -       if (err)
> >> -               goto err_direct;
> >> -
> >>         return 0;
> >>
> >> -err_direct:
> >> -       dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECT=
IONAL, 0);
> >>  err_map:
> >>         sg_free_table(&mr->sg_head);
> >>         return err;
> >> @@ -401,6 +471,10 @@ static int create_user_mr(struct mlx5_vdpa_dev *m=
vdev,
> >>         if (err)
> >>                 goto err_chain;
> >>
> >> +       err =3D create_direct_keys(mvdev, mr);
> >> +       if (err)
> >> +               goto err_chain;
> >> +
> >>         /* Create the memory key that defines the guests's address spa=
ce. This
> >>          * memory key refers to the direct keys that contain the MTT
> >>          * translations
> >> --
> >> 2.45.1
> >>
> >
>


