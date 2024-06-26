Return-Path: <linux-kernel+bounces-229933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C62991762E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5542838DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6102B2DA;
	Wed, 26 Jun 2024 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4D4pbU4"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93288134DE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369174; cv=none; b=LEyneKTD+SDCrKRb1XSo9ta9rquJQzRnEv3D/Z+l+lR4xy8bt717wigQ68WTpn28wOEXj9O55JKPncfufvWWsyjnzOIlYLPo8Ssh+Ugg7LkMvqs0VLJ5/D1n0m+CtwmQD9MOVprU/qz1Qz6XmLP7CyjwfPgo/dobW5X7wJuMWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369174; c=relaxed/simple;
	bh=wYLtnbnY2NNkZzxViIokOnau6BfM3jzZSdTVyAUN65U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrlqvXPcsASlr9Kan2EUY3nJroC78H2eMcL7h+puRYSNcTB8OubY1Jx3vYSLx+S81rF+IGD6nCHlXpy0mDoNjv74XLMDU0m54QzTRQLT4Vjpnn8EEnYr6ye0oCJ05vH+dGeeKzKQoiFhMsl86T88nDW8ktZqthBJHgfrzPOnxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W4D4pbU4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d22802674cso3211992b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719369171; x=1719973971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7svuScRKnlywk77bE54H55WY+OOGbn6LuxGj4BpG4uk=;
        b=W4D4pbU4VRwkYqPf9yZ218G7NLfFCJKpjpjUnGB/2FWaqoZ5EUE4NsuJ+QtAdXv1dA
         nlgxqO3fWFnhk0V2qXTrTY9egz8UlkuaSYoF+vdQzZc3HuMNBjrDGXX5tYT4yfLqEVEn
         9KHcrRHvdJsye7olcymKLRkbRzqW5QgqzolpPHG8jb3WQoe0TeKmxsbmTqsakKqG4w9X
         LRzHlRYYQmGBSV9iqWdoTO5b8xBog3oUUmorPZhGNDVqpvLoiecmeFNqPwnyJ9PdzeeX
         RFCGarxFO2ByBG1PqPg+t4Y7BP1sHaTjx5Qxb60m09M3/gsH/k/QUSJwwRdUJLCIUxbn
         dPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719369171; x=1719973971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7svuScRKnlywk77bE54H55WY+OOGbn6LuxGj4BpG4uk=;
        b=NuNrq5qwwEbrqddKBJMveHoHoP2Ff4sQjpBOM/LWox/V4oiwaNYiF9BcN1KeJknExm
         1GOE3Spsd88RtkVo1ZlbQJFRTqrbJ/HJHi78UKvFpfNSkb2O/mbF+CeND0WktKVpKDSN
         OPF62d5+hCPn0uN3wC5rsC1AHJD/NvBpZIL6ONNYuyYZVXdN0jWQj2mSTDOSvuxrPAxa
         9w8K3cw5gQinjOuGuvUZMNKiPeuV/BA01vrscOG/BZRt+PDAWhqVmHxvfn2UySQxfn4Q
         PMe8ax5rc29mxJsUJdbpS+GfU5oyUAaTTjFkguCmVklL4DZgcvBppgNUaJsHz8cJezaL
         16pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXbGyPaDfm1Bgu/qeKgp7aYYZ5S/aI3TLbeVQ7pP09jCiSjMYBnukG9NnUGiQiJ+4L4+RLoUqK9JQPvy33YkpEjWDhvP0j8/UMWqPf
X-Gm-Message-State: AOJu0Yx3NrpI2Vuf4daJRr8HF0ZcVwg5TvH4OIFng0BlXZmefEP/VQBS
	Wcvvn8slefz+sGWuB2jI0Uvk8WzqYn6ogrJLIyn9VYjYMk1pzZS7VnIHb/irRWQ=
X-Google-Smtp-Source: AGHT+IGSZgielOQ+Q/l+FxeqPFApSbxY8xldQDt14i1PgZfy/ZzOeS4mycbqgd/BPGqUzp6qGjSZKA==
X-Received: by 2002:a05:6808:144e:b0:3d5:5c77:fc2f with SMTP id 5614622812f47-3d55c78016amr3602949b6e.48.1719369171279;
        Tue, 25 Jun 2024 19:32:51 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70666de7bc0sm7084253b3a.74.2024.06.25.19.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 19:32:50 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:02:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	"'Rafael J . Wysocki'" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sti: add missing MODULE_DEVICE_TABLE entry for
 stih418
Message-ID: <20240626023246.pfpdosvde332c3ue@vireshk-i7>
References: <20240625220056.111913-1-rgallaispou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625220056.111913-1-rgallaispou@gmail.com>

On 26-06-24, 00:00, Raphael Gallais-Pou wrote:
> 'st,stih418' is missing in the compatible list.
> Add it in order to use the driver with stih418 platform.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index 9c542e723a15..1ffa23dd8907 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -293,6 +293,7 @@ module_init(sti_cpufreq_init);
>  static const struct of_device_id __maybe_unused sti_cpufreq_of_match[] = {
>  	{ .compatible = "st,stih407" },
>  	{ .compatible = "st,stih410" },
> +	{ .compatible = "st,stih418" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, sti_cpufreq_of_match);

Applied. Thanks.

-- 
viresh

