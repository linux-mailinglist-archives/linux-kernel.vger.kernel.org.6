Return-Path: <linux-kernel+bounces-287896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E2C952DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995EF1F24C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB57A1714DD;
	Thu, 15 Aug 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="anTMsZ19"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C01714AC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723539; cv=none; b=oZX6LTqznWzAlf5bm3V9qYIwP/orPjmDg1IqjIVLXsKrJ2p9YcJAGKqmURJFTMvAjIM3CTv+OKrs40/pRa+tEp52AJEv0ZBgG4u3wFHcHOKU87mFggqBMKz4X5aYgnNCKhKsyodXzllYk8Sg87lhoL60boBOfG+Sjilz5FjX+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723539; c=relaxed/simple;
	bh=bX+Z03KAir1AvRgDPM3iUP5NFkMq/MyZqnmhaxA+O14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8E3CUhNWirk+N+8lwNDndGipqNdAiavRu8LbLn6sAC76hMmlXnucZz3ueZdzL0xUlqEQvIMZDA4B2sa5rHqYgCCgDEnrX58Si0cSINn5dT5rTGOm5pmoQcj/xhkoy9uVJ3vcCTceaZFrYYBh9dJ4S+9oxd0tPPPLIvKySpzX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=anTMsZ19; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf7658f4aaso1597116d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723723536; x=1724328336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bX+Z03KAir1AvRgDPM3iUP5NFkMq/MyZqnmhaxA+O14=;
        b=anTMsZ19BWG7Fr5Z+SArmuys8mtWRtX/kZPBpVSpnoUrbFXv3nR1lWsKeD60dhjW8S
         VtHFubEIvQEuaHeuJNdEsVOAZFbOcND2//gfQSdJrPTh0MuOL9Y9yxoxch69+PRPn4Ca
         la1iwENRVmC4wnPkEB3noBWNg5OWbOhixMENhGWXxvmeAshk/seU0dXCsoHy2PJLOHhg
         UPlZScK4qA4rM+wXYSFJ2iCYk43TQEbusgnw9bsF9O6ZM0BDkEnI3CoPmF6tdm30jkjC
         pVIzuA2Ew5U34PQtnKobMqsXOFSw5oe+fEswqLM6nCfX7PVZfVsnpH0ew1dpoYa7exv4
         YfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723536; x=1724328336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX+Z03KAir1AvRgDPM3iUP5NFkMq/MyZqnmhaxA+O14=;
        b=hHzJ1797kTb5kv6o4z4D7297kGlMMdUx4volSzwwuNWhP3R3U1EARaeZIMSmpmmt6B
         DqzFfXAYzvcLRNFJMMM3xziwkz9lnQoHRewEMT4209HYWNa6PLGXTUamY1xzNnYM0Q+R
         1v/Bq+B9xW9gw6DuQvFnFMxNIUAMh8gKY1RkYySpuVKPdp3yxj7KKHgCzgGcIf4k42+g
         cEPLIBoZ0U/d6c9QWx8VifgQw+bJddWyTnWyab40+/PaozU2kNM2zPJ5yRERS8LW0JNl
         XT6dj7QBe4aLZ+Pd/bKC7PKj0J4kKnToL5a+1FiTIcjVCtwA2tOJUyxxZXY2c+RbMOhe
         Hv3g==
X-Gm-Message-State: AOJu0YzS8TAn5i0kfCqTQFQhTKhVwM5wZ+VeHGuQWjJB7aArlFc314Yf
	zn9XgP21Ototh5W8TJqGtHGhq/nGM+vZGDK7kwa8HG+T7KHUms6QHeNz6n2+qi0=
X-Google-Smtp-Source: AGHT+IHPJiOlGhJDc6291J9QgmSpFBfBzpYQwHmlzz1FILnpS5kT+SLIzITpRexaKsXRzXG8EOyBGg==
X-Received: by 2002:a05:6214:2b89:b0:6bb:9c14:8bbb with SMTP id 6a1803df08f44-6bf5d277e83mr60014146d6.48.1723723536093;
        Thu, 15 Aug 2024 05:05:36 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3107sm5805326d6.121.2024.08.15.05.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:05:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seZEU-002lfC-2K;
	Thu, 15 Aug 2024 09:05:34 -0300
Date: Thu, 15 Aug 2024 09:05:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240815120534.GD3468552@ziepe.ca>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
 <Zr3m4YCY7Ape3R6y@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr3m4YCY7Ape3R6y@google.com>

On Thu, Aug 15, 2024 at 11:30:41AM +0000, Mostafa Saleh wrote:

> Yes, s2 translation fault events are the same but with an extra bit
> set (S2), and with a new field for IPA which is not relevant here as
> we only report the IOVA.

Okay, as long as the IOVA is decoded and passed into report_fault it
should be fine

We don't yet have support for specifying the IPA on nesting..

Jason

