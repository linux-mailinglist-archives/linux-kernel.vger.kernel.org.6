Return-Path: <linux-kernel+bounces-175906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A68C26EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCCD2869C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CFF16F8EB;
	Fri, 10 May 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ntflsule"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2914F9D1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351729; cv=none; b=Q3H4un8X8POQf4GApKuOMlqYIXWoMf1nJPJd1czEu0XaynscrHVpFkykJNIn0wR6YkMF9xGItoP57eN2HiNQIpEh3Gqa7HlIJJwtfbG6jud3poTUmKPtwjXMSQVVs13+qQS8lh+riPlS3p2w9H1j8b8EwbrEQ08j2u0VD4tmFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351729; c=relaxed/simple;
	bh=kATQMNOhJrdbief3Fgl9OA3f1yYFHp3atah9Ebe5p/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSHWSNafo/KIWCUbJTp8BfFR2NvbePH0Kg9CePJpnvJjm6yLtV3qw9sxmPh64gUgFH+DiJE/lXkMaS7fLHKl0GikHg2AkBP+15kcmleh4pFZ1DXQjmmyXzcmI2i6r3w6Xq7dYJHLkMX4xAqJm0C8RoAFeQ9jB1SdAb+yy2kGtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ntflsule; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e3f6166e4aso37382651fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715351726; x=1715956526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhvBTKrIEHNw+3a6hb0Xwmt+4VWhx+P/N8uTLnP7/w0=;
        b=NtflsuleneyiSe8fyggklJJCyZrlNS+7h+NUOYbNLGh4/vwTPZgbtMd3BZFsbmNjje
         VYvWEWwBduIMmrhEwpmXXkFUl6JFDr+ZEtbkKQNKC8V9DySLTyHeuXQtOxCWepoSWz7e
         EniYE7vSwdJ8D9jXdLLN1Li1JMbnbs2+jrqviSzSQ2H5DJF65ONhQSfrF2yqoSXnDkr1
         C4asEYE0AYlkhj7LbXjNmRsr79sMEa5lcf+Lg/pV8SvNQWggoSnPHBq40D15pEJ3ePxi
         ZcZ1J5hRaM50gYV0yuCn6dbBeaUyH8VG6HIuyOhfsxAiJDvp53j06bC9fR5IQNOisQ4i
         iBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351726; x=1715956526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhvBTKrIEHNw+3a6hb0Xwmt+4VWhx+P/N8uTLnP7/w0=;
        b=jYa24sXuYm9GmtCUFy2D6OcCnFQ47mxA8v8aX9sxXaJq4Z3qjIsVv0EO+XFiQv6d84
         d6vPNuckSReDEe+UrNDoR+NWF8w2B3OEwShu8I5Pdw7lBUadiCmEaVRdT6KuH0Uqvxdp
         cs5BGIcttU72sJ+9mh+WLD2mvyv1Nbz1XKesCGJPHFp/bc6ePIxgzu00pVxea0xOTt3v
         dISkBoqlPkw5lU+dipzlqFSYtI9YPBobm+Li8u09AHOzLsC9dzDakNOYQFAnPPj22gHZ
         UQEWKowY0Jk5YAnDHEHTEtcDcoJhfrYPW4xIVkLKklET5zPlCFHiYbM/bhbx5mgpNezb
         PvOg==
X-Forwarded-Encrypted: i=1; AJvYcCWR2j9QAwqnd4o4GC40JGZtdst9vBJhpFuV3ur+LeNlQLsatT0PUnJPAbdtvddVeWB7UH5DJtbDhy8nk2w0zRdqNklmJKhA4AO597Ub
X-Gm-Message-State: AOJu0YwIGS72inFzoFxBweBxOqHZS1A6zgSC0tI4nmnxYAQU5DMdSpEn
	mXGEaRCMefc1hjrf8B0EQxi1npYHdDHTWmmtMNbXFe93fOpTGiw8jKkOnrb2szY=
X-Google-Smtp-Source: AGHT+IEAC9dVjDMT1UPdVqARhjQhRcXJv3fsVQDnUMR3w47CcGcW+O53nF2+nRJEW7ujUyZvmdSP2g==
X-Received: by 2002:a2e:bc24:0:b0:2e0:83a9:e385 with SMTP id 38308e7fff4ca-2e51fc340a2mr28548151fa.6.1715351725643;
        Fri, 10 May 2024 07:35:25 -0700 (PDT)
Received: from localhost (host-95-235-217-160.retail.telecomitalia.it. [95.235.217.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7fc4sm191151166b.135.2024.05.10.07.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:35:25 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 1/4] dt-bindings: arm: bcm: Add BCM2712 SoC support
Date: Fri, 10 May 2024 16:35:27 +0200
Message-ID: <e60ee068f06cb2325e3d09c27b27002ba6db8572.1715332922.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715332922.git.andrea.porta@suse.com>
References: <cover.1715332922.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 SoC is found on Raspberry Pi 5. Add compatible string to
acknowledge its new chipset.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 162a39dab218..e4ff71f006b8 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -23,6 +23,12 @@ properties:
               - raspberrypi,4-model-b
           - const: brcm,bcm2711
 
+      - description: BCM2712 based Boards
+        items:
+          - enum:
+              - raspberrypi,5-model-b
+          - const: brcm,bcm2712
+
       - description: BCM2835 based Boards
         items:
           - enum:
-- 
2.35.3


