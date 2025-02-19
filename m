Return-Path: <linux-kernel+bounces-520911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401C4A3B0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6D51894170
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605531B6CF5;
	Wed, 19 Feb 2025 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gr5icUyw"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354025760
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943734; cv=none; b=E/MeMbVzGkikuFTUzjj/kq2t+/uus2KAfpRPe4u8eQG9YfdepaGajfmEDGc9MxIKWAV4CfoJ4/67flVxQ2rDfgBOApW0OVKao34m4ntjDLRdHaILxPXyy3FqNFn+x9j2PsEYyPo3UvHQc+c62rMGCVvCAa/vpcInbp9BOt+Xk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943734; c=relaxed/simple;
	bh=UlxN5nIxHgy+wAG7x32fxZL8LlqDfxRzsgF07t+gqsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvN+6AgUuthgU0wuguorojEFRCrnwCsbvhMGcxAzon1PsMvUoZq6/JxMho08881QVMGO2bU3z7tPLFkGCoYFiwcYSYYfeXNC/2qvtputLf/2ckTChJ0BkGrD1WluzJdGymXT6nZ3lyyq4G6CjS0oIouefTNU0aDVgAyWkv/TsAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gr5icUyw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220bfdfb3f4so127577245ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739943732; x=1740548532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw7t6rEqkTZXH92Wz/4+gNz4tFU3pvCeEiYAUtl7Rbc=;
        b=Gr5icUywPWVr7KKXKa4D6/TQPndfU1OryjWZ+9n//bbxkdufIMfN1R+Z2GfHvPlBhb
         0J0GoBEmYOIBpo2HdmSYe7j7S9jV53+fzeSteE178SSLJ8Ovq9E5RYwMsSTwuNB/LiYu
         oiKrKcTsXagiq7n0A3rjJ9OJ7kOv927mauaDcAxbSmDUZv1zAN+jdAqMAkdyhpzViH/X
         5kvA0zfpI2whjhwddbr9K51BISm90haF2etHzV9GwUJ4GgWbCxaFum5pHtr7v7mdXSEw
         uN6yUueVcdkuxwhRsQoJHLefMLpIGUyYGQsWeXlQkWVHw/xfKKyoCrhdDI2ubjfJSaAv
         AksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739943732; x=1740548532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw7t6rEqkTZXH92Wz/4+gNz4tFU3pvCeEiYAUtl7Rbc=;
        b=brkp60M70iU8VEYEWitUT5aYpymMrf1qmyKjrN/+RIJVt+JWUzh/qBuD7S3t4frsbA
         d7Dqe4UkwuSNXardiqRIxuID9/0W/5UPIiBcS7QYLIrpsivJCyBUPakFc4CiSRfYbpiJ
         tBXYEnltK12x6CbhsISmfWUuTFkiQIC+sZmFIX/eD2rTciGv9Osq69Pk5+dpHNFIRkwI
         kelbAMjIDsDzSXD0KEbAzrxlmvSgphCnN/o9k70THqg5KML51681yvXUgm51e01hppPx
         34k8p5B0JSoPn6Zqejg9mCWWZEB+zsjf8BE+zviD5Df+81QLtp3vw5k5Gn1/PCEW6+9c
         v7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa2ZNrtjKw59t5cH6p2YRK/4RktbR2elbNEsMi0W4EsIwJoRIsPeLPAeYjyV2RhESbZl2K6vgcy+uTMaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxepEDfLkklarncoaEvMBQlSFuLUoZ3P/e6YaEyxSa+aiLFug8b
	3L+LP+0MtLKhevSs8Y9FTQP9FEjZ3SuSzjFuBaxB/dRqyn9JXwiOBoQgX3fuby0=
X-Gm-Gg: ASbGnctPcMARF1vlQ5moJWQ7cy2+d3hQVYlNh2GT7QrM7BzjVQKKR5c1ctd23Y16J9X
	+Xj0HLozfGYiFaJTZ9AVI2q5Nh+oKV7II22AO/gX0muWpGYppoB1hwxsUkgfssdez7LrT8k9sJ4
	sSZIS5n1Xj26hLIz9JzHWPAu4wNby7fJBvpoItw2Q6H6gy9uZQToFQhWE4X00HlxEuC+uoNxjMv
	2zBToIyVVfaN3zb1QirubkfZG9RXmTOW9+XTmzJ5cMLiFG2BKwFY6d83ImmWFiakmpka5SiRbZC
	PiRZuVFDRp+qNIEg2Q==
X-Google-Smtp-Source: AGHT+IFmJl4t7FAw0hGuv5yC3n7fuRs/TbAcabQxCpBJfvULJjAbDJAYajm1qYLNhiNrv4hZgm/Tjg==
X-Received: by 2002:a05:6a20:7491:b0:1ee:d3ac:56f7 with SMTP id adf61e73a8af0-1eed4fb2369mr3887537637.33.1739943732560;
        Tue, 18 Feb 2025 21:42:12 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568adasm11461609b3a.52.2025.02.18.21.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:42:11 -0800 (PST)
Date: Wed, 19 Feb 2025 11:12:09 +0530
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
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Message-ID: <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>

On 14-02-25, 15:43, Mark Tseng wrote:
> In mtk_cpufreq_set_target() is re-enter function but the mutex lock
> decalre in mtk_cpu_dvfs_info structure for each policy. It should
> change to global variable for critical session avoid race condition
> with 2 or more policy.

And what exactly is the race condition here ? Can you please explain that ?
Since the struct mtk_cpu_dvfs_info instance is per-policy, I don't think there
is any race here.

The lock was introduced earlier to avoid a potential race with notifiers, but it
has nothing to do with calling target simultaneously.

commit c210063b40ac ("cpufreq: mediatek: Add opp notification support")

-- 
viresh

