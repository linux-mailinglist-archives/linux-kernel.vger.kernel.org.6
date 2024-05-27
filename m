Return-Path: <linux-kernel+bounces-191014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD178D057D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238981F266EE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE715FA74;
	Mon, 27 May 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="x3h2fjfh"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0015F32D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821516; cv=none; b=G1rsd501ZCaLKdb9Y1tCB4KfbfQzjQWA6bYwI84BU6EKZDGRyIxxci6cltewDMk8qAOvaUwas7+41tVzrGZQV6s/YYipijVK3RK0McQPRNpWk+6zn2ZLGD17U47l5OPHxNqKlEpQhfE5eU6trfmYUl1D/QR31CJfzdP1UvnCt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821516; c=relaxed/simple;
	bh=PzsdtZ2NobtBlpL/EaORk8s/DluIb9CT9Nq8llwgpMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGiaB2d0HYGBSV+flxzKq/n/2g57Hr5N7Ky8VA3muW/Aa9Gk4lh/PDI+1lC6e0VWS6gtP/mrmvxNcpNtAuL074Y73B2KNHWXaPlyCYNALApQVmDIJySaF6qVClwes441h5ipBEZXkwJ8qY9AoebXhFsvoSXLqO05XbNXHFLKv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=x3h2fjfh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4202ca70287so32920115e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716821513; x=1717426313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgX0LRXMWD/Tqcm0aySOB29/SX25LRJ7/gYjgk9c3wM=;
        b=x3h2fjfhFqgW5PljuiNxSf2fCvLLRz/vi6hzElING1/WfxTWTxZ2jRZ7x/OdUcm74H
         Y74gCiS10iD7XjTGdYNzc4mdlwlLmou70ksGLCDtFlDNmvfhWmilnTODwf4W5uPCR90d
         IZeg9bToKDxUrC2OYG2brAZmAsVq4TUPwfi+A74MjPcIgNZEDqz1J5GAwPTPysStcn11
         zjOTc4vVzlV4DF0VGlNilQnmIU5zMkMikkyZxdPmx2lDhO0IcUlN6qc8oYqm/3910kDb
         9Ma6Aov1Stq2ih4TXpqp/kuk6TzH7ieYShptSGvQ6IAV4VUoRWa6WqoIpyMgNf9GIEy/
         287A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821513; x=1717426313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgX0LRXMWD/Tqcm0aySOB29/SX25LRJ7/gYjgk9c3wM=;
        b=WwsiKagzAFLLawKWp1Fr0gkNR6XEHcTswvKJkbNxCxLOKKbWKDJWbpvhbLuxzFZq3T
         X+83l3Hgg+dQPiD3w09JpzkGP3+liNBm3DrOh+b+UmpbxHPVZch4lLVg9K+PKZlPIOJ/
         IfAvq/RzMylE7m1uUg+T/IhI7IhbMyKfKZ/WhgAzjQIw82XHpXqgp62bimEkdGSc2Bgp
         KDw4mxESWdRfoOwBOVBqNnmHHkry0x5VMzGc9lTNnQsc/c2LVjmLxprNSTJuOpWaeXRi
         pNkwTLEmGYLiq5SH7/srsZE5qq9MQKokl7fA5P+XTkEqnIEXN+khCXKxQynJq3bzm9wx
         dHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUONkMudwKoyE65WeNNhjyZpFF8gZisy5l02NRwGYAPDZsv97wYVXGsNqeV+FpuNHc/u6kqnZZAGdKi7KcTPVqe3nR471gSah6frq34
X-Gm-Message-State: AOJu0Yx04xPKcLmRqh/wzaNhNdVaPpefjWrDLVdyPp0cDK3+NhiYYeeu
	wqRWEO936Ga+c6cMWlTuwSJsOUZKzGVATP1AAE6OL1RM4C+xwbEYNPPdUUh4+kg=
X-Google-Smtp-Source: AGHT+IExJKlGVoq3XaadcSjgqIkZiy+up0Xg9tfAEuZhSfNBYOCHHBInqETUp5yzhZuOTviNJ7N0ZA==
X-Received: by 2002:a05:600c:198a:b0:420:2cbe:7efd with SMTP id 5b1f17b1804b1-42108a0d464mr110962095e9.31.1716821513105;
        Mon, 27 May 2024 07:51:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:c322:131e:ff9d:ef41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420fc82cc41sm123374165e9.0.2024.05.27.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:51:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Norbert Manthey <nmanthey@amazon.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] gpio: prevent potential speculation leaks in gpio_device_get_desc()
Date: Mon, 27 May 2024 16:51:51 +0200
Message-ID: <171682150857.156397.13252252218897228306.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523085332.1801-1-hagarhem@amazon.com>
References: <20240523085332.1801-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 23 May 2024 08:53:32 +0000, Hagar Hemdan wrote:
> Userspace may trigger a speculative read of an address outside the gpio
> descriptor array.
> Users can do that by calling gpio_ioctl() with an offset out of range.
> Offset is copied from user and then used as an array index to get
> the gpio descriptor without sanitization in gpio_device_get_desc().
> 
> This change ensures that the offset is sanitized by using
> array_index_nospec() to mitigate any possibility of speculative
> information leaks.
> 
> [...]

Applied, thanks!

[1/1] gpio: prevent potential speculation leaks in gpio_device_get_desc()
      commit: d795848ecce24a75dfd46481aee066ae6fe39775

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

