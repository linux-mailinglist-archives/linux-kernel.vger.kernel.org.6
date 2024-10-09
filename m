Return-Path: <linux-kernel+bounces-357926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7FD9977E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DE4B23430
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5E41E2842;
	Wed,  9 Oct 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZKN6tGL"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7096178CCA;
	Wed,  9 Oct 2024 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510671; cv=none; b=HCvjwafYO/LZk2nJ/M7fp0Lm3TfRSTM9aE3ihLbyZrL+OiD2yCLNe82ItGSQzhA1HQtfyhVn9Xaxn+ujWzIuI00N3ZMmILN3SVcJVEnzUmy45+MyJmNxkQJQI06FdnD9/SDnYZneQx6Fuq+P4Zi/ldXen/LjLo1ujCM9uLtrKqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510671; c=relaxed/simple;
	bh=Algu2qaw1YIGO5BHSn8dvR4eoY6Acvkmc3OtMZbqGBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDwh7SR3xYyv1EzujUWVsvM7hfynojhere6CeE1FblTi7WBhdROX5Ugkk7Q1fPq4fh4HzHnalaF3Ed7T2FbEpPeLq61LPMRe0zPaUpyYgiz2pduG8F3aFYmuzZXU3IILENU9IxIQNyRu/LHqG95NSLQ3AMoErhdceQzf2gGNc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZKN6tGL; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db238d07b3so204621a12.2;
        Wed, 09 Oct 2024 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728510669; x=1729115469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq7cT7iOuSPhHk28fKsdjOBJPWkivslMrpeiMk+Tm5U=;
        b=RZKN6tGLNM5JKTQOQw0TAUWSlKkeeJYCyuQV+vsuWEdbHZImKxeoZjTgBXZpverbcs
         eL49fjl56SHgzoLjybJB8PEr5U1LlIN1aLUjfUJ9+3JuXI3TDVql0ASC/f3xHfbKgukL
         cFlBM8MhCaisxkQLHGssADR3VC9pDVLF3pqNH7pEacS5JXzumcUM9GGm2IkLLoswZ0sq
         /8asnY8qgDbPF+FrizjUFCapfNwTECCQu3GH/U2j11MCsLVnTgBCpxwY6JWM23kciAGH
         J0EAIKuDmZVWt6nR7aF2l8J5Gz0SBtK6i2OoNpnVr/2FMsEfvpHNmURdx4JJKldmIH/U
         qe9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510669; x=1729115469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xq7cT7iOuSPhHk28fKsdjOBJPWkivslMrpeiMk+Tm5U=;
        b=fWx3le4HpgL5VlSFj8COimytL8JsAt/2z1/efb9mFe0NEq8/3wuK2EnrcCZWbigHHg
         F2WsJSdik+4+oH6rR6mYvTDKohpgl6NmnRTzn8LuR3nnb7Q26Ua1kfN/PkEw3AYUVtCS
         5CDAYS4nHoOifhfS8rr23ejtte3vp9GUoNTLZMgzw0o+CPMvhxF+/reVjJKK71nGTpN1
         Q0DtDiOfBmIoTQoUbWWtcCOLQwb8kgL2dHLDdLpMIhGdgqjl+04pcy1/jvLzpr+OzQ/A
         1ZWYZDy3aneYYySdVW4CEjlohFalk3/WM/VAN+VlMMUc9sYSszcdV+HGFxBedRo0UUV1
         BQAg==
X-Forwarded-Encrypted: i=1; AJvYcCW/GWMtkhN3xuFsdRcAoC9y0A+i6qmEgZ/tt6isAY1NG/2yTXee2OVgNW8AEhGzzJZAg0VzVvrisV/T@vger.kernel.org, AJvYcCX2pOS20zSahizJtbwalJcBSTcodXsFToGJWCd9tIDCLQcV73dO0oW/0zOn2ucmve+scvw4JGLE8RQVIKhh@vger.kernel.org
X-Gm-Message-State: AOJu0YyUh3hfT5M3LQC4ADitLpZzG2BE5o0vQGBl591tpaolRCwf45Xe
	FmNgpMyzAorxwZsZT0XdeRyf2FOjiHkEouv0TrMIkt5TvZQKhnh4C9fSoSqCyzk=
X-Google-Smtp-Source: AGHT+IGOd4+7Ydh13M6mwUI8U2txnoUWdoFVcnuB03ILxF9pWQHrX1mSLua7NbnryjYw7cmWaWYl8w==
X-Received: by 2002:a05:6a21:2d0b:b0:1d4:e638:d066 with SMTP id adf61e73a8af0-1d8a3be1410mr7349577637.6.1728510668910;
        Wed, 09 Oct 2024 14:51:08 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833a95sm7651847a12.52.2024.10.09.14.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:51:08 -0700 (PDT)
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
Subject: [PATCH 0/3] Resolve BCMBCA DT validation errors
Date: Wed,  9 Oct 2024 14:50:43 -0700
Message-ID: <20241009215046.1449389-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings DT schema folks,

This is a small changeset to resolve DT validation errors in some files located
within arm64/*/broadcom/bcmbca/. It consists of a relaxation of the BCM4908
partitioning schema, followed by two fixes to board-level DTs in order to pass
validation fully.

The motivation for this changeset was to resolve validation errors flagged by
Rob's bot when I tried to introduce a new DT to this directory [1].

Happy spooky month,
Sam

[1]: https://lore.kernel.org/linux-devicetree/172808887840.121596.11205114990341820307.robh@kernel.org/

COMMITTER NOTE: Email being what it is, the capitalization of my email address
is apparently getting discarded. If it is important that the author email
address have identical capitalization to the Signed-off-by, please explain why
so I can investigate why this is happening and/or get these patches to you in a
desired format.

Sam Edwards (3):
  dt-bindings: mtd: Relax BCM4908 partition schema
  arm64: dts: broadcom: bcmbca: bcm4908: Fix Asus GT-AC5300's cferom
    partition
  arm64: dts: broadcom: bcmbca: bcm4908: Fix Netgear R8000P partitioning

 .../mtd/partitions/brcm,bcm4908-partitions.yaml | 17 +++++++++++------
 .../broadcom/bcmbca/bcm4906-netgear-r8000p.dts  |  4 +---
 .../broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts  | 12 +++++-------
 3 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.44.2


