Return-Path: <linux-kernel+bounces-515177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC891A36154
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D99E160EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C133F266B4D;
	Fri, 14 Feb 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iimcNvQl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1AF259487
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546258; cv=none; b=RxBIyFAEedrQsRxnItzhzPLO5t+GJNW2LwTPM8MOp9vSOghMnSirfIkhe1BkULRH8EDTnidUJ+8HKzBmHMuIPh4ZWVcwoOj1ti7WZCRaEyFUBRdk+rd9Td+Dl3N2TslcTS24UeGYnCqNtuB0SsYRDbVUwVYl8NxqwNc5ybi4hbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546258; c=relaxed/simple;
	bh=tUTcWT3xY0aNKKrpAIhOmqVWKwDSg0YFK87E6/nR7Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbSRWL3jHDs2J7Cqfu4BEf2DrGwW7piNZJmFsvooOFbpFr2zqFwvG+dUB80BYfTwIFl5NzbhroE8tWkNaUyWvD/J3Hjb6UjrUFheRxyODH4FI0u7p1wBjUl9rKB+rVC9Q0hcvBx3RDviixlrDoNQMvtZVpNvLwKUXShB/pC08sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iimcNvQl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739546255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dfZVegvU6qk4m7FwzKbbRj/0F95Jye2At6/Y/AuatDM=;
	b=iimcNvQlzGQXs+oFBaVy+I0kyTa/sah7vmHGFdlqPgc6u54pDR2cLZopZTcNo10nQ27QDD
	pu9Ms6b4yVu5eF1hKMdaq1uZCm6fHsAJtS7q/OvmjeS7t4sw8P8Qt2VVtdRaajD0eASEUP
	IBQTnFGQf9mYldcHET/fdZzquSf9LaA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-fgc0ENj3P_a-_z5vZz_cCw-1; Fri, 14 Feb 2025 10:17:34 -0500
X-MC-Unique: fgc0ENj3P_a-_z5vZz_cCw-1
X-Mimecast-MFC-AGG-ID: fgc0ENj3P_a-_z5vZz_cCw_1739546253
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38dd533dad0so2023501f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546253; x=1740151053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfZVegvU6qk4m7FwzKbbRj/0F95Jye2At6/Y/AuatDM=;
        b=fmy+Z3Ktd7p4eLiNWkeXdkc3D94EpbZX58/lQO3oAc7LMb2qwVjnXXHi8wiE0NrCkA
         CZxJrEkDAptUmUeTk3fxuKqkYSNIwV7LNMiCql28xxcineYPna//pjWFJKemtxv2D1Ev
         zO44A7xB7RuZDbUjanpPLfSsFgoRAi3ZjPFB7Ewl+g8h1AcRa1pxg/y+TRCmdZgOM+Vy
         YZ2oPU8Ksgtyh91r7T/3lgNbLw3jVBvIFnLkYFouMyWLUbb4M9O9wDAf0o2qGvJWFRDU
         To3BDNCMMUNNd/jZZYrHM9xA7UHhhHRo+04tSr5I3q0RD3pImkZsUuNNxgGSkj95gLeM
         1XCg==
X-Gm-Message-State: AOJu0Yw6gBA2K2PTnxeHb8zceSXCJ5zUjYf6BX9nAdi4nZEfMF+B4UfU
	fng1C/ewBPGUu0Gi43DgaD+gLzgiXdYjyVMqldgZ9vDGRyMsWOfASaVs0y86URlHFl9bSZOXfR/
	x9eqAfCdkZm9xR/DiuxnmZv9h4WiPqIYuqcsSlv/chHeLCvh2+z4JXizDNBksh//n2cJh1udaur
	O9RJ8yPvzTJSLsn6YXoOjppUrQgbSKKYfOQ5ICzzPfKf/S
X-Gm-Gg: ASbGnctaZ9bz9yVL6CLE3ERVf74grbpwNwMn3oz3+6weVBbuE11ZVjCSUoCwCc9PLYw
	iH6eXrV7u9eQuNleTQAnqNt3w7a4WISCiUe4UXLY2tv26GMXVsSHLFY2ZYUxgmXZqz7gCgZCvqG
	DkJmilFmd29oRb2B5XtV9L2LK3ysAqiG7Wk2YmshO/oYWlJ5Qd2ZcuLeDQsmfk0K3QIHu4iPNWM
	trlzjgPHPjmAObQcfJUw+aHLJnFypen0PBQLekBl2aFoGvpYHSh4gXcWZtF92mMoP+CJzisMqgY
	8thIfw4AKKKldBWGA9BlAtxmaydYHQ==
X-Received: by 2002:a05:6000:18a7:b0:38d:dfb8:368d with SMTP id ffacd0b85a97d-38dea2f76ddmr11997628f8f.50.1739546252742;
        Fri, 14 Feb 2025 07:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqA4RqLrxgT7ylPsH/Tx2/hd3i/GaBHUNlAKmeVU3IYJ2UXCjv9nvu6wq2BY2mLXriK9b/Xw==
X-Received: by 2002:a05:6000:18a7:b0:38d:dfb8:368d with SMTP id ffacd0b85a97d-38dea2f76ddmr11997573f8f.50.1739546252260;
        Fri, 14 Feb 2025 07:17:32 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5655sm4855672f8f.77.2025.02.14.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:17:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: javier@dowhile0.org,
	rjones@redhat.com,
	abologna@redhat.com,
	spacemit@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Yixun Lan <dlan@gentoo.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] riscv: dts: spacemit: Add initial support for Milk-V Jupiter
Date: Fri, 14 Feb 2025 16:16:36 +0100
Message-ID: <20250214151700.666544-1-javierm@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch-set adds a minimal support for the Milk-V Jupiter board.
which is a Mini ITX computer based on the SpacemiT K1/M1 RISC-V SoC.

The DTS is very basic but at least allows to boot into a serial console
and get UART output, similar to what exists for other K1 based boards
such as the BananaPi BPI-F3.

Patch #1 just adds the compatible string for the Milk-V Jupiter to the
SpacemiT bindings and patch #2 adds the minimal DTS for this computer.

Best regards,
Javier


Javier Martinez Canillas (2):
  dt-bindings: riscv: spacemit: Add Milk-V Jupiter board compatible
  riscv: dts: spacemit: Add Milk-V Jupiter board device tree

 .../devicetree/bindings/riscv/spacemit.yaml   |  1 +
 arch/riscv/boot/dts/spacemit/Makefile         |  1 +
 .../boot/dts/spacemit/k1-milkv-jupiter.dts    | 27 +++++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts

-- 
2.48.1


