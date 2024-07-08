Return-Path: <linux-kernel+bounces-243916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B075929C5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A3528106F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E014A96;
	Mon,  8 Jul 2024 06:42:35 +0000 (UTC)
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CE01171D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420955; cv=none; b=dI9ao7NxffSrKxch5jbE77Hkg2Fdz1nNBeZhJWISCLrS8jxMwrM/nao48frZtMak7qyuqwLZp3FTnh4rZj/TRIXgCyUhY3/RCuG3sO/MsFcMWXw4R8rx4MxPv7pOwfJ+Xc9nACQAj9yTtuJa3X7MoAKQIlRXyED766DR8fQacmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420955; c=relaxed/simple;
	bh=vZlyhz9kZynd7BfQ52qoNRZBB2kYcbiYaSkTn8WajS4=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=ny1sVV4y+dz81VyvOt+1Y18Q+ewqwWiV8mmvHFB11ejgVDCJTnnP0wDudUSrWOFfIrwv7PPuUUwKTX2wQltANqqgQYzmYQG9nu7WOORwNwG7uVEfL4IJiagaZQpcMNuylpmCiUYAWyu32DElZ7nIlN89gMXGF8L27WDhBv9FeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=0933383879=ms@dev.tdt.de>)
	id 1sQhnW-00Ettk-5Q; Mon, 08 Jul 2024 08:24:26 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sQhnU-008AJd-4H; Mon, 08 Jul 2024 08:24:24 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id C90D5240053;
	Mon,  8 Jul 2024 08:24:23 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 38FB4240050;
	Mon,  8 Jul 2024 08:24:23 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 70A2A34AE0;
	Mon,  8 Jul 2024 08:24:22 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Jul 2024 08:24:22 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 linus.walleij@linaro.org, nico@fluxnic.net, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mtd: cfi_cmdset_0001: Disable write buffer
 functions if FORCE_WORD_WRITE is 1
Organization: TDT AG
In-Reply-To: <20240707094302.784948-2-olek2@wp.pl>
References: <20240707094302.784948-1-olek2@wp.pl>
 <20240707094302.784948-2-olek2@wp.pl>
Message-ID: <0135dec8e53837912712cb08ba2ddca7@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1720419864-67452D95-A9D6B882/0/0

On 2024-07-07 11:43, Aleksander Jan Bajkowski wrote:
> Some write buffer functions are not used when FORCE_WORD_WRITE is set 
> to 1.
> So the compile warning messages are output if FORCE_WORD_WRITE is 1. To
> resolve this disable the write buffer functions if FORCE_WORD_WRITE is 
> 1.
> 
> This is similar fix to: 557c759036fc3976a5358cef23e65a263853b93f.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/mtd/chips/cfi_cmdset_0001.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c
> b/drivers/mtd/chips/cfi_cmdset_0001.c
> index c10693ba265b..5404637e54e2 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0001.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0001.c
> @@ -62,8 +62,10 @@
> 
>  static int cfi_intelext_read (struct mtd_info *, loff_t, size_t,
> size_t *, u_char *);
>  static int cfi_intelext_write_words(struct mtd_info *, loff_t,
> size_t, size_t *, const u_char *);
> +#if !FORCE_WORD_WRITE
>  static int cfi_intelext_write_buffers(struct mtd_info *, loff_t,
> size_t, size_t *, const u_char *);
>  static int cfi_intelext_writev(struct mtd_info *, const struct kvec
> *, unsigned long, loff_t, size_t *);
> +#endif
>  static int cfi_intelext_erase_varsize(struct mtd_info *, struct 
> erase_info *);
>  static void cfi_intelext_sync (struct mtd_info *);
>  static int cfi_intelext_lock(struct mtd_info *mtd, loff_t ofs, 
> uint64_t len);
> @@ -305,6 +307,7 @@ static void fixup_use_point(struct mtd_info *mtd)
>  	}
>  }
> 
> +#if !FORCE_WORD_WRITE
>  static void fixup_use_write_buffers(struct mtd_info *mtd)
>  {
>  	struct map_info *map = mtd->priv;
> @@ -315,6 +318,7 @@ static void fixup_use_write_buffers(struct mtd_info 
> *mtd)
>  		mtd->_writev = cfi_intelext_writev;
>  	}
>  }
> +#endif /* !FORCE_WORD_WRITE */
> 
>  /*
>   * Some chips power-up with all sectors locked by default.
> @@ -1720,6 +1724,7 @@ static int cfi_intelext_write_words (struct
> mtd_info *mtd, loff_t to , size_t le
>  }
> 
> 
> +#if !FORCE_WORD_WRITE
>  static int __xipram do_write_buffer(struct map_info *map, struct 
> flchip *chip,
>  				    unsigned long adr, const struct kvec **pvec,
>  				    unsigned long *pvec_seek, int len)
> @@ -1948,6 +1953,7 @@ static int cfi_intelext_write_buffers (struct
> mtd_info *mtd, loff_t to,
> 
>  	return cfi_intelext_writev(mtd, &vec, 1, to, retlen);
>  }
> +#endif /* !FORCE_WORD_WRITE */
> 
>  static int __xipram do_erase_oneblock(struct map_info *map, struct
> flchip *chip,
>  				      unsigned long adr, int len, void *thunk)

Thank you for sending this patch upstream.

Acked-by: Martin Schiller <ms@dev.tdt.de>


