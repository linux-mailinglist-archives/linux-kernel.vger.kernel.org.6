Return-Path: <linux-kernel+bounces-307033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C64964713
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483361C22623
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10861AB500;
	Thu, 29 Aug 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vj4LsyMf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E619FA93
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939012; cv=none; b=BfCL0wa3kQWkxjI3pa7WAoRo7v/S1YeDbe8P+1yUfQB1aXBbxJqYvqIUNYLzWpE6U7w53dGTnn/FbhVSwUDcGVtkKG9RmPYzwPFC0ZL4xgQszyPbYT20CLz5wT8MJM3UiP9s+mcgffqptT18blA9M8bGwaJC2loqpYoKlIqS0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939012; c=relaxed/simple;
	bh=giGBQU+sQEwpl2UxJ2qyqRaobzqGFI9NezCBLi0vtgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rz8EYmSdoM15uRaKV07MvBwoAIVQFG+d0EtL1YKxWPIZBYlHPmdt3DStcG1kcjMxJuTAKfbjD4Ruxa615a+HV7fzbOF6pix2SASMZhojlCxwamQX9JZ0WZN3oJlLgQ6Hem+LaiE30KSwVF/yvhnYHDGoPa184eU1pfdDskv1SOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vj4LsyMf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724939009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0Z2TTAubebcI3yRFy8BOcjudxXHokyVQvE7gs+dc9U=;
	b=Vj4LsyMfTb0QiYX7U5ahzCeNzty3H+A6LTK1uEY+mAbRg6pBPmC6+/KV8l/gOr/VNk9yyq
	kv/1UjxnbAJNg7NqG8vTeHQ0cU4wkjb7FdlnJhcKWHw3Y+WfcQOisl8bvpOg4Fh+roQh47
	KyRXVohILIZItnmIofxh3JblbGnXOXA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-rXPbg8RbMuq895kMw6MxoQ-1; Thu, 29 Aug 2024 09:43:21 -0400
X-MC-Unique: rXPbg8RbMuq895kMw6MxoQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-69a0536b23aso13032857b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724939001; x=1725543801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Z2TTAubebcI3yRFy8BOcjudxXHokyVQvE7gs+dc9U=;
        b=oCFeKrtSugAR1d4BjdP0zbd68cSH810Bg6AvVgE39WC0VW/uBDOgjncLm6/cVVoyds
         0sUpM5xmvRs2Lz79NaoYUINsmIfCAM48A4szvTXi6o1FCjEF8V+GiJHWP/dnN87aaNCs
         EIfxuCZHP6nGYwWRtsOks+m3YPo61RWOK8ij13vs3Km/uHPLrDy+WrW6SR44w261DfQE
         rKSQgPDUbXmklKRUJbi9pyaFyc4kj7+Ska1N8+TK+0JcCo6RwdesxFvMckzT7Ydhazbw
         qRwvxRfT5BnKRjXmb1+zF1M14SUGhFUrRr2rlFPLi/7WXEOt3KqdxcUqylPb+ZyWecKU
         0uQw==
X-Forwarded-Encrypted: i=1; AJvYcCVzxdneczP8/eF2Eulo2/qa+O1enBt4YTwzHvP1ucdepn8yv7kQHtZZwIEyStp019fnLs+c2kozcjSjDVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYC2h4HUh8opaolPmaFUqXwNqzu3W6pBx25rDQDvTJw22UzIJl
	4uDCIsPUM5dZYX1IpH8thHhxx5joBRAXzKizvKT6UOLLSWjm6ZROs1g3DKf68HRQIqxoCIMR23X
	Q4rYdxVNRqgNkUgMGiaH9svJnxTI0xr2xBVV6nileFBjdVbDzkZM6ae/fdC+dBaNXAa1VPonAU5
	k9sAe1euiEjQoD9jI8pFVTWtEGWdxPg4Egsfr/
X-Received: by 2002:a05:690c:f03:b0:61b:1f0e:10 with SMTP id 00721157ae682-6d275964aecmr37487087b3.4.1724939001198;
        Thu, 29 Aug 2024 06:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKHkEXcfTNGzxGT7v9KMH1vSi8w5QzeRtQyq6gaTRJfFSbAnlIh//kHPNxfyUlcn8CoE1HLbBmIbGorcq3lvo=
X-Received: by 2002:a05:690c:f03:b0:61b:1f0e:10 with SMTP id
 00721157ae682-6d275964aecmr37486857b3.4.1724939000930; Thu, 29 Aug 2024
 06:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-4-dtatulea@nvidia.com>
In-Reply-To: <20240821114100.2261167-4-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 15:42:44 +0200
Message-ID: <CAJaqyWch9oNEYONUe=X0u02788Dey_8+_bF0sfiPZ7Yv53MVGA@mail.gmail.com>
Subject: Re: [PATCH vhost 2/7] vdpa/mlx5: Delete direct MKEYs in parallel
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:42=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Use the async interface to issue MTT MKEY deletion.
>
> This makes destroy_user_mr() on average 8x times faster.
> This number is also dependent on the size of the MR being
> deleted.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 66 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 66e6a15f823f..8cedf2969991 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -55,6 +55,11 @@ struct mlx5_create_mkey_mem {
>         DECLARE_FLEX_ARRAY(__be64, mtt);
>  };
>
> +struct mlx5_destroy_mkey_mem {
> +       u8 out[MLX5_ST_SZ_BYTES(destroy_mkey_out)];
> +       u8 in[MLX5_ST_SZ_BYTES(destroy_mkey_in)];
> +};
> +
>  static void fill_create_direct_mr(struct mlx5_vdpa_dev *mvdev,
>                                   struct mlx5_vdpa_direct_mr *mr,
>                                   struct mlx5_create_mkey_mem *mem)
> @@ -91,6 +96,17 @@ static void create_direct_mr_end(struct mlx5_vdpa_dev =
*mvdev,
>         mr->mr =3D mlx5_idx_to_mkey(mkey_index);
>  }
>
> +static void fill_destroy_direct_mr(struct mlx5_vdpa_dev *mvdev,
> +                                  struct mlx5_vdpa_direct_mr *mr,
> +                                  struct mlx5_destroy_mkey_mem *mem)
> +{
> +       void *in =3D &mem->in;
> +

Nit, isn't this declaration redundant? Looking at the definition of
MLX5_SET, the second argument is casted to (__be32 *) anyway.

> +       MLX5_SET(destroy_mkey_in, in, uid, mvdev->res.uid);
> +       MLX5_SET(destroy_mkey_in, in, opcode, MLX5_CMD_OP_DESTROY_MKEY);
> +       MLX5_SET(destroy_mkey_in, in, mkey_index, mlx5_mkey_to_idx(mr->mr=
));
> +}
> +
>  static void destroy_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_v=
dpa_direct_mr *mr)
>  {
>         if (!mr->mr)
> @@ -255,6 +271,55 @@ static int create_direct_keys(struct mlx5_vdpa_dev *=
mvdev, struct mlx5_vdpa_mr *
>         return err;
>  }
>
> +static int destroy_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_=
vdpa_mr *mr)
> +{
> +       struct mlx5_destroy_mkey_mem *cmd_mem;
> +       struct mlx5_vdpa_async_cmd *cmds;
> +       struct mlx5_vdpa_direct_mr *dmr;
> +       int err =3D 0;
> +       int i =3D 0;
> +
> +       cmds =3D kvcalloc(mr->num_directs, sizeof(*cmds), GFP_KERNEL);
> +       cmd_mem =3D kvcalloc(mr->num_directs, sizeof(*cmd_mem), GFP_KERNE=
L);
> +       if (!cmds || !cmd_mem) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +
> +       list_for_each_entry(dmr, &mr->head, list) {
> +               cmds[i].out =3D cmd_mem[i].out;
> +               cmds[i].outlen =3D sizeof(cmd_mem[i].out);
> +               cmds[i].in =3D cmd_mem[i].in;
> +               cmds[i].inlen =3D sizeof(cmd_mem[i].in);
> +               fill_destroy_direct_mr(mvdev, dmr, &cmd_mem[i]);
> +               i++;
> +       }
> +
> +       err =3D mlx5_vdpa_exec_async_cmds(mvdev, cmds, mr->num_directs);
> +       if (err) {
> +
> +               mlx5_vdpa_err(mvdev, "error issuing MTT mkey deletion for=
 direct mrs: %d\n", err);
> +               goto done;
> +       }
> +
> +       i =3D 0;
> +       list_for_each_entry(dmr, &mr->head, list) {
> +               struct mlx5_vdpa_async_cmd *cmd =3D &cmds[i++];
> +
> +               dmr->mr =3D 0;
> +               if (cmd->err) {
> +                       err =3D err ? err : cmd->err;
> +                       mlx5_vdpa_err(mvdev, "error deleting MTT mkey [0x=
%llx, 0x%llx]: %d\n",
> +                               dmr->start, dmr->end, cmd->err);
> +               }
> +       }
> +
> +done:
> +       kvfree(cmd_mem);
> +       kvfree(cmds);

Same nitpick here as in the previous patch about the Scope-based
Cleanup Helpers. Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> +       return err;
> +}
> +
>  static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_=
vdpa_mr *mr)
>  {
>         int inlen;
> @@ -563,6 +628,7 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvd=
ev, struct mlx5_vdpa_mr *mr
>         struct mlx5_vdpa_direct_mr *n;
>
>         destroy_indirect_key(mvdev, mr);
> +       destroy_direct_keys(mvdev, mr);
>         list_for_each_entry_safe_reverse(dmr, n, &mr->head, list) {
>                 list_del_init(&dmr->list);
>                 unmap_direct_mr(mvdev, dmr);
> --
> 2.45.1
>


