Return-Path: <linux-kernel+bounces-313309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E4996A390
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE4D1C23B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A122118952C;
	Tue,  3 Sep 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQ6KtiVh"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC21DA3D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379404; cv=none; b=e08s81t56sCgFrCPNQlREPYd3K0iwcf8xew8MNEgYUCcaLD8GB/+NqQ9YZtFv0WdfqRg9TYf1KtBpxNULGHDUlbvLsS2JAgDEmz9F+cvLjxsPn1RlqcaBcX2JFjgahHT9OmtvL5yceM9W2xexsuK60gij+QwwslZGwveXP3JsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379404; c=relaxed/simple;
	bh=TRpYNXWzJe9pe0LP0QmTo6lFgdRXfbDvjnKxBzy8RYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCcY+hRQBM8jErdy8FsEnfvrJ4hVBREUFEv8p8ftbP6+Yg4OUYrrmtauELOdxotuDFJzFfBJv/B5EgKvqQZ9faAEZcZxKnaS9TMVIl2lugItp6sis6ZtaaZWlovyASqdsOAZdas1aoZw2TAinbHCHgEUygTEINtVvVNambc7EfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VQ6KtiVh; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so5645917a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725379400; x=1725984200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRpYNXWzJe9pe0LP0QmTo6lFgdRXfbDvjnKxBzy8RYs=;
        b=VQ6KtiVhHcgAgWoHsXXQvnonjCHr74tiddzL3vfWujPb9ZD7ELQWskThCWDSm9rBCG
         kCYP7IjsVtKi9iK00oAKMkzsCiewV4yVUYyOFK0a3hwyj0Yb++PmZq9p69iZr+cFMo6S
         /ee/QApsSHBPpmC/2vdWouJK/OFOyGUXVdEJLuqlhqW78wLYxB3SIat9HU/zE4bK4TuG
         NEr0iXS46RMs+GZTmwsEw+KVOdgIk9kQFhFdj3ZjjlQBqpzLx3HY0rdMblwfgY+VkoIL
         JQaCM3mPMiQitjLCMDdn20YKql1HmcWvH+yIG+gL750TzZX0/aPxdCHT6Sk4Q32Wr/o/
         lXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379400; x=1725984200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRpYNXWzJe9pe0LP0QmTo6lFgdRXfbDvjnKxBzy8RYs=;
        b=BsmZ3PZncxIHwgfBG7axZnym4iKoBzoED+L9zCWUSbcpaskUVGbBunpFddktjGAgsT
         r2/CwL6Xgrsba8WYXQGtYbHlFT64ZRXU7g621mmBfcP06jjzc6DD7gPtu+EeeaXHFTsR
         L0NOuUdGZSiv37pxu/2C7rkK7Cax/axhHggTJzLkwwn2PBEYtbF1oMcPq3cilrhDrMiW
         42IJ2/QZNYiyT3OVfNsOGfPS3JkRyepAx1+motPEsKKEKv9/hYykON6X4bTbT0MDlarG
         DaT64ClrMZdoE8/uKX+rB2/dun7H/qPQ5jUHx7aCO4tZfYdmCY9wLqOuvIOMQfIzFz50
         qPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbmlnBIjzsB0cUNJ6oJB0PKHIixT54cgCFWzlVvw8NrQIG6ar3eHuIi825UJeqmet1t9rl/x0cNxlGF7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEYCtgWxGtf+q8ClGkKHnXC5LNbBtlFrPlrObtoNiNAv8/Uefl
	KpFpi9UrRTo5nBTPsmhsMf6VFeAb4RyzRHkz7iVkgaX8bZPGtIF8oWuktcqfLgg=
X-Google-Smtp-Source: AGHT+IHS1Rvzb8UqeT7n0pUD9/wp8DOfOLzfqdZFhgAaqZruEi5DiDVN2tFicLvnOryGuMKxr9gfgQ==
X-Received: by 2002:a05:6402:35ce:b0:5c2:7570:3a2a with SMTP id 4fb4d7f45d1cf-5c2757dc9a0mr1279823a12.17.1725379396617;
        Tue, 03 Sep 2024 09:03:16 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24733a74bsm4490101a12.86.2024.09.03.09.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:03:16 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:03:14 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, lujianhua000@gmail.com,
	lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de
Subject: Re: [PATCH -next] backlight: ktz8866: fix module autoloading
Message-ID: <20240903160314.GH12939@aspen.lan>
References: <20240820121628.42321-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820121628.42321-1-liaochen4@huawei.com>

On Tue, Aug 20, 2024 at 12:16:28PM +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

