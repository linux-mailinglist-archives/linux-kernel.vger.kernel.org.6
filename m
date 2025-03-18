Return-Path: <linux-kernel+bounces-566132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE6FA67393
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE0C19A3AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4713320B7FD;
	Tue, 18 Mar 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbD2D1MP"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660020C003
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300092; cv=none; b=c0cAHDTbV/AfkqESJEqI8FcCPruNSFXE35W8xzCuNaHPOOUxetYffNsS20QAS33maBfrpCtKo+Z/e05PwCVvtIjbNoPGaTjOrrhWRKuA4TWLF0Dz3f3wWP19bx7XsYzQJNnD3hg2c4kl7C8jlHKoF0D/2fi/eQo11w7bLL9fxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300092; c=relaxed/simple;
	bh=Om9LWwSZhRbR5uwbIwSklW+JTUXChFeYWNKsyZInKxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqbt9nvOLHCeyJtLdNKU1E81eV9FWb1xw+uY0jdaaYxj0XGwQCE55/tZmZFc0uyqZTD6ZHX/orLVnpkf9GgLPMnNXvrMJaff9qA+XD80T6N63ZUGeawlbr7ja4PbKiKZ3z4KxZs50Hb1tPljXlR+GvhoB07jTazOgbIZXkyNGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kbD2D1MP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fecfae554bso49589527b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742300089; x=1742904889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1/y8nwDFP5hJBBvbUUG0QfBtnCqzgdSuPLHojeq2gsc=;
        b=kbD2D1MPMjnW9DfW0jfJ86/dLJ/M8uNfxysUkdpSPPvkZ+4vK1ertxocA1zmXH7h+f
         wiJAsKSNLeYcpNB1O6S43mFFgCnUP1hUyCfln5WNt0Z2+f7mW1s4uHkzX4gfIBomQk46
         EsJzKkrgbNglXfmls5Ld9b9aNfyBTZcXyRGha06ywVV620f0MaIoLCDO9V3QTCFhspRZ
         /O0RAROWYaZwUJZAk6dthBYRy+O8mkt6kwNuahlYhdBACkuPATyuV668LqLM4QRuzc8r
         awYvaudAa1x2Hk+Fva3RnWWWfzJs+cbxwl2UaBHEHHylI+5S+tI8TmcyV9jGxjjk6yC2
         fkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300089; x=1742904889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/y8nwDFP5hJBBvbUUG0QfBtnCqzgdSuPLHojeq2gsc=;
        b=kFl6bSvjy+3iaNEgEuE4E32RGr4AJhgpc00j2Fiflq/n4Pzoc6J1hpQeESgd/0NpvP
         gtz4wEE61KQKjzBnkXxQdW7gxVQe8d9dbq6sMruZpB8nfdu0eLB+1f/70wCe10c8H4Mx
         hsr8c3s9IE+5s8Whz+K/Ru6yFudoIdYjn/5YlxtHmpjP7oBp3LlkY5+ysJNKObZXVPFK
         aeBKaT1QV0vnySsV4D5dqdkVsJSwb86b2D92WckSUzSE34+FfBnZoOok/b0ioG0AH5aD
         HhwYgRCFbxaQwH7BgyqF2eRRv+9IpnF3JnBt7QjhLN1ZTFFud3Octk+2PNQyWTwXN9Kh
         v22Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbPWPX1R2r03dKmN3R7GDyT9xjzari44vMCj8BjbeetfoK6nQs8BVLWKJjNy/djMk9Fozoyhe1gc+UX6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRDKf1Ju/EerLu1vRpOSazxhktUSwLZvQs2E7lLGWSvq9Ft+J
	qqeApzRw5yKwdNJKPU/lUwZ2so7iPRUAwICgKEiFIS8Ntvev87ga4usboMe0ohwQ1XPW5Oxv7+2
	2dQEGPJbTPbcfCICCf4Vsy6l2h3jvnnmV0MErAQ==
X-Gm-Gg: ASbGnctbwesYyMtzFPT5LBc8iaYRvkct+P1nICJUsBWnjAompOgPhMMLd6Qk/QERfEQ
	K45Un4wYHl4VshjU67Hm3kiJOLjsv/eRRxDyXsLf8hQJbXwyIH7tddLJPuQEanuF7rtmZt5PnKd
	cIjgSZ7vUbS3v50Gp5zBrtXC3rFQQ=
X-Google-Smtp-Source: AGHT+IEb+NzrbCeNRdPzm3xEMtkofIje/IsnUYw+kILlbfLc0DlZPY9+TQaCk80CJVoK/tOOND9xyncng+d5HjDNmyU=
X-Received: by 2002:a05:690c:6ac4:b0:6f6:7b02:2568 with SMTP id
 00721157ae682-6ff460529d9mr218205717b3.32.1742300089569; Tue, 18 Mar 2025
 05:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f19be994-d355-48a6-ab45-d0f7e5955daf@stanley.mountain>
In-Reply-To: <f19be994-d355-48a6-ab45-d0f7e5955daf@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Mar 2025 13:14:13 +0100
X-Gm-Features: AQ5f1JqEJzBTaaSWFDJFRns2Qyn4YifFIkvKDJuCkDwbsG7HAzOkL1ON5MzrQiw
Message-ID: <CAPDyKFo8hyTJHZVLTAVXe2EW4FCPPLm39WWwpjOCqzUQnfNJ3Q@mail.gmail.com>
Subject: Re: [PATCH next] firmware: thead,th1520-aon: Fix use after free in th1520_aon_init()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Mar 2025 at 11:04, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Record the error code before freeing "aon_chan" to avoid a
> use after free.
>
> Fixes: e4b3cbd840e5 ("firmware: thead: Add AON firmware protocol driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/firmware/thead,th1520-aon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/thead,th1520-aon.c b/drivers/firmware/thead,th1520-aon.c
> index 4416e9bbf854..38f812ac9920 100644
> --- a/drivers/firmware/thead,th1520-aon.c
> +++ b/drivers/firmware/thead,th1520-aon.c
> @@ -203,6 +203,7 @@ struct th1520_aon_chan *th1520_aon_init(struct device *dev)
>  {
>         struct th1520_aon_chan *aon_chan;
>         struct mbox_client *cl;
> +       int ret;
>
>         aon_chan = kzalloc(sizeof(*aon_chan), GFP_KERNEL);
>         if (!aon_chan)
> @@ -217,8 +218,9 @@ struct th1520_aon_chan *th1520_aon_init(struct device *dev)
>         aon_chan->ch = mbox_request_channel_byname(cl, "aon");
>         if (IS_ERR(aon_chan->ch)) {
>                 dev_err(dev, "Failed to request aon mbox chan\n");
> +               ret = PTR_ERR(aon_chan->ch);
>                 kfree(aon_chan);
> -               return ERR_CAST(aon_chan->ch);
> +               return ERR_PTR(ret);
>         }
>
>         mutex_init(&aon_chan->transaction_lock);
> --
> 2.47.2
>

