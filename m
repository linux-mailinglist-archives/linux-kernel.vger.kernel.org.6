Return-Path: <linux-kernel+bounces-212971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96347906925
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F591C23761
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A214036A;
	Thu, 13 Jun 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLOjkhsc"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB913F449
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271771; cv=none; b=hFpqGhBHug9szK2ZCWgfNUbo3mFupZdYHwZCbkpbYBi7LB/J6mx8JMfNnhfKt4PiYDTv7q/v4VW4PD5mJ+m0+dLzllsxeHVIiw5yLmZ1F6vYZIusgD0+2K5DRfCqnEPr7u8eV1fDFsWVAQo0KeOicVtqzmRoQS73vXFiMq0xTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271771; c=relaxed/simple;
	bh=/csI6K3GGf47jgq9/8chaqlW9Z0I9qjMXHACV/hlBtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b63yZsfgUb/33enjLNgS4E7/LXNqMcSXDu3PP9SHy7ZiuMLiyF/JRRHXHw7UslR6ZjrGlxcNa6JYgHE7A/PMFvKui4hIErRZpzGuvU9K0XtUH7TyLXiUhEYMozd4QK7vwrrek9S5mzFcQqo4I8eYQSgA2OjlHAGMWLVlhcnvxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLOjkhsc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f4603237e0so591652b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718271769; x=1718876569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cu6cspdF8T8P6HUKOhK2SCIjh0ZPJfUV0xoeJIiJuuI=;
        b=gLOjkhscYWEpYmkbANAeOuz1Q6HRkWzu2UnKXStgEBCaLsfc0VXCB0rlQAjyRcZvSo
         GEdzXaoFLTi8JKKco31WtKNBtWUXx8SSqKqYIOnCOSinSCUdpGLd6x7sKbmo1Rcvokk5
         YpXwAI/CQ0TeJuemxnfegNzQcDzmCqCKDtOWmK4QVaCvgQE5Hi0azm9q1p6MFI3qkOIv
         zrDcQhkGdp9TsPpErG4pbnf/lkSDrZl3CTcP7u28M1USbe3UIX3EaGk6wFD4R5Rqm1ax
         deZaYKvuqN9aXwQOYJLvL6HN0aIfboXYNINMgKA5uzNBIIA9ILvRjvIS/ENX16DGheZ7
         xTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271769; x=1718876569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu6cspdF8T8P6HUKOhK2SCIjh0ZPJfUV0xoeJIiJuuI=;
        b=XTe7KdMq1ReCq/Dm/EN3lHV+he2fitlOYRdoTVUbqrn8n6xkxyBAO2eqsFbGxll2tG
         sNmw+HVUI+S13O1ggVNsgT0T7vqvYdq6L4v/gGQvUoLNp5OatUv5JmjSDdWfxzf11ggP
         ezZToeW8zugcWeFx5DrCowAnlUlDiDKrwAHbGNs9693LE/DJXKagB7NNRqUqOiExUQDq
         3TFQ6wUNR8Toyb7CUdGM60HIEvNuOCyh/c4qHCBT/kWR+UCzXOQMUjpRlIMCHUZZJal+
         OnyeAxdh1JKbpLSFTCBSAv3VtfFvFUQBMV5K/K4NBKn5bXDOL2tSgDN85oJeu/8w4tOV
         ifkg==
X-Forwarded-Encrypted: i=1; AJvYcCVibql82AetRe8O0bcNwDDNCDnH2O13kfECRFPzy/Wt7JnQCdcUtESeAiAyRY9OBVKROWCiHaAWFuq+SilQHGeWHjom72WB5X68xsdb
X-Gm-Message-State: AOJu0Yy6BNgMtpAzyGk91x3+LGtyVzCZi88FrPw27b1fMrm5Q7mQW42R
	xrd6lmTagOr+QdVdB3hceKaB9kCEkyosHsVZN+tKA4djwHwX/0sqK2W5ufzNaX9fxx3D/X+UpDd
	8
X-Google-Smtp-Source: AGHT+IF5LpX8illGnH4Jh3LBbYZDLJzJWGwRolEuYaWWdqEDgfDtAQKDUpG9IAQVHyZdB2FSGLL+Mw==
X-Received: by 2002:a05:6a00:1913:b0:705:cbcd:ebdc with SMTP id d2e1a72fcca58-705cbcdef6bmr2231556b3a.10.1718271768328;
        Thu, 13 Jun 2024 02:42:48 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96b6f0sm944991b3a.69.2024.06.13.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:42:47 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:12:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>
Cc: ionela.voinescu@arm.com, rafael@kernel.org, pierre.gondois@arm.com,
	beata.michalska@arm.com, hotran@apm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v4] cpufreq/cppc: Remove the desired_perf compare when
 set target
Message-ID: <20240613094245.cidth5miv4zxfg56@vireshk-i7>
References: <OS3P286MB2490EB027398DDB852BE2169B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3P286MB2490EB027398DDB852BE2169B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>

On 12-06-24, 19:46, Riwen Lu wrote:
> From: Riwen Lu <luriwen@kylinos.cn>
> 
> There is a case that desired_perf is exactly the same with the old perf,
> but the actual current freq is not.
> 
> This happened in S3 while the cpufreq governor is set to powersave.
> During cpufreq resume process, the booting CPU's new_freq obtained via
> .get() is the highest frequency, while the policy->cur and
> cpu->perf_ctrls.desired_perf are in the lowest level(powersave
> governor). Causing the warning: "CPU frequency out of sync:", and set
> policy->cur to new_freq.
> 
> Then the governor->limits() calls cppc_cpufreq_set_target() to
> configures the CPU frequency and returns directly because the
> desired_perf converted from target_freq is the same with
> cpu->perf_ctrls.desired_perf and both are the lowest_perf.
> 
> Since target_freq and policy->cur have been compared in
> __cpufreq_driver_target(), there's no need to compare desired_perf and
> cpu->perf_ctrls.desired_perf again in cppc_cpufreq_set_target() to
> ensure that the CPU frequency is properly configured.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

Applied. Thanks.

-- 
viresh

