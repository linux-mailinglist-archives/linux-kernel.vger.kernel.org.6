Return-Path: <linux-kernel+bounces-534005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14ABA46164
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E27175ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF6F21D3FF;
	Wed, 26 Feb 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="lAYR+mu/"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0466118CC10
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578154; cv=none; b=PkCZmgmjxPAeaN9hlydmpWVM+SpZE18wyIRAzmiDnUID2ppudBv221hRw5/11qxoTEzS35/fOYjXDP65bPR9E1B9WWgzNf3WreqviikXEN/PuHtMr2zlojxe632vLqb8oG07q8dFtGmmmrgD57wixcUu0Zv05kg141ePMQvJVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578154; c=relaxed/simple;
	bh=tpF74Bc8nkP8DDuqSqjtD4uoz4vOJq3ZHVih9iTzIt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/xWig4n5lHlKIdcmH8+Ku6FptFl10+Ve8UiHBc4r3HN134o9olxhT+guX9jfcjjhLVnGreOk8/81B4XB2VclBe9P9e8iw2VBB54RGnaoAqri+SkBNfZzV2qCZ7FICYo6DMJKffg/l+DdKgf3SumdSM/fzovee5a7d6291X+qUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=lAYR+mu/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be49f6b331so661272285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1740578152; x=1741182952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhUvj0RFZy69SqBW6GfxIwgPOzkEGSiBv5ZaFs5vLVs=;
        b=lAYR+mu/irYh3vdlb5SDeFq7CpMNztR93KukqXdFXVPGZ9KC9Ufw9Ig9OZPgBYa1Md
         8/ElnANDGHczu4G9bQY4fTcZrGUfV9ngg/w5UytacABQ8tyQcWycaQ3eUvlxMs2cszyd
         OWT20NMpvSSewqYNMfzgbUQLZmU8q1zqhTiRhPUoiLDJVNvkp7ggp0tqjoAsVDxqtIKk
         D6lfq+gNBAuzxeeQCW5usUrjzubXBrmqPO2R1q2NFTeJxfe38vtZMik/iasIbQQMbuU+
         AiS25zMxtyGLX7EvYXg3Btz6xRGNSl5V4LstNOZVttiftLGyaRk3pVmXPnW7TWkINdgh
         7mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578152; x=1741182952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhUvj0RFZy69SqBW6GfxIwgPOzkEGSiBv5ZaFs5vLVs=;
        b=E8ZW7edGBaSzdmqEMqt2LImg6JR9zmNt9a6xUpjsLxq9a3B1YeH843G9dR9on+6ptD
         lX0nZZnu55wIaiwjbsH8UG6eTQ/Mg0HWfKfswSOE50jAK9RZod07sZMDiJ8e6hiaN+ve
         jSDtxMi3H9kz+7xctd6SOjJP+32yNuYgtyr6Pk/T0r2HrlamoOCWuWfC04dc4GbeKPix
         PvRQcWtb/+DETRVL6pZrR6hyJzwe23c8vtmhhN0sykQazvW99EZKVbix17RvQHOvTgBz
         mVbYo4pjFl5nEhFLjBCgQSu+IMsrAOXsZTEgPyKTeYs3aXuxUpOVn6r15U1zGRzvpkEp
         kDPg==
X-Forwarded-Encrypted: i=1; AJvYcCVnOmdQEfSd/pi4R7UfYrPrKKeNdmvXkH++s8FpSgfoWtok33oSAB7MMXJsxIeyyvNe0bztcWG6h88sqos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqHMfo9SpNDsDf4iDFmIre4pHkrGW03nsDI5v8S+M0jQD2fB3
	o4q8PbUtiv8MsL++dIwwmmYI6diyXZ9O3TscFDP8brEZZO9elbQPLG2JvME8Qgz4WTr8bzNJfbO
	jzzlC7+Q5J8pDaCz5jK1qxVAe92kmksqTlYolBQ==
X-Gm-Gg: ASbGnctVr/c4xuW/kpmAfQvfKhlvQw+7EyDIJmwe98ZnxpHM7/TcMloksSR5ZU6m1Fm
	ZKKcw08fUirQAOQ+j1ckIOyMbJo3QNVmePnuF0pzg+ange/Nt54OB5ORZxyQfg95PULaamhymQx
	evfn2CupeDjfKedIm8JYw2Y2E=
X-Google-Smtp-Source: AGHT+IF9JNVuuN8bPIEslvqP08Rm/fPznkmgjxA71qYbkp5tsuuoVM8OWD850Rm891NlxodE4XcG6gIPGkpGJXT6eNs=
X-Received: by 2002:a05:622a:1a1b:b0:472:1812:23d3 with SMTP id
 d75a77b69052e-47224716f88mr242782461cf.10.1740578151740; Wed, 26 Feb 2025
 05:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-apple-twiddled-modifiers-v2-1-cf69729e87f6@rosenzweig.io>
 <CAPj87rO3N2=3mNQg8-CUF=-XTysJHLmgArRKuvDpdk3YZ2xMvQ@mail.gmail.com> <Z75BwWllrew-DIlS@blossom>
In-Reply-To: <Z75BwWllrew-DIlS@blossom>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 26 Feb 2025 13:55:40 +0000
X-Gm-Features: AWEUYZlVeaWaGooIARJfI13M5E2woUVblHaLAgLiu0Mf6aUTrS-ZPIVERoXVQWc
Message-ID: <CAPj87rMpSbaOe0qEU8x-VFCGOvoWpyRURr=0bJ80=cdkTQiAbQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: add modifiers for Apple GPU layouts
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hey,

On Tue, 25 Feb 2025 at 22:18, Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
> > > These layouts are notably not used for interchange across hardware
> > > blocks (e.g. with the display controller). There are other layouts for
> > > that but we don't support them either in userspace or kernelspace yet
> > > (even downstream), so we don't add modifiers here.
> >
> > Yeah, when those have users with good definitions matching these, we
> > can add them here, even if they are downstream. Anything the GPU would
> > share out of context, or the codec, would be good for this.
>
> Sure. The mentioned "other layouts" are for scanout (GPU->display), and
> apparently the GPU can render but not sample them... You can imagine
> about how well that would go without a vendor extension + compositor
> patches......
>
> (Currently we use linear framebuffers for scanout and avoid that rat's
> nest.)

Heh, impressive. Are those the twiddled-but-not-tiled ones?

> > > +/*
> > > + * Apple GPU-tiled layout.
> > > + *
> > > + * GPU-tiled images are divided into tiles. Tiles are always 16KiB, with
> > > + * dimensions depending on the base-format. Within a tile, pixels are fully
> > > + * interleaved (Morton order). Tiles themselves are raster-order.
> > > + *
> > > + * Images must be 16-byte aligned.
> > > + *
> > > + * For more information see
> > > + * https://docs.mesa3d.org/drivers/asahi.html#image-layouts
> >
> > This writeup is really nice. I would prefer it was inlined here though
> > (similar to AFBC), with Mesa then referring to the kernel, but tbf
> > Vivante does have a similar external reference.
>
> Thanks :-) I wasn't sure which way would be better. Most of the
> complexity in that writeup relates to mipmapping and arrayed images,
> which I don't think WSI hits...?

Yeah, anything that wouldn't be exported out of a GPU API context
doesn't need to be in here!

> Also, the Mesa docs are easier for me
> to update, support tables and LaTeX, have other bits of hw writeups on
> the same page, etc... so they feel like a better home for the unabridged
> version.  And since Vivante did this, I figured it was ok.
>
> If people feel strongly I can of course inline it, it's just not clear
> to me that dumping all that info into the header here is actually
> desired. (And there's even more info Marge queued ...
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/33743/diffs?commit_id=5ddb57ceb46d42096a34cbef1df6b4109ac2b511
> )

I don't feel strongly about this btw, was just thinking out loud, and
also lets you move asahi.html around (e.g. split into subpages)
without having to worry about breaking old links.

> > The one thing it's missing is an explicit description of how stride is
> > computed and used. I can see the 'obvious' way to do it for this and
> > compression, but it would be good to make it explicit, given some
> > misadventures in the past. CCS is probably the gold standard to refer
> > to here.
>
> Ah, right -- thanks for raising that! I'll add this for v3. Indeed, I
> picked the "obvious" way, given said misadventures with AFBC ;)
>
> This is the relevant Mesa code:
>
>    /*
>     * For WSI purposes, we need to associate a stride with all layouts.
>     * In the hardware, only strided linear images have an associated
>     * stride, there is no natural stride associated with twiddled
>     * images.  However, various clients assert that the stride is valid
>     * for the image if it were linear (even if it is in fact not
>     * linear). In those cases, by convention we use the minimum valid
>     * such stride.
>     */
>    static inline uint32_t
>    ail_get_wsi_stride_B(const struct ail_layout *layout, unsigned level)
>    {
>       assert(level == 0 && "Mipmaps cannot be shared as WSI");
>
>       if (layout->tiling == AIL_TILING_LINEAR)
>          return ail_get_linear_stride_B(layout, level);
>       else
>          return util_format_get_stride(layout->format, layout->width_px);
>    }
>
> I can either copy that comment here, or to make that logic more explicit:
>
>     Producers must set the stride to the image width in
>     pixels times the bytes per pixel. This is a software convention, the
>     hardware does not use this stride.

Hrm. I guess more in keeping with how it's used in other APIs, as well
as more kind of future-proof in the sense of not needing possibly
gen-specific rounding everywhere, would be to pass (n_tiles_h(buf) *
tile_size_bytes) / n_rows_in_tile(format). That gives you the same
information as you get for other users of stride, and might help make
things more explicit for small tiles as well? Plus would apply pretty
obviously to compression.

I know it seems pretty inconsequential, but it does help for utils
which e.g. dump and copy content. And makes sure no-one can make some
dumb assumptions and get it wrong.

Cheers,
Daniel

