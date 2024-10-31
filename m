Return-Path: <linux-kernel+bounces-391029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAB39B8167
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCA2B21423
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B411BE852;
	Thu, 31 Oct 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yHCgWUph"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C651BE239
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396474; cv=none; b=QhjWqFK32L3uY5msjeSlKmv0hbOHlLuwvmwF/PZ2ONR0hp8iLmx+FCIcjlp9HankuyQEg86lFYCaMu/pvWre1XtSfZcr8/kI2shiOvhlmrcbS5SG0YuAJ3WG6WBxu3e/F0cK30DBKkg5U4TLAsYkf59hN5wahv2AW7G+9skvMOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396474; c=relaxed/simple;
	bh=rjfli0tBFoUX1/voONhYE8T0CoIEjN4qiViiUnRARk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtahcU2ZZfqoUTuM26ZJo4vphGUiOAOR/+rC7sq6OlYQQiSaJoBSQGik84/iIwD4o5JGs3zfcHdgPo0eyMFSmn6O7Cmy08XaQ16GjumT/DMflBFDW3pjO+vTv3/FPrx8ZYKQc6Ms+yZMClIFIJD0KDEvYCSqtTf6n4jDQ7/TnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yHCgWUph; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3bd42955bso4541255ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730396470; x=1731001270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yx1Qac1de1Zs6DaCXK6vx+CLfs1Hn/NJAOE3KhROYK0=;
        b=yHCgWUph95hJEGV9AHSk8BB+kKu0d7uc1Qt26l9QDXURVOP5KCphJrdwgttzObwmYC
         dpiS0mcUKp8AID/m+LnMGLgI1ShIKjGafnLbZ2Wyvo4b027y6skH9kLawV7GEmihhLay
         atmBTFLx49vC8Aq8NGscK8SpuBB0OWsn5eEmK7tA7Zo4eEQLfxwxIRjfuc8HMa7dFAFw
         DKAL9Hi3VoNSzCwew8BEplTn4E2SomoHyw01uWL1/Zye+occYW0bmdYA81UOB8hKkCaP
         +87zESscMGVsD2X07oXzk2FsB1VHG6X8mal2Jt+nscd1bp9/qQ9Uukbwd8BeBjmAbphT
         dZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396470; x=1731001270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx1Qac1de1Zs6DaCXK6vx+CLfs1Hn/NJAOE3KhROYK0=;
        b=wIz2LRcwdNZs/Javie4EOaNtEwnX4QSqeWnPVvI6rY0wXi/MaTE7+pmqYIQ8PUIX0F
         e7vj6KpKyZxXMKHrZZQVFEBcgZ4fmhEl7kc2lWHKESh6JBUwOO9WwKLYEkiXe5KVUIi2
         mZa9JQHybnvzhWfbqgD6OpGK/aojd/vZweOfcq3dMtGC2+kKbnRzdQAtXWENz8rJps3d
         wIbvOsZYLZ+YORJRMdolx5U7NvalGhBeqibnsOMQ6hzXEUyel3GD3zd0RggfT0TZ44vi
         gXmCrFHdXFVpxiqJKM5Z021Fg5tc+o1KxLjDDzQRkazJnCoW8lCT2uwfK8JyvkQQOsf+
         +hEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4PWTtWJQJfZ5Uqs3dHGZPQUw/OxqR65VCJyZep2yu379gQUeq/rZBWFINjMwLRS5McjKBVOetLtBI0AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfT92RC5hOQaZAz4cZDMyEGkQEBc2+jVD+nrI0W0B4qDEtwDb
	iZawSjHMp0OM+NnijL6Hnu9ttv8J+nnTkium0yqPr9cq8w1n9ZF1oTZcyxkLxq8=
X-Google-Smtp-Source: AGHT+IFyXNo+4SkkDpMF9EOTb5M/8YLNvanS4IsBDAEKJMERveCtkiHuWa2Wiv0xiuh0/9TvWImYxQ==
X-Received: by 2002:a92:cd88:0:b0:3a1:a619:203c with SMTP id e9e14a558f8ab-3a5e262e89cmr84852595ab.23.1730396470496;
        Thu, 31 Oct 2024 10:41:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6b073f258sm563215ab.79.2024.10.31.10.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:41:09 -0700 (PDT)
Message-ID: <780facb8-b308-4e11-a7e7-7c258545e9e1@kernel.dk>
Date: Thu, 31 Oct 2024 11:41:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: rdma: Add check for queue in
 nvmet_rdma_cm_handler()
To: George Rurikov <grurikov@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: MrRurikov <grurikov@gmal.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, George Rurikov <g.ryurikov@securitycode.ru>
References: <20241031173327.663-1-grurikov@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031173327.663-1-grurikov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 1b6264fa5803..becebc95f349 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1770,8 +1770,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
>  		ret = nvmet_rdma_queue_connect(cm_id, event);
>  		break;
>  	case RDMA_CM_EVENT_ESTABLISHED:
> -		nvmet_rdma_queue_established(queue);
> -		break;
> +		if (!queue) {
> +			nvmet_rdma_queue_established(queue);
> +			break;
> +		}

This, and the other hunks, just look like nonsense. Why on earth verify
that the queue is NULL, then not use NULL after that. Let alone that
whatever you pass it into happily dereference it, and now you've also
got fallthrough errors all over the place.

This needs to go back to the drawing board. I'd worry a lot more about
bad code than "potentially malicious hardware", to be honest.

-- 
Jens Axboe

