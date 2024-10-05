Return-Path: <linux-kernel+bounces-351660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179DF991464
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E6284F8C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF738DFC;
	Sat,  5 Oct 2024 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhTxN1+X"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79747F6;
	Sat,  5 Oct 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728104679; cv=none; b=sHxBfBveDuOUZYXtW0HvFsrTfDcKRC7/xeCYyeCU39KLo+JmibI093VvCQ7QpFI7VGet7n3u/WWXzfIN8jKbVa3Qik/S81gyT0HVBBeHXaPRKfDmWWiDqgiFc/FdoDDHmswwqoy9K4tPBZC/xS0keSPDZtMsoWO02OGA88kx1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728104679; c=relaxed/simple;
	bh=4UnUIgsbD1n0W2b5XrUNaJ8Sw5WrhqGja7BSVT8mc2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWdofcS4mVhpoAIgbtjjWiWsc4w4PWSL+uAuGM/rcJV1iI3frlz1a22r0E1wlunk3ewElf12PtABuRxWAV7FYVspDWmxIcWBQVzLWieTF3icZkH6nml7qyQUZbIQjJvLHkVRE/KwZiyN3ROS4SRgchbC1/pLaXis/YbAYV0LHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhTxN1+X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e09d9f2021so2032939a91.0;
        Fri, 04 Oct 2024 22:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728104677; x=1728709477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8NHiKWRZuu6Ni0mDEJmlzarQeFmoce/A7Zp31QdSHY=;
        b=EhTxN1+XlL/pp1SY581AlirnEI9oymsjiLvXj6ZLMvhtqXsf+H2Q/6gXpTERURbKYm
         haluhEX+6IPedxh2lAkf0Su20+A3NmJsIt93rVs6At210BqCBiYEqTYMzaDkzUCQnC0L
         pwoMj+GE+b6P+LrRpc8OdDMSznexQmRWTUfY+WTm8L9k4lAhP58I0pqDNphE5S7w4JKo
         aZBopeHxM4rZuDK4sHdKnPmQRaYVCgOP6KLt3NCEB/2BpI9mL1YIuIYmhlkLcJlu0fVT
         t0UTWne9mow4od7kBveVJ6baqVUseExsQrkeRWAnJ4SPcLWVyryJ2ZCyy9CaVkKxKDam
         +bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728104677; x=1728709477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8NHiKWRZuu6Ni0mDEJmlzarQeFmoce/A7Zp31QdSHY=;
        b=vZaKz2A9RjDcQX0kFHLYnptCA3LBUgXRNB2J5NA17P1DaPG4yqvLILpjLrjGR9QXZE
         mZChGtbWrVvFbHEwF/gkibyR9RR/9JjAvgZkxJuiYXRGKawA380RHlh/9q9LG7tQbiHj
         er7+jSjm2Ztk5ginDfoO1dzj2dhkMjUAYTlS8qph347rdbQmB+UKT0z0l/iDmNyvI7jy
         SdC33Q/nXr8A7jzcbZlUwduK6wXdJKZqXNvet1EnOer7K7wH0nHQpMUPeFJuP9TXksC9
         eBVHHoBkAJ4S9NzoYGWl3To7e8oxG9taj/EK50+q2pNyZ0UJ96UlOd2YCh8xfB3/CR6c
         6UMA==
X-Forwarded-Encrypted: i=1; AJvYcCU5xYbP2Nu7/YbQRcUOq2Imhod6VqzFzPXlJVMvsMvrhq2hjyMsuhUtPTP5zkhk9fg8lmVWlJ0npQO5@vger.kernel.org, AJvYcCXTKNIo8Dckjt275c62Ak7jFIYvbZ7Le7LIM9ml1T91inauC2bTQnwqwFf4gtP08j5+1A9n83gLNYibaout@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkcCXnvNatyvvF5oyNddSkLQT7k2mpLcfG9icCQvRBpxPvIbG
	AEd0NE1r1Ezy7ats+3U6k6mfPj9IQcNFqJR4GvP3dq3YPlmcXtQn/K4z6xHXfkg=
X-Google-Smtp-Source: AGHT+IHJH4xcREpvD0HDuNMTuUtxVUEaLiBlPUv8CIIcBjF+dsn53MPqiV3uxRBQCo5S+yuJsLIlRQ==
X-Received: by 2002:a17:90b:1644:b0:2c9:a3ca:cc98 with SMTP id 98e67ed59e1d1-2e1e620ead0mr5773693a91.7.1728104676850;
        Fri, 04 Oct 2024 22:04:36 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:ed3:4cda:b368:ce98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85db34fsm2625744a91.33.2024.10.04.22.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 22:04:36 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 0/2] bcm4908: Fix secondary CPU initialization
Date: Fri,  4 Oct 2024 22:01:53 -0700
Message-ID: <20241005050155.61103-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello list,

This is v2 of my previous patch [1] for resolving a problem preventing
secondary CPU(s) from coming up on bcm4908. After some discussion, I decided to
try dropping the reserved memory region from 64K to only 4K. Looks like it
works!

Changes v1->v2:
- Reduce 64K reserved region to 4K
- Style change to the `reg` property to use hex instead of decimal
- Slight rephrasing to the commit message
- Add a new patch that also moves the `cpu-release-addr` into this reserved
  memory region

Cheers,
Sam

[1]: https://lore.kernel.org/lkml/20241003213007.1339811-1-CFSworks@gmail.com/T/

Sam Edwards (2):
  arm64: dts: broadcom: bcmbca: bcm4908: Reserve CFE stub area
  arm64: dts: broadcom: bcmbca: bcm4908: Protect cpu-release-addr

 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi      | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.44.2


