Return-Path: <linux-kernel+bounces-570717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002AA6B3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D0C3AF226
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369F1E834B;
	Fri, 21 Mar 2025 04:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A25q+mdR"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F541DFD95
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532989; cv=none; b=pHwOuY5C2pc8nBe95Zb+rHFaKYDEMbm0hTwFb/lhD6yW7k8H1N6r7EcffMtKfACcYmJ9Nv1oeyeSKhL+ejJ7phBmxI33oZZ6kJHa3Vmeeg4JN/RJomeG6iwphVHZiwJPmuFx+bilGnpBZEO7IDblUU6YIh8xhuBkcFZ0ePyc8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532989; c=relaxed/simple;
	bh=TKGmqm1ndvYNsgqNnkeO2QbbChwHZc+jTCz/4Yrq09s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiEN+xwkMQ2dPXoMsSk5SIegeATZadb+yGp+JDaiQxPaDimyI0ZAwyqBXPEhTlWnLPsUkCWeYseyPE2Des5eL/8Ou9JTzptntnolRYFx298VPL/wunvZwZLzaI4rBj1pxtHt75CJ2QncCjQOrYtJYBursopKLxuNV7wiQStq1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A25q+mdR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223f4c06e9fso26149185ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742532987; x=1743137787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ozUpcCEWntr3v7+jvGD7rSS3mGlFfqxCVTsgZ2wgtA=;
        b=A25q+mdRJLZmB7gHOg4Vigct//EqaCFdRgk2VTPq5yLgr/8D5QJwZ8ejGNOwoL6QaB
         9KagnS3c5/cNTFZXO4qipiBdWcRWaMmv8rc2/IqlDQv8LyI1Ald6RO7e3tEFt+fUWlsA
         ngYT31QKo3yP2WJC0PAUaohk/QabIThBOynE4YZjFvTEbLb6FDyEfMPImnF2pp3/4m9k
         inZf5Y5HoAIVTgZ73Hs2FKyo3bKS5kxtgxooIFf7FxbXBy+6xyIRwFJTyCZIM2QNfNW2
         mrbhUXbAG1OsMpCB4xdwDqhnpL3PuOhAUDgna5QO7B8ZwmTtMQXz5vfOkoSgKykav+RQ
         lQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742532987; x=1743137787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ozUpcCEWntr3v7+jvGD7rSS3mGlFfqxCVTsgZ2wgtA=;
        b=qBN83JSgK+KYfW+fwYKcC0/HIRzMwc8n84uJSXE2aOirGmESV0l9wN+XyfNDjgu+pe
         AXGx9pTiw9wZMOCDKDGtkknrRNxSp1iOCX4EeoLT+D2XFhGUGBHZokvCj+apZWUIKVog
         BAxXVDzecb+Cumv/AP5FqUHd71TuSoEt9QHJDwUSEcPORG/hlRfBBAVlsUUp4NsOiD0k
         2RwvsET0hFM+zapk4xMWkc/UIl0KSoJcZemYT2yAit/Fr3u90eHACm335Kp9M45FkR+w
         Af8WnHCU3oqRGETm4Bkw/6vn53GttAEIKebnmeu0IVgIHQw43JqGr82Rm74AAr5ble5x
         rj8A==
X-Forwarded-Encrypted: i=1; AJvYcCULzOJjRGiN9M2jS4NpUZ1WO0tFyEiZEYloYftOTlVHCwQ3oQGguUxdFsxgt8lTIhwtQYLbhL3iDf/N6uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVeUHtiGlxe7Jh2Y3h2ZJrIBBafOGSSuUmAech1+82MnBj0LUg
	O3jQygzZwTYxB9ahE2A4C0tonrme1F4APYZZZNsvsjR31plApEA/cI+Bl6J5xj4=
X-Gm-Gg: ASbGncs0t87+hnXMTEHRb2hINYaMUi/GGmhIbTh54d5lfQXIRCmJ1M+K4Hx0LHme+Df
	f80wgCWZ9aOx0sCrriio1LOutT5K0Q2TYDl6qBzjywwt3mXxlYN8uoJ0LP7/AbyNC4LVO5WaZHc
	gDx5SS+CEoDoKaeEKNfmhBsvonEIWdbmFyP32gPz2NU9lSZv0tanW+V4Ecib5o+LDOVtQFguidV
	7Gwu6ADnQjzVXwdLqoAKiRymIp66i9T2v0/ieuv29+hyFaRlM+Wakr1qrlEhBHjuiGAnqWZ3YVp
	QzryZ10TprCpFUlEY0b75u7ljlhB3m9HNbwb71H2ZIms7g==
X-Google-Smtp-Source: AGHT+IEfZE88rs+io7iiRT/X8wJSM3aPVySwMLCiKFphdme5Nr2cI1Z/rOArrzthb1zZgjhHnKW+8w==
X-Received: by 2002:a17:902:f646:b0:223:807f:7f92 with SMTP id d9443c01a7336-2265e743880mr104023345ad.20.1742532987264;
        Thu, 20 Mar 2025 21:56:27 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4d5f5sm7225665ad.79.2025.03.20.21.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 21:56:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:26:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>
Cc: "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Message-ID: <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>

On 20-03-25, 08:22, Chun-Jen Tseng (曾俊仁) wrote:
> The struct mtk_cpu_dvfs_info instance is per-policy and the reg_lock is
> also in this structure. when I have two "policy-0" and "policy-6" use
> the same mtk_cpufreq_set_target() function but the info->reg_lock 
> is from 2 instance(policy-0 and policy-6). when the policy-0 and
> policy-6 call set_target target, the mutex_lock is locked by per-
> policy. So, I change to global lock avoid per-policy lock.

Yes, that's what you are doing. I am asking why a global lock is required here ?
I think the per-policy lock is all you need.

-- 
viresh

