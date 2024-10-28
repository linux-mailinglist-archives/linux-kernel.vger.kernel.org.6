Return-Path: <linux-kernel+bounces-384481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D76089B2AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76329B2092B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7A8192B7C;
	Mon, 28 Oct 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3zh0Hr4"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F88190678
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105337; cv=none; b=fsc7uqzHfJm+73gTdN9Zq6ZUVZWMtl4Zs14O78KeFOEEtUEiVta9lNfzuuMFc6SHnnQAQo5oIGJN31ZX3qWYiB6UCoQ0NoUDYXTD7qAuo9oqa+OHiyJ1J26JGStftLhi42qTrAU25q+8iLW59IBzJndW2gOngM0OV4E6Wy0xfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105337; c=relaxed/simple;
	bh=j2xt+trhQJQXYZaSllPkx3D8Wpc1vrMkDLbDwCWMDOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/DuOYbs36NgtViTVEAdr0nNLeeTCsKlzA6yUBi7BV6qSJ/wgTWW9Oh5A15vK05K/R5McVdtcIscfrvDTMUCXsCjR27gg4Je7uN+ZvsAue6vpnPTb/ZvoKW3hLJ/t3m7yO9vhJOso3RfHZ0spyLtGOgQUGDuYCz1Y7Xk6OT3qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l3zh0Hr4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d495d217bso3835143f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730105334; x=1730710134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yH8rSI6GTPme8vkq348HNrx9rwQPSGuC28jjl3dlmxg=;
        b=l3zh0Hr4hplY7Z5GZlCke9s2uQ9f/DPcR6Rl6ZITB7YF7TVmnn0sDCWmHQj56HDCZU
         wXzqDZxcbMNghanFFryfwKrgsQf5NUnOnuCGaiHMN3LYIc01ldoTAZjwJ69ZsXoEOzbX
         TIfBWmu6uNKgm5NVa2ah94ZgnG5sSNX45Gl+kzRSGvnxYtTeNLjoeMJHDU5GN3NLkyl9
         EmdKHc6qro4nt9dgYzqGUxzZIz5lNy7ORhB4GISK1+160N1s1ghoccaJPmCgrLQ16RHR
         pqCFEJ9w14B5pa8lP4AKVobXwvAjDatDoZTJJMGmCzFl5J0jXS6Ph5YWzv/Q+QXgFz+1
         e1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730105334; x=1730710134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH8rSI6GTPme8vkq348HNrx9rwQPSGuC28jjl3dlmxg=;
        b=A31WVgyvNL8CNHn9wW6uvLCjroi+xaqkZfc7PvkX76HzO9Bq5maICtvifF/Kw/DUp/
         uLAGMDTTr8v2ikN0b+Duppo+nE0X940AkrRx8L05Q+tATwOBMuZqP6KBvUGxDhldS8N+
         V8OJxd3EuuqpI3LlPNZALcKR4zV3ArTBFE4f84s6CxQ6YL/ZsSTv5Jhi337S2YLTvmjs
         AA4p16ch6ymWXmqR7hQfyJfEmzYWOZAkAVkdueMr6kinDdIvoQRlXo7DnNQ+9YFA+v18
         HdEBpA2g96MAycFKpBS4iJiEqowf5ka1u7iHCEVq/x+CWxIBvMhUciRrWduCcCcP3jij
         Ft3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtqJPCNxNytWDL1DEFOXH4f4e0Lrd81esZDYBuI4waOXn/pHbrZNIgqkmsBmCnG2sUjk5qL9GQeIZipGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68I37H/ZGGlA/sFLGuzWPveryhNKNkBS+dfcV6PbL4csH/J9f
	1efvEdySu/k6aQEgY4gHwFdVQrMxp4hUle1rLEZElQfYaHsRXldiW+DBQ6szc2w=
X-Google-Smtp-Source: AGHT+IH9y5ZsNU0/1IZVAwqxMjl/THOn02DoTBZeJQXoIQD78iYBw9cg5G5ERRFPQ7WvpJL4YR5few==
X-Received: by 2002:adf:ea91:0:b0:37c:c51b:8d9c with SMTP id ffacd0b85a97d-38061228564mr7060382f8f.38.1730105333982;
        Mon, 28 Oct 2024 01:48:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c861sm8872842f8f.44.2024.10.28.01.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:48:53 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:48:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, upstream@airoha.com,
	Richard van Schagen <vschagen@icloud.com>
Subject: Re: [PATCH v4 3/3] crypto: Add Mediatek EIP-93 crypto engine support
Message-ID: <2c53b5f9-cba8-48a8-a9ad-9c72656b7479@stanley.mountain>
References: <20241025094734.1614-1-ansuelsmth@gmail.com>
 <20241025094734.1614-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025094734.1614-3-ansuelsmth@gmail.com>

On Fri, Oct 25, 2024 at 11:47:24AM +0200, Christian Marangi wrote:
> +static void eip93_hash_free_data_blocks(struct ahash_request *req)
> +{
> +	struct eip93_hash_reqctx *rctx = ahash_request_ctx(req);
> +	struct mkt_hash_block *block;
> +
> +	list_for_each_entry(block, &rctx->blocks, list) {
> +		dma_unmap_single(rctx->mtk->dev, block->data_dma,
> +				 SHA256_BLOCK_SIZE, DMA_TO_DEVICE);
> +		kfree(block);

You need to use list_for_each_entry_safe() to avoid a use after free.

> +	}
> +}

regards,
dan carpenter


