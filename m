Return-Path: <linux-kernel+bounces-558368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBC8A5E4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2857ABC26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF9C1EE019;
	Wed, 12 Mar 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkpWyZ6d"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51641EBFFC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809617; cv=none; b=rNAYTelqQjCrEbBIX/JvmSkFc5No13V/pDrJclLwGTwO2ykbAcq9971MBY/YdCUSnFXUbsYjGCFEhH9OAS4sL1axX2RKY0IlVV9d/FLNoexcZyNIX9K0M1RREnL2fvgcss+AtLf4tofePYxP2R3NpidwSsbu67VuUbrKq+EDTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809617; c=relaxed/simple;
	bh=WvRKKyrxPM0AndWhf5s5lTyd+m2bVCqjFHn7YN0dKLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mE7eYI418e8rezSkvi68F2zZ1YPHPrmPQwkOgCQ+LtSFhiroB/oW6e/Ek+EpWh8ZNytbZZ/Dl0ZaRlDliE/JROGRopL8P6qbreHWuhtxO0AWb9h4N/xMvqCSF5QPnC9+T8Df3tbZameAIPQ3kEdZe5EaLE5n1lv2GZcMu+7wAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YkpWyZ6d; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso403820a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741809614; x=1742414414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfELBOAwKsIn4f/h6RBx4PQYztLIiCjc1rnfMpVEC8A=;
        b=YkpWyZ6d4sIAz8Q71MhhkEIMYhEsZbVa2vGdNjc+Lift/1YfQ0N+DKzRV4HUsJ1uO2
         E8wLY56pRkrgJ6SVdPlikdW42MxWkg+3FLo+kw3vDaTNFLHmO/WYSfkSbQW2uCft+o8K
         2J2AtEgVE4YqYLVGyP0a3UYutpF/iariCJxyyLPnS5qMhGFGJAT3iztE0JIxJqrUO4qB
         LYHwfImJPPArq2p0WjOEmUeEXi2NNL+pIXMMVKVV2KNd2n/ZDjVNVWMjtQL3Xfh05oox
         Ey6o659P2/ZGiTKMz44g0Le2Kjy+rJhJe7luRdi5g318FnqOfDj/rxA8GCP4yJytTfUl
         t0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809614; x=1742414414;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wfELBOAwKsIn4f/h6RBx4PQYztLIiCjc1rnfMpVEC8A=;
        b=ZOA4WAQAya+nlRKV3vcGiy+TY+7z9W0/7J1zGYSi0v/umwOm9e6CLLxprarnrVACsG
         5LpVxQ2J+fWaLNaKCDc5jLXgM3/Zt321j3EYG8b8smo/HIkWo544gw5/RkvA76XVRZlq
         W9DBQxso27Z2dNfKUO15KTJrXUg3oJW5Qz2AHVp9iU+9A7YfWQIHyf8IwC+kvYqZw3Xl
         1EwOaxCGlDvpPShHMcD+pchqsaeoxVIBwlvwh53EwtPaP/Zlwxu/lTBTE6ufzsvdnryo
         BWCQ0ZycRMfzCTyV0hp9a7jTJXeWgyRn8+GnHpvgTqpjmsJ9FkKuugG1ROFYz8WwsDfL
         EqTw==
X-Forwarded-Encrypted: i=1; AJvYcCVmG8qcgNJ/1IymC6Zio6qE4zqusH2sABCoWzuPYSpue0Y9XWgCcrjxamV8wXzFMPPIB1Bkjudq64wb+Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOx+ykcRzS8tZvXpAraH4CTEtLvJcKDrJJf0YfF0ldTF1krO09
	bwhtQ5zOsD+pSE1jtNlP+3lmq6QS2qKwxzhQZxHzGN3pllS9DFm0+DUPAi0m9KAQJd941wW1xwm
	+8Q==
X-Google-Smtp-Source: AGHT+IE+MbUq96ItG8DzcFSeVabSk7TgmT8HCVRXFsqek/lzPUV/vp4+cJRf1j5i4c+BNQLVVm3ovOJuqD0=
X-Received: from pgbfm12.prod.google.com ([2002:a05:6a02:498c:b0:ad5:2dcc:552b])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c79a:b0:1f5:8126:8a5d
 with SMTP id adf61e73a8af0-1f581268cd8mr18624416637.17.1741809614269; Wed, 12
 Mar 2025 13:00:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:59:10 +0000
In-Reply-To: <20250312195951.1579682-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312195951.1579682-1-jthies@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312195951.1579682-2-jthies@google.com>
Subject: [PATCH v1 1/3] dt-bindings: Add cros-ec-ucsi to cros-ec-typec device
 tree documentation
From: Jameson Thies <jthies@google.com>
To: tzungbi@kernel.org, ukaszb@chromium.org, bleung@chromium.org, 
	heikki.krogerus@linux.intel.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, groeck@chromium.org, swboyd@chromium.org, 
	akuchynski@chromium.org
Cc: devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: quoted-printable

Add documentation for the cros-ec-ucsi device tree definition. Defining
this node will load the cros_ec_ucsi driver which is used for USB-C port
control on PDC based ChromeOS systems. Additionally, update mantainers
list to reflect changes to the ChromeOS USB owners.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 .../bindings/chrome/google,cros-ec-typec.yaml       | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.=
yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
index 9f9816fbecbc..ab39c5280681 100644
--- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
@@ -8,17 +8,24 @@ title: Google Chrome OS EC(Embedded Controller) Type C po=
rt driver.
=20
 maintainers:
   - Benson Leung <bleung@chromium.org>
-  - Prashant Malani <pmalani@chromium.org>
+  - Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
+  - =C5=81ukasz Bartosik <ukaszb@chromium.org>
+  - Jameson Thies <jthies@google.com>
+  - Andrei Kuchynski <akuchynski@chromium.org>
=20
 description:
   Chrome OS devices have an Embedded Controller(EC) which has access to
   Type C port state. This node is intended to allow the host to read and
   control the Type C ports. The node for this device should be under a
-  cros-ec node like google,cros-ec-spi.
+  cros-ec node like google,cros-ec-spi. On TCPC systems, ChromeOS should
+  use cros-ec-typec. On PDC systems, ChromeOS should use cros-ec-ucsi.
=20
 properties:
   compatible:
-    const: google,cros-ec-typec
+    oneOf:
+      - items:
+          - const: google,cros-ec-typec
+          - const: google,cros-ec-ucsi
=20
   '#address-cells':
     const: 1
--=20
2.49.0.rc0.332.g42c0ae87b1-goog


