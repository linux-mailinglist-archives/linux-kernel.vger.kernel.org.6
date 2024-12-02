Return-Path: <linux-kernel+bounces-428070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD59E0C09
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FEECB35C65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5330A1DC197;
	Mon,  2 Dec 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q+XXGW9C"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0971DBB03
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160386; cv=none; b=ALHVi5EeoG/addFBGBOQDdPu76OrVj2jzh42d6aJtWASJnH+jRD19V/dgQGWSBaHUIQEJ3ZRioY4ACNoMjQd69jdIqw+4Gh85flLv5sAV2qwdy+IcZnzuLsesPV/fV+dltwPcvew2QTzK1lPLzWiMHcR8oEDjfUlvesT4cM4KcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160386; c=relaxed/simple;
	bh=ae8KEDqDkL/cV/eSqqI5LQ5Sz4A4iJSDek5yer/4mas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXLkMIObulnS1OovNB3IcWYH/FlqCoJoZpBTCjZW/V1bsUQc211/VYYKVfmtAMprgOmBq3ujQW9suztbDRUJwtuwYLb9CEcnZNfr0dh5ElYM4WwLKdGDYPJaLhFS9fVegbQ3Ot7Xev9l408yntIg0lc0y8n4L4bRQ8w6EUwon5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q+XXGW9C; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724f41d520cso2664649b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733160384; x=1733765184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQBhvBNYSI1fNvIhGqfRe5QD/yRE1BVFAKx554DMguU=;
        b=Q+XXGW9C0FWDu4dQ3yJ+/QAXjWFgmNfZuVmxYNASz0Scwt7sILT0XxiwLb8lNqy1Zv
         4JGcQtspluCwB3HaoEQnWG/yxkLkCIktyE6r/43NjulXEx4pthYkT3TGQCbEtqqOIpp8
         iU6z2QZ+bfDJyK3Z2EiJfX45rolzNrNiYIp6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160384; x=1733765184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQBhvBNYSI1fNvIhGqfRe5QD/yRE1BVFAKx554DMguU=;
        b=BHjQ5TBm+DJ3MZlaodGBaJVTuuvbR7IsrCM4DfjkJ0mGSS4JNpFtDh4OwBzeoacnKZ
         in3Hfnl2AcS2e8O1ecK3k2ntEbIgzaytkbVUMwEuPSxWRcI5evGQjsUPM5+P++j6jIix
         SDHbSRvNaoP6J2iErmwAbb63+Smc2o4Hnhx51kLigO6UpW7cwDa5D/4aRE7px3Q0jGkq
         AN3RFgvTKol+8irOYfqEGJCt1owGhEbXidEqd9wrkrhlwO4AfLS3xKI7EWiLiS3yQQx4
         qH2U/5Bofw0fIuthD38cOA8Var9cUjdBcAxF5Fl9NnC5+SqOIpRHbBLSC+0LphNZbQHt
         Rl5A==
X-Forwarded-Encrypted: i=1; AJvYcCVh753bQQM/X/kmyocTB9x+CnTXdIIYby3cmWBh+hVwzqDhKQBYcKCiaXcwT05RmtQj34wsno4x2B3Js6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5hiBygugoIJxIlYNZFSqfP3ENpI8IGPpkc4V/yieFwLUdJTQ
	FxzkRj/nfONtGTdnfdxvEj225kwWJpusQBK0ePU948zSTEspWL8ShLV7LIHuqqgM/XzaqCEl84U
	=
X-Gm-Gg: ASbGncuDB/kWYga6L8Qf/O+P+MXqXeN+MU6MrHKQt2to6F5VpvK5JmmPg+C2RxJxmiy
	BJGxocsZbn78OQd+5bbvH0iNKaaFq2p1vM3RkVtvkSeCKfsnNk9ZsfhAHPahLECATtGGXNp9hpT
	M1Zvg5t7osXLil9Jo1DbFhiMwssgKfRGyRoCUBD5DTwDGj3FLu3FqcADgj7qtoNQpxKGA6+x3Gc
	ZOT0udsnptynfyU88yG78H/7qEwebcpjxKtbfpn6GKxb0jSnExTwBWqbgqPAM9PQ/VUcJFT3j1J
	j47u8atbiUHIIRH0
X-Google-Smtp-Source: AGHT+IE8+oQ2K2atd5+VFharoEDGjdupgXSlE1aTfo1XUkAGnjif4iGSxVcIsHV0B8z8jcDUmE+cdg==
X-Received: by 2002:a17:903:22cd:b0:215:5437:e9b4 with SMTP id d9443c01a7336-2155437f92cmr177939515ad.54.1733160384312;
        Mon, 02 Dec 2024 09:26:24 -0800 (PST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530753d15sm72513305ad.52.2024.12.02.09.26.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:26:21 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2156e078563so14359555ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:26:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVc5tZDg7mPqY0eMjxLX8wZj0+Xl5IJGQj4UxukZWk5S9PzGBEyKHaAzRk2ovTvt+VgSh3AoKLRcu5gABA=@vger.kernel.org
X-Received: by 2002:a17:902:e5d0:b0:215:5a53:eded with SMTP id
 d9443c01a7336-2155a53eff1mr163851165ad.39.1733160379613; Mon, 02 Dec 2024
 09:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-fix-llvm9-v1-0-2a50f5acfd0b@chromium.org>
 <20241202-fix-llvm9-v1-3-2a50f5acfd0b@chromium.org> <20241202162454.GA2848026@thelio-3990X>
In-Reply-To: <20241202162454.GA2848026@thelio-3990X>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Dec 2024 18:26:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCu+gJb5aTywEnGDQUJYws++9x=be5QLsdSUqS=XjFZGnQ@mail.gmail.com>
Message-ID: <CANiDSCu+gJb5aTywEnGDQUJYws++9x=be5QLsdSUqS=XjFZGnQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] media: mediatek: vcodec: Workaround a compiler warning
To: Nathan Chancellor <nathan@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Hans de Goede <hdegoede@redhat.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi


On Mon, 2 Dec 2024 at 17:25, Nathan Chancellor <nathan@kernel.org> wrote:
>
>  Mon, Dec 02, 2024 at 03:47:17PM +0000, Ricardo Ribalda wrote:
> > llvm identifies that the SCP_IPI_VENC_H264 and IPI_VENC_H264 are from
> > the same enum type, but their are part of the same ternary operator.
> >
> > vpu_inst.id is of type int, so we can just rewrite a bit the code and
> > avoid the following llvm9 warning:
>
> LLVM 19, not LLVM 9, as the minimum version for building the kernel is
> LLVM 13.
>
> > drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c:597:29: warning: conditional expression between different enumeration types ('enum scp_ipi_id' and 'enum ipi_id') [-Wenum-compare-conditional]
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> FYI, Arnd basically sent the same patch October 18 but I guess it has
> not been picked up?
>
> https://lore.kernel.org/20241018152127.3958436-1-arnd@kernel.org/
>
> Hopefully the new media committers model will help patches like that get
> picked up in a more timely manner.

We can take Arnd's patch.

Yeah, this is the kind of patches that the multi committers can really
help with :)

>
> > ---
> >  drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> > index f8145998fcaf..4786062e879a 100644
> > --- a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> > +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> > @@ -584,7 +584,6 @@ static void h264_encode_filler(struct venc_h264_inst *inst, void *buf,
> >
> >  static int h264_enc_init(struct mtk_vcodec_enc_ctx *ctx)
> >  {
> > -     const bool is_ext = MTK_ENC_CTX_IS_EXT(ctx);
> >       int ret = 0;
> >       struct venc_h264_inst *inst;
> >
> > @@ -594,7 +593,10 @@ static int h264_enc_init(struct mtk_vcodec_enc_ctx *ctx)
> >
> >       inst->ctx = ctx;
> >       inst->vpu_inst.ctx = ctx;
> > -     inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
> > +     if (MTK_ENC_CTX_IS_EXT(ctx))
> > +             inst->vpu_inst.id = SCP_IPI_VENC_H264;
> > +     else
> > +             inst->vpu_inst.id = IPI_VENC_H264;
> >       inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_SYS);
> >
> >       ret = vpu_enc_init(&inst->vpu_inst);
> >
> > --
> > 2.47.0.338.g60cca15819-goog
> >



--
Ricardo Ribalda

