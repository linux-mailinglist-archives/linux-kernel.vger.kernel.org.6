Return-Path: <linux-kernel+bounces-322805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D558972E66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78132B22802
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0874318F2D6;
	Tue, 10 Sep 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Va7mJJ4V"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D318B493
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961322; cv=none; b=PKffBJ8vfcLZcAQV3rVozmNrbAcOZau4KNQWdLwb6avbekDni9ueEkeQtzlP9BxHakgI5OkCVQdsaxNazb8EZml0yJO+6UUitMMBGKNj/xbvlvNOhjHQ4dnfAyDZchQmzt5Kv1ulFAvW/0AY/CiEK3vhR/rPdlVnf3S2Xj6aWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961322; c=relaxed/simple;
	bh=9VgJjVmZ2z3iHIWJKr+PVbZvKtgFkLWgVshWta/n0oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgALxjc88EQmhLOX1BN1ak3Yn0OUu9qUOAsXuqtlZO/9c9NVhPfqqKMLkGDYghtA6zCed/FHzQQ33tRV4lJ3cHqGrmbGhcQHU8PBGZ2jgY6cedZQCSXfRTa2FaPzG4vv8ph3iCschszUA9jgfOI0ld6Kaa16dYEq4Gix4/nlWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Va7mJJ4V; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3770320574aso3288846f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725961319; x=1726566119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/oY6ev45wkHlPwZhqCuB2CkZ0X5S0m6QlbT3d2XbjQ=;
        b=Va7mJJ4Vg4n5F22OuSPQWUw7LmKAAgM8pofWgYrhP6T/YnkTJKyDqhgU5M089k1o44
         ztGRkL7pVf31DM8c0dTBeh3PIOjjYb+CQOxMbIElBlF6fjXaNz3vx0cejvr9wH6KAvBk
         laoWl5XCGzyxl2+qg/rASrE8dJjKvg8SQzOF1VXGtnPzr51Uqsj1CSBDEnkKzxQQTrc0
         ri0NrNRzhK62Lp3s74epsG51afNeIOJuJCEReAdn812whX5U5TDDgpDzVbe7IbvBKv4o
         4Ui79+rvveoqMPsCwPh39O12XONzGkMWe7Bq5tZiXr1pJDB/JpYbLQG7+rlqE6PaigfL
         jTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725961319; x=1726566119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/oY6ev45wkHlPwZhqCuB2CkZ0X5S0m6QlbT3d2XbjQ=;
        b=NpFTkCkn/hAOoK52mtbDcypcBsBd3OxD8vPjaqtcTHrVo8Z7PVndqx+g8viFcp8Mme
         S9rKw3F62F0QQ8JpppO8RRtCnrxqzo87CTA/g2bL/s3BqqOW2lhN5QPr0ijc/TtKA3ts
         +4XBcqPByag/dt12zj1vX7K52ex+mwXZ9fVzUgaPDI7iCdITvpFkuvTFeQVPF06x6D5f
         gnddwNr8Sv4IXN3P/x6W9id7IJcWNg7w/N5KWbFyiGhhda6biVxMBe4oHJQS3aaD6327
         +vaMGY6xDwTAKE4tlBAhURv6X0MeLo3nQlPRK16cAQw3Hz7m0zVpQNT7tX+UTfXOyVfr
         WU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhuCDO5ANLUK0tr6iFKX0oK2P59JyHQoDrwI50sprNJFCEXfOxBCEKZIFFlGGQZgUjFeLG4jlYGByYP0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw27ZaHtBxlWyEnmIUx5Xhgh7S/U0ULRrEP/ZVHnleGzWqf/hFk
	JZDrqWtX4nLqpCbmA26TxuLvrYdPg0xkOQ77IX4h8vyaXUxZw5XsK9zf5wbG8aU=
X-Google-Smtp-Source: AGHT+IGkWtwB/f9V5AkytZZrRUhRw8yTBucrHpQCVigseOJkrWFmkVG2BpPk6J6yzN3QltddzmfKXg==
X-Received: by 2002:adf:eb92:0:b0:374:c42f:bac1 with SMTP id ffacd0b85a97d-378895c28camr7531799f8f.8.1725961318785;
        Tue, 10 Sep 2024 02:41:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb449a1sm104805385e9.27.2024.09.10.02.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:41:57 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:41:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Sebastian Fricke <sebastian.fricke@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Bee <knaerzche@gmail.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christopher Obbard <chris.obbard@collabora.com>
Subject: Re: [PATCH v6 08/11] media: rkvdec: Add image format concept
Message-ID: <8d8fe408-ad2c-4198-89e2-46ce973caa6c@stanley.mountain>
References: <20240909192522.1076704-1-jonas@kwiboo.se>
 <20240909192522.1076704-9-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909192522.1076704-9-jonas@kwiboo.se>

On Mon, Sep 09, 2024 at 07:25:06PM +0000, Jonas Karlman wrote:
> Add an enum rkvdec_image_fmt used to signal an image format, e.g.
> 4:2:0 8-bit, 4:2:0 10-bit or any.
> 
> Tag each supported CAPUTRE format with an image format and use this tag
> to filter out unsupported CAPTURE formats.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
> v6:
> - Change to use fmt_idx instead of j++ tucked inside a condition (Dan)

Thanks!

regards,
dan carpenter


