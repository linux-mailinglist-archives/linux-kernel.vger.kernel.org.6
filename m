Return-Path: <linux-kernel+bounces-377953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE419AC8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8321C210B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110141AAE25;
	Wed, 23 Oct 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKhDO0eq"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09BC145B1B;
	Wed, 23 Oct 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683246; cv=none; b=CaG1F+H8HEymxXS8QBdsN/ly3PPYlWNEI9vWuA17oJn/UNnnY20tyu+vWI1hw22eSZUqUC6XmKI6v7ha1ykN2gJIndbtEpWKMSypdZu9ITIeVl9NP38B1ByLEZbvWa75+5jlltXiDj7dgqIVke8+xJhlFpNnQbuGpmzDZYrCeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683246; c=relaxed/simple;
	bh=6ekIhr6LIRQoiqBNm39lVH2whzKUguM4E8G0SKHwOjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMJgo5kib7uToPRJNXa3a1zW5lCX1zYS5ssliDZhsOggr40MavmdHf4OupFiJk/k3/BKu//J3GJKvODK7CSnW847H5ksHjTBj4LmOIJcG2eI6HllGFsa0b34bTKwZElyuMmcyD7ZEQ1H19aF0dNIDTINSJHZ0oDOFlwQQ7weSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKhDO0eq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539ee1acb86so5039440e87.0;
        Wed, 23 Oct 2024 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729683243; x=1730288043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1UjQBMNm7fCJHZ5GrQYk9mjiccdMOgKswvtQC1VZ0U=;
        b=iKhDO0eqKzc+4ixiWno6O9rUJ9C6M9x+oQ7KoEyJyGNI0Q6cmEPEnn+2biEH7UrSeM
         NaL2KUKsigfGfookNpvRmCTNiekq6hfuqxa58p50e/L9skDJv1qAUNLrOUFvlHIxqg2l
         pZnwkBr9a1y6wWtQSlYV+/5j2ukS6yRpv3kEq1N9nhVQ+GKd2NomQ9/6PJCXbTYn6ZbP
         1hel5ygUtI+nHvzaUf3xCmSqJP/PL4thyoFp47LcYZ2bwUjVoeI3HeyK45OiAkNyIrIn
         Yh1xOkJOREJKc9lqxwgkkviKOJw0bBM1HVIgPxa0tt2WedgSzEkua1ls5N9FChIMckUP
         1+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729683243; x=1730288043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1UjQBMNm7fCJHZ5GrQYk9mjiccdMOgKswvtQC1VZ0U=;
        b=F57t4ty7K7Lpj828OnlRnTnuH3HIOwV1rcMMp+RdsF4Lxnqv1TA5KVoBhkpxSzLOvF
         6TnJlPoLxRBRb/FBGnRxwkO9gjTYydYdna21lySZDYcWB8ZGI3uFWMltTL18McgBylr4
         ic+P85Kgq3xxd48IskRXHRQKdyUhXtKXb/2QCpe2OJSeldFLOdfMWc1dUS+hJzOGFtCr
         FpcNdpsKVgWoh9lwS007FKWtXybY3ff2tC1PRab9Ql1aJ3+6Bg61+vUAwZcu8UyPfHsq
         1NfZE6qjHqQbAAQp3bRL2JE6o2fvhSXLH11L2OM0n3SWxvtdaQ0vV37eMBlte3XNLk1m
         XxDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6To2fGooYrZiI8xG+jWPRmDKfjtcs4SnKwN9R+/BzrzovPmmRhHSFGSegyDZsjeZH4yiBNOIfSzY75qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLWzcndW4kT+w/U8hno+7N25baUXue317KRMDzwdqDlt7in6o
	AsP0GX5vy3CrBULiwyGxL+BT1J9vnK2Wci8DSpa6b5ob3PBD8ZS9YyPSAw==
X-Google-Smtp-Source: AGHT+IFbOlLK48PExhhHxRYQG5J/MleXz68mjZXyQ9bAK0Ab++/QpPHn3LzqVFdZyj7sv9gY4PtHYA==
X-Received: by 2002:a05:6512:31c1:b0:52b:de5b:1b30 with SMTP id 2adb3069b0e04-53b1a36196amr1146252e87.44.1729683242539;
        Wed, 23 Oct 2024 04:34:02 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243ed31sm1029769e87.254.2024.10.23.04.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:34:01 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: a.hindborg@kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 0/2] Add dma coherent allocator abstraction
Date: Wed, 23 Oct 2024 14:32:49 +0300
Message-ID: <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the dma coherent allocator. This is based
on code developed by Andreas Hindborg for the rnvme driver. We adapted
this for basic use in the Nova driver to access the GSP via DMA [0].

[0] https://gitlab.freedesktop.org/abj/nova-drm

Abdiel Janulgue (2):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.

 rust/kernel/dma.rs   | 153 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/error.rs |   1 +
 rust/kernel/lib.rs   |   1 +
 3 files changed, 155 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: 15541c9263ce34ff95a06bc68f45d9bc5c990bcd
-- 
2.43.0


