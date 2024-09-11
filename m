Return-Path: <linux-kernel+bounces-324447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8996974C94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5C22860F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43E14F9F8;
	Wed, 11 Sep 2024 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+/B/r9p"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20C2C859
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043184; cv=none; b=a/BsSI6rP6TC+sB0cBOsgCsZC7DdXfyZLnJThUEwdgtWcv36kSzEhI5Yl4JcvHT0UqEfwunzkbbPSk7DZuJjlYcUg1wvHDwDzdQwZSwtusGcjIwMzWEI75WjITUHqdomnFTZOsyhtq86wNUmkFGyjAnwWf34mt6HsKgY3dQoBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043184; c=relaxed/simple;
	bh=AG/8RtBynRt+mEGh3AS9RZKy1USA0iGqiFfWqJqmzDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw6EyV9PIFzL54ZOEsTJkOtSMPMGAvZLpnD5wEdkmTNqAaY8wRk4hunb7zFyd5N/ojC9/8ubufX+OtVYpgBf+qnh9/Sbg/saK7yIUKBCMqUD5Rb7pdXS95Mqv0RDm58mc4ro0oIeAajXlncdzitmDghq7SmW/IfyZ6UQ46rElU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+/B/r9p; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so56620681fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726043181; x=1726647981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG/8RtBynRt+mEGh3AS9RZKy1USA0iGqiFfWqJqmzDU=;
        b=l+/B/r9pkHmvXFCMPAHD2+7MjpS4StaVWBnqaKS7Hua6CBpT7ezSS8waIPqIrjWDsp
         Y1Ecincx+V1eu2FGEb4CVzeYOTvgSQphXfKeAoxXNtk/wl2Q+/kwp1FqkDdJEd5g+C7x
         UWS/c822jhx9Yu8DB8c0udkEZUYfED1g3FqjFAJ9cevYEkhEHWauK/N9e5LK9N4eTwQm
         QfFdfVk/ykVxhB/nDg8kVkPtbVKPLjX222G5VZvoLsW01ITCACRrUsJXEzOXOhfTmaYI
         2zoDlQRwUPQqpdeNGbf2UKqu9FSc7gn3I/Lmf5aucmx4Ww6ypR/3m2kNXsj5kDqRAH4B
         EQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726043181; x=1726647981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG/8RtBynRt+mEGh3AS9RZKy1USA0iGqiFfWqJqmzDU=;
        b=qNZs8PHDkXNPoiBxZuzYZtUS/N/zO54ssg3OhDfpcpUmnp4IkeZHvr0zRlQeMkzS92
         Z2YnU5MV5L2dwUII5l+VvHvfMG83vBXfuUiX/5ZxbSEMT/IJW5ZTwrcNmM7Bjm90mI8w
         cT0sjlw9f7rCgAYHemLiNDGgYiM+S+zq5An33dJiNgOCUOc5U0J1KPOK3fGOh0UK4yjP
         NXrp0FVu/jyM2b+NF4FSapUWqt0b+IkS//t8qwwyAcPN/dGchgqNK+6jCD3RtQxoZHPH
         D62vOFfhjasJISBhC1lVF50HvOwuq072u0I1m687metdg9Ss9E4MKe2rLPU6sZTpU5x4
         SURg==
X-Forwarded-Encrypted: i=1; AJvYcCVIp2bz82t9cWhL6fS1kjZP2V13lS/L2ysa5qREcn9EwziEHlALCFcJAR0oTnNoBzsAt3ITbYZfj7dXzvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGgBCKcRuLF50LRhFWvBLqOaeDEULtvxt/+CelWgKm2ROLYz7
	gJvYFwK5uGg4IbUqxsxewkiluuothUMwf4eGXp5yLXe8LNp3XcfoZY9mBSrzooHV+ZK2K6Eb842
	x7NucI7gj4GaeLzeoVyQhNp+dOFWcDNEoewSy/lrhBQDjsGzS
X-Google-Smtp-Source: AGHT+IEjiTjcEZy1dr3ZvMNOud/SL7eq3MhGmRuYcQFWDTE2sXgqA6CmAkpweizSlnMP5APvFB4W7TkNG6pa7ib+fuw=
X-Received: by 2002:a05:651c:1541:b0:2f7:7cc3:306 with SMTP id
 38308e7fff4ca-2f77cc30691mr9511981fa.17.1726043179612; Wed, 11 Sep 2024
 01:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909102907.9187-1-algonell@gmail.com>
In-Reply-To: <20240909102907.9187-1-algonell@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2024 10:26:07 +0200
Message-ID: <CACRpkdbbB3kMYvFTNSa_jhAw0iQHjFU+qKZZpY2goRvwL2hycA@mail.gmail.com>
Subject: Re: [PATCH] arm/mm: fix typos
To: Andrew Kreimer <algonell@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Sami Tolvanen <samitolvanen@google.com>, Peter Xu <peterx@redhat.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:29=E2=80=AFPM Andrew Kreimer <algonell@gmail.com>=
 wrote:

> Fix typos in comments.
>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

