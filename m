Return-Path: <linux-kernel+bounces-260228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A093A4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860C0284ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE51581FF;
	Tue, 23 Jul 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwgSS0if"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866A14C5A1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754629; cv=none; b=hw1RkDb0/V4e8XWP3pha5J6X8cbxb3LRAm36FnGfLr9dGahMAsHf7OFhpoKu0Yh8ew9JoGhwC3b/ljUYyaOlZ5U7e1HIX+WxaujORpskeT7A8f7U4PY1HJS9pccFkDpjcSV626K6VsryIATcQ2+RpgTgjG5c2baGZ2exs8ypowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754629; c=relaxed/simple;
	bh=24QFWeFJW9cNgD4vg0h/nZ0B3GiusnpIEgOINcnaDNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmjZmVM6+TldcmuspH9/BT0H5KpT0nUoiBEKiRoYYdQlp3RuzfZDZFQh6b9mrXT9WVasHyOdA5BPnShdsNIYDJbchCd/odtpVm69s0uZcMsPd2JZwB8D+xfBoI9LYdQ1rK7RUaYoMUEm5tXqyo+5YSnZWzeTtIAyTFz21taQQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EwgSS0if; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ce74defe42so3200203eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721754627; x=1722359427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O8cpYfreI5j7rgcaJv6Mu2RIM9xL9FytkeVp1cbbhk=;
        b=EwgSS0ifk5TjFGBtLE2KTcR9gFr3QYs6nlrGvj1T+6/io8fX5JulMsHRnLiqYWigEb
         o2riHx8QoKORZuja31eMc9jyK0g3W0Y/0yqa/SoaJZ6vLqdZwjD3mwTSQ8t4GiYMdW5C
         oQSEAR6pnl9Lvr1pfx7Wy487nQNEEAUAd8TLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754627; x=1722359427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O8cpYfreI5j7rgcaJv6Mu2RIM9xL9FytkeVp1cbbhk=;
        b=vqwnzCGrU0mEOBhPT/ZTDfD0eM20Kgz53B4iBQ2MLEaJgI8uUbPQvMJaHgM8jQQQea
         NtC7MMfDuHxXL/M1vf59A8yo/TdqZkZ+mH54r9rwL6QeNWjcbuXS5y/l8xKPW+ARcJOb
         moTSYWgg8uKXyIcD2G4Jg6amFpCDJw+F8eU4TjsAQtPxxtv/e8ujbpeXcI4SGJQ1G2Hs
         SefeINWtZSQqbZgqMB7SqfDJ/ppBLx71Q6egGsUZRPSNT/GOkiR56A3JQW9nDYKTeKOO
         WZ/6yFrkpJgaBX9XcYSS/bZaEXB1o6hI1MohOZfRms43g70UUTOo3/n71D2D9+umbj4i
         M6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBArw8w06TYfSU2KxMnkgqLd7iKtK9PzVoqK0DwR515fd5AwiGy8EPfud+wYgiXl4ib5kcXHxhlqhLJjLBiPzkxvqtgCvd562CFhxX
X-Gm-Message-State: AOJu0YwrcDpkBIXvS3ExlqUFLSL8vRdMAptwQJvzLQsJfPlBa6dso9jG
	ZBLdNU5K80o1coy0czK7v0DdY+n08EOg+avrQsV+/Q1xUalxCA2TVBYk+k/7CQ==
X-Google-Smtp-Source: AGHT+IE8pxOJo0CXFT8R6oxSQXh2b6qZzDtVTVpt9uNQrpafHmixjvJjcL4DgSA1MhOA+rq0CDxfCw==
X-Received: by 2002:a05:6358:3404:b0:1aa:c71e:2b2b with SMTP id e5c5f4694b2df-1acc5aedf15mr1246068755d.12.1721754627240;
        Tue, 23 Jul 2024 10:10:27 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3be5:f451:a5db:11b4])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-70cff59fcb3sm7432583b3a.176.2024.07.23.10.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 10:10:26 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:10:25 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 3/3] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <Zp_kAeKx_NRag2-m@google.com>
References: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
 <20240723-mwifiex-wpa-psk-sha256-v3-3-025168a91da1@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-mwifiex-wpa-psk-sha256-v3-3-025168a91da1@pengutronix.de>

On Tue, Jul 23, 2024 at 09:09:59AM +0200, Sascha Hauer wrote:
> This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> using key_mgmt=WPA-PSK-SHA256.
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Link: https://lore.kernel.org/r/20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
>  2 files changed, 4 insertions(+)

Acked-by: Brian Norris <briannorris@chromium.org>

