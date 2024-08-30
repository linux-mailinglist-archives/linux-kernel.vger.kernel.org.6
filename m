Return-Path: <linux-kernel+bounces-308650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2A965FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20880287D49
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A18192D6D;
	Fri, 30 Aug 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXGJ7gi2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B4179652
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015840; cv=none; b=EkV08bDrIHPYSzQQ2z/07/2rvE05hLPJzO8TksS+CxRXou3Q36oENuauH7qOVRuCmZaFLMUujJc/SsvnlzoLhwEak+TsdrgLGhD3gJ40NrGR4xrl1nfrLfID4PTIMvvLteSvrAFzXy0+2CtH2gu4gXEagJRgS5K3fy9uONJp7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015840; c=relaxed/simple;
	bh=0ffy6KqD2ZsBlubMNAmxaGladd4Gg5hkg0zx+QhJMCU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AtQkWMTgvlgoYLAgGFud+DzQ37gLBBlSxjhAo80HntGdQqy0dIXUK4gjItn+NqP32qLmw6fDv8LpRA8YUhiUzNcjwSJlI/Bx70FnpMZ1XlM4f26arVPMb91Caru3JZMwIiXaHCH+DFVl8hkWLbtFmf+ybo+mEmVVSfinNmiB7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wXGJ7gi2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3e062dbeeso8805237b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725015838; x=1725620638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obthWJJQx048EnN2AOC6zuK5QgHhreZNXc1GxoMBMd4=;
        b=wXGJ7gi22eQAnN+MisYtiYF5VweiCqk3vahimD1iifKVvHrm95qeocOmcCnhBKk72V
         tzLm9dx/sFEx0RS16FlG/f04fLAiBB21mqi6jvj8HT6fKL8sxIv+alW8BGCAaR7+mWKS
         i5YcnIfwk4ZXGxY7DHhsj9Uw97WX2MtHC8VXzxPXenvTTpsfSAIv1do/PFFKx5twkLek
         keSxRbJuCYDkVMS8O6cSx2eO0Um8w2cQAxIju7jVcgPTPBZci1AT5K0t4EWdAhC+ZPkl
         qizqWQHehoylQbpmxGLDPJSw8qrVqikHzM+/VOidhptL7jeGqHRFE8opFZVZyFBwiPUB
         xSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725015838; x=1725620638;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obthWJJQx048EnN2AOC6zuK5QgHhreZNXc1GxoMBMd4=;
        b=mkxmV95Sg/BMbqoWl5ujtfeVdcBxqPmTkDyOHJJ56dH5waqJMFelS+ne6MetfVL1yC
         HcEsI9P5nI51HXDaw3oqIPayXTOdHl5fdztXHQUNikYiBAEvlimykF/eNu2zdMdD48+7
         jnCJ1Ax861/rsvwQJCGJbqlG/UDgqeaY1V2MJxXzAx8If2rmSOY2hsKLIZKMgL+tRfna
         8lVkUfdRqFZU1WzPGsQcfO30xJ+wn/gN8J3wrkwjjxR54ubJhTZXpwDk+pweaGhToj8g
         LicgzhyYHNw4aN6BFC2eaQN+IylEdrE5LNBBlq3QnHhZQguclf+rkqyO+UauTdJ8sTlI
         5L/A==
X-Gm-Message-State: AOJu0Yxa8hwnpcJd62xBmFQodnwNlwmMEuVxRRF/sQoUOQhixUta/GNs
	hwKSq3hMxom5AsbNnM0CUleLs6q/F2B95njqS3Ut/AxwepRr0Y8jt/ZWG3FZjZEvxJ90R+YMpY+
	A0TEMEtTEoV7tl6fmPpjJJE71nBGiEZjLPnQD0P7YYvdXVz7TvWNbf6eWMcFEXDKhSjhx20Ho7J
	6lA3VcL6b2tjCOhWk+iJ9TASzZ23VSHASpyljMIgY+e02FDCpKGKw=
X-Google-Smtp-Source: AGHT+IHkyHjn4rwsHHaBZz13oCcDK5Wif55SRe6/R2eIzxGkPl4d+94YtRJamqf/F9SQM1XvqVn7meehMJtJLw==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a81:cb0d:0:b0:651:2eea:4dfe with SMTP id
 00721157ae682-6d2818a64f4mr1646297b3.0.1725015837461; Fri, 30 Aug 2024
 04:03:57 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:03:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240830110349.797399-1-smostafa@google.com>
Subject: [PATCH v4 0/2] Fix handling of S2 stalls
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jean-philippe@linaro.org, jgg@ziepe.ca, nicolinc@nvidia.com, 
	mshavit@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While debugging something else, I spent hours looking at hexdumps of
STEs, CDs and commands while comparing them against the arch specs,
where I noticed a minor violation in the driver regarding handling of
S2S bit in the STE.

This has been there for ages, so it=E2=80=99s highly unlikely that any HW (=
if
it exists with such features) running Linux is affected.

I don=E2=80=99t have access to HW with stalls so I just tested normal usage
and (terminated) translation fault events.

Also, add some unit tests for stall enabled masters.

Mostafa Saleh (2):
  iommu/arm-smmu-v3: Match Stall behaviour for S2
  iommu/arm-smmu-v3-test: Test masters with stall enabled

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 83 ++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  8 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 3 files changed, 66 insertions(+), 26 deletions(-)

v4:
- Add S2S bit to get_used for stage-2
- Add unit tests for masters with stall enabled

v3:
- Set S2S for s2 and not s1 domain
- Ignore ats check

v2:
- Fix index of the STE
- Fix conflict with ATS
- Squash the 2 patches and drop enable_nesting

--=20
2.46.0.469.g59c65b2a67-goog


