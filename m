Return-Path: <linux-kernel+bounces-319253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FF396F9BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5595A1C21CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898711D4606;
	Fri,  6 Sep 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6U1S6Ej"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AC1D3620
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642426; cv=none; b=dEjOJAtTFKv3jb8IAHj4GwvJj0LDVudVpNAV3Xx/SGvdjuL05uInjRFsKmRKQv4RBFLcRLufvHJQ+9VUGa7xGIg7UDeaCNquIn6YN2fm/JOe5AiddfQSl/lAv5W5vvsjHdW+XCReSlGVJskKnLvU2WfT6W97BaqzIuvw9y83R/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642426; c=relaxed/simple;
	bh=c/wFplKjGeoEW8s6yT+hTQd/xCooij82y3QwuPFojJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwsDffmrzOO+wpTUSyW+TA9rQYcOU4xBAFTpdCrGYioANOZGXCxf/3WjNi9SAXkqSub8EuHoeBmCrHpWmotC3a9QUYkMgNKeVRAo1ysVkh0qBGJARJps+Z5E47zOMKKpwADAUOVcOSUphYLaTbPGErounnCwL9h6da2UjCgKyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6U1S6Ej; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20551eeba95so23347875ad.2;
        Fri, 06 Sep 2024 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725642424; x=1726247224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGRYx+Z/60K8I4cTktkF9rBnE5w/ipry+Qd9MExXW8M=;
        b=c6U1S6EjyGW2tpywQCKqwUPHhm4ffcxC7pR/Evsu7U39kH7tFZZmHLD3Ns5SM48mb7
         lxmCdqg3GILNeIQCxiMfxFyLoLjAY6mvS82Rw+TG3RYRDRC/7z/bgtfS7NbnEPb215a7
         iXPwSAhRxe6AQf6QUZJuek/CszcCI4VESV+X06bi586sBbpYL0NYEwCnmkavNIUvvdOO
         QPspbnvdMebjwV5kTRe+BeBEWQF4eb3QnJdjZ+jgwS3qdhNb5duxVeATir2zpBivGhnI
         3pTNqLAqNQrJ4W/K8d1IbPEWiGpR6+ZKFG0XDvrU9+G19rdzz8JrfqcecnoG5Q+82tI3
         LC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725642424; x=1726247224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGRYx+Z/60K8I4cTktkF9rBnE5w/ipry+Qd9MExXW8M=;
        b=nd4aMIjC9Kd4RIgUA7/vWuCOEBRCKie1j14x+umlqZliMtVA1H5UjRO4SEl+mYdoep
         +S38/GA03PUZCKws+UfSBMyX7roYMeltS2HpcX6eytWmh1eBzVTmeRZEowJp8EJtViXH
         /gmOoGTihIHUTJP7BF1W1uCQMTMPyzzyEuFTQ3GRsk1FNR6nLNWY44F8U+xQ2127MNxB
         UEVvtZbQ1H2/Rg9sBa0nSm3IPED7krqXAydmgTWsag5p2TqBzrK56rJS3v+sfx9cWswK
         EBsIjvYfxPniL9uV3UeX0n2No6yjXvcdBySSa04a1BuqcJjj1+1OMivVLAZPj/sQXxX7
         UsgA==
X-Forwarded-Encrypted: i=1; AJvYcCXVd1q/ci9S0XGsudBVI0cZZmUlZdRsuNBQnt23nZYy0hBJj8cuBmTN3w63Y1sH+wuddKDhejfM35z0Di8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmZiqNmkXHKlrVHaVvWwqaZlyzubt2qvI0gnwp8hYBLwWurd+
	pTztEqy63slE0OvUZcS8bgRyRwyEIxY3rz7l8hER6bm44YsnmUGY
X-Google-Smtp-Source: AGHT+IGYxo6SZ92DwzJI7kuPsy/xXiG+Um3ZAD+zN75W/LaCZPp/7Zlz+42nZa9ahtMv7POc6dj3Sg==
X-Received: by 2002:a17:902:e885:b0:206:c675:66d5 with SMTP id d9443c01a7336-206f04e1e90mr35877335ad.15.1725642423732;
        Fri, 06 Sep 2024 10:07:03 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae965b58sm45317185ad.118.2024.09.06.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 10:07:03 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: asahi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/2] Disable 32-bit EL0 for Apple A10(X), T2
Date: Sat,  7 Sep 2024 00:59:37 +0800
Message-ID: <20240906170648.323759-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Apple's A10(X), T2 SoCs consists of pairs of performance and efficiency
cores. However, only one of the core types may be active at a given time,
and to software, it appears as logical cores that could switch between
P-mode and E-mode, depending on the p-state.

Unforunately, only the performance cores can execute 32-bit EL0. To
software, this results in logical cores that lose ability to execute
32-bit EL0 when the p-state is below a certain value.

Since these CPU cores only supported 16K pages, many AArch32
executables will not run anyways. This series disables 32-bit EL0 for
these SoCs.

Nick Chan

---

Nick Chan (2):
  arm64: cputype: Add CPU types for A7-A11, T2 SoCs
  arm64: cpufeature: Pretend that Apple A10(X), T2 does not support
    32-bit EL0

 arch/arm64/include/asm/cputype.h | 42 +++++++++++++++++++++++---------
 arch/arm64/kernel/cpufeature.c   | 25 +++++++++++++++++++
 2 files changed, 55 insertions(+), 12 deletions(-)


base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.46.0


