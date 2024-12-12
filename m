Return-Path: <linux-kernel+bounces-442633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8389EDF9F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA002839E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1183204C29;
	Thu, 12 Dec 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLqe9MYQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158D3201
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986594; cv=none; b=iQteAfFnPJuFOVy3rB/CVuXJfSFP3ZHef8tN7bhobZhPaJ/YUJTw5P6yhr+NdjQcQV81PS9eAppGBY5sbK5fqibxekGf5UfqfDIcQCsmQHrpzem9r5bcCgjIl79bFonZky8lzt8dnzaQkHPE2GQ2o7/sDzFpSTQdXxQPkRAkqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986594; c=relaxed/simple;
	bh=B/Yhz2XiNDoxQD3tFO1V0tfLvQF27qroWQqn6kmZ3ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqbtnPK0rG+qXFuO1UMpl4WMUlkKSFL51BOml3QZzSRkFdvqeFWT9dj1EHxQkY2u4ABaXCDmyzH8fHEC9iqigllBfzwjqXQSpohSSGCEaSavzp2f11DrKoCvWUUM+kiT4teXDmgYKlgAQUIn9GxreE5SdLmNweytppLKNFlW1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PLqe9MYQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21644aca3a0so2675325ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733986592; x=1734591392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V7LbkwMCmLAaQYUZoVnQnJtPhNczH7UjhysTzF0HSs0=;
        b=PLqe9MYQlvWNtm1N9D1/ntq4LBE7qz0Q1wVt/K+DCDlq8HgAXiaLDQPmA7DEjL1Dcs
         5paBNKOc+QM5Qin6KRXcQUriCzDqts24B7dZPYk9wJDXamzUNCogEKewJB77R3GV2cAG
         wbTC4U9oBIYgXHjjyMYTbZYJnodzRE0h/WmaY55a0t0o2cesrlTeoHZm5mqXDh/E1qzP
         aJ+XuxpxOAAgvFsDXG8p7gRoIfTtUi7ObTMU7M8ZN/vW3gi/mDdsNYSU9Pg85x43V50w
         0dTc66UFv39l0r3rX4dQWZekJ+vVZWIfelDIPooIiJ036V37BhN2ipzlhScILF4y3pMq
         6ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733986592; x=1734591392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7LbkwMCmLAaQYUZoVnQnJtPhNczH7UjhysTzF0HSs0=;
        b=KBwob+PmLMXi6/6ruGo92SunrLPKAyT+ae5xRrMzW/rLfwjAuBNsFUPDY0IUYj/dJL
         xNRg3h0lNj64SWJGM+Jdtydtl94rkiLHItKI7+XmhpE3TyLJlL1w+mH5+329NxvLNygF
         WQe3706EMtqlOclzpCR7Um/zRqky374yD/SwbnIN7ug14LZokAI6Jh+7QXZ8czLg5IeE
         ALD4K30lf9HVJt3mR3LVcFB+WTnHbHXqqObXgARtHvU3hn8UJ2HChorGbEq+o9hpwDd4
         vwatWNjpyiHBraq5rZB6Y02Pk/TVqC4WBanILaZ34HkkLOr25QlHHEBjW2l/aCmyl4yT
         JbRA==
X-Forwarded-Encrypted: i=1; AJvYcCVM4sdQWp3Ib2QyLf+MyUz8OEeCIkk2vGGvkHv4U7A+Dms3h8l6kwW8g3LLEdcqa7nlYOWEtY+zbyFPGfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZYBsUYFxNnknt5KT2h1JzyxQh97gFnlEDsOSsAFnJEc2UB6H
	GBi6rI6ap2ePSo5mMlx7eaRRv+x0HVnqdyVxj6jeDz93aBmwrhg764wrINKxjLbTiYawiQRQfHC
	N
X-Gm-Gg: ASbGncuoHFNVyJcvTNWd4JiCRm5sC4Bztp5gOAVFD3cRy8gi8TNR6bXCOVtLVjWvOE0
	1yzZStsvt8vh2xFv+CROYqgs6b6RhuWwL0j1OVZOm1/ro94c9Z2WzCQ+YHJClkujar3MKirzu5+
	APT+x4b1rxZTcAsMYDLPrvRuWgXjyimJPOJQ6Uvu1vDLA7jgodoihSfLPgO6U7Y57SP+NsIBmnK
	XRSzbY4u+xmJ3orVUroy3mokdpZBLGZKl+E4Rk9RyIsYMcSvW7XBasBEgc=
X-Google-Smtp-Source: AGHT+IE5hSbu8aZNspz/v/cwW2sIJqEiSGnw7L2g9/MWfA7y3YObl11jJNPpN53pEg/ur61k7KkTqA==
X-Received: by 2002:a17:903:2451:b0:20c:6399:d637 with SMTP id d9443c01a7336-2177869886emr109699365ad.40.1733986592142;
        Wed, 11 Dec 2024 22:56:32 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2165590a8ebsm58557555ad.271.2024.12.11.22.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:56:31 -0800 (PST)
Date: Thu, 12 Dec 2024 12:26:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	guohua.yan@unisoc.com, ke.wang@unisoc.com
Subject: Re: [RFC PATCH] cpufreq: userspace: Add fast-switch support for
 userspace
Message-ID: <20241212065629.7pi3txrij5aqraik@vireshk-i7>
References: <20241209081429.1871-1-xuewen.yan@unisoc.com>
 <09acd46b-ec63-46ec-a239-e792c3061e52@arm.com>
 <CAB8ipk92xYEkZ_+m+xKnn2Z0DNOkum+6cgHUhSd_gbdzjAbOXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk92xYEkZ_+m+xKnn2Z0DNOkum+6cgHUhSd_gbdzjAbOXA@mail.gmail.com>

On 10-12-24, 11:27, Xuewen Yan wrote:
> On Mon, Dec 9, 2024 at 6:36 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 12/9/24 08:14, Xuewen Yan wrote:
> > > Now, the userspace governor does not support userspace,
> > > if the driver only use the fast-switch and not add target_index(),
> >
> > Which driver does that? Is that actually valid?
> > No mainline driver from what I can see.
> >
> 
> Yes, indeed no mainline driver, It's on our own driver.

fast_switch is optional but not target/target_index. Its incorrect to only
implement fast_switch without target/target_index.

-- 
viresh

