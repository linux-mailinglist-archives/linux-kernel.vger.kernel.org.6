Return-Path: <linux-kernel+bounces-275088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB975948084
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD9D1F239DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0916BE17;
	Mon,  5 Aug 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="egrvSP7L"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18D16BE19
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879508; cv=none; b=ueC3MABWT3Pui+0sDwgfIv8d+HWcE5CkvR0iAOW+XhibHUE0K4ZNGK2X362RyCVsrVx9JLd0PDG/a4ghBYwGVzlzc2VBpq1IPV1hGrWPRKp69JVG9GPbvyjKWZId4939hZhPJ58qK6iziWE4YXZMkMf66oU93DP5hgVlP9LCzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879508; c=relaxed/simple;
	bh=ik8EI0eu3P6stBq1q1xB5IG4bhoSIH/gjP7dkCDbQdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utChYiVfCFYazna4dLfszE+pnT20HrM/axlmXXrST3lBibBavHWHeW/ScToCBH+9NRZla+Ln8zooWkkA4Rz8tAkHysWOfmrPWiuc38LmgPT/XSkN875GKFwnx2r/zmlfdgeFwmkPhw3uhxww+GuPvvIwGbS64Jc15aB3xip3h1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=egrvSP7L; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd69e44596so42708565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722879506; x=1723484306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZkU76SoGtSfmnwPfEEw88qwH45x7O9KVsPVc+U7f04=;
        b=egrvSP7LRcv4U55hUov6FgQTBhehfu39bfQVH775NHIHJmROMyJQT6nQ4SfX3aNZL6
         6u74HD6qv6w3dXun7jTztfHH7ib898FPshP5SGV5NLNFB6Lkyd3ie7pMWuIYEQRt00Zu
         8fc5RPjKUqVOAklXaHUtKjjugDqDb4SaXt0lPJTAw3GweEI4jBWJTOF+etM4tUmpRDcq
         QgijJVhV14CEGR0pPh9pJUlyoAYy/iT9dMQ3HV09qdM6IVSQxLyneby17EqInG9tzz3p
         HjG81Xlc1/6tLTEmnjc/h83P3/S9ZOYc2I1iN8+TUiYhxJ+8v+JnLLOd7vOvYFEecZmm
         JOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879506; x=1723484306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZkU76SoGtSfmnwPfEEw88qwH45x7O9KVsPVc+U7f04=;
        b=wO1f2fYGbUXddO5DYOwVDugghRIj4PNaOHAmjZt1ncNjiAKFCpVp72ne8/jPznQb1P
         ScKPYhQtLiKp5N36KBias7cdglH0+nFUyo+LmsGxTaONXqi9MP0odn3uiukq5qakhIRp
         8vKQCot5HnTO4oLSQsA7XownIyB0OHCZV/j4CAs4b7hIrsGVdJOAm1SMcic2GRjfDwk4
         5ENDWu2Tw48DhVBMIsPBD7rKhd9GfMqbB43ueJETYqAJ6ydsxaYlo0++iWocTspqZ6VS
         3wQI/UV/VOlC7qMfx7QmDVGjNwn3epAn/GAPzeWmlgIfbMoxi0BhPQwAm8m5wt4yCDHU
         fN7A==
X-Forwarded-Encrypted: i=1; AJvYcCVwbjBV1jLKABfUobGmLq8lZIvZqII800OMlbbdyCgf4Sdb9+dKae7M2tsVX7ns8aMDtpTqsc9RBmNIqqFKmtbXWqrz1+giJgW2JCox
X-Gm-Message-State: AOJu0YzHMtvCew5XzGk3HFIa0ncuFFDI/Hm8Fz57mQxPLSAS3zPj+9Im
	H7WaA6gYnu0SCpmTvvEyvuiaNYdZfXy0qJTWvMyblPEpSmXqIzRNnN3Aoi5Co7o=
X-Google-Smtp-Source: AGHT+IHhD7ZA5U9zNGbfmuHz6Kc73fLM0dyk7QDOl15u9J4kpVy9BxqJMA6+3ZrOnp9i0Fr8cg59Bg==
X-Received: by 2002:a17:902:d48f:b0:1fb:9cbf:b4e3 with SMTP id d9443c01a7336-1ff57ea1a8bmr218560665ad.22.1722879505996;
        Mon, 05 Aug 2024 10:38:25 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929407asm71128435ad.242.2024.08.05.10.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:38:25 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/1] RISC-V: kernel parameter for unaligned access speed
Date: Mon,  5 Aug 2024 13:38:16 -0400
Message-ID: <20240805173816.3722002-2-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805173816.3722002-1-jesse@rivosinc.com>
References: <20240805173816.3722002-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kernel parameter to the unaligned access speed. This allows
skiping of the speed tests for unaligned accesses, which often is very
slow.

This patch requires (RISC-V: Detect and report speed of unaligned vector
accesses) to be applied first.

https://lore.kernel.org/all/20240726163719.1667923-1-jesse@rivosinc.com/

Jesse Taube (1):
  RISC-V: Add parameter to unaligned access speed

 arch/riscv/kernel/unaligned_access_speed.c | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

-- 
2.45.2


