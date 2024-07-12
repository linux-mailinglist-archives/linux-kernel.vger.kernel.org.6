Return-Path: <linux-kernel+bounces-250796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC5992FCEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A662628469F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5849172BD6;
	Fri, 12 Jul 2024 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVaarWED"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FDFEAC7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795896; cv=none; b=EBWfFSRye6ECX6ikAf6uNirWcjMmupCe7FYePx3HUeNe+7hIpjoOUY+VvNIyDx4//DPZ9k60ljkAhviVNtjPwM9c5dXMaE4BFl3SztHD9O4HaGRw66qz+peMubngjxal+2lJxLIbS119tU/hkmTdjCtMjF1qajDLbomBxFqmkQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795896; c=relaxed/simple;
	bh=6Xme/fG7NEewAT3iCDuDM/s9b4eHsxK5bexy9nMN6Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EE8jochNLgoROOYTamSMFTLwAGXwlhpebN8Ka0aab2uHV2MAxpb45mrRp6Hdt+dFTfrQaMzVPJrb8F8nedhRZH/2G/1iSrV8MlXvMkf3dCI69axNYehxyJRxqykXRSm1Qyi5+kUjLi8WjyyGDYpG/Qg5QXP3c+8Y6TVI2BWEop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVaarWED; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso2685387e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720795892; x=1721400692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ky4WPChWhIsghhn+5sM672ORVDTwy7ezIsC/I8SFrEU=;
        b=hVaarWEDDueA/zJa+Cm7+u7dGK2+rjWsj5TcwJNC6L1+frYzbzOX7PpVqqKWldUHs/
         470yi0V3WlaNEYc2k4YHiaz6zUO6eD/Kk+BXO4R9etzAxufrmhfTIiZDkYjTTUAkCyoj
         H1i1dm9yfbg+ztG0W7XcRRyMuN8XmyJjb6eqyCoLQStwK5EbFCPucmRPhGtx1skO4kEr
         sQeHoL1cCMcJTw5wHO0OQgqkMofVk2OxI+gJmEf4jOGrcH8naJc8KO09KcLA9NaMR4tK
         FaQHgcE3gytyPLuHaarcTWaeVyxIzwGqg6vicrcABM6xFzIYr9hD773YR9Jq3mj3t6KR
         NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795892; x=1721400692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ky4WPChWhIsghhn+5sM672ORVDTwy7ezIsC/I8SFrEU=;
        b=wx4uUWgoOz1fXFjuKMvNhd+O6MWcZWqTyP7/RkXv6x6rqQfw15nnBptwNNOVms69c/
         y2id9nJfo/QFL/0EcnwPs071Z6llkZVaoZm6pQITma/qcHaCXUGhl4hahKb7sG4eJT16
         C72CsA9fVgl0Dn+bkaVAEq1tq+KJnmL4fYWLfmvwIuwj2uPjaWbY/A0OmLmhKJrCXwZw
         /q0PbuYZr68fc2lB1D0TYIatcdBMxAyq7N/G0eQIweCmg8QCUtD0X1cJeYtQcnsJkych
         AAqJAR3qlpf4o3geY9PZgssLnlrP24HPfLezzRFZxip5EDZffOrOKp7tHSEiOoadlYAg
         p39A==
X-Forwarded-Encrypted: i=1; AJvYcCWXi2Qa1kAC2SuYdXa8ALDP66EcUJlvD0eSChaY8ZThbqj3KIV7iQ43To6eeW5MYryvoo516hIe14S98xIWIHyeb8KnKumlsPXsOqyL
X-Gm-Message-State: AOJu0Yzy5jyOelGfyS9r4HUPGxJBaU3v4nXs+W7GMA4OaubWU1i7eGqQ
	mMPz3Uxl4G2veMxBwhwJVDGaKgfBivXnAhjCAkbXF34sB/K/XH2gxGDHzn4K58E=
X-Google-Smtp-Source: AGHT+IE2vju82VfTfF5Xrs+6WtBUZDSZ/EBYY7uH6eZlCo/ZT85PKn9f8YK9Az7B5XqPdDfnn4EbmA==
X-Received: by 2002:a05:6512:3a8a:b0:52e:954d:359a with SMTP id 2adb3069b0e04-52eb99d1eabmr8889644e87.43.1720795892533;
        Fri, 12 Jul 2024 07:51:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e3454bsm1316600e87.61.2024.07.12.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:51:32 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.10-rc8
Date: Fri, 12 Jul 2024 16:51:31 +0200
Message-Id: <20240712145131.169802-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a pmdomain fixe intended for v6.10-rc8. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10-rc2

for you to fetch changes up to ddab91f4b2de5c5b46e312a90107d9353087d8ea:

  pmdomain: qcom: rpmhpd: Skip retention level for Power Domains (2024-07-09 12:47:46 +0200)

----------------------------------------------------------------
pmdomain providers:
 - qcom: Skip retention level for rpmhpd's

----------------------------------------------------------------
Taniya Das (1):
      pmdomain: qcom: rpmhpd: Skip retention level for Power Domains

 drivers/pmdomain/qcom/rpmhpd.c | 7 +++++++
 1 file changed, 7 insertions(+)

