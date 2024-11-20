Return-Path: <linux-kernel+bounces-416098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8029D403A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375B31F222AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2B3153814;
	Wed, 20 Nov 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvAeQaUq"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580D749C;
	Wed, 20 Nov 2024 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120779; cv=none; b=FJS2fGb73H1CQYtFUkhyrc9m1P7yFHZSB76TGaXfbXYiw3ZxIKr4BlCUW2nkSiCp9lh9aJjjlMZZb/mg8OayyVLISzmsutoSY589fjeWYOiJUXZ7rrxfwNjBGMOqnTGcKFe5qNKVc8rrdcfAwFm4Mr1AX2Ixy84vpjkOXa6KoXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120779; c=relaxed/simple;
	bh=BsIa+RgaLPKa5bAxbkQ1STBnEtdx6f/7oQ0Otk+B8Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSqh3ebVbteS6zVPyim0KPkY02QDiMlhOcHZd6aU8+LorY5OszXdk66o1+IOxwuP1wKcUtGDfdLbvER8+mmsOn+AYwMO3C3C9oIOAzvSrNwsET7pmCbNXnz0JrE+NRTJWX+4rI6Z/5gPNLNsZO0KcObvPqnIWUQQlkE1T4AE//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvAeQaUq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-72483f6e2f3so916850b3a.1;
        Wed, 20 Nov 2024 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732120777; x=1732725577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAUwlthhsrI+QxNOIY7hNomh5JBQhjmQBWtieudrhVg=;
        b=JvAeQaUq2NLPVkfW71DcLHYun9lcKyWDz1+h6Bsky1YR2u205cY9IzlKEXrhiihi0C
         XoLEurP841Y43urjYCor3E5h25rwvaZLWjoLWdY+IcgIxToWXPGCFcXES3+QzsbsaggR
         MwEufknnQ05DzYQ2thKLw3De552GEDEz5odyJYcaa+6DYZ/yt1YHGKPhOQJ7cHEqqFC0
         1JWebkcJSbsHuvzLW0KAF+D9ne7ayYS9I3DRsJMb/qKN0yScZPO5v66HORD0Q1TWbhGL
         mQJlcFIfX4BaubklBQWfN9j332m8K4q9PQxCkpacb4syizfZvR+bJlkZrH0+gEUBIcwj
         hogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120777; x=1732725577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAUwlthhsrI+QxNOIY7hNomh5JBQhjmQBWtieudrhVg=;
        b=C/ILeGG3wSFxQuu/gkcer7XZk3sZh3WcBKgAa0jMIpcJ+9Hj+oXFlGKqZwNsN0MGRg
         JJ76tYckdeBzYx7iGK+WXTe9k6IYVztVgY+rdI5sHrlXx+0VskkPXp4G5ucvxf3n5O07
         Fv0cOsFm1Gvyvv4fIWJd1LgKWvqBrV5TNUwPqIkGz3PZrjwTMRjy9adE5Dhtx+kOkj1Q
         tG6/6lSgo+KOIZJiDVcMMSQ922xIcTz5x7cql+v/dTQdkZyLx62ytoHGNgdyFMZyNr2X
         dk6YHyiLDaRkYFYUi5QTR+IYqXMMHMuSlXH+ZTLcns18EiFQ3Yt09Tx1oo7M/BbbceSv
         jhHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5BFkxDqX+q5WnqVi9LtNnNRZmpwXlGEjkCsUEk6iQIRTN649wUybsvPgiOLSBYjz910UPoW6XlvNYi8MfX8a3BL1wEQ==@vger.kernel.org, AJvYcCXiQSV0SNE6tiv5mFNpEFmzDL3kRq6MjjI5jYJ+wfnIjWzpKqxkoD1OWslvvSRTvSyVf44N6nttNJA8MDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4a44IP1Mr/Gj2uyJc4Z1nXyzrr2v3LWrEJQvNiCHSc34kHQfy
	BWIIwFp4046a3+lUeMhVpN3xLEWSpABZJs7w6j0xOJHbPPQhZVZB
X-Google-Smtp-Source: AGHT+IHHtFpi8o5Bm0xSkzaHeuFqDgQowwYXmMwUDAN8o/XELlMVq1TRzHOKcUsgeTK0wChjShhODg==
X-Received: by 2002:a05:6a00:1393:b0:724:67c6:99de with SMTP id d2e1a72fcca58-724af97a50amr13747289b3a.12.1732120777067;
        Wed, 20 Nov 2024 08:39:37 -0800 (PST)
Received: from localhost.localdomain ([181.84.94.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befac939sm1845981b3a.163.2024.11.20.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:39:36 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH v2 0/4] alienware-wmi: Improvements
Date: Wed, 20 Nov 2024 13:38:36 -0300
Message-ID: <20241120163834.6446-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I want to migrate this driver to the new WMI interface. These are some
improvements I figured I should send beforehand.

I made everything on top of pdx86/for-next because I think they are not
fixes, just improvements. Check individual patches for more details.

Regards,
Kurt

---
v2:
 - Dropped patch 4/5 bacause it's empty after changes
 - Changed patch order:
    1 -> 3
    2 -> 4
    3 -> 1
    5 -> 2
---
Kurt Borja (4):
  alienware-wmi: Migrate to device managed resources
  alienware-wmi: Improves sysfs groups creation
  alienware-wmi: Simplify platform device creation
  alienware-wmi: Remove unnecessary check at module exit

 drivers/platform/x86/dell/alienware-wmi.c | 186 ++++++++--------------
 1 file changed, 62 insertions(+), 124 deletions(-)

-- 
2.47.0


