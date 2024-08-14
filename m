Return-Path: <linux-kernel+bounces-287197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7A952483
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F4A1F23E52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100A1C8221;
	Wed, 14 Aug 2024 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktby8IA3"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5EE210FB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669916; cv=none; b=CPpQhh6tjtDs5AxqB9IYQpogox8IUmRO+vfS8dazmijoZkWwwDc7gO6jhFhk12ogwnRfgNL9/zipNgvc9kqjNGRV3S5qFwQk8lXOg0FvlEJ3osShVYAOtYYG1P7JaSEKjz6RhzgDdqUQWyW0ZZ7mLloUeOpDSzJVUsNI9lyheco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669916; c=relaxed/simple;
	bh=RrNuKMnpWClcSwdeuBHgLTNkTWm1l+81N9oPrYk2bpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kWOx8GavQ7Ep7Zo/b90clQlYFB8U4oWjNwruUjtWMKww7sPLxPM7K0d+D5LOIpvap1dXl2jfABKARNb32cmPdw83qDrI+YF3pjHolq3SqdvQkVjW+OxViFs184B/q+66l17QRbS0bv9W78fH476tHB9zLjErLoplhE3I2AZKTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ktby8IA3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37182eee02dso133259f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723669911; x=1724274711; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNtnCY8eBpgWHbCqN80CA+9ry5b1MXO3tqsVqyVfaag=;
        b=ktby8IA3B6Z4A+97jEQEqvOR+Ww2A+k5EnwXCdNenKQ7FeSNItwtCOA9DPz/XB9R1N
         nO2Fhl5lYOj0s6A+k5QihjEtjFOJ90u1HpnnCpB8qZ8hTiGM2/cNMb/rL7wgBWzbPk8F
         PKVTvbOzBmQjLMCLep7ECQnKIDO56KbUdNv+FZN3LYPIuiF3SeHL49zmlASdf3LWcFcb
         bcoGkWn1JS70MK4cSmSR/m9O5CAxFRId+59E0vgrUjF8dsLOojZpYm9IF3RgUJR8VC4h
         WDvqd283rERwW/qA1RdIgK/Xq17xI98vcX6Eu4vCcdPvz3Yp8xvDXf0hF2b0pVRZLMK+
         JRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669911; x=1724274711;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNtnCY8eBpgWHbCqN80CA+9ry5b1MXO3tqsVqyVfaag=;
        b=pBTasrL+BiCxi4uoobe5qbGzrTItMYpfM37glNDAjnspWZ5i2qvH6lz74m98c5W9f4
         oJe78zLaoscFRBfzh4BTnhH3iGsnH6h9ZQYc/0PqeI63iC8M241ZNK0OlSqv1RX9e6gG
         AhGgrsYhcdNRX9ic9p+NWqPofL7QIZdmzrPlbnBpLx2ZJbIEH+Rc7HDenIZmiMJCBKtX
         /9TEa2YUzh9wknEubDr6lgtsqBMNzjIdkvGafassH3AHuXsS+vjbzEUHfaR0W2u1d5Rk
         JF07LehgXPI+ruwZVK1Iz7iPxQzWJdWfGp9bJuO48w9MxvgfotL7Cg3ULw0aB9qlvx6G
         C25Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3mwU+lk5VyqjySebHYcV01i7PYLW5vSDg3f3Yj7qPbIctPRJ6upjlBFjJQbvevnw+aqip6S/owLD2Las=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVpbJ9zCYJu3sFVUnO7RasdjYby+Q+Z2nTqbNcpTZVK8ir7s1q
	C2+3tEigVYtHCGIZwCFzjH8FhpCC3P/6YnlvpX4FK7CX7Eku7OZ8jS2L1QkMQVo=
X-Google-Smtp-Source: AGHT+IExOoLUif+8UAIX2fT9byQAmZbdMZQHvKRFH/pxCPo2HgmjobMSMqCtfayNv3jQTefqPATJ/g==
X-Received: by 2002:adf:e641:0:b0:36b:bb7b:9244 with SMTP id ffacd0b85a97d-37186bbd1ecmr665844f8f.1.1723669911269;
        Wed, 14 Aug 2024 14:11:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7cfc6sm31092815e9.42.2024.08.14.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:11:51 -0700 (PDT)
Date: Thu, 15 Aug 2024 00:11:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Bhoomika K <bhoomikak@vayavyalabs.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavitrakumar M <pavitrakumarm@vayavyalabs.com>,
	Ruud Derwig <Ruud.Derwig@synopsys.com>
Subject: [PATCH 0/3] crypto: spacc - Fix Smatch issues
Message-ID: <b47b6e7a-dd63-4005-9339-edb705f6f983@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix a couple off by ones, and a minor style nit.

Dan Carpenter (3):
  crypto: spacc - Fix bounds checking on spacc->job[]
  crypto: spacc - Fix off by one in spacc_isenabled()
  crypto: spacc - Add a new line in spacc_open()

 drivers/crypto/dwc-spacc/spacc_core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.43.0


