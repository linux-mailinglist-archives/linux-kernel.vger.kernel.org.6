Return-Path: <linux-kernel+bounces-179760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4898C64F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D681A1F23EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35F5C61C;
	Wed, 15 May 2024 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUx8Mr4M"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376059154
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768867; cv=none; b=gTMQbod6tMiChD4+nSXTVCJ4e9Eh6n5NIA1QwTCEBFtYAVddiAqUYHMJsXz5sdyl5Vkmw6vswbJDV4pi8TAt006q40ASSJvSM2oCDUJ+6L4xAiMSGPUJ0uR6KxntUTsVDNrnkoyazF8kUo+Lx0FP0g4JZMVBTgE4tFRjgwfYM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768867; c=relaxed/simple;
	bh=qWgM+RX/HiPQ3kWzHw+7XBTUnyzmv62HfLHw58tjQ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaXOrGr5n08u4NOsqBgVpjQaOUHAzR3wAIK2xDfrwt6/EXXAtOi9FdRruQGTH+fNOFuBRRUa2cfq/ij39whvSZRh3f5CxXnhClp6ufhoeRB5nz+SOL1NwrDLn81JG2PCGE6iwuoH8QGxwLI+/lFSINnYVxusjnjD/QD7D4nv5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUx8Mr4M; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so7374565e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715768864; x=1716373664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BTQ5oCj9CpU3fLEYwzFA19a0kicd36gmVExJVssytQ=;
        b=NUx8Mr4MaudsUlzqAg+jpf55flJZCGe+YdZvxdX+N+3PzkheTWIQ03oZWF4cEipais
         +d9BWIqw/VIUZlqPjCXdD2DDqKC/JTiazj4VenGfRsWREatYHhpYBBLVyxNgoejgpLrP
         I2Ix5Pe2O9CmEqTO5uD/9dHbegPyyNoSVB6LVGL/+foStahHJHbc3+ywAznB6JRH2feZ
         UCksbPMjOqks+nB93qA61JRebf9Q4k+R/2Kb6sPTTiJ/auRZw+QqtwLdcjQekHAWw3i2
         Fy35n9zWoY2RG3g3HT2mz2SVyK79SaFplN+vE67AtjOa4C/hrEBgs2BL63dsl3iDkuFu
         rWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715768864; x=1716373664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BTQ5oCj9CpU3fLEYwzFA19a0kicd36gmVExJVssytQ=;
        b=nE1vz4vn5Ps8rZ7RVvh4kiWQFYMjkOfM9Oi7Tpy6fYJI4lUQk6e0AokFFeAGz3FMA7
         ivLmnZdUxm0ascYK1+cZ3BCmapXaqE4KZL9HQtuVG+VcM4ytciju4HA70sZADMr/2SYp
         Omm+UHCR1MKeAZrLk01g/WXYSmEZ/yPO5qXaG1xxyaG9lHhrwpe1kvLPJbrQYmri4E1+
         Nf88XhnGS+mkUTDj8vdPV7V5LJKdx5tSt7FkZNrn0frNRtqFFUIjZjz220HFR1MJVhZh
         Xqqo6M/+bA9TJPirEcnp8mMJE6eJ3aIseYE9e2xiIdGnXGnCwynET7dMjJ3lF3uZnLMz
         QvgA==
X-Forwarded-Encrypted: i=1; AJvYcCUhOSHNThY2eRLIGX1GbJZv5KGY0Qg5rgRhz7OnRKK2HX7MHhBLS3HY49iqfcRpJWrzlBa4F8PcFG49JZUyHHRMG9oiveLcqZ1CetMt
X-Gm-Message-State: AOJu0Yw2kgFJvWA7VSZsxvdE8rNrrl2aLUajm/C7uG2dE7z3ISdqtG+z
	LSw16JoOUxnQz8l15Y0JYzBwyb3eQWbfajBokLJBJNGS+Eyaxs1Q1BkKNclbzLY=
X-Google-Smtp-Source: AGHT+IFfdE0wSDcpswRQGHdJ3wJuk/Aivko6hlf8NFc9hysPwbGoKDFxjddxqAciq7EqVqNTrIw0yQ==
X-Received: by 2002:a05:6512:230b:b0:523:a89f:aa57 with SMTP id 2adb3069b0e04-523a89faad5mr50980e87.56.1715768863887;
        Wed, 15 May 2024 03:27:43 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fe518a8fasm204238535e9.33.2024.05.15.03.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:27:43 -0700 (PDT)
Date: Wed, 15 May 2024 12:27:37 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/31] Staging: rtl8192e: Rename variable nPadding_Length
Message-ID: <1d874933-34f3-40b1-be1e-84ca7ffc380e@suswa.mountain>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
 <20240515045228.35928-18-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515045228.35928-18-tdavies@darkphysics.net>

On Tue, May 14, 2024 at 09:52:14PM -0700, Tree Davies wrote:
> Rename variable nPadding_Length to npadding_length

n and length mean the same thing really.  Normally we'd use a shorter
name like "pad_len".

regards,
dan carpenter
 

