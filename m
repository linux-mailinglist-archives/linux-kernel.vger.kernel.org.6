Return-Path: <linux-kernel+bounces-215661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B290959F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19CF1C2145C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1606279F5;
	Sat, 15 Jun 2024 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaVZDjNm"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B751396;
	Sat, 15 Jun 2024 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417722; cv=none; b=cw9MFixvZtpyv6hI0g7gli/M42QVcVo7p1QaANyV3P810cLAvghLTYJHP/IH5wHCNENg0VBNnGPa3O83d5TIzlX9qkj5N91Hb4/xIc1tN05JOS9JwMrX55NgkDYg267JCZ2VgDHs4bd+/HnbjQGng+bCGutomUX6bhPFwMTtYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417722; c=relaxed/simple;
	bh=SPsKWeIizp08t7cz/YkDNPJdR0L1WQwASGhsGsLDECc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMxAjwqud0n4mmYG3OTq2o3BQdqEMWDmXKZRlLsJzN33YCYG34D98OgxelCckJu6MCpr6TqP3d130Q88ZhcTtWdC/ZKMbMivVcpYmdVC+tou6kFuIklyIknpgPVpDKMNRI/FN3ebnvAE4ZV6sa9KzT4/Ldftmy0m+wbrpGl8sYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaVZDjNm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7046e87e9afso2312689b3a.0;
        Fri, 14 Jun 2024 19:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718417720; x=1719022520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7u6FwRIze0mtb1uqHOlNNmcMAkHqxJeY/UMRB19/D0=;
        b=SaVZDjNmQmWuDA5XmQ6OmVIN2EOlwM4y6blhppFC7XMlFfzSRsfzWuuDr7R28jKiIZ
         IyXn/kBPWCrdKF+zTFGb9bugOphnskyqilaOSIXtni5zQtLfpuRan2V2KV3zpjm81QWJ
         nEvmFWMZfwYrys6If9JDsrX3mmc0sOuOqlEZT7baKI9b1l2O03yOdt6LnNI7HL/9MAcQ
         0K1LB++nK5kv/WdqpKUQzr16fIf5jam4w761x5UoKSMzux9RuG0uV/sXzcvPQcmbO+m/
         SRyc7d7KFbvvcu2QZ70rJRfDP1K09osTiU25J9SPcQrh8at+y/bEqII7A1ze5k7xlmgh
         Ks8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417720; x=1719022520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7u6FwRIze0mtb1uqHOlNNmcMAkHqxJeY/UMRB19/D0=;
        b=v8PcCfXIfjUcLZhr45G2+tXkSbpXd2FPkLdt/frFJJbJ4jsjj8Y60vmUe/Pd/mcI1Q
         sGuNmd3oojIn+ueEowZNKVUFA0Yz1n2r1b9o5s0eTGo5vKaSGSNhgQzUdyIq2g0j0Zkh
         Kt3ESGzKdRnyfCHz7sO/BpsRg3K/kaQCtPUBslNWRl6yUv2NuuHLeThVYzvuDaT66nva
         gpbrvK0C+Rc2J/jIz/R3SRzQP6gnP9u7cU92IhjJQPyymnebHrIwHBTXJu/CYCBH4Ut3
         oCSB8KpNc+ikOMAliOWYZMgp3R0Yc871rqPAKjnXWMbz2hfcue15kvMzbwtyJQ9+oebh
         l0aw==
X-Forwarded-Encrypted: i=1; AJvYcCXa2u9Ws44apHO2iW6ns0lVD7KRYwnRN90591FjF/pkQ1xGyni7eE2VtYEkTrlXhgsbkCik0SXmcnUtw8PnEf8vwaDF5M1sc0DUvTvDAn398ZMnSXpiZ912cU9QIjv8yA2kbfFjGyaPiA==
X-Gm-Message-State: AOJu0YwdaTv3NyEWCzizHui2wJwYeUco85/Ib9ay0wKJsDpfwyEPrFA8
	5YvBIfF72UP+rAN9CvDg+KtIbmEjchMAw57NjGWS60XwMnYoQ/8W
X-Google-Smtp-Source: AGHT+IFb+XtAj0x7xV2hM6qD+3rb1K/g9G0r0SHeazDyGKQXtVdqRoNXUtEHvMz+q5gidKnOdai+oQ==
X-Received: by 2002:a05:6a00:22cc:b0:705:9f03:abbe with SMTP id d2e1a72fcca58-705d71d249dmr5373091b3a.33.1718417720337;
        Fri, 14 Jun 2024 19:15:20 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1c28:4b16:65cf:ef28:5753:2be4])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-705ccb3d2acsm3717839b3a.124.2024.06.14.19.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 19:15:19 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: kanakshilledar111@protonmail.com,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND v4 0/2] dt-bindings: interrupt-controller: riscv,cpu-intc
Date: Sat, 15 Jun 2024 07:45:02 +0530
Message-ID: <20240615021507.122035-1-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches converts the RISC-V CPU interrupt controller to
the newer dt-schema binding.

Patch 1:
This patch is currently at v4 as it has been previously rolled out.
Contains the bindings for the interrupt controller.

Patch 2:
This patch is currently at v4.
Contains the reference to the above interrupt controller. Thus, making
all the RISC-V interrupt controller bindings in a centralized place.

These patches are interdependent.
Fixed the patch address mismatch error by changing DCO to @gmail.com

Kanak Shilledar (3):
  dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
  dt-bindings: riscv: cpus: add ref to interrupt-controller
  dt-bindings: serial: vt8500-uart: convert to json-schema

 .../interrupt-controller/riscv,cpu-intc.txt   | 52 -------------
 .../interrupt-controller/riscv,cpu-intc.yaml  | 73 +++++++++++++++++++
 .../devicetree/bindings/riscv/cpus.yaml       | 21 +-----
 .../bindings/serial/via,vt8500-uart.yaml      | 46 ++++++++++++
 .../bindings/serial/vt8500-uart.txt           | 27 -------
 5 files changed, 120 insertions(+), 99 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/vt8500-uart.txt


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.45.2


