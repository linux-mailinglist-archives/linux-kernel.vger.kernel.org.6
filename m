Return-Path: <linux-kernel+bounces-345316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934F98B49A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B02281F87
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2E1BC078;
	Tue,  1 Oct 2024 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZLEUNrq"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EC1BBBC4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764909; cv=none; b=mmiXDAxyvV6PpVMN83vulvvLpPCjeQN88CcmnJY6H4e5WsAGyrtkgf9MIrR4y6s9qHMcoExEtOm76e/pP1NsX00tANuSp4sc4EVGsQVOc0t74ZVGhK80yAQvWEXGgTGLnL/DLyGMIw/MVC/iZA89fSaeFGsINz7FT4/hoBoK+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764909; c=relaxed/simple;
	bh=YtVW8h8bqOHldp7HwSG/PfiEqEPsdApO6u51GkoDJ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH/9XwdZjs0icjtn1CA4K2Rw1ZSkf1K/u0wJX4Uetfikl78QZykzwlyzp99srCcqun8MW3W0qnZ25Of8fg1mVOF2fTDCUV6MOgtKbllUtInGgHMg/vsowsJungv065oOYIkuO8k2eK0MJj93VsS5QyCMKFOQ+Wt67ld1WEXU7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EZLEUNrq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b9b35c7c3so14440565ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727764907; x=1728369707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrlCI6gDMqjjvh07SpujHzw4G0hvOwNj3Og9A77/EN4=;
        b=EZLEUNrqGipYiaptsr6ndy/8aAtR41d9ZDSMX8RF1iJB4mqInjey8WOgh6IhHbpUXm
         gImks6yAyICA2Ko/KWXQ0xISLgd+nSaeWaYqJIVviaEabrEQfrreY1GDUUsign+Tsyek
         LBnc/bm5JfV+QhvpssESYQ1APqeluhijTKKvrgSAH1KyUvpBYE2SidvjcI5YCzj/+HIQ
         t59iII3uwZfcjQB7mZLR+yfWqsr/h/24h0lVwIDUq9mz2kIRsYqmM1yI+EtbYJiqqrRn
         Jz46vdLq5K1DV/+svHHkH5211hg+blaO5bOH+s49uIXWih1HPaDRGvhu6OD/Fosv7pCe
         Mq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727764907; x=1728369707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrlCI6gDMqjjvh07SpujHzw4G0hvOwNj3Og9A77/EN4=;
        b=feGdUMejD9XlHkU5HCqkthedVWdcbi9WNf9YPSK5v8kIZQzTrmxp45z41NOPm6puQs
         frhFR7lNKHM1EAhXJDHlEyHK+ad3TaEWx16q/cb+1kmPsdvIjIV8yeRVqyWu8X/uXXL/
         Uw88plxQ42/zetswHoIDTc3ujGG8OKwzzyGp+EfnLvHzAXc1VjrSb9UUbcq1gCJjLlPZ
         YeORTF6/hUqmMZtNOXO/RH1q8x8oYKOdyfiie9HpJ2ULHA9VBcMh/vuh1Qqn13l+TZoL
         oE2HyLuxgfG+MGwTC+TaQOEh4I8fn7Hd7XJoGAe+N9YyCde0RlxW045JDs+9pnc/PfxU
         rU6w==
X-Forwarded-Encrypted: i=1; AJvYcCU2wBuDOeVrAJR1ZdCa6Hn1yTMXQ9VfQ65XEuK53QBHO20lOQzoQp58SisZFiPJW01CHLijJmtDiyxKUDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZB7X3GsunvEEcQ5hPgbRPRkvF4toOzkmqqapXfl/kpL62sp7
	Zg5EToTK3IM5+NKDeN/hFPd6liBGIo8ZyRbrAF6NqtRskAy16OEXYeItgim5Jy0=
X-Google-Smtp-Source: AGHT+IFP3u0mkHLILfVEb/4G2eiUN2Rl9g69lxh2r/A1UnM0/qF+U9h+WXBSTr/0YXwcXLpcsRJ+KA==
X-Received: by 2002:a17:902:e80a:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-20b58f2e394mr152709015ad.18.1727764907712;
        Mon, 30 Sep 2024 23:41:47 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37daf85dsm63772875ad.113.2024.09.30.23.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:41:47 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:11:45 +0530
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
Subject: Re: [PATCH v1 1/2] PM / devfreq: mediatek: protect oop in critical
 session
Message-ID: <20241001064145.fnnzcsrewz6pttoe@vireshk-i7>
References: <20240913103933.30895-1-chun-jen.tseng@mediatek.com>
 <20240913103933.30895-2-chun-jen.tseng@mediatek.com>
 <20241001063919.ekqfd4epcefh5eci@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001063919.ekqfd4epcefh5eci@vireshk-i7>

On 01-10-24, 12:09, Viresh Kumar wrote:
> On 13-09-24, 18:39, Mark Tseng wrote:
> > mtk_ccifreq_target() & mtk_ccifreq_opp_notifier() is re-enter funtion
> > when cpufreq governor is more than one. It should add global mutex to
> > protect OPP , avoid get wrong frequency & voltage.
> 
> I am not sure I understood the problem well. Can you explain clearly
> why the current locking doesn't work with details call chain ?

Ended up replying to the wrong email. This comment is for patch 2/2.

-- 
viresh

