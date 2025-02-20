Return-Path: <linux-kernel+bounces-523610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFDA3D92E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAFB188E688
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B911F429C;
	Thu, 20 Feb 2025 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8rrZ7A3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059DB1F3FF5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052217; cv=none; b=HOupsWAJx7FN4EHfy4kKFa8kjr/G0f2dcmJvXU50pBL4w1PVJ97LNsVS6LzQBj57axsnW6k+hrSWSfWWJyPnelA/AnlvRAILQ+U92sA+kZGFufHeuJkYzeH/nEaok7FEUQ/KtRETGxOD26suFM3yCzbVWKHAejChknWtTVyZA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052217; c=relaxed/simple;
	bh=Qd7iLMU7K6oE41J/ZPWCIKeYBKUVZk11zBd3yFWEF6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qpYRxd5WCjpw8whsMCPVTE7e58LI40oH/HbipfSXoP4yaZlsZb/tmizNtsHA0pmmLxwcQeCZdnQ+ZPu7pXmPox1uUhso5Fw7XuUhC1jhSzjXGCrpFMVU71U2ooqbS2/zpg6/rYyhfdhkqcyCigKxh2yNHEap2ornnpbl76cQkEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8rrZ7A3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740052214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCL5T2fOGWwb4Ncq/3B9uFaujaHLIklsmBY7EqGh3To=;
	b=i8rrZ7A3uol5ynLdErGlKl/cE4eOlrfWxPUf5RyWYZ5H/PTPwWv2liEHszgPUgGJaFta0W
	VMJSpLTmD3HQyeRvE+ncWtzzEGQK8uYi5kAZyvYVSh3ryP52EwLlS/9XyXA8pcH77NfTqs
	k1MvIA5kqkbmsOe9JYE2PKU0Ebu96tI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-kmDHzFAdOQGzPedq-Kjx0w-1; Thu, 20 Feb 2025 06:50:13 -0500
X-MC-Unique: kmDHzFAdOQGzPedq-Kjx0w-1
X-Mimecast-MFC-AGG-ID: kmDHzFAdOQGzPedq-Kjx0w_1740052212
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4cce15c8so434244f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740052212; x=1740657012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCL5T2fOGWwb4Ncq/3B9uFaujaHLIklsmBY7EqGh3To=;
        b=pqYRtSHJHj4JjFKW9z/O+IIDtiwsCk6C0DKIXliJQmKr/m9r13kfBu0hj311eogBaJ
         /tMjr9JP0AZs5B6MICVfDwSyvjiv9pZUnVCCmYCXssyZ9Y1adx7IXakozsfFPBDqs+Jd
         uyHrqp4cUs80EAJR/dOELGo4/+tWEZgPEVsF9znXrf4pUZlwYNoYRxLF3xwLzzl6C1Zd
         NoI2Brbfj+6z6HZkwHw0rZ7O8BvAU3tg0YouaipVDu6nhNDNlLnL4il99mVv5oKE0M9t
         4sgwcsPj3lOPTg2LamclY43ZLVMz6a3QbMZcRzkTHSaHj6QE3OQ9MtU/NpsOr94086j9
         lX1A==
X-Forwarded-Encrypted: i=1; AJvYcCWiCZXXVESiTAsgtFr6527VCTzURAaD/vacs0yb1omyKv9yy7i3YB6iVzEdMURFYFvJmY4/QCrBkM8U1Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5v6/GQKbEcJ5nRi+CT8mQziaMtwLydT8IsXIGLlgKCw/+Vw0
	T8xLz0wGIN0W2YVo4bbsOkVzoHmTDFGJdvsoTGiYc5I3f6x5LihmFkwcEmDmc4ViP65jUW/kI7s
	UsON6kG0gBLQtXYEE6XinVTdEaZCoiSpgHEdQRSjjUDvC7KkJvS9hdHE8fQm1NQ==
X-Gm-Gg: ASbGncuxu43PZW6z7c2KqJoppNVljyxvTaMcYMDz+4p4vm0wioS/2S0fDiXBz65yP22
	uzuYNv8xiiIsSJZB2IvmJD0ez1wR76fCOorSKcm3LlZ0UK9Ro3b47ZYLj5rr/6A/8cUoLZgCN+X
	QwjP2GvTSBq6eUsWv8KTSenfZIAnfxFAxQ5LTMPswp9/y1qwu+vHL03rPWytnAHb/dfpczd3sI5
	vZHGppSnq/0hE6YYuNgCe5W4eMWO9LWnDfI6Rgpznkkz6/X+eSKGhaACjE+td1OYG0ucB+NObdF
	WxzJliWDfna9/EtjvCK1Pg/ZB4lc1JVpNZo=
X-Received: by 2002:a05:6000:1568:b0:38f:43c8:f751 with SMTP id ffacd0b85a97d-38f43c8fa82mr19116903f8f.35.1740052212182;
        Thu, 20 Feb 2025 03:50:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXl5fZZkeyKsU5VFWXzhep6rpst2tghJmHc2P2hWr/bmfrj7kfG/Efxf/IMxjJnR76hGNfsA==
X-Received: by 2002:a05:6000:1568:b0:38f:43c8:f751 with SMTP id ffacd0b85a97d-38f43c8fa82mr19116865f8f.35.1740052211727;
        Thu, 20 Feb 2025 03:50:11 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399600257asm72707745e9.4.2025.02.20.03.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 03:50:11 -0800 (PST)
Message-ID: <a0f4651c-31a3-4831-89a4-ee3010b3b4ca@redhat.com>
Date: Thu, 20 Feb 2025 12:50:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 2/6] octeontx2-af: CN20k basic mbox
 operations and structures
To: Sai Krishna <saikrishnag@marvell.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 lcherian@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch,
 kalesh-anakkur.purayil@broadcom.com
References: <20250217085257.173652-1-saikrishnag@marvell.com>
 <20250217085257.173652-3-saikrishnag@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250217085257.173652-3-saikrishnag@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 9:52 AM, Sai Krishna wrote:
> @@ -2443,6 +2469,18 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
>  		}
>  	}
>  
> +	ng_rvu_mbox = kzalloc(sizeof(*ng_rvu_mbox), GFP_KERNEL);
> +	if (!ng_rvu_mbox) {
> +		err = -ENOMEM;
> +		goto free_bitmap;
> +	}
> +
> +	rvu->ng_rvu = ng_rvu_mbox

AFAICS rvu->ng_rvu is freed only by rvu_remove(), so it's leaked on the
later error paths.

/P


