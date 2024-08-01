Return-Path: <linux-kernel+bounces-271642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11799945101
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431F91C2577C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE97C1B9B4B;
	Thu,  1 Aug 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MLnbitOs"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A01B3758
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530522; cv=none; b=mpLaaqkCNvxdvT3QAr/0zcl3acpgKgw+QBeAzNl6Snqv4/khv4XGs+ohPQl/c8NB8PY85B10ffA8wd2uLdUYW38PKTads65BnrwgBBluRUEV5pyjNT/4HdKUhMOAQeVJJ+O9BizMarqyc6++AZVQtNPe//KMuG4E3mCgB6vQNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530522; c=relaxed/simple;
	bh=48L8m1/nqyrVllZo1zjaeI5/Whv8Q8kyuwKNl/y5GOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DNyX/3/FHiarJvqFmjlXln+iAR6K98nE4Qq1ZhkyigY9JHrrVhErGc0aW9jL1hnwE1+/600ib1M2skVSxmiLnq0n74blyOiU+REQWGkh+Hj4THA7F+UH0SgGp6HjrPPXmLhzM2R45fXUSp03xrVc/gYRjfZ4c5LbQTzxGk5gJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MLnbitOs; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1283400B1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722530517;
	bh=oH2IxwwaeB32KbPmmlJ7oQ67OtriazyI1RrphFPcsu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
	b=MLnbitOsnDZ0GLCnZjmRHFq2kyvOYurg4hNtGpoN4Mo29hKPg7MD4k99DSL/sGErG
	 qOjtVq9J8yzRuLZRe78Unouq3xfuFOaCOBlNnLHNnRmZDg6yLn6M1xZzmzv7TvAIcr
	 oX4n1bk/Oc0AglKaqy+I4fP7Ds5z/ECQ5apeL/wW7aKCHqli+BWNksrrUieKZqQR9d
	 kYpNAjACdsEDknSMSsYtedtJXr8Up2lqNTyBoD3o8D2KJRjw6wqU0TWJ9hkrpY2iD3
	 VTt4V0FQ/vJ3XIMLT9XVSccFtbhbhYOk2kRw/kc8QuKgdiTkZSzt0f7rMRrPSsr8Ok
	 TEDb9Ga0HB6zQ==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6fd42bf4316so5060975a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722530516; x=1723135316;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oH2IxwwaeB32KbPmmlJ7oQ67OtriazyI1RrphFPcsu4=;
        b=c1o2pO1spj/gDsrTKOuyzLnwt11JhTNH1WJrjIIw9mo54jBjPdTzTFhvgSxZLzukyq
         I2PaySgLPf9Q6czHz8fyiZTnDQ62IvvzZyD0SvScQPXtgUtXqFmEqH+Ttti31ITv/9Vz
         yq+smQXuns3hXRtLIYIcKpXSVr7o+fGAiwH3LTtECvqMFxe5rczZNkzSQInfMYuKlh3c
         hGRtL4Xmcg1fUntCx5pfGqqdhOLIUWSkAntRdBS9Texj9wA3ucLOf20iqEpzDH2MgGim
         4xnZLw9AQ9l+g8RSraIj5bn8NwBWPuPxXMBBC4FjXFqee37iHL4IbECvHHB1WQNIASYR
         UIiw==
X-Forwarded-Encrypted: i=1; AJvYcCWFQJ+3Rz6DX0pWvMlliz7bJCau2xQfbc4oqyrCDaz3gLVBoI5eIbZk4Of+j2pNwpSCMlz1F26jrjtAVDaZZltj7PWDy5JVlTMxmequ
X-Gm-Message-State: AOJu0YyFcWhtUEMjFS27t95KyKvldoqAa76oFH+x7k1iQBh32RgQnx+3
	BToAqfxS9yh4xolKPzg3vxyhVGP93tv2N/l9fJDrGremYX03a5v/Ua1mdpjMUjMYEC8G/qNWOVs
	fOoKpUXa7wKlcR5OgLrOMUKs5M7pETdKUkAIphq3xm0yrNo5WaUH+3VQTUo65yNEZtm/QYahsGX
	BjTrU5CEw8/pA7
X-Received: by 2002:a17:90b:4b92:b0:2c9:6cf4:8453 with SMTP id 98e67ed59e1d1-2cff952d016mr973450a91.31.1722530515933;
        Thu, 01 Aug 2024 09:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+pG8FFdEdd9i0NyZFDUieVjshTw4yaNRddKN9NBT0wOc4Cc19sa0uEU6/WASWF9LAztSMcQ==
X-Received: by 2002:a17:90b:4b92:b0:2c9:6cf4:8453 with SMTP id 98e67ed59e1d1-2cff952d016mr973418a91.31.1722530515347;
        Thu, 01 Aug 2024 09:41:55 -0700 (PDT)
Received: from capivara ([186.250.11.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb0c681esm145461a91.25.2024.08.01.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:41:55 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:41:50 -0300
From: Pedro Henrique Kopper <pedro.kopper@canonical.com>
To: rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, pedro.kopper@canonical.com
Subject: [PATCH] cpufreq: intel_pstate: Update Balance performance EPP for
 Emerald Rapids
Message-ID: <Zqu6zjVMoiXwROBI@capivara>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Intel Emerald Rapids machines, we ship the Energy Performance Preference
(EPP) default for balance_performance as 128. However, during an internal
investigation together with Intel, we have determined that 32 is a more
suitable value. This leads to significant improvements in both performance
and energy:

POV-Ray: 32% faster | 12% less energy
OpenSSL: 12% faster | energy within 1%
Build Linux Kernel: 29% faster | 18% less energy

Therefore, we should move the default EPP for balance_performance to 32.
This is in line with what has already been done for Sapphire Rapids.

Signed-off-by: Pedro Henrique Kopper <pedro.kopper@canonical.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 392a8000b238..c0278d023cfc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3405,6 +3405,7 @@ static const struct x86_cpu_id intel_epp_default[] = {
 	 */
 	X86_MATCH_VFM(INTEL_ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102)),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
 		      179, 64, 16)),
 	X86_MATCH_VFM(INTEL_ARROWLAKE, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
-- 
2.43.0


