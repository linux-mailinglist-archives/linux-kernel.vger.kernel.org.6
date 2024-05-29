Return-Path: <linux-kernel+bounces-193565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8858D2DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FF71C23A60
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3348B17E8F0;
	Wed, 29 May 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABCHHcqy"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E515B99A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966768; cv=none; b=kciw/q79z4SgOvgJUGvrFupWmY7lNBjtL+kUy4CXCeKsV2DKQjEMVTL00y3I+EuYgVIziNKXhxIPADcBX6DYfC32hLpqy/vOTUBB4vto6g9jemO7gaJXn+al/153C7qk+MXSBode1Vn1w5ee2oRmxHyrubYy/lw1CPGwyda5wUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966768; c=relaxed/simple;
	bh=cAQbvBmUpMCA3gTxY1IDXFVX17vOV0Rw+rnvXDMYKiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O52AFulTewnZxfxUiePKhoUHBhmzyiIcy0yx4u2SPl2jgLnjAWkiuZJtuGU+2CLzjUQR9+Agm3Sjxe25nlaYoLP9erapBJK/3oUz3IB+GtxgLsNv4/7mMZSxIl5xPTehBfeJFIzZNxZw4dvEDIiCxTEnRS9L4gnrpyShMMGlrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABCHHcqy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f48bd643a0so13082445ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716966766; x=1717571566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q6bYzyZnFYI4qrsZB34ycSG1lMjbB+dLnkiJDJkyrtc=;
        b=ABCHHcqyf7tcOOdhjgl6YVaIW0brYMjmgedFmpqM0BzLF28Hp+Y8crXOpp+gymYupr
         fzObq6gNQ7Gnm556LEjXZh0AgaLdXYcGv8+ur9htYjxg/X9q+URJWe3d//Qv1ubsrP+J
         w/dA+ObFFTblwFO/kq38sAK9NYOhE/2EIISLEKZz1UuQ3m6IlzpUmfaOr6gR28zbVhzs
         SIMwIGF66Y4CzzyIWbJTpBT76WWRrVo3c8tz/XuQZch3/yG84Iudp5jGVKa9lm1fHIhM
         i/3PwXLIBtDJRyzhO4niEagOR+ESWBiXWzH48k7JLeRbkQvyUP44SXH065VZjnRq+HcI
         K3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966766; x=1717571566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6bYzyZnFYI4qrsZB34ycSG1lMjbB+dLnkiJDJkyrtc=;
        b=G2Lzy0THj3eihDl5WkyDcTmNNfsNRXVQqwzISmasXoz2tIF43M4Kx60/Rxqa2PU6Xz
         Cf1yKGihcVDwyExhhGr1VuwKkZA70WH0kKXJTGvizHg4nla8Y9l9vaZmUmawfox9+r7H
         EMkpPjULe0SwH501zTmlWDWbtADX8udp31gARQSAcY+uCEwoO7VwRb73cUbGcDTOgM2I
         KMgwfo5jnMtTqYyR9N78BRe+S3sfcliw/kdX9+lVIfw514IgBtmW21oFefyjKrT5jTp/
         RXWGvFO1h7wVdCtNOilXst3l9JhsqPzLFofyTi9J/BCp7l80N8XE1EZUSpO/Bk1gkukD
         3yPg==
X-Forwarded-Encrypted: i=1; AJvYcCWRXOcnfNs7Rn7auRNS7zjM7vmtJrWjhE/5W+PheJ5BGGJytDGjwyQgV9cixu4ZfP+oitpYpziVXoMuVtZ0lPaFiWc32XengFvlEHy7
X-Gm-Message-State: AOJu0Yzpo+Xg/C7FgogkHcbMeiD7YDjYNbNu0r6v6Mb+Di6L3fmlDJIk
	+efS0KRcUntDiQJOsDHeCCbYSOeN/wSJE5opa5H5RdwZ10iyrQrV0e2/1Mw4Fbs=
X-Google-Smtp-Source: AGHT+IGOx08QOgH9vGWV/sdBcKu2pC7HV9WSYJng84PKel9YyN7krOr89/wBNKSivHft3W7MyULAJg==
X-Received: by 2002:a17:902:e750:b0:1f4:7d47:b889 with SMTP id d9443c01a7336-1f47d47bd5emr119995205ad.30.1716966766454;
        Wed, 29 May 2024 00:12:46 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f477d337cdsm67413355ad.71.2024.05.29.00.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:12:45 -0700 (PDT)
Date: Wed, 29 May 2024 12:42:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] cpufreq/cppc: Take policy->cur into judge when set
 target
Message-ID: <20240529071244.vwognqagaa4347dm@vireshk-i7>
References: <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529053652.pzcjoyor7i23qc4i@vireshk-i7>
 <TYCP286MB248669BCAD7A7E54C5071EF9B1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCP286MB248669BCAD7A7E54C5071EF9B1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>

On 29-05-24, 14:53, Riwen Lu wrote:
> Yes, you are right， I didn't think it through. In this circumstance, the
> policy->cur is the highest frequency, desired_perf converted from
> target_freq is the same with cpu_data->perf_ctrls.desired_perf which
> shouldn't.

Please investigate more and see where the real problem is.

-- 
viresh

