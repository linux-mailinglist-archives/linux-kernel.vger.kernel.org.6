Return-Path: <linux-kernel+bounces-440684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062269EC2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2371880845
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F9E204F79;
	Wed, 11 Dec 2024 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuEG8ifs"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16840CA4E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886543; cv=none; b=HLfIb8BXPOWOqp8C3Ppl5aNWbJgA462HI/a9yhVCQsDSCy14EEt08geiOmYsS3YzrTbCcI0DbEU8ApQI9SQ1j/nJD8m0aB+XdJwUBNeHmMWUpeEaEnbTUWwgz4pDOaDfblIqToY4bz/wmV+pfcIMJDjkkwQkls2JJjkEdFWxF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886543; c=relaxed/simple;
	bh=rl/bH3ncMLElfsEL/vmPX3sHU67tJp/k8u4tqzTHJ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zzy+5AeAgEcNkckH8xqEmx7wbq41TXPTMayJykwdKiviasjlpHZ1PBR9X/nDxx1GqfR7teNHRN6g4N7CjGAp0A3S/CwbRC9PJGxurb2dooj/ThTjNkKy61WYoE9kXMfsC7426zE5x380vvSIbCu8qkmwJmVsz7+JqQ0A76hQydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuEG8ifs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3022c61557cso21398741fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733886539; x=1734491339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJYiplpN21nOYm4w/gDDPNv7XNfDm2uH3FMwqWHdt5k=;
        b=FuEG8ifsaEzPZLvIZuSl8atkPYenbD6Kj2nfKv4j5cNemcpFrhPi/p69CCT1SuEgjZ
         6qmAJ/JTqs9ZpeG8w/qE1LpBdsP617RgyU9IJPPnD3GnwQHbHFhksFU9vP5oHd6sYWCx
         NvmA3yalPgtgU28B71huAZKlcfKRmP05gVk/5mVtyvHMcRbI2A79X19A6oh+HJnM7g0W
         p8al7CnzYEkgtsQaXxlLJV+FRMvdyV0hyFwFtiLFbz8GMDuMoNgPRNT4omR1hCqAQcbo
         ftbY9gtiT5yNIrd9XxMX6Fn6OFQ7zGp/G6NQ3DKAGD5Mqt6e23O12ADIPY/Q29zSWGhx
         8Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733886539; x=1734491339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJYiplpN21nOYm4w/gDDPNv7XNfDm2uH3FMwqWHdt5k=;
        b=dBoOq3ZgkeSWTKKk6xqX0U2l3d/UFjpXdiMWgDHNhDqln89ihlrTSTiIcOBG/I4gJf
         BQuHu8wwGFqKhTQ7tIAtbuuhDPD/A3cYq8jBgsYdsepo5JHhKkSx8rUne3IVWy8piRd2
         h7/uQeCfkhyAMc+lBgy8ib4WhwwI4aV8lVp+wWgB4opLDj2vRTIT8bw7fY9NY9J1QAvB
         qMPCRSFCMUE3+o0b/FXEhxOcVmXNUU+eDyCmuaECS/5U8jFtEvkDEmo+2V7L1viqzDxP
         OMJdW5qAa9vVeyzXaxbvf4HdrZsYqdQdmiAXvpZErh7cYHXm7W51mC0Na4FYzHrPYt2g
         qcwA==
X-Forwarded-Encrypted: i=1; AJvYcCUjRdtBO1nKYwP6hkv2MdkszbW1lqASrng851WetEchzlPHtsiN2lzqtvkjeeKt2IixIqr9JjnMMCwNQaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfpeX1H0c4mC607SEm36vISz0rjcS9tQpxLnqFCbOb355Wpv5
	LAqZWLeHhRyGsMLzTGNlLE6j3iyetOLlxT7k1jBzPk2Wcypluzi9r1CGLPQtQ3ssBNxrweDVxVT
	/+E9wBEuzgJvX92jSqhdPEl2AE3w=
X-Gm-Gg: ASbGncvM0fsP6KWdeNRY1+54tmRjLONOhrjkvHuJxsAiyJLAdShawp7qlE+Wa2tIg1W
	MIHfySt6UCIXahrf7Bv/yxjQa2puhRUS6VFP4
X-Google-Smtp-Source: AGHT+IHdI5rHVz7RsYzjySox+XBa4vG7b27828fJowbfJJbRZGGzIM87e/rIEnj07lRvF5hLfpOjv9WTw67kIAFQ32c=
X-Received: by 2002:a2e:a541:0:b0:300:5c57:526b with SMTP id
 38308e7fff4ca-30240d4fbe0mr4077391fa.11.1733886538822; Tue, 10 Dec 2024
 19:08:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104034545.497907-1-yi.sun@unisoc.com> <20241104034545.497907-6-yi.sun@unisoc.com>
In-Reply-To: <20241104034545.497907-6-yi.sun@unisoc.com>
From: yi sun <sunyibuaa@gmail.com>
Date: Wed, 11 Dec 2024 11:08:22 +0800
Message-ID: <CALpufv34r8cMv0BtGXWLd_LEBjtMGM+CZ=XpnsL8Qr8WOsOk6Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] f2fs: Optimize f2fs_truncate_data_blocks_range()
To: Yi Sun <yi.sun@unisoc.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kindly ping.
I think there are no problems with the first few patches, but the
current patch may still have room for improvement. Do you have any
good suggestions?

On Mon, Nov 4, 2024 at 11:46=E2=80=AFAM Yi Sun <yi.sun@unisoc.com> wrote:
>
> Function f2fs_invalidate_blocks() can process continuous
> blocks at a time, so f2fs_truncate_data_blocks_range() is
> optimized to use the new functionality of
> f2fs_invalidate_blocks().
>
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>  fs/f2fs/file.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 4 deletions(-)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 9366e7fc7c39..d20cc5f36d4c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -612,6 +612,15 @@ static int f2fs_file_open(struct inode *inode, struc=
t file *filp)
>         return finish_preallocate_blocks(inode);
>  }
>
> +static bool check_curr_block_is_consecutive(struct f2fs_sb_info *sbi,
> +                                       block_t curr, block_t end)
> +{
> +       if (curr - end =3D=3D 1 || curr =3D=3D end)
> +               return true;
> +       else
> +               return false;
> +}
> +
>  void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count=
)
>  {
>         struct f2fs_sb_info *sbi =3D F2FS_I_SB(dn->inode);
> @@ -621,8 +630,27 @@ void f2fs_truncate_data_blocks_range(struct dnode_of=
_data *dn, int count)
>         int cluster_index =3D 0, valid_blocks =3D 0;
>         int cluster_size =3D F2FS_I(dn->inode)->i_cluster_size;
>         bool released =3D !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks=
);
> +       /*
> +        * Temporary record location.
> +        * When the current  @blkaddr and @blkaddr_end can be processed
> +        * together, update the value of @blkaddr_end.
> +        * When it is detected that current @blkaddr is not continues wit=
h
> +        * @blkaddr_end, it is necessary to process continues blocks
> +        * range [blkaddr_start, blkaddr_end].
> +        */
> +       block_t blkaddr_start, blkaddr_end;
> +       /*.
> +        * To avoid processing various invalid data blocks.
> +        * Because @blkaddr_start and @blkaddr_end may be assigned
> +        * NULL_ADDR or invalid data blocks, @last_valid is used to
> +        * record this situation.
> +        */
> +       bool last_valid =3D false;
> +       /* Process the last @blkaddr separately? */
> +       bool last_one =3D true;
>
>         addr =3D get_dnode_addr(dn->inode, dn->node_page) + ofs;
> +       blkaddr_start =3D blkaddr_end =3D le32_to_cpu(*addr);
>
>         /* Assumption: truncation starts with cluster */
>         for (; count > 0; count--, addr++, dn->ofs_in_node++, cluster_ind=
ex++) {
> @@ -638,24 +666,60 @@ void f2fs_truncate_data_blocks_range(struct dnode_o=
f_data *dn, int count)
>                 }
>
>                 if (blkaddr =3D=3D NULL_ADDR)
> -                       continue;
> +                       goto next;
>
>                 f2fs_set_data_blkaddr(dn, NULL_ADDR);
>
>                 if (__is_valid_data_blkaddr(blkaddr)) {
>                         if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE=
))
> -                               continue;
> +                               goto next;
>                         if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
>                                                 DATA_GENERIC_ENHANCE))
> -                               continue;
> +                               goto next;
>                         if (compressed_cluster)
>                                 valid_blocks++;
>                 }
>
> -               f2fs_invalidate_blocks(sbi, blkaddr, 1);
> +
> +               if (check_curr_block_is_consecutive(sbi, blkaddr, blkaddr=
_end)) {
> +                       /*
> +                        * The current block @blkaddr is continuous with
> +                        * @blkaddr_end, so @blkaddr_end is updated.
> +                        * And the f2fs_invalidate_blocks() is skipped
> +                        * until @blkaddr that cannot be processed
> +                        * together is encountered.
> +                        */
> +                       blkaddr_end =3D blkaddr;
> +                       if (count =3D=3D 1)
> +                               last_one =3D false;
> +                       else
> +                               goto skip_invalid;
> +               }
> +
> +               f2fs_invalidate_blocks(sbi, blkaddr_start,
> +                                       blkaddr_end - blkaddr_start + 1);
> +               blkaddr_start =3D blkaddr_end =3D blkaddr;
> +
> +               if (count =3D=3D 1 && last_one)
> +                       f2fs_invalidate_blocks(sbi, blkaddr, 1);
> +
> +skip_invalid:
> +               last_valid =3D true;
>
>                 if (!released || blkaddr !=3D COMPRESS_ADDR)
>                         nr_free++;
> +
> +               continue;
> +
> +next:
> +               /* If consecutive blocks have been recorded, we need to p=
rocess them. */
> +               if (last_valid =3D=3D true)
> +                       f2fs_invalidate_blocks(sbi, blkaddr_start,
> +                                       blkaddr_end - blkaddr_start + 1);
> +
> +               blkaddr_start =3D blkaddr_end =3D le32_to_cpu(*(addr + 1)=
);
> +               last_valid =3D false;
> +
>         }
>
>         if (compressed_cluster)
> --
> 2.25.1
>

