Return-Path: <linux-kernel+bounces-377080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F299AB99C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDEB28479E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F611CDFD1;
	Tue, 22 Oct 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0bGF+HB"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C11C8FCF;
	Tue, 22 Oct 2024 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637352; cv=none; b=pRWdqxBfjye4LralLrmYBZZ8ezENUZVkOoVTMsBlw5saxSA976NqRXI6uP194ATVZaHc5o8BgyTpkca+cncymI0eFLn1T/Xj+UKG6+irwlxh/6eMxCWl0g86ectcv4UuBd9J1WIyVWbH9v7xy94hVkhzOIADXysCrOIXzN2DwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637352; c=relaxed/simple;
	bh=itz1PosXXxDzCVp3LLVXnsJCcW1EmeiHBwbSYfzPbMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLbK1+i04YLxefsQThTKXKjeVCpxhmGfgyowg+5qyRyDTPB6VgheRgK36GxVnFz1mq4amhWcM174u0h/6+vhYpu7BRhDu+Yi17t0pT8USpcPMqDeUXzr1KE0NKreyN/ldXDApO2qddJ8axOBLXzbiPraZJSSW6UreEzlGWOJJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0bGF+HB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso6269740e87.2;
        Tue, 22 Oct 2024 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637349; x=1730242149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUHN0XnjaQQ8Lenc9CGKPJM3f0XauY2Hf0U+mcSQ1OE=;
        b=i0bGF+HBAaq3Y65f7iH2ipNRmDqV4Pb4ARD5KHzENiQDsE9L5JgdTVZv+xpjQoGga1
         16HQgBB5AO/s5+8YpfnrmC3k71tjVQ0HCYJBsz/6xwxj5wSziATPsIqQTuTGjxi9ky7T
         cD8CDRh6cokAt2w/7c/jZtpr8+Ad8U09D4s3A2EFsLCxy3jyQDBfnejuF2HNo+4SsvDv
         v4467U5+2wIXIZSKe/fMWAL7SbGvP5iwuBHd0YwTDc+/6OnAnQk6pWdvjSL/hj033ed9
         p7zeEHbeHgLD/yq4K2SiGQqsa2c0+sj2TjuC9QeISNaL0TYV5L8qzm6Vji0ZpSP2xIGw
         FUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637349; x=1730242149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUHN0XnjaQQ8Lenc9CGKPJM3f0XauY2Hf0U+mcSQ1OE=;
        b=AjYIInxyhwV+vfFPlbwuc6XyRMJkZBOKIlavrwMF9lIO39hftkelJLFt6lY3YVeYFF
         cE7cqsWw8UU7hdZw+OXGUwgNbhyQTZTh7ZI8F/1eq0ut/TQ4yOc4hIe+09UuaOmOqquK
         lXhXZJ//cjQnLxLBw4hGkkEQghSlO5RWF8TcuXFVYYtqs1ojPYaYf/hxjyQLftcnczTJ
         Vw3WhxiOjIjKVxHggx4/jJ1Fb+FKgartz1X/sM3eImMsFu9+Z6sE2IKVAdBnYMV0lHdL
         NNFKKTPA+lN1rU1kv+Zngxo4dCSnrf7nZTEHL4TvAfPYxspCRxfQu/Z4KQNiziVVB1QZ
         bUpw==
X-Forwarded-Encrypted: i=1; AJvYcCWEEetbFhESx/gyuN3aAWWr3PVvnz+mM8R7JX0OyUTyeK56ghA5qSQ9MVHna4z5RvNkUXxrgOWEAu4IHwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxseNRNarxwSYzqrjeoH+kKB1kgt03Z/qsCkKQKmGbe8quD64Tn
	iCoxsIOlPchOEirm0HO8wfVAXUeI/ZD6/TayAlwJYlt6j5KC+UPxjfoEDA==
X-Google-Smtp-Source: AGHT+IHJ/lPGoSVtaI/AxWlHv5OntgpiNOCFAsPJhbhs5Hxdf+5yokUO5fw32NKbhZTZfiWwzMslFA==
X-Received: by 2002:a05:6512:114f:b0:539:88f7:d3c4 with SMTP id 2adb3069b0e04-53b1a328277mr207712e87.29.1729637348163;
        Tue, 22 Oct 2024 15:49:08 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e595csm894881e87.14.2024.10.22.15.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:49:06 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v2 0/5] Introduce Owned type and Ownable trait (was: "rust: page: Add support for vmalloc_to_page")
Date: Wed, 23 Oct 2024 01:44:44 +0300
Message-ID: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series introduces the Owned type and Ownable trait which is the v2 of
"rust: page: Add support for vmalloc_to_page" [0]. This series includes changes
for firmware as well to make use of the new wrapper.

Changes since v2:
- Use Owned and Ownable types for constructing Page as suggested in [1]
  instad of using ptr::read().

[0] https://lore.kernel.org/rust-for-linux/20241007202752.3096472-1-abdiel.janulgue@gmail.com/
[1] https://lore.kernel.org/rust-for-linux/ZwUYmunVpzpexGV8@boqun-archlinux/

Abdiel Janulgue (5):
  rust: types: add `Owned` type and `Ownable` trait
  rust: page: Make ownership of the page pointer explicit.
  rust: page: Extend support to vmalloc_to_page
  rust: page: Add page_slice_to_page
  rust: firmware: implement `Ownable` for Firmware

 rust/kernel/firmware.rs |  31 ++++++-----
 rust/kernel/page.rs     | 116 +++++++++++++++++++++++++++++++++++-----
 rust/kernel/types.rs    |  62 +++++++++++++++++++++
 3 files changed, 184 insertions(+), 25 deletions(-)


base-commit: 15541c9263ce34ff95a06bc68f45d9bc5c990bcd
-- 
2.43.0


