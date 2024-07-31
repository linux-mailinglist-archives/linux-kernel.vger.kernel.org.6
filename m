Return-Path: <linux-kernel+bounces-269584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B13943485
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ACD1F2640D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80441BD01E;
	Wed, 31 Jul 2024 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CeYuCnD/"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3E12B93
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444980; cv=none; b=hM5EJpTeR9TNZLtRz2ELMqjD8sK+MTImljjpgxQwiG21iCZIm/4c5hLMHJzqNBjTInJw1ddQsxKucQKtqIIZLwrU8prLYii5kW9qWaR3AbRbnF3Jb1gzJQRaU0m7iEADLu6WECZNnkAZ4L1LM8j8dCQmwo6Se/UZnrpvFm2ImUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444980; c=relaxed/simple;
	bh=IKLHxbuR0R9BOTQTYx5RDen/I6pf12f5piDZx2DS4mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eceNQz194bSQs4ny364mgskAw66ujzYlFY77RT7KKiCGfHjuAfDQepAyej4DRnk0oqS+JB8NnSJZK8fR4TcelQBaMC+Nor42R3mzM9iYdOmfEo7JUSGJlfNtNDC/5E7Q3k6lDNc1KDuYv7cvqD/liYPhOtdzz8zYSWtlnGGyjQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CeYuCnD/; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5c7f24382so3360889eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722444977; x=1723049777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kcpERRGU5dtW2iPAXxOu8gXnKquzRYp88DBD078J7tA=;
        b=CeYuCnD/PqrVffd/TEtCts0wY6bPovDPDK47cVyO7ybb/aYlBmGMyptbk5tPyYa7qv
         mQIywnD7Nh8e0wUEN+Q4ty6/1fdP+4feYx5miC1TiQgUgEyhQ+uloTS2orlKLPG0LIRr
         aA64Kf+ITd1pRVpisQDZ8Ff+kX+/4drIuW/2UeC0pP6BoZRP00rTTxyTswYOAN+6xHR3
         ASUpHDPbpPXKeqyTFjjrH4agVxDdMZjLu38AUZCA8fwXGdLgMVORE/rlJFM/XsM1H+UP
         LKkLdr5eKcDh2hrnaNvrT2Hp5wui5dTCo8B3QNiA67/PFrku9kq5Db6zPhp8p0hRHGi5
         hzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722444977; x=1723049777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcpERRGU5dtW2iPAXxOu8gXnKquzRYp88DBD078J7tA=;
        b=QF2BPFEFoGSVN0RlHjuaRimd+4E6A2kDrRvxWJ/c60oog/hwbbhGlgh9pPZKcT+AqP
         +CaJyFC14CmwcuQablDRF9rC8x5bM4ifxdXRyezUy5InWOaNZh7K7MuXpe2n7Bg5Y0+T
         ZzF3oRtpv4Xs952BM0L34kFgCDhZoQKmyNgXzT0U/7FCGv1Ju/CfpCStnegCmDj39HJl
         LahT1F1qTx2/HPvFt6W/XXGgnGuv6YEG1aLal8oG8dNBBZKkrTIn1WLu1Uht0dkX2qKJ
         MruM6D1z2ypj/AvXf+kUZXxwrZoEk0XDzUvMBIvEjqncUQBlFxEQQcCMndW4KT8ff/aN
         kbwA==
X-Forwarded-Encrypted: i=1; AJvYcCUMIKJF+qY3KbRAi62Ujl5C3gFqQTrxD1gHzv+ZjAhI6TU+J0NHx/nMKpHjBt441gb2mvCujjncly3WnGUleAk0XG0ECTO1jtRFSKHo
X-Gm-Message-State: AOJu0YyW4w4/4APYIGXU1ZyyZ98gD2sTEM7IMQ22ndMig/k7JMjAQ5jn
	AfkM1B76GQ053GFmKf7MVAjL5iz8ItawLOvr6xp7cMcOCwh/PFIk2oJHL5P13Bk=
X-Google-Smtp-Source: AGHT+IEufPjRxTWjzgVrtdmJzPJng6hNeQ52ulh+woNrCp/z6nYp0qwQuW3J63AoyMFVNDqa1RjA9A==
X-Received: by 2002:a05:6820:160d:b0:5c9:d9db:6a51 with SMTP id 006d021491bc7-5d61e3e28edmr105432eaf.0.1722444976962;
        Wed, 31 Jul 2024 09:56:16 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:c572:4680:6997:45a1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7095ad72442sm978393a34.28.2024.07.31.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:56:16 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:56:15 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: linux-sunxi@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] media: cedrus: Don't require requests for all codecs
Message-ID: <b3ab99a1-2e72-4b7e-8569-f7fe9beb3018@suswa.mountain>
References: <20240731164422.206503-1-linkmauve@linkmauve.fr>
 <20240731164422.206503-5-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731164422.206503-5-linkmauve@linkmauve.fr>

On Wed, Jul 31, 2024 at 06:44:14PM +0200, Emmanuel Gil Peyrot wrote:
> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> JPEG decoding doesn’t need it currently.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---

Does this change have an effect on runtime?

regards,
dan carpenter



