Return-Path: <linux-kernel+bounces-168804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD1E8BBDD7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BADB21127
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0284047;
	Sat,  4 May 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GzPEcII2"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3FD4C8F
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714851294; cv=none; b=Hwg3mQhUc7eABjxp+F5oyF3LmVnB2yLc6RPohytv3XYg29if6X+OfX7FhkBQ0EYrY7tPH9qaHzuNDHQOb/ZCAMSrmiHgmPHJbrpSRferOcgBqLt1J3dEkX8yuVhN58FMBg/bhBCaHZroEaLBntL/DWAbWG6eV595XEZaUouIU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714851294; c=relaxed/simple;
	bh=sa73LuQSyDkzgvdnKeZPnMHSAv9AkXFQb4jtSwXZ/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W84tN47Qm0GNm1jfZOumTZsyElgDpxKUeGvGfZvZISZenBMItfObpT5KRV9dEehaIYircLubImmffJYxF1Ce3KrtnDunhkKJIoxbR/EFQHyWL/x2OHXRBpTtUPWW01o4s+Op26pim5/u7RbkzEiwcYeBWw/Wxz53D8wQtCrwS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GzPEcII2; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 980043F2A6
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714851289;
	bh=fCdw8igKrdSP0dtv5mprL77xFjRhGIFmRTlH+eUmhU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=GzPEcII2Q3U03nHYpqi8bmvjr45151lY5BWQWGKfOnrBcuUwwgHR8cMgTQZtjUOBw
	 wcaBASXy42b2MF76H+hpW8ruq3M1uba9WeC3DoyH2N/4sYo+t0h9i1PEEGFG4EeIA2
	 hZZv2S1sqES3MaXCv6vwVtxxkc6HbO9yZ2JTDTLpUgtgxXuY6mKdLZBy1fDGxRbDxL
	 WvGKxlRSch4vgi6EZBFegFwCKEMhYphxDH5ksB/bltrsuAiDqV7vbgGi+XQn5RxsMe
	 bkvQBQBRy+iSpwR/tAsuXgEt7n8qm4Weo06MGqlPvR2wOXRfDYGxbKMx8mqCSl4jdj
	 fXNoGNeK/eLQA==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57287ec26a8so305592a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 12:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714851289; x=1715456089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCdw8igKrdSP0dtv5mprL77xFjRhGIFmRTlH+eUmhU4=;
        b=aC4XuadtRN9PLHoe2kgYRBh+6dRzFNkSKQdRGrihIz0uWjQkM7aTe6FUfEYYzAO+uB
         8nbkcmf/XbRhFbn5m92RcWdDnTzSCKHKTaxtlt+o6hFX8JCiXZcFHqiKG54PFfTKVOW8
         fcVhAfPTAQ97A3PKJ0pUNIPFRAoOcQn6V70qRAnkOKgR/cKyFOWlJR1rwGONKMf/wJM0
         E4LVWEmn2iOC0p/7h6Thy2dhYaxCoCMV65uA9u51gm+GcOe1mp+2KkIMsIAlOjInm1S6
         ll26BkiEcokXllJQPSkmmi/8w8bJm8iG/hkEv9cK2D09srur7oYrsfQHvgoRXhd+rnQA
         3+IA==
X-Forwarded-Encrypted: i=1; AJvYcCXHBNh+afxLUt9E6chRl0AvVKimyLpiom9DUXAMvVtpUY4h/nAWaEZ+BDpIMUOJn2gwKsiiu924LgBpxMYvCX4Jv9eZ8vvjFebQch8d
X-Gm-Message-State: AOJu0YwbX/VHCMwJQk85PBkAkE4WiizjfcA6fw/P4SkfDYTzmYtlclxh
	3WyGBjJsxUR+MyyEC89TA7pMc9x131pUyL3WeiW9FStv6uU5oaC2VFLLoK1ZFItZBEiVNarZ750
	gBEPlc4JRaPTiUxiXwC5lZa9PMJbfBRct3cXC4TSIWphmm0BmeS4EZGyLRDi6p+YFPVKqzc8BcJ
	ReGw==
X-Received: by 2002:a50:9f27:0:b0:570:1ea8:c50a with SMTP id b36-20020a509f27000000b005701ea8c50amr3930440edf.6.1714851289230;
        Sat, 04 May 2024 12:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfrOVNzJsIs3kHfWe2V+kJZE0Bxb3FyGDeAx2q21GBg8JQx9QrNbPMwAvnDHQI0wDmkJ7nZg==
X-Received: by 2002:a50:9f27:0:b0:570:1ea8:c50a with SMTP id b36-20020a509f27000000b005701ea8c50amr3930425edf.6.1714851288778;
        Sat, 04 May 2024 12:34:48 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b00572d255e342sm2227021edb.10.2024.05.04.12.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 12:34:47 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCH v2 0/2] riscv: make image compression configurable
Date: Sat,  4 May 2024 21:34:37 +0200
Message-ID: <20240504193446.196886-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Masahiro's patch[1] made me wonder why we're not just using KBUILD_IMAGE
to determine which (possibly compressed) kernel image to use in 'make
tar-pkg' like other architectures do. It turns out we're always setting
KBUILD_IMAGE to the uncompressed Image file and then compressing it into
the Image.gz file afterwards.

This series fixes that so the compression method is configurable and
KBUILD_IMAGE is set to the chosen (possibly uncompressed) kernel image
which is then used by targets like 'make install' and 'make bindeb-pkg' and
'make tar-pkg'.

Changes in v2:
- Rebase on riscv/for-next
- Use boot-image-$(CONFIG_..) := assignments rather than ifeq train in
  patch 1
- Drop patch 3 already applied to kbuild/for-next

Emil Renner Berthing (2):
  riscv: make image compression configurable
  riscv: show help string for riscv-specific targets

 arch/riscv/Kconfig         |  7 +++++
 arch/riscv/Makefile        | 55 ++++++++++++++++++++++++--------------
 arch/riscv/boot/install.sh |  9 ++++---
 3 files changed, 48 insertions(+), 23 deletions(-)

-- 
2.43.0


