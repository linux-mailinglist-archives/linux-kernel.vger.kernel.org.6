Return-Path: <linux-kernel+bounces-442620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16A9EDF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F32E162174
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AB71F9A9F;
	Thu, 12 Dec 2024 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnUjaVMn"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E331F9411
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733985069; cv=none; b=NRv9dXYJvKQz/0fkxkqgEIC69YpEjesh+hthTqJEFL3/1TR6JiESAZZoeQJi4kOHdWRpuUM2sSR4Y5TuOpJcN/ElCags1Bxn/uwmN+6aYcX8nnGFwN9Fc/KYsuXrBsggHComeBnWfCsT2KloV4jEni7APE8bHzjjeS81sFHik+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733985069; c=relaxed/simple;
	bh=7lg8BHq5Zkj2rCpJl3qYkjaaykVL6MQ+dIFz7ceykZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYO97xGqPwjY5yjT2VUQDMsUoNV2LstTr1FYXhKRtnM4AHcIlj3jnSFYFf0kep/dl9ONKK7jdqvzifsA51Qwgdoh/pRbWVD1GaFddCjCdR5Czrv3XWxQKIr2/bMCVc/c44XPxw5ycWgadO+Pq+QoC4evmP03L29NHhnVGWAZFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rnUjaVMn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e0e224cbso81918f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733985065; x=1734589865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdk5mwj9oPpJlVtb093wBGQVMuKiQeDOvo82XEuEwwE=;
        b=rnUjaVMnafUtN/mq8I+DlxvokCn1Q2c6bsudI8+9hzOjwW42f/djeyirMjbwmmmtDN
         3NXcWciZGm+tECGZ6gYt+miMClCoG4+iJ0babitsn/kvp16/QRm+qqqiLDo5lj6CD2iS
         684PgA6quhi7j6Gxao/MZtYxZKvRudiJkLR0zbHUDiLw2eSlRF2q9kDHwIDchRgVeMyN
         WeIqEXpvoqGtkq7bvlaEn0Znp7CKSbLV849ekirryI6n6dnPrGK0mQZ4iEHQfMOnK27s
         /+bM5/ctqSoffMQxVLivEexka6Ae5L5atY1+1EGoGsV+OfKZdS3wWgq3ooSQzZmU5w0S
         EhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733985065; x=1734589865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wdk5mwj9oPpJlVtb093wBGQVMuKiQeDOvo82XEuEwwE=;
        b=MwcWJUDDngdvZOW5i01z5ZpF7f1uC7IRYDwKk3CraU2QWYcwHOA7rfiSjSlj5YpelP
         nuH090/yus3kY4qLDHhTolDIGo7j+zZGOmArHLSgsEP7L9AAzt/lREpMGHNHTivjh37f
         2aZoWdWy+ugra2CKawDHXwwZbnos1Z8AalR1r8XWDP9CZT2c5SSPf8XfvcWCjS9QR+dT
         tFdU6uNYSnnCuB9qxSHqCGP3K6POB6uAVhyPYJWCTuIsKVjCQKWDJLhJNc0wthlBPXzB
         ddsRrjtVzyxOvLdIC89P9WTbN61kskG0Gav2nub+yHC1N1tQpGHMQ1dec1C9lVRevMgk
         hmXw==
X-Forwarded-Encrypted: i=1; AJvYcCUBSFYsN4cYrnm+erYsVVWckxqovIaThuU+7HnNlLQgnXICGGwGN0d3LvTC4uwC79vPK/+0JHzhG683uSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxitgTCLzqNNKIGrbfpsPnEY/NeYL4kM2Vg1yiIvmTZ7kwJhc9
	qKZR3ftJFlyPtmo4VeI0tRiGsrTgMwKlDETNYofC29mQ/WPOLJ4/2lmtMe5dSOc=
X-Gm-Gg: ASbGncveD9h9EoaiumIHNYCNm4CDEm70EMaoRenWwV6YaKcIT062WXlLSQcTUnpsVhP
	BftNTKszbNnrlm8Bzy3tg2MC1UoE6J1i8KCAerGyrS0/XP93P/bOeqRuZ2nVgDQhZ7NyYSLQTF+
	fCPsrHk1VgeydusE0Hgq7Tng8Hohx/Wpr7zUPKr65b8Cob8HPwAMjEI3uC8DtPDP3dENM6UjglZ
	N0GP1s0+hjG/GaZ42DsK2DkFBLTnkgYYqGsQWURKYH0WhhIsNlFLdF2N9jBWQ==
X-Google-Smtp-Source: AGHT+IFh47uwV1k6ja045AtMme3ZSND7FaMgkXxQ8uSMkb7peRH8YY6TZ9EvoYikamy2Sx0aIhJQAw==
X-Received: by 2002:a5d:6486:0:b0:386:33e8:20f4 with SMTP id ffacd0b85a97d-3864cea578cmr4664052f8f.59.1733985065245;
        Wed, 11 Dec 2024 22:31:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550555sm6658685e9.5.2024.12.11.22.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:31:04 -0800 (PST)
Date: Thu, 12 Dec 2024 09:31:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yeongjin Gil <youngjin.gil@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Jaewook Kim <jw5454.kim@samsung.com>
Subject: Re: [PATCH v2] f2fs: compress: don't redirty sparse cluster during
 {,de}compress
Message-ID: <644671fc-b35d-4c53-ae25-356963466339@stanley.mountain>
References: <CGME20240819083433epcas1p3861b773a5b21eea6f0332036a71bb5d7@epcas1p3.samsung.com>
 <20240819083430.31852-1-youngjin.gil@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819083430.31852-1-youngjin.gil@samsung.com>

On Mon, Aug 19, 2024 at 05:34:30PM +0900, Yeongjin Gil wrote:
> In f2fs_do_write_data_page, when the data block is NULL_ADDR, it skips
> writepage considering that it has been already truncated.
> This results in an infinite loop as the PAGECACHE_TAG_TOWRITE tag is not
> cleared during the writeback process for a compressed file including
> NULL_ADDR in compress_mode=user.
> 
> This is the reproduction process:
> 
> 1. dd if=/dev/zero bs=4096 count=1024 seek=1024 of=testfile
> 2. f2fs_io compress testfile
> 3. dd if=/dev/zero bs=4096 count=1 conv=notrunc of=testfile
> 4. f2fs_io decompress testfile
> 
> To prevent the problem, let's check whether the cluster is fully
> allocated before redirty its pages.
> 

We were discussing how to detect these sorts of things in the future.
Presumably a user found this by chance?  Xfstests has two tests which deal
with compression tests/f2fs/002 and tests/f2fs/007.  But it feels like
xfstests is not really the right place for this sort of thing, it would
be better as part of some sort of fuzz testing.

What do you think?

regards,
dan carpenter


