Return-Path: <linux-kernel+bounces-215400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D72909233
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351521C22DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AD219D07D;
	Fri, 14 Jun 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YW2pxOYc"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458A2CCD0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389440; cv=none; b=eHLo//5CBsV5RmfC6reC7nUWq6cFruDZC25cFTrYPrEXECSvIM/vF2zFxUE1Tm5cV30b213Y8XaV3RxnZE/Y16zBBo88rh71jxjq7n9tKlmyotoNVWIoLPH35TPdbScjwxwPU/ISrT7XDn/FcRSji0G4EcXr7abcenL1keCoSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389440; c=relaxed/simple;
	bh=T9Lemwfn1DLC+FC//MnJvqr6mTgC0I5LdcfhGplrckE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULjKIV86UFkltcbzlKmuamqs8t1MUFyi1SqF3OfhaHkXwCMmiuKm44gP3CzDLla/WMPp4zHNEUdeE+A6O0GvRxR4dkPVOgPrsukbiokUXTJOiEeaGOEPT7BmDQ3MmVrJ2ZY2fl//Nyb1Ao5USZJ4ecIZjrEDKKRutbFnZ7+t/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YW2pxOYc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1840278a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718389438; x=1718994238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZn50d8R/xT+6kVKruGSleyZqMbn5U8/mQpLLULuLpU=;
        b=YW2pxOYcTnjDFBNrmFi5CmJ2R1uZVzwY9BXuEswfKAfiWOPaP32xZ5tU/OHaj53Psv
         S7WbtLNZY48l65KTbN14dhSCLhYmcGGPUFM2jpmM6DYPS5p62NuMSazwk46esy6SK1sJ
         BSI1sSCGEjtogOjVee8PAATcLhMFPvwTlWgWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718389438; x=1718994238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZn50d8R/xT+6kVKruGSleyZqMbn5U8/mQpLLULuLpU=;
        b=UBaNDnB+Z1eUjOmgZhYIIzB74esZUiQ5/TuY26BXzGppFaiE0242ZsvSM181Z1G60b
         1Zt2gv6t9afa40Bh9v27mBP5S24ECJC+sWhwQsL/kmzwdFxuRRGBlAJF0ClGJea/ruPo
         60zx1SLVhNcDo+EE5ybYsVNhE0pCzYxoU+ZsBUzl31YKW7qo04mwsilBhxvBUnZZqxF6
         9+WZhQsrLHCERCtvGefFZf6Evmgg1VwBNDf7up7xZhHHs6lpMVC0pqb3mmkWRGhScvP9
         mewoIvbZz2oG1btvUa7E06xRIYogUJvjlLYBlIkGvAK6BWx32yW/F3oWfr0P5RtaJBpe
         qhtw==
X-Gm-Message-State: AOJu0Yx63AAeclTBwsQInchy6VukY56jb9/aVfJI5JwYpJvb6ONiFFYI
	yAnVQ3kLFgTctGiZcwhoiY3LXp+mWVPudAisxgoNikCDqX4wdHWWs3SeZb8l3w==
X-Google-Smtp-Source: AGHT+IHEEim3bmh4/sD50G3DI5iFGIOyghrjMg4i8a0ncmlm0TwXaT/62REOeJ0qTU8r05Cp5Xrgyg==
X-Received: by 2002:a17:902:e546:b0:1f8:3b7c:dff6 with SMTP id d9443c01a7336-1f862a0ab3bmr36880735ad.65.1718389437750;
        Fri, 14 Jun 2024 11:23:57 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f855f394desm35130775ad.266.2024.06.14.11.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 11:23:57 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	jannh@google.com,
	sroettger@google.com,
	rdunlap@infradead.org,
	david@redhat.com,
	adhemerval.zanella@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 0/1] add mseal to /proc/pid/smaps
Date: Fri, 14 Jun 2024 18:23:26 +0000
Message-ID: <20240614182327.752156-1-jeffxu@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add mseal information in /proc/pid/smaps to indicate the VMA is sealed.

I appreicate Adhemerval Zanella Netto to bring this to my attention. [1]

[1] https://public-inbox.org/libc-alpha/743ac2ce-817b-42ef-a0a1-7edf9a85d8e5@linaro.org/#t


Jeff Xu (1):
  /proc/pid/smaps: add mseal info for vma

 Documentation/filesystems/proc.rst | 1 +
 fs/proc/task_mmu.c                 | 3 +++
 include/linux/mm.h                 | 5 +++++
 mm/internal.h                      | 5 -----
 4 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.45.2.627.g7a2c4fd464-goog


