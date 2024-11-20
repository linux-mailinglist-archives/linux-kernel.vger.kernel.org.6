Return-Path: <linux-kernel+bounces-416007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C60519D3F41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073A6B2CF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3D04B5C1;
	Wed, 20 Nov 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0BLPctP"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E213B592;
	Wed, 20 Nov 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116630; cv=none; b=LHj5gsTcc6cioYuqkIeoPyX369g9ieph0/JMwg+82R7TWAWig8sKQxl7pAe9C2CQ/mBfiOQRfFVUbqxfbX22D4JbpMn40TekE5KW1Ptzo5g0AE1Mlm50UE4nmvLa56lzvWoPBZQEXlVN6AyS3FsHfRvqDjRZ69vBX4HauvGX0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116630; c=relaxed/simple;
	bh=HpUE8Hp6rpdOKIPu3oxaVkUHkssLa1gjD1Ltf6yr0gA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JuY7fiqT1Sw4RqzSqnvfan7oqP1SjjtksXZ3qg4R9UUxUvJbVicgUCsmEHMT/ZIIUiFSLg7XP15hx3P/hQBkUk4eUN9Y65b93or3OtBgGI9xdRPyFrdR9UJBNBbxe43ftyH4i2imqE1dLauORUXXR4mbaG6J0XRVdbApI3ltZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0BLPctP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f4325168c8so3116448a12.1;
        Wed, 20 Nov 2024 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732116625; x=1732721425; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q92L/R2YmvTNp1RhwXd/fLj5ETQBHNWrCMx9B/X9LSc=;
        b=F0BLPctPyhmd5NZf9bpXZXYRGcUOXxLRO/cSzJiME2ao13omumx9C2TDWPdM3BXppe
         m73FRWCsQzyxWcesNsITbj2+Bp5YqtZjO5Xw6t2PqNOnGd04N+afvUdWUrBi/tGXrrFU
         wo2BTzALkavt/7RJg/zrfiDrgclkGBFk9qdlwhuuwnMm0g8Adt8n5i/lhUNapimZYMFj
         hg9rvEhjN5A6z9HUrzD81B2W+eGehyWQEOWpReqQjAq718blZNLyrvBXqOG8s8HDKXPk
         x+1YPKN4mKOKY6gnlrXAFP8T5KI9wjknL9MRg8xba/hL2YoHwJUU0+MKwiETnv+sEL4m
         xyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732116625; x=1732721425;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q92L/R2YmvTNp1RhwXd/fLj5ETQBHNWrCMx9B/X9LSc=;
        b=GG3ySvvcfMvNvVuHYxmOWFarstgxlrv61rlJjyoMGe0f/G/A90p2jRjPHxTJ6oaT0f
         O0xFAa6iJV/wIDrAWJdYEMWYlNVtIL5u0BK4ylx6EE04OEM9TeTNH2v0F1bx8auD4An/
         +jkfYvldkBDi37AeowcpOGsxY2ZLhe1fLRJ9Y85ZH9YOMj28ETYb/4MDIYVYKkUaSJ1x
         Tsr/n21BV6KQ0C71umNR8jj41SAfaMzBCCgwCCIwXWlfdTJEbHlF4VTHYLbBy1b5pdxH
         r3D4Exie4blBmLQCT0+L6/j2V/3ywAKsz1Hit0C+ZrWnQD+nVf9qKrWaXor4eHl/Xzzy
         Mssw==
X-Forwarded-Encrypted: i=1; AJvYcCUUPjc+c6+q7NQLSE22vdkKJ4xPEAyUq1+EiAXTIKqcv/d55R9Ti2VoXCirKpCPRmBZF5UDTZdWB0zk2c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGeLAFOCBB3hroWXU7XW6G6P8IwJhDbjRb7Mw/b27E7vBDR9Aj
	S+uZlA82ROzWqdbTOd5xsQV3gO53cohzuZbhsD8qVQEvKZzrvERgsKdCFQ==
X-Google-Smtp-Source: AGHT+IEvXhHnJIklLk2svVl5ekqiFKiIk+e6Ljugt4KewIjaYCqnpznG6lbBnYvKpBRIHtLh2Y70Fg==
X-Received: by 2002:a05:6a20:7350:b0:1db:dc58:8058 with SMTP id adf61e73a8af0-1ddb0818b33mr4703499637.31.1732116625432;
        Wed, 20 Nov 2024 07:30:25 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befb27bfsm1754558b3a.169.2024.11.20.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:30:25 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] dt-bindings: trivial-devices: add RAA228004 and
 IPMB-DEV
Date: Wed, 20 Nov 2024 23:28:05 +0800
Message-Id: <20241120-trivial-devices-v1-0-1f7cb48ee21b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAUAPmcC/x2MQQqAIBAAvyJ7TlApyb4SHRbdaiEsNCSQ/p50H
 JiZCpkSU4ZJVEhUOPMZG+hOgN8xbiQ5NAajTK+1UfJOXBgPGZrsKctRB+sR3aCsg1ZdiVZ+/uO
 8vO8HWXP4sGEAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732116623; l=506;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=HpUE8Hp6rpdOKIPu3oxaVkUHkssLa1gjD1Ltf6yr0gA=;
 b=WciIkpbkHfk1Y/fZ2GLrZftjix2FK2bEXcfFGA52dZnSz5HrBg5TVzQ7CLbn6/FzQndzJVQJg
 NeELWsrImz4Ajd8+hA8a33Ko9AIUM11pMWMrfwpjRwvtw/zsjLzUQXe
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add RAA228004 and IPMB-DEV in to trivial-devices list.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      dt-bindings: trivial-devices: add isil,raa228004
      dt-bindings: trivial-devices: add ipmb-dev

 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)
---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241120-trivial-devices-81d6caa95069

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


