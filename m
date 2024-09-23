Return-Path: <linux-kernel+bounces-336369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F7F983A64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4848E282B95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08445128369;
	Mon, 23 Sep 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WVRiLxD"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FF127E37
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131270; cv=none; b=rnTY4SzTtoGB2m8nx2BYYALq4H/TqvhaAc6oc+bltNiO+SZgYF6eyxcuM2zAbKgPCJxGNMPGl9mcTwvNhtLLKqNnPqRoH2Rb8XB52cQiAlsr1tXi8AGFvKoykm6dJ1+mBkdSnb2hgPb6iW7gKUwS2zdZvicpq3kcm2BWU8zgtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131270; c=relaxed/simple;
	bh=PS4BLuuHTqRfAsc6UJdp59YR5Wc8DDeE0Qb1w74bDi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eAq6ffKHNb9nmPy1SCe7SZodBI1YXt6a/TCyqklPKpRossKW8xEev+7Yeh6DBqwsr8i6l9R2RqUplfxQlHpnbRuLijfAdEqBmnmWyfCU8/Id2ZM9BX3DEzw6LRnnAtJbwmul0vv6D/VYNuDIVpgbPndoQcIifJJjpc5OR4JFVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WVRiLxD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d7124939beso74299547b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727131267; x=1727736067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0CyW1JtJfwLGoAAX+BVVApeoMCB4q+lbs8zs4x8alI=;
        b=2WVRiLxDW2ERc+ddNqTsBvG2XSMSCOp5TlN4/UJSKY6zKgUTnkvhocH136rj/4Fkzg
         XRp59ODCK1kv1T/HiAatc4SG5Sp/cEd5hiIjom/NCSV/a+reUOdQEOg+ck3DYL7EGsYV
         Mu3wzyX5/9WY1aaSzkBmerkZ3z1q9/lzIdEStK/0BZYKLkzafLPn9WLzmqMkHpgPNKcm
         iZCnE1/gf7B3uI6Zyasxd5pcm3WmUe6XEKWM29mnYEH9gUTcmKJUICrDFrB/V949+emt
         iXPDIkVANU5C3QJ9FZyGa9/HtxxAIir9g9N5rfp+uJWPAivdlSOyFBcxL0EwV/jrH62r
         E1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727131267; x=1727736067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0CyW1JtJfwLGoAAX+BVVApeoMCB4q+lbs8zs4x8alI=;
        b=Dwkc2tdawYi80is2kmP+mllUCXqFIVXB4KTBNOEghxI3QQqJMkWr82tfi2Vcpc4HKV
         Txlmit1BbLygqaWh8Xt+CgohZd9x5oKfl3bidLEvxIfnSnimwDr/sp+4EDhN1EV3hGXi
         dqG3w+Pn2o8wDX9aLDOfX6Vbl2NLVQZaNclvzP/X1wuUWSGcYl186S9Pk24f7tUIwok4
         661++m3C/GxjKVJZrfKW0nK2p5DuvOekQfaWRoxtJ1LPYqOOkKizZNtM7zclhDEBC283
         clizg7PAZ1QB3R9gIHvB6K51HuU+YCmZaTclKIbzCS5Oshl8cBq1h0wrmKndKPwtoYIt
         QS1w==
X-Forwarded-Encrypted: i=1; AJvYcCVdvYckfDOoaDWoe2ev5rvq6FF+Gg43D5MpZjoxeYobKkENAjQ1UikmVJyOXd6NHhYxHU/WgwMmoQmR2qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9IBuERKx0L0suYNH7wmFATwhyl0illEsNJrKpKiO7tWSP3+7x
	gWAtXhRoonyEknmXBqwo5Y+eXD2aXpC9DmLHRsNE95tm7Kp4XIejc4S+F0PkWfhw4/9jWfNCeXb
	tpg==
X-Google-Smtp-Source: AGHT+IGSjLQWmP851y1eVS2/hu9bUHsBbO9LVlRM6GryOZeP6D1cgOZJreq/N+ptQftupMuqBX9oaKMKBFo=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a05:690c:6d01:b0:6dd:dcf5:28ad with SMTP id
 00721157ae682-6dfeea08a59mr2106147b3.0.1727131267372; Mon, 23 Sep 2024
 15:41:07 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:40:50 -0700
In-Reply-To: <20240923224059.3674414-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923224059.3674414-1-amitsd@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923224059.3674414-2-amitsd@google.com>
Subject: [RFC v3 1/2] dt-bindings: connector: Add properties to define time values
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


