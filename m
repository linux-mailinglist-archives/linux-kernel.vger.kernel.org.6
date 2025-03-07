Return-Path: <linux-kernel+bounces-550679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F0A562DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27FC188CC75
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85EF1AF4C1;
	Fri,  7 Mar 2025 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7l5sUCk"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91114D283
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337196; cv=none; b=XH/LZIRra3X/cubMZ64c53dhcrKkHbL8V8sHpaDfwLcN07jP9cAQtr2UnFyaaTVi2yyzkkFzIjOYnXen0F6UabSD6qHwj+4qXmsfqNFg+31J4iUmfVR6gDkxqj0I+Ee4OCFiOvqq2bHkHQ8AWrNyuFDZKoT6mCu1wVflpDZBlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337196; c=relaxed/simple;
	bh=UZdNPSFkGuF67Y2D2j1l7ajtTt0384qJziCThvH/X7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c7uRrW2Yz4yRfaTqT2dNXLrqUNLmKv8iZvN8JC9byF/SnPaygs1QrVi04Eob9YROkkb+3sVsAzwzyl2Uh39eu3Hy/7GrXs7NNmI77AXPdFtIcxORxjR+byHT48s0vO19boTH4oc3q6ReLL7BFrMdTH+pxsFcvQB0MtbEmdZEP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7l5sUCk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a823036so13148015e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741337193; x=1741941993; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpjTC2Zowt+/mheAT9bBFuVRKJP6ih9w+W88EZYs/AU=;
        b=S7l5sUCkDUQiyrIqZKdlq+5UbK9F+1pteNriXVLIqTNC14TEjddENAWAijZBbFDXqF
         QJM2s/RdbZKsfKfUEcb93LFBmYycVW5SnBesznTPFl6vPR9bVEFWYOtkvclA55BfuyD8
         NWDOJsZabzHXc877m+FaUucUp0MeSHsXRclNIkNGwpoaxn37IWgra0/R1fKDUwZoBbkr
         740/j3gX85cnSw20fbOXLQWQ4SRTS9wYRMT2QJ9atOTwAdCOOzEj3XEblvE36TUMIfoj
         B1uqUiMluXPz0DGXRzy2CfgZ8I1bhXhWE8+En8m+s6zxvhPRZ5/aq+jy2eQkYzuZlre1
         cs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337193; x=1741941993;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpjTC2Zowt+/mheAT9bBFuVRKJP6ih9w+W88EZYs/AU=;
        b=JzBf5+0uVuXmIOps/mQm32sZ2snScjbi2XvnFmAXiLpYg35xVqErOp+vpnzprdEjHc
         ZduR1aJeomqkZMoaSy3P9iOxC8Mg4Q2vgrj43TKLg53eBgrj3KR2+/gQSwE7Uc0pmCIj
         uqynjV3v8Z6f4enR1hgsGjD1gb2hKTUQHXFkEpHoRWVldv+TyVhgx+B/17DHecGn2vHy
         PQcibB2PXGpiJo4yrk72MarPjmBD8GgZy1y8v7rk+x2P3yUoLjiTMdJ4OSpBeHcc8+EK
         MXyCKiAudE0qSDgYN5sXMHDSIMQJk82VgZlpPbjEm2xc/qAjd7UX6EeTZ4fsFvdzEvMs
         SaDg==
X-Forwarded-Encrypted: i=1; AJvYcCWtA+wowNfRqIzi5Nibs4LLnM2f5AHTTvwF8B12WeQTI8F6r3EE96gQ8R4wD+XiKw2uR7jL24EdIc+hLlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4OzL73olwyS6aeD07e1yV3hJcpI0SVyhiy3CUaTgFfe2Tzsq
	rZW9JngOomm6pTOXo4yvSvSmCBUmwPkqvpAfZPiTRGv3wR4Hlflcwuhn06flspw=
X-Gm-Gg: ASbGnculx3lCQigOZfZxqL/g/gLENmB/+7VJEpWzs+pd7IT3jifH25eTb1NOXf24WIv
	72DbjEfrncQyLxcMAGa/e+KtFkzbhYvrDpInPk2h0u7X6AXHbuWcLpSh7Di8BXac/nUb+YhUuf6
	/9AzdzVLKoV9pi073/kNdAyOHPdqxphXTlyQB2clbnKzdnnIynfEeS0zVEg+sUMdLT2zlJxoOoc
	4m/9mlhmwkH8G322E3rVodhm143uaZZV60/jGTCDxu6m/hKlrG55YQWagH1T1cncaJdpNC8V3J6
	Z/ao1rk7EVpnmW8bjr7NM2AlWE9jjLxrlYOKlr8Yro+kMn0R5w==
X-Google-Smtp-Source: AGHT+IE2WPmmMHuLMoG6nFgev4JSV9g1QQICRRmhZKcc7TCsnVzPPzO+2yO4IWmx2AdvpgYXNQ8mQQ==
X-Received: by 2002:a05:6000:1445:b0:390:f738:2467 with SMTP id ffacd0b85a97d-39132d5a94fmr1699978f8f.33.1741337192832;
        Fri, 07 Mar 2025 00:46:32 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdfdb9sm4606948f8f.27.2025.03.07.00.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:46:32 -0800 (PST)
Date: Fri, 7 Mar 2025 11:46:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/2] PCI: two fixes in pci_register_host_bridge()
Message-ID: <2865c3d3-7315-43b2-8e3e-5eaa6a943f18@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These are two error handling fixes to pci_register_host_bridge().

Dan Carpenter (2):
  PCI: remove stray put_device() in pci_register_host_bridge()
  PCI: Fix double free in pci_register_host_bridge()

 drivers/pci/probe.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.47.2


