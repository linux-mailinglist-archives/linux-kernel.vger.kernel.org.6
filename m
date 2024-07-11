Return-Path: <linux-kernel+bounces-248864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E092E2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218721C22DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEE0156F33;
	Thu, 11 Jul 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfcDApZ6"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900561552E7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688388; cv=none; b=d/QtoN6+OopIm9wk4zNdKZKsjSfRU9Yv/KLg+wug0rHOCm4A4drZDa44wyvbV8SnqyT1c4rC+buvuWPPa22k+TWCri9Ja/kMEJMhxpRXwHiou8iUWmyGxdLUw8j7TwH8UWxnpLp4vO16Uh/hARoxdTJgkJ+VVaOQu3fIxQwvP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688388; c=relaxed/simple;
	bh=tah/DfFII8seG9HeCL/p/DaVGC3NzKzcZAKm0yRPZjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUBc8sZGysfOjo37Sg3RL0HVZtBWduskyRxJubJnjBgioZY83PVmwyrSKMoUXYc0JEAuseJPjvLIEThoCV/so4kcFe0sSP2Fm4kJSfxG4c6GZOj3FSee7VMbaqUMmlv0f7tvWHTeEi62lrudI3Pb4nAJBv5Hj5rYiPBynNFllGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZfcDApZ6; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c669a0b5d1so339284eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720688385; x=1721293185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VpIsi5SvudMiqecZum2ED2ZMyreh7/IcDC+rpYXkJ8=;
        b=ZfcDApZ6peoUyWdEAmegN0+eQVtEsjLX+kyQo+IHIPkgXhLne9Z+UKdkb0cUWbY79S
         6rH80rplT2+PvETX2xxkCT7TPzS1Ffq70vCTAvqXn5NGf0T0HCnguDTNviCLrqwBGH4n
         hRcWXXo8U/Cc6efhp2qB3PC+E4TLC0v7VBvJVBiKxRxstoazZMEW6pfUL1pPfNd7Pny0
         4h6Ir6SpybS/kCRYt3XtrnxpAYCa+jzfo0Kl2EjroGoxlyPyiTlG3b3zwmzH9Bh8pFS7
         fJu9EPb5QjqLpR7d5zi0xwfFxEeKicNt2xoc0zbgjSiqwqr+oe8Fg5eRVkOTTJmAQQSL
         MVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720688385; x=1721293185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VpIsi5SvudMiqecZum2ED2ZMyreh7/IcDC+rpYXkJ8=;
        b=KdJUvCvAEQwxhKvRCyCZCeaCATZQpHCy3UcZIJnOkIdjg8Qb75389fP4zcHjP/j7VU
         O2De6Z+q9WIYa4V5yb4yDq/IjKuf8yGHZT5XTd3zcfj2BAGriNMmNagGFi6LgXpJt8FF
         vnv/2F6XjxahwLz11042pt9+PHyzhIb8Y8k5GRCYUAjiexzR4xSs+CsEI990dcAAoPlf
         bNv1s1bxUA8SH6QaeVqoU3WQ0KhbUWrX3npMhuNOc2PuLsLqmq1YCIMtw//GuUiP6iag
         23kMm11+SwfW7fq/L1sKVoS09VaOT22lHGKe1i+h7HXSOwZFmzXwYa7P0K9rUDg8JRB/
         TS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXraojI6T8QGD2S29rI4h2ixZhp9nWR38DWDiOhGuZ0+Do4liN8FYVjfXn/+5ZtFRhw3580T/E/Wfkx4EjCxRapSuB4tDF9xLj+6RfV
X-Gm-Message-State: AOJu0Yz+0MctBxO/Fu0vgIOoiK5N1XrOYdkPrSM3VE/fmtOGG2HLxws7
	ivTj4e/fJHV0fuVqPc/uVUspkCVqgYuAF0Uqq2hvYuJCYe8h40ScEa9v/3VD7tlSVQHBky3cHGk
	r
X-Google-Smtp-Source: AGHT+IFz7MoufwF7ME/+vUtnYtSZGgWCE8cKuvAjq+eK0TZ7k5ALjIyHsw2VXYYb+ScNAYbyLKSKkg==
X-Received: by 2002:a05:6358:c3a8:b0:1a5:575d:def with SMTP id e5c5f4694b2df-1aade041a1emr607781055d.2.1720688385673;
        Thu, 11 Jul 2024 01:59:45 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d5f0b202fsm3916579a12.9.2024.07.11.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:59:45 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:29:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: delete entry for Conghui Chen
Message-ID: <20240711085943.3tke64sk5enejs3v@vireshk-i7>
References: <20240706144150.2668-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706144150.2668-2-wsa+renesas@sang-engineering.com>

On 06-07-24, 16:41, Wolfram Sang wrote:
> The email address bounced. I couldn't find a newer one in recent git
> history, so delete this email entry.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68e3ef05facf..55bf8ba02386 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23842,7 +23842,6 @@ S:	Maintained
>  F:	drivers/vhost/scsi.c
>  
>  VIRTIO I2C DRIVER
> -M:	Conghui Chen <conghui.chen@intel.com>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  L:	linux-i2c@vger.kernel.org
>  L:	virtualization@lists.linux.dev

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

