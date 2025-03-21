Return-Path: <linux-kernel+bounces-571660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F59A6C049
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE6116AA54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199A22CBED;
	Fri, 21 Mar 2025 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtuzh/M7"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60A22CBC4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575282; cv=none; b=ZS9Zr67KtYH2OGOePk0eWYFrEmIK9b9bWMuHhv/k8j3ck1Ioig9/lF0zwLey9aY7cNWR98yfN6rvEEGxE17vx3XFJi8D6pwhgOl1XZXA0iOVnU86XCUEu11yWhLbuU7mGB6TDlyafCI8oENK/g9dj519jVwU+XRTd6v1KoI1daI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575282; c=relaxed/simple;
	bh=bkMwgOdDKThxS1Ispd/jVtTHqHiO70yLIJOqvzWYhE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OPNmpy8iKKwnlDzSpPYH8VTwkd54c4wpHQR56/lzJl25A0tsCyLof+ioLfsJi+rTXJmK30kf1hM/WMZ7EcLg1NqXgdcdEMNDoTIXTw7mfXkj5cwRsIaxRMGNOP8ZnswCyQS9yILHlkfvNXK4nQFNkYeSjDlzWbcun3yfBM0NiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtuzh/M7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac29af3382dso352018566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742575278; x=1743180078; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/7lbrLsVGX6maQoBKXKGK0v/L55Iip7Mn2w3HMZN6Ds=;
        b=rtuzh/M7LbT2FrWQ1o0cvgtItLQAW0CugZdMBCoAg+vxKeGypF6Ah3b2Qr6qYwarmz
         D/wCe3vOuSqIRGhMkHfdrVH8u06zMTiBQ8/kAGFNQZfqmtRd/IbGcRq48S4L5KzdsELu
         WGphS0xYoURpPZI79wiGO1uzUJGai9f77l76P1I3ZmUOr0fQBiG5M61a5oSgF7hXHta2
         eGU4wnNqAAB3HO4byRLqzPgeP8/4lWaGdBPOXiwTzQ4nRLYitDOE9/ZRfwsZoUvLGlXf
         g/4NkulLQoSz8VOwh6IsvY+5j3/HZRRwbEmF0u06KgfTIzMOb+5GWvZfLkk3ixIqeMyX
         sjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575278; x=1743180078;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7lbrLsVGX6maQoBKXKGK0v/L55Iip7Mn2w3HMZN6Ds=;
        b=xQ3mQM1IArwWlu/ZxbkIoPzhpLyxdx76ftYkjuppz+WPcnBAqByJwB+5zyv+w5niF3
         qa07k0AwjTesQHiD0f01gmT4uJl4k0Im38md3LL+M188HbJQorQEMvURCuqkBflUsAcL
         0LyszxEqDM3ys3GYNgWt9zoIaen/BY6h2lklGUzkUNpbNawREq4VqQ9RxDvtSgpDy7zg
         s8pkz51v2bayhnzTvHicC0e5P4dPJlOOD9KB0RbMofrRYTpUpV0CXsPwZ7JcP8W0W2hw
         xPvTJ43+2phrys+yu7//2rC3c0n61JGKca4m1HR3Oc+YSqSEZWBDCT/RmRD4kMd6/3cY
         J5jw==
X-Forwarded-Encrypted: i=1; AJvYcCXPbHTJ4FAiV3R+bPUouzHjxoUcQoSOpGzL3BrJBRMxiU/WYyJ58fYa90d1SIae+vM2RAWtTxpnMLpcrg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7vYEbudwgrsE20KK7ib30HCyeCs2LAk7OUB4hbP0Cr5jg+dJ
	CKvDRgA6R+R2Thq6UDzxDxGqmS7gNu0ow/oVk43+6HM2nVKLkOww7CHFtqS7Mjc=
X-Gm-Gg: ASbGncut/YfDehWcnWd8F2CS56Dz+1n60jyZtc0rD7yXeRjeyOTdkcNm3zPWaD73Lwq
	NpqKoHZHggd/ku37qRziCZrTeVb0DphnIsAPLqFAv/CPDRu8q2/WczPiNEgACVulZ/DGc+1xPNW
	T7mFJW7rMgt/04Bwa5n6pBZyX91d9yUk/E1HBtVTig8mOBwQe5TMi6K8fKslqidZXUcqPP2ll1G
	ZrsClrHMjp7q2zxtjtSMwC97TGsuxnADMmDrUiKAdytWBuv7Nhj/3V1uFPTq4ykBHdU+ZIa0QP/
	5+ena2I1RHCMQcJQ5x1+bwb+vpoyUocE3f6p0CVcYZStLTQMT+nNde/c1Zf4xF/nsgzT6IC5+vA
	PdGbxstfEmc8Gn3MeCHhBOiIP3vj+
X-Google-Smtp-Source: AGHT+IHh8NWOl362k+c3d40t/J+WkLnIig/7cGdwwswOV+7z2+Wk0kA3DxuBF3HLDuyvLxlH3NNKMw==
X-Received: by 2002:a17:907:ec0d:b0:ac2:972c:f732 with SMTP id a640c23a62f3a-ac3f22b13eemr457901366b.33.1742575277903;
        Fri, 21 Mar 2025 09:41:17 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbdc78esm184015666b.134.2025.03.21.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:41:17 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/2] firmware: exynos-acpm: allow use during system
 shutdown
Date: Fri, 21 Mar 2025 16:40:56 +0000
Message-Id: <20250321-acpm-atomic-v1-0-fb887bde7e61@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJiW3WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyND3cTkglzdxJL83MxkXQNjY3Nz0yQDU8PUNCWgjoKi1LTMCrBp0bG
 1tQAfgEpcXQAAAA==
X-Change-ID: 20250321-acpm-atomic-033775b051ef
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

One user of this ACPM driver is a PMIC driver that needs to communicate
with the PMIC during late system shutdown and at that time we are not
allowed to sleep anymore.

This series address this by switching the code to using udelay() in the
specific case of system shutdown. This approach was inspired by I2C's
i2c_in_atomic_xfer_mode(), which has to deal with a similar corner
case.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (2):
      firmware: exynos-acpm: use ktime APIs for timeout detection
      firmware: exynos-acpm: allow use during system shutdown

 drivers/firmware/samsung/exynos-acpm.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)
---
base-commit: c4d4884b67802c41fd67399747165d65c770621a
change-id: 20250321-acpm-atomic-033775b051ef

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


