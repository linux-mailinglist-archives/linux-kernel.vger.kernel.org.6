Return-Path: <linux-kernel+bounces-380296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F19AEBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289DE285FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6921F80DE;
	Thu, 24 Oct 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rf/LES2r"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FAC1F666B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787129; cv=none; b=OKXsM3oiLS2Dh/PhMLLQRqoICqlNSk6idkzN99afNXK8ezkrVy53h06BjKDc6ESES1ahgpt0/VHF8JbLQg6qy1LEcPeYNWgOvl/apq0sHGwsHHvdAucFningZuWUgnAq7QVB512v0ZXBru3p//inOyqYbNeB6H89w4jd3Rn7xF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787129; c=relaxed/simple;
	bh=jmlTYrYntbS4IGYc2EP4iWxxwtC5Jg9tZX0AcgAK4zs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d3roCOo16FWJUgdHDbt3Rea2eTRa154bItib7Ls7y424o/dNZx9QIurpBPx5S67hn70EqstqxOsk/Q1o+eBcTioeygIEnCsyk8E4LnemKIFU2/V5tPHCUOPzMPCz9KkfTrLk8uOyemr5pC3tadmXWlP3HOt2QuplcvrfOT9Y8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rf/LES2r; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so9057515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787126; x=1730391926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KR+B5L4cIU9DDdYRJ/PwALZk56liTvqbQa9wbDbtP2w=;
        b=Rf/LES2rvYl7hEJzJNgp22wwmG5JEQSyaVrcDaUD3lSFTIljrwmO/vBA3gdpFw9dZp
         44eyR01pVOU5grBHg1sDy4fLzM4wIKF8Ya5saT5uARn3vSI/b86Ag0rWH8oheBvbZJom
         cmHmsmI5oXwbk05v8w7sv4d+gDltH5cu7rTIGAGNhZ9zyPLn58CPoFwweBvK+5m5nTzI
         dO3tmbZtSiiVBvCdgpJV7LK69huEgol532qlZvct67duWTNhdc7DcMTiowmq7f9w6AbZ
         d4Th22joElENkRwWlqPzwtZoeRblIseVfuT+YmYcroPY7ik1RYK2Ip091izS8fkmiiEU
         +RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787126; x=1730391926;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KR+B5L4cIU9DDdYRJ/PwALZk56liTvqbQa9wbDbtP2w=;
        b=dvQy3zMMR77hzcO8KMVLBY36YQphFmM4/1gXbghGV76Wp9GJqQgEiXJVBFj1s7XuHh
         pXwvlirWTIeoa5RfO8l6HBnYTHcs1ptSgP7+0gEPh2/bf0dW6E0e1e1SFpBoSCSM9WBI
         +3kzMIBbSV6e7xNvyzUa3VY/0jZeunygP4DvMKvSkB0f5Lq02/va91j89UutR6ee2Ykd
         k9WAMsQHlDF6VkpjVyVYsc/+BBcIe8yYH486fxXije6GjCdGFH1rCnaeq4DKX+MDEpBi
         4Xk2GvzSrQLZIgP6+evYY6Z+I5KSHNUOMm/v3oElw5gb2xY1quGrpWhtmBiC232+DQAx
         Z9RA==
X-Gm-Message-State: AOJu0YwpiK+tRihYaz/tXwRK/SRu+WRzIRhSWicjVKkoJWUWT0rngowY
	rvb1ZmRo5tdDAqGnE3obiaB172aFqnLlVFpcgK9lFZYnHTTs7aqjim82qvCWQHEYPiLgU8CXSeS
	A3oc7mK3rK1rcL3Nr66Wo2b/r+Y4Uyj8OnW4XUf7r2PA4BVbC38XSgti/LwM4aXpI4zZ+Euqq8j
	2Dl7rTh5tfbuhweuWZfEVANVPNe6n5IwRrf+V2z0f0c09WfN2RFws=
X-Google-Smtp-Source: AGHT+IEa0fdCs9TdeI1S154h4FVCg2RPzpPawn874ObbhYWCTqLcJW9Fp8UBsiTi8lK8mBxACgZ6DDCkYsBLxQ==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:4483:b0:42c:ac8c:9725 with SMTP
 id 5b1f17b1804b1-4318c76565bmr59885e9.8.1729787125428; Thu, 24 Oct 2024
 09:25:25 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:25:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024162516.2005652-1-smostafa@google.com>
Subject: [PATCH 0/2] iommu/io-pgtable-arm: Fix for stage-2 map/unmap
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

The first patch is a bug fix for stage-2 handling of concatenated pgds
that can break map/unmap for some cases.

The second patch is adding these cases to selfs tests.

While looking at that, I also noticed that the concated page tables support
is minimal and not supported for many cases (level = 0, 2, 3), I wrote some
code to support that so I can test further, I can send it later in another
patch.

Mostafa Saleh (2):
  iommu/io-pgtable-arm: Fix stage-2 map/umap for concatenated tables
  iommu/io-pgtable-arm: Add self test for the last page in the IAS

 drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

-- 
2.47.0.105.g07ac214952-goog


