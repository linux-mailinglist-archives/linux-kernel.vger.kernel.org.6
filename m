Return-Path: <linux-kernel+bounces-396787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703DA9BD204
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E2B286F8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235FEEAD2;
	Tue,  5 Nov 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/tITIXd"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CCEB640
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823315; cv=none; b=KJ5S/IZ9Zv8CimlOBAGiBlXPgMWv9M4VAoszs7DzUCOA7ijumCsopzY84EJxUkDLxavvgX+9TNI0hFOT1QcVVr9H/qjAIG+CCmR+4WAoREi82CJXyEc700IMLhzViaX8OBW1HqV0qZpZ07P4OSqb15dRxmdEIxl1h7sjQbE2XJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823315; c=relaxed/simple;
	bh=WUSAP7JfoT0KrQZ5hTAXo1+SUCAu6hsTJMVzWxbiRos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3CoI78i8Y7sRM+9AeK1ysbdrGgaTUwPGwfM2BjhUJV35zvrD2sAS2DixgNB+CxO1f9SREyvENCCCJ94zHBig/ezIOiWnDjJMsdN/yAsBCqS9JTw0DEGS/7/t0fSAVjxF++4bnCTQceT3yuanDprJNGGGGApYXbz2e2ik1kTdQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P/tITIXd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so3470355f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 08:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730823312; x=1731428112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CW1Cg/cnkPv9u+n4mqogPh24pUykRgt3ujnVhJASOW8=;
        b=P/tITIXdTv0fZl4tjdOEF+QtSFrVS+PQNaer+z/KqSAk7ANCuM4Vu+kmpefysZOxm7
         f7uQ+MVdf6JAaA2x84wvTLYuHxzHtKelrOXtj7L+eS77AT9QM5Cw54WWUGLJaGuSNObs
         ixw88bSmfyPta1Zm8fgYzI/9PgC6eA0wepE1F2gYElNSzfhDTbK4iK4i9avoTYJ6fuKr
         PB7KjiKRpA01PM6fjcBMAbcAZNk9DmB9kbB8chd/+4cQSJdEYC9ijGieGJJ2pvsMR2cb
         ZdZ6GMpv7Aw+JaVjTLKowvLsfaZjlD6EA/0om16iQH60laBnPk7XgoLdysHba9jhIkDV
         NrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730823312; x=1731428112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW1Cg/cnkPv9u+n4mqogPh24pUykRgt3ujnVhJASOW8=;
        b=XcP2a1X5iFZQ6b9c6P3s9woh65Uwbk0gkD8Hc01EQrI9vny31MwetG8wQCw6TXLj0+
         UYYUDcEfaFzVE2gY8Dt0/3arf9r+bQ3pSw0qRt06oyPTiv5oKqYYsQ8HA+PQIQiecDA5
         1qAupCoFpXs/pXbixU4DPVsySlWjn5ajhbCIMCae+SIOeNh+KUN//xIvpffFd4s5/Q4G
         K3v29wq2qClqAOrldBTs5r6FQHwIj0L/eV3s2YBUg0IMQEruHoxEGhrP8y3wWFlwo8Pj
         JXRC0eJ+Rlz4yDI+uNSQ6ZkTeUOW2L/J7uuRFxN1+gM2fypCkOfgN0rWMrXSg5qsW0a1
         kNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUm4eTT58oFSP6cL3k19rgr3xbiO4UyAV0MlSQ1fiPE2yP/uo+EzTa1EmBFiR4n7CckFRsHLeE3d89XYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlffOaf4m7vshlcBG1soKzfMWT22PejZHMtPChC164njSyUij3
	3o2QMCNCNW0/W6tScD1A5O3VbOVijv8SXCuHNZ1vHlB2yiCWtwadV3Ts5hM6Ggk=
X-Google-Smtp-Source: AGHT+IF6QXzlIan7zLZ+Ti4McbwWx86e1nJWzWZWC0DEaU8zyIoc2LEiFjd311LHzgQU2S/tBukzHQ==
X-Received: by 2002:a05:6000:ac1:b0:37d:3280:203a with SMTP id ffacd0b85a97d-381b7057644mr17370896f8f.10.1730823312316;
        Tue, 05 Nov 2024 08:15:12 -0800 (PST)
Received: from localhost ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e771sm16717277f8f.81.2024.11.05.08.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:15:11 -0800 (PST)
Date: Tue, 5 Nov 2024 19:15:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, cristina.opriceana@gmail.com,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH 2/2] staging: iio: ad9832: Correct phase range check
Message-ID: <fe767a87-f3a4-47a8-882a-2a33f7eca2e7@suswa.mountain>
References: <20241105140359.2465656-1-quzicheng@huawei.com>
 <20241105140359.2465656-3-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105140359.2465656-3-quzicheng@huawei.com>

On Tue, Nov 05, 2024 at 02:03:59PM +0000, Zicheng Qu wrote:
> The phase register for the AD9832 is 12 bits, which means the valid
> phase values range from 0 to 4095 (2^12 - 1). The current check uses a
> greater-than condition with BIT(12), which equals 4096. This allows an
> invalid phase value of 4096 to pass.
> 
> This patch corrects the check to use greater-than-or-equal-to, ensuring
> that only phase values within the valid range are accepted.
> 
> Fixes: f1d05b5f68cb ("Staging: iio: Prefer using the BIT macro")

Same comments.

regards,
dan carpenter


