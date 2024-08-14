Return-Path: <linux-kernel+bounces-287207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969449524A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2366428509C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C932913C684;
	Wed, 14 Aug 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXJkDOrg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED113BC0C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670447; cv=none; b=j1xelOjmwAvh/T2eOh4sBl0wJT00Y4TJ1YO+UzrxrzV9D2zAeTNFwqQc68ssAR6UQ9m7DTxU6ShjDooW7C22SEJxcnEGPZh2ABzw0nOrvYeYNuFVJPXurjSNUdsjtzBBfDgzgl4DU3B3fNwz9c1xJcgoh6cccbAcEn9FZuv+YRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670447; c=relaxed/simple;
	bh=BXpWJ7G60z8moZHykofBPZq77vdUi15m9nFEAwLkLYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMYy+v9x8lB+TqEW8N8h8gyuajpKp0uyqOJxx+r9uYiYYgdz98r1YLf5nBKSEKipyYuqI/tlv7jIET/GXmucoV/yFY/uCIHHYfFOeUsa8rpNfkPlNuI+YlibUwCFOKEc5CIfL1H3310sdrEEWwg+xrzgEkkGG5M9h2RqEse2mpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXJkDOrg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42803bbf842so1995735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723670444; x=1724275244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9oAYmnH6MofwvfK7sgRQ6mxCg378Vn0pCt20dkMthag=;
        b=LXJkDOrgO6ZQlF5TwYc8UAiRfQ8vZOzKHK6lNbsPFPhXEQCv7Zvr24szwgv8nZ5Wmc
         dxswBL8Bw4AOC+ghjzJMKMTtaDyYHnpgQ4vx2FZRk7dKwNEQMs9e/KoVust8F8JMMBhF
         IIm5n65EJRoUWb1otRsnVM7gy25yVnVDe6ZUa8gGTM0Ka1LLqJKyTIVDyyxM9qXFRRqO
         9SVGgx9QgOQL1dXRhI00wF9ETbn4FdP+6hSBAH81DW/FgyKxqfnP10pv7X+mGVLAhUIQ
         C4B5Ki6cy6llvm9JO1XMSgHj4EANk1fuqBSxUcROnU/Qkp0tTtAybfk+tu6Pi9D9zhr+
         SVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670444; x=1724275244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oAYmnH6MofwvfK7sgRQ6mxCg378Vn0pCt20dkMthag=;
        b=VnEN7yo8CNPfZJ+Q7BfFhJbYo3dFBXAAfzqUBQScK2AxopR8bwsw1KS7A2ZzFZ7gnh
         3Y5LUMGEAi1q7XuUQA/YhpXKZ87bcVx1j1YXXI/X0oUSrJbgGF+6LlMbhnSteHNiiuq2
         8gC0erPbPikLDBxrlD77zd7XhvRf0d4fl3u9TMKN4Ya2dx44o417EOnFYWJcqqNQ+cSZ
         hjQzn26bae89+kxYoCV4VcfJn5itxmrCK2uZBObs493gequXrd4gG455AFcpIGorkIgx
         xQM/x758JJXnNTUQp2CK6v5KfMWqJBoxr13Puq01Bnhuh4im+6GPJa25GKKs8pFRG9B9
         oFMg==
X-Forwarded-Encrypted: i=1; AJvYcCWEx5qS9JErc/ztwk9YdeyMq1kDvO3vyDZ1NVpIXTqnqwpIOhyGE7nCqJZPYSGiA44WhkExIV72gIGvoEr+3tnzxbpnUyE7c2TxSmH7
X-Gm-Message-State: AOJu0Yz8bTpP8SuU12E7wOpRxIlZkvILMTTkRtuxzPG7yidmmYvz8FCX
	ULRNUOobd6uSV/CZ3mIdsJPViXbsrER7hVV7XO0sNx0J58YN9FJ1Yht7NZJF7kbVtwPw8L4mKxz
	H
X-Google-Smtp-Source: AGHT+IFeFdsWCWSXFxKzZH3YN0A/8/j4lcY3BId4eyq51PWhMqA3R4eNW2JxWCo7iUvVwKlvj2scBg==
X-Received: by 2002:a05:600c:5488:b0:428:e30:fa8d with SMTP id 5b1f17b1804b1-429dd22f43emr33659265e9.6.1723670443523;
        Wed, 14 Aug 2024 14:20:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3596esm30497385e9.22.2024.08.14.14.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:20:43 -0700 (PDT)
Date: Thu, 15 Aug 2024 00:20:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Bhoomika K <bhoomikak@vayavyalabs.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavitrakumar M <pavitrakumarm@vayavyalabs.com>,
	Ruud Derwig <Ruud.Derwig@synopsys.com>
Subject: Re: [PATCH 0/3] crypto: spacc - Fix Smatch issues
Message-ID: <35f19bb9-8035-4301-924b-45d6a20512bd@stanley.mountain>
References: <b47b6e7a-dd63-4005-9339-edb705f6f983@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47b6e7a-dd63-4005-9339-edb705f6f983@stanley.mountain>

Sorry the threading was messed up.  I'm writing script to add cover letters but
it had a bug.  Hopefully that was the last bug.

regards,
dan carpenter


