Return-Path: <linux-kernel+bounces-267795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9EE94158C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11EB1C22C75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88EF1A38EE;
	Tue, 30 Jul 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Xlw2g34L"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C821A38E3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353960; cv=none; b=ZrE43ccmizs1Ld/ZLlYQkf98HRmAlTBrEtEeHDWiZ/+gpZUjF0qaX/VmipOP0HiRFjxRKrAbtirGwKI72bXlj+T6cId+qoGA5j/bn9Fh9SI7uzZRggjivYSu+rn8vLii6zyi6BxxkC0HXxO+wLI36v5aKfxIY99mHJEjzxj28mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353960; c=relaxed/simple;
	bh=g7se6oeZ5KLpRAANz/R9S2ovP5N22d6tZ6dgM6QNyEc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f3rfJEe8Zo2pN9TR4nJONp8zhigEEVU8bW2ihJmkCgZTdx2Ef93wm9rkuh4+GLHcEuuan9jOGGU9hsYyogl5whWkJi0Wm0SWd4zk2r/8/CNHP+xHH12mvqbU4bxDDdXGxelOlvgSD3IdOH8DL8uDhCGPA93Dt669/eKeRz10vuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Xlw2g34L; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so27683205e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722353956; x=1722958756; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIlY+IE9qZ+wnr6EW9tCYg2sPtX/V+1hIuGutkdwgzE=;
        b=Xlw2g34LtwYFdgBn2JIozraDvtRItq4LohV2RNXMgsd7SeeZ/mapHevKQlJUuA9miA
         i617ThWJ3liJi+S9Jk8kT1A+B8aIBk+R9cFpGVb7v+zVWqQiOYZTvAYqaDKekpFEomVz
         an05cdPJ2/U3V7uFVK34zqwnRfs5R2EZQxj9UhFzQXMGU92+U82NIx8dLNsroemfjETg
         vwc6ZQ28il9njyI9n7AxXPF8TsTHWF4nrXPOGcVfRh8YdrJfCJHTE2OlJxPgbwOMYLZr
         jxHuMeqPlF/zCy3NNoUA6GuHzFg2G2LHaWbHsNazD6VwBdoFa2LOjluXroaUClP9qHmw
         RrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722353956; x=1722958756;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIlY+IE9qZ+wnr6EW9tCYg2sPtX/V+1hIuGutkdwgzE=;
        b=Z4JhSokW4Nf3ycmV79YajLkDladHRvb7j//r1PvtMpQrAeih7VDNjsJ80VTJcJcwG4
         gVihNi8gjTMdGm7M/ekKyLI2Z2ib42wZLT9fn8uQToR+FdERX5m6I0nrqurmbDzbDuXG
         hXsmR8ABHZC7Vv5e9Wrgn7b5iOCfZvDyIh4bZBpSw0uMSvQxVK9AqzjPTeR38r52OuP6
         DF+L0KNMMjRZlnKQKP4BBLoUavdDnrZJOl76q4lOOUkjmZs9UZVIGKcENjSTfmPEXjNK
         VfjaGyapXVaIRZKUa69odhp8FXQl7qDCsFcHMkX/1KdVdtTuLkDTynDW0F78vd4Ur4vc
         tA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRaJMqGmZfwlX8q7hw27fN04puyU02jzBcvytBuhjA8XfSPk9Pi1hdKJwSX7Hb05GD2Mea6wOKFkZzBoywP5h7/Dt8a7RBWdPfVDWe
X-Gm-Message-State: AOJu0YxVVivYq3wV/0dUuwKNfBpFA36dLJ4cjr46vjegj/8eja0ehl5D
	rjipWl19WraFjhR/z4tXmqi1puDzKtiyEgPP5WzArLbnDgEMlEDQ+NXlJZxcTCA=
X-Google-Smtp-Source: AGHT+IHspqqnJENHVY5Mp3AXGRnutH8mgR3X58Qhy1uRyHnQBa09D+2nE+N56A7emHPuM682wEL0mQ==
X-Received: by 2002:a05:6000:c50:b0:367:8fee:443b with SMTP id ffacd0b85a97d-36b5d353925mr7510570f8f.41.1722353955544;
        Tue, 30 Jul 2024 08:39:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ccf2:71b3:8f46:e8cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857d5asm14952522f8f.84.2024.07.30.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:39:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] firmware: qcom: fix an efivars regression in qseecom
Date: Tue, 30 Jul 2024 17:38:47 +0200
Message-Id: <20240730-tzmem-efivars-fix-v1-0-bb78884810b5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAcJqWYC/x2MywqAIBAAf0X23IJpD+pXokPpWnvogUZE4r8nH
 YdhJkIgzxSgFxE83Rz42DOUhQCzTvtCyDYzKKkq2WqJ17vRhuT4nnxAxw/artG11Z2ZnYLcnT7
 b538OY0ofb9ZRrWMAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=842;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=g7se6oeZ5KLpRAANz/R9S2ovP5N22d6tZ6dgM6QNyEc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmqQkfr8s6RE2WchOtnngvxkSv7CJVeA8N2ajCe
 mwzPpS6zvuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZqkJHwAKCRARpy6gFHHX
 cqjnEADCbQY28LE4rlkQeeLG3BrjUkdamAuliLSmvUVHzSefg+fiT/nAifYj1CnKINDBQnu8gtq
 eJZo14HwouCdhp7HgO0lRFEYk2Y6S+bLOxotFbCvFFaAtVs9VJnP61dIr151EVTxzesDzmm/XBZ
 cXtfZ7xWnKK3ZoSS4o4nMkc8xWSxZAsIw55vmZTry9H7/6wRl/KF9n3WQ0/LAveZuOl7tsnLPvQ
 DKy5+4lUcU8EZqJQfL3JO8ZWFnnVv/VGuG2xAZwxb786R2OqTn8HU32APg+DG98B7EMD2d7S6he
 3JnQtjxXmoaKxujyD1rj2T48zvb/KkPNreSP7goGnB0iLTOaFHb8HhihsbXoK9zwlVg5F+Mrdwx
 i5+ainSA5YQUnwGXjdXpxSMr7TCqPo4OUcADxTtQQSwnlxFkDTKWMhSY1ba0K15ph0D+s5mTGs5
 8lctHhxp4/c+Nhg433o2vNqEMKeghRE0cjbNAiFs60/Eqai/R4/4bcW7hIpyk69WVXk6F09aZ35
 N5bY9en3T8GFAGw+4SEJwadqFUjZsZXjdM2yOZCdthVFYiN6oXXjeIBVgdBRSnhKLA5kktAqdd8
 FP97VFFhXTKm4luKJ9ay1k6+YD/K7jmwmmLRo6kzk6PijiFXnGREjceyQdfRzXIDU+ZRntya+Au
 D1HH/0kHkOfXiAQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

The first patch address the regression with efivars using the qseecom
driver reported by Johan Hovold. The second patch removed dead code that
was left over during the conversion of the qseecom driver to using
tzmeme.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (2):
      firmware: qcom: tzmem: fix virtual-to-physical address conversion
      firmware: qcom: qseecom: remove unused functions

 drivers/firmware/qcom/qcom_tzmem.c         | 21 ++++++++++----
 include/linux/firmware/qcom/qcom_qseecom.h | 45 ------------------------------
 2 files changed, 15 insertions(+), 51 deletions(-)
---
base-commit: 931a3b3bccc96e7708c82b30b2b5fa82dfd04890
change-id: 20240730-tzmem-efivars-fix-d9635d39cbf2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


