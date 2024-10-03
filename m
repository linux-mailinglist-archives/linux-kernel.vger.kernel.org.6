Return-Path: <linux-kernel+bounces-349240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC798F2F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D4C1C217E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73A1A4E9D;
	Thu,  3 Oct 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBSvMC4X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A31A76B5
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970199; cv=none; b=DlWBTSgQrqsVK1gbTvX78U/kyTLEYKpiT3UOasRZw7tIA1iUlLFtk/zMo9C2n6vHRE2Vj/9CHrRdsPCIajCY4C95O8Qljptta94aFyiFYnOJNW86nQUzjhLvrghjiGG49cDu6ebBjjBK56LxDo6cLMv+q7OGNRAFrVHexDsMkuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970199; c=relaxed/simple;
	bh=g65+54z4Zpj1dPZVy4oOrE4bpLAgX4AieSGQk3Med/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEQ/YJje3NX4ulp6u57ZCPtmdI7nvCDx6ffXCCX+ahQ1FTuKHMlOF/xnnoFYzC6fZtd+/GKuzwryycx3OwarbQvOIe5w5vDTBSgFfdVVe0Gh5YtoF/vyR4xbgizAXXNJYbhrFnnuJmXBTv5g8Rg7JyEl6v/ks6KPZWp3d3Idzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBSvMC4X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727970197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1ImaFrP+6jNDymNS93hyPmUljHWg8mBw4D0yQ/pKRs=;
	b=XBSvMC4X5zwza/uzaRpaToQQ+tvNkfDvCam+enS+SB/DSDLZtt8+UXMh2PiN690NVUpm+h
	HEByWjILy0sBVzJ0WOpP/OqCDGxvgLpxHAIQEC5UkA7VRI5TEM2Z93NPGJUdHstvDTsvqK
	dEtj9Ruip4jgJrP4ZQee8GkkvSgpnko=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-uMYV8xuZPByyuQXr9QFhNQ-1; Thu, 03 Oct 2024 11:43:16 -0400
X-MC-Unique: uMYV8xuZPByyuQXr9QFhNQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5e1bd9060d1so932494eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 08:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970195; x=1728574995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1ImaFrP+6jNDymNS93hyPmUljHWg8mBw4D0yQ/pKRs=;
        b=D80Z3+Q/jS0kE6jySlTAPAGGZ0xvarqpSJuG7ksr2i4JhWUFY7k7r0s7AHFqLqaUji
         L8/lIb17b5rhy22ovAFWlRvl7brw0Q1jQSsRlZxg0HLj5M1gzxk8tGnDvOrr0NYWqZbx
         6RrCi/zEVHFfLhvosSY8k8E41VECvhLaYQ2XyH8VvoNhsce9M648WXIwWaQmgWA8bey8
         m9gJtPnz2PNDfWvumMVavBtZVmcYKoSoDeVe5Bd6Yr/xBnG6rjLS/iOsaYiiipSslUfq
         f8VoO0rogGcCzzwFNVuJbRKnSKzKdvLebw4zupTuxcqfzwvboDqk4RQbFWsahG3pl4ou
         ELzA==
X-Forwarded-Encrypted: i=1; AJvYcCU9GxbkSmTo1W/6LqZYMoDaHCNKWXR8ClWEs/mdvaSEhxFbtDBELk1G0hlQA300m+HKzgOvRo1cfF6dDzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1sPurZZ0xS4H/Gi2nB4+8gtEfAkSSkAgKmknodAnjWwDXdieA
	RBBm7+hYzeACIwEoLPYOe90t0ul+lZq/SV4CTwhtyNdUrjHj1QT9b5oW34c3Mkn2BqS3fk6jKJW
	zR073H6BsaFUlTEKWuKbySdsIBPdBdaDYZXboUoCsVpYYrJEpbToTNm4gmeLKrw==
X-Received: by 2002:a05:6358:718c:b0:1aa:bad6:2ba7 with SMTP id e5c5f4694b2df-1c0cee92b1fmr398321855d.25.1727970195335;
        Thu, 03 Oct 2024 08:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnR129o0ZmhGaJxGwZv8rxgeW+LqzUiI7DV/2SZ3qqCdAGXTFQQsjRDJ7iVhNRYnQB/W874A==
X-Received: by 2002:a05:6358:718c:b0:1aa:bad6:2ba7 with SMTP id e5c5f4694b2df-1c0cee92b1fmr398319355d.25.1727970195001;
        Thu, 03 Oct 2024 08:43:15 -0700 (PDT)
Received: from [192.168.1.165] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92e2e348sm6571771cf.48.2024.10.03.08.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:43:14 -0700 (PDT)
Message-ID: <d0e31a7d-b2bb-437c-b9fc-65a095c4e35f@redhat.com>
Date: Thu, 3 Oct 2024 11:43:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] dm vdo: Remove unused uds_compute_index_size
Content-Language: en-US
To: linux@treblig.org, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241003011554.266654-1-linux@treblig.org>
 <20241003011554.266654-10-linux@treblig.org>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20241003011554.266654-10-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 9:15 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> uds_compute_index_size() has been unused since it was added in
> commit b46d79bdb82a ("dm vdo: add deduplication index storage interface")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Matthew Sakai <msakai@redhat.com>

> ---
>   drivers/md/dm-vdo/indexer/index-layout.c | 26 ------------------------
>   drivers/md/dm-vdo/indexer/indexer.h      |  4 ----
>   2 files changed, 30 deletions(-)
> 
> diff --git a/drivers/md/dm-vdo/indexer/index-layout.c b/drivers/md/dm-vdo/indexer/index-layout.c
> index 627adc24af3b..af8fab83b0f3 100644
> --- a/drivers/md/dm-vdo/indexer/index-layout.c
> +++ b/drivers/md/dm-vdo/indexer/index-layout.c
> @@ -248,32 +248,6 @@ static int __must_check compute_sizes(const struct uds_configuration *config,
>   	return UDS_SUCCESS;
>   }
>   
> -int uds_compute_index_size(const struct uds_parameters *parameters, u64 *index_size)
> -{
> -	int result;
> -	struct uds_configuration *index_config;
> -	struct save_layout_sizes sizes;
> -
> -	if (index_size == NULL) {
> -		vdo_log_error("Missing output size pointer");
> -		return -EINVAL;
> -	}
> -
> -	result = uds_make_configuration(parameters, &index_config);
> -	if (result != UDS_SUCCESS) {
> -		vdo_log_error_strerror(result, "cannot compute index size");
> -		return uds_status_to_errno(result);
> -	}
> -
> -	result = compute_sizes(index_config, &sizes);
> -	uds_free_configuration(index_config);
> -	if (result != UDS_SUCCESS)
> -		return uds_status_to_errno(result);
> -
> -	*index_size = sizes.total_size;
> -	return UDS_SUCCESS;
> -}
> -
>   /* Create unique data using the current time and a pseudorandom number. */
>   static void create_unique_nonce_data(u8 *buffer)
>   {
> diff --git a/drivers/md/dm-vdo/indexer/indexer.h b/drivers/md/dm-vdo/indexer/indexer.h
> index 3744aaf625b0..183a94eb7e92 100644
> --- a/drivers/md/dm-vdo/indexer/indexer.h
> +++ b/drivers/md/dm-vdo/indexer/indexer.h
> @@ -283,10 +283,6 @@ struct uds_request {
>   	enum uds_index_region location;
>   };
>   
> -/* Compute the number of bytes needed to store an index. */
> -int __must_check uds_compute_index_size(const struct uds_parameters *parameters,
> -					u64 *index_size);
> -
>   /* A session is required for most index operations. */
>   int __must_check uds_create_index_session(struct uds_index_session **session);
>   


