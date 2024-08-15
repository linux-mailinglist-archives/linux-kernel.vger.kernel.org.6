Return-Path: <linux-kernel+bounces-287858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B3D952D50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA53B2138E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B311AC8A2;
	Thu, 15 Aug 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQKrB/tj"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDE1AC88A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720804; cv=none; b=r/L8lYR2zGqK1+tuwGdn+avphq5nt5T7/xbOzLzufMfWb+TjKruPMVJJ9rM6yWIc9EkPTaKT+zlnKx0GfvR5z2OaiE2U85P7RgT30WiX0cc+AzbKvaqEWIoLyLMgVX8CRHdymTMbnIbJzPyXApbEN2auQaOB8b9sgMkff9hGJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720804; c=relaxed/simple;
	bh=yURztonZrBwHUHibkawREdePNMweVxOWwY8OJ0QSyB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=awfSqmy6JizKwkGwIduXsDUCuseikyTBE90cMWm4OXr7jwNFzHyxA5aQoWsoO9k5B4X0X3izkQH2f1uNxH1L0WaAtk+1oNUXFQIAoaYW/5GVq+MIN0EGwBlkS6aJALO2z5nXtXe9ZOrZfyDeSmMIvuD/hEjYG8JQytTBHCewV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NQKrB/tj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280c55e488so4070005e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723720801; x=1724325601; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nI4171woC8AbIwEQ7yZoKX44iROE7Q6gQWAZSkQrquE=;
        b=NQKrB/tj/k375VSGk79fmL9o7iqpTCgt1iPBQjzQmRdPJxdwqiI8sisfdLcez3fBmt
         1Yf1xUuaREFHR5CG5KZiJYA3ozkQkOOamKlSBIpO6ip1kMqCv6tkfeL9941j4jfWmYlJ
         eaam3qtZdLWsIACtVula3bGHggy4YerhlFQC5/2hL/C9qCa9XNb+YvAzJTWwO00V+cEr
         EDChFrKKSiBojYMFIgLtXKf9dRd0sMEi7k8cn6zSSytgJKFEgI8ZKtbEerIXcjX3p8ob
         7HIJJd0LsVXwIUL95Zp2AC7N3TlFGAx4GspXKBAVXMHovOeXWZIuNiKy4KGCYDWVDrnA
         EAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723720801; x=1724325601;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nI4171woC8AbIwEQ7yZoKX44iROE7Q6gQWAZSkQrquE=;
        b=G6BJ57jBsWkcZdZ5lamjGqVd66rwrG+ijwglOdopWQpgj6ccWobc57Q6GuwITqIgYE
         dOiW6bTNSckSK1LQwCj+OyYuRStxNqKkmaCe5gE5BpVjC/8/PSQLmAYHxFEpAuC1Wx+i
         Q+FQVPZIIPGT1hTQfpdnX+pCsAUYb7J8DtkHTf2HVtNHyrf5PReqyxlknYk9wa+LXtJR
         IF6UziIPHo1JV438PBWj1Q5osfq1fzWrsBpLyhYdo7iCNHL9j6ikZFV0KIeOyKT5r2DX
         EJxRTCYl+eqkGYEwlkWuqsD+yppNd3FZMmubBVxREAdfMNJ/2Fb8Hx+W2ns0Q5Tsf+SK
         v7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWryqOmUzeb/SE1SP4fLOG34iMZcq5T5iOu0MbnDZNVT1NmorB7AxjjUhHno2/WKr4thDDw/qKdvjZGl/yZxEge65bRRS2T62GHMKIl
X-Gm-Message-State: AOJu0YxwIL6RMj9mDqUt/QEO8PlcfV2cLG4qp3uaIuAYwfImFtdQWqNb
	xe12SebomC47XK3AATmELjokc8MCo6fHr2vCaOwFTRGiZrtUfyZjhpAZLaifPrk=
X-Google-Smtp-Source: AGHT+IHd9j20vHOXcP9rlnZ9ILGmbI3Pz/RRtKxnfVhu+foJuiDVUD5jJfu6OyZ/hkQoLTos92SGtA==
X-Received: by 2002:a05:600c:500c:b0:426:6981:1bd with SMTP id 5b1f17b1804b1-429e233b139mr20497645e9.5.1723720801296;
        Thu, 15 Aug 2024 04:20:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7bfd90bsm16608105e9.9.2024.08.15.04.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:20:00 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:19:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
Cc: Bhoomika K <bhoomikak@vayavyalabs.com>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ruud Derwig <Ruud.Derwig@synopsys.com>,
	shwetar <shwetar@vayavyalabs.com>
Subject: [PATCH 0/3] crypto: spacc - More Smatch fixes
Message-ID: <df1ed763-0916-41e9-bdcf-a1a51c8ad88a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A few more Smatch one liner patches.

Dan Carpenter (3):
  crypto: spacc - Fix uninitialized variable in spacc_aead_process()
  crypto: spacc - Fix NULL vs IS_ERR() check in spacc_aead_fallback()
  crypto: spacc - Check for allocation failure in
    spacc_skcipher_fallback()

 drivers/crypto/dwc-spacc/spacc_aead.c     | 8 +++-----
 drivers/crypto/dwc-spacc/spacc_skcipher.c | 2 ++
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.0


