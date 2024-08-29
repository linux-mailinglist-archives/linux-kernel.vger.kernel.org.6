Return-Path: <linux-kernel+bounces-306474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E03963F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5821C23BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650118C926;
	Thu, 29 Aug 2024 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jobFx441"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFD18C92F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922418; cv=none; b=GUBgX/xj2Sarkz/ZjBw3BMDGbeNVU5Sv+oqH7qiweOHhv694tf4tOgukw9bzv/o7qFD95tRHk6GOcie+GTmmPegBQ5zY5Kkg5G016RHsRWQsfSC9ZlYfIU6QvB0DCw0G+vzhFKVhygfJXYoPdgyFaHTA3VUwYtvMYULV62dLi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922418; c=relaxed/simple;
	bh=7eXz03uhw8DoH+SK2GO8uzlMczYV3nCsPFtaNJ0YIbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7kt0jfJ6WU3HE4mXt/aita0/5JKL8tE0plbmsaHbYygXiuepszGyiazaitwp0X9SkhHQpDHpCfByKrCxotDYVlQbpuSDE5KJPpfvLwfNagyXEAJzuKPOCWSIPBb2OtdbOStOv5D3NLEo4NEjn35+0TESz+2vi6dpS84Qk9sP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jobFx441; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5343617fdddso722625e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724922414; x=1725527214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0i+1aeEGq4rgf/d7rFiIlGkZZYQ3MiL0C7dIbTMOJs=;
        b=jobFx4410Ah+jCJKqR6V8zPUn6tzxhbOakmz0hNorb4kcNp4vSHCXbaS2ZpvSpInKQ
         ibEixe5WB4qG+r9tpbUJEDacwIjTIND/X0M67pz742T8Hamhia2BuspLdK29Z+1aijX1
         vbVtSdl7Y/kSKxU8+k4v+gz002RgVGkDattA90BsG4lAn7o4eEbfzBs4TCX08jDcPl44
         xsVF7RCQHvLPwVcLQVEXcgpgiYwqUInOowklBgmwpnBuCkq4AD4sFMJTkmMxjfXDXUpa
         vLdU4C1QWXic+iXs7EuQbZ7e2gNrd6YtOECgsggpSEGlTHsq4y1x43xkPXIPATqxn+QG
         o7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922414; x=1725527214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0i+1aeEGq4rgf/d7rFiIlGkZZYQ3MiL0C7dIbTMOJs=;
        b=F3pZiwt5tmVLwIE8ZBTP2VyFpHIVy8+Ob4yzX9hAJh/4+qxjoRxvAAtzW2pqkLaVwg
         NL8HEdIAqJg+u9ifrX3QGm5W2g8KyoGWDNqURvT3UFbolhgMVDE5q00JK/9P6YEVhm7h
         uqVdjPO/ECtnn0TfjAGe4jge4dPB8IWw5FbOdNnmZTdeG0DgXoYDGGSlKE927HyGYd2y
         bhf8jegZXqoHHhKNzRczyI8CKjVnhSGDfE3kCF8MlsoYhUeJPRwdLXNyHSzzVMuwOBEH
         kBvtJA8sEe3a/feMmFbHkAhWNAkKHo/L0CkzZEnSOikCu4PCzXAMOhaI9sQrmEeopPke
         djhw==
X-Forwarded-Encrypted: i=1; AJvYcCVZEzceeUjtuWCW13xsvp4OPjh3bBQrKBjjNNjPKEix7SQ7rbFHTXXMRo+CYPfiI/zPmDMPWeAP5xeWi2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUhJ24oy3DGEhrCL2XgE10dywb7+b5yQrqO5rd+jJgtvU/70E
	HmkY4O7OHyYl0SYR6AfW2JrH55QGGnvVrOXnV8mvKm5MFJ9qxshCMumy4Kl7a6w=
X-Google-Smtp-Source: AGHT+IFZAFiajCRKvVrZMT4gwxiPYEf4yoRnz8sc8Qm/VbyG8AogZfxmVe8CJ8QJj3rL4C+Jh1L22A==
X-Received: by 2002:a05:6512:2309:b0:530:dfab:9315 with SMTP id 2adb3069b0e04-5353e54324amr1735621e87.10.1724922413711;
        Thu, 29 Aug 2024 02:06:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac454sm102192e87.103.2024.08.29.02.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:06:53 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:06:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Yan Zhen <yanzhen@vivo.com>, andersson@kernel.org, 
	mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3] clk: qcom: Fix error checking for
 devm_clk_hw_get_clk()
Message-ID: <alrspfbadwth4v3f5q4nstjm5phd7ttqxyxx24lyye6lpqclws@v5dfuc2fsp54>
References: <20240827025252.3512746-1-yanzhen@vivo.com>
 <9ce5d7b09b5358c9190d8a999d79de23.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce5d7b09b5358c9190d8a999d79de23.sboyd@kernel.org>

On Tue, Aug 27, 2024 at 11:18:10AM GMT, Stephen Boyd wrote:
> Quoting Yan Zhen (2024-08-26 19:52:52)
> > The devm_clk_hw_get_clk() function returns error pointers.
> > It never returns NULL.  Update the check accordingly.
> 
> It can return NULL if the 'hw' pointer passed in is NULL.

No, it will crash:

        WARN_ON_ONCE(dev != hw->core->dev);

Furthermore, clk_hw_get_clk() also doesn't have NULL checks and will
crash if NULL is passed as hw.

struct clk *clk_hw_get_clk(struct clk_hw *hw, const char *con_id)
{
        struct device *dev = hw->core->dev;


-- 
With best wishes
Dmitry

