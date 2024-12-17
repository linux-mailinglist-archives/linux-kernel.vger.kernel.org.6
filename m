Return-Path: <linux-kernel+bounces-449853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB69F56F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526CB16C0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9041F76BC;
	Tue, 17 Dec 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpZHx+V3"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954515E5D4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464262; cv=none; b=lTkQ7/4/trrrEwS5HfX6js3ottdgVkKxn/zJxviGjwLCEbQBvWVcm2b9lXcsFXUNM/5rA4hYDES5vqXlWUMQQglzXPsG43+o/bu6KN26U9j666YH2nsw+TpdyHO7dWroaT6vZBBKNbl4d3Ia9mRGPxAPSkAKGU1YRp8pmUogIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464262; c=relaxed/simple;
	bh=MTVNlMY7b0CAMdNRX/uC5j50fAU9s27MkmHSyeTpy0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4ovCX+RNB4p2urrmbeWE3Q9KHTnHS+lqLqCpEk6z0hNjXM1JPdnzHSxz0SPgIVT0gSv4RcMClqqET5j1u6mk0hyAvhoi5ivTxQytT6M10/qfXUXF9t66UpqIYQNJJySHHGtXzOkJhO+MsuRxPj0MAr5OvuyYHNRAP5UqWDfFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpZHx+V3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728e729562fso4941224b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734464260; x=1735069060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4iQzS388Vkl1dIKlXcv5oxRgFYPMQyIAJx0jAV1ZO8=;
        b=NpZHx+V3o61VBKDkecldCRtjq5t4s7DSW0j3xRLL+NXxjxSHXjtNTVFiVZ6YFGSxXj
         pUZrZ5IZPPy2wSiFFlzqyPIbPcN12mmwtKuyRLDs79prONjZAKUlZf7JCT8BPTSRcLFk
         /drhxc7/iwx/awF6EkYw6mpyHqftEX+T6TZOrTV6bS5AAGsvaPO359zxp/6+ElBr/pn9
         VZH1obIEwswd8Q3b3+cxbUxBIPBkpzXYxBQUP8jFxi3+o2MUYp6zzlp23q/CDNvwfks+
         3ZrTqbYeiyYyPY/8tD4pLH2YCQiw+P4ja6QffH3ae1rSCf9IukjTFQ6I1Pf2Gh/NK1cO
         0taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464260; x=1735069060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4iQzS388Vkl1dIKlXcv5oxRgFYPMQyIAJx0jAV1ZO8=;
        b=KJNNKn7fFCtkwtn+iNS3PRFydUzaEO4xLwD9HtWFmep56ZTziC3vEj1IlhvYi+8HvO
         saSIgo/tlL5M8YfmGREDF29nAdy3o7xKiXjIyf0qOuNTKwhUCRqwgzuB291zQqUvhLm/
         ZeZFNOK6Vopr+ZapDcq7W36j+WwafjY06EbkiMwpx5edFLCS5C6ZA4+ijpMU7JoVRd9+
         kIdhLEgxw5AlnCpcEktMf54eSO4x3JR0O9Jhuftf5GDUU2P8MpRvQ0FgCDM9XhjxE/Cz
         751yxqJSK3LpP481iQBfKQixTWYiYfo+pLxSetgNTm5b2suo9sbrZjoTdT5f/Vt5GGKh
         UT9g==
X-Forwarded-Encrypted: i=1; AJvYcCUxGjYacQ5yody4tyVgw7cSv1WIrhxt9CZPeEdKpjk9HR8Oa2vd5PL4KcUUKMpun1gUBwagck6ZIopc1j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVq4L5Q8eCi1c3m529Ebe+oO9GUsqvocVRXQpeJGO/wT6Qo6o
	8a2Z8KV2OCHIFkBZnjCSyrG5KMh6bqT+ICT6X+HuumvUkeY8sJt3Frk4VYk3Ww==
X-Gm-Gg: ASbGncsX+yvR/4DHiuVc78aS0foGUIcszgZFA4xHVnWDafbi15Z9HcPLyVcQB31pL5g
	OchUXl4Qo/TuSbJmh92a4aEI7xwULn3EJbaKcQfckzumiKIfMq9J7M2Th7oBMH/pU1knxtHS0n7
	BeQ/kzjLu05z2sEQv2DHK9bUkexRyIP8oJvswoCBzOdx+vPwFy6pGfZtlOuZAyZ4O3FL9sDszuD
	PIl2vRDDIyTBZVWrGPI3/zNHxONRcB9ADBzec1kyoBqbHyChx1hzLr/r6WT6F8BFfFFwj1wfTs9
	QnshPTq1YSkCqjynrF1V8p3/
X-Google-Smtp-Source: AGHT+IFSh0wcQB8WeGymgHrpQl9Zg51F0JJud967hTyCNd9GHB2YYAEXbnbHcgR+dP0LBD2AX4WQjA==
X-Received: by 2002:a05:6a00:114c:b0:725:f1ca:fd76 with SMTP id d2e1a72fcca58-72a8ce37eacmr389503b3a.0.1734464260229;
        Tue, 17 Dec 2024 11:37:40 -0800 (PST)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5ac872bsm6209895a12.32.2024.12.17.11.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 11:37:39 -0800 (PST)
Date: Tue, 17 Dec 2024 11:37:36 -0800
From: William McVicker <willmcvicker@google.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] mfd: syscon: Allow syscon nodes without a
 "syscon" compatible
Message-ID: <Z2HTAJmBeIUlWysh@google.com>
References: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
 <20241217-syscon-fixes-v2-3-4f56d750541d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-syscon-fixes-v2-3-4f56d750541d@kernel.org>

On 12/17/2024, Rob Herring (Arm) wrote:
> of_syscon_register_regmap() was added for nodes which need a custom
> regmap setup. It's not really correct for those nodes to claim they are
> compatible with "syscon" as the default handling likely doesn't work in
> those cases. If device_node_get_regmap() happens to be called first,
> then of_syscon_register() will be called and an incorrect regmap will be
> created (barring some other error). That may lead to unknown results in
> the worst case. In the best case, of_syscon_register_regmap() will fail
> with -EEXIST. This problem remains unless these cases drop "syscon" (an
> ABI issue) or we exclude them using their specific compatible. ATM,
> there is only one user: "google,gs101-pmu"
> 
> There are also cases of adding "syscon" compatible to existing nodes
> after the fact in order to register the syscon. That presents a
> potential DT ABI problem. Instead, if there's a kernel change needing a
> syscon for a node, then it should be possible to allow the kernel to
> register a syscon without a DT change. That's only possible by using
> of_syscon_register_regmap() currently, but in the future we may want to
> support a match list for cases which don't need a custom regmap.
> 
> With this change, the lookup functions will succeed for any node
> registered by of_syscon_register_regmap() regardless of whether the node
> compatible contains "syscon".
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

I verified this works on my Pixel 6. Thanks!

Tested-by: Will McVicker <willmcvicker@google.com>

Thanks,
Will

