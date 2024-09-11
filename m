Return-Path: <linux-kernel+bounces-325399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB40A97592A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183E6288E46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB791B142F;
	Wed, 11 Sep 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/ir5sX1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540E64A8F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075161; cv=none; b=Nni+Fb1C1at7ANy2t2M0yrqVrPRlyZOr8QDjJx3GXELoXb0WI7+FWjFmBB7rzO4IGuGgCT9DP9JALCp3tT7aFTvPSP4mwHaVfbuos2hTi0LIT0y62c/WEVE8Y9M9ZipaXThIjrA3qB+9EsORRjJv5kkVil0VJk7aYmpVuxW65sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075161; c=relaxed/simple;
	bh=smKxVhFn79pKT/2Kkn8qLXZaI4lWWuNlXGD8QzciySA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eKBefhvHgU7fMfsMZ4jux/NvZUQBzhACdJ1vCSWkARmo0yeZfPnHDxCAmUv8TCWdwXK3e0EkWhl4mf32fFZ/2qs40JGA8p9jgcjrrcAv4Mn96G4P1ZYnRLFDj6onrCoLMGKpfuGZL4I9OR4aSR69CPpV+pym0zsjLTZN8tIBhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/ir5sX1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726075158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2QEDmlsZbGKAeMRHxcVxt0zDqcHVNLrImWJvTn3pv4s=;
	b=H/ir5sX1dEoJAS7ahBZ9Y6mO9tAKb6fzdDqeat+5eS/4j2JhTGEOjhRFXA5L7R4gvo+VqP
	eZlpJum73nVnci6C6DnLjokJSwewTHJGRBRVFqqEPdb9vsxp9BTeCHDJozNSMuzLhJu/tW
	J6z+5qJmJzZpH+ov+Flfa1mrKFhdiNA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-JweyyeOfObuEVRkEVKt8ug-1; Wed, 11 Sep 2024 13:19:17 -0400
X-MC-Unique: JweyyeOfObuEVRkEVKt8ug-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6d73c1c8356so2618787b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075157; x=1726679957;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QEDmlsZbGKAeMRHxcVxt0zDqcHVNLrImWJvTn3pv4s=;
        b=OWK1XH7Fu+LcArE5NB+IvE/g7Rr8bwjKPDNvl2txmk+OIQkGANlBsb8f050bEFfFPp
         aCuT89Mk777SoOLnwtAOy2Mb+X+8dWYcAphM3bq40wrjVIqHOTzk4OljE1X2qqS0SMWt
         LL2dbwG0+ihZc7Z6uCw9HZfx9iWqttZu/tjLfjcYabitMXos8TW+CLedoqe8ilMssA+w
         RzKe6G+mKC3p5p0wf3E3JoNttsKf/I+gdiOWpJau3bdezOC81kB3/+mGK5veGfXVP2FS
         pFz5R41jqbMqKfAEk2MAJoVGgfvd0N6w8LIE+BXM9Lhh8MVXUzaqi4ky8j0nTKgt3y+b
         tRlA==
X-Forwarded-Encrypted: i=1; AJvYcCU2QgQCUcqpY8NJcLADSTDFqICqCaBbr34UG2C537OpwCoZBfzf6+ZGmyGD83lui2NZBENwQkHFL2auzV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+UEy+o85ytsJG3ubgR+/DEmDqijBQKnL2bBrOJosTaL6AzPl
	v7+FlMpv40QrxpITy4Vx5I99qjpjDqBF7WnQgr/o35FPq2jvDcTf/CIZVeQYElz+UIrXOBYQIHv
	U7XtSP+hLQdhZQOQz7DbDFartdwcks5lXiq25Y8SwBu3/iVXzmgY0BnVRtMoQqA==
X-Received: by 2002:a05:690c:6503:b0:6be:28ab:d87f with SMTP id 00721157ae682-6dbb6aebe05mr2706187b3.2.1726075157212;
        Wed, 11 Sep 2024 10:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIT6qXmmPGIvv0rLTPN8wAe6rzqrVtv/4GtEfQBmbljlGaKJ5VLk5wfIf8FZYj9mcObdM7nQ==
X-Received: by 2002:a05:690c:6503:b0:6be:28ab:d87f with SMTP id 00721157ae682-6dbb6aebe05mr2705897b3.2.1726075156896;
        Wed, 11 Sep 2024 10:19:16 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7946b8dsm444433285a.17.2024.09.11.10.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:19:16 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-j784s4: Mark tps659413
 regulators as bootph-all
Date: Wed, 11 Sep 2024 12:19:01 -0500
Message-Id: <20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAXR4WYC/4WNSw6CMBRFt0Le2GceUJA6ch+GQb+2JlLSNkRDu
 ncrG3B4TnLP3SGZ6E2Ca7NDNJtPPiwVulMDyonlYdDrytBRx4jTiM/LxBLDvKZx4AxlCHl12HL
 dWyIr+SSgbtdorH8f3ftc2fmUQ/wcN1v7s/+KW4uEapDDpFkvLbFbNNqJfFbhBXMp5QvuoeNeu
 wAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1

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
---
Changes in v2:
- Only mark the regulator nodes as bootph-all since parents are implied
- Link to v1: https://lore.kernel.org/r/20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com

---
Andrew Halaney (2):
      arm64: dts: ti: k3-j784s4-evm: Mark tps659413 regulators as bootph-all
      arm64: dts: ti: k3-am69-sk:  Mark tps659413 regulators as bootph-all

 arch/arm64/boot/dts/ti/k3-am69-sk.dts    | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 8 ++++++++
 2 files changed, 16 insertions(+)
---
base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
change-id: 20240906-j784s4-tps6594-bootph-19d3f00fb98a

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


