Return-Path: <linux-kernel+bounces-409347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596AB9C8B90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0622873BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F671FB883;
	Thu, 14 Nov 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="sNX/7hKB"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A201FB3EF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589893; cv=none; b=Qq0FUs0rFll8KnMnJ7BH8EAELxI+zNK6aFLGpgEiNIrLm0HRhCWmXXXGg8BPyFqaXFkMzI7Vhwqfae6Mo0gJ/TLeWa0375s138LEUq7fFmeRHH6bMcRu+ivG090Ol8OZISC5efyGcAsgS3djZpCPJUXpMFgFSU5aK0ixEf2GIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589893; c=relaxed/simple;
	bh=69InTgkbQ/P2D6HIZK3TsoYrKFIx97fb289sR9FPbD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCbj4EMkWU7/zbpJ9Uha6hyRmAJ9XQ7IAq0V9TDqNB0qLLhdFLSy35YYNgM1L6jYBLMMt7iGYwUGXYGs3FjFX5Dn25d8dyizN5EaH35M87WQXF0JJTXyFrxD9L/OuvJGmXuo55s70N6vqRO/IJIjz2umOEgxhCUWNZHlbVEb/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=sNX/7hKB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731589886;
	bh=bh4YSrNjXuKLor5p5E2eFlc/Em8vHgx4kf/5d9oGFhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNX/7hKB+hZn4c4CkhnjBmgVReHB2OzVWMjh5M4I6ytM5hgn0mZVUpyHcBafMsKml
	 MU0dZe8q3HwMSTrCfGxwcq5JjpcXY6fyq+FwAyYxhkIzO5/GMQyAqUHoDMb3HJU5si
	 D1QOp2Gk9oKgsTLZfrIVLKne3wFSMiMd1uXEuzcFua5+UnoEtZah3sIvmXK+pgfU7Z
	 ri/mb5mqUBVsnT70yI7Rd3kr98MW3XzUBBhwEDuWejsqcReT1BHYL3sWEgHHmQUFRl
	 TpaTNI9GkAddCop5qMoLLESWk8slCTjkvqVeEMSJeXoO+qeiXU+LkRIrQh39poHzFl
	 FfbpK/RGLL3yw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0sV0Gy1z4xSX;
	Fri, 15 Nov 2024 00:11:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<geert@linux-m68k.org>,
	<arnd@arndb.de>
Subject: [RFC PATCH 10/10] i2c: Drop reference to PPC_CHRP
Date: Fri, 15 Nov 2024 00:11:13 +1100
Message-ID: <20241114131114.602234-10-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PPC_CHRP has been removed, so remove the reference to it in Kconfig.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index cbd072955e45..153929ac5f59 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -371,7 +371,7 @@ config I2C_SCMI
 endif # ACPI
 
 comment "Mac SMBus host controller drivers"
-	depends on PPC_CHRP || PPC_PMAC
+	depends on PPC_PMAC
 
 config I2C_POWERMAC
 	tristate "Powermac I2C interface"
-- 
2.47.0


