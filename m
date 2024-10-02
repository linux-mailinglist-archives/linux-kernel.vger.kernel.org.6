Return-Path: <linux-kernel+bounces-348395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE13D98E71F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1771F24332
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA7F19EEBD;
	Wed,  2 Oct 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWgx7/wP"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04A19E994
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912207; cv=none; b=diEhRXTMUyT0/UBi+2JPYX7xTaNIIrGS8gXjZpuzsh68QeRkmhdZUXDke4BHwYQpuqkuf1cAwNl4XBpluXLNVPgvRvy/qbHfuLYoqQmS0zX15FJh/DRLWMp38VsdyNA0Goyt8KBlRG77ENz0BOhJ2cERXb/4zITa7orZf6HHlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912207; c=relaxed/simple;
	bh=rOZgG+gsXianEKZTK5XyYy1qU43hBALX2PDyvo7vO2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDmV6DgdRBzLp3lo6kHyWwUOTj9N6uO6xB1lqykcHzrXnNA2krvV7WBphexQMz5BGRDhfhqrpNF6IeaMNUUpVHPHD7T42OenTD6MRNkpNfD0fgB/pROUDwiOjy+J/AMJBSO5CNp62yNHasTk4/oe6YCSGbu2Iz/KsHMBNEa7C5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rWgx7/wP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso348574276.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 16:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912204; x=1728517004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X024ptzefyB8VQ2TszNaeDmPmn0oYGPKjzQobGj4E0Q=;
        b=rWgx7/wPe1zK7A5YNRIEeyqBqenXF+ZVPUxCJnENjW3etWv95bS/qAKmujRMkTJk7G
         5z6EWVefC4cKbYcgahu7aOdr1nUNJqFecpGPbCbbxFRjwLb37yWUvXaTwu2JC2rwUnfp
         vI2a/XNc1Zj5YZojcf7i+BBdnT8DcbceeiDNUvxi51+VxLKSztjyRGRiqcQve24ony71
         UaUUvFIFkxA+hryLWPeRRHy7vqC9da8w9kEIguYQpZZwaT5iny4D8fU8WyTvLT65hNFw
         +rszm+H5yGpZ+6kwuaYWmZNrDl9MeK8X52OPFrCPaKIZphlt0nLfsZGkl0L8dAHsQ5ZA
         fQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912204; x=1728517004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X024ptzefyB8VQ2TszNaeDmPmn0oYGPKjzQobGj4E0Q=;
        b=b6sOQxJRZaPNGLjeI9QdYdXRwdpHJaKNc76TDxzmsDp0pWsOY9QaZ1lmmSt7zxqYFV
         VjTdzWnMiQ5s6BwxnbhmZRm8rMcvnltDc0auUC9Ws9W1h2Ry8hw6fIvJBH6Dcg0No13T
         FZWf/6pNjXZ8esRgcenmDP47a00uIA1rUxNp/w5c7V9TwX+4Nx3tv72rj4spKNGSNPZ8
         DkRiFDWGVYrpEamhRSgkMBhPkzutNlbGAxhPR9ZvrpRAY1Z2nUWxMC/EfxOH/7AesaMg
         8S8yu1bsxMCmOlcJrt2pISaOVyPYePole0umF+x67p1dE+Xg/eUnCTBFPLB7rupjsXWh
         3YEA==
X-Forwarded-Encrypted: i=1; AJvYcCVTdsxYIWoqeqBCVjnRZXABZMs59ETCiSIFLAZSKmW0tO/Ba7LJGX9HmMo42nLBrzgwn2cF/32qEHgneJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+MqUUWckhDirZWypjhFoHPnKkju/4fegxZ09wvSj8pgaZoW8L
	F30ZzwVC0mWLTX4vaQHIxOq7R1EkZA1kQyC1gL3KY8prL5QejFz/omN2ZNc9GpY23+nJl11FPOj
	fWdJE4247FmKReRKA+E4E9/UgVvCOe25eeK5smg==
X-Google-Smtp-Source: AGHT+IHhVLQwoAzI5exBQTwAX41kCwO1IgOgu326ohmJA+OTKU337eKS6j3/2WCTqoct9eNB6s7naZI4VA/F9HAIrwo=
X-Received: by 2002:a05:6902:2389:b0:e26:c80:d3ab with SMTP id
 3f1490d57ef6-e2638442094mr3736927276.57.1727912204640; Wed, 02 Oct 2024
 16:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918081640.1493847-1-yujiaoliang@vivo.com>
In-Reply-To: <20240918081640.1493847-1-yujiaoliang@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:36:09 +0200
Message-ID: <CAPDyKFqOT_C0hBp1QLNrxFWK1-ig1_zbWevcE5Koro+P5feoUw@mail.gmail.com>
Subject: Re: [PATCH v1] memstick: Fix typo in comment
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
	Jens Axboe <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>, 
	Ming Lei <ming.lei@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 10:17, Yu Jiaoliang <yujiaoliang@vivo.com> wrote:
>
> Fix typos:
> exectly->exactly,
> cylynders->cylinders,
> intersting->interesting,
> inteface->interface.
>
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 6 +++---
>  drivers/memstick/host/r592.c     | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 47a314a4eb6f..c0383959dbb2 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -996,7 +996,7 @@ static int msb_verify_block(struct msb_data *msb, u16 pba,
>         return 0;
>  }
>
> -/* Writes exectly one block + oob */
> +/* Writes exactly one block + oob */
>  static int msb_write_block(struct msb_data *msb,
>                         u16 pba, u32 lba, struct scatterlist *sg, int offset)
>  {
> @@ -1684,7 +1684,7 @@ static int msb_cache_read(struct msb_data *msb, int lba,
>   */
>
>  static const struct chs_entry chs_table[] = {
> -/*        size sectors cylynders  heads */
> +/*        size sectors cylinders heads */
>         { 4,    16,    247,       2  },
>         { 8,    16,    495,       2  },
>         { 16,   16,    495,       4  },
> @@ -1729,7 +1729,7 @@ static int msb_init_card(struct memstick_dev *card)
>
>         boot_block = &msb->boot_page[0];
>
> -       /* Save intersting attributes from boot page */
> +       /* Save interesting attributes from boot page */
>         msb->block_count = boot_block->attr.number_of_blocks;
>         msb->page_size = boot_block->attr.page_size;
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 461f5ffd02bc..544a31ff46e5 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -675,7 +675,7 @@ static irqreturn_t r592_irq(int irq, void *data)
>         return ret;
>  }
>
> -/* External inteface: set settings */
> +/* External interface: set settings */
>  static int r592_set_param(struct memstick_host *host,
>                         enum memstick_param param, int value)
>  {
> --
> 2.34.1
>

