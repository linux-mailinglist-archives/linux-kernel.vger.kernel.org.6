Return-Path: <linux-kernel+bounces-407282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6119E9C6B47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DF21F25A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A828F1CEAD4;
	Wed, 13 Nov 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZFSvwpO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B411CEAAD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489355; cv=none; b=W8n3uLy17U8Zf43I/5tURpUrrRGq2gZEkYyNR5VKIdFU0fDv8nXy3Q3VqXMX6YArcL1buDLUVyBIL6wM+MbD2Xo0NyO6zPhiI7evtFKdEao+LqKNRnOcjsIbq7SNgputDR0ORSGqI0STeptLgCSqN5V3hoVtc8hFaNu62feQcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489355; c=relaxed/simple;
	bh=SB7Bfgqn58f7pGUarYoQdJJz2+RISn4Ut5lwKQbEXC8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YLounCbKHWhhapstRJolmdU2htUvYtGmeG7hCMHl0KfU7hqXEKXIJvdtOGQo4QN4AVNLIGFZQIAlqyn8bHybyc4bZOEOkxFnjhhGt1bY30zs15JbO+0nSWgPP0DrxwK9DpTRGe4kPsj4uRp8+E5JVwiWOHXBg5LdbU4shYf/5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZFSvwpO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731489352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=quTAJEdlmLiz3O8wMhr6p5bbf6+58IEExsR/WOQUwf0=;
	b=LZFSvwpO07ggnjydWC7U91iVQTdEpCBSkDPiYWCzZIYwrxevA6QW9e1P5VLXfJdRtNs5pD
	MUzzLJT31ShX1dA6f8UH4b3hlyB98jCAcVc87riMFoSF+2ZBzSc9uNzVAtoSNROw3ILZei
	xccdq9KeWSVYUT02UoRwXY2IyeQXx4w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-JaCQN5FrNaS7CEzRGEOZCg-1; Wed, 13 Nov 2024 04:15:51 -0500
X-MC-Unique: JaCQN5FrNaS7CEzRGEOZCg-1
X-Mimecast-MFC-AGG-ID: JaCQN5FrNaS7CEzRGEOZCg
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d395f187f6so4281756d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731489350; x=1732094150;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quTAJEdlmLiz3O8wMhr6p5bbf6+58IEExsR/WOQUwf0=;
        b=i8EPeZkPbtF6kqt2bTuC0jgqbYYTHIfYJO+yVjPpIUafG9ehKmZ2PyHkuoebuT1bbx
         /ZDbR3reaf5iGHLDs/aTp9Z3qkDeJaKgXsKT3QRICicQxu65o4g+qxHhaViCVVCPVGHF
         OVMB0pI82DPh8YVHR1uCWf9Y5dLVhRsCdC0Q3QjZj+bAsYU5/Da77Lqc/jvgzahGKI/U
         ygDh5uOIRxxZC4KYJN3tuqH4GaMBEPaRUHhtfuKxM4Doqrwee4Z9TSvocpRbYKeo8BHa
         gy6zSsEjU3ZYxFQWqF/M1ZtOcvmztK2o7LA459bSBmuhFd//4EQWKHEPCioxU9VOvW8u
         WHSA==
X-Forwarded-Encrypted: i=1; AJvYcCWm6dL1fsBRxBfDh208dIG7/JHBwpl42Hff3mZVC5rSRfTvsZPFVC0mgA8yZcRmXNbPMew36vt9TL+bsPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwycWCAmPUVLluQbIjyH0QbqZuhkph52zaqgw4TTFMxU3ve0zdI
	JPLBvBAcJcE00x5ypuaUyZmlOFT7g99zlo/ppUv1ARVFXMewlo9fD/x27YSajw6dwk/hu/uW/R0
	AXoZo/rOln658MWovDS44t7Fx4BfG8TbqLGkKoF78swNPiYX9En6Fo+Z7IxHxnQ==
X-Received: by 2002:a05:6214:5081:b0:6cb:1fad:82b2 with SMTP id 6a1803df08f44-6d39e1125bdmr116776226d6.3.1731489350608;
        Wed, 13 Nov 2024 01:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDwDRfyzmSF24P4AFU+yndsPh2v9vVvenuKF0R+CHcbHTyMz4BPrKKIgvxXN3lhC47OZ8I4A==
X-Received: by 2002:a05:6214:5081:b0:6cb:1fad:82b2 with SMTP id 6a1803df08f44-6d39e1125bdmr116776076d6.3.1731489350269;
        Wed, 13 Nov 2024 01:15:50 -0800 (PST)
Received: from [192.168.1.51] (207.red-83-46-1.dynamicip.rima-tde.net. [83.46.1.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396630ec5sm81599036d6.101.2024.11.13.01.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:15:50 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v4 0/2] arm64: dts: ti: k3-j784s4: Mark tps659413
Date: Wed, 13 Nov 2024 10:15:15 +0100
Message-Id: <20241113-b4-j784s4-tps6594-bootph-v4-0-102ddaa1bdc6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNuNGcC/x3MMQ6DMAxA0asgz1gi4NKEq1QdEjDFHUgUR1Ulx
 N2JGN/w/wHKWVhhag7I/BOVuFdQ28C8+f3DKEs19F1PxpgBA+H3aUkJS9Lx4QhDjCVtOJDl1dn
 Ojt5BzVPmVf73+vU+zwvgTedNagAAAA==
X-Change-ID: 20241113-b4-j784s4-tps6594-bootph-348ef98086a9
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Halaney <ajhalaney@gmail.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Enric Balletbo i Serra <eballetb@redhat.com>, Udit Kumar <u-kumar1@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731489348; l=2452;
 i=eballetb@redhat.com; s=20241113; h=from:subject:message-id;
 bh=SB7Bfgqn58f7pGUarYoQdJJz2+RISn4Ut5lwKQbEXC8=;
 b=HIPKdQzzrXuLuysgHfF7ppw9TUp59s2Aq+m8hqdoYVFBygJxdrz0L3t+09pfJVK5VzLhnkrxS
 O0rrpwWx/6qDpMWqjAaulpOfII1MTHgoVLOOBPrIk7aXUlZAlB80Xev
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=xAM6APjLnjm98JkE7JdP1GytrxFUrcDLr+fvzW1Dlyw=

This series marks tps659413's regulators as bootph-all in order for
the nodes (and parent nodes) to be accessible during MCU's u-boot SPL.

This in turn is desired since the tps659413 needs its MCU ESM
state machine setup in order for the watchdog to reset the board.

This took me a little while to track down, as enabling the ESM, TPS6594,
etc in u-boot would result in the below boot failure:

    U-Boot SPL 2024.10-rc4-00007-g44b12cbcd1b3-dirty (Sep 06 2024 - 14:25:52 -0500)
    SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
    Initialized 4 DRAM controllers
    SPL initial stack usage: 13408 bytes
    ### ERROR ### Please RESET the board ###

Which turns out to actually have failed far earlier in spl_early_init(),
due to these nodes not being accessible in u-boot. That's hard to tell
though since console isn't setup until later (and for that reason I
think spl_early_init()'s return value in j784s4_init.c isn't
evaluated since a panic() at that point would leave a user with *no*
information at all).

I've tested this in conjunction with a u-boot series which I'll link in
a follow-up response on the k3-j784s4-evm. I'd appreciate someone testing
on the k3-am69-sk at a minimum, as it should suffer the same fate if things
aren't setup appropriately.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
Changes in v4:
- Rebased on top of ti-k3-dts-next branch

Changes in v3:
- Added Udit's Tested-by tags
- Reordered bootph-all to align with dts-coding-style (Beleswar)
- Link to v2: https://lore.kernel.org/r/20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com

Changes in v2:
- Only mark the regulator nodes as bootph-all since parents are implied
- Link to v1: https://lore.kernel.org/r/20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com

---
Andrew Halaney (2):
      arm64: dts: ti: k3-j784s4-evm: Mark tps659413 regulators as bootph-all
      arm64: dts: ti: k3-am69-sk: Mark tps659413 regulators as bootph-all

 arch/arm64/boot/dts/ti/k3-am69-sk.dts                   | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 8 ++++++++
 2 files changed, 16 insertions(+)
---
base-commit: 767b6a0d0900c951e8b42306bd636268481a97ae
change-id: 20241113-b4-j784s4-tps6594-bootph-348ef98086a9

Best regards,
-- 
Enric Balletbo i Serra <eballetb@redhat.com>


