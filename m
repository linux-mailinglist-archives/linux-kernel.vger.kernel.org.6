Return-Path: <linux-kernel+bounces-427420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 332FD9E00B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611A0164F27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154081F8F16;
	Mon,  2 Dec 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Gr8tzw4F"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FB1FE478
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139243; cv=none; b=Z2mnsanJqTNHNBVMf7iQr8pCuKlYoMKu6bPAkB82LFthQyMfbFKBZbC+cphQzKQ8Zk+k7/ZnsqDDxYTVbjV7jEADmAAU3RFUBUm6JMWWRg7dXeHNjqcyYYJZ96d+8nbF+JnA/tfYMcbHIQWHEfz9aBjQzKtRSa8AbzLm8KY20l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139243; c=relaxed/simple;
	bh=Es3IiYWZzTXVfJsOZtRpCVAT8FwilKQh7ALxYlW0bWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CX9FOPA93wxVgW8lsE0ELz1sJojCG7zTFsF9mch689vV5Di+AnHT8HINpU4delmApV19G23QApKlXL8ZR9MvDacrpOzYPsX0x60YyzigF1g2Aa3C7vqF95QtwYUNbdzRcWOjRsw4tnEPek39+B40IFGivDxMoS0Jdw/UMkuR7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Gr8tzw4F; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa5438c6ba7so93605866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 03:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733139238; x=1733744038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgOsW78zI7AQFOhUrQQ6vOCCpnka8ukylLDi+hJyFSs=;
        b=Gr8tzw4F+O5kk8VCfVnBB4UZ9KbGwMlVcrx+mbDGiHYC06BSn66w+Lf75pQu5BkLmt
         V7w2vSB5i7fY3iO8qToiwW1HN53MWUphU8c0P+KqMRYXfR1nTxUjMbFMGPF1vX5oXIFr
         ygRetrtG/oCQEa/SdfG7KFbZLTQhNdOL3ILvhcwFmPKxi/O8xRcpQs1vplZg3IvLxdqy
         2cQltngY6cN0hmg+Fkqf0BN9lcgqieDX91QCAkLTJQcJqJIa1CN7iu3UAk/T/WMyoinC
         CesAftDKCEJBpN7tIjg+JOd16n3GFb9GcJQxDA2UTAxDSOcIUJBhwx1tDrkqVYTwcnY6
         rG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733139238; x=1733744038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgOsW78zI7AQFOhUrQQ6vOCCpnka8ukylLDi+hJyFSs=;
        b=Vcll171eKyigdFZ/ffg+RBwXQx9ZTqc1FXDUGYCCqNxguPnaOor1AsDvT03cDOpJGy
         u1kLVqafspqbxkZhYaL9yYLTpyh7VPb7+Fi8a6gJhlqnJcboglV7oHh10kukKZAfELEC
         SDxA7p440xaTtVbDzmKE7+rfGKTUyaBOXKeTtUc0I+80yk8kUZUz+14/17ADRytsijjr
         2VLhPnFlPEXHAERt8RVyZEHsIJr2mLtYI3en5ZLAE6dqntCDtBzmNN1BMWg5hxJmbVqs
         F+JkzkkbQG3UJzit2Xc1Qiuc9zml3s1S9TOYQjwdhIvOQYv1Em2BdodP78OhAHxCVotI
         vPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMlJ8o46J04QKg67Q890Ge9NO6UoBpMKQ/pnNOb0Wm3YUGAZY3ev72/exb/lAvxDRoYsn9VvU7y4fiyOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww33J9QqWPCyGgzqXvEC1/zDfChRIvni+YwHExPWJOzKvrWzKU
	OB7TyD0JcDFEbHEvFr69bnSIvpKTzQVzKhGUQIkalV356OFowQJ+XfTR6hYhuKs9W6uDQ3f5AuZ
	Lwy49JsTKhzsM+ZWsV8IZLTeKEu/6KWX19mRHWA==
X-Gm-Gg: ASbGnctu1Qt+1C2glhoVf4+wgz+Pg81m8JH1i66W8cEmAN1Z/oUd5OWJ9xbvq3eqqny
	0aC8hYCgIYbBJ4IiSQ0q1CcKfS3hvjzk=
X-Google-Smtp-Source: AGHT+IEwIB6XH1kGWMBcCu7HJACwhVV+8n2RyYVFYxHT/UodC2Nz3Ehl0lbyhxmEO5pPfuJb2pn6FdJt3yEbIp4ucnI=
X-Received: by 2002:a17:906:6a24:b0:aa5:163c:69f6 with SMTP id
 a640c23a62f3a-aa581097801mr1084938966b.14.1733139238297; Mon, 02 Dec 2024
 03:33:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202111957.2311683-1-john.g.garry@oracle.com> <20241202111957.2311683-3-john.g.garry@oracle.com>
In-Reply-To: <20241202111957.2311683-3-john.g.garry@oracle.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 2 Dec 2024 12:33:47 +0100
Message-ID: <CAMGffE=1ywvm-B6_GB+UqtQohdgYo5h9DCWQ0_QLoh6XK9G=ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: Delete bio_set_prio()
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, haris.iqbal@ionos.com, colyli@suse.de, 
	kent.overstreet@linux.dev, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:20=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> Since commit 43b62ce3ff0a ("block: move bio io prio to a new field"), mac=
ro
> bio_set_prio() does nothing but set bio->bi_ioprio. All other places just
> set bio->bi_ioprio directly, so replace bio_set_prio() remaining
> callsites with setting bio->bi_ioprio directly and delete that macro.
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
lgtm, thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 2 +-
>  drivers/md/bcache/movinggc.c  | 2 +-
>  drivers/md/bcache/writeback.c | 2 +-
>  fs/bcachefs/move.c            | 6 +++---
>  include/linux/bio.h           | 2 --
>  5 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 08ce6d96d04c..2ee6e9bd4e28 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -167,7 +167,7 @@ static int process_rdma(struct rnbd_srv_session *srv_=
sess,
>         bio->bi_iter.bi_sector =3D le64_to_cpu(msg->sector);
>         prio =3D srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
>                usrlen < sizeof(*msg) ? 0 : le16_to_cpu(msg->prio);
> -       bio_set_prio(bio, prio);
> +       bio->bi_ioprio =3D prio;
>
>         submit_bio(bio);
>
> diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
> index ef6abf33f926..45ca134cbf02 100644
> --- a/drivers/md/bcache/movinggc.c
> +++ b/drivers/md/bcache/movinggc.c
> @@ -82,7 +82,7 @@ static void moving_init(struct moving_io *io)
>         bio_init(bio, NULL, bio->bi_inline_vecs,
>                  DIV_ROUND_UP(KEY_SIZE(&io->w->key), PAGE_SECTORS), 0);
>         bio_get(bio);
> -       bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
> +       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0);
>
>         bio->bi_iter.bi_size    =3D KEY_SIZE(&io->w->key) << 9;
>         bio->bi_private         =3D &io->cl;
> diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.=
c
> index c1d28e365910..453efbbdc8ee 100644
> --- a/drivers/md/bcache/writeback.c
> +++ b/drivers/md/bcache/writeback.c
> @@ -334,7 +334,7 @@ static void dirty_init(struct keybuf_key *w)
>         bio_init(bio, NULL, bio->bi_inline_vecs,
>                  DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS), 0);
>         if (!io->dc->writeback_percent)
> -               bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0)=
);
> +               bio->bi_ioprio =3D IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0=
);
>
>         bio->bi_iter.bi_size    =3D KEY_SIZE(&w->key) << 9;
>         bio->bi_private         =3D w;
> diff --git a/fs/bcachefs/move.c b/fs/bcachefs/move.c
> index 0ef4a86850bb..67fb651f4af4 100644
> --- a/fs/bcachefs/move.c
> +++ b/fs/bcachefs/move.c
> @@ -292,8 +292,8 @@ int bch2_move_extent(struct moving_context *ctxt,
>         io->write_sectors       =3D k.k->size;
>
>         bio_init(&io->write.op.wbio.bio, NULL, io->bi_inline_vecs, pages,=
 0);
> -       bio_set_prio(&io->write.op.wbio.bio,
> -                    IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
> +       io->write.op.wbio.bio.bi_ioprio =3D
> +                    IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0);
>
>         if (bch2_bio_alloc_pages(&io->write.op.wbio.bio, sectors << 9,
>                                  GFP_KERNEL))
> @@ -303,7 +303,7 @@ int bch2_move_extent(struct moving_context *ctxt,
>         io->rbio.opts           =3D io_opts;
>         bio_init(&io->rbio.bio, NULL, io->bi_inline_vecs, pages, 0);
>         io->rbio.bio.bi_vcnt =3D pages;
> -       bio_set_prio(&io->rbio.bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, =
0));
> +       io->rbio.bio.bi_ioprio =3D IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0=
);
>         io->rbio.bio.bi_iter.bi_size =3D sectors << 9;
>
>         io->rbio.bio.bi_opf             =3D REQ_OP_READ;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 61e6db44d464..2e7bd5d66ef4 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -19,8 +19,6 @@ static inline unsigned int bio_max_segs(unsigned int nr=
_segs)
>         return min(nr_segs, BIO_MAX_VECS);
>  }
>
> -#define bio_set_prio(bio, prio)                ((bio)->bi_ioprio =3D pri=
o)
> -
>  #define bio_iter_iovec(bio, iter)                              \
>         bvec_iter_bvec((bio)->bi_io_vec, (iter))
>
> --
> 2.31.1
>

