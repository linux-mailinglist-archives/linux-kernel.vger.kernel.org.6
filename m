Return-Path: <linux-kernel+bounces-434454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB09E6716
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD7016617F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C661BC9F6;
	Fri,  6 Dec 2024 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhbOY2Yt"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD74198E71;
	Fri,  6 Dec 2024 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464755; cv=none; b=QVaYwq//KVcfR45V9+IAzOGq15SeAjPrOj/G8fqjWL40ieR9IkPmZ3B8wGwavrUVpLx4ZDc74t3kDfOXwG8anLAH054u5LMXw2g5t4GvJorZ35KUaf1j6cGV6vT0nbtqHXL4qZvHv/EAvmlX5U9ZsE5Lh1CT5HauvBYShGv2HTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464755; c=relaxed/simple;
	bh=sFG8ADYYDro/hv6aKGepxKBtB0bQU3S+myM6PcBLLKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AOPcmc7iyrvfYrocPuOLN4dVvn69Rht6K97f2saIWiI+B47qbQ2zYIZr7xkrCWqxyJemXhsQHX3EschWzeoMlNzrUr32HVljt8u041seRuTI+g2AmkKXGr+0ctQbksi+g8XAoQJYDWulsnFZTNyfkZofwUicwI65R94lwGeipg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhbOY2Yt; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d87fffeb13so11001866d6.1;
        Thu, 05 Dec 2024 21:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733464753; x=1734069553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXRFRs+XC0DJNciNy6r2rJesSJbW/6H6nTwb7IfEzgA=;
        b=jhbOY2YtLlUIFLWFjr9UrwnnWvNaFF/nzCEgARMD0gm6zathz41SinCaNhxSvRd92X
         7Ntt+IO0qSJGRkm6h8b+FnrJJqwYQ0gv16fcnDZoJvcktAfxQCMgw2ZhmAg4eiCZx955
         gdzwQPE/cvSkhli6brHrvSo1mbkRP1hoW+VmkxEL/JmCbdGWDi+t2WSDAQZ3zT30gtoN
         rbaNAkxmO8ejUTQamCqGq/VCMQzvvk+IUJB8ap2fu2OfkVGy4S60obtVVCxuRmFS+547
         iWLnCTA49Wqe/GGtyvsvzuYDHdEXVs32IgisYoHkUEDzdKASaNFAVHZKg1qB6kFPy/gp
         efRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733464753; x=1734069553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXRFRs+XC0DJNciNy6r2rJesSJbW/6H6nTwb7IfEzgA=;
        b=V6CgSS2/hgxZWT2ENpQvIwXAPy7p2F7tT8VdpF+8kKlNFZJbAIVrdYMbfpTdHLlGz8
         +6X5Rzso5k7PShcIbHxlsv3bRz8Lgb/mWYe9cgAhYQPdbhOkNqijfPAeywSURmHYQmml
         EP8uj5rfT7+dZctLvumrhu1ZjUSwcn2bAlCqH5iMrcZqow7yHzxbYvjel10EummxIR9c
         QEtrrm2Edch+6Z3x+sOMkzlXhABZgjKCXC47pURytXjTB3X0zVlGJ6nZk1stUDqsX6fV
         5k7K9BUQmnUZN56MXzqo+f83FrQ1xfbrbPp7Jv7OWnNBQZSDAWdKxWNxwCH/beY006za
         Fncg==
X-Forwarded-Encrypted: i=1; AJvYcCWVdIzDNIYA3VTJBav8qllr5WBWbulN60ySYvi2rwlkG7YHCuy1KsqlyGtzLumSi1iklVaJfPYyuyteiaI3@vger.kernel.org, AJvYcCX1bbUpH8vCE2xb9+7Gt2lWe4x6FdmTaLbfd5Hqs/TSlwdxfcHQBIrwROlh25UIIs+QQxBGKFSsVFBG@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQalwOJyYaiugXfNuu8F6rqPrzH10RqOWerlME5kXgL6dGJx4
	8lEiLG1GpkqWy0opc85plD3SXZl96RW+fkQ4xHxxIMz3YKZ/Qh/e
X-Gm-Gg: ASbGncsyECjoMYe/xN1Y7Wa6EPi9j+4os6hP88MWm1SYi5S2pw0RARXEhNZEazZ9SZb
	gq7Gq7hRKuKd/3MrZfPVEu7eNT84xjVu3U2M2GdMIPE2JmeC1nWqSyVuy/cQA8SnmIc0MIfZGoq
	Q7j+Cv6f6nUvoovcB0BBsr7Yl1JQi3iMCLe/qBkGSin2WgecTuPRuWKg7UYGv7N/aN2XmIhEW0y
	TAeso6MSS6pIb9P9/XMhOWK7A==
X-Google-Smtp-Source: AGHT+IFdJttRi42Zr1gBevCxL+wX995Q3xyfSbyquAMQ2ObqdH+gemcPApjmT162LwutnyFnblVzKQ==
X-Received: by 2002:a05:6214:1d0c:b0:6d8:9bbe:392d with SMTP id 6a1803df08f44-6d8e70f0644mr15278116d6.6.1733464752961;
        Thu, 05 Dec 2024 21:59:12 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8e7883a0dsm5826426d6.45.2024.12.05.21.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 21:59:12 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 0/3] riscv: Add bfloat16 instruction support
Date: Fri,  6 Dec 2024 13:58:26 +0800
Message-ID: <20241206055829.1059293-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add description for the BFloat16 precision Floating-Point ISA extension,
(Zfbfmin, Zvfbfmin, Zvfbfwma). which was ratified in commit 4dc23d62
("Added Chapter title to BF16") of the riscv-isa-manual.

Changed from v2:
1. rebase for v6.13-rc1

Changed from v1:
1. add missing code in sys_hwprobe.c

Inochi Amaoto (3):
  dt-bindings: riscv: add bfloat16 ISA extension description
  riscv: add ISA extension parsing for bfloat16 ISA extension
  riscv: hwprobe: export bfloat16 ISA extension

 Documentation/arch/riscv/hwprobe.rst          | 12 +++++
 .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
 arch/riscv/include/asm/hwcap.h                |  3 ++
 arch/riscv/include/uapi/asm/hwprobe.h         |  3 ++
 arch/riscv/kernel/cpufeature.c                |  3 ++
 arch/riscv/kernel/sys_hwprobe.c               |  3 ++
 6 files changed, 69 insertions(+)

--
2.47.1


