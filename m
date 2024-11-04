Return-Path: <linux-kernel+bounces-394695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E769BB2EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C561F227D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B61C07DE;
	Mon,  4 Nov 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DW9QWAx5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8831B3954
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718531; cv=none; b=gfmyfx+xe5KRvP5QLKaNKxKnKI4q8Dy5UR3RiOQbYVOjczLNrojlNS5Co2qpTQTdkS1JUQ0cmrla9dCMQiTAlXzV/VAgbp47xmtWCOR53mjCdw9Ti8Dt6TqMgoJZlq+IZYCVh9fo2pCPqfGbcm/MU7ULO+55RKlpCp8lhbVjTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718531; c=relaxed/simple;
	bh=s5P19hNeuAnGUdrMJ/5Mqch/0JAtnNtGyau8mT1WKzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NH7hKLmEZX0HnUpBZxdKf//4i0ZgDUqNgeb4mjDoaLo18p92auoC6m623ZgFkzBNkP3UyRYIEpvt4QzAdKY0pAnIZB3bzD6EPNAlJH3o+nqpzrmip2qN0QYrm7CYIasQY3mz9H/MbpBeQBg//1x8fWOWWNwNIsNNXW3CnwdG0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DW9QWAx5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730718528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiPSsBINkhUGJeoO3ADfkXjMLznBBsiB9KM89Hnjm4M=;
	b=DW9QWAx51Nv/ZIAdNH3ObuUvUpozYuq1HpSwCeAqbWD/MODGJCbAepC9It75HesqRk1Gva
	ur2tFoEI3zvXGql1MbIEP1CyAqEPzUflQkMweieb0/h2sx8wTkGIevp2oXgajskkRq0di+
	lhMrMcz0PeZVdVd7KZ4NQQuWy4jo8P8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-neF9Fw41OQCrUNfIa3R7Ig-1; Mon, 04 Nov 2024 06:08:47 -0500
X-MC-Unique: neF9Fw41OQCrUNfIa3R7Ig-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c934ceea1fso3203605a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718526; x=1731323326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiPSsBINkhUGJeoO3ADfkXjMLznBBsiB9KM89Hnjm4M=;
        b=CyMHE2LdFzpNIbszQK6F/FcrzZwuANe++v5NFO8dIYWEMB9qjIoYDHDaQd3fNHghLc
         Q3sn12e44Z1sjaL6kDM7T73lOuNSblcKUUbVFhv93yX1Be/86Kgm/KC7j5MQP5zuOPeA
         hD+F7OM1RFdSW414sy4T8FoVPZYfSF1LecjVyh8KNaOS7rXZmw4sGmCIC75SHx6AE3vE
         IQ9+a86TvB5FcJ8l2ESzR3tqFCQcXwFGGjrTAiRf6/DGPYvaGrk/RVlylgtHYI9fEvy7
         xvpoTogq3IdJeZKZPaSTZ1rlfYyxKG/ATCejRcauaZwl7Z/0uqTzp3zHpf1MgXd+MMsS
         HsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDoA1a7eB7/FbXmBE8LwhYTcCCAI1RT9XVx/9xACebjge56MGj8VGWPa1kUXCYTNc9Rep8HwapeQ/5dvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3B7vmeUV9GMBw2lwjiX35p0UB/mwUAJPyUzgp7OzxHADDXJe
	uQ1nI/tuhVnxAGPj0nhd6KX7ps3w3c+Zfp0H4t6qc4DMORZm+TBonbyBLf+90yYZKcpb2OzVsBF
	z3OSpRlk6lKqSi6uGJcD3AyM/YXyhC175jFK5IrSMqG5DweWQCglZhttf8N3S/L4qVIJf4Q==
X-Received: by 2002:a05:6402:1d4c:b0:5ce:de14:65d0 with SMTP id 4fb4d7f45d1cf-5cede146642mr966712a12.0.1730718526162;
        Mon, 04 Nov 2024 03:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpuDyO8D1nRRXTlTJuNJPSHeW3WHC0+/HSstAONVJrZSkZK8THp6jyRFyHZaAKg2FAXzHvYw==
X-Received: by 2002:a05:6402:1d4c:b0:5ce:de14:65d0 with SMTP id 4fb4d7f45d1cf-5cede146642mr966691a12.0.1730718525615;
        Mon, 04 Nov 2024 03:08:45 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7c8c91sm4128304a12.75.2024.11.04.03.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:08:44 -0800 (PST)
Message-ID: <e25fb120-965d-42e3-9f0a-7aa9bc1c9dee@redhat.com>
Date: Mon, 4 Nov 2024 12:08:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: atomisp: hmm_bo: Fix spelling errors in hmm_bo.h
To: "Everest K.C." <everestkc@everestkc.com.np>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240918082203.4941-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240918082203.4941-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Sep-24 10:21 AM, Everest K.C. wrote:
> Fixed spelling errors reported by codespell in
> drivers/staging/media/atomisp/include/hmm/hmm_bo.h
> as follows:
>         increse --> increase
> 	decrese --> decrease
> 
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>

Thank you for your patch(es).

I have merged this/these in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this/these will be included in my next pull-request to
Mauro (to media subsystem maintainer)

Regards,

Hans


> ---
>  drivers/staging/media/atomisp/include/hmm/hmm_bo.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/include/hmm/hmm_bo.h b/drivers/staging/media/atomisp/include/hmm/hmm_bo.h
> index b4c03e0ca9c0..6d3c74156345 100644
> --- a/drivers/staging/media/atomisp/include/hmm/hmm_bo.h
> +++ b/drivers/staging/media/atomisp/include/hmm/hmm_bo.h
> @@ -159,12 +159,12 @@ void hmm_bo_device_exit(struct hmm_bo_device *bdev);
>  int hmm_bo_device_inited(struct hmm_bo_device *bdev);
>  
>  /*
> - * increse buffer object reference.
> + * increase buffer object reference.
>   */
>  void hmm_bo_ref(struct hmm_buffer_object *bo);
>  
>  /*
> - * decrese buffer object reference. if reference reaches 0,
> + * decrease buffer object reference. if reference reaches 0,
>   * release function of the buffer object will be called.
>   *
>   * this call is also used to release hmm_buffer_object or its


