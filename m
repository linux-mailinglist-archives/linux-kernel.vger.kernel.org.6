Return-Path: <linux-kernel+bounces-241953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC59281B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB79281D8C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042EF13E898;
	Fri,  5 Jul 2024 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bquYCzRO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D721C6A0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159749; cv=none; b=Q45v+ypBwKS5xupxw625cj7HujQxbVp9PQXQ1NBMr+mNOI7ZwylDhQEywUE3scNUeOSRnxRgNw35CDCWWpv6XGQZPzT9QBNFth4e20ItJpDmGKKwdBGQET012ZNmzmi+O/pyuxv7FPZjwZ8CsloE5D8+WzQd5T06TuPELsPlONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159749; c=relaxed/simple;
	bh=t4V9aBaDIU10iQAeyyRSsO0jbGq6VWMWJ3FhCAYqYvw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TvmGM1kPCmkm+xqxQrIbQWRIgvUtg32GECRAo2nsvAQZ7Re9TtMYj/Ia5a5vsSASkA30CXUr5NJw5iRR9PlzHGN8fjQvuIUNjHt7mazOIKL42Ulqd/zgYX6umSWavGS8Nyvg7EIgB+zFr449lLuz9vnETUJmjHq2lW/VpBbatMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bquYCzRO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42573d3f7e4so8541865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 23:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720159745; x=1720764545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2irV+74U1sj/QLOHmfl6f7w4EpV0Hch2lBDdlAQVrA=;
        b=bquYCzROMqcQN3ingOueyN6iaJumVV4TOE/3enT9MSrQpFErL8MxHRxAY8NYaEorut
         gendsGbKu70acj4cmuLvY5aRP+lxoqZvnvgOU5hZVnUYfVSz9xkzewj1KGgbhHfn+pqX
         n88SLWAHuBCV8P/GdltW+n5Frb+/jZpbOhwWPkxvHsymU4YRnyE0Vrf3r9zPag7L9e0W
         nRC1H3Dq2F+v6r3nglDUvhCLw+8L2auNsyTrfn1Zrogq9Nzce/5k2Dy/8tMApHn7WbPI
         e/kGGCMtVOQdfc6CTWIiaarv3z1KrjlAyWBdHO+EDccDxfJlCCJ0xW3enop0JryBAjf5
         /Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159745; x=1720764545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2irV+74U1sj/QLOHmfl6f7w4EpV0Hch2lBDdlAQVrA=;
        b=slBvEuK9yj/fZbE/OnjjB/sSbk9zi5h1iglzubG6jM2yIUeGFr9uJbD8a7w5c9QRZC
         v5Qx0eVq8ulYH7W5m8Uz8u4TqLqdpgcfVxSXjb28/18LR5VI0nm3rdVcLvqZd0gA1MhY
         cNCosGJCEw9SMS6M1Smbx6H9pti3AplB50Uq0OqWxtjNHkkWLb6tHR3LfU+YT86mZOKZ
         d6/1DRC2Y8zdPDl8c6pisT1tRDf7B0gbr+CTUykA8epYhIegq1SwwCUwok8Rb2cCviTc
         0pg3qfLwmmeTupm4p5Q4Eob55bcbKmDstLf29YhCWHtw8KAhi2ckYid9t5UIFkgw5vQF
         2WzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/4prgN7ClXohn9lTgpj4dYbQ4mJlXmZgaMm8fwciRvNkyg/KHBrTp6adlZ/g8+g1x2JhR8joHLc7/RcWk8YKUYDIQD+ttCE4jer4w
X-Gm-Message-State: AOJu0YzdYhs69lKUJ47svVLtBVoJRvwgljPKwI2eoLxmCczRZICYxCqi
	4TPu2YwNjBfHLH9FQV4ErLWBPMQLZVwdszhajmiIsEX5/uqrIkZAanG/LhMv8jM=
X-Google-Smtp-Source: AGHT+IGPH7q3QPIhsxrOuPGnR5xF/pM0f0Ix1bFjxS21nFb3I2IhRoxLgCXjQ0q7L3CqruDgrr/YXA==
X-Received: by 2002:a05:600c:2149:b0:425:66fa:c7cc with SMTP id 5b1f17b1804b1-4264a48c5a4mr26558225e9.37.1720159745226;
        Thu, 04 Jul 2024 23:09:05 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d6133sm48641305e9.13.2024.07.04.23.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:09:04 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Vladimir Isaev <vladimir.isaev@syntacore.com>,
	Roman Artemev <roman.artemev@syntacore.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 0/2] Prevent dynamic relocations in vDSO
Date: Fri,  5 Jul 2024 08:09:00 +0200
Message-Id: <20240705060902.113294-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patch 2 uses a generic function to make sure the vDSO object does not
contain any dynamic relocations.

Patch 1 removes a dynamic relocation from vDSO in rv32 found with patch
2.

Changes in v2:
- Add patch 1 (Björn)

Alexandre Ghiti (2):
  riscv: vdso: Prevent gcc from inserting calls to memset()
  riscv: Check that vdso does not contain any dynamic relocations

 arch/riscv/kernel/vdso/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.39.2


