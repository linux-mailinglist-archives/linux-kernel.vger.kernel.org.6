Return-Path: <linux-kernel+bounces-410925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892479CF082
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3550F1F266AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3821D5AC9;
	Fri, 15 Nov 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UC3ExCUX"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DC847C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685143; cv=none; b=CA6gS2EC7azAJBOTS3Q0pshMb15lk/md2D9yHOj/P+XzkP+f2jl1++rHJjAL+aMPimT2XyW0BQhkb51zh/XiNiI2u6WSJmOZ4ZI3TYjfmgZr4QWa/qNev79sQBQuQqCFYaflxNW2eUxhsx/g3hoAPj9RiikbwktX/a+6BdQHs8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685143; c=relaxed/simple;
	bh=YZf9OjMF0rWfp7DJck4HJJphVfS4WuI+ybgguJI0DfE=;
	h=Date:Subject:CC:From:To:Message-ID; b=c8hIelhqISX5fO0FwZnELnhj+ghJhqolPdXdgyBQpRNIOLukGrg1eokDgG+mdp3ZzTfLJPVp3VUJ7xXBohURVox9xQ0iRFynIQGF3NMLQtD+dQNdbuSPDBflrt1bbbKoihCPaQHDOpSxKvs1s27+xL0m4MYW/X+vhdXMHqybbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UC3ExCUX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7edb6879196so1447220a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731685140; x=1732289940; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND7/dKOs1bs7dRKWzno0aqrE7dox+7Zrrq0GQ0dkX+4=;
        b=UC3ExCUXhDPk7fK81yK375JlVpKswcAQwB3yDmNVe+RfLH+GhIcx6gXvLrCPRl1/SS
         8nhKT3J9yLBM06GX8aJ6Xs47uWu1f57+X0On5HjhknO28zstEdITvn28qyxU9WF83/sU
         g7TBbL/jqb3gJ6ehP5VawmBLOEllqZ2RaeKjp+uEecKdHQe6ilIUVZteHpZkE6WXhZ0J
         wYz9nObbZs0e7UA3UragyswWUZnHF6mW2Y75O2D1aXf/7Fho/FYRLVYMk0QEul++T/q0
         ygoE/SiB646nJPecFvnJrnmvosq/jM0xG6sk+QRSlEyM6Q2ja9LerkK6GRmd3K0JMAql
         dqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685140; x=1732289940;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND7/dKOs1bs7dRKWzno0aqrE7dox+7Zrrq0GQ0dkX+4=;
        b=L2t04Rmw+OP/Yhid4JKlgIMIh7m2N65eg6b1/T4QX4e/6HMit9nOlp/ma87ks//48N
         fISQ+dWOcYJU232tWdH2bUAwU1RBuIOyw8X31KzNm/Jku6ZWkkybQ/740WncTicjnSal
         MvvgDIZJ0JK1/dnWJnwO8CBIfGxX93+zDNE2rBGUtXsxPUkTxVoVuPlV66NVjiQiL7HA
         ohTyCO40M+PngBYkrYcsla92oiqpuB8vQQVnOxubHHclg/qNMq+EhgR5RaX+Jvr/4+Lm
         l2YtbmDkdyYnV+rjg5sVmAElz7US6yrcvkw66Pee1gA9ONgUs9qB/MVbNK1gZj4WJhY+
         vPJA==
X-Forwarded-Encrypted: i=1; AJvYcCVKEqGxREypNfa5olMtr/9UdElt7coxBiO6Xj130/StEJck5WEJiEITWlRlp/MLJsGX2iz0XOUNA7KlZ0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBN+s83wjQqM3580M50O31aav5sRrdsl/FLEkHPw1kGdneZr1f
	dmVumDtVgUFFeMjzB2lKlVLuB9uFJAE+/Rt+1f3pUtpdvEiB1vWO/9UFum+URR0dfJWfwN8bYde
	a
X-Google-Smtp-Source: AGHT+IHmyajOc05t7LbFFeyz1KQSLtKrSNK6NRQQd7WDn0DudtcjHK4tw6yfgrqZidHenGBcNslnHQ==
X-Received: by 2002:a05:6a20:430f:b0:1db:f05f:55c1 with SMTP id adf61e73a8af0-1dc90be213emr3376469637.30.1731685140058;
        Fri, 15 Nov 2024 07:39:00 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724772001adsm1480640b3a.178.2024.11.15.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:38:59 -0800 (PST)
Date: Fri, 15 Nov 2024 07:38:59 -0800 (PST)
X-Google-Original-Date: Fri, 15 Nov 2024 07:38:57 PST (-0800)
Subject: [GIT PULL] A Single RISC-V Fix for 6.12-rc8
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-257c7a1f-aca6-48f9-b3ec-6a4673f8d33e@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.12-rc8

for you to fetch changes up to 57f7c7dc78cd09622b12920d92b40c1ce11b234e:

  drivers: perf: Fix wrong put_cpu() placement (2024-11-12 07:34:27 -0800)

----------------------------------------------------------------
A Single RISC-V Fix for 6.12-rc8

* A fix for the CPU perf driver that avoids leaking CPU ID references on
  systems without snapshot support.

----------------------------------------------------------------
Alexandre Ghiti (1):
      drivers: perf: Fix wrong put_cpu() placement

 drivers/perf/riscv_pmu_sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

