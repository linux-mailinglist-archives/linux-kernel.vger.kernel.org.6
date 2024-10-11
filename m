Return-Path: <linux-kernel+bounces-361217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF599A527
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36093B21BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8C7218D7F;
	Fri, 11 Oct 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxidC66D"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E6216454
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653744; cv=none; b=ZpE5fYIlHdpnExMpcHtYvKcOybevEwtrrffEHK7fcbAkgQ+PffCzss+yU8wt7Dx3FQk/Qdlvj6+KJ1jfyNDoAO6M3aSH92XLOmS7aocFVf/R5InTxIoA/Ekek0DCckhzslXZT214hsHlz0cFRHoKnMsW3Lm/O1Abb1Bvy/2EQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653744; c=relaxed/simple;
	bh=y583lHNmEbb4W3ps4BMPaHQpubte5hAb5QNlptwTOvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRoGUD8OFi0V/0VGW9T2b5Av6exnFTXaa4ADFR1BMKir/1KAxdndt8U44uV7/QoRnTcwjWL6wZ2GnxonTaZL3fB83NNHtCc8BpfpIlUjwMaaBpVONzpX64esIKgjSO4aLvSYw/51Wf2b1K3YfNIqCn3O1b2GviVzZcYeV6ES78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IxidC66D; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so2790898e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728653741; x=1729258541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNkFxIiVDl7PLS5v96RofiMAjJySrJbza+kK4tHaN2c=;
        b=IxidC66DR8FvO4LdQEfrXDGHAXUPBTqGFMnNjR1uzjTIAzq8YK9HQn+V9O2h0d9CCt
         Gj5cJ47t0JSreVBShArE00C7hsSGtgfuSOVG06foIqqn9sMwD3jPD1nNQeZt+ZePwEnc
         EoMkX6HbZXGqV9yEhc85P3AuQiRHwowcNv75DYEG0I3r3YdZauOp2tG9UP3/zlZ1Psne
         Gavg/R7eIbVFLaa+j6060cHijJSJ8wgtdnyoF1mRDXOQ8C970hWtF3dKxuCcyI3eKZN0
         silM3g9RmPXp6qlwJ9XqKeK9RtD6bQTfG49O2aRPVoLpJAphLDu0wL75mS4dRsGIZBZi
         ZnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728653741; x=1729258541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNkFxIiVDl7PLS5v96RofiMAjJySrJbza+kK4tHaN2c=;
        b=X9ltpBI467aLZFp2ME4BvaXWr98btrEzX5YNzG6T3B/p8Y2W6CuhmGWeeG+RpqB9z0
         N9cj3wr72iDI1UAiXMqpEW1J4tgKyWwWqW/pG34EMWh/3QxZ/dVim5/pk3ubKYH/4e9a
         gVAZyieHkex/D19y2H3wHPj8G9wGcJmOyH8OXUcLNkwY2X1AJwg5nmpMaXOUqCXzmqEy
         tPCJZxcbCo7YPPZhu7KSzdLH5EASbOnT6VQgl8/9KcNi1upM3Q6ZzffnuwM5tig5JpM9
         lSTDo+fqZ+/zqHLTeu3bZusGiItOY8ZHeNu3ugLi424bsGAbFNzxv+u3NwWu8HOijpQS
         Q2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWATEYDNGQzA1ZhQosx9+/vn6kd49fRQBqy/iie7M6m1MjF1KAYfbPWcKAqLGBim5qRnuf9zOclPAllnnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlbLYzzFV5QEV/9pcC3koprRZN58Ef/9Tzn8aF8okl67AE4QR
	Ya+Gj+i+4v/Q/4iGpdSuF0Y1TXNAHcENLwnwJo3Waixti0xszX8akZY8YV7UVAU=
X-Google-Smtp-Source: AGHT+IHnxNPVynVcrMck81D3auhtBQv0A6Io3oarT+knKEkNf7MmsUwWO3aUapPtGtAon09fEqgPLA==
X-Received: by 2002:a05:6512:acf:b0:539:94e2:a0ce with SMTP id 2adb3069b0e04-539da5aa8c3mr1616172e87.59.1728653741180;
        Fri, 11 Oct 2024 06:35:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e2de7995sm82101e87.122.2024.10.11.06.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:35:40 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:35:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 07/10] remoteproc: qcom_q6v5_mss: Drop redundant error
 printks in probe
Message-ID: <3le7xb2v7y6u3zzini33nj7netwcmhi4ged4ymzpnwkfbourxt@anlri4uawc7e>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
 <20241011-remote-proc-dev-err-probe-v1-7-5abb4fc61eca@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-7-5abb4fc61eca@linaro.org>

On Fri, Oct 11, 2024 at 03:09:15PM +0200, Krzysztof Kozlowski wrote:
> Do not print errors of getting clocks and regulators in probe twice:
> once in q6v5_init_clocks() or q6v5_regulator_init() and then again in the
> probe function.  This also avoids dmesg flood on deferred probe.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

