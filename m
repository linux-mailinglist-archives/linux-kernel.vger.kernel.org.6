Return-Path: <linux-kernel+bounces-563445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455AA641F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A116F18A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A38219E9E;
	Mon, 17 Mar 2025 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfdJGl1R"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1B15382E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193776; cv=none; b=YCl3Cj2DsXnQV4DvtxKaPoohIiXHhQq7zKCpbA2WG3bL3q2iBkOkzrb7lkU0Yyo3Je0X+Zpkq4oGf2+wppwrBG2zqBJdH+gfubg8pvCOfz2kZ4z8S81S/jwqhlifqnfud0LsRv9ecymC4gSYECJvPZehIJ5U/a6HV7omn76KCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193776; c=relaxed/simple;
	bh=tmuz3S8QS2CK1Do0ifyQigpJ/ofdqUE49XrcsC1JGjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AbJh4Mn+fug7xpAS0vYxdPB+vuGlyCtqqLsTdBcm0e5PGdx2irxBA8K/LMqzYgQu1UQTwMae0J6ozaqIbJCt8E/T38X1UOybgo8MbClzc5xGUdZ2768MWnHdnWzLTEb1fxVb5J9jZgKHJm32R0aFbSEZX1lzUL1J0GejCcnNgZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bfdJGl1R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so12376675e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742193772; x=1742798572; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5FewJ6YzHvRF4+9HsRWOweevFbmaLN9395N1HxAjAI=;
        b=bfdJGl1Re5mS91MXqCduMdRn+1T49drS79F/hqcbM3M8KWg/94O2kPWZRiDif/IFq8
         5ftn4Oh0353ag4PddCUDCb4OKX8bJTFqdjuVcEoUIemh8UaAivKFL6+12UzsbFkTDjF6
         g6F2EyIS0GVwRujX/5NvaR7Mn++GtWBB7VDthgaAAZVTOCyl5nRGX+0dzleF0s93BNyD
         EiGN3b/5zndnoaSTqLhxV3LeFZz1qN679/eLGYTLJfzVqu+7yA7qhml7VOs/XPaJCZBB
         0wLUtUi1OtYAHgTl7S9sr2UFiYyEckwBC3xOpkVGQ+uhA0wfAXLSSlPR2JfaR4sZbTgW
         n7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193772; x=1742798572;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5FewJ6YzHvRF4+9HsRWOweevFbmaLN9395N1HxAjAI=;
        b=TXHAO+83dKX0B3w1E7IkRR66qfDVbRzuBaaBdfI/+WhbU6UyH2Jm81qnsR5ldpvbuZ
         2FLRf2czcN56j00euyN/oLVykW8ElNACfP69j3M4p9C0+bsgjEWHwZ+/u5l48dTtnEWD
         CbPxN+g/G4b+34KT7NpVG7bSUYEUIapCHjhQJRkznuJbv7pg8u7DaUD4RaYJ0muI9lWC
         xzxGE050M1nUG5X5tXCSW2j6ph6yabJvrGHA4LiaZH1R29wxGH0Tc8Fak5AdyJPDQH4f
         1tpkaDx58q7cpWnHA3Hcth8SN4GPK3qHG93t3NX6+HnpYOoOP2S9RgjLDLGZLXArziVE
         RcXA==
X-Forwarded-Encrypted: i=1; AJvYcCXbR+r8QLZ87KRFBnLLAltNSZVOPm2AiJfsPSU6OpVrCw5fLSjmydrO5wuOsF/Bla196GEtTYLh+t4c320=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrROZxGgNZQbCz1DgA+dyL25cL9iUf2tjFGevoZXciuS55Y6QD
	nXAGj7NPYzjurl7H0/9bEUHqkb9/WC9nMLZ2CumGHb2SZBZnWdhAEP28DKH49dg=
X-Gm-Gg: ASbGncvMFFRGvJE7VPZEuxTrL/PCA+cYrXwF8I9VEzv0DhIyYwsHiNiFpeMGIGB6lQ6
	FOpcDsRCKo3DFzwnlMJi7M2KgSYOUSjr8zyARo0WHCWOf1sQw0BqiBTCYDfwDo6tLVrIiHnNJWo
	X62SSy+LzP+Jy+HptO6USeGfPRx6Q7FAQ6Rdy8qSkQFz3+UunfPvETz2a3MGtZTO9ve/yEPYRTd
	G9QuMe4hH/EY3Vr5JztmMnv3RglWDsln57Vi3ll83/r5Y4i2JHLjHNbFXtbpb8wQEnIsh4qOZvv
	i5G+JHn8jOXmpMsHKc+MOFMlBYY6d+hNBJT5RoYOpKLGwAag/w==
X-Google-Smtp-Source: AGHT+IHxu9xjH7mhApYVVv9e3tygFxjACr3/rHNOhNNTZEZVnWCwgxdXUjJa6ONf3FkbXFANSKR7sw==
X-Received: by 2002:a05:600c:1994:b0:43d:b51:46fb with SMTP id 5b1f17b1804b1-43d1ec622b5mr110644745e9.2.1742193771884;
        Sun, 16 Mar 2025 23:42:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d2010e0bfsm94729805e9.36.2025.03.16.23.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:42:51 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:42:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] iommu/amd: two tiny cleanups
Message-ID: <960a6d1a-63d6-49e8-890c-5e8a66e50c45@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Delete an unnecessary NULL check and return a literal zero instead
of "ret" (where ret is zero).

Dan Carpenter (2):
  iommu/amd: Delete unnecessary NULL check
  iommu/amd: Return a literal in init_gcr3_table()

 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.2


