Return-Path: <linux-kernel+bounces-311085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA569684B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE002281AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DECF13D529;
	Mon,  2 Sep 2024 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xc6vTKAN"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BA13B2A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273119; cv=none; b=WgovLjHssYXe3R/9bNzqerL4zDyk+qQtWFpl03Pr+m1A5aPFuOK4o0MnyZ/cMLVw6fKGW9jb2CyUakHGRYAcU5I6qeEfxg3aqkwJ/KHAhDAtZcDtUnD5oQC+filCXtqI66x+TiQKjEmfjvgpSByK19VXeL2KXTQlJh4xwTalbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273119; c=relaxed/simple;
	bh=E//9i3rBC3Mu3CinKYbPASsoeyN5yH642sDsswD5CaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXhTsrlcMhJS7nXB3x/yRdlRqOvzhf7CK1eIA8Hz9y9JAXwQjsNOUonhcQhX3k6E3HPc6F/VcGJ7MKla4kxBnY/NiTDaR5lYuxfBirUCdkdYhJzvOnGAjHDX2WSHsBbi08pcEHZnv0rXhFiFSMMLYNeSZceC1FBWhxw/TVYifAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xc6vTKAN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bfb50e4e6so17273225e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725273116; x=1725877916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZz5aEve9gJnmWAIJx6ZX5ka1gAEq2augQUIkDSiEzc=;
        b=xc6vTKANzErgDRMuW5u37LDUyNV9DPtS8Ig1rfVcIeApUZ8ZNJv7rjzO7DiXCGzNM9
         X4SU6jkE13mw3xl6iZMZWbrfeUvVv3qpWJZzOBJOPn7zd0nzjw/e1xUGfzePXBbOxxN2
         ak5iQbRqvJynlVLlb6cnrbmL9cgtBfzmd3S5NVyzM8LcacqmNzfcqZEJtRtLSXMqXN15
         nHPTOWfgeJHTZwFQPxkGOlklR7j++KRsjqzk0owHY9SPiiz/+/zb5++X6uRY2dv7+PMc
         Wa0c6rIiUmGHSu9nhNJUBVv60V1TaOy8UcSWv0cNdBBeqhpy+aS/dXomTQ+54j60DYLR
         Y9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273116; x=1725877916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZz5aEve9gJnmWAIJx6ZX5ka1gAEq2augQUIkDSiEzc=;
        b=HGOOc/4P2XcOfTdSro37rDAG0At2r4iF6p5E58cZcT/rjl4ruW2Xq9+JnLEoXAFEDr
         kgSf47g04O4uf2k6tqjg+jLJC0ndg0RjcL/P02AZg0U60oxEs2BFWNlZ+lDipxeri9s5
         fR55uVwFmQLtQ6BGpfZPDFYcpVGWUbZbTOlV5so3snJW8ShsZDfzw9M2VHJsItlRI518
         4aeMm7P3MoAlh2oyZnbenNFx3yw3icucSgWypcJPSimHdBSzndxwM2K0q815asl+7yvO
         awrI/nD9frP0NAkduWptYA5wxem8zVJ3RWvdrscTvy87HaTGT+qr4jGgcyvW8MVwTSxu
         CSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCI5zg+970DwwxSgclEP+FQu3PajZ3SEPufMH8PKFGD6IUXD9h9mVgMqHHGiTfJH8391VnPJ0+MW8RlH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2bIfK12HtyGe1EjEdvV7nFj5dh9fnWVqEC8Fn4+ptZ1KXGMyj
	G3svdfDbIEHKMobCkR+ZseEyF7yIbIzZv0bbJZ3rq+6HSFvWMGtGSD9Hrbwk4vk=
X-Google-Smtp-Source: AGHT+IFe+kSVm4VczVX0txVhurxYCvaDzKfUsg3clGmZJTp2CX77i8Kf9WevGLDkeTB1G96m7kOb8Q==
X-Received: by 2002:a05:600c:3d9a:b0:426:63ff:f763 with SMTP id 5b1f17b1804b1-42bb27bdffemr87907015e9.36.1725273115781;
        Mon, 02 Sep 2024 03:31:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baf1b0c18sm150196505e9.37.2024.09.02.03.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:31:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rong Qianfeng <rongqianfeng@vivo.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1 1/2] gpio: stp-xway: Simplify using devm_clk_get_enabled()
Date: Mon,  2 Sep 2024 12:31:53 +0200
Message-ID: <172527311082.25578.2725532526030192371.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820121651.29706-2-rongqianfeng@vivo.com>
References: <20240820121651.29706-1-rongqianfeng@vivo.com> <20240820121651.29706-2-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 20 Aug 2024 20:16:50 +0800, Rong Qianfeng wrote:
> Use devm_clk_get_enabled() simplify xway_stp_probe().
> 
> 

Applied, thanks!

[1/2] gpio: stp-xway: Simplify using devm_clk_get_enabled()
      commit: ece70e79868c75d946819db4fba095c8c96ddb32

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

