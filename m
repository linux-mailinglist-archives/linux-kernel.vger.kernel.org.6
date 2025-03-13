Return-Path: <linux-kernel+bounces-559988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF8A5FC36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B0E170E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14F726B2DC;
	Thu, 13 Mar 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rWqf+0PM"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37F26AABA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884008; cv=none; b=ei+KqUXi2WuhkHOQgFB8zi4q15xZfUFKBt3V2TZq7VoCDMZFoWvY08XW1WkjL8ARnPn0URJ7A0Qjm0VwSaJoQbL0pVW295K+SrTN71S/RG4/t4fyy1ftaB/dHgmA+kP5oC88BX8K6kAg3OZpaQ6uUbbUhc3IyIu+z5GgrjFguVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884008; c=relaxed/simple;
	bh=GWLwb/in/ljzG15bf2lZCq2gdMYjM1TmRRBfkCLRuqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIKYZV3uKtOwwryOROq6DNLeOyW3ZXtIBx0dpF0UL9GNyGK1z7Nl5Nd8FcMhPZvgy5M3IJnQ04H9p/43vt77y+XyJVP0yE5t35K0ktdIr/xBeOUjs1yic1D0ByqUBwNb9lbHUvYSSLLMdViCSKM74p8nkVeTu9jex8qWJZ+RtqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rWqf+0PM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8fce04655so11150826d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741884005; x=1742488805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AU1db5kv6b5O3y8o3SsJx1lUw+kz3Y+K2K5M1PC6NRk=;
        b=rWqf+0PMKiCEcaZkh/n/kSfZHXtA7YK7bKZ5XT9cGoHGO4qPuc5/gUpqrb+O6nUW78
         6CrObp3C3UZqq35+BOgM2pJDk56a6Phf7jcgiCLWEG/u5sKv+8Q6wMymR1DAaIzPBTJp
         hCmqiYrRxiFdmziM/xnKCrGEw+0lLH/rkaDtl3OXpWsTUJrkKHxxFnlf1rRw1OKtHtLu
         A6XKWLEkAxrIkgE6JEMvKLI/24Y3IRWPQtBSulPjFM6etFLU6sUHRee8QfDdElDxZ/L2
         QnGa/LjUwYQKYVFNIdK0y9EyVUP0a9doLQ4f9Nq4iGDfWzl7RNIvfCLCN1gv7R2LPAP5
         NR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884005; x=1742488805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU1db5kv6b5O3y8o3SsJx1lUw+kz3Y+K2K5M1PC6NRk=;
        b=qJwOgHH1EYB5YE2VsFpjE3gRRqMe87Bl9LyFrESI6mVjaKCw3C249JS6QKPJB2+3xt
         +9nSZznydPlmF8cm1ivs8bgsXMt06D2vImGHgcpnPPJl9suAE5yt/FDcx0Cn8EqdnJKX
         +3U7W4049Xn5IQMF+91+qnOFjJD1SYOPtgemi3mEicF7Objn7sOqUsXOaEIFR5aX/lCw
         Y8/TkUv/mxYfnX7R5PNmSWnm9Jlhr8nSBEKY8Fx5cEWyy23n0YpwxeVGIPB0agauyueB
         T/s69yiN/VMi7G8tl0LplPAowh/3x1B7thvEgLtRRNHGNzPTQvPy12KoC045YaCRAC5P
         aDkA==
X-Forwarded-Encrypted: i=1; AJvYcCXx2MdFSZI9+R+Z0VPp+fQdN3K1H4qNYszaZtJnc9LjEYv8IAogsX9ccTo0ZQXu25Yf8339vaeNkBMfNIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7RUb8ZveAd5pSASuVmoNbsKrSvZJE+W6Mevqy6SBGvMcI5inU
	NOr1Hj6xR5A7jPz/eCsrYY+ohfFqqoWi6m/1rTEn01dhNFLszWDLxHUDf16vfrg=
X-Gm-Gg: ASbGncuOy0rys7Hvt7Qud5NNBTImE61Ek5yQg1oWR8S6QUqPjb3KVkmXWmh0rQFmUMW
	2y3ecNmjJ+h2O3OwjWdQjiRExO9BJ/3JDU/FXO2y8fdDqW56YrDIdUDt/1vtmNOCjwJpOl3Y9gS
	gQqhp3jPWvZ9V7ARJ2YPQnBrvDuZ9jcJieWjm0vjR7vRrxL5hiB75AuSHIoFc6xoic7zEgd0ipo
	wuYhLubdWz3GZmB6wXrZasqXESttmhlYo0KFJGlwFv2kk1scXeoWqcCFbo2RmhqQ7FIIHSr5gsz
	WqNkpVMAmX6QacrG6KTDPBb8MGxmt9QYfVzyKyRouORL6jWHSn11/eJyhXu5IZXVuRW+zU/bjnQ
	jnKHLgNzqgGwEhSvKi29rGnur5mc=
X-Google-Smtp-Source: AGHT+IFkbHVcwllGuGBIJA3zC1/en1QL/cRzQlTpw+FJ8AJ/Tz+liHnNiv/rq/e44ltwNEtCG6qzGw==
X-Received: by 2002:a05:6214:f62:b0:6e8:9526:5788 with SMTP id 6a1803df08f44-6ea23b41e51mr182171836d6.0.1741884005199;
        Thu, 13 Mar 2025 09:40:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24ea07sm11488136d6.66.2025.03.13.09.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:40:04 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:40:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 3/4] mm/mempolicy: Enable sysfs support for memory
 hotplug in weighted interleave
Message-ID: <Z9MKYlJW9WtotzR3@gourry-fedora-PF4VCD3F>
References: <Z9Gy-No6pXFWZAyc@gourry-fedora-PF4VCD3F>
 <20250313063416.703-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313063416.703-1-rakie.kim@sk.com>

On Thu, Mar 13, 2025 at 03:34:10PM +0900, Rakie Kim wrote:
> On Wed, 12 Mar 2025 12:14:48 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> Given that this adjustment is part of integrating the refactored
> structure, I believe this patch does not need to be split into two.
> However, I would appreciate any further input you may have on this.
>

Another way of saying this is: can you please change the ordering of
patch 2 and 3 and place the functional changes into "make mempolicy
support memory hotplug" patch.

It's a little odd to "make mempolicy support memory hotplug" and then
follow that up with a patch that says "now make it REALLY support it".

Patch 2 should read:
   "Refactor weighted_interleave sysfs to allow node structure to be
    dynamic"
Patch 3 should read:
   "Make weighted interleave sysfs structure support memory hotplug"

I think you'll find the patches end up looking much cleaner this way as
well.

~Gregory

