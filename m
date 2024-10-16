Return-Path: <linux-kernel+bounces-367589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32E9A042B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B69A1C274EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F2B1862AE;
	Wed, 16 Oct 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQYIO/Z6"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25718A95E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067146; cv=none; b=cDzV/EAlNepuYb25Vut1ouAXSGKCiXLj/19B/ZQHfXqhRiprEXCp4QxYrnCqN+r1GGGZa87MLwoMmVK5vnFQNEcJDOy1N2KFwq97rudeOBYEEcnp/K6qDILShnDPNJui3GpUDeOss8l5QpGF0pitN6rjlDWa3cE6jk+YL9EkhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067146; c=relaxed/simple;
	bh=cHNU5Nlmdv0S2aOXaW1YmI5Vi55Yd0a+mORnEs+1XLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JU/XtxWX5+RVPZVLEWfZ7E6gY2ErUDpi5u352C4bJkSx2a02Lfm/aE5f6b6cU0DVC124IoinicUkGTALISrq+8ToVISL6QYPbgi3DuQUavCo49hXDLTQUoLtm7xqBtvGA1mhuV6w+nroDuY+jroQjz4DicXcu/y7hwq6aYfZ99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQYIO/Z6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d41894a32so425821f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729067143; x=1729671943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTtC+Ws3fVNan1tFRA0VRBhmS9l1bU8+DPHPhAm/2m8=;
        b=fQYIO/Z6xB0J1wosZdLoyeYH6XGGTRxVGuMJKDjjDD4XJFYXrelXKdwIa4GqbZfZBa
         awVBzuKRAA0f93lp9vSory4VvxkDxG0FVCz/c/JoeDDfdwKSAI+YUx4j829nS02noMaX
         vfqYH7owLXd6IQTcHNasUcf6dX16AIAufwhw3x7cnj6hcpucNLAX1A3i73Depxvz7BIy
         mTRjXTbScosj2pQhXSPYrBX/gQ4Ojq/aygdoj6jcVFoyUc5XaId6ZWIv+brf8ihzd4Eb
         UlAQMyDRoFjBTDrKc11AWVJw1F+McoKgbfuf9tUBAZMa6mX5WRO1wLMGPF22yRyuJSKl
         VNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067143; x=1729671943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTtC+Ws3fVNan1tFRA0VRBhmS9l1bU8+DPHPhAm/2m8=;
        b=d2iUDIr/OEDes6WQgiMhXmbBVGH8QgJI6qFBS8D9h5vmjnbOJmT6YT3rpaG4+VnA0I
         phrv4EaN+3EqrZRdZH+WPojdSvXfdwKCCfOeJ5m39uox+VE9+mRNHF2uHzvSTRWIaWtM
         0hI72b2fSyGv+eM0CfC866P7Io4baI4sqeUSW0f1inNtzIZCy5pJHa00w3lQ2YfyHv+w
         jf9P7TFrBI+nTmxzwU3AkmUIUzpE4w3BgxFGEm1a3B2wFWRzAJRPr3UCtaQoe8Aac+sB
         /nRqu5+Z2FtiX915qnwYgl2/2RogD70CHEESatgTcVbyKBjnPdyvJ3d+rUEM+ek3EOy3
         +8UA==
X-Forwarded-Encrypted: i=1; AJvYcCXn3BlojuuX2haw/fPqOvRnqiJfIEFGi5XYN+qxdUvBr2J/iWLjthTQGqDMc1YU9UKIly1wDTQkDjGlqio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgMOXEDunuygYHVVnsckboR6xS8QZPyJ6BbDoRAkLioqdNbJl
	sHRgyLl4/qZgJ9PhfYTtqjkWm3iqg/Ysgakw/7Me1NT1nh/kmqrkhbUF0biphwY=
X-Google-Smtp-Source: AGHT+IEMMChsNHzste9atUwBuPlSVeJ6Nh/ZCpuS0zBDCoPbZFXSkfvsEaGtm/P2e319k3WMElMnNg==
X-Received: by 2002:a5d:6882:0:b0:371:8685:84c with SMTP id ffacd0b85a97d-37d551fbe1emr13520902f8f.15.1729067142813;
        Wed, 16 Oct 2024 01:25:42 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc113f9sm3673888f8f.90.2024.10.16.01.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:25:42 -0700 (PDT)
Message-ID: <c28ce930-9a70-4f23-9f6b-541c16c212e3@linaro.org>
Date: Wed, 16 Oct 2024 09:25:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Speed up some tests using perf list
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Leo Yan <leo.yan@arm.com>, German Gomez <german.gomez@arm.com>,
 Carsten Haitzler <carsten.haitzler@arm.com>
References: <20241016065654.269994-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241016065654.269994-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/10/2024 7:56 am, Namhyung Kim wrote:
> On my system, perf list is very slow to print the whole events.  I think
> there's a performance issue in SDT and uprobes event listing.  I noticed
> this issue while running perf test on x86 but it takes long to check
> some CoreSight event which should be skipped quickly.
> 
> Anyway, some test uses perf list to check whether the required event is
> available before running the test.  The perf list command can take an
> argument to specify event class or (glob) pattern.  But glob pattern is
> only to suppress output for unmatched ones after checking all events.
> 
> In this case, specifying event class is better to reduce the number of
> events it checks and to avoid buggy subsystems entirely.
> 
> No functional changes intended.
> 
> Cc: German Gomez <german.gomez@arm.com>
> Cc: Carsten Haitzler <carsten.haitzler@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

Reviewed-by: James Clark <james.clark@linaro.org>


