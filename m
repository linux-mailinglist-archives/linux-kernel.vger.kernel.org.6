Return-Path: <linux-kernel+bounces-201271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB68FBC37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EECD1F232DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B414B07D;
	Tue,  4 Jun 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGVnyxLm"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873B13DB9F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528153; cv=none; b=EdN5iz3Po7K4T00OTLiAQa8H1fMWERet5wYEMf8dCWk0mN00VMWrqdNjL2tch2CZo6A5g+LiTGRXjrZGq93LBslFU5mx+g/F3+aE2MVBwff/EfUKdkAQ6P+jZnYkr6FDklE/oViOuJd6F+pzO7aATpS6lzio4CbBDCjBIHMhaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528153; c=relaxed/simple;
	bh=XwKCIkqkYBEgl5ZLKvPLvvtSlpG35zCzFjQXlbOyGj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbt3kMyPUQCBfWEPlEi01WIXKLagShCnUQpaqmpsrrOJK7i73FJ45ng3DyipdYX6/gabSGTjFqzN/6OvXQIrR1ZqQwwV64WnTD30hRCwG/crln1BeU4+eG6dHm4dNo1uR/6r+UxkAyf64avC10hN5fZzwT5ODP9bN+8cJbNRtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HGVnyxLm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a20c600a7so6767378a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717528150; x=1718132950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgB4DbGE6T1ikwhYmw4fa2hcF17RtM7yOsq39hT9I98=;
        b=HGVnyxLmkb5rgO8DdWN+3Qgpa7NYAyZaER/Y+DwRZmBxvlb6SSAvAQM2qzK0gqB9Xq
         VTshWOhAyxjROhpuXWjdS7+KyyHKjflE1qWfn13lIQzTQ7NzYJIuEVVGzyKoj7KLrSJr
         vQ++l5HAd3xS5mLKhzxbTosCGw6ElrJ6MSiRzG4GWT8HV9j9B8jTyCq1SonM7rrBeplA
         TOGJceC387Qry0OCcNZFZFIE98aiBd3pch0jrAGkuS2crg/ngHNwKDBxUxJf0AgO2qCd
         Q/9Famn2WLU28UjxNP6KQyIgTOEgdcfhDcEj1DS5Z7+WEEY66dkolzwbQV9+vSjdLV72
         yW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717528150; x=1718132950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgB4DbGE6T1ikwhYmw4fa2hcF17RtM7yOsq39hT9I98=;
        b=ELfohdGV5xb8E7QBETZ5wOoVRSP3IAmSvWI78iLskKalFhxUKNn3HIJwpRFe8wD6Za
         StYkpqRKZpqmJ+HunzTKfgws/tU/zGCvGatiEwDY+OMT7N6rpClh+/RWUkUHJ9KuHq23
         fXq97wKbW0KGxWcx6i1KCff+pbxiBOVwl16JKC4aBFv2bUaSYx+WZxzSAi4XzEf0Ttk3
         6g+YXROb6tIUWv8z7Qq3quZLOyBaKdzWM2J7P8xXe1GWJfpKIPHS7wV90NATykzcKOb2
         Rv5ZWcpmYnkTuN8weEFo71ynOK0M7SsV07QV99LKEOBIJQ4TFzp5ApfbNXWTjSOn3kmI
         FzHw==
X-Forwarded-Encrypted: i=1; AJvYcCXgFWw8fxoDjcsunPOMUdRlVydl7rjSaOJvLlGAL7Qwz7j7R5u3D8CE3S8QiVWHCWXG9oU0tEniuH6RE6g275eXrDP8dRK5yoU3qm9K
X-Gm-Message-State: AOJu0YymJewcW8ecwweB/RKFD6PPaD2MaDgy9qPxlroRzkwYdI9iYDZk
	uJMlHse+RXT3sczKSkzPEzWs0fcv2wd0WYPUWVQMC8H2GuDzb+g5Lvsx94oUV1E=
X-Google-Smtp-Source: AGHT+IHQGLFEtmqT9U+tp95hpWm2B8YC/v5PjnMpJnjq63cgYXkxFs635u1b0+F9sBKngRqYp/Xe5A==
X-Received: by 2002:a17:906:2a82:b0:a68:fafb:a16e with SMTP id a640c23a62f3a-a699f34ae75mr29653766b.4.1717528149569;
        Tue, 04 Jun 2024 12:09:09 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f8840bd9sm389463566b.20.2024.06.04.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 12:09:09 -0700 (PDT)
Date: Tue, 4 Jun 2024 22:09:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, jgg@nvidia.com,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Avoid uninitialized asid in case of
 error
Message-ID: <30b1fd0f-d43d-497d-b372-5218f7b4153b@moroto.mountain>
References: <20240604185218.2602058-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604185218.2602058-1-smostafa@google.com>

On Tue, Jun 04, 2024 at 06:52:18PM +0000, Mostafa Saleh wrote:
> A simple fix would be just to initialize the local variable to zero,
> this path will only be reached on the first attach to a domain where
> the CD is already initialized to zero.
> This avoids having to bloat the function with an error path.

Yep.  Since everyone automatically zeroes stack variables these days,
this patch doesn't have any impact on runtime at all.  It's free.  It
just silences warning.

regards,
dan carpenter


