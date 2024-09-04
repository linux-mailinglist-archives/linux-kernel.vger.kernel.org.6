Return-Path: <linux-kernel+bounces-311192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83529685D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87D6B21B90
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201E170A03;
	Mon,  2 Sep 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnsTmaeB"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CD3273F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275418; cv=none; b=JaEPvl4nq9bmS0ltI7RS9wr4rNq++VzwVIAZcbeM9lfR/Rp+Z8zj2xEU6IqPgIqawvceghyuVI+XQkhuNocmEGB8+vpT7Z6KQ4uh0fu56ev8jfxHl2lNd2FDsjWDx6FR6ccE3CsGbaORMtAQoxZKLrUKa+zC6jQOATkLRNVDJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275418; c=relaxed/simple;
	bh=afGKlEcvIBL8y13KBacFrS2nAEcKGc9EG1pkvjKK2hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnR+63GXec/hceEMiJvQmtOB1wFCSmKy5zn69S9f440ejTRKdb1w2r2+D7dO/OBevCZmRdkVFC1ddZ5niqBHaP97j5rjMSlowTD7Sn8kRDlSn2LK6+Gthdy/P3rTf4zrZLzpez3JlVd4iuiec85uWkDL0pxyLLevXbhnstUqGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnsTmaeB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c84dcc90so658903f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725275415; x=1725880215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Yr1AbDz3pAF6i2Nwdc6oL92uHgHSwP5utweidTWwIA=;
        b=xnsTmaeBGuz72b9E56xtolEa4R/MeKC01+bJXWKmf8dywyFc8w6AbxVvYgCHfnsRuU
         e11IFiHPv4SJ/QVKvBbCYyKdLl0Vem+woQ+LnGDqCg/bNF+OSV3e3uXeAdR9LVtsyx6i
         AWhah6TtyL548eWw2QE6BZt65pPqYgeJ0iU9qwnfFfz7Uimht45TpAk9eYQegMGPFvkr
         PJzns3z9du9JPXBEJ5JdeNE6tP2dwtD4jsBIYx58EMXvP6/NnujpnOT9XIXyvFBapDwY
         VFu4pO+fBsUUSod0k5ZJ0Lld9NM9vqSGXzfJBZ8tT9yNZk1y0JLXZHe/q3WzvjGfccr3
         pViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275415; x=1725880215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Yr1AbDz3pAF6i2Nwdc6oL92uHgHSwP5utweidTWwIA=;
        b=q0MQ2k0/E9m4f35gEuj1SvwPMzzgPnis1dicsQG98PpxoeGIGpTzGJ/7bTL+wqNJRd
         ZDPoAr+0Y/LpcOz0utp6XEPvHJkAqZJNzhZ/dPMUAkUnCXeV+R9LcRTAOLUeXkbqq0Hg
         YrIj832c1Zys9RsvEBMNvt/9H0ZfNympiffhkVGKj72jXgCmvRVlyzGq/uDiSW95hDII
         MhAdqDnHA9Xl6RZjF1RGgrVepQubc1mWO7723BSlETdyLL4B+2Tmxg5WEQLgsCl6dKk/
         WfzUjM7rQhJN+lVDCMTBBoMOVd+OOKabaDJiXCNnH/o/iGO+YouqoC1JAL6A6zNC09m8
         RVgA==
X-Forwarded-Encrypted: i=1; AJvYcCWjetJn9gDdwSgOgezai8A3684nIiZXWRh6H9b3w66uCw2yISVKoZwkZD/LG98LIO2+aZLMH9QHGViurwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPI2hkDvQlvtO43WcAjTXxmDa4mWjDBbdnoRSlgHD2fl0qm1Sm
	VkVZuIq2W9jDTa+6OKt/LU5qY9Asw7IPcW0YbjMvXyfaOWKLOF1KMb+ooPjhWWE=
X-Google-Smtp-Source: AGHT+IFFKOcLENrTzpSe+YOhxJHEo9JEH1LGbrPE9GTWkSgqUCf5imV2HQIPW388XVhZJlwUiOGE6g==
X-Received: by 2002:adf:ecc5:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-374c945c443mr2194700f8f.14.1725275414997;
        Mon, 02 Sep 2024 04:10:14 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb6df1066sm133737835e9.18.2024.09.02.04.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:10:14 -0700 (PDT)
Message-ID: <b4fc2024-84cd-4b10-b974-9886421b536f@linaro.org>
Date: Mon, 2 Sep 2024 13:10:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: brcmstb_thermal: Simplify with
 dev_err_probe()
To: Yan Zhen <yanzhen@vivo.com>, mmayer@broadcom.com, rafael@kernel.org,
 florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, rui.zhang@intel.com,
 lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240830103918.501234-1-yanzhen@vivo.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240830103918.501234-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/08/2024 12:39, Yan Zhen wrote:
> dev_err_probe() is used to log an error message during the probe process
> of a device.
> 
> It can simplify the error path and unify a message template.
> 
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
> 
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

