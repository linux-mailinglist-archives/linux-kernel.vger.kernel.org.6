Return-Path: <linux-kernel+bounces-405865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 511779C5A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FD7B242F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0848148828;
	Tue, 12 Nov 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5zdWNpi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78113C807
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415746; cv=none; b=lbz/kviTfoAA6JFOpIZ47KvImXYEzhgKC+5UIMFRn+Oi8PojiM3MGGvnJdLrQiM+qXhls00fnxlzY/6ZIqTt8Vj/2JBxnh5kowIo21D25HfHkprGWc2gFYJ8r49C+tnAMD65DHnoQGUYzwmv18TyvY7/1w7QUjC5yUOAS1Twt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415746; c=relaxed/simple;
	bh=tO2DFX5hpPjovQKxGltnLka0mrtQgk4SmhGgjXzyU7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fIBuq9EQFSnzVbEjfLPKxpOp4aaSZlEeUVyjSTMSRQ12wmVV6oqdjATWXrX7SoNO5DGnQVj3juIWbevEenM2aIXWMOj1U4dfbLqvHigyB6E/6JPWLVjNcRhXIQTzWeTKW79+L/9f9cQZDJV4tyIdADfFmMJK7F5fU8nSBN8rheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5zdWNpi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731415743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l72p6+5vAW8EV7pNrL52Yl3/6leWAr3UfpwvnjLecyk=;
	b=Z5zdWNpiRNFILCUuElvbS3NZmuONd22X7NJ4c9VIBh4qUAOJpkIdJRlLqIJWQMpJBerlJP
	9T7D4jXN7Kh3nppr3+9IZwMXdjKi0oGP6ZMBPDoVlDqKmuEZWXMGdqqNDJ1nL33HtEcuiz
	GO7GKOZbeJcl7z7ULEsPffrmT7Mqa78=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-_In2Vy2lP5uMk8hjQ9BzkQ-1; Tue, 12 Nov 2024 07:49:02 -0500
X-MC-Unique: _In2Vy2lP5uMk8hjQ9BzkQ-1
X-Mimecast-MFC-AGG-ID: _In2Vy2lP5uMk8hjQ9BzkQ
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3e600565aa1so4278304b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415741; x=1732020541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l72p6+5vAW8EV7pNrL52Yl3/6leWAr3UfpwvnjLecyk=;
        b=XNPLa+PiySSSxxTkKjVClLnoeTPCaRs5Xl/Y7QAi+CAdwtu+K3+ugKrMhWaQTcwG18
         lqDMRlpmJn6hzVrSAFT2txb+8H6n1rMgimCXNeD2s+H15k5M37nO/t0dGN98XQG5MvGv
         Ur4KeaucTo6gLclKu0VANvfMukNASZrGW6cu1Kd7xjL5gCjypoZDMMprLd9J2raMi5Gi
         d9scscKRVFaBZBOUjAeVqGqDdeZwDTzZ5TAPvz56qVppKvdQisE1n/T+4EZInK9YMvae
         Mfc0LKv2YIzHZTbcm45uSUuA8pnQCvOlxxP2rEKv0cn7XYZriD0m+8Hiv7EuSZuAAzM4
         LPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnjsYBauALyNKrObx82h3lE2huU20+OsdgM+GzGA8t6e7jTXFxQ3insSjWDtEOXlNyUWdJH+3MVT+25CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKof7XRgOeNR+3DR868egcRhYUHFWX+UrsJA04WvycS4uhDEBL
	I4Jy0D4mpwlROXAA4WoSZjKyHhvDoCcw4aLaihal6q7kVB3F+R8M/FjpQyMjV2LOdxI7bO7Odcj
	AkiZoEu96hkbiXwLoVzBGrSAyNq0so7cWaz3uz65cftnOQLDPhQlRK83x7RaboQ==
X-Received: by 2002:a05:6358:6e88:b0:1ba:5118:ebee with SMTP id e5c5f4694b2df-1c641ea6f2bmr658006355d.8.1731415741584;
        Tue, 12 Nov 2024 04:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOqIUm2AqLWOl43bH4Dc+V7W9b4DHpDjnOPXRxys0bKVgesz4gERPMAgv1SVGD/ZW/baY3gw==
X-Received: by 2002:a05:6358:6e88:b0:1ba:5118:ebee with SMTP id e5c5f4694b2df-1c641ea6f2bmr658003955d.8.1731415741304;
        Tue, 12 Nov 2024 04:49:01 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39643b384sm71399376d6.91.2024.11.12.04.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:49:00 -0800 (PST)
Message-ID: <e03fbb80-2f44-465b-9152-d85302b9454a@redhat.com>
Date: Tue, 12 Nov 2024 13:48:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v9 6/8] cn10k-ipsec: Process outbound ipsec
 crypto offload
To: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jerinj@marvell.com,
 lcherian@marvell.com, ndabilpuram@marvell.com, sd@queasysnail.net
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-7-bbhushan2@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241108045708.1205994-7-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> @@ -32,6 +33,16 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				     struct otx2_cq_queue *cq,
>  				     bool *need_xdp_flush);
>  
> +static void otx2_sq_set_sqe_base(struct otx2_snd_queue *sq,
> +				 struct sk_buff *skb)
> +{
> +	if (unlikely(xfrm_offload(skb)))
> +		sq->sqe_base = sq->sqe_ring->base + sq->sqe_size +
> +				(sq->head * (sq->sqe_size * 2));

Not blocking, but I don't think the unlikely() is appropriate here and
below. Some workloads will definitely see more ipsec encrypted packets
than unencrypted ones.

Perhaps you could protect such checks with a static_branch enabled when
at least a SA is configured.

/P


