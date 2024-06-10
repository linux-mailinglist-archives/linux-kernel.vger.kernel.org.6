Return-Path: <linux-kernel+bounces-207983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEFB901EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017AD284728
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46B757F5;
	Mon, 10 Jun 2024 10:02:44 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA5380
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013764; cv=none; b=eMhUHppSkfZU40D6xFBBPP5Q8b6R+lBrV304tuIDGFlmGTvxOLSn6aAbCNv+bQY4I7ftM6Oq180Xy8vsKr3mjaTNwC2Tu/1pi/BvIrQ1n0RufuexBLBDlX10CIjk9Pq7ShEgp8FALjg0WBINrp+uSIa/9e7uLosMPZKnZAS9E2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013764; c=relaxed/simple;
	bh=nY7vQBXvvLcW7pJDPfjjwJtzNcX2dFm+TJNAsQ0x2dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3CyFwpYff9aXT8LEaMcMJErLmiEHdmF0C1V7wB6vI/QhWAvA+q7UaUcQRFwKQWM/GYvw2JxmXe+ICJelCoBMlZ57vj6/jNqWMV7Yipne26Q8P1ZOcM1MCtWJ6NDVJOkjORjzZG1JRl0FAh0yGL0k3ZlpnngHf+LHMqafWPOTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3590b63f659so541001f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013761; x=1718618561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpxmJoSW99hJx9JZ3U2DWGrUs+PthUzBo3UheVm8ELE=;
        b=ICKXzJd0UWkGXL3P+mVkvuYUJEGiaPVAtms1IfiZWtkjivtJNxImPBOneKGKxQaIog
         jW/yxVfeHZR05A0yRuyWWhbh4r8OgAvsARYwL6nkWhcJwnAvJKii4G1vr0sOjYtxbY1/
         rFQChYGwraLSRVcMMjwzC5COcSvQ4URy1zv3lysU4GRKlotwGpRMzD4o+9B3j7bGkfvW
         a/OBAGcFh+0MWr6ZpPuWaF3oWn6lyy95Qq4IxprP3d8jym7YWCuEjmthccyaBwy3bTcl
         CWkfAEEyOzMUXI2YntsbIHqoqqBBq7Oov1NOxwZEpLCITsIaMQJKieuL7p0qyuDRwhlg
         LW/w==
X-Forwarded-Encrypted: i=1; AJvYcCX3SgKAuljDo+k2T5lj6MwIADTUxpELGh5ji6+XPyGUcKc/o5E+KIkIfdPSFjuvOq4trQgAdgS76Pz4CHk6yKOu3Nnni/LFFpNxPjWw
X-Gm-Message-State: AOJu0YzYxkpJ/TIjFNC3xxqgWKc+XNm97Z1NdyF1Ku/iljZKbxUYXQC3
	oMTuvo9kHA3/wDCrAXdKntLl3O927cMRnlfBMhxaf0+QsOvRZM4N
X-Google-Smtp-Source: AGHT+IFc4quup2PVQI04GykPP1rc368w7lB7TmA/X2/kJcjFKtZl/DbVIOsQEIAkB5HL6h1SIVn8pQ==
X-Received: by 2002:a5d:64cb:0:b0:354:e778:3665 with SMTP id ffacd0b85a97d-35efee307bamr7496441f8f.5.1718013761158;
        Mon, 10 Jun 2024 03:02:41 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f212aed2esm3248721f8f.26.2024.06.10.03.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 03:02:40 -0700 (PDT)
Message-ID: <fe0a1e51-8b88-4f6d-98ec-a5e6c2a12e8d@grimberg.me>
Date: Mon, 10 Jun 2024 13:02:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: nvme: target: core: deref after null
To: Alexander Sapozhnikov <alsp705@gmail.com>, Christoph Hellwig
 <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240607134340.11-1-alsp705@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240607134340.11-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/06/2024 16:43, Alexander Sapozhnikov wrote:
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
>
> After having been compared to a NULL value at core.c:813,
> pointer '(**sq->ctrl).sqs' is dereferenced at core.c:838.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> ---
>   drivers/nvme/target/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 06f0c587f343..5a67d2bc0c55 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -827,7 +827,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>   	 */
>   	ctrl = sq->ctrl;
>   
> -	if (ctrl) {
> +	if (ctrl && ctrl->sqs) {
>   		/*
>   		 * The teardown flow may take some time, and the host may not
>   		 * send us keep-alive during this period, hence reset the

This is a redundant check. sq->ctrl and sq->ctrl->sqs have the same 
lifetime. If
sq->ctrl was assigned, it means that it was allocated and needs a final 
put to
fully cleanup. ctrl->sqs is allocated in nvmet_alloc_ctrl and freed in 
nvmet_free_ctrl
which is the final reference.

