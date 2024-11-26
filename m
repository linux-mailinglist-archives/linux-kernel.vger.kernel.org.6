Return-Path: <linux-kernel+bounces-422075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A969D9431
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE8D1610C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043DA1D31AE;
	Tue, 26 Nov 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pR77m9w4"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA81CF2A2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612880; cv=none; b=uOcogeT5V+mCdw3NUUqPDWQB670fwGlg0WRdJBfMlllejoUZSUEEOFAULzWzeP3fWdpEY6rMoK9aOMIkV5CCLi2gFs3UOk4nePoEJQMlkppBwa8haIILn/Uq9/e/SgVajqLN3PuumL9rPuzY3GLoJBcTU3W2GgNc7O5SuJgZjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612880; c=relaxed/simple;
	bh=lMDTraku/x7/L+HfQFFu+VuQD5cryMGir72e5kDEJHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZCF5bFUOLHBp2dpoOU5lpi86s/SrxdhwiOGO4JbnuKMQbK9OkbxkcKgDKDThQO8twfLq2/c4WV8YxzVZ0J8fDQAjm2GB+gdNNmxg9N3Z3Kh8sVZsIK2A1Q9usalNfGOkMOrTUi0VgIhnh0/cKnb3AaL+o0i1nepLDmn8W0DQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pR77m9w4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3824aef833bso3901486f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732612877; x=1733217677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWc+F6Re5lYpUThTPl2Jyvuy/tQl0uxdBQ2YGVSL9kM=;
        b=pR77m9w406KSH80pqt+Rw6/mp3tHCZZNEafG65Xyl92uhWFAujhH0fhEOiyG0O8qBR
         fT3sNtG/pMXSSjkZ6jgF+4c4CBVtxY+RTCfuK8trH5gSbwEIapgP4HYa41DWoqBNd3Vb
         BiDdVc/p57SwlGi1JLopl9iZ11ITRfbsPSouF2xqkz4ZvXh/0ei+4SWY78vK/KPdscWZ
         jqaCYZBmt8X9fUgO3BJvEhILEY2b0ucpVV9iaCvXa0vnIdDZFyzvYU9kEilMvD/cypRl
         WQQnJl32wXtcJb+pn9far95lOTpZ3LrTNx689T2PDlzchg5d6hnOo1vFDhsjx9IQA4S/
         nvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612877; x=1733217677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWc+F6Re5lYpUThTPl2Jyvuy/tQl0uxdBQ2YGVSL9kM=;
        b=vj4BbZVAxARn64wZTfSL/DfFJM9oWIIM7ztVmiD1TsXbdWu4dhyKULIWdnPp4OOKiN
         5Yl24I73QfP/cDExLHOenHhjxP3/TyywDM/YV8iuftMmDHJpQhDd6ND0OO6dnShBzPim
         NkkxyGRDEHtL/SmMKkuku7HLIRth0KIluWdwRi5VnAatjyL/UuMJzxVVF4QiM/Xv0T8q
         vjVvgx9JOSJ9BJoyvhineI7s/DK5TTEuMlkzSnSd9YhTQrhN/CS3Tm7sYwzJEgxQIwwx
         CE9lFZ7Qp2A32srmks/umU5vMn2huKJFQjd2NXodK+jjr20CjI1eb4YYY8KIpwEXQL4w
         5y9A==
X-Forwarded-Encrypted: i=1; AJvYcCVLpzu1gjLIDGCUo9Wc0xG0AQCYBI1oeKmP38ddtzqcijOxMNW7ce3ZkaTNSotrdeCOvxrtm6EZXLqukbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwerXyg6tCz5irBvAX2VOmJd7E7Hcltcid8SSxwz6d1iiHycdG5
	ZHw7U4XRv0JayC/k6fZ0buSPzcOLRL5QMgSTQZBoM2Spz9xEmvJv31dlDhcwPP4=
X-Gm-Gg: ASbGncu/Y/RtmR2yy/tUMmI729y0VnY5xrBSMFmfE6bDrT3vaOCE2O4tmAs4eEWPuNG
	HiDlBCkO/OQTL6a+o4fckEylFjbwk4oqUDL+x+WYC3JLOcr+2gxiRs8RhU8LViqh4FQXP48wVOH
	ydMF75tGx8hBYenqQMGKYkbsTWsZOxg4gvUn6jx9kf8AJxeevg5Vg4Ybpe+45S2kTX48QOHeUTE
	utH3Ngsv0zLE6yWV25uoTlKgBThQ6slnfVDB0KLmw8QJL6vR8ZQg2MqofU710qez0MsS1gj9KOG
	XL0=
X-Google-Smtp-Source: AGHT+IG3dGq/ZJlhJq/NurIWM/G3VWbjsNdFTR8iP7hMyFJIs0S9/bgfBkT4zkY71Su/dQBJNJTAFQ==
X-Received: by 2002:a5d:6da4:0:b0:382:4115:1ccb with SMTP id ffacd0b85a97d-38260b45f98mr11753556f8f.7.1732612877138;
        Tue, 26 Nov 2024 01:21:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3a47sm13027694f8f.73.2024.11.26.01.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:21:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	yoshihiro.shimoda.uh@renesas.com,
	christophe.jaillet@wanadoo.fr
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 07/15] dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
Date: Tue, 26 Nov 2024 11:20:42 +0200
Message-Id: <20241126092050.1825607-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The reset lines are mandatory for the Renesas RZ/G3S platform and must be
explicitly defined in device tree.

Fixes: f3c849855114 ("dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S phy bindings")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new


 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index af275cea3456..2babd200bd98 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -105,7 +105,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,rzg2l-usb2-phy
+            enum:
+              - renesas,rzg2l-usb2-phy
+              - renesas,usb2-phy-r9a08g045
     then:
       required:
         - resets
-- 
2.39.2


