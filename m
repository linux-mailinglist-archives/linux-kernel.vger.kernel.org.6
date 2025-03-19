Return-Path: <linux-kernel+bounces-568831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E86DA69AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBA116F9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AE4214A81;
	Wed, 19 Mar 2025 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NijzHpPo"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD121579C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420013; cv=none; b=T+b8Hmndan/3HcnkAscO+8d+4OC+LzoQBCGoOUgzU2+KFisr64RysPMF0O1NiTBu3HS+ls8B9kOlWZG7C0Uc/qJQd3HOiNM47UIWUKqMWILF/8pTz4hc8whpacWrAGlo25x3NNaa63Im8mBDIf2raaKuQbtxS2P12pwL8CpWZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420013; c=relaxed/simple;
	bh=nbOUfrRKv8gbG5f99IfsIMt8DOkpl7pjwqLVaqWQeBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlhmH19MrAL9JNjZK/qgYw9HJJaFieatNNtMg2/2akyB0qaPmqiX9JunxCsygiya8B9uMAWFrdmMUklSjFFydH6HSJVnLVK/KRlxgMt8zN/Qgx06ALBgl8hBwlbikPcvI5NczVOidNNFzOScp71bHH8vgrij99peLsRdAsM+E/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NijzHpPo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso621765e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742420009; x=1743024809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZZnr8Peg4sgkDN5O2NmMXhC1AaZb9dF39U9SKehLEg=;
        b=NijzHpPohPdF6m7/0mtQ+ilngmpDjd8depCVG2MpoGJ0NUtjMuY1vU8B/PnFpUQuib
         9lZUxUGbBaSKsd2eQZnNzpe/Cxj37byKjaJTFzqJffSP+fBg9d7K1h0EnnmP6ZhhrORq
         lVywax5T8CXgxDd48jn6bB5Js+o87a629jwFdy9Xb1LH0iN84PRj8a7Gig+FvK6tLEKQ
         X16PnKEhEVF2BjeTGlauAN2HVbcUuTi081seoCiNcsMajy77FbZVofm+vKiD2d+npouM
         ERvTb+lJfbGvwZshee3X7aoIofOk+b6FW6peNXMZmixTshKCW+6gN/1xoex2hCYKAYDH
         p/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742420009; x=1743024809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZZnr8Peg4sgkDN5O2NmMXhC1AaZb9dF39U9SKehLEg=;
        b=TW9qHDeg6pD5JOh3ndx5FRQc2L80P7FoiN5VphM+0ocgivs98Jq9Gj7brNULxVwe0e
         WNxz9K6IRD3i+thieXH9U891P7MlfHLdw1E55mLt5IR1OqBU627DMTLgfdZ8/FKYtT5O
         sv2apY5dfF1AQiM8nUqsn+xKMSE2S7whJGfmkh+Yf9+0rUqtn1kpLaSzVXnHMvmf62ga
         XUbGowX28blSabyf3DZd6TvIajLh8+oRWJEq2jc4YuNesrqomyI5S2lRJddPafFHvgHQ
         tMa27GEXabSoIbpx5OuO7Mn/vUfLjVbF0epP1yYfDvmC7VlXH0c9ex/RpknR2yj2Eqlt
         P6WA==
X-Forwarded-Encrypted: i=1; AJvYcCV+eQn8m9znyC2xQb/mYBDngui0meQoXXT5U4yL0Qox5z1qCDSzubEZn206wWAB/1V7nBQvsyKnuBcrJIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk01EhIaq25H47JBkKRELnh8vT39NGkcQVIOrNqYJWj7A2IKSd
	jQPnP2bQNixi8w/mH3Vpm6lnpr6ksD15wgPLR3zWsdOS/45biCQ9j4LIIg==
X-Gm-Gg: ASbGncvPvvDxkKIHtjSZzMuoZp+TXmGzv1f4jatyhjofLnqFBpX27q8A6Yor5I3Wsya
	hemPwBBGH7HPOdeLGFNFLESk+WX0STzFbjDXkyEREvWPQkrAlteIR53MEkswA1W/OPjYEvZY4lf
	CM2AEjFgQxT33m8ZRp3SRrBfzwUO782m6nEDLhuVmnIOW4g0kaJwbKX75yOp1EQaw1v5lT+XPhl
	nHBuLrS0qwSC6bTMzTGUw8aImgjidMMfzs3fZIYdSaKJb0FcdQNTsBP39iCad7ZVqhatIeg5R2e
	JvKnaytAxHOsBO52s0lK3wbWiXlB2mIurnVlWpZ3/ZQdcUbmcZ0VNog+s8Z0M/zSSb7lPD5Zniq
	kRbOE3fQ=
X-Google-Smtp-Source: AGHT+IFOk6grmlPeOiStRfVkidnxaMQXz4SpvB5TFBLqf7uN6Kx1t4fNnlWxPwuptc0lhMR2/6CPfw==
X-Received: by 2002:a05:600c:ac1:b0:43d:49eb:963f with SMTP id 5b1f17b1804b1-43d49eb982cmr2544855e9.24.1742420009217;
        Wed, 19 Mar 2025 14:33:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f47ba7sm29093165e9.16.2025.03.19.14.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:33:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 21:33:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: <shao.mingyin@zte.com.cn>
Cc: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH] nvme: replace max(a, min(b, c)) by clamp(b, a, c)
Message-ID: <20250319213327.2bf94bc1@pumpkin>
In-Reply-To: <20250319210032.5d442b0c@pumpkin>
References: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
	<20250319210032.5d442b0c@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 21:00:32 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Mon, 17 Mar 2025 15:39:09 +0800 (CST)
> <shao.mingyin@zte.com.cn> wrote:
> 
> > From: LiHaoran <li.haoran7@zte.com.cn>
> > 
> > This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the nvme
> > driver. This improves the readability.
> > 
> > Signed-off-by: LiHaoran <li.haoran7@zte.com.cn>
> > Cc: ShaoMingyin <shao.mingyin@zte.com.cn>
> > ---
> >  drivers/nvme/target/nvmet.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> > index fcf4f460dc9a..30804b0ca66e 100644
> > --- a/drivers/nvme/target/nvmet.h
> > +++ b/drivers/nvme/target/nvmet.h
> > @@ -819,7 +819,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
> >  /* Convert a 32-bit number to a 16-bit 0's based number */
> >  static inline __le16 to0based(u32 a)
> >  {
> > -	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
> > +	return cpu_to_le16(clamp(1U << 16, 1U, a) - 1);  
> 
> Swap the arguments into a sane order - clamp(a, 1, 1 << 16)

To clarify further it is clamp(val, lo, hi) and is only well defined if 'lo <= hi'.
In particular the order of the comparisons is not defined.
It might be val > hi ? hi : val < lo ? lo : val.
Which won't give the value you expect when 'a' is zero.

> 
> 	David
> 
> >  }
> > 
> >  static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)  
> 


