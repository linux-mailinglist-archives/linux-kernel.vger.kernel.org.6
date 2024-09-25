Return-Path: <linux-kernel+bounces-337944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B27998514C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625CC284B38
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B15F14D2B3;
	Wed, 25 Sep 2024 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfUq7CDt"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899414AD3A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233912; cv=none; b=W28JwU20wQNHGKhzsK6LWUbzIbY0V6MYyYqHa3YUXWvyJHrC+gyWb8YaNZOtNv87BIXkUYCQOSXhd05Mm1OWafwvt3QppnnJVnzP1ng6Ff+gMA5hFuj8PzjYTEnvRkVhhjZC4S5UUvYXmwnXBrplG4g0LGsRPT9sEuj6Gz1bkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233912; c=relaxed/simple;
	bh=ESF4B1n3zhN4p/BUG4O63hIkzMP2aE+/kcxZPliqe4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m9v7OMa4c/O8semO6XAxsvSxUZYtaHiMbaQuIe860CZdSgLRW/N6Cb+dqdDeCg8FZSzca86ie0hHSWWooX93PpCza2uPU24Kq22hqsYXqIgtlZforf9unSCGuqoCqXJIHlIY33le2gUq8fmEXs1w0y24GgFjPT78j/ij/EJzxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfUq7CDt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24a31ad88aso1046331276.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727233910; x=1727838710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UVr7KqF146l104fxhnzgYW/+yda6qz1wr5zQxAmCh5I=;
        b=tfUq7CDtGKqbtj/Sou/3BrluOSWnW0Srp1K5kpYYTzBz3JDRdThtS2VWv64nappodw
         p3oiCTSvXwPwBR0ua+BS8wJe3TtumLqjOtom076cAW/ZDSCZIrKhVxCwTpY46F1n6bIO
         9hbD0751IflfAt9c1FWuC1u8qkb/SFES2P+fVjQJkFghOAFD2CpvsJxagC8flFeoflSB
         wRGQvFYk4u9Mec2ESM2pl82LOyymFI27XhalE+Qu8dTtFlNOoR1XrVL/XG2ckY6FKTyK
         8QBj0Oj3xBWisZEl1eFN1NLgXUqdKP9Fd48ycQCTV3hkA8xCmRxkHh6Lth9dT9c080d7
         AeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727233910; x=1727838710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVr7KqF146l104fxhnzgYW/+yda6qz1wr5zQxAmCh5I=;
        b=jBIXvOxAZalNkd1fuUhRYPYBvSfQgVY54HGyYJZVq1NQ9Wj/Ntqj78LwreU9sk8uKW
         GQYd9UMo47qQ0nqbb8gTVHfhnhj2RSmPSZKN2xG/VYfRZ4E9ahWCAJb5kvOaj6zAbCjy
         SnmX4E+9BkmCxfaTAbmyCyrgzwdJY3nWEc9oR1KlJILBEtQq4PLF9z+2la9RsvYYFueY
         C7JbOaVsU2GX2VkB18RERhdblfmGdVPXLOX3xiFqd1JNH8OepyIZlqIMZ3kIlxOpO/I1
         jHREBqzDuWZcYZ/AZDwrq8Uf4zJFeMpiuDlVaMcLO/U1bzV868OKPYn+S+Up6vtnzqJU
         qCYA==
X-Forwarded-Encrypted: i=1; AJvYcCVtE+CZe1fCNTKH593t9e090+uhjvMd+8fuNkdA5BqDDL2EgsgSstPZEgezdxU0sZcTky4nfmaXAjJq+94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7wy+Y8wOMGa6LoW9CUZrF8DHhKV/HDMyLBNS2bBfTl/BZnl5
	d7rkJQDXgh+kR51KmaBX6Km6YtE1caIGW2nBMs//TL0yJm7WWwgDoOHRdey6C1G/UAaP6sAMljY
	p6g==
X-Google-Smtp-Source: AGHT+IHuFr2TP3OPoA/rgoO/fTssCQNMhFEhC2Y3DqU4KKzglS1lQ/ALChp7Rea/E+qP6aK0Rh7jS8LnH6Q=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a25:b120:0:b0:e22:624b:aea2 with SMTP id
 3f1490d57ef6-e24d46b5e11mr1316276.0.1727233909726; Tue, 24 Sep 2024 20:11:49
 -0700 (PDT)
Date: Tue, 24 Sep 2024 20:11:30 -0700
In-Reply-To: <20240925031135.1101048-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925031135.1101048-1-amitsd@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925031135.1101048-2-amitsd@google.com>
Subject: [RFC v4 1/2] dt-bindings: connector: Add properties to define time values
From: Amit Sunil Dhamne <amitsd@google.com>
To: gregkh@linuxfoundation.org, robh@kernel.org, dmitry.baryshkov@linaro.org, 
	heikki.krogerus@linux.intel.com
Cc: badhri@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit adds the following properties:
  * sink-wait-cap-time-ms
  * ps-source-off-time-ms
  * cc-debounce-time-ms

This is to enable setting of platform/board specific timer values as
these timers have a range of acceptable values.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/connector/usb-connector.yaml     | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index fb216ce68bb3..21a0c58c65cd 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -253,6 +253,36 @@ properties:
 
     additionalProperties: false
 
+  sink-wait-cap-time-ms:
+    description: Represents the max time in ms that USB Type-C port (in sink
+      role) should wait for the port partner (source role) to send source caps.
+      SinkWaitCap timer starts when port in sink role attaches to the source.
+      This timer will stop when sink receives PD source cap advertisement before
+      timeout in which case it'll move to capability negotiation stage. A
+      timeout leads to a hard reset message by the port.
+    minimum: 310
+    maximum: 620
+    default: 310
+
+  ps-source-off-time-ms:
+    description: Represents the max time in ms that a DRP in source role should
+      take to turn off power after the PsSourceOff timer starts. PsSourceOff
+      timer starts when a sink's PHY layer receives EOP of the GoodCRC message
+      (corresponding to an Accept message sent in response to a PR_Swap or a
+      FR_Swap request). This timer stops when last bit of GoodCRC EOP
+      corresponding to the received PS_RDY message is transmitted by the PHY
+      layer. A timeout shall lead to error recovery in the type-c port.
+    minimum: 750
+    maximum: 920
+    default: 920
+
+  cc-debounce-time-ms:
+    description: Represents the max time in ms that a port shall wait to
+      determine if it's attached to a partner.
+    minimum: 100
+    maximum: 200
+    default: 200
+
 dependencies:
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
@@ -380,7 +410,7 @@ examples:
     };
 
   # USB-C connector attached to a typec port controller(ptn5110), which has
-  # power delivery support and enables drp.
+  # power delivery support, explicitly defines time properties and enables drp.
   - |
     #include <dt-bindings/usb/pd.h>
     typec: ptn5110 {
@@ -393,6 +423,9 @@ examples:
             sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
                          PDO_VAR(5000, 12000, 2000)>;
             op-sink-microwatt = <10000000>;
+            sink-wait-cap-time-ms = <465>;
+            ps-source-off-time-ms = <835>;
+            cc-debounce-time-ms = <101>;
         };
     };
 
-- 
2.46.0.792.g87dc391469-goog


