Return-Path: <linux-kernel+bounces-566147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34036A673D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278713BD4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37958174EE4;
	Tue, 18 Mar 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDRB15o/"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D420C00E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300758; cv=none; b=uipVt2eBASoPQQoFEm5Um8eQV+NmDjApQnMPUHSfgaP2z1beHXLVlGpkajSMO6Qe8x/meKCSKzvzv369RdZfkPoLA3KwxvASKDV27YXup/ZTXSBdoqj2hzEAOMsbc8nXFCw0zFWC5XRv3Ij1zEZO1bUhGEwcUknRkAYH2jVTySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300758; c=relaxed/simple;
	bh=uWcup4zSOhXmCE7f8utEF9MDkob5Y3GjPtl0Flu5Fv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1QGZpurFsVbD0xL9+Y9XvM6sc7lXqRZaj6fL5OeXWPGliZqG1bQHOUNd37wvqZjSTqCCqHtrJHmsipboYuNrMLx92xmkLSCrTN7FXY6jC3/ewy5VJea7KC2Kfzh4KrOR2MXgE+gFI2eZ+5fHNYnczbmiRM6yG7oKSwPyJJwh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDRB15o/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so5634584e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742300751; x=1742905551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtPLa6Gx4FxVSml/wkB43YfMAD/jyTKQtWnRVh8gh1s=;
        b=iDRB15o/ymQM2Rs92dvh3gSbiKZaPScBH/Y3PK/cvrrKtcDHz6V0lEd3i7jy1yNPpZ
         lJNFkQb5RhnpBVYlyYkYP+p1/BWbKkrv0Nu9a8A9Fe/aIpxnwGYoxPdIeiAf8b3lN2Ku
         /Oaz0GSICvdCXq9uebrfNcv+syXkzvZRKUT1xVWay8TIpx/vG1IZGcxLYarIwqlSsJFW
         4nd9W/1RkOAJo/O9lhXQH5KgnY5MQGf7oIiOoWBfPUcBFbZQyioTrvz843iipLcSTebK
         jKuvlXsUIaEvcu9gY33cCddiL7CvjGNXpPHxu4VI/URCZKfY33axAcoaaZeg1AJq0S7C
         /JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300751; x=1742905551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtPLa6Gx4FxVSml/wkB43YfMAD/jyTKQtWnRVh8gh1s=;
        b=DxZbn0vhkfQmvTEqWNrd3W+rERE0JQXuBviXRypKAB7AnzSzrQORKk9f2BdgX0Va1P
         81xhI8dAfO2FkBZsqMFK6y9fRs9q0ga9t56WfowaAeuagXilJ+3xV/VgL+L206wnUzKj
         033W1xO4Z9UGmdNR/hxZmnThGz/Tr6JA9/UWMzKKwh20i5yNADOZBMnStuTfrjZikPO0
         tmJuxivpVwVq5ufPSNDfiuByeNFH9jCHZsEoi/WE0lbq2slUoC54900EhvXkMKJbNd1Q
         nY/J6mib3uX6WkxhfSsqWt9NfM85akaRQg4H9qzkImO5OM9r1In170aIhY8sTZV8wi9Z
         LCIg==
X-Forwarded-Encrypted: i=1; AJvYcCW4VaHXiwUp/bItXgVgBOFq51Uj5rryYYNAsnA4tZjQDQghUJjADuxhn0Glr6hC4IC0xpCxGsfqEfnD5A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnrFa8QxObqJW7JKprZm/dX89+leYCYZZFKxKV/t2PWaOO98xu
	HG7Bshs5ktKuUbq2e0T4bRVIwi+ScbpdAqPwM6AV52NAqcfuVP1kOcKbtpZSFzs=
X-Gm-Gg: ASbGnctw/5XZAl/JcAXOBSnDbxhJ+8VgT4gJGkMg/izP1hdrIOM+bE1vjkNzXXqkGer
	VCUKe/Qzi3xYM6NN1c7RFfW9ipG6I9pzL1Mlb6722UQk/seB650Z6M1AzdGn7ZYFu+moyYA1l2h
	0Tvqt+Ibo6EVamjMlccPJ7+xYwkK6ICLRwQM5Qrmi4SQP/PNDTXDJD0Y2Sg5clbLPIRmojkOWvK
	imfpiuXydparov23h7X+zHUxnjOxP3pKhhlAYBFIK1qWG+FEYED3WOSvRDuSkjYXjdRIlKd6q/L
	OtzHOtItCOE+hI4OJ4RoDaYngOxtkaoOpeLqh1SWuveO9j8U/2tKlrQi2sp3hmy8nFPDlI28WSo
	HwqS5w6uS9hL0n/VNKKQ=
X-Google-Smtp-Source: AGHT+IGVZaHWKtN8hvWXYb4jPz6o8jybr9YNPIgsaj0qZXf8oAQIfNC+5+M6VxE6U6PaRzmbGl48Vg==
X-Received: by 2002:a05:6512:3d8a:b0:545:1d96:d6f7 with SMTP id 2adb3069b0e04-549c396e431mr11868418e87.32.1742300751071;
        Tue, 18 Mar 2025 05:25:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba86528dsm1626584e87.138.2025.03.18.05.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:25:49 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.14-rc8
Date: Tue, 18 Mar 2025 13:25:48 +0100
Message-ID: <20250318122548.1328552-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a pmdomain fixe intended for v6.14-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.14-rc4

for you to fetch changes up to ef17b519088ee0c167cf507820609732ec8bad1a:

  pmdomain: amlogic: fix T7 ISP secpower (2025-03-05 15:51:04 +0100)

----------------------------------------------------------------
pmdomain providers:
 - amlogic: Fix T7 ISP secpower

----------------------------------------------------------------
Xianwei Zhao (1):
      pmdomain: amlogic: fix T7 ISP secpower

 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

