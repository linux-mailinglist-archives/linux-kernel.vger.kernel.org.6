Return-Path: <linux-kernel+bounces-305106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A7F962997
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF2C1F2517B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE613188CAE;
	Wed, 28 Aug 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="baJSbmDs"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285013BAC3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853708; cv=none; b=n/G87h0rzUTPvd+uGZM2wNqBoMo/gT6gnZcMZZHvDOajKKlEl52h8eVdcBMvoizJw8ipkhV6UptpY00lWkzRQdLYFHUSACgF1Wtm7fcB6v+0Cmm2pMK1zWFnHz+KZ0viCFRAdfm9+fCCjED1dAH6KvL9ocBU8i6cH3E//vVo0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853708; c=relaxed/simple;
	bh=V/Wy18YR5ke/o9Xi8LgbZDbzUDBROCTr9RH1OmbZup4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1NB9CvX+VB3Gy1a63L40pRy1D3LWXRU3Y1X734u0rBqMSWkviC8/HQC5O+ShRs+EfWdIsAydG7/ibUC/bNYr4XOVY7vvQENSBGTtsbM/y6vD9QhKxLpBmiWMT3T9rGlOXr/N533ExNdZR5IjNZoXko0Mqo3ZCeMcE3KRMXHcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=baJSbmDs; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso2707535e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724853704; x=1725458504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yz/ibjJeKSSnXM/JUAR1kWRXaxDhHhqY4dbSHAOlf9M=;
        b=baJSbmDs1Zanm6PC8MudL7XTvoqv8x7jKPGyRlClW59ZV//r7B/HqQxACyA8mJ0E/Q
         mERXL8M+nlRowzxRHuIDmNNtO/FBmbtvlI7vr5i32zCG3Cv4rfxGyM9IcBomjxp6P2Cr
         PsQrY3grHRKGFjzecVfnv2JMwHH5ZUKgRc6ThGqvsxRQ5ef/d/AdYjI/EktARSo4ch2o
         1f8IWSWJwZpZk3Tu8woB6FSjyj+F6K85VPd7+7LyeK1SxvGO4ejTN+K2XpAtD3mJPbkL
         UC+yLwph3Zi2ME/TkCteCyVIw7i/ZDhKv5MimvasUj5d9bbbI+ONv/tvcoyiTK19Wttg
         fuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853704; x=1725458504;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz/ibjJeKSSnXM/JUAR1kWRXaxDhHhqY4dbSHAOlf9M=;
        b=pYEsB3n8h1Wl/4GJ6pPNX7ziPPBVwtb3E8pcE5lE1ztpJtxGrzViHImwyTuGK0HDo4
         TadxRzACUzxBMaaWinERYUcw9UTO1mi1p99CtAnlIA/h2yFRyx5iPNLz4mDeALu56uAn
         ld1iIVNjY9bFIpDlZt9sNJesegYKVtah6zuC+Njj94zjwiRFUlNlYcbYDte5n5N/kXl5
         kH7qqU48QDRosOHa6WAgTLPoexahG3SBfhuos6Sn+IzAvHmvMxq7/WevAjxRRe2qf9+y
         Y9a1IUDeX0gXd8HNcPlGgfZ+CW1y0YD9YEIClANX1p0EoDOk9/T5mBr5obrmm5Q3kfkJ
         8vGw==
X-Forwarded-Encrypted: i=1; AJvYcCUNOh+mq7UubLkIrv4bQcLZQ6lhyKYTFikbndltfW8DvjYQhaYrpazsj2ZDBCIow5tbBSixr+5neFQBkkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxow/9wW2bKQbzGwh1fvysksg5EADZNadp6xHpu/UKelWlyutjy
	EsED90nZ8Py8BpG8xhJFZTLm1gs/xnOpiVg0ZFCn4xzWgeIxpo/6gqc27n7TLNk=
X-Google-Smtp-Source: AGHT+IHcKCNBrrb4V9Cp57xz1/wEeaxh4KI4YfsCOBvju9zEuyDvwAodbuqKUKWsyZSFfDFIfw8cxw==
X-Received: by 2002:a05:6512:1595:b0:52c:88d7:ae31 with SMTP id 2adb3069b0e04-5346c763611mr1757423e87.48.1724853702167;
        Wed, 28 Aug 2024 07:01:42 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-46.ip.btc-net.bg. [212.5.158.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a88a48d4a39sm34478966b.12.2024.08.28.07.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:01:41 -0700 (PDT)
Message-ID: <135b7be6-b31a-4104-abd2-986114323745@suse.com>
Date: Wed, 28 Aug 2024 17:01:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] x86/cacheinfo: Clean out init_cache_level()
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Chen Yu <yu.c.chen@intel.com>,
 Len Brown <len.brown@intel.com>, Radu Rendec <rrendec@redhat.com>,
 Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Huang Ying <ying.huang@intel.com>, Ricardo Neri <ricardo.neri@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-5-ricardo.neri-calderon@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240827051635.9114-5-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.08.24 г. 8:16 ч., Ricardo Neri wrote:
> init_cache_level() no longer has a purpose on x86. It no longer needs to
> set num_leaves, and it never had to set num_levels, which was unnecessary
> on x86.
> 
> Replace it with "return 0" simply to override the weak function, which
> would return an error.
> 
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

<snip>

