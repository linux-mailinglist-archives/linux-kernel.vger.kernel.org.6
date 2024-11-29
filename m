Return-Path: <linux-kernel+bounces-425328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAB29DC09F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C32162267
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA1A15A87C;
	Fri, 29 Nov 2024 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKIhLVOH"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B60161321
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869657; cv=none; b=Yi9cqb/lDyAbAvIRN280IdZvO5Qv2oqzjB0xxUzDhzkEM5w4IpAf/3aIjpkpnFY7DaaZcuDwBT8bA32IdDcIG4ieNs6wWyUplI1YCiKW2xKEbiislRiGbSSzn2mQPhpqhHKUE7VWB3z3EccIqg0lhp3xJkklcBEQGlkNalxsNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869657; c=relaxed/simple;
	bh=ltzMSsQLYC/4qUZo1d3pV9RN8/HZ7OnfIqYqFX8gARM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYrzBO9Qi0wR+iQ1AtUDHSIzxMZ131voamuDK6V3+1qvDoWdINjwaXhExTtTQrsGxDWL5QaG7SfVN0Wchg0w2oY/Mc0iwLi31gULO5XW+kkSTXXB2u5wsIhCahyFJpX7QCjloOQ2CtaDxekS4SUGfj/p9wVS4Blw7QJfhAdSnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKIhLVOH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7252fba4de1so1481764b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732869655; x=1733474455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbwQYpitovH5oQlteNzxBXcjWfkad4Wni/HhJDybuVI=;
        b=mKIhLVOHjjP8eIzyq+7Qkm40Mg3TYu7Qf1RIUWlt1Tn8dGqPIXATDWVT+b1jkUa+PR
         xpEtHabOZKCILFqPKw8D5QceYFe6PcEJDJ3l8gleTEwlSR8TC6OjuuwZHa39m8+MoF14
         LtgYrHOrM9e3lUP++wIvBqbDzYOKfdf1JRL4d0Ky47sAThbNTKr8hysTLmkwJTyIAyhz
         JtSdPA3v1g4KGs+oNhj/58rWk6nZf+Y21f5D4JMLjLvZyF4ZoQF1udxi0MrRCs+Zna8Z
         8xa8Dd5pxB01BzuD/mDU2x0uXaxx0/3f31ROFGj0vrROVJbRxzqRFN714bPpgUiQpkRO
         r+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732869655; x=1733474455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbwQYpitovH5oQlteNzxBXcjWfkad4Wni/HhJDybuVI=;
        b=oPUQeHu89FSWECc6rxhM+sOqCBXNFOyh+RX52f3vjBc6WaO6Z7YshkdiD13BeAYq8x
         fQsI40901S7LSWfgutcP8TrQtFq9dSYM+8tt2LC2cCK+Ix1sXj8iwIr0CUYJYfNnoDsS
         sQU03v6+x1NNos3d4+fhKs+QGd3Ssa76n9a9bSLkgqjApxFe8o0tuHT6PfW43p//eKV9
         k/Jp9F3P2U9Z0w2zLES/KOibUYdCWlPp/yOHLTACvz32S2Vmn4HBifF/DUP609GkdcPC
         GNyKYDC5Bm0sNy9QIPwwGrT8Y6EEiOQhai4G8DLGoJ4An3ZfwTFp78v6NsINWrsYJC4O
         ROsw==
X-Forwarded-Encrypted: i=1; AJvYcCUFgMoc1jqr3QzabBBnTZZBoNpTMrOMK5eZ94CS//M5Gyl8kF8HeN+56RHCP2oXWFkaL36jouZT+DA2tBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KNFlkqS+Qj5dNSvAJLx41CY4XDevB8QsxBKfxH9AeVgRXroo
	bC8xbZ7WdsPflL2ZKrq8WCMZx5o5qRIwYJUdqLQsbo4sN9ltmPjjfK4EaJ8rMX8=
X-Gm-Gg: ASbGnct+C71tM58cCZG8UKQGwDaGJ8ztxASDOG3xm500uygfewk3wK27HuaNJ+RSdwG
	P5v9ws+++8hhlSgZKbHCCaTRglRV7huYmTsJV56Hhq6U7x/C7XvT6J2+nHTM/8m5GVQa6Rx+Lhg
	lJQS3lkSGOvc00ebUsY2Cp6+Y/ZSN55ogZLhmNnMXEXhNcxjK1731coxfBRCem3D5dHJ8KKeKah
	liUBPXI8RXEfARIgOxEi51g0MDXhUraCh80FxiK0g7wm66Nz1J1
X-Google-Smtp-Source: AGHT+IES7KHozRR3CC4f/KofJkNoePMuMocdqyoM2Vahg/s90rTfb4PjPf5nBfVGqPl3tpw4jaSNHg==
X-Received: by 2002:a05:6a00:22ce:b0:71e:5b92:b036 with SMTP id d2e1a72fcca58-7253013e930mr14090384b3a.22.1732869655100;
        Fri, 29 Nov 2024 00:40:55 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541828c61sm2936394b3a.163.2024.11.29.00.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 00:40:54 -0800 (PST)
Date: Fri, 29 Nov 2024 14:10:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
Message-ID: <20241129084052.wfi7nakgcnt3zkur@vireshk-i7>
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-1-cb8bd4c0370e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-topic-opp-fix-assert-index-check-v1-1-cb8bd4c0370e@linaro.org>

On 28-11-24, 11:07, Neil Armstrong wrote:
> Pass the freq index to the assert function to make sure
> we do not read a freq out of the opp->rates[] table.
> 
> Without that the index value is never checked when called from
> dev_pm_opp_find_freq_exact_indexed() or
> dev_pm_opp_find_freq_ceil/floor_indexed().

These APIs aren't supported for cases where we have more than one clks
available and hence assert for single clk.

-- 
viresh

