Return-Path: <linux-kernel+bounces-371832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3779A4103
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D718B1F2464E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA42E1FCF61;
	Fri, 18 Oct 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gf+2gEda"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF031EE03D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261284; cv=none; b=CRiaVf4HuI6aoavBIqPUMsNndqwitfSVbNOC1QdvJUneP/tW9wLFYJCNryz3s74UC465ar+JDWllyCcM2ZF/ZgVqNEJsgVguP71Qe2AmwzxQB+1dnVOz/tmtJEc4U1IggUnuxv6goGV7Yhyq4YQq6dzh6YOmOy1g9N+XaTow3qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261284; c=relaxed/simple;
	bh=xHybtiKyTxNA1jI8buXYvXG734IlXSdiFFZRHOOaxdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTxPBRWtzmqrhSQybsbjVBYm+lIzbJlfMoMiKzdKVg/MScC277IbprM172NKwDtItqgVbqsollUrTG2ZrJycVJM4LRjvX9Wtut1sF8CIONPrLjpE0SNMy+n+A1AQtaeXz6EU1Z6m05BepJEp+tL/dK0bU9JAeWn++IVut8X+9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gf+2gEda; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8b557f91so23255955ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729261279; x=1729866079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxkU0SurZ3ytvyybPNhQLE8bgWu3q/xADixl58fl7SE=;
        b=gf+2gEdauu4iblVqH0Q8ixqqzmkR672MxZGaEGuTwcUofb3qD9OVe+U1LH3DZwNaO0
         UWvOQy7hB5rFSqc0EPKKSN7pcjHfKFuZa8U/3W30/f5wXyagc335BEcfwFf/9erOTTch
         iwX0sNKBTkKdc0I0GBvvZ5QSpKhZg1gGZlMth1KWytRbNeqWd/CiztxeORbF5ldViAWY
         TNkzfpizE+5b1eDVHhpusX79DPKwugtZ3EUJGwOUjpCTxCcR6FADs6dNDZC//T8p3kxf
         TawCxxvASl1gP/v9cBQJ32yNL0KuxNEcJ/IMPaNBLVVmETArdLZ5islYnuesfT85GO3v
         +ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261279; x=1729866079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxkU0SurZ3ytvyybPNhQLE8bgWu3q/xADixl58fl7SE=;
        b=g5NkwJ//Uq80KJcrP7Oes6iLoPCqrt127U3qNTyLX0z1jorPHdHcPWS/wNqZrkwEkX
         swSO37JTi+wnU+a0RsNH2xMbseR463d7RKoBqM9HXy0qofuNHQ8VbHK/thEEDtKa0WwV
         pB7zhOq0Ez6659HGcRfP+oeKyf71p1mboNHsn9qprVSHvl0KRIkdBKOkk86/cNIVI4di
         mxs7dP7OZ+BzdcaneDULvAJrIGBl+BjsCbqj3yWkgvoCWZu12Hqox2UL/6a/Ckzub8Bp
         IaElPjYmIOqLSLFwd9gq0EywVu7IKKNszV8PAjWrrp4vrJiA7NPd91wacKGXoUfFOsl1
         U9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL7Eu7OpyKVieo1uQX/H9kuHoARnOYChMiL9eQuXgru88bTRvTSA6hNCak0po+6EiSj7/C0wczqcKQTwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+neHr4LJxev0X9cC/PsPkyXeJkODjosle5KcEdcfhXqaTGGG6
	tbKMSOcVQJGlojO6oiTaBrVBNS5jak7w0QWZM0GPmlELH4sYmSpz6T1oyC32jp8=
X-Google-Smtp-Source: AGHT+IGZk6UCrT0VIMAN6pIiPBhEinc4i35+NJcdRK7GjNJnOyc6aLd4dZkz49tcq67yLWma6DwkOw==
X-Received: by 2002:a17:903:234b:b0:20c:fa0b:5297 with SMTP id d9443c01a7336-20e5a78e147mr33139555ad.26.1729261279129;
        Fri, 18 Oct 2024 07:21:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f9f34sm13138225ad.235.2024.10.18.07.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 07:21:18 -0700 (PDT)
Message-ID: <cb9d65fe-47b9-4539-a8d0-9863e8ebf49f@kernel.dk>
Date: Fri, 18 Oct 2024 08:21:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] blk-mq: add support for CPU latency limits
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241018075416.436916-1-tero.kristo@linux.intel.com>
 <20241018075416.436916-3-tero.kristo@linux.intel.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241018075416.436916-3-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 1:30 AM, Tero Kristo wrote:
> @@ -2700,11 +2701,62 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
>  static void __blk_mq_flush_plug_list(struct request_queue *q,
>  				     struct blk_plug *plug)
>  {
> +	struct request *req, *next;
> +	struct blk_mq_hw_ctx *hctx;
> +	int cpu;
> +
>  	if (blk_queue_quiesced(q))
>  		return;
> +
> +	rq_list_for_each_safe(&plug->mq_list, req, next) {
> +		hctx = req->mq_hctx;
> +
> +		if (next && next->mq_hctx == hctx)
> +			continue;
> +
> +		if (q->disk->cpu_lat_limit < 0)
> +			continue;
> +
> +		hctx->last_active = jiffies + msecs_to_jiffies(q->disk->cpu_lat_timeout);
> +
> +		if (!hctx->cpu_lat_limit_active) {
> +			hctx->cpu_lat_limit_active = true;
> +			for_each_cpu(cpu, hctx->cpumask) {
> +				struct dev_pm_qos_request *qos;
> +
> +				qos = per_cpu_ptr(hctx->cpu_lat_qos, cpu);
> +				dev_pm_qos_add_request(get_cpu_device(cpu), qos,
> +						       DEV_PM_QOS_RESUME_LATENCY,
> +						       q->disk->cpu_lat_limit);
> +			}
> +			schedule_delayed_work(&hctx->cpu_latency_work,
> +					      msecs_to_jiffies(q->disk->cpu_lat_timeout));
> +		}
> +	}
> +

This is, quite literally, and insane amount of cycles to add to the hot
issue path. You're iterating each request in the list, and then each CPU
in the mask of the hardware context for each request.

This just won't fly, not at all. Like the previous feedback, please
figure out a way to make this cheaper. This means don't iterate a bunch
of stuff.

Outside of that, lots of styling issues here too, but none of that
really matters until the base mechanism is at least half way sane.

-- 
Jens Axboe

