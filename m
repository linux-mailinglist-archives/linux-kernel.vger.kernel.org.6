Return-Path: <linux-kernel+bounces-373408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 829559A565A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA30B265A0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260D819DF8D;
	Sun, 20 Oct 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz8kYjGD"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E4198850;
	Sun, 20 Oct 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453259; cv=none; b=tvdQcbdguOx1Az1+TUTV+DR96ok0Pi8CgOQbbmEKEoZdBd9AF8aolnBjK4RCKr0haP8Rpz/wJ1Iq93mTZhcLr1dij447V4Jj+k9h4ytxUZGUGh8z0AWvnkQ0O+muL+JUXqmI6b6NZdAcgqsi6Yy8VF9V/F5bo94jeISBBXMWuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453259; c=relaxed/simple;
	bh=27NvY+oqHgSkrI5lxkKLYnp4X//jaOa/2qmioyhBup4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppKAlS+OCv0z9oiWEVti8KXGtyUBKs4xByQkcky5VHYXSxcH8fJT6KUPKlt1XwzRqFXwGoHqf4PygYUU/2YacJrYT/ebhfnBFMAJqqd9RD3rz7fsHw6LfdU3ipD6vRbc3AvaMxffUxhtGWaHYyle/YQ5tMn/WYe1OCE0bIPXZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fz8kYjGD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a68480e3eso25265766b.1;
        Sun, 20 Oct 2024 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453256; x=1730058056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY8Z0h1B9qGZ8W4gBKFGpJTQoZr0iEHUbZV6WjRURpU=;
        b=fz8kYjGDCjUutXN7UiK79MRUtmvzBoIX0QHNljy8CJrXIFUkPv9/uRjSBs7sDVXzgo
         iqAOiUPq5GNvWURpkDjcRywsCPqEUPTzKBl3vwl2UqUkMcKSBlJSp77M4qWsAsErON3j
         HgucCtOqCqfl0jblkD+xFtC3d5dK1jzy+TyBATS+cnQw4nOdchm5+3+9+3rO7CFzaFap
         wjMIgKlsQ2BVAGhdymz+x4GHHx1/2wrYYFlNw4FDF4OoLanx8mVjHv8sOorqiv3Ja4iv
         C+4xMK4Ob0HlBrRCVkVHtym8PkHgnLjVLV7Q+mDJx7ap+qYKtUJI5+AIT+fw+4Gr492p
         /Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453256; x=1730058056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tY8Z0h1B9qGZ8W4gBKFGpJTQoZr0iEHUbZV6WjRURpU=;
        b=T9nNSZ5frTcFIDYvMfSNyRILFnfl/MMimQB+oX49DO11zAmQpIfBYNXh9ve8/2lnS/
         sWJmwpbGvMrCW/1f757S2kdNGkAfUPWcSej+Ip6SmIRkwNEO4DGc19j8BunRcyqU9hEv
         5ZGehKZWvVZFtj2nNRlhBdhvY5jHWJaSINcsgNuFVrI2YJICn/ipBye+yPJGUHRQB2Is
         ITJc97FGnXVVYn3jMKL1EgO82jUvvorN2N8xVeLUsbaxQ2emWmX08SeSjCrGLqSBStQp
         4skDt+sJc7ntEOmbZGxrROsEU//cM0X3qeY7nIHGz9bfEWSdL9IIBFTfILhWWb646Iwg
         fJag==
X-Forwarded-Encrypted: i=1; AJvYcCVOkkAgS3UEu2YkyW8V/mLjNKE9EhfS0+q8ZdLJN/n9xYrqjmWwqqsSUUzNh7lxfwjNQ7SfGGPRSHMsRPRM@vger.kernel.org, AJvYcCXQYb0mx2YxwM6IT41Tq4X3ZT85+cdvKrE/xDwfBBzBZB5f1t59rQrsJz1jtdPYwI8DzKLWUg9EaNQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXMMsqZxfxrBwzmGnnSymkeb9FXXS4CPjoKNz2QlCuu5kUZTS
	fM52N+HdJxcJbSmd29YwkTnbmXa6lR9K/ELEMGwjrAunPASUtXD4
X-Google-Smtp-Source: AGHT+IF/F73Jy/FxCOTDHDc1P5tF6T838SLhRDeGjm/Gb4Pn//weTPZgOPtZgtOnaLtt3Y3Ksc7UJw==
X-Received: by 2002:a17:907:94cf:b0:a99:f388:6f49 with SMTP id a640c23a62f3a-a9a69c9bd69mr441408966b.9.1729453255775;
        Sun, 20 Oct 2024 12:40:55 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:54 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 18/23] dt-bindings: altera: add binding for Mercury+ SA2
Date: Sun, 20 Oct 2024 19:40:23 +0000
Message-Id: <20241020194028.2272371-19-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the device-tree binding for the Enclustra Mercury+ SA2 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 87a22d2a4..31af6859d 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -61,6 +61,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury+ SA2 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa2-pe1
+              - enclustra,mercury-sa2-pe3
+              - enclustra,mercury-sa2-st1
+          - const: enclustra,mercury-sa2
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.25.1


