Return-Path: <linux-kernel+bounces-204051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CC08FE361
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC7A1F242EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F3179652;
	Thu,  6 Jun 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6Rvb5C6"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F7178CC9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667344; cv=none; b=GOpD70hZeanhaTqgwp/6w5w/ecUfj4nZQ73hvYknLZIplATgaCBY3leVV1Vqllf/UuBO79hv6NtZt6QceGWizSgtuYszvmg2axpkkeD5jz0Zp9mQENtDBNtwPW3VxGOdJWmeTxNLFJ/ZLv7JR5CdkmiW6DukGV8C7CBOlNKdWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667344; c=relaxed/simple;
	bh=hG91Pv3Z/w4pLwtwAtO+Nu1aK4L4QzPc3dsecebuqQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHvGUjPoi/uS36iJj3EjQiuyFNBE65IlihYZJovQSmSQ76X183FeGQ3B7N7j/RtPl4tSxjZ5KEmBNcRVSisVVu1BjwdwI1upUFq8stNuzRcJGsOfXU6rFcPky8FwPTrdnvONyoAIqqeXWIVw1bpBJkxLU4jxn+k5Yvh25w21/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I6Rvb5C6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f60a502bb2so6053765ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717667343; x=1718272143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/H24HsQcmDcCsB8nZgHGFoHym/yrfcVk5pjKG2BY8ns=;
        b=I6Rvb5C6kugW+bn6fOVXVGc4Y82J2EF8uPVna2aix8MDZAB8zZTRjKf8QA4pQYpEJx
         ERJBzkJ1ytDWmV71kqVC+y/nyMq6ZOyngYz0HZ/SkuHRiJxe5yq+jmiTbm45jGCG47HO
         S7i8jlrBCVhpSFZ7FYXRyT9ou7f23BS3G9ge2fvr5yrjDnzoHNQbOtmgI9GE+1tuvLi2
         UmakZZ0y09wr+J9xV2eBrn2TFtkMrzjacTXehNAHGJ6YBEYE9v9C5agZ3q8XJfqQ7P5v
         5QQCFWC8JFhoIphDW7WBFJDS1E7mpodh/OSEv9xYy9GDo985k4o4uJKFWx/9L55HnK+n
         v63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667343; x=1718272143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H24HsQcmDcCsB8nZgHGFoHym/yrfcVk5pjKG2BY8ns=;
        b=wcsnUm65RUYPx95Foy8CvAYDejc6fomVUEobRPZXkYlmuAMy1mo1OILFS8KlUd0Xfm
         gXCjqtJghplDpc6bWIkczMzcbr88yMEJGS+4re0kMgFWpiynEgzkWKjaBZpeBaKI1d6a
         vSCDZuccLT4QLURCMpRvmmFeurDMWQwTsgbEv5mmpjCOAcX7ilKa8WDA8Nk79E30hM/L
         XOpYTz18oLZJ+/6w9HjYqe180jlrWb2EiVt0P9IDKSjekL4NyfEYlVlAAi2Gf/MXXvM0
         nrhdazgrjG6FUshgNcI8xzV89HLfEBt8PC6kYLKM93BPvtwzt2k4AFjW8kkRLNHtcmCu
         C9fg==
X-Forwarded-Encrypted: i=1; AJvYcCVPfijgtbX/VzRuK4pNdQZJiwL47Jahexg/10BfcRshGX959QrSE2OGwZtz0cjTkkl8aADekcul9nF/mYAvazhCjp6uRNHDnjizHYCU
X-Gm-Message-State: AOJu0Yy78wpiSViuBdtZqIohg4hvTkaVRYZbS0HHFnLMhjr0jf3XXmHE
	J8E8wHcPwnwuciW86OqHGlNMVY5Y5DILlgufyo0BLzKyewUk7pS+EZLxWQDriIw=
X-Google-Smtp-Source: AGHT+IF0Sa6ZEQ2nUPSBI2H1YRIj8dpw9WvJ1YU6WGSbKXCp7HYqPdGcHOYUQCyxAm/HBPmvk3nMDA==
X-Received: by 2002:a17:902:e54e:b0:1f6:6426:8da4 with SMTP id d9443c01a7336-1f6a5a9b0admr55965465ad.66.1717667342458;
        Thu, 06 Jun 2024 02:49:02 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f136sm10535675ad.8.2024.06.06.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:49:02 -0700 (PDT)
Date: Thu, 6 Jun 2024 15:18:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH] OPP: ti: Fix ti_opp_supply_probe wrong return values
Message-ID: <20240606094859.6yclnarvlrzl74bj@vireshk-i7>
References: <20240606070127.3506240-1-primoz.fiser@norik.com>
 <20240606085956.wsp3ecyfqck5tltt@vireshk-i7>
 <ed06bac9-6396-426a-b0ea-4932bc5fa7ed@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed06bac9-6396-426a-b0ea-4932bc5fa7ed@norik.com>

On 06-06-24, 11:43, Primoz Fiser wrote:
> ti_opp_supply_probe
>  -> dev_pm_opp_set_config_regulators
>   -> dev_pm_opp_set_config (returns negative if error, otherwise >= 1)

Ah, I forgot about the token that is returned here. I think the driver
should be fixed properly once and for all here.

The token must be used to clean the module removal part. Else if you
try to insert this module, remove it, insert again, you will get some
errors as the resources aren't cleaned well.

So either provide a remove() callback to the driver, or use
devm_pm_opp_set_config() here.

-- 
viresh

