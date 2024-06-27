Return-Path: <linux-kernel+bounces-232691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4271691AD04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC2F1F26C72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A5D199E84;
	Thu, 27 Jun 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="B2pBpWEb"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36FA19754D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506500; cv=none; b=usOo66oyjYprqmYTprGPV50juXbXBs3zf6OZR8/CiX0rQwWGU9IvA/AqJQajzM28VrAISqO0jor+SKvrhz3Hvo40RL6bP7lhW5Gg8uJUFbTGQMivNr3axCkYkQtTy9VpDi6PDJ77BsJKdt/lUOphNfGcaYAKsxJbI5NVJSiw+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506500; c=relaxed/simple;
	bh=u0CA2mnK5GIS2TbTnpjqwa5m9KRjDNpknWvMk92qW2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnLM1qhmie7buAEKVTKSWqANiiW9/9CV/KvaSDZjF8rOSpHN7hztUrzog6YxcgsOcBatV4FHmT21kLsHUhTIda/ehjIihuD1QNeACj1a6Q2+nFe0bz2o8KHRvwT7W+l/EWQSbHRZE5wM5SXHxrvG2NGoylVaNSvOmWKzJ7Y0xNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=B2pBpWEb; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79c0abd3ea5so124441085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1719506497; x=1720111297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+1i7NWNKVTSjYDCvQQ69OikYKqZtAzAKVkT15CSvLQ=;
        b=B2pBpWEbJ6HkRMvAQZPZ12Hd5pBa5jXYHw3MctRQFqxgEXHNuRTgq6axVAaxvKvdex
         QvuVJYMWGx0Dw+X/8cQGeYO8v108O8Xq/3jm6g//Irz1DRQLaJj1vfEIBqeuRm6UHiHp
         U5Odzvk27ti+Q10UJ1ymzB+MTauMHMaJbZfyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719506497; x=1720111297;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+1i7NWNKVTSjYDCvQQ69OikYKqZtAzAKVkT15CSvLQ=;
        b=gupfeg0e1RhjGc+jdrGIyipVR8Ta0qHvCMQAH2+kVoYDiFg0h/wGdS+KDXnAzpgo2N
         aElZkFiX7BuQEq0QDjwk2QOD0GgjczlR4Z640iY/QSEfk6FrhcpFI4yNTLaJdG9ZY1Mv
         I2IBTmQJyszYQwExfaVWJUOYmSS+kzFu5Nw85F1v9Jr0hR0jd9nURKaTfVkAyFxtFegN
         iCg9i65ozrq8/XINI9/feRThR/kHv/8Bh1A7iBrFZxpF7rXYM45szn8Rej112pIoQYTz
         CEL9CJGZ204idDnfDO9I373K66/gMW0XJvOz0cDpq8XijbEoxCOy5XL21JXidc7kolFm
         R1cA==
X-Forwarded-Encrypted: i=1; AJvYcCWxl1V0+WZ7/n15RYtyk8J8YXEcfUCRaD4i6aqrKeCyaHu14aj48Ekaeb6xj48MU+VcDavvciM0AgYpgBzTgZqAG6osydpLhbNkkSR0
X-Gm-Message-State: AOJu0YxpyjhGETq4WlG5UogFIvnsz9MRm4zeyB6tLrbx3KpUHK8jQC9+
	zIMoAHZYicCVOeUS9AL8JF2kvljqE9FIR8zf/tE3EuwFoftalWFr3j6btg2wjUA=
X-Google-Smtp-Source: AGHT+IEeTnN8ngM5bC7gmArgUEvjJbKIkAR2vmS7pI72qKpgM/ZQgCxZTMR+iGrWbz4yDAn+bW1Ldw==
X-Received: by 2002:a05:620a:2984:b0:79b:e70f:3935 with SMTP id af79cd13be357-79be70f3b12mr1542535385a.62.1719506497610;
        Thu, 27 Jun 2024 09:41:37 -0700 (PDT)
Received: from LQ3V64L9R2 ([208.64.28.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c82e066sm69457585a.57.2024.06.27.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:41:36 -0700 (PDT)
Date: Thu, 27 Jun 2024 12:41:34 -0400
From: Joe Damato <jdamato@fastly.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	horms@kernel.org, rkannoth@marvell.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v21 02/13] rtase: Implement the .ndo_open
 function
Message-ID: <Zn2WPhHOgBZFEvPE@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, jiri@resnulli.us, horms@kernel.org,
	rkannoth@marvell.com, pkshih@realtek.com, larry.chiu@realtek.com
References: <20240624062821.6840-1-justinlai0215@realtek.com>
 <20240624062821.6840-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624062821.6840-3-justinlai0215@realtek.com>

On Mon, Jun 24, 2024 at 02:28:10PM +0800, Justin Lai wrote:

[...]

> +static int rtase_open(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct pci_dev *pdev = tp->pdev;
> +	struct rtase_int_vector *ivec;
> +	u16 i = 0, j;
> +	int ret;
> +
> +	ivec = &tp->int_vector[0];
> +	tp->rx_buf_sz = RTASE_RX_BUF_SIZE;
> +
> +	ret = rtase_alloc_desc(tp);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtase_init_ring(dev);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	rtase_hw_config(dev);
> +
> +	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
> +		ret = request_irq(ivec->irq, rtase_interrupt, 0,
> +				  dev->name, ivec);
> +		if (ret)
> +			goto err_free_all_allocated_irq;
> +
> +		/* request other interrupts to handle multiqueue */
> +		for (i = 1; i < tp->int_nums; i++) {
> +			ivec = &tp->int_vector[i];
> +			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> +				 tp->dev->name, i);
> +			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
> +					  ivec->name, ivec);
> +			if (ret)
> +				goto err_free_all_allocated_irq;
> +		}
> +	} else {
> +		ret = request_irq(pdev->irq, rtase_interrupt, 0, dev->name,
> +				  ivec);
> +		if (ret)
> +			goto err_free_all_allocated_mem;
> +	}
> +
> +	rtase_hw_start(dev);
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		napi_enable(&ivec->napi);

nit / suggestion for the future (not to hold this back): it'd be
nice to add support for netif_napi_set_irq and netif_queue_set_napi
so that userland can use netdev-genl to get queue/irq/napi mappings.

