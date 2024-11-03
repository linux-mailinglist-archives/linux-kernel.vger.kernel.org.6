Return-Path: <linux-kernel+bounces-393667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A839BA3D0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CC0B21691
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 03:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284F813B584;
	Sun,  3 Nov 2024 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fys2VPE6"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249238614E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730605607; cv=none; b=OKu9v5i6zQvwQ1YMWYFhs10+3VTCtYpNGIiBYpmk74gw2j2uFlQtnumgrZaEha4+NZOuRWsuBOiTXRfrUXPKcbCo2T1CRtSPxQli2xdzlNTtIDwqpyRurbo/OmO2yLXJilOiwii2H+pBk5UxGsat5cr3b3fjbP/L1jGhVhMp1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730605607; c=relaxed/simple;
	bh=nodndSIWpNnYMRyxXjDdCYJsYRoIq1lmpYJn50Ochxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBvsBrloOgcXuxHZMZM8zUgrj7kR+/5SvtfB+60F4o1hDyROw9UtQ+64az5snv/s8ccmWanTsGcfC0Ucdn9talvkMDNIBi5tvVp4YSOnOQ/9IiFc4Q+DqBL78/pTWRGFl3e6zUOE4PXbyTIlBQsa02cEJmKolBuvqqLh6pgyl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fys2VPE6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea258fe4b6so67777387b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730605605; x=1731210405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cz24K1evmI78I2+NJg1IxStwGuEObzk+Xurvv5EPuVo=;
        b=Fys2VPE6Qab9wzngasVwMLk09jChIOT2UO/L6vgTl4RKyJZRXTt8eoxlZ/34hx3ynC
         kXebfkVIS5pUR14qDhVLerPqjfZDyNJQpODwDFxnETM1bEBgiYzCHtuMO/wxl3vZ5YEP
         DxmMiEBH1gpioFksFuUDfZ3FTf3/+B8yOznMDZd0s8mmjvqPPq0MJr/PjsnxdacQOti3
         5l7O53YZMxCoxa5xPbvQEDcuuqzWWTXU/1z3RTzDR26NAkEUaNVUK+/fkxY9pE/+8+IK
         ELoMh2nMSQKtSjpHdEUDNoXUlvy+Z1D7+SVp576xHsJwuf9nOI3pvcFWYWAo7RxPrPu0
         cLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730605605; x=1731210405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cz24K1evmI78I2+NJg1IxStwGuEObzk+Xurvv5EPuVo=;
        b=oucJHA5e4p39FWhBT2f4aasSUjyGxqW60jB+DFxPedkz5rxMoewmoTxK9gAcch2dW9
         VjwZa0w5i8rt/WxC5s/75nxfrf9UKMUCQnznrtR3/BpGRjZVIQzJNaSRqLFV6EpVGeAd
         8xiFoUMu5XXLnfYNqxa0p245gwz+e3AH7gLoHYYYwjHqm2Sbbu89q7TfxWpqVbc9IDxF
         4sRf9GWaAoBNayIApxdm6rUCD4quJQLpWjDlodWRZbWIpg/Aco+/LeUnreWmbMniP7lU
         8ftktg8ETyW8qYpIjprbUIFF5lh+kxKqtF2YNFsBYZ/mnLIZPl2GyPXxbjYXDmksHddF
         KOZg==
X-Forwarded-Encrypted: i=1; AJvYcCXzjm64O2gAju3PqLCtOG7Jaii7trbIOX55kt0CJgTAzwQ+YLPCrk4+3dfvGUpWXw50UQ2OgiqJLwmSMmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SoeymSXMfuggC76HyQJQrBlm0VwMRTH2j8JoYVf9DwnUjW0e
	IADrQzmHqgdtnVoEft0SWqKvkfKzFwlp2Ufixdubb7QDaRgQDOwRzF9owNp+6nKEPhtDOhqdId2
	IAw==
X-Google-Smtp-Source: AGHT+IE0WVlEdrG2GsvwLl5rNgi0hg5nY6f8ceJOB9AAUS82QrY7EXjnMk1ez03Plg1ISqeq7HIQNBHaDb8=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a05:690c:6f12:b0:6ea:8754:628a with SMTP id
 00721157ae682-6ea875466e4mr485267b3.5.1730605605204; Sat, 02 Nov 2024
 20:46:45 -0700 (PDT)
Date: Sat,  2 Nov 2024 20:43:29 -0700
In-Reply-To: <20241103034402.2460252-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241103034402.2460252-1-amitsd@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241103034402.2460252-3-amitsd@google.com>
Subject: [PATCH v2 2/3] dt-bindings: usb: maxim,max33359: add usage of sink
 bc12 time property
From: Amit Sunil Dhamne <amitsd@google.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc: dmitry.baryshkov@linaro.org, kyletso@google.com, rdbabiera@google.com, 
	badhri@google.com, linux@roeck-us.net, xu.yang_2@nxp.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Add usage of "sink-bc12-completion-time-ms"  connector property to
max33359 controller for delaying PD negotiation till BC1.2 detection
completes. This overcomes the occasional delays observed while
receiving PD messages where BC1.2 detection runs in parallel.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 276bf7554215..20b62228371b 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -69,6 +69,7 @@ examples:
                                        PDO_FIXED_DATA_SWAP |
                                        PDO_FIXED_DUAL_ROLE)
                                        PDO_FIXED(9000, 2000, 0)>;
+                sink-bc12-completion-time-ms = <500>;
             };
         };
     };
-- 
2.47.0.199.ga7371fff76-goog


