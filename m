Return-Path: <linux-kernel+bounces-568795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE5A69A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4148A4E54
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91F521A955;
	Wed, 19 Mar 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhNidU0T"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E412219E9E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418038; cv=none; b=K4q0RxO2IhPY9tshKN/C28h4iZVaSX2ql5hgGX5xBO2qlgt1qovxrAFxckVBZtOJJ6IvQGborU18B03jUCjAEyo39PSW0lDj8Vra0frrDbpmWpAEdMf5lC1l9UfaJDiHQ5X9T6McZ+gEDJyr+yYGOziawAa3j5ArPmI82kzAKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418038; c=relaxed/simple;
	bh=JpWbN3PonD02EeSQ+D1c94qmanNDOUGdytzOyMjZgKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMy2QdaAnmyqLrpaLqcE7uvXCgzeAlQ2YxZDBCnlid1ogpBJk76K6bTyoL2gRwv4QYbs7VvtAGIXnoHGARMgYjIqTH6bak9LQlqCZL5G9bWLWxvWGBvZQX3oQTJKlPTmrbDlwjre0GOLg9b7MxFE3/lLTUdvzT5TzCkaIaId9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhNidU0T; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so30197f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742418034; x=1743022834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9fA0vigQcgLewl+P2hKDh1ek8N/s4rvS4ZYh23xgGc=;
        b=FhNidU0TqclHktySFNOO9czi0awS2z6eLZwPya8XWaoLEvjILKnarlGTR7l8awz12K
         g0LRHq0hls7C/EOYF8sHw57RhqS5lSv9Fh2TEndPRSmxZSMIbMnufPbbCzqBJAVUhbvR
         P26Bb7kjKm32mKuIdWTVTkFU0UEVwBw0NRJLtYgCxRx3RKoz1OrtymiBoutoa7z4iAgR
         YsdXjY6AwnyxSWLThdo5ccgPf2hcBN2Fp2kelV3d9xNhykb+XX3IVMfFn9gh7gHC8Zpz
         cgGwnYsfV81WphPLQUNDRm0nk3Az+Z/waNMRYRtVbtMCqyi8mAu7qEvhzkK2mS9tmxv2
         pJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418034; x=1743022834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9fA0vigQcgLewl+P2hKDh1ek8N/s4rvS4ZYh23xgGc=;
        b=OTE0HTxxfBibA+rhZcyxmdz7dC8ocrjzyyTAPqlfsYTFtgLuEtTzk16+tPyisWVfzI
         KmPbz/XaBtX8+XhBoPkw81EknA6QBufWi7fBoQ5ZQOz55lDo4BSI2rGWhm0d4yuOs3pq
         p7EmH0ZuNMdaLGw1/djYdiq1IJ7GpXIiPL4rYdZ7eRuoD1ig7wcn5sCBdJnZEb/15egY
         f2CGwh1pJOFxd2Dy9MStUNc5rXgkPWHf3zWuxeEBZpwSkGvuCT4E/FpnZKB7H9dvKEhk
         6pqUK0nOEVFEVGUK+Hup2pGU0IKuNKYXQyVlZ2aK2leMQje3bEjM2FDz51RQDlD9tJIh
         IbXg==
X-Forwarded-Encrypted: i=1; AJvYcCUlsynldGN6pZro6CFdDHcU5cPZrq/5/aAf3QTQ1IUgEGs6KfLketRTc+GdHVtPFOVlHTYZ5pJ8fMfRBqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHmhoKNYQuYNsPcYfNSnIh+e0ZP4brubcGGaS2lWJaTNSU6YS
	LyAA6kfMoD/1DYfpcxv9NCWBM8lKYx52I83XSmnwgfGGLmwKrqnV
X-Gm-Gg: ASbGnctMJqVZ7Z4oV9c34iZ54UoaxY6ys62n41BPMIni12Jpv946TARBXeqlzsIwkt8
	Bp79lWvZIXfTHf+4jI15PENRLoVOZ5BlD/azl5qqtQPQkp2CBi8jYmWqvUvVUa5moEeNKSkAZOA
	Nrqds4VSu88jcE7nQp0wKbSGQXsggeIDqjGXJcQTY/twUoN39gh111Qi2x1xHU0C7CKgpCDzEou
	exhqf5mnfnIIYBpPMBpDFMas4zn7eojWsLUplxRSCzKKR1wVDPODTduYOrLX3NDnaCO6h75AhvH
	TTnt4nzRAc2DXyp1GtZRDGlVCjgVc7+Nav466I0VKjRWHJrZqls81bfGA8+UIGNL4HQKQAhVpE4
	NqPOk5eI=
X-Google-Smtp-Source: AGHT+IEh14hIPzocWY61j2hM9V2XCwKM6EoxuGhHTrrI0GDTgEhJ9w5eegw2wU9kY9qwW+6pbIpMug==
X-Received: by 2002:a05:6000:21c4:b0:399:795e:d899 with SMTP id ffacd0b85a97d-399795ed8b6mr633215f8f.14.1742418034195;
        Wed, 19 Mar 2025 14:00:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3537sm21976764f8f.8.2025.03.19.14.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:00:33 -0700 (PDT)
Date: Wed, 19 Mar 2025 21:00:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: <shao.mingyin@zte.com.cn>
Cc: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH] nvme: replace max(a, min(b, c)) by clamp(b, a, c)
Message-ID: <20250319210032.5d442b0c@pumpkin>
In-Reply-To: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
References: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 15:39:09 +0800 (CST)
<shao.mingyin@zte.com.cn> wrote:

> From: LiHaoran <li.haoran7@zte.com.cn>
> 
> This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the nvme
> driver. This improves the readability.
> 
> Signed-off-by: LiHaoran <li.haoran7@zte.com.cn>
> Cc: ShaoMingyin <shao.mingyin@zte.com.cn>
> ---
>  drivers/nvme/target/nvmet.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index fcf4f460dc9a..30804b0ca66e 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -819,7 +819,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
>  /* Convert a 32-bit number to a 16-bit 0's based number */
>  static inline __le16 to0based(u32 a)
>  {
> -	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
> +	return cpu_to_le16(clamp(1U << 16, 1U, a) - 1);

Swap the arguments into a sane order - clamp(a, 1, 1 << 16)

	David

>  }
> 
>  static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)


