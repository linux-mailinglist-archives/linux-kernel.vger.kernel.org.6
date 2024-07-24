Return-Path: <linux-kernel+bounces-261532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4AF93B863
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59982819B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78F013B582;
	Wed, 24 Jul 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="uci4zWRU"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC54713AD1C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855379; cv=none; b=kg43O5RVs0Bl6VzlABZO7szYeowyhZH+RJgvsAMYnkWxWOoH18WjYWQMMrI16JNnxEJSuSa2UhN5SIiFbfTR99HjXJ8GlbITfS9YWAOmkgqGwZR515HmFXli610yJZbcEnFr2+kPmEsLeoqhIMI1CdZoSoQhzExx87RVcupbpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855379; c=relaxed/simple;
	bh=uxLT9f9IqbyPnZuQ+zIPpBsbmcvHuBGoUjbzjkQd7MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfPXEzDjJxlJ+MTmIDI0aGkzQ6k+xqWH2Du4gE9WO220+DF3AyfZun4uyscoF+rcJC0v92u4l2sQt+iYiSavNdwUGQVSM3pB4P+1X+0f6lx3WNtY14zoLkPlE45j7zFLjIYLaoL2QpnOPeGYXejNf8DXcvKfnZDyD+F1oeLZ+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=uci4zWRU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so184028a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1721855377; x=1722460177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JW5RrNNJxqjwuGLo9kHT95SO/33HKB3UwhgKtE5uUyM=;
        b=uci4zWRUJHPci5CRF9ySjTerFEOcxDfVw9V/YWr9KvfI9wngJRe5S03o3FlFagZJg8
         tvjsDjhEeOVY2uQhBHi4cDJUJjQQFH8Zlkpj3jBn72E77Z4ZfgSmE/JYgXiTZIvkIPKp
         Wb0+bkm7zWjeba8hm5xE2KDFy04r8TXTSgjs2x9c6dy+T0PzUIs6KbO/iFAyTBGkZSCG
         l5q1mZi7ND4MQ/S1D9pLx9iLXMXKnCkoMkVyCQxdoywZP90F2xBUgGXFFsSrb4ApnF2f
         cEDJAt0RKfUTE8o3/sCZOPkqycUpsayALvBvb1c5g8aTt9LE4nJQAq2I4Dj1apGDd29s
         C7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721855377; x=1722460177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW5RrNNJxqjwuGLo9kHT95SO/33HKB3UwhgKtE5uUyM=;
        b=N9hluKvS2PDqRCoCbAr09TCtD0pol3J77ElPs0Y78XlgrpHE+5b3fu/h9gYFUNUCEq
         K08jv2vk9NepDZrhP0AycraQsQDGOInbkJ1S9FvtC/S9VzzzsJyI39XhRVbLqDg6Sbf7
         wVpg/NQMw8u5UWkD3V/jbujvGF7DJNOR2TVdVn55UTl7QxGX5/CT3+R+ENkiqN4e1Dzk
         hDd2I+MWtik15E2B1C2swd/LZKyMP8zcstU5cxN/tZfhaaGATLecJX/LRnsinlobAD5N
         prDcZN2bnE1YfIOCnRq7c4ph/IB8zJCOIbEfZdSBMjVaLSbDMvVwqI3Qu1PnzsHbdgxS
         uBAA==
X-Forwarded-Encrypted: i=1; AJvYcCXEi7GOCJscyazuFaNk1J/kHb/lGAH6duwjNy2NHDpT+5CyHQs59VKbDaRimIphqBJm8NSJc7cr6mp+5Ibtx67YFMxKAcFb0agafhr/
X-Gm-Message-State: AOJu0Yzjwn/NNeR7oE8E3W+8pn8lkxxdiEHTaIfk523185RI6oFPMLKC
	/O6Oc/X7PKX2WLPruRUVlgAFHRx5h/4Aqc66UL75fbGvyWEGDIJ4ivzZWD/KA3c=
X-Google-Smtp-Source: AGHT+IGELhs314KqDpmVaOF4YhHiDvPSIICIdBh1kBNNnVk36MClFKGOKcaWxOApghMkCWpIwy05HA==
X-Received: by 2002:a05:6a21:3396:b0:1c3:b267:4261 with SMTP id adf61e73a8af0-1c472830996mr1583265637.12.1721855376943;
        Wed, 24 Jul 2024 14:09:36 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:8821:4dd1:578:cc09])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb738bb33sm2164778a91.4.2024.07.24.14.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:09:36 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:09:34 -0700
From: Drew Fustini <drew@pdp7.com>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v5 0/8] mmc: sdhci-of-dwcmshc: Add Sophgo SG2042 support
Message-ID: <ZqFtjpxXv7pRpZHV@x1>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721377374.git.unicorn_wang@outlook.com>

On Fri, Jul 19, 2024 at 04:44:38PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> This patchset is composed of two parts:
> - one is the improvement of the sdhci-of-dwcmshc framework,
> - the other is the support for sg2042 based on the improvement of the
>   framework.
> The reason for merging the two parts into one patchset is mainly to
> facilitate review, especially to facilitate viewing why we need to
> improve the framework and what benefits it will bring to us.
> 
> When I tried to add a new soc(SG2042) to sdhci-of-dwcmshc, I found
> that the existing driver code could be optimized to facilitate expansion
> for the new soc. Patch 1 ~ Patch 5 is for this.
> 
> Patch 6 ~ 7 are adding support for the mmc controller for Sophgo SG2042.
> Adding corresponding new compatible strings, and implement
> custom callbacks for SG2042 based on new framework.
> 
> Patch 8 is the change for DTS.
> 
> By the way, although I believe this patch only optimizes the framework
> of the code and does not change the specific logic, simple verification
> is certainly better. Since I don't have rk35xx/th1520 related hardware,
> it would be greatly appreciated if someone could help verify it.
> Note, the DTS change has dependency on clock changes for SG2042, which
> has not been merged in master/upstream, so if you want to test this
> new sdhci-of-dwcmshc driver for other hardware except SG2042, don't
> pick patch 8.

I have tested this on the LicheePi 4a and found no issues.

Tested-by: Drew Fustini <drew@pdp7.com> # TH1520

-Drew

