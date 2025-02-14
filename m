Return-Path: <linux-kernel+bounces-514792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 655B4A35BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662DD1887F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6425A2D3;
	Fri, 14 Feb 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yg68Gh7v"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9A212D67
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529824; cv=none; b=RYvLztfLJRchUUcgPEaRVEU/1pCEq5+0uoKy1c/sBWUNL2hTJZ/U+P8Z0ljYskjoOr2mCS7AcegOQ+DOgXnOnYYXVxCgArlbM6IaQUEQ19aYbHqlPuNbWcnLyMexW0LMqOaK0pLuB5wj/TI4z2s7qzRSCkK2ZR73dStxI05iBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529824; c=relaxed/simple;
	bh=258ESUmkji2A70iQi0WVuGZY6DzAzC9+BBeqUcHI3MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq48a8UT6+ohR08fA/EYrWdPv8IVkYBgBhu5JhBG5qJ8RqVPVoy2fUQjoHH2VUkEVWg0lrxouesJuefJH5LCzq/CUmCc9751aYgRMcg7Ar7yqdlB44nS8/rWETnt3sq5sDtzxiGe6176BYuICd3lGh2BQzzySIaawVuCbAHtSQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yg68Gh7v; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-308dc0878dfso19926991fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739529821; x=1740134621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=258ESUmkji2A70iQi0WVuGZY6DzAzC9+BBeqUcHI3MU=;
        b=Yg68Gh7vH67KKH73fZDYm7O4pMoRUqhXWo7yWx8VJqAkXgLAu+wNXOxqTeV6cuoPGu
         DiYjj1e5FqP5sPZU6GibHiY7r01GRsNprprcw+JA9SONoCGIE57WXrm6xzI7LL6Q02D6
         x9/jVvGFgsSU21K7EZgV3BaaKzObeVc1e7XwP6CAYv6Uj3htJmYGDQYi2RcovrD2a/yu
         yZ/xy3IdPmaUVIrGlvtM3iHYtAnV36hda1spXVpQcHd9FfXdd1bBWOJPLKxLoeLA9HrF
         s3Lc9UGHljiigxciCF8oj5lAH15q9+jLp8IITd9rrF2/kuP8htqBrNi+XAAm4kNHlKvU
         gTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739529821; x=1740134621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=258ESUmkji2A70iQi0WVuGZY6DzAzC9+BBeqUcHI3MU=;
        b=w4hu6l8AVo9tmOT4oTOXc1hGZQXu2K2pfUWRFFjSs5bNxaWR8eW2VmWjHTn4YofQIv
         utrsc2RDYSc9uYIT6yCJyFPO57Y+nW+RgesvbZQim9WjuqA3W83S4mnZdS2VgGaDnTHx
         myd/xKHA6JJA6hZMX5U1RFL4pw2o+R8jyNMxO95jLB0hSVAHAaj+81/2oe5ojZVzwue2
         soyw/futmqfEDJVUeM/oBO7RFL24XzcgOj6MHiKpi1GbFDipE9u8FpwA10T6DB+Zch6Z
         /skGrYIh5ngMCBai/1abpXpE2/OyGmZHYvpjg2sGGoHL8jHQvu/mfCPg5SvQXBGgoehw
         duTg==
X-Forwarded-Encrypted: i=1; AJvYcCWpuCSKd4p111BsPS/qSwGRRPATUToAH4MqeDLOME+BwdVVEAK/hKTV1EHFAfIe/DtMhsowh+RCPVGnYV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXp1cmbOt7ammrzIZsWrLn3M/f8rLEC9TP27I4pBlwWoqtVOLj
	OdpdxSiuRMGlqT0whBm6I4OQVkzu4ZWaAPDGZnR9lqS5mbIrzltKHPeXOtZXtpEIxNg98BVN2Mc
	9lpyUbThYUuzDrgeVXa+x527StvL6TTlEmIB8jA==
X-Gm-Gg: ASbGncvFqmWAIgdhibZALv2KsUdy2QriFUuPHxvrQ/EVBMQI1CvYqumw+xsFhOZ8NdJ
	tRHf6gOrP61tLyV4vVwuXaPzqzaIJrenRPoJSCk6Vni6AuQ7+aBnax1GqWRJQDgnHrzYQeizB
X-Google-Smtp-Source: AGHT+IHIrJlrERpgwzo5wAuMDjjakD4AlBHd/8GGQfZyq2/tG9XCbPSB3xq9CnfI5XcNnXqNyGNdI7PPACfZeC6FfKw=
X-Received: by 2002:a2e:be06:0:b0:308:fedf:8c12 with SMTP id
 38308e7fff4ca-30903630e55mr39608221fa.5.1739529820875; Fri, 14 Feb 2025
 02:43:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213182527.3092371-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250213182527.3092371-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 11:43:30 +0100
X-Gm-Features: AWEUYZn045uEEhfW31xBwMEeZrHA-IrXYXkIgwYU0XEIBbh_Wqus8rfEf1lz-KQ
Message-ID: <CACRpkdZj2TtWh2CFb4f4DewO90C70e_3YdKr_DZYuQ6J4+z0Lg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpiolib: Make code more robust by using for_each_if()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Alexandru Ardelean <aardelean@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Instead of opencoding with long lines, use for_each_if() macro
> which makes intention clearer and less error prone.

Excellent patch series.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

