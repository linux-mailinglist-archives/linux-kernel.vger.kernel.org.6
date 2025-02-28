Return-Path: <linux-kernel+bounces-538461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D2A49900
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E95A3BE487
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC226B087;
	Fri, 28 Feb 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuuHrE+m"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3926B090
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744925; cv=none; b=U+4WHBPNLZ3JqNh77gOKoUra4yCpYtPw9CvQkgpCsasmwl80v1YXsy1SlHXEMTAGx6GnH2Bf4GN68OL8V8CU2YDw5dNyqayvUyL6TewIsJyrTC+hGV4GwezoF9qR6RHHXHtpoH3NI85C6BmtE9dnMnKVqXGbvacrRYBctTC+HRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744925; c=relaxed/simple;
	bh=jUNIrARAbtbTs0tlrP0Tn9FLBSgxnIB4tXATcm2ewZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEknVjzaHZkbyEpvRorP8OH3hphOZ1vwEEAHLGEGshTdvmCKAEKqQbq41J5uT7myCHLw5rHPcpv8gT/t1/N0kPIMsGNKrn5zrhzDHZZm7ikqfn5M3iU0VW09p4VkNT+HMkzDzcml9bxemwOZUaSy3ztP4xawjW1KO1aa4mes7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuuHrE+m; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fd2fca1cebso12870757b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740744923; x=1741349723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jUNIrARAbtbTs0tlrP0Tn9FLBSgxnIB4tXATcm2ewZk=;
        b=QuuHrE+mpQ/NoTWgX7ZAEzezNs+vN6gNvLOcqVVEKYYrdNQeOUjuZuSQCzUDbUIqjp
         UzSlYXbZDIOLJpD/E1Kx4svNG2JWP5HpevbzWm1fSjVUAgrA4e2U9qJDjwYxpfB8hV1V
         tcJagQAH30HXsaIKpyw+4jFu2PNDuQ7rfnGHABCx2B+7EYFTA45H/mA3Q9fDnAtDX0E7
         232ru8SSxbyvw3/Jccu8oMpTT8Q+iQe2dM9jSXthoDyUFqJc+vqlGrN+av38Tnbn8Kfx
         iBFyZ1zSnVHP5T4LXbci5VDQzRDmlx8bxqebZAWbLyfwAn9+sSqrkJ3q6raUiES6w7Y+
         Ukzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740744923; x=1741349723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUNIrARAbtbTs0tlrP0Tn9FLBSgxnIB4tXATcm2ewZk=;
        b=KukxTTcjW2TadzcnxmwnDlMo4ERAXOuW8NAmMJ3yBQ1Xgu3uyewbROznwScvjwSnt4
         wTAqogaCTsIa6z32Ppzc5zZ4PZcWF5/2Q8Ycy86OtO2o9GoHiGCF3T4xHhxGjQkVswB2
         NBmQdFmKT5sXyfdxbCeSOlU+gbVqSxjlYr+STN7TNX6SgE6eCafwwYnL3IQyvZ4lmNgQ
         PRPnmY1aofVQLuZ/dbEHwrUV5QwH4/czRwwqAcJsM//rcpy4OvxiER0Eo6xhqAjBiP2H
         gUtIavFGkcfch4xb61KMaRaGDahhzehHBsvCSTQeA7FXKnpMFIBqYmni3t9oBYDfl+UV
         wYsA==
X-Forwarded-Encrypted: i=1; AJvYcCVgqv2YdRdDdLqKNnHnVGQhcW652e4feLNReiWH6ocZBTAy14zt+iuxIAkCfSjZl1G+COQU/LbNltgea8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKl2kicYrf4gAdzwEx9XGxYf3JRohU6pMRwo3j7e3LWVDYvuyg
	l6REtggEl1DRyYxdS/pRgylsgyzl0d7zpeqGIztzSEYyQ08ayqexAh3qS1h5Uhc2CF46aQqgs6i
	BBqUPhG86YIvJ+A2z8QVYRlCan5NRqzPIRF84rqcqvSF2xBFZ
X-Gm-Gg: ASbGncu3Vh8t8XKgzb6ahPMjR2uOxiWmdGhb3+Ohjhh1TOuuMiQmMjWQjYXdd82PIXs
	58XbafCG1hmOikr4y+KHTNmj/+36p/5YfDdsjUUT40TRtz0npnpV40rj8aNnghEBwqZsXDIkNaP
	RjwII3aSY0
X-Google-Smtp-Source: AGHT+IHT7obeRQVC5jfTWOVMXwZbo8MvDy1vz1fLAzz3uGYU/jwe30ZeBEtELX2ss/DGYLXh7XY0o+RqytL8ARTZDYA=
X-Received: by 2002:a05:690c:4a0e:b0:6fb:1c5a:80fc with SMTP id
 00721157ae682-6fd4a0c405amr41901307b3.26.1740744923010; Fri, 28 Feb 2025
 04:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
In-Reply-To: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 28 Feb 2025 13:14:47 +0100
X-Gm-Features: AQ5f1JrDK1Y4U3HrAxZBGp7DwLtxTGI5xNt7avBzml29SRZW6KdhhTSUIQ_s8IE
Message-ID: <CAPDyKFpQaX8nUt_OQ-hwB+zYqWVCLKci2BmhrBOYUTcrkOMv9g@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Fix RK3588 power domain problems
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Peter Geis <pgwipeout@gmail.com>, 
	Tomeu Vizoso <tomeu@tomeuvizoso.net>, Vignesh Raman <vignesh.raman@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 19:58, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> I got a report, that the Linux kernel crashes on Rock 5B when the panthor
> driver is loaded late after booting. The crash starts with the following
> shortened error print:
>
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'gpu', val=0
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to get ack on domain 'gpu', val=0xa9fff
> SError Interrupt on CPU4, code 0x00000000be000411 -- SError
>
> This series first does some cleanups in the Rockchip power domain
> driver and changes the driver, so that it no longer tries to continue
> when it fails to enable a domain. This gets rid of the SError interrupt
> and long backtraces. But the kernel still hangs when it fails to enable
> a power domain. I have not done further analysis to check if that can
> be avoided.
>
> Last but not least this provides a fix for the GPU power domain failing
> to get enabled - after some testing from my side it seems to require the
> GPU voltage supply to be enabled.
>
> This introduces devm_of_regulator_get without the _optional suffix, since
> that is more sensible for the Rockchip usecase. Longer explanation can be
> seen in patch 6, which adds the handling to the Rockchip driver. My merge
> suggestion would be that Mark provides an immutable branch to Ulf.
>
> The last patch, which updates the RK3588 board files should cover all RK3588
> boards that are currently in Heiko's for-next branch. Any board missing the
> update will behave as before, so it is perfectly fine not to update all DT
> files at once (in case I missed any).
>
> This is based on Heiko's for-next branch. Also it's probably worth mentioning,
> that mesa CI is carrying this patchset for quite some time now.

[...]

I have pulled patch 1 from Mark's tree and applied patch 2 -> patch 7 for next.

Note that, patch6 (the DT patch) is also available on the immutable dt branch.

Thanks and kind regards
Uffe

