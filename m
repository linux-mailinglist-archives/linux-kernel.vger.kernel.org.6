Return-Path: <linux-kernel+bounces-208621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA6B90273E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340C3284AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB2314D714;
	Mon, 10 Jun 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVV7wJzR"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8014D70F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037846; cv=none; b=b7qJtx3deF7cG9RJ1t/FIu2gk2S0hnj/oHRB46Mf1oho9bGxqFAq5sJkopq+isK60hwDpJSrMdcRoXsMwM+9Xy4jCZylAGXnr3a0sLlc0XGqw+eoeD7/o14LLVxTXJIwI45JqCIyTXqKVbh+vm93mAWlpaV9BsaLZVFlYIwuUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037846; c=relaxed/simple;
	bh=xlRyyKorKOkhZQWkf8a+nVC2AGE5Tsed48f95tQ+Bjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1gjszaoPuEKqt8MyO6hMeDApJt+7KQ8BZ2x4x8ZsecLmtNxRB66oN1lqiJjTRlhvQ/qOvsz3PHR53w+UB1yhgl5S+vCQEL0sN+rUje9rWpbP/gST06HQ2XoaLLGU2f9BwmP5tCbld4nOqL7egmiIjWIjgwPgQb5guTgYJGmSvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVV7wJzR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e57506bb2dso104422a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718037844; x=1718642644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWJrFt56Ba2XKaEKUnUCqUmu/jVW4Te91KO0JGqkT1U=;
        b=vVV7wJzRXeB3sZmGcJE71gHQuld85DUnCFugMhjYU3T4QniZ0LJvImsxKJxukpEWMd
         mTuRH8N/OOfUrus04eWls6VFT3/o+gPSxRffI4eRDy9T7Xqof+QPO1a6QJOMV1JnmwDe
         s7TeUx5LeDCoFcfm5rRMi5DFcuWl1DenPA/DZqGE3pU20Oy1JESvJ9h1sTEJIWKWNCzD
         SgbgztELPXPo27jutHk8cxDYpB7QYrthombm4u/RPTsFyv+JcS/R4X21B09nBwnymk3G
         cVp5is2P8G/gnoSEobw+YZVR4OBCPiGEh0Fq7mtaKOlgSbBrVGBHXIFTcI+GRpHuffEM
         CALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718037844; x=1718642644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWJrFt56Ba2XKaEKUnUCqUmu/jVW4Te91KO0JGqkT1U=;
        b=VcNUtyCwb5otC4ZreJ294W9Hck97jjsgDBtfZ/TpDZZAn15eoirEeX+be3Ylj1W/kR
         pncoRbvsbULHKSsYj+9Q9+D9AdEDSt1NlF8LR1Xej61Zg3p+jDm7UPGPSGZJaJKOaFl0
         bhIAlWrpxItVQNmtr5itFdHiuHhhBznCEYzkEAffm1pBm0z7gIH1cTRkl7Oc/fYxr5ya
         KMD53QrjVaKBGerzApZCY2p7n3YyK3qKlAb06CeucDoS3HeRgJFDjFdToaXYxiiH9oqM
         5G9UQVp1gYtgP0MFxCqPIc84CYC9sBpsCyqUG5M5y0OTvBy3Rmeq/C1UmXvRM5BmooA8
         EOFg==
X-Forwarded-Encrypted: i=1; AJvYcCVP1kQ9UuAfELaAM0NTNP1LCZCcayljT2W9QU7OtIqN8erT/BKXfgW/23D+/VvRku2qarwAHy6qHNiWPavqF4A0XVDySm5ueFnM5yHJ
X-Gm-Message-State: AOJu0YxqXd777+h8wx87b9t6+YQHfSx+cvg9OqywVMqD+pgT/ntBCHuc
	trjqDiwzKfXVVww+X6nGV/Cy4o/gIMWf9ff/blwHno1/FOE7Scwy8aDk8Ms6xQ==
X-Google-Smtp-Source: AGHT+IFO/T7QbJyG6RfIGM4sbC0wUi2kSF81e1T/t2MsMvtblCbstqePphSLuWts4/pUFHivpG5mhw==
X-Received: by 2002:a17:90b:1c8c:b0:2c2:3de7:20c0 with SMTP id 98e67ed59e1d1-2c2bcc4cd43mr8521758a91.37.1718037843726;
        Mon, 10 Jun 2024 09:44:03 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28066d57esm11358284a91.19.2024.06.10.09.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:44:03 -0700 (PDT)
Date: Mon, 10 Jun 2024 16:43:59 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
	sumit.semwal@linaro.org, Brian.Starkey@arm.com,
	benjamin.gaignard@collabora.com, christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org, jstultz@google.com,
	linux-kernel@vger.kernel.org, tjmercier@google.com,
	v-songbaohua@oppo.com, hailong.liu@oppo.com
Subject: Re: [PATCH] dma-buf/heaps: Correct the types of fd_flags and
 heap_flags
Message-ID: <ZmctTwAuzkObaXLi@google.com>
References: <20240606020213.49854-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606020213.49854-1-21cnbao@gmail.com>

On Thu, Jun 06, 2024 at 02:02:13PM +1200, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> dma_heap_allocation_data defines the UAPI as follows:
> 
>  struct dma_heap_allocation_data {
>         __u64 len;
>         __u32 fd;
>         __u32 fd_flags;
>         __u64 heap_flags;
>  };
> 
> But dma heaps are casting both fd_flags and heap_flags into
> unsigned long. This patch makes dma heaps - cma heap and
> system heap have consistent types with UAPI.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---

Looks good to me, thanks!

Reviewed-by: Carlos Llamas <cmllamas@google.com>

