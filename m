Return-Path: <linux-kernel+bounces-306728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C378A96429F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331DE285BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEBB1922E5;
	Thu, 29 Aug 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfQzBVzZ"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCE1922D0;
	Thu, 29 Aug 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929540; cv=none; b=Q3OIJKTNS0spw196pQtRfkJYew2HXGnVr5glZ74tQ13oPGE2OKD3sNjJFqAOpqLNOwiPUth8aIYqv+as/yg90EjWQgjqrB7L6DpqwXKba4KdKHxGoTU7TIV/zPjWpxJ+0+gH9s+wcRX3Z2Y7StRdwrgIuMZM6nL9Bm5U4puWNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929540; c=relaxed/simple;
	bh=/j92o8XunxPaVAVtxYK+L07dpPVfhrWfpRqf2TFJOz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1dVSOrieMLxBfNY17gjbPGUxqyV23lsyb1mnT52MQaQNJ3Z1qaqbsl2wI6OCiBLTEPhiNTWBbPFhIQHAFwFhw/HhVKDsq+UAcJeUf+Vl1MxLE+WtFzUFfS5egHpKV8lrcN3Bf2nvLOn4MsaPEzFCzJv+IFFQqSLPq4W2hryyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfQzBVzZ; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-842f3f275d3so274786241.1;
        Thu, 29 Aug 2024 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724929538; x=1725534338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ianpNl3jL8Gv0lHeq+hByhZnx3GF6W02IwZ9uRWxMpQ=;
        b=VfQzBVzZsFIxCHpGTg9V6L3lr4uxnGK5EFlaexGU+ZlRyYAnqdxycvHqexA07YUSRf
         KQCdqB1It2lYbZE7ZfaLan3g4nWbyIDOYe+mIiFPd0n/KJbX0pGk56a580j54VW53yLu
         AQqlz3bTRbSLMV1yletZiUJY6oot1cp4ng90ZyFMTO+3U+98nL2lEO+v6qvPM1MhJvga
         Yjf01WL6CI+ZS/KfDBKF4p1AyaAR/IXp8FFJXY6koXOX5sk5dJhYgqSTCih+xHCQEEn0
         UbZCNH+an7iIkmvN7IQEJw1BKVWeAuwWdLC+dP+qhL+cCSjq5dfIRnJpb4lQW7WwDSKl
         SnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929538; x=1725534338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ianpNl3jL8Gv0lHeq+hByhZnx3GF6W02IwZ9uRWxMpQ=;
        b=dieKG3a5svbf+jW8dzO0mrh15kNuCzH9fjOo7vg46oNycwZMzvQn7WdVAxDco2TCbS
         bFlPxvVrjNbpATv45GtG2R6RPMX87zBd+xwDhWHrIFHSfdzD0uMsd4h206ZRwKmBXOKG
         Z0RjrtJWIZ8+6mzyhqNjwnR83d+simPneWUGw7v7dttELEQjcaYu6tOsR99RaJXgvp9T
         YoRJYldWdpJFVuFwfS/SvXuOekILfSIPn42ln72mcCrEx1Q03SbyJEtrRGnEvTkh7QMM
         QGVfd0FV6I4tehy7E3NLbt1t/N9D1VvJ+lwfYP8uiY1Aly0R4+6c6pXOz0uegbhHQNTg
         lQRw==
X-Forwarded-Encrypted: i=1; AJvYcCVK5bvclIEDTC2ipPC493ClpSNKJuZkgtE+Cip8e7RWMcxfIby4G/bFXfUQnJ2WjKF9KLUt3tIxTYpCVsQo@vger.kernel.org, AJvYcCWPsrYmntbkzdPSewpqS/iXaFBqLmYH426it/z55K/wHOcsUKWyujeyLk4xm01QeV3QJXrZPH/j4Jvs@vger.kernel.org
X-Gm-Message-State: AOJu0YyVm9k+1hRFc8qJV3vcMzBaDQ6D+qUuUrz5k7ci4pdq9wu2yU6X
	vpZ1B4xWu2Q1SK2C16MeOh4tKiHXNwk59BF+eA4z3eWgVd9vBNcvGJwHDXxzRsA=
X-Google-Smtp-Source: AGHT+IF6yBcBMzp8rTNq8i+IQc91e14+ebz9MBYVssN2nRk8uZQahgLcP+UIaAxH9XbozPbSUz9pQw==
X-Received: by 2002:a05:6a00:a1e:b0:707:fa61:1c6a with SMTP id d2e1a72fcca58-715e78ce1b3mr2227273b3a.10.1724929527263;
        Thu, 29 Aug 2024 04:05:27 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e5576cc7sm906671b3a.32.2024.08.29.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:05:26 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND 1/3] dt-bindings: apple,aic: Document A7-A11 compatibles
Date: Thu, 29 Aug 2024 19:02:15 +0800
Message-ID: <20240829110436.46052-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829110436.46052-1-towinchenmi@gmail.com>
References: <20240829110436.46052-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatibles for Apple A7-A11 SoCs.

There are three feature levels:
- A7-A10: No fast IPI
- A11: fast IPI, global only
- M1: fast IPI with local and global support

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../bindings/interrupt-controller/apple,aic.yaml          | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 698588e9aa86..2e38b585a722 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -37,7 +37,13 @@ allOf:
 properties:
   compatible:
     items:
-      - const: apple,t8103-aic
+      - enum:
+          - apple,s5l8960x-aic
+          - apple,s8000-aic
+          - apple,t7000-aic
+          - apple,t8010-aic
+          - apple,t8015-aic
+          - apple,t8103-aic
       - const: apple,aic
 
   interrupt-controller: true
-- 
2.46.0


