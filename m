Return-Path: <linux-kernel+bounces-520912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3620A3B104
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51395189468D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11BA934;
	Wed, 19 Feb 2025 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gD0Q+owD"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C88BF8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943947; cv=none; b=M7Axs9hOsa5mZZgKy4kOqx51LVpIMqmCNbZc/2oHf5SyZH4nQAs1rv5l/YcKrEjdKN6vGt1IB8JXyfzt1YD60f0GT4RdbDDOZKAv8uvJVs3oHcRoPTCyHBkC6pOTKzlT00gp1F4CjSWxGllECViQdlj9ySEtTPBrehPtjdaS968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943947; c=relaxed/simple;
	bh=kECMkiczJBY+HWUWDw6LnKgZH8be4eQ73OMVJR01HCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcn/vc+JrJz8uESQClwtP61LjOpmlSMJUX6L+wZjK6jQUyPsARO6/ORB7LQiuaAkwDYoQFk4FBDJE1uDc3FMEZZrVFgan5OnmldxDznYsJr9xS/KKICW0WiZtyAIRpZlrSj8ibX7kMY5bNQogdhKhsr1u5JdKhQzwWAC8e+FB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gD0Q+owD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa48404207so12655239a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739943945; x=1740548745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRInsltroDfnSviS90CirrNU28rUPlNtIher41yQK9w=;
        b=gD0Q+owDfBmdECcw2HUswj2FbM11eo6b7lfxFYSU8imc/NHZng0gbdSOxXk2gmjlyq
         vkEdhniIIWbkaH18vzKcZNlsxSGrA8NDIYPxbSxYzu/AXWDqyLbIOyFIR3oVj/93Ybm1
         UFD6M7wASwvfeNQXh7Sx2peXXMBrHVtIq0PjinerXMeIx+e4EMIvibv0X1QaoUJYCx12
         3NhzcA/2XvQSBQaH8JVuG7H/CxsmlcL+xH4jir/konTl4M2IvpxcrIF02p40nMmoUBxM
         wNbyUjyh2Q88zFzPLvfFLUpnMgfsQsvvlIlqRGmBMzOnRA88NPotVpp9iDnElKfr5umg
         3EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739943945; x=1740548745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRInsltroDfnSviS90CirrNU28rUPlNtIher41yQK9w=;
        b=XUYjXd9XFpWktyZqOSvccAl1TG1Wo+envHOYACsOi9OgvNsoQ9nE6HeVute6NTD1Ww
         HHWSnDni1FKP0Lh1iGZQp+3gGjBJxB61qiWcPHLi4/LUDKE1Pr5mOJa37F7jB/dwfQSX
         RtC4pRfMn68/Enn+Mavfp74AR/nQqVvrC3DahWsQ8Q2UkLqNVKKju83lJdiHnKyQ05Fc
         e7P2m5w6ElUUndbYFb70IzDXGb2qQbL1QzeWWg9JPILUK+JpvlLRuUQMo7b0K0lSMyaR
         bZthY+vsZGS2CEWk8S+qrlZ0WTV14B7ImC5rrBOsnhHR3i8dOGsvFYRPtMAIWtoBAv0m
         nwEw==
X-Forwarded-Encrypted: i=1; AJvYcCWZBUWXTCvwncdcs21ftAJ8Omh6FMf/5xdGcAvda7MF0C2pL76BNFxqgzV+N/i2XN5l0tH3dYW3d3Kq7BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2VGSfpcrXvj2oYZbhFjtbhDz2GRt6W8cPr3qyzw7U2Pl1Qv+S
	8MQfFR4i1s7Yi6bY+W2KrttFbSqRRy93pc1ZHB/gUxyPO3e1iagVnLC7QPhDLww=
X-Gm-Gg: ASbGncvzyHx4xnIADfJ27PnG5z/kg4wwrpm6QGnNbFlricjtyfTg2NLF/rbYCVLZu0C
	p8FPTs32mWCPYcvscoQyeb6SWOM/iUXmI5mJfBCXKpeO7YvIs/Ntxv7umFW452JPIoEJ64zInVi
	TKDnnaYNbMooJ/IEieslni0/Vvl4FvxwVA0Y2aMu50ANRvvVI0GTFS5Ck/iQIzHUjwEasaN5FOV
	Q9ccHXoH4hsXyZ5OJA78zcQKC/WLQ0hLFn+kBzcpdEjLo62yn/Z8AQ3HjXagGspObrZDt0kbOzX
	jQ5s4MUnjYRvGWgv9A==
X-Google-Smtp-Source: AGHT+IFDzea3Pp7rZ2dMCaYzxs9nrys/cZznA9NmmSQBwBK5duGLQELrvaTllazoUHAnVNqWR3kPyQ==
X-Received: by 2002:a17:90b:2fc3:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2fc40f21c49mr24036277a91.19.1739943945616;
        Tue, 18 Feb 2025 21:45:45 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9757365sm13106540a91.0.2025.02.18.21.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:45:45 -0800 (PST)
Date: Wed, 19 Feb 2025 11:15:43 +0530
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
Subject: Re: [PATCH v3 2/3] cpufreq: mediatek: Add CPUFREQ_ASYNC_NOTIFICATION
 flag
Message-ID: <20250219054543.4xt4tixsauwoqpst@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-3-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214074353.1169864-3-chun-jen.tseng@mediatek.com>

On 14-02-25, 15:43, Mark Tseng wrote:
> Add CPUFREQ_ASYNC_NOTIFICATION flages for cpufreq policy because some of
> process will get CPU frequency by cpufreq sysfs node. It may get wrong
> frequency then call cpufreq_out_of_sync() to fixed frequency.

That's not why CPUFREQ_ASYNC_NOTIFICATION is used. It is used only for the cases
where the target()/target_index() callback defers the work to some other entity
(like a workqueue) and it is not guaranteed that the frequency will be changed
before these helpers return.

I don't think your patch is required.

-- 
viresh

