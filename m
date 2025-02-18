Return-Path: <linux-kernel+bounces-519183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7350AA398D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E147174878
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C135F23F275;
	Tue, 18 Feb 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwlSeUgB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C423957F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874391; cv=none; b=UjeWT+YTJSFwViyTqio+axoqLPnIMOchnTZNs5N4Pc8aSUnovwut1PfNlb5wZi+nvR1GUFy64CYksjMQQ6JQ5AvzFAlBGVSGZWE0MYoHxOeoGxS9sTdyc9l0VUE7sCEBT7lCDD2eX8WSuIOV47LMGbcG6ASuNHnrHFxl58B1k2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874391; c=relaxed/simple;
	bh=lTGVYVOIgtjNSuSseJT7KQGGiUReOwLr3tUic5SDfP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MrGoVi8L4xh0iClfRXbKB+Aorc7fGfT7wgNLkJ98tDww9Wdz1dPJLetllBJZDTqLM8kg5Y7LQfJ4krfaBYDMBuxVTQiO9ZuRtOSYH20L8DBlF/AsmeG6HqhMxqybdWpfSMCfcx4TU40i6xXVLJfaLktvrhtziLKOUrN390uBvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwlSeUgB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj8aRneA036R40Z/93/r0n4BsJ0KrjIQQUbrcu4BIVM=;
	b=IwlSeUgBIgJ1mhCgz0xJDHtwJ+x2wOb6/aixgOoGxL5wiTbdQr9H5bGKx7qj7fcS169Paj
	eqCeq8HxBDfDrJv735AN2fhfQlKjyjlEOcuERrzCgJTPa+Hmu5Vrnrmg6ryoLrpFZZsDsT
	cYTaWrqcHEQyCzehNUSpDW1YYmSt9mo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-nLpLzJDtPkibffvSbC2mig-1; Tue, 18 Feb 2025 05:26:26 -0500
X-MC-Unique: nLpLzJDtPkibffvSbC2mig-1
X-Mimecast-MFC-AGG-ID: nLpLzJDtPkibffvSbC2mig_1739874385
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43961fb0bafso27051495e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874384; x=1740479184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj8aRneA036R40Z/93/r0n4BsJ0KrjIQQUbrcu4BIVM=;
        b=TcSLbOCyQi46KS3LjCAs56Np1JL4X5H5FqFe9/7W5TtW0Rn7tdMCMAD5tR0lGfEzwj
         0szZAxTkY8Skqf0TUU2x3vYQKPDKGvSg0f7E3pNzhPeyWMcwQZQtoxaPHMphTe2OtskU
         i/V3gCLvC0GZ5EWZdFrdQddyZpyTkmZKmLVfQ9AsAFNS+LMedB4mR2WKGleUwv0PVCGf
         wzIHFCNnF+EIvtGgetTNJ2J88b1zHvlxka+USWNNRs9Vc21fLh7GkCT2o0xlS5QRrfgQ
         /e9Ic/QJH/f0Vl1J/RYRXriEQmvgCv6r0g3DmemXmJL1lSTjlgMScSjvhnkKqLzCGlgT
         r0gg==
X-Forwarded-Encrypted: i=1; AJvYcCXohvUHK6PN8au3J38q5wlZi1PVTQe9LdBbkKYcsW3ZCwjum/HeL3yPC/lLNHwcYIbUuBOOP+E6hFf7Czg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrawwuYTUUWYw89kGYkoaUOhlfjEjief/iJ8h4ZsDxFvjxa+G
	PjnGMSxLsXGCd8IKJwOzpt0pnnzjiUDqa0mD0vvbb82lVT8TefIgj/g3/GKAh5XC0Kh9CdptzfC
	11WOsQlWkcml9UNcDYumnXSWqFlm31C+Ma7J6Z8aWbBQE9PoNFzjZ3JGTIxrj64Ry7rv5Bw==
X-Gm-Gg: ASbGncuQPtGjRbvtgoZ2Cdcps9Y26TZnQrP4Aa6WHCvoTcslZKYoNIHJH/lY9lKZCt8
	KAzsmciHDrvBFKShu3tCCiWaiHwxmjhOGWxZJfHPSnsYVn/lQYsZ+HmIRmBaQxBCqOsAvqIL4in
	B39AVwukYdA8hAPmsTe2lHA7Rb/8od3wReIl/5qUliRHh5XwKu7buGtjGIwzrH0kAm/U7gnNG7c
	J29xGEfaHpXzsVN4voCAqm9u3Vhb1cJ6IJiRYdXB8sBqnnAV9hEhdlcw9Le2uRSLJqWWx0hxMG4
	5bMlOhUlxGvz6kHw4w1gKHJ2GtxLRRfMM+A=
X-Received: by 2002:a05:600c:3ca3:b0:439:5f7a:e259 with SMTP id 5b1f17b1804b1-4396e739aa7mr116417655e9.23.1739874384586;
        Tue, 18 Feb 2025 02:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkSU/VSnOl2Lx5jSHDnvFMf1SdmHIIFIgmwDPLjf61CIhWkI2u1PLCMfAvVZ5aFuhqVLRdZQ==
X-Received: by 2002:a05:600c:3ca3:b0:439:5f7a:e259 with SMTP id 5b1f17b1804b1-4396e739aa7mr116417345e9.23.1739874384260;
        Tue, 18 Feb 2025 02:26:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982bcc607sm58367795e9.16.2025.02.18.02.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:26:23 -0800 (PST)
Message-ID: <1ff73b64-2745-473d-a12d-87e1501262d5@redhat.com>
Date: Tue, 18 Feb 2025 11:26:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 6/6] octeontx2-pf: AF_XDP zero copy transmit
 support
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lcherian@marvell.com,
 jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org, larysa.zaremba@intel.com
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-7-sumang@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250213053141.2833254-7-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 6:31 AM, Suman Ghosh wrote:
> +void otx2_zc_napi_handler(struct otx2_nic *pfvf, struct xsk_buff_pool *pool,
> +			  int queue, int budget)
> +{
> +	struct xdp_desc *xdp_desc = pool->tx_descs;
> +	int err, i, work_done = 0, batch;
> +
> +	budget = min(budget, otx2_read_free_sqe(pfvf, queue));
> +	batch = xsk_tx_peek_release_desc_batch(pool, budget);
> +	if (!batch)
> +		return;
> +
> +	for (i = 0; i < batch; i++) {
> +		dma_addr_t dma_addr;
> +
> +		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc[i].addr);
> +		err = otx2_xdp_sq_append_pkt(pfvf, NULL, dma_addr, xdp_desc[i].len,
> +					     queue, OTX2_AF_XDP_FRAME);
> +		if (!err) {
> +			netdev_err(pfvf->netdev, "AF_XDP: Unable to transfer packet err%d\n", err);

Here `err` is always 0, dumping it's value is quite confusing.

The root cause is that otx2_xdp_sq_append_pkt() returns a success
boolean value, the variable holding it should possibly be renamed
accordingly.

Since this is the only nit I could find, I think we are better without a
repost, but please follow-up on this chunk soon.

Thanks,

Paolo


