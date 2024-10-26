Return-Path: <linux-kernel+bounces-383037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043919B166B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974511F2312D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A451D2223;
	Sat, 26 Oct 2024 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7qMGoFg"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604E1D0E28;
	Sat, 26 Oct 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933737; cv=none; b=goocHch7RV7y0/jpEI0h8loPTYMOwJsKZuB9BHNaKTxOBYSyVBN0oS1jGfU5VitR5oP1zMXJJPbl2qLbDzMaUPicUOWN45oebAx6RprkrglAY+1O6/hK60Tkftd2gLsP4eyikGnVStY9mubiX5lDvV+HWs9Fag05tl3n45Odo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933737; c=relaxed/simple;
	bh=siH1oVdbLXkLgmnymW3nRJNjsOpI21J5yjja1M4RzDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8aqJwZX7+BWx7uvqpN2jF/dmLOedh+bN9niiiRegrOJq1eQzKX8onrNj3EWKHEtR4MLJWoPH2OKHEAxTa1nNswlL1VrpQB1dxfZK+K7E4kDnLyLkJMcH6tAoa9GPRO/uCA7cE/7xwn3Se/bcr75r8Q38pmnQef4C8Bfrr4c0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7qMGoFg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c94a7239cfso1522141a12.3;
        Sat, 26 Oct 2024 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729933734; x=1730538534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jB7vnCcNMaJNbXRa9I5NK9mJ1CVmQDLVMtOS2h9/iKc=;
        b=I7qMGoFgSze9KtBpSJM2V4Zn+BiLTIu2OWNx+Ybxiy7Y3rEpnkDRjSleZpKZP224cr
         w/tQ/7Yf0u+m1xZqxC9ankaC9g/EQnUvCx3O7h1xo7lS0y/ZXFdEJmfvXsNwt7Y1WJX4
         h0OO7gOcl8vUU1h5u6SjFEwIR4xM5euiJl7w6NhnAYX4BgYZ245lnZh+tU7o8YWgCUys
         RM2Dl7fzoWh2oZbA7fUjFNYzaR6ZkzIRbLBRfsAEvXPvq+DFX/s7fOFBCO2o9R48BEfk
         E3xuJosuJTMFgsJs0jSMnrCXn3xUUpAEVwfHN8Qb1jHDJCf07UxQget5IQ+6Fk2RNkqc
         020g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729933734; x=1730538534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jB7vnCcNMaJNbXRa9I5NK9mJ1CVmQDLVMtOS2h9/iKc=;
        b=gTxlpiGDIiJUF0Ih4jLqInszYgrEyJd+ViK0xFiHcaX/CKU5GkOz4S5R4xpqTQCNbq
         6ymuWURTMpH9daNEEmQ57YJkn+BtH0GdVFPsRFKskTloh5lqsY2HHkz4xJm/Qw9J2T4C
         HE2hCagFsKzuZKN4dhTFbIw9/mzDRpS3l0k5eq2RW1DThVFuGQALK8jKGobG50KZaCfo
         M96HSz7BctXZlxOcyxWOMsCd5qt2h+7BKN0dfxrZL6uIv/AOJaj4GskrZGMHiuZujNz8
         gwj4YvGzf4bud58UQCt59mbNY6ioDR3F2vLB80Pt6PQahzXfM4fkoLG4KGDGdzb3HlpH
         xpvw==
X-Forwarded-Encrypted: i=1; AJvYcCVaCwz8cSkmTAM/fBaDLaYYPhQrnRJm3+aIS5os000myp0YddS6JSM55bVyOhPHldfp9xOQm2Ea7TbQ@vger.kernel.org, AJvYcCWnc2W8sKp3ZOydeSbreXkTwNGoPbWHvsoGzkhl5sdJmbckQlY895epMSZ7/3eQDodJfudQDWFci9WYRPCn@vger.kernel.org
X-Gm-Message-State: AOJu0YzLX76I6443jcplSC+waxgzVFzXOFPvJTtY9fra/rjvHrMwCCO7
	UHEKz4iS/QB14FGm/k3TvjmuQIMAuMRcH3oWPldbat0RQB5gDIqZ
X-Google-Smtp-Source: AGHT+IFWVU8c+fv5gqRDDfXq8/nib0Ts9tpQk7jPjW2VInM+Vb2Ynkzlp9BPxGOyNu1o7twLach4Fw==
X-Received: by 2002:a05:6402:3214:b0:5cb:ad98:7ad8 with SMTP id 4fb4d7f45d1cf-5cbbf8dcfc8mr2190124a12.19.1729933733657;
        Sat, 26 Oct 2024 02:08:53 -0700 (PDT)
Received: from localhost (89-73-120-30.dynamic.chello.pl. [89.73.120.30])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5cbb62bf52fsm1342351a12.40.2024.10.26.02.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 02:08:53 -0700 (PDT)
From: Patryk Biel <pbiel7@gmail.com>
Date: Sat, 26 Oct 2024 11:08:45 +0200
Subject: [PATCH 2/2] dt-bindings: hwmon: Add ltc2971 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-add-ltc2971-v1-2-109ec21687bc@gmail.com>
References: <20241026-add-ltc2971-v1-0-109ec21687bc@gmail.com>
In-Reply-To: <20241026-add-ltc2971-v1-0-109ec21687bc@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Patryk Biel <pbiel7@gmail.com>
X-Mailer: b4 0.14.2

Add device-tree bindings and documentation for LTC2971.

Signed-off-by: Patryk Biel <pbiel7@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml b/Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml
index 1f98da32f3feb9899ccdcc15e70ce275a74c63c3..dc3d19a383e8098516d6d2e6ff50f52883c4b8cf 100644
--- a/Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - lltc,ltc2971
       - lltc,ltc2972
       - lltc,ltc2974
       - lltc,ltc2975
@@ -45,6 +46,7 @@ properties:
     description: |
       list of regulators provided by this controller.
       Valid names of regulators depend on number of supplies supported per device:
+      * ltc2971 vout0 - vout1
       * ltc2972 vout0 - vout1
       * ltc2974, ltc2975 : vout0 - vout3
       * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7

-- 
2.43.0


