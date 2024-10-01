Return-Path: <linux-kernel+bounces-345326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B035B98B4C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65001281FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06F1BD038;
	Tue,  1 Oct 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iqfkntfk"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6D1BCA04
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765036; cv=none; b=p4/r78z9cpNYI+whOPypQvwItRH6AlipPDwTftcuDHa3K2Wx2Pn/T/h0bT96FyK3eWG3lfLfIJ1kSJpFUfs97iQDmoh4OJDDOkqdy0kr48J27steFWmYfRbs89/fclhBxBRSZwd7/bPwwVW+nTpDEougXJDVN+EUseQ6EaE5HA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765036; c=relaxed/simple;
	bh=SXzSKD8jJ2iXEdYuKRsGqR7JGqJhWk9AWaqO3Qj04L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeGnSBTcCAeCDHhOm+E3zGx8QBdFGsf2CA5ab0IHeMtjN3HYqDXgWkd8QTtTYIP+LnlUX08y1ak7ND21dOE3cKiwGlo8/7G5HbPtw2VFfJco2WZBq/RRanlwf2S5Fw9fO9nAbwkT9XcO1wTx/iNHMOQ4bDCNimTT7AIFau8jFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iqfkntfk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso4444492a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727765034; x=1728369834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+9r8/ELl7iDlCWa/yccfFSqcqOg6/F/KEEgCukawR0=;
        b=Iqfkntfk8jCHPUFL7ICF4g1ivBQW9NzIanlJIEsde8ZD9nmnPtoQyyq4CNhHOnIRqL
         TS+IsOWdLci1dLkSo+w9sSI5tnaUlvjgRXwuOKeiFFiLO2GC2+KEZn3qfD+B4nuGAQ1u
         U428j4nJbLcgCkYv9q7+0nF6k2fA8iievTuHmtZWt4JJ0H3TT4fnUtA5zxpdJzmw6z3m
         AGy79r9bTxF4rBmq4aqxqpyIGJBZUhxsCb7XX2yIIWYbyuXqLJulH2al3S0ZB6F4oBNM
         HllkCtdCoTyRY1xad1APmSedoyJC7rS1TKg45qmv3hGiMAi+AlzfkHHWakIac1Q3QFGL
         Igzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727765034; x=1728369834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+9r8/ELl7iDlCWa/yccfFSqcqOg6/F/KEEgCukawR0=;
        b=sqGLKUHJGoU4cdZdEY0mwRlyECpdcGnstaWeBCLn8bbNjl2VTJ7ml9WU8ecb2dquvX
         TZkKUOzzE+qfBdvx2CqrA6EModhdnywf4OpW6O+U4MEQyLngPviUSUqBhY/y12ZWTH94
         EO1+Bfm2jFW5Pw49qNPshz0k35mYQLWln3/7ZP+7heZj9y+FsswwNOP2+fhjwRfJLgRh
         Vu3j0Z0/VhODHz7/k7qHN84n/576yboNTQdUNhb+4AEgWnxa7mNTcYdlqjwR10G8eoj7
         V882Hj386QyvkyspyVVQ0MKGjOyplq6DjJmHUqR+WI2onfwXXRJ4UD7MucWTRmq5OiI+
         QI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqoW2KB2r3B4ihaG5G6oV2s71kzmkqVopWR3JnEQ/ILCBbhwPqCS4zXPBiCnkv9cSI7TU/m7WGOiPJ+/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUIRPdLP+MBiWDwlp1s/QqBND3Jvy2fld6/RyrID2MoMF3/jd
	Sepnwgp2AJYXcA7yiZrVrcIXgb+vnZqoFkWqbw6HDNLu4Mt6BQYUhczfjm3R0Lk=
X-Google-Smtp-Source: AGHT+IGo9nDsPPgqeOWUQkdQH/9wmb+SBZj3pDfJ3l1Mq6Sz6MV6DgwxCFnauB+HR6NC6KCwCRh9/w==
X-Received: by 2002:a05:6a20:2584:b0:1ce:d403:612d with SMTP id adf61e73a8af0-1d52d10a3f4mr3324373637.13.1727765034276;
        Mon, 30 Sep 2024 23:43:54 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2963dasm7613444a12.2.2024.09.30.23.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:43:53 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:13:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mark Tseng <chun-jen.tseng@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 2/2] cpufreq: mediatek: Fixed cpufreq has 2 policy
 will cause concurrency
Message-ID: <20241001064351.vpahvdwzmvjblnd7@vireshk-i7>
References: <20240913103933.30895-1-chun-jen.tseng@mediatek.com>
 <20240913103933.30895-3-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913103933.30895-3-chun-jen.tseng@mediatek.com>

On 13-09-24, 18:39, Mark Tseng wrote:
> mtk_cpufreq_set_target() is re-enter function but the mutex lock decalre
> in mtk_cpu_dvfs_info structure for each policy. It should change to
> global variable for critical session avoid policy get wrong OPP.

I am not sure I understood the problem well. Can you explain clearly
why the current locking doesn't work with details call chain ?

It is normally okay to have per-policy locks otherwise. Are there any
common resources being used between policies that need locking ?

> SoC with CCI architecture should set transition_delay to 10 ms
> because cpufreq need to call devfreq notifier in async mode. if delay
> less than 10ms may get wrong OPP-level in CCI driver.
> 
> Add CPUFREQ_ASYNC_NOTIFICATION flages for cpufreq policy because some of
> process will get CPU frequency by cpufreq sysfs node. It may get wrong
> frequency then call cpufreq_out_of_sync() to fixed frequency.

Don't do so much in a single commit. Separate commits for each logical
change so they can be reviewed well. Also don't send cpufreq along
with devfreq changes, unless they are dependent on each other.

-- 
viresh

