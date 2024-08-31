Return-Path: <linux-kernel+bounces-310018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A0C967324
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 21:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9911C210FD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949217BB34;
	Sat, 31 Aug 2024 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MXTSPoyr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3827524F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725133248; cv=none; b=dR8pGyF+6pWTiPdd+u7YrDgX5ln/pwASN5MF6c8/xRvsX6CB2WyCBq1+y7fHPJuLwJzliK3ZCRI/4e6JROea5m9Uozqk4kk5wP+R3S/BfldZo8RaUcEHgjOFFCcyC/UnDmumzKi/Q5z3V+Lc67CdV1258a0+szUcqam7TqvlTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725133248; c=relaxed/simple;
	bh=0zBqQcQWGQH6QT+Zs59gfm6nXvQOLfs6t1Z3jMdHjSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMhfhfSJmsBujypNY675xip1L+eRnuvabH8O23Xyxvg5QjZfukqxnGEexlWn3lNkKAoKXpA/o3eGc+nC0ttxqsjQGwDDlG4v4uJmv+AJKMG9M2dW/FGEimM8HspzCElXM7/KJjkLs/d//Y3AvZurl9Vmrb9L3rVRRsVnL5ClZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MXTSPoyr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c7a384b18so4781915e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 12:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725133244; x=1725738044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CtfmoH02/knNQfvPe1y43TpSI75G5Zoj3oZBNUmpzE=;
        b=MXTSPoyr92imhXo8QqorP8Tg1SrdVdBmlkVqFaDkhOMygnYk8wiRhF1XcXlw+uV56R
         CBTU87n/kJRikB+hiRfMbqbUORxdklARB71yA9DspeieVDzUxwyO7/tEpgdJITSeKR3p
         NIDNXBg8zF7X1kvix2Pst9wfXwaLDKP/Gff55y5rrKWKUq01+bIcdLsbN6tqp5rpCb2v
         p2MCAnVfsyDQBMzZ6v4fhZzjNqxHEQqQg0MjF33GsCJQQEGmbplRepfpMgSsHQAUx6F7
         frs/0pMb27tdp4VIH1U8cgfi6sZB7gLpjw6SVnHbN2YC1OEB50G2JlzoAaTUIfTRgHc6
         EeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725133244; x=1725738044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CtfmoH02/knNQfvPe1y43TpSI75G5Zoj3oZBNUmpzE=;
        b=TAzLzfO6o7zvtRncSpQAPxierlevsnPgux7Mu5lty6Zj9IIG2hLZQXqBEDvbShCZwe
         yTaYywG61B+DlHuL8KuRzgQy9n15q6XVQyYuc61i6tTqFdrlbEyZuXaeTPeoX7T7WKK3
         ZCQrSrPUDrxFRu3LMFWY//M/qzthTNPWLeyKFxXdZ9U4f7yqWbSBD1OiKiVmZhkS7gw4
         w6vckN4I/bDZRwGfv85dofI4SkUN/JFRLzgxjGssHPSjEJ7KwUQwT5Q41/g4nIay69mk
         8fWkZmpb5VGeWlhtgEQ6C4bTG2OGZYKWHyfy1RxNlscQAJPuNN2uIDTKu49RINsXMC/B
         fHSA==
X-Forwarded-Encrypted: i=1; AJvYcCXM97TtRFUA+6fesF1L7/O5E+dfrinwYzh7V8ranlg+cwbThm6TlMFimDWJ/v8kHeTBP97fMFF0DJ732Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvufVuuDmPv1zY/418wfrRt99QAcyZo9iIEKOZ24d2LVrwP2NL
	HzmZvpD7X+MKQhjphbHPV/AY41+8ErvJff4f2gcELWCRYnKOPAqqpqvUyBBhjRE=
X-Google-Smtp-Source: AGHT+IGMPsKGvi8ik9qWKFA0pPgByI5GVS4lUuTCFIOR8+o1o/wJszc9rxEhmR+5anMa6INMYGb15g==
X-Received: by 2002:a05:600c:4452:b0:428:1090:cfd4 with SMTP id 5b1f17b1804b1-42be48faa4emr19435215e9.33.1725133243464;
        Sat, 31 Aug 2024 12:40:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:48d1:4cac:fd8a:956c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df936dsm84597655e9.28.2024.08.31.12.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 12:40:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing fixes for v6.11-rc6
Date: Sat, 31 Aug 2024 21:40:38 +0200
Message-ID: <20240831194038.557316-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following follow-up fix for the power sequencing
subsystem. It turned out the previous fix for this driver was incomplete
and broke the WLAN support on some platforms. This addresses the issue.

Thanks,
Bartosz

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v6.11-rc6

for you to fetch changes up to d8b762070c3fde224f8b9ea3cf59bc41a5a3eb57:

  power: sequencing: qcom-wcn: set the wlan-enable GPIO to output (2024-08-31 21:32:19 +0200)

----------------------------------------------------------------
power sequencing fixes for v6.11-rc6

- set the direction of the wlan-enable GPIO to output after requesting
  it as-is

----------------------------------------------------------------
Bartosz Golaszewski (1):
      power: sequencing: qcom-wcn: set the wlan-enable GPIO to output

 drivers/power/sequencing/pwrseq-qcom-wcn.c | 7 +++++++
 1 file changed, 7 insertions(+)

