Return-Path: <linux-kernel+bounces-262574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB3293C8D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A4F1F22DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857861FC5;
	Thu, 25 Jul 2024 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J8qRI7OP"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1552F9E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936312; cv=none; b=R6Om/899+Ry+IPksqlxlYySgALz1DWhblUZcwH5ihMZwNwjxnNjyNYHoQLPkTCVexN1WIcxFqWrAXqLjMF1gRupD3MwKvBQFiCLzns94GRJ7Wnv46ETOt7E+NNpDDgZWzhESaK/i3MdOyUx/ZM8XKgAkoZZLxLVnE3tZ8YxyZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936312; c=relaxed/simple;
	bh=rn9hIMHNo2Pna8pTksAbo9XeKPgSZNcQeFcNZYyXJoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5I/gN8uSTkiN3ja1HWb2Bu3Wl+bLd3qWmPrT5YZrRqaZ0aKVCOBKAC1XsPwhSciY3JaRVDYNsi/ejbj2VJNDROZI6OmQFv2Bgf/k4X4NLqxl3jLI5t/CdA0E/5/ShT7097dUZl3nRv52Mo8zdXwV+01B4qQJTMn4VoaibQlstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J8qRI7OP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=YUOsB12X9TWd3uUe1z7FI1U/ajvQFn/Ef7WCw40Dze8=; b=J8qRI7
	OPYUXcJLF2SYXr113AGosq/9YG/BV8deDJ4zFVbFgEDDGmnT5TUh2G3w3dInQmzb
	zU2dg1kA6pv83ME4o9clvsv8x3DVjMm8idn6XxMKROkiGKY3WGdELLq2kUBhxlG3
	UBwV+czGFmKbUYwT4pT89gPAr3yJHtwzB42lG4KPMT08WJZ+N1Q9aBZfRF9Bbxd7
	mw0RWiNmS8NKDA0ORu3zPvvxhsQVdQJv+r64ABqrzT4MO7jwrRYIAnIO6h9A5uUX
	QgubDv9l/sUS4doHXkGrpnLKhvae7PMPgaGc/dTgZveLkusnnJwGV92lSeub0lig
	ozqG03ES/Dios6CQ==
Received: (qmail 3086258 invoked from network); 25 Jul 2024 21:38:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jul 2024 21:38:27 +0200
X-UD-Smtp-Session: l3s3148p1@5F3liRcebNUujnsv
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pwm: renesas,pwm-rcar: Add r8a779h0 support
Date: Thu, 25 Jul 2024 21:38:04 +0200
Message-ID: <20240725193803.14130-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725193803.14130-4-wsa+renesas@sang-engineering.com>
References: <20240725193803.14130-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for the PWM timers in the Renesas R-Car V4M (R8A779H0)
SoC.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 6b6a302a175c..2fe1992e2908 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -37,6 +37,7 @@ properties:
           - renesas,pwm-r8a77995  # R-Car D3
           - renesas,pwm-r8a779a0  # R-Car V3U
           - renesas,pwm-r8a779g0  # R-Car V4H
+          - renesas,pwm-r8a779h0  # R-Car V4M
       - const: renesas,pwm-rcar
 
   reg:
-- 
2.43.0


