Return-Path: <linux-kernel+bounces-574535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC3A6E683
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC58173B57
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4C1EE7A8;
	Mon, 24 Mar 2025 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHKDc1x5"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83F1802B;
	Mon, 24 Mar 2025 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855229; cv=none; b=mhZfRLgM2MaqgRdb1F9QdCaeJOtYD9dkN0wvk4QHgpGsctac8J/lcz7spOr0a2PbXECepd6Pxt/5sA4QqIw9LjNFIwgGfMmgPzzM2AuRtw5FpdIyV99SUgk3nH9VFEEZCcmnYzgubRD8LkUo6flofQTPSOWlmAXnI/+EEc4YYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855229; c=relaxed/simple;
	bh=Kcxk5Ed6l5YFje5AH1/EsybxObDZblvJTnzf6HiN0sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPV1HND6ciXoAKEREwP3yeKTK/EwLxXx+QzUI2Bbyw28uOGBLAD38vLL/jDNBUvvjkaY3t+0fy9/JUUs6T6OsERnLPpbFUrhmRz57npGr4V4nIZPrhrszkKsEGztgHM013dgm04x7DFCrl7P5u17JWADe+jDRNyqHC6r735MaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHKDc1x5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bee278c2aso63489471fa.0;
        Mon, 24 Mar 2025 15:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855226; x=1743460026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dicu2uT/TQQ3Kzvda1LDs8DKPfcg6uNo+1qE5KXvJLk=;
        b=kHKDc1x5DVTDN+MtXTM9H1aY0j61x6P2HZkj9m5WvICn5Nv5PXHClJ7RKou+mpkPAD
         4sPTWseKU2nc8gu3hK47VctJ6shVLwVLpodRQezmlN0tUIUH1gOt/0UiulsIkLvkwRhK
         9+Aeq/TLarcghdTK9XuLhT+f8aBEypVju2jwscX8Y6+kvG9x25SDU878XDT+MjpW8hTv
         cgS2VvnP2T/snscweHQdlvEqVWzAo8//XbN8paJo5GvxWzCKHxn6FdfxTYia/zB1AlXc
         GHffbR7pECP+3vww9tNqc5AKt+2ujdBO5VbIBaTF65M33KRuPHaezFbBuXS6oRqpKDAb
         ZMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855226; x=1743460026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dicu2uT/TQQ3Kzvda1LDs8DKPfcg6uNo+1qE5KXvJLk=;
        b=wFQaBDXDiTUI3KatZpl0Cu5ouZLHyGPUvwHtN5QeQoyDMCmhSSVEPk3xt/UexfXrnZ
         3sai57/NZR8j3Tnmyz5HQ2yzugZXRc+zH2hgbaPgrexer0NHbSkjrVggkzhUExKBp0eD
         vntEN6/w5xV65zRqOspweXeFAN58clMiN7NfuPOynp2OAbtusVrxDU/DLbU652hu3Lml
         ZkJH4eowaXqc/myialWowvMPr7E0+F/RkZ665jU+KmiJClq2k5nDH40CEJ1a8XpcC7J2
         +lAuW267CZlWsS014sA8Ryal+VfPmYH8+zDiBucChQUQwQ1UV9ft5Mmut5a5ZYwKyRJx
         o5rw==
X-Forwarded-Encrypted: i=1; AJvYcCXK9sH3fmEJlWtvKZAlusMX0k8FxQGh0ORUrKPn60WOg5RcNH/ioGMAcLUef7H0cq1J7hvifiU8g3axXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzovtHDgYdgizlm2WGAsayBHwLr94gYC1DRBimPjypGs0BpANu
	2uwf0Fic9KCxAJk3HHxLV2kVDBDdH4DhiK6pPcHJlHBUyxZwtR6YvykXprfdfX8=
X-Gm-Gg: ASbGnctT/fuQdoOfU8gqZeRXcTZ/ZKruvYnIYY3rxyGHtRYcZHpA3wLey3KjtZFPVcV
	bVIoTHvkASW8zn5G8QKrBoGBEn/lpdpO7yd0Axze1+DbyI1lPLFbotl1TsiOF6x3HdgIfMx1BUQ
	PgkLMatMVpGaXTeLt5hmCEozI07phaIzVbaBSVjwt2/rC3kCngAxRUVlUaR34oqE/dw0DSGzeIS
	dnzUgCwgkvpm3t0KV8q/etTosKY5UDXyP0/a4jmyZe4DNPfr5oG12lx6PI1X+q5gDHgfzTpjuYK
	OL3pQITxuUfST6uBkiKOhuYlsWFc7GsS0WTgGmxl1Jgzxrc2BWegncb+Wks7icYqSKLXda0Y01C
	so60E0yUaUZzYfIvIL0dthw==
X-Google-Smtp-Source: AGHT+IHsjQ4ffT87Dj7E4IV365DayLWgJMiSXG4sJAZqZiGP6NUh0pw5imGom5qmGODRSgL7kgG/OQ==
X-Received: by 2002:a2e:98cc:0:b0:30b:ef8f:cc94 with SMTP id 38308e7fff4ca-30d727b9376mr70306961fa.16.1742855225322;
        Mon, 24 Mar 2025 15:27:05 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe8b9sm15860611fa.58.2025.03.24.15.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:27:04 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: richard.henderson@linaro.org,
	mattst88@gmail.com,
	arnd@arndb.de,
	paulmck@kernel.org,
	glaubitz@physik.fu-berlin.de,
	macro@redhat.com,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 0/7] alpha: machine check handler for tsunami
Date: Mon, 24 Mar 2025 23:21:32 +0100
Message-ID: <20250324222643.32085-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is an attempt to implement a machine check handler with detailed
information on error conditions in the event of a machine check exception
on the tsunami platform. This work is inspired by how machine check
exceptions are handled on the titan family. This patch implements
processing of the logout frames that is generated in the event of a
machine check. The logout frame contains platform specific information
and is helpful in pinpointing the source that triggered the exception
or fault. Some faults are recoverable, such as a correctable ECC error,
but others may not be possible to recover from. As Alpha hardware is aging
we may see more errors due to failing hardware and proper machine check
handling can assist in detecting and diagnosing such errors. I hope that
someone finds this useful, any feedback is much appreciated.

 arch/alpha/include/asm/core_tsunami.h |   8 +
 arch/alpha/kernel/Makefile            |   2 +-
 arch/alpha/kernel/core_tsunami.c      |  37 +-
 arch/alpha/kernel/err_impl.h          |   8 +
 arch/alpha/kernel/err_tsunami.c       | 707 ++++++++++++++++++++++++++
 arch/alpha/kernel/err_tsunami.h       | 199 ++++++++
 arch/alpha/kernel/sys_dp264.c         |  17 +-
 7 files changed, 942 insertions(+), 36 deletions(-)
 create mode 100644 arch/alpha/kernel/err_tsunami.c
 create mode 100644 arch/alpha/kernel/err_tsunami.h

-- 
2.45.3


