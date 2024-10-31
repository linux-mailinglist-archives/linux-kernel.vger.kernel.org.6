Return-Path: <linux-kernel+bounces-391458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F19B876D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406472824CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C925D1CF281;
	Fri,  1 Nov 2024 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jg/9eRn/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658392837A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419213; cv=none; b=l9x15ZmjZqu5O7L5MEK7E3aTtGIUW8IF1cwcXfPvbU2dd8CCm5AgX0AJKeVSl39I7YoqMm0NRWebpvYa9BM0PNRTUAKoVy/rHYNYyZazzb+nxxACIsHuTRDxJrH/MqtsluQA/JLNzFENfyViTG4tT8CUGW82D1Wof/+KKYgAwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419213; c=relaxed/simple;
	bh=UipML7Yg8hvmCAePJ+oaJ+qpyo3ZhUAnZLJXkXrCSsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sj9UH7nr5jY+3l5VtScf4d0Cbrf9s4rha38+nyqsjLRMIb9XlVA4pfDBZqBDNd09WwTLpJjW8js5/8YWnoKvA5GoAZNc55jddMDhWVCwt/x/1nLhiht2OT4907KeFMteOqmD0TWk9ZwTYk8KILIH61XtZXHmxrZWp7UZ7vIzpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jg/9eRn/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e5bdb9244eso25482877b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730419206; x=1731024006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHYzIMl6GMa9fGC8SIOmNYUS+e+ogp8fvmmhcUikr/U=;
        b=jg/9eRn/NvXNvnOX8kUK52c7pCyB0jvQ4MazRBMUl7EbOqjq7RXKtZBSQ1EPAcd8RH
         omWxsraMMWO6Mzkgs2qw1KalCoYkx/Pdtjb4i8LVnA+OyCWR93Arpo5AxtFfcyMukw26
         OM2sYMAy/8a4s1znUO2m1lVt3e+0vcfAGSFdoZh1x4ts5NJMym77L881wDR+iNf+oXUX
         RCbPmFPXix+f+fmKIhrzr8pGWHzmiOOh81amTl0JOmQ6pCaRZLj0hQ25Qvhee9EMoPwn
         tbyVbSh0sHuHIlAR6eVEtu7nbjCfsl1tJmJLwTFbltSzDoB9TJ+8uqadS9lSuyRySlZG
         lz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419206; x=1731024006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHYzIMl6GMa9fGC8SIOmNYUS+e+ogp8fvmmhcUikr/U=;
        b=ckhgKDVCdJ8x7fRWmBUDt5CBpMNTgo5Se18fiLg9VRiB4W5e+NdXgaqcXcNIreYoKG
         dsSErCOO23sSQKekNC+fsZ2lntuao7ZiqG1VFG1iAm9DHn7dUwGWLSyThM4EXdaaGPf8
         DQaVmMMftYRiGepmcjbfIVC75dBVHhmHG+z2XdL4PKePwmRrNgATkaAnTwf9/GlDLlxW
         m8fTEgG+9dq/qKJ4pmOZsI3x+UQ6lKXPBvVEamKD4GNQ7avc+KpX5QHwy9rfTd0hgSDb
         Pq1TVu4UE3cCXw2ELfmV3R8nTk7Or2NtWBohEE+fXroQOH05Am30NTDLA8OC/c84xdcb
         F7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOTQJD1YvsSP86tLzo/wtLUDFmcpNKjm9FkAnDLCrDZLfKcj6H8O0xPP6i/NR5aUf//5USBtbdNt9Xa0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVq/9z91Wvg6t3MqLdtrpJvhXvQx+a0lvB7ufsXJT+6k6Noqwh
	vbwOHvGG5/VTxspurfpVTk4YhWxGVJxu4+coye1bfvHHE4DOtCgtvV3c4bRTqMEiZ0XUvgqeLq9
	+Ng==
X-Google-Smtp-Source: AGHT+IFtsw1CqjzV/sSzOx+52KMljtEulrqPxf+Kx+05Kx6SAXpGeTLFotSa7WrdF+OVatsVoVJKlZNHePc=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a25:83c3:0:b0:e30:c79e:16bc with SMTP id
 3f1490d57ef6-e30c79e1861mr11704276.8.1730419206198; Thu, 31 Oct 2024 17:00:06
 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:59:52 -0700
In-Reply-To: <20241031235957.1261244-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031235957.1261244-1-amitsd@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241031235957.1261244-2-amitsd@google.com>
Subject: [PATCH v1 1/3] dt-bindings: connector: Add time property for Sink
 BC12 detection completion
From: Amit Sunil Dhamne <amitsd@google.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc: dmitry.baryshkov@linaro.org, kyletso@google.com, rdbabiera@google.com, 
	badhri@google.com, linux@roeck-us.net, xu.yang_2@nxp.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit adds a new time property for Battery charger (BC1.2) type
detection completion process (based on BCv1.2 detection spec) when
typec port connects in a potential sink role. BC1.2 detection is used
by some Type C port controllers implementations (such as
"maxim,max33359") to detect the type of charger port.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 .../devicetree/bindings/connector/usb-connector.yaml  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 21a0c58c65cd..67700440e23b 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -283,6 +283,16 @@ properties:
     maximum: 200
     default: 200
 
+  sink-bc12-completion-time-ms:
+    description: Represents the max time in ms that a port in sink role takes
+      to complete Battery Charger (BC1.2) Detection. BC1.2 detection is a
+      hardware mechanism, which in some TCPC implementations, can run in
+      parallel once the Type-C connection state machine reaches the "potential
+      connect as sink" state. In TCPCs where this causes delays to respond to
+      the incoming PD messages, sink-bc12-completion-time-ms is used to delay
+      PD negotiation till BC1.2 detection completes.
+    default: 0
+
 dependencies:
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
@@ -426,6 +436,7 @@ examples:
             sink-wait-cap-time-ms = <465>;
             ps-source-off-time-ms = <835>;
             cc-debounce-time-ms = <101>;
+            sink-bc12-completion-time-ms = <500>;
         };
     };
 
-- 
2.47.0.199.ga7371fff76-goog


