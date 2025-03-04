Return-Path: <linux-kernel+bounces-543901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3725A4DB3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E4E1883803
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC81FCF44;
	Tue,  4 Mar 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4QaeHCb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA91FC0F0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085268; cv=none; b=IsMNMsoR3yOkBZpdnrMNQ2+mflost4tIxSrwnCUluwGT7eKjghJTXG56ed+2d0rt+iCc93BKivSaxraidHkehDWCwWC03RLpqpm+QwAbtl/5NB/MB5jvfmrVJjy1MnWxyMk3BIwzw2AXMeWMrwUiv6mPLY3a43tI7GKgplli+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085268; c=relaxed/simple;
	bh=GDHmLRbpTAvcpqKY9+nVbCg+pOeoBmL645S5vBz+z5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoAlutOpKccphYW5tv6Pm/R461weYmWGANvsvq00y3Kk3NfAl99G7qb108P/+uqG0dpEUiWTtEMjy3fO1Y40uO1zYJXYBCplei05La8W9yVC3yVgQmm8ASmol+tAD5vkOQZjJJNg4dhQDrx1Hh8l8yaGs4AXOLuQP+etCqD4quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4QaeHCb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741085266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozWRlkVvFvj5lU4SkREoIbQWM7uBXzxDwOOcUPy61o8=;
	b=K4QaeHCburM98vq5uCAyE6YaW8v729wmcvdBxTbjNvltNA1AjGR6XXXOfvngreXuka7XpF
	OIHOORVXgOh6LEq/M1hKcfNIJ/75c+jdK0qaxgPUlrIS54wLwMdR7qGdNFWHgBjHVpgFGb
	N65tSl2tQFy9Vbwyzts5kZ4AUKEIZBQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-GZtO9-IXO4qcQOQtyHapXA-1; Tue, 04 Mar 2025 05:47:44 -0500
X-MC-Unique: GZtO9-IXO4qcQOQtyHapXA-1
X-Mimecast-MFC-AGG-ID: GZtO9-IXO4qcQOQtyHapXA_1741085264
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39101511442so1124388f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085264; x=1741690064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozWRlkVvFvj5lU4SkREoIbQWM7uBXzxDwOOcUPy61o8=;
        b=hUD0KGYnO+j1mScB2+Ipo7mgjb2rTqBBd+b0V7Q65zlVDWltAaH8RO3soH6nuMx33W
         qyPRlutPT16wFNt4e96RmnIM8G92OeYFjIYcwxuTKBJtGEfYrNuHypPB4Tt3i525rYnG
         ZyoXpUZNDyFK7ai6kSuKVIoSSQU3TqKoTp1L9QhYB6j8ZanGW/kQrq2DP5QdpND7caIL
         0gTOtjqfTbtGboJqwmSajPqFOnFR7Rxlj9hu5hGbIkdHgeq/iBn3XwPbo/RKmyaQUp4F
         q7mT7FLqBJm+WlAjPkYENr3UxYsD3gu1It6N2uH7HK+L/c6YzYOagf0uK+66LPCeUxJe
         zbOw==
X-Forwarded-Encrypted: i=1; AJvYcCVse1WcCzPm/yOdedotuXAouIXUEpCxEJtzQid0/ETbnM2H6E8QPSz2T/leGDoeG7sUtxYOzpV9ey5In+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukzytCvbPPnVxXDsG8NJYMBZRoB59CsE6KonSpeU18swQWC1s
	mpau58CpMaqOahmKFcTZfeQlZxyupUVQHsK+K0nDc5TRlGJrnM4iVLCMCmT0zSfnd64R4H3zEB3
	ryRZt7KUlclv3iL+YzYKVab5Q97ZrJ422KflEyOGzdIp4+NyVBGHm2oEmZy6KKA==
X-Gm-Gg: ASbGncuus7NOZ8+VPHVANIIyVl2uTwwH2NepZVaCmxXdaGFDgfSySCV/6eeSOZDifnY
	PxlhiV4RtWil/T7RgNZjsPpGnFaLOOmsYv8WYg9HyZQczrkDg3eozfJ8HACbsGH6VwFqgdPwb5f
	7t/QWBYOCnBtIiuYHlXaTlYvgH2qhLINaw31aNixr1CAj8a5+Dh3aOpxSRvcsFuT/ITqifTCMne
	c73BJuRf94OHfPMXFN2fLsKf3cDuT9xIIOrSLPJG5xYL8NjUOhsNTZMVROVPEU5wqRcl0efwVUU
	KdVBLsSjoEw0Yjvnxi5NxU+p4zB3l2KDrYOAam+eKHsw7Q==
X-Received: by 2002:a5d:59af:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-391155fff3cmr2199360f8f.11.1741085263742;
        Tue, 04 Mar 2025 02:47:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKsGGn0f/jRHWk1XXNEVK6OtmwuK7qRmHXGvVjX+OIeWT8bbXwzK3XUIPqKMexSIXmBvuV/g==
X-Received: by 2002:a5d:59af:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-391155fff3cmr2199340f8f.11.1741085263363;
        Tue, 04 Mar 2025 02:47:43 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6f22sm16984595f8f.47.2025.03.04.02.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:47:42 -0800 (PST)
Message-ID: <b16a716e-69e3-406f-a0f6-1d62cfa39c42@redhat.com>
Date: Tue, 4 Mar 2025 11:47:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] enic : cleanup of enic wq request completion path
To: Satish Kharat <satishkh@cisco.com>, Christian Benvenuti
 <benve@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>
References: <20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com>
 <20250227-enic_cleanup_and_ext_cq-v1-7-c314f95812bb@cisco.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250227-enic_cleanup_and_ext_cq-v1-7-c314f95812bb@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 1:30 AM, Satish Kharat wrote:
> diff --git a/drivers/net/ethernet/cisco/enic/enic_wq.c b/drivers/net/ethernet/cisco/enic/enic_wq.c
> index 88fdc462839a8360000eb8526be64118ea35c0e2..37e8f6eeae3fabd3391b8fcacc5f3420ad091b17 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_wq.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_wq.c
> @@ -6,8 +6,12 @@
>  #include "enic.h"
>  #include "enic_wq.h"
>  
> -static void cq_desc_dec(const struct cq_desc *desc_arg, u8 *type, u8 *color,
> -			u16 *q_number, u16 *completed_index)
> +#define ENET_CQ_DESC_COMP_NDX_BITS 14
> +#define ENET_CQ_DESC_COMP_NDX_MASK GENMASK(ENET_CQ_DESC_COMP_NDX_BITS - 1, 0)
> +
> +static inline void enic_wq_cq_desc_dec(const struct cq_desc *desc_arg, bool ext_wq,
> +				       u8 *type, u8 *color, u16 *q_number,
> +				       u16 *completed_index)

Please avoid 'inline' function in c files.

> @@ -111,7 +81,41 @@ int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
>  	}
>  
>  	spin_unlock(&enic->wq[q_number].lock);
> -
> -	return 0;
>  }
>  
> +unsigned int enic_wq_cq_service(struct enic *enic, unsigned int cq_index, unsigned int work_to_do)
> +{
> +	u16 q_number, completed_index;
> +	u8 type, color;
> +	unsigned int work_done = 0;
> +	struct vnic_cq *cq = &enic->cq[cq_index];
> +	struct cq_desc *cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
> +		cq->ring.desc_size * cq->to_clean);

I think the code would be more readable creating an helper to access the
`cq->to_clean` descriptor.

> +
> +	bool ext_wq = cq->ring.size > ENIC_MAX_WQ_DESCS;

Please respect the revers christmas tree order for variable definition,
and avoid empty lines in the variable definition area.

The above also applies to other patches.

Please include the target tree name (net-next in this case) in the subj
prefix in the next iteration.

Thanks,

Paolo


