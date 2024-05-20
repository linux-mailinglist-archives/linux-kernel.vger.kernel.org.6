Return-Path: <linux-kernel+bounces-183505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FC68C99F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BD3280C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB361A2D;
	Mon, 20 May 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClkoGjEY"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2612B77
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716194869; cv=none; b=rSRkFFHOClxbhrsEZz/e4GGO7RQQdGDv0Nz4Qn83obHh3GHI3hvWmAo22ecKQwlzAvOLuMmpaZvPMl+Hr5w0ATUTFOUDwRFlo9B4ncCzO5LW/F/ghCPZ8g2omG6nSKMh2a3gqi/YTt6MNpDmBhLBctgsoNMCuw4LvvNQBAghy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716194869; c=relaxed/simple;
	bh=1JXwg3co7CA4yd8HEmvpHCNIBhJLvkCWwnyE35UiQjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TipA+R6QtgZHrBx/KxS7VmvMJhuVwNz8epM9k3btlgDKdpsdR8UFEhU9rFfeCIMDcbtadE/FQiWB9inZ0EUVZ0QDAjtGtpGtwo5y5onaS8BPXWrCCwWq0Sl0/koWqCL6oZ2RptrNfXAJhjuvWPGpAb3XSg0bER7+aMjHs4208JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ClkoGjEY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee5235f5c9so64891125ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716194867; x=1716799667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrLMhQtHmFLHs+kWdp3R2y+V3C5K0eADNR+Y0D696q8=;
        b=ClkoGjEYQ/cv7Eff3faGvgT35sEOQc+VhdA5v2h02Qi/vFPyO9hVabP9gqtE1Lxlm2
         yTSEvDnXe98j0VrtzOy22DNbYIgc5+r1leT/JU/KZ4n5zE/zwoeAnQPDJ4S54iG1CMA2
         HS0RCPfzSLXaHG3fPU6LPPUejp6mFbTqyh8JiOrWbIodtWkScFtzkJTs/uYoiFE8xqO+
         7i7XUC6DlkKYMi8FrVZ+MD0Lv1BJKk0WcUAIx6Re0NydYQQGhYxKSKUAS/13mvxOjnJC
         2NYaBhXxflrZ5pfs0zglKfMImyHySNGMXvSRAwoaSgO+lmEy3cAkndrDtG8h2i9ZpUll
         E/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716194867; x=1716799667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrLMhQtHmFLHs+kWdp3R2y+V3C5K0eADNR+Y0D696q8=;
        b=LMLIRzsVYTh0Rhhb768f1giGy5cCzUshO+qmdpoJB4WbMhxOJqTIYMPRW3mOstEKPk
         OdYB2zrcueLhvTCr251Xc0ov49/2PNwuhwvcYuvsqIvzxj/9U1VcrAEqix0hrA2iKKB4
         SnZLouDhkSmZy0joKkqewLsU4Nwu4aetbDEBTJ0jxUQDeHQdSW8FW8qty7ek8IW61BBJ
         DWznJs9ktFu9CatZbi9fMhxPdbn3VoQ4PR1o2xXMMqUKIgGrE+QB+1+Ic7L2gFquZ5ud
         7fe2wQjhbt+wLoVemxS7cLoX+RbYw1tQKVYwLvGVQceFe96FmZjwdzVw/DhUq+PfHTfy
         QlQg==
X-Forwarded-Encrypted: i=1; AJvYcCUN3Bm++v/m9sWG1D6VALBmTJInI88ExfupMgolF0OH56kbiYJlto7mYZthpfy6cAZskm4tb53UAQKr1uTJWRNyg62gVc4ikbkEMAai
X-Gm-Message-State: AOJu0YynQPEVSse/NF9TGopk9oxxIraK+7lnzsNNEbF9Y+uOwN5QJqub
	9eVlea8y2r0IG29Gsf8TTQ17bSMaT2kOt6Iw3RFSzRB+nURFbUppT0yE0oW20sE=
X-Google-Smtp-Source: AGHT+IHIV6eCV/9i6/dZe1BXa4HhbTQyGQqcAj5k+kJx1rGb6z5ATgfbFY+Jq78Q6UjwvQeG1Eelvg==
X-Received: by 2002:a17:902:bf04:b0:1e2:1df:449b with SMTP id d9443c01a7336-1ef44182635mr255554345ad.69.1716194866898;
        Mon, 20 May 2024 01:47:46 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30523c34csm9111535ad.13.2024.05.20.01.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:47:46 -0700 (PDT)
Date: Mon, 20 May 2024 14:17:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Vivek Aknurwar <quic_viveka@quicinc.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH V2] cpufreq: scmi: Avoid overflow of target_freq in fast
 switch
Message-ID: <20240520084744.sb2rk7l2pjf4whyd@vireshk-i7>
References: <20240520063732.11220-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520063732.11220-1-quic_jkona@quicinc.com>

On 20-05-24, 12:07, Jagadeesh Kona wrote:
> Conversion of target_freq to HZ in scmi_cpufreq_fast_switch()
> can lead to overflow if the multiplied result is greater than
> UINT_MAX, since type of target_freq is unsigned int. Avoid this
> overflow by assigning target_freq to unsigned long variable for
> converting it to HZ.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes in V2:
>   - Updated freq variable from u64 to unsigned long to keep it
>     consistent with the rate parameter in scmi .freq_set() callback
>   - Link to v1: https://lore.kernel.org/all/20240517070157.19553-1-quic_jkona@quicinc.com/
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

