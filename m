Return-Path: <linux-kernel+bounces-420585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D63A9D7CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E871634EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217E188591;
	Mon, 25 Nov 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VM5qWAB7"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EDD18C32C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523494; cv=none; b=Z75X/gFCW62UO9t/q0AEqG/SnnISXUT1PwxCign6EE2wnbBw+NYJGH30/Ua/+wRH19fxhgsGLrALZcOWHd65FTQsUb7RZ6/uk6AbrJeXHi1cvwK1SgxkwNKgv426I/K/0ov1zZtFIRo+7eom1P5c4gGZv0RqHui6CorZ25LZ1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523494; c=relaxed/simple;
	bh=ktJPK16HT87IqUYNk6xW4DxEM+thEREPtW8kVjrlImY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iR/7YNlKYu2bdFlqj/nrpysru/82tfYNOc1eBcHMMSMLYYyQBuzez2wdhCjkDhJK2r/ECFXrmD6RKVG6l5p/ibZcwVxnzzN3cHzHNQxjxxBM12geuGqfUQm9UE+xllhDWCaouuyLnPxdRnE6stR7Q8SREJ+7cfFtSDIoGMI6l6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VM5qWAB7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21288402a26so37629935ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732523492; x=1733128292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POCxcDAs1OPhEdapqaVu7R6Wv3Kn60gIQbQM6aiBFqA=;
        b=VM5qWAB78aQWuRBbdou8G1Lxim/wNWk60mcDRo60vJLSYcU2bsc3nTyJ6M8rRYc+rL
         P11itXOS/f3ubQpn7G3qFhp4Bwj3lBru6Hfirx0dR+e7VOOcens2t1IUh9eRpuh+bi4a
         5oq3Vkg6xqAdT9G/6zVRXYAgjrAo0+RvSEiao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732523492; x=1733128292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POCxcDAs1OPhEdapqaVu7R6Wv3Kn60gIQbQM6aiBFqA=;
        b=Y/g8RHCvEm4XCIdlNvyGk357U4yRlwC1VrhfrOzDaVB2TFS/9uh/PmD/STiuIpcQiL
         oE12b4gEWIK3G1bYrqwHNUUJmcrUFP1n6tjk8qrBA1t1Xn+ohKncKc213bo5asICZ5K5
         LXvaXg7O3vzRP2PqQDp8Di75ZeZFjPNVKNLj8yt+AFPkMVIJeZqCTWP6vxs00nuVzuN8
         rJcUS1YnX67bkytbgIIHjEu50JNYcd96wdYzfW+espGge5gI6tE6YibusyYm4F9nkA5p
         IGM2axcJOPyta0/96/1xtmm18SCnVefPzCHdy6GEA1bXooZSVLMwOEBmrI/CfZJT4B/u
         2hyA==
X-Forwarded-Encrypted: i=1; AJvYcCU65nemVJp8urin9JmGgssEI4m2efXQwN1wwT1HMtiq+ytf+90ricQjFsrsNTlr4hf7D3YBOlE/2/+14gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMtRb0KYnXOSEXpaBtPPIiYEGkWITux0hFK4LsBNF1wiR5vuo
	enzxg7/uTv0HW6G4x8BMJSV/XgTwpxWjnNtRjshdKDzB3ViKAk4NFgitiwaOTA==
X-Gm-Gg: ASbGncv4kpIUxWs89gGjG3QUfwgIVgxTCOkFKksLcYlcSai4uzp0kLAlDuMrNjB0WKf
	whuHCgbQxTiCc63Ivi/FV2sY3ocmhra2mCW2jW3LZdMpx4zyFLOzPdD5LFuwxe3moojDKtukGo4
	PBy+fewY3U6K8Qqzrr0lOl+4x+9/htXvhGgqe2dHYjDnnVuj+XEkuLn4Cn+FgPAx7B+0+bFgPav
	G8e6B2Hh0QQX1BiWRHcJXrUkDoA7JIaqBdjei+0EZ9ixw/FJ8dsOVJqw+2Hj1c4EFmwAQsP
X-Google-Smtp-Source: AGHT+IHSb4l363kSqeAiiJcrwoOGnozawSDBYK+oCcUIkkFt6/AtetpUnMMRtlfX7k/Ckh1KEU4bSg==
X-Received: by 2002:a17:902:f685:b0:20c:9326:559 with SMTP id d9443c01a7336-2129f240de5mr179893455ad.29.1732523492519;
        Mon, 25 Nov 2024 00:31:32 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:66a3:d18f:544f:227a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfece2sm59090025ad.157.2024.11.25.00.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:31:32 -0800 (PST)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Mon, 25 Nov 2024 16:31:17 +0800
Subject: [PATCH v2 2/2] dt-bindings: mfd: cros-ec: add properties for
 thermal cooling cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-extend_power_limit-v2-2-c3266a86e9b1@chromium.org>
References: <20241125-extend_power_limit-v2-0-c3266a86e9b1@chromium.org>
In-Reply-To: <20241125-extend_power_limit-v2-0-c3266a86e9b1@chromium.org>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732523485; l=1439;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=ktJPK16HT87IqUYNk6xW4DxEM+thEREPtW8kVjrlImY=;
 b=FpMKgfM5p9IzbPe7guqbp4Vjag/aqYKH4JxQjr2hWl48PN/wyJux8YdE/6fm8+fY0+2OLaW7c
 ohiglj075PQC4cCEHOJcL5SCqRAmB2aBhq+byXp6ug7DAA8KeGSGApQ
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

A charger chip is connect to the ChromeOS Embedded Controller (EC).
When external power input into the system, current would go through the
charger chip, generating heat in the system. The EC supports limiting
the input current, thus reducing the generated heat. As a result, EC is
a simulated passive cooling device.

We cannot reuse the existing charge managing mechanism in the power
framework due to:

- The power framework requires the charger to expose its thermal status,
  which is not a supported functionality on EC.
- We need to use different thermal sensors to run thermal control,
  rather than using thermal sensor on the charger.

Add the property '#cooling-cells' bindings, such that thermal framework
can recognize cros_ec as a valid thermal cooling device.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index aac8819bd00b..2b6f098057af 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -96,6 +96,9 @@ properties:
   '#gpio-cells':
     const: 2
 
+  '#cooling-cells':
+    const: 2
+
   gpio-controller: true
 
   typec:

-- 
2.47.0.371.ga323438b13-goog


