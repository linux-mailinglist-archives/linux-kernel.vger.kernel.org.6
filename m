Return-Path: <linux-kernel+bounces-284721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD595046B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208081F2314C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D09187348;
	Tue, 13 Aug 2024 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JjSsPXOx"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853D1990A2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550774; cv=none; b=Ceg0jC+d+LRMeXf3/juLx9Q7NkUiR4duZhz7c/l23mFPVArIr2XdPTU6KB1jD2qTiwdWpXlipymIw/kuisD6pOCXhtkdNwOvggsslSo+2z0LW4q0R0tWpFq0tkjzes3WRM2kVj2on0Thha9nJwC2qEhQ65aQURm7uQvCuv1Lf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550774; c=relaxed/simple;
	bh=z1541LLoljeScFAviJcOpT1FxAuiQdONaXIbOm3M7tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7N0TRljIlOAnxeD3wKmOB0rbmUbZba/9Eq4nV9jl8qQFiRwr7JN/iBh274mQO2yrnDf0vO3IeFcSBZyI89UlMzFEsSLs7nPQfBZ2dcAF+n/C1sS7RgQTH2WL11YCnn7fgkrpuL1VmJ+t5fJKyU4Nh4itDUSUSBdAtWZhWXoN1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JjSsPXOx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-72703dd2b86so300848a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723550771; x=1724155571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTZVldKRb/o0QB96J4YTidzWQUdWVcUNuGr7ChBtChw=;
        b=JjSsPXOxgfl7ezcuD/8V4TqKdlBKIMKrdrkGqDG75O0abFwSFdCZrqI2eovmp4poMS
         TN/4nT4DWsEMU7iF0NjDrBumfOlQHU30aXDanGYDjs/nOsRKy9vaLiV/M7O+G48i7Udn
         cmV3hDyXS97ojVwiHGPdZzuxOixYVxBLqG6dFYYT32qc5wbOLPxIpAsuUVa7cK9Vtin8
         Wc7z3kesq2pOP4alLKp2K35F/PIEIO5OPTYfBJxd0GB46+YzGVtQIv/LJ/EecGZ/ZlCD
         8wbAGGFqhcVWi2tvK6t5REzn8zdLBw9eMxjyzbIjR2lShAJ+uriDgmyDUIYZtxN4ZSkZ
         7ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550771; x=1724155571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTZVldKRb/o0QB96J4YTidzWQUdWVcUNuGr7ChBtChw=;
        b=KBuWFqe5xah0KcnFecnxIgMMux4x0fhsA2jK2/tnElfLNUybXzUFQ8C7D1AJFc0Fu/
         x0icfgXwXxDODYXDWc3iJVjX4zm85vB3Gcv2jsznVC7/RoxcNsyqNcN5mQZQ97pk6BH9
         AEQFpMiJxSY+GJ4jaU5MWcxasnbTJ3oXpxolT0ZLQ3MmWXY5Vjwra3fyTQl4pMbKbZLQ
         oUZScC/ruvsUsCNGhqLwA77osiWNnljDmHSc2aH1BqtafxkUx2ny+TCoCjo//dbUTSvD
         dWQEutvhBEh/SiSbvOVo9frQkg5ZnyA7nIdHmlrRWTvHcN9PhOpbBcHMqzCsiPFAabqt
         BScw==
X-Forwarded-Encrypted: i=1; AJvYcCUOQIHI5jLlI3egw1Jv5WWJ66AQkiZVPd0VolpXzI3AnFIWMC/V+MafGhD0nGAnCs24GXPMKQL80+6GLT4P42OFagXnxRplaM/sE1qQ
X-Gm-Message-State: AOJu0Yy39dK1IJ2vuMvl/Qay5cl3xSXDVrMRxIEx+evZwL/+/9zQVX1U
	FQDtRwWuX/tVEFZjy71gnEpZI4XXl7xH3h309PRXEkbOb4XGG6H0rTBSJ/9az2w=
X-Google-Smtp-Source: AGHT+IHA0uIBnOoa9zK5QZ9wRP6pn4p19E6yD5IViwfQv396i/GQegJiGKmsIH9XBKL7FRfeZDxC/g==
X-Received: by 2002:a05:6a21:999d:b0:1c4:c007:51b7 with SMTP id adf61e73a8af0-1c8ddf13570mr1450329637.6.1723550770637;
        Tue, 13 Aug 2024 05:06:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5889deasm5760351b3a.18.2024.08.13.05.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 05:06:09 -0700 (PDT)
Message-ID: <bbc6c4c2-b596-43b3-b37f-95f9fa4134c3@kernel.dk>
Date: Tue, 13 Aug 2024 06:06:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/fdinfo: add timeout_list to fdinfo
To: Ruyi Zhang <ruyi.zhang@samsung.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, peiwei.li@samsung.com
References: <CGME20240812020140epcas5p3431842ed5508ffb5ae9f1d1812cae4d5@epcas5p3.samsung.com>
 <20240812020052.8763-1-ruyi.zhang@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240812020052.8763-1-ruyi.zhang@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/24 8:00 PM, Ruyi Zhang wrote:
> io_uring fdinfo contains most of the runtime information,
> which is helpful for debugging io_uring applications;
> However, there is currently a lack of timeout-related
> information, and this patch adds timeout_list information.

Please wrap this at 72 chars, lines are too short right now.

> @@ -219,9 +221,19 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *file)
>  
>  		seq_printf(m, "  user_data=%llu, res=%d, flags=%x\n",
>  			   cqe->user_data, cqe->res, cqe->flags);
> -
>  	}
> -
>  	spin_unlock(&ctx->completion_lock);

Some unrelated whitespace changes here?

> +
> +	seq_puts(m, "TimeoutList:\n");
> +	spin_lock(&ctx->timeout_lock);
> +	list_for_each_entry(timeout, &ctx->timeout_list, list) {
> +		struct io_kiocb *req = cmd_to_io_kiocb(timeout);
> +		struct io_timeout_data *data = req->async_data;
> +
> +		seq_printf(m, "  off=%d, target_seq=%d, repeats=%x,  ts.tv_sec=%lld, ts.tv_nsec=%ld\n",
> +			   timeout->off, timeout->target_seq, timeout->repeats,
> +			   data->ts.tv_sec, data->ts.tv_nsec);
> +	}
> +	spin_unlock(&ctx->timeout_lock);

That seq_printf() line is way too long, please wrap like what is done
for the overflow printing above.

Outside of that, please also rebase on the for-6.12/io_uring branch, as
this one would not apply there.

Thanks!

-- 
Jens Axboe


