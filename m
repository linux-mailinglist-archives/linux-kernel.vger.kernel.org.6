Return-Path: <linux-kernel+bounces-511589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505EEA32D05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408DB168FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D884C26136A;
	Wed, 12 Feb 2025 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8rJ8RXE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B0260A5D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380024; cv=none; b=uYdxTXaNQaj3xAEstNwyS+FSsyomoODH1ASDt7DZqriclvFUwtKZeRyz19GvBownFnAQxZTvknWvM0FXL5FZ6dKhwveOix13LIJcCpKXYxM4YhfT8AHfzVn/vlqWACsJCPIyLK6EXHAgXNCAqIQuzmCMv5ZbYqMiLMUYc+LSVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380024; c=relaxed/simple;
	bh=lteTsHAofWcNmBaXCw2mHJ/LxVM4Lx/RZ4wOuwiWnt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjGPlYSEtDEPzKyKFUu9kAL2ydpRlcffeL47tNSc32ySnsmpsjwCWBS8d2cwbmlKieYDacHRRCfgGfeOtaXiZaTdfqFK+ULiE32cQbc6GWAFo8kRDO5hPqUmHQtWQQyha1rFI5qyJlCia7tyBk92CW0kqScH6HS3tX5wVKRcxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m8rJ8RXE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f818a980cso69078255ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739380022; x=1739984822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iMfbhD6wkX6MaCnkRWtypNgtVIrRM7/Oh0qieWzgO1w=;
        b=m8rJ8RXEs4UMpNHdBa39t96D3WvuE4TNCtkDZmPZ+FXgkNVhySzfuP4FoZSHVVHsY5
         VROK/DnL3I78r7VOieozX25g/HV02dEfYFOXoj8EXaCDl0Nb7RzkGynag8G3V7PyAO2K
         aIOlw6XEMPO96/xEvTbC95y+0BowXQyfxrKU3LXloyBjwHQu4K4MfkAA44zkm80PWIz0
         Sko7nltWJ2HpOHeID8GggZucdfpACSfRUF3VcpHG0YHmePCSviroqsnjX69sflSsTL1Q
         PkT3PgUHFW0X5lbsqB8yntRo9boV7swCJeRlZvrntaaTgQSki/vRzmYyOFxpN2RLBcJ1
         Yn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380022; x=1739984822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMfbhD6wkX6MaCnkRWtypNgtVIrRM7/Oh0qieWzgO1w=;
        b=CsQxx5OBsWJ0CK7uFda78/z3pVTGp99Muy32OZsm8LKE6/HvSgi4TvIMRYsoNGc2eg
         J7qoxHpvZQ2LNgcezu7O0bQFKwbe+aOh16K2cVhn4M5J9HWwnQpY5XX5UFvEneY+zRGC
         xoTUOE1W2/0KnEJdqfHGVWraz0ob+Th36c1Z+SPtc+f13llezyjAAjrwkRKdmR7EWncl
         ibtSZAHtEpNkGm10wR83qKNizl4QAVPzSN3HlXXWkuOjaiq0YZExOxZoRtXFCWMUIaHm
         5kAp0QZbSg1QGPItBlPCL/Xyz+A0PqBeCTTGl97HKcU2JVqywfaOBvfzhkOMIJNxF/h5
         vhBA==
X-Forwarded-Encrypted: i=1; AJvYcCWJspS/E4/bg+STsJoecUMW8fq06s9aREiw7c1QmGBQSCHzare8CVkmMxcvzaI20QLe1LY7Ihhr8N/aZtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWQl8MAfaT31svvK/IeYPOoC9++5G1wqfZ/6bJHhhOWbKeGLS
	PBHgnQBiKwBA1bgCEJuZmxPEn66aUyNQw7A2zqR8gdqmgYME4Md843rj9u0KOA==
X-Gm-Gg: ASbGnctxv4fBF5zpKDSFUX3i0UnISQ1bg8NV/4QDZ+yHa+kCAYU0wJFaUD8TTDrDxEW
	GKwuFqpEqB1aKzwpSbFFLzlUjDeRa/WzwEYDuDkmoP1nnTJFEFkakwh2pjyUr/afN6j1GIKhOUi
	J7iH2MGDEGSrY5nb7ifHDy3wycvCi2f/mlDR16XsI+xZR0AfxjLDewfENXLP0HyDP0ryozlCKKG
	ZnfL4XuH0A9N7SBV5nyddIMk+5edgKKVD5umC+7LwQ92+3j0AO/5oHMjd9Kpqug5Cmfn77aT3MR
	MMzfa1pg8VPjhKF+YoCUhDxiyy/3qWI=
X-Google-Smtp-Source: AGHT+IF2luvrqC0ykZO6VitJHSJWVQ71T5mlJNsMYUeoTgA9VEadsV/+zYxhfiPIyZqZHXO7crIAtA==
X-Received: by 2002:a17:902:cccc:b0:21f:5b1e:11ef with SMTP id d9443c01a7336-220bbc64587mr79261985ad.32.1739380021744;
        Wed, 12 Feb 2025 09:07:01 -0800 (PST)
Received: from thinkpad ([2409:40f4:3012:d471:d5a7:bf83:76ba:b479])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad5434dc097sm7690741a12.7.2025.02.12.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:07:01 -0800 (PST)
Date: Wed, 12 Feb 2025 22:36:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH net-next] net: wwan: mhi_wwan_mbim: Silence sequence
 number glitch errors
Message-ID: <20250212170654.tmynyd62szap6n47@thinkpad>
References: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>

On Wed, Feb 12, 2025 at 12:15:35PM +0100, Stephan Gerhold wrote:
> When using the Qualcomm X55 modem on the ThinkPad X13s, the kernel log is
> constantly being filled with errors related to a "sequence number glitch",
> e.g.:
> 
> 	[ 1903.284538] sequence number glitch prev=16 curr=0
> 	[ 1913.812205] sequence number glitch prev=50 curr=0
> 	[ 1923.698219] sequence number glitch prev=142 curr=0
> 	[ 2029.248276] sequence number glitch prev=1555 curr=0
> 	[ 2046.333059] sequence number glitch prev=70 curr=0
> 	[ 2076.520067] sequence number glitch prev=272 curr=0
> 	[ 2158.704202] sequence number glitch prev=2655 curr=0
> 	[ 2218.530776] sequence number glitch prev=2349 curr=0
> 	[ 2225.579092] sequence number glitch prev=6 curr=0
> 
> Internet connectivity is working fine, so this error seems harmless. It
> looks like modem does not preserve the sequence number when entering low
> power state; the amount of errors depends on how actively the modem is
> being used.
> 
> A similar issue has also been seen on USB-based MBIM modems [1]. However,
> in cdc_ncm.c the "sequence number glitch" message is a debug message
> instead of an error. Apply the same to the mhi_wwan_mbim.c driver to
> silence these errors when using the modem.
> 
> [1]: https://lists.freedesktop.org/archives/libmbim-devel/2016-November/000781.html
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
> index d5a9360323d29df4b6665bef0949e017c90876a4..8755c5e6a65b302c9ba2fe463e9eac58d956eaff 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -220,7 +220,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
>  	if (mbim->rx_seq + 1 != le16_to_cpu(nth16->wSequence) &&
>  	    (mbim->rx_seq || le16_to_cpu(nth16->wSequence)) &&
>  	    !(mbim->rx_seq == 0xffff && !le16_to_cpu(nth16->wSequence))) {
> -		net_err_ratelimited("sequence number glitch prev=%d curr=%d\n",
> +		net_dbg_ratelimited("sequence number glitch prev=%d curr=%d\n",
>  				    mbim->rx_seq, le16_to_cpu(nth16->wSequence));
>  	}
>  	mbim->rx_seq = le16_to_cpu(nth16->wSequence);
> 
> ---
> base-commit: 4e41231249f4083a095085ff86e317e29313c2c3
> change-id: 20250206-mhi-wwan-mbim-sequence-glitch-cdbd2db5b3bb
> 
> Best regards,
> -- 
> Stephan Gerhold <stephan.gerhold@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

