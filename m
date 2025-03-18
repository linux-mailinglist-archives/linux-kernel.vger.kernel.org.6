Return-Path: <linux-kernel+bounces-565532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C32A66A30
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444D13BB738
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419271BC099;
	Tue, 18 Mar 2025 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Yyh/1FZj"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F128EB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278520; cv=none; b=UNnmBG3IrYcG2cJYqbTFVdmWGeYw+tSvv623qY8atZbAf5H6RX4oQcwONuYx+AOW+T7Zvq6yQx+CmviwKGwQA6u4hODVxClieUOD+q2Wcc8qO002E/75PktcXtqV/Te0/Rkb11/dq9q3Hd3i/CQ+xpiJOZrNma8x/GsT+4eaR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278520; c=relaxed/simple;
	bh=uz2c8MaUMixuzqHU/0PW3hRT9ifZlHzEdlwQmqA4cAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ObaDjV07TrHkKT7K/xOSAGfSF5jRgCgGy5lM+JYd4idQIh+FyhyVYcCFtG7NmtKkbB/Y1sFlHKHhQCQ4Ah53zQk117zqvifqu3OXft7K6Y29N6SAt3KoSDbFAarpikkuJm/GZ6E5ViT/TfnkRnof6J8Q9K60CWG85qn9ebdMItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Yyh/1FZj; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f682a2c3c8so3019292b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742278516; x=1742883316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwppuJlAFjDRGZBTGAcU3W99FXz7w1ciVwQO9dUzifk=;
        b=Yyh/1FZjR64q+mu0cTSOTuVmYh1aEq3TDfeTOmvw2WiaJI4PbtkIPFAtGUuVg2y72R
         pBg1nGNpKmC6uctJNBaR6R84sXGaKhe50PhuKVd8rVr20tcYXObx6pSQvmMYH/NAnzHF
         Mp6e4vHeGrEO8JEDPrkOfUkB0NhhsEh1HiUPJ73+gr1s5a/To9NUuX+Zo5LowCvGQ9oD
         DGRTa5pTX7SGqXQkNZVWeFZt5JBpSv5lUvfduwd76/pqkSEHX0vD/KsevY4lh/0Z4Yni
         1jU0E74iZ9WTjspfbQ3oHvm2xFFbAbcRfxE4xVFNbkv4ku1EOBIfy8si7gyQYkJnotve
         +n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742278516; x=1742883316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwppuJlAFjDRGZBTGAcU3W99FXz7w1ciVwQO9dUzifk=;
        b=YAYOr745Z9ahXds7QNtw/7aUilRrou8J+rJ4CByIfXmgqsd1A8aeUNg/Qi5IaYuRbq
         jA8woyQ1S9SE/aCTuaozwcYdrbFdhjdqsyPKMNdzFmThb/Q8kiwOkJRmB+EwIPMTv5P0
         bf/6tVGMxlU0ffRqtG8TwB2RpQGWo9qNEaWhccM0ceP5y2g7E6eJd/csLkk6tNKKuEgS
         hVBNGBfRW61Cww7IzrbY96u4jru4jrAD5Jm40GZxpl1q6LkDUq4hmbWGJ6TJHXvBcXU5
         bMFd/7is7a/lnKjIR51qzCEUymufnOf4FNOlKkRZoTDy/r0oOEG676H0kEmhqH+im/Pt
         IuKA==
X-Forwarded-Encrypted: i=1; AJvYcCWyu1Q9gWtJZrwHiIPd3xjM0y45TjA65p6dKILooeNeGGfrUrnb/sdi1J35weTwpxs1Jahfj3hgQhkxOLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVNMA1mgwZ6ZD1bocsfaYK2PD4+a+iq2OQOsVWrZCZxWaLYQd
	1o2okLg5XabN4rirNRjvgQuPmdbway/L/L2xiAmdexEZIQzn7XFRhAGiHkqVkQ==
X-Gm-Gg: ASbGncsx/LyzaTHUJL/cmRp8nhyWLiMWELRi9+UGUG+tMbr8Qo7UBDA+kRuLcaPus+H
	uUp0yMsh+Kp3zN//AT3k3MX7bQri8gZt71WLrO2Ib+jVlz2tiMHUbG5kXfX1NP+DesDcNsOZDxp
	jLRkDRdi+e6gJHkEUdyLtjmGqpuCBxOtGzlhxOaQtfPUFFgLIRNbtqZW+ikT+PEsd0rfQ83r4DB
	rvi/VnFmGLH1+T3GVIFrj7QiiKNLl0/9ce0/mSlviNfSwyqUnFd4FLzASJXt4E0gsG+Z0jo7pmR
	XtG0ufx96vO2YCCEywnsuLlGiBUYmOunIIVWVr3mbYexT7Xg1jy9JwN8PbI2s/I=
X-Google-Smtp-Source: AGHT+IEvs1FoNC6R/cXbhA/3oJJADjGI8dDrbJPGZmXUNHn72DZqatIY1VucAS4DD9EA3K5vofASig==
X-Received: by 2002:a05:6808:1a1c:b0:3f6:a6a8:d340 with SMTP id 5614622812f47-3fdee930e72mr6839018b6e.16.1742278516340;
        Mon, 17 Mar 2025 23:15:16 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd403b882sm2051642b6e.8.2025.03.17.23.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:15:15 -0700 (PDT)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org
Subject: [PATCH v4 0/5] riscv: uaccess: optimizations
Date: Tue, 18 Mar 2025 06:15:09 +0000
Message-Id: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series tries to optimize riscv uaccess by allowing the use of
user_access_begin() and user_access_end() which permits grouping user accesses
and avoiding the CSR write penalty for each access.

The error path can also be optimised using asm goto which patches 3 and 4
achieve. This will speed up jumping to labels by avoiding the need of an
intermediary error type variable within the uaccess macros

I did read the discussion this series generated. It isn't clear to me
which direction to take the patches, if any.

V2:
I've taken on this series as there isn't any response from Jisheng. No
significant changes other than build fixes.
- Fixes build breakage in patch 3 to do with not having used 'goto' keyword.
- Fixes build breakage in patch 4 on 32bit not having delcared __ptr in the
  macro.

V3:
Significant commit message rewrites.
 - Corrected the justification for patch 2
 - Better explained/justified patches 3 and 4
Minor code changes for legibility and more comments

V4:
Fixed checkpatch errors
Added a unsafe_copy_from_user()
Added patch from Ben Dooks to save SR_SUM bit on switch

Ben Dooks (1):
  riscv: save the SR_SUM status over switches

Jisheng Zhang (4):
  riscv: implement user_access_begin() and families
  riscv: uaccess: use input constraints for ptr of __put_user()
  riscv: uaccess: use 'asm goto' for put_user()
  riscv: uaccess: use 'asm_goto_output' for get_user()

 arch/riscv/include/asm/processor.h |   1 +
 arch/riscv/include/asm/uaccess.h   | 218 ++++++++++++++++++++++-------
 arch/riscv/kernel/asm-offsets.c    |   5 +
 arch/riscv/kernel/entry.S          |   8 ++
 4 files changed, 179 insertions(+), 53 deletions(-)

-- 
2.34.1


