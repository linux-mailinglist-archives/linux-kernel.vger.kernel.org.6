Return-Path: <linux-kernel+bounces-280134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC40B94C631
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54536B232B4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C115A87B;
	Thu,  8 Aug 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EeyQJAZi"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DF1487FE
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151535; cv=none; b=fixgWL/64T9C94Iw/elc2JhBqtwPgu/FTeeDR/ahCHk8dv0P6MKBxiC74L0sVN+q6VVr2YElZOK4XnopOLSUt0SBHUgbOKRG+LOItlviEOPwzBi0OqQglzAfXVYhM51QRWksZHIearx9HqOBopB1ze7VtSH5EQoA63yrcQ/X3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151535; c=relaxed/simple;
	bh=BXCnPubHWZHh8bqWj73fx8w+O7f72GJPlz6ECgIDpj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s7efLZAJbK3rXWOFfY+w4FcyDCP7RL6RY4YP+bP38RKUmuhgfDAijh9IU+CvoQKlqQ034jiuroRmm1VRmMHkCoIIQGd/7sNZBuIev0+P/lUBL9aLhMrc9pk3mBAW9Cp3RkDJ8hSyma73ZnYbCehdpO5PWnI3jBvhi/mTR1CGjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EeyQJAZi; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5c324267aso791715eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723151532; x=1723756332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYsdvDV2WF5FlF8GKdTNudC9k0UxewQK/gFCEgnC2i0=;
        b=EeyQJAZiWfxSPr9y5sxKO4Tu+enGGBCdnWObC9Cnx63WCKfPirBwRgGvi8vlq20w+S
         AGL8Goh4JVHZgmT5JiGRoJZsVnde50XZhZIZa429Fe93btG35XIN5i6Egx93xCYJoH+B
         iD8k840dokW7th4J8cqTxY1dZKTsVKn91N93Hohi2vw8EQgqr4zaGDYEZFYuzkfUDs3v
         7zVU30I3tvoUTd7Soh5ZXzTm7bvhfzNAuvVe5XVsO4E+bJ03HlYV8j0UVfPUZ1iNrIc0
         2Ov/Pgok+NkBKIV4o7lAwkes339VeDebekEu8xglLePB44TxRnoMSRhgmzbDKsQsXjY2
         CKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723151532; x=1723756332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYsdvDV2WF5FlF8GKdTNudC9k0UxewQK/gFCEgnC2i0=;
        b=Z6HTBNsnreMJRcmLH3vdehIdcwjlmQMV9NPdBxcXBw1pg0m2+ydgGs/k7DPLZ/njpe
         kkourzdcclB3W1lTQt8Q7mIRlBzJOl8Pws2uRTckludaXD8Dyz13F5S7aOIpCETOZzml
         Fr9jNSumQqg2zyXwZe77qXFpa1SCZGPzuV3ikHKPGQvxZm53ruenQckRO1ua8ApTQCXP
         RVNMck4hib9k7kXYcNZHSiG0ESVpG93BLeM2KdXpn2223zfKofik2ZNGaUs+ZSDAidW2
         rykRtsdXm8suzvCDzvc5/X3QiyJCquU8jaIaNKggvu3FO1gfFir6bFbzJvJZrjO7A3dV
         bY7A==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5ruUgNnEn3VuzI/gF8yADej5g/JR3gKxuIAig+w/h8+sZnkzIkvEY5j+0nWKih3AgrmdXN7G0LwoM0AnksLN6rn9N5Qjva7Spk4Y
X-Gm-Message-State: AOJu0YxGMRVV1LFoo/d2ZgO1fr2P3rOPGbveDMayW/tiPz6+fVR5d+dE
	Lfh8mynVhE2GNQUCfRUeWz8Y8uutOX3DZsYwHR1MHvhbWFt0S/ty9KGeja7dKdY=
X-Google-Smtp-Source: AGHT+IF/7lNrPD7DeC4xdkrtYHEkdNoglsIWOfvBsfOx/jqlrW9GV+eLobq26DnYJ0NDU4qYjb0GTg==
X-Received: by 2002:a05:6820:178a:b0:5d6:1082:4f4e with SMTP id 006d021491bc7-5d855b50576mr4577013eaf.4.1723151532516;
        Thu, 08 Aug 2024 14:12:12 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d757179759sm3851188eaf.8.2024.08.08.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 14:12:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: ad4695: fix common-mode-channel
Date: Thu,  8 Aug 2024 16:12:08 -0500
Message-ID: <20240808-iio-adc-ad4695-fix-dt-bindings-v1-1-5cf37b9547b0@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

The common-mode-channel property is a scalar, not an array, so we should
not be using items: in the schema when specifying allowable values.

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/linux-iio/CAL_JsqKaddw8FnPfdnhKhHUb8AcTxFadc_eZmxjX0QxFR80=mw@mail.gmail.com/
Fixes: b40cafc11436 ("dt-bindings: iio: adc: add AD4695 and similar ADCs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index a2e824e26691..310f046e139f 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -136,8 +136,7 @@ patternProperties:
           and OxFE is COM. Macros are available for these values in
           dt-bindings/iio/adi,ad4695.h. Values 1 to 15 correspond to INx inputs.
           Only odd numbered INx inputs can be used as common mode channels.
-        items:
-          enum: [1, 3, 5, 7, 9, 11, 13, 15, 0xFE, 0xFF]
+        enum: [1, 3, 5, 7, 9, 11, 13, 15, 0xFE, 0xFF]
         default: 0xFF
 
       adi,no-high-z:
@@ -202,8 +201,7 @@ allOf:
             reg:
               maximum: 7
             common-mode-channel:
-              items:
-                enum: [1, 3, 5, 7, 0xFE, 0xFF]
+              enum: [1, 3, 5, 7, 0xFE, 0xFF]
         "^channel@[8-9a-f]$": false
 
 unevaluatedProperties: false

---
base-commit: 7cad163c39cb642ed587d3eeb37a5637ee02740f
change-id: 20240808-iio-adc-ad4695-fix-dt-bindings-520ade561235

