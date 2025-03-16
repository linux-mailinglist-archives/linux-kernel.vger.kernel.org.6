Return-Path: <linux-kernel+bounces-562914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2EAA63499
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 09:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16F3171323
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6102A18DB1B;
	Sun, 16 Mar 2025 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="H1ImCpV9"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD542A96
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742112141; cv=none; b=akI+M+6tfi/jB5L6eOsmHT9s8jRogGWSFyaEjKxpsBgw0waIhBk9tJNdAnDL3SeTZRm1gsPJiohnXAWCvOqEFNhh5f6nZYK1ZSq9BDxZ9VOKbLOkGGMjRQvohmrL66BhXJlPnhcbxolgPQukFNWl5tjzGbPsqPXh2sAyAgrK+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742112141; c=relaxed/simple;
	bh=cttLIRELZi6ZZVASfH1p6HGqi2UXsbx/rQAHvxhTxbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkhP7hNsyQ/rsK9QIi7oRp+cyWpYc+jY70qa5fj8uVowdUZVLKRON/3i8IWRcRdOeqgdcZ1lvGlbAG18tya/Pu5BRhIioPjepbC7d9OKCNrtmzPnGJsuf2uO/dZDMDxANoO2y1z1nrQDv90+6UWqLgBMHNJI5cJ0TAtrq4XSX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=H1ImCpV9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so1631411a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1742112139; x=1742716939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZnZbUvNHHCM8ClClCv3gAetthjgMYIUsE6wr9GK1bk=;
        b=H1ImCpV9fArnX6fnn8lkZLDE1s1RCclxhdUb+fJCN7QRE4mW2h1fRGKjpp06YusvhP
         TyzJppH8R1EQPnGVgeZc2bkFcnIwDGcwTulEImDSASeOpQOj+Cwp5qXco7dY0evGFaji
         gPvuf5rPCNZv2j/mFfo0vfvWdQ3R6qie2JYS733OpNhXlmluqvW2U9BG6qZlSu/3mIlz
         oMuX2uGHo6ggrUGG6IBrPRJCd/Us/SMW1df8fxVBmj8IbT4VBSuDmix8BOFzn786OZ1T
         E71amuBpiHOQxEBJCoPj0YK3b9I8C1X2D+zXvqIpAZXGY2Y+PXh6X9dKM8FgSmVn3mi5
         IXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742112139; x=1742716939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZnZbUvNHHCM8ClClCv3gAetthjgMYIUsE6wr9GK1bk=;
        b=RdTdAnDI0wwKj1J1t7SifHaNa79xhmL1CyuFeQhkjTfYmF0VWMYFSAfPKmo4/n7VFp
         GJznkhLy/UJu0cVubuemj6LC6L4QJI5HWgvOdCSFevpMU2cWGztykvsvJ9Hv+00e70nT
         Kb1rt8XeFNlGl7tle4HrXFi08WYJPnZl6cSA7Cm7Wwt9VZZPaPNxBXOOgmhwZb2HY4CG
         T06txgWQJw96VTsqoNAXstAjCaznENyQ5kfist8M+77kjLYGAPg1EDczHeKpGIrbA261
         JZLPaK+MhUGGAS6JaXXKxkfblVBOYf6i9KZqTvC/hixMkzS52vIldSOBC5yk+eD8PW7d
         ersg==
X-Forwarded-Encrypted: i=1; AJvYcCU7d8nbAd3U0YrL1R/lsEIFalDNdst/v8Vhbv3zhvzOeGGcNg4aaCoNxKmeHZXMvK/ApheZQbEe3vQ28yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9d+kcvMr3fU8er/dm2LPIHottyknZ867lbhUrntQx5opGDnp
	OoKJ5SU/8+5R+65Jqrsqk4DRAgsxz1yeSqXboAzmZ0f/p82I0YfKG2uDa1bV2w8=
X-Gm-Gg: ASbGncsMdGx9fzkHp4q/KGP5OlJuUIsetXBZZSFX1M/0/m53VgaHerYiXgAolbuKMq0
	/TLrv/4Ys2Ol08oUWDYXlcTsvgm0FfTkKMa52uhlqOS+1Igx9i50YJD8nUTXYuBLTzF+m9VE/J4
	jblwRkLLiQFbtS9vIdZUAWlG+CEnZRpKZ8lTnvPmuLGZ/ccTamm6p19GYRU+z9plRMas4sGoJOD
	HDNHv8hm3sqrXEdJwbDbvWHSfdB4tZb9UpC3rdEGr7VrMMEBzYcxrzD0K9bFVdCYXZQTHh2hDfu
	Pb//Ik70rEKBeReV0c6w/XIMyleERYbLcBdaYnbel6UyVXCvVjzYhiis2yYxBisrIz8r8Q2M68U
	AAW0//Q==
X-Google-Smtp-Source: AGHT+IED4vymxS4RzWAOC2HBeSb/hVxVF9X0bf6Nh69xJ/x50+RouXKM14v3Fa38OCKl9/YHcz/lKg==
X-Received: by 2002:a17:90b:514e:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-30151cab344mr11117742a91.7.1742112138695;
        Sun, 16 Mar 2025 01:02:18 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688d93esm54326445ad.45.2025.03.16.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 01:02:17 -0700 (PDT)
Date: Sun, 16 Mar 2025 17:02:08 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/3] io-uring/cmd: add iou_vec field for
 io_uring_cmd
Message-ID: <Z9aFgKTUmcx-YCMf@sidongui-MacBookPro.local>
References: <20250315172319.16770-1-sidong.yang@furiosa.ai>
 <20250315172319.16770-2-sidong.yang@furiosa.ai>
 <da0445a9-1fb4-4b75-b939-b38ce976205f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0445a9-1fb4-4b75-b939-b38ce976205f@gmail.com>

On Sun, Mar 16, 2025 at 07:24:32AM +0000, Pavel Begunkov wrote:
> On 3/15/25 17:23, Sidong Yang wrote:
> > This patch adds iou_vec field for io_uring_cmd. Also it needs to be
> > cleanup for cache. It could be used in uring cmd api that imports
> > multiple fixed buffers.
> 
> Sidong, I think you accidentially erased my authorship over the
> patch. The only difference I see is that you rebased it and dropped
> prep patches by placing iou_vec into struct io_uring_cmd_data. And
> the prep patch was mandatory, once something is exported there is
> a good chance it gets [ab]used, and iou_vec is not ready for it.

Yes, First I thought it's not mandatory for this function. But it seems that
it's needed. I see that your patch hides all fields in io_uring_cmd_data but
op_data needed to be accessable for btrfs cmd. And I'll take a look for the
code referencing sqes in io_uring_cmd_data. Let me add the commit for next
version v4.

Thanks,
Sidong

> 
> 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >   include/linux/io_uring/cmd.h |  1 +
> >   io_uring/io_uring.c          |  2 +-
> >   io_uring/opdef.c             |  1 +
> >   io_uring/uring_cmd.c         | 20 ++++++++++++++++++++
> >   io_uring/uring_cmd.h         |  3 +++
> >   5 files changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> > index 598cacda4aa3..74b9f0aec229 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -22,6 +22,7 @@ struct io_uring_cmd {
> >   struct io_uring_cmd_data {
> >   	void			*op_data;
> >   	struct io_uring_sqe	sqes[2];
> > +	struct iou_vec		iou_vec;
> >   };
> >   static inline const void *io_uring_sqe_cmd(const struct io_uring_sqe *sqe)
> > diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> > index 5ff30a7092ed..55334fa53abf 100644
> > --- a/io_uring/io_uring.c
> > +++ b/io_uring/io_uring.c
> > @@ -289,7 +289,7 @@ static void io_free_alloc_caches(struct io_ring_ctx *ctx)
> >   	io_alloc_cache_free(&ctx->apoll_cache, kfree);
> >   	io_alloc_cache_free(&ctx->netmsg_cache, io_netmsg_cache_free);
> >   	io_alloc_cache_free(&ctx->rw_cache, io_rw_cache_free);
> > -	io_alloc_cache_free(&ctx->uring_cache, kfree);
> > +	io_alloc_cache_free(&ctx->uring_cache, io_cmd_cache_free);
> >   	io_alloc_cache_free(&ctx->msg_cache, kfree);
> >   	io_futex_cache_free(ctx);
> >   	io_rsrc_cache_free(ctx);
> > diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> > index 7fd173197b1e..e275180c2077 100644
> > --- a/io_uring/opdef.c
> > +++ b/io_uring/opdef.c
> > @@ -755,6 +755,7 @@ const struct io_cold_def io_cold_defs[] = {
> >   	},
> >   	[IORING_OP_URING_CMD] = {
> >   		.name			= "URING_CMD",
> > +		.cleanup		= io_uring_cmd_cleanup,
> >   	},
> >   	[IORING_OP_SEND_ZC] = {
> >   		.name			= "SEND_ZC",
> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > index de39b602aa82..315c603cfdd4 100644
> > --- a/io_uring/uring_cmd.c
> > +++ b/io_uring/uring_cmd.c
> > @@ -28,6 +28,13 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
> >   	if (issue_flags & IO_URING_F_UNLOCKED)
> >   		return;
> > +
> > +	req->flags &= ~REQ_F_NEED_CLEANUP;
> > +
> > +	io_alloc_cache_vec_kasan(&cache->iou_vec);
> > +	if (cache->iou_vec.nr > IO_VEC_CACHE_SOFT_CAP)
> > +		io_vec_free(&cache->iou_vec);
> > +
> >   	if (io_alloc_cache_put(&req->ctx->uring_cache, cache)) {
> >   		ioucmd->sqe = NULL;
> >   		req->async_data = NULL;
> > @@ -35,6 +42,11 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
> >   	}
> >   }
> > +void io_uring_cmd_cleanup(struct io_kiocb *req)
> > +{
> > +	io_req_uring_cleanup(req, 0);
> > +}
> > +
> >   bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
> >   				   struct io_uring_task *tctx, bool cancel_all)
> >   {
> > @@ -339,3 +351,11 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
> >   }
> >   EXPORT_SYMBOL_GPL(io_uring_cmd_sock);
> >   #endif
> > +
> > +void io_cmd_cache_free(const void *entry)
> > +{
> > +	struct io_uring_cmd_data *cache = (struct io_uring_cmd_data *)entry;
> > +
> > +	io_vec_free(&cache->iou_vec);
> > +	kfree(cache);
> > +}
> > diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
> > index f6837ee0955b..d2b9c1522e22 100644
> > --- a/io_uring/uring_cmd.h
> > +++ b/io_uring/uring_cmd.h
> > @@ -1,7 +1,10 @@
> >   // SPDX-License-Identifier: GPL-2.0
> > +#include <linux/io_uring_types.h>
> >   int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags);
> >   int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
> > +void io_uring_cmd_cleanup(struct io_kiocb *req);
> >   bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
> >   				   struct io_uring_task *tctx, bool cancel_all);
> > +void io_cmd_cache_free(const void *entry);
> 
> -- 
> Pavel Begunkov
> 

