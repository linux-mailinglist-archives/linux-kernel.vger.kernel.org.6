Return-Path: <linux-kernel+bounces-522548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05F7A3CBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915B516EBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615062580D8;
	Wed, 19 Feb 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="kAn1zkn5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDhIcwUo"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4292580C6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001350; cv=none; b=WYiTQmIAsLuVoIC0+9wfXJ7Qc8UTgMBcDwUqufaHp+xYS9eTs0hzx66r99FtBPrCcGSkAelg+vRIbYqcjeDZLXgHktTvaIIL+OdQTo9ZKCGd4zqk2ZJQm8qgT5dhOBfW4z6BWtX/GkQa5Ho9oRiX970LlhDZve0h3CfxpsB1New=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001350; c=relaxed/simple;
	bh=hkErimOC8nju1yldPsKOsy/v2K2OGraVG6yJ18+yaWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzo5z/j+GtJSzloNowycNISrXONwI7k8H0e7ZTUFWIB5IGpT4PX9zYI1gC9Z2wmrtXxU7oOrLUcMTtmll77bd69W4zf41Tj2fGapApFEWvX0MeEEAK2fyioEQwKzhnxshh3LQ2xIoXOeADiotiyc+HstLIEQp7Vvl3Yem4iB7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=kAn1zkn5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDhIcwUo; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB833254018C;
	Wed, 19 Feb 2025 16:42:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Feb 2025 16:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740001347; x=1740087747; bh=ckcnFC2PEi
	/TmO7cPULgl0dHPxY4zBm0jXhpXxiGuI0=; b=kAn1zkn5CTBMQHc85TJn4GNp54
	yBhL6nQ4KLBHOlC0KYhJc0oFI7ChE1m+thfgNZvpaCp9qlNPS5BkpA4JpB+aFWAt
	7I23KI/Ofk2VW0katsRUzjDGCE1nmzmOoDmKWr2YECFD7pFU+1CMORVLrYu6h95a
	TIF04zLX6TjsZD2ZkFQfz+lIBGy7xpaI61JJzS0cJgLO2pPUthfQYpK7bO02bfwx
	U63JTkcJCeUVVM+KlVv9HLrgF69PtB+46tPCr1IL7b5Uzn8tODQnONOYDI+hZUh+
	SmmJp0jA0QNdSa7S8hjEi/1XYfBVOuq04rXDstRYQIH6SKiXXex4bcKhXYnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740001347; x=1740087747; bh=ckcnFC2PEi/TmO7cPULgl0dHPxY4zBm0jXh
	pXxiGuI0=; b=jDhIcwUoCRxWWzQWFmsutDPtpp+vzslaxY/L4oqdnu9qq12jI/q
	6jqbjDSvZtsyrlXZh2n4t2on9RYON2Z+XGsb3H02Y81MkYSj3SHxFwEbZYZCA9qw
	wfVtSPTNSQX7JXmpaoySl32gZ6EonoUdWI9LrW1SXFfXNoiVWCt6V1Pdr/dYWO83
	wJjos+LUfzVX66oeOMYnvO8l0//YdSSBGon23mERveOp1YfROjww/RHnV6vF+//p
	8lSxHgQQTpWGl7OoD+nKKT1CDk0XBfsywHadJAMFBcZeYzMXttT8P6OqCoUP6TPM
	NMALVx9sTxMQtrEsWb950Se/79X9unY0lmw==
X-ME-Sender: <xms:QlC2Z9c39ngTrLIR-pUp1e2ZDSqVDXpt50_5_BAWnNtceYgDiD4-LQ>
    <xme:QlC2Z7MMK-v5lL64fAvA_XYawEA-n7WvkSmro46xsQps1pGA7jLwczms-cXvY2oJ6
    YtseHXegfbOHirCDLA>
X-ME-Received: <xmr:QlC2Z2iSIbWgYnGoabTPE_aExzA8jOFPDBbYpRWoVVXv6mwbot_85uimy73hWiTDUQnwaHASr4LSd5UPm2YQuYWWwwQsHkNbeaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepieeitdduudekkeeljeekudelgfejgfeiteehvdehieehgeff
    tefhffehteejudeknecuffhomhgrihhnpehmvghsrgefugdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgv
    thdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hlhihsshgrsehrohhsvghniiifvghighdrihhopdhrtghpthhtoheprghirhhlihgvuges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtg
    hpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdr
    tghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepughrihdquggv
    vhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    shgrhhhisehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:QlC2Z28ymLWekoPMdfE13xKkp7QrzDgcm63LSTo0w2Cr-oBiEhHk8g>
    <xmx:QlC2Z5v3tAtzxb01J8Wmx9LU8B0dJzhMwQQW8beK34-8g9TpMEAfPQ>
    <xmx:QlC2Z1FLTcC3k1KoM6XoEA6x4WJOpEzhtjBPYVyho9vJGZ2sFZ-LKg>
    <xmx:QlC2ZwNp3XG5p5vUXjjpeO6T0t-J8evjpSDmehBmsZ6nmQUawKVVOA>
    <xmx:Q1C2Z_LMauPWkruA46Fq_ymeLC3b8TyzN3S_hcZGhflWySL9JMXa_uVA>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 16:42:25 -0500 (EST)
Date: Wed, 19 Feb 2025 22:42:24 +0100
From: Janne Grunau <j@jannau.net>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH] drm: add modifiers for Apple twiddled layouts
Message-ID: <20250219214224.GB57799@robin.jannau.net>
References: <20250218-apple-twiddled-modifiers-v1-1-8551bab4321f@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218-apple-twiddled-modifiers-v1-1-8551bab4321f@rosenzweig.io>

Hej,

On Tue, Feb 18, 2025 at 11:15:54AM -0500, Alyssa Rosenzweig wrote:
> Apple supports a few image layouts across the SoC. To begin, add
> modifiers for the "twiddled" and "twiddled + compressed" layouts. These
> are the two "standard" layouts used on the GPU. Mesa requires these
> modifiers to share non-linear buffers across processes, but no other
> userspace or kernel support is required/expected.
> 
> These layouts are notably not used for interchange across hardware
> blocks (e.g. with the display controller). There are other layouts for
> those but we don't support them either in userspace or kernelspace yet
> (even downstream), so we're not adding them here.
> 
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>  include/uapi/drm/drm_fourcc.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index e41a3cec6a9ed18760f3b0c88ba437c9aba3dd4f..6c289fc172c099ab32bf539a1698dabb93f9a0d2 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -422,6 +422,7 @@ extern "C" {
>  #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
>  #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
>  #define DRM_FORMAT_MOD_VENDOR_MTK     0x0b
> +#define DRM_FORMAT_MOD_VENDOR_APPLE   0x0c
>  
>  /* add more to the end as needed */
>  
> @@ -1494,6 +1495,36 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>  /* alias for the most common tiling format */
>  #define DRM_FORMAT_MOD_MTK_16L_32S_TILE  DRM_FORMAT_MOD_MTK(MTK_FMT_MOD_TILE_16L32S)
>  
> +/*
> + * Apple twiddled layout.
> + *
> + * This is the most "general" image layout supported on Apple GPUs.
> + *
> + * Twiddled images are divided into tiles. Tiles are always 16KiB, with
> + * dimensions depending on the base-format. Within a tile, pixels are fully
> + * interleaved (Morton order). Tiles themselves are raster-order.
> + *
> + * Images must be 16-byte aligned.
> + *
> + * For more information see
> + * https://docs.mesa3d.org/drivers/asahi.html#image-layouts
> + */
> +#define DRM_FORMAT_MOD_APPLE_TWIDDLED fourcc_mod_code(APPLE, 1)
> +
> +/*
> + * Apple twiddled and compressed layout.
> + *
> + * This is the main lossless image compression layout supported by Apple GPUs.
> + *
> + * The image is divided into tiles that are internally twiddled.  In addition to

Does the compressed format uses the same the sime tile sizes (in pixel
dimensions) and layout as DRM_FORMAT_MOD_APPLE_TWIDDLED? I'd assume so
but I think it's worth stating explictly.

> + * the body, there is also a metadata section containing 8 bytes for each 16x16
> + * compression subtile. By convention, the metadata immediately follows the
> + * body, after padding to 128-bytes.
> + *
> + * Images must be 16-byte aligned.
> + */
> +#define DRM_FORMAT_MOD_APPLE_TWIDDLED_COMPRESSED fourcc_mod_code(APPLE, 2)
> +

ciao Janne

