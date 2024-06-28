Return-Path: <linux-kernel+bounces-233695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53591BBA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAC21F2106B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6D155345;
	Fri, 28 Jun 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TP58STNX"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34369154C0F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567489; cv=none; b=u8gpKbTtiC126I9OWbHqEGortWJF44+8iMZp3TWvWSVGUA3Nr0sGmEY+C1VjD1uhaNk7BNb2Mv8BnObqY4mfMEnjR2MMi03CEpBYQKx299AA4WkNRp8zj50mRgGLB24WC7a7VoB9APYfc1PGUWIi2FvQhMNflZR27lE5z/UizUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567489; c=relaxed/simple;
	bh=ONgrN1lIcSl02qRIHLXZVgvQprShqnN5GII+tATavQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lmEhHf3DJ4GskFe81qX3QnGNVAohzkZf4MXQb+kTKAz361GJoIbivbnHlFHFWs/FNNi/q9NfeU+kK2/zSRxcK8utmvTlOxYYS8xtbRVJ9KjQFgNkNoiaYxcPUFKq5XAj+Er1Ib1ia6FgEjkhKaP8Q10jJyHXmsyffRoSlQyOQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TP58STNX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-707040e3017so265856a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719567487; x=1720172287; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YA0dWEkzXvI8/KpPhKTDAN4RTMFwdU95qGVE5ffUQFc=;
        b=TP58STNXnKWesOPeYw6CQD20/ccvXIziu1010ZZdWxfsijNKFEgzUvRvblm5Vpqui9
         adVcWsInbecAF5L8hvaixOEK9wgOf8UKsQuT8WJ424ikxU6wRGYzG3LGGrn/lDyPc8tz
         xoqZ2a1Ap2evwEW9xLhn1GDPIjKauBXfN9HLGFezuxilDkyOiFweQfdxdokjkDT66emd
         mKVvYQKhrvMKIqL+j4eHrJdGL5CsPLTfRiPyL5d8M+aidV21nxtKOESJh6xbHkKHP8Fc
         1h0UtAsioLro56DyoZmMk1Yk90UVyX5MzlnpSdS+o+64G/lddWAZttqFw+ljF04rNPVy
         m9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567487; x=1720172287;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YA0dWEkzXvI8/KpPhKTDAN4RTMFwdU95qGVE5ffUQFc=;
        b=Xj1A3UYhe2EzZcRJqEOq4YUxnAH1Bg0fyyFV7vLNnAj34iBtH2ex/CTYFxP/sxskMQ
         EcHkmN0IU3FMN6iaHhGOoXSziT80kPPOF9KESCm9qXJxqnXZkuirW09DfGAGE6u9vWGJ
         T9jbHEDPeEFw08xoXn9/x9q83UC8Hyf2u2ps/5/VwXRcUfkL4eZfqJHOXR//yugR9YZm
         uP/ilWojkM/eIGl2eYML5mafdo3z7JJbNiTaZDZN8ABo5P7gyIIbXBqylZCELbzK34O4
         v0NTlsiEDGlz/kLNZJ8yDA6xsHL83Z8SbS56o7FKjdispbjyAwHYZEFDuGdyhEpWNVNL
         cf5g==
X-Gm-Message-State: AOJu0YxHXoIf/6oumrFm3cwQltBVrrKOXS5IMKzkebpOrASknvzy/Ccu
	WXQ2I1Wpz7BJOot7Gq1zfHbd6PfYn0GRGhvgsOdl/QRSyn3OV5J8W0RYd/2NtPeoH6GHGVz+ofr
	SFmOCylBvx8U4D9SHhr0Snjx1GGSYpSxws0APP6lCJCORweDSeNPLfk5+aD+Mp4y2wAB8TQtcuh
	WKMaNi4NVfpwqH9+3O92NqA2lHDfLjFplBecDn8OIUNpN+6XmVXWk=
X-Google-Smtp-Source: AGHT+IEr7EQCj6dcAAmXxE9nTudy+Q1tr3NBQMPkn5K3OhDpK9au3cIf3F6kgtczs2qpjnr6GuG+cA==
X-Received: by 2002:a05:6a20:6a90:b0:1bd:91aa:79a0 with SMTP id adf61e73a8af0-1bd91aa7a7dmr7189755637.12.1719567486974;
        Fri, 28 Jun 2024 02:38:06 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c6c8dsm11087155ad.26.2024.06.28.02.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:38:06 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	devicetree@vger.kernel.org
Subject: [PATCH v6 2/4] dt-bindings: riscv: Add Svade and Svadu Entries
Date: Fri, 28 Jun 2024 17:37:06 +0800
Message-Id: <20240628093711.11716-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240628093711.11716-1-yongxuan.wang@sifive.com>
References: <20240628093711.11716-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add entries for the Svade and Svadu extensions to the riscv,isa-extensions
property.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..c3d053ce7783 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -153,6 +153,34 @@ properties:
             ratified at commit 3f9ed34 ("Add ability to manually trigger
             workflow. (#2)") of riscv-time-compare.
 
+        - const: svade
+          description: |
+            The standard Svade supervisor-level extension for SW-managed PTE A/D
+            bit updates as ratified in the 20240213 version of the privileged
+            ISA specification.
+
+            Both Svade and Svadu extensions control the hardware behavior when
+            the PTE A/D bits need to be set. The default behavior for the four
+            possible combinations of these extensions in the device tree are:
+            1) Neither Svade nor Svadu present in DT => It is technically
+               unknown whether the platform uses Svade or Svadu. Supervisor may
+               assume Svade to be present and enabled or it can discover based
+               on mvendorid, marchid, and mimpid.
+            2) Only Svade present in DT => Supervisor must assume Svade to be
+               always enabled. (Obvious)
+            3) Only Svadu present in DT => Supervisor must assume Svadu to be
+               always enabled. (Obvious)
+            4) Both Svade and Svadu present in DT => Supervisor must assume
+               Svadu turned-off at boot time. To use Svadu, supervisor must
+               explicitly enable it using the SBI FWFT extension.
+
+        - const: svadu
+          description: |
+            The standard Svadu supervisor-level extension for hardware updating
+            of PTE A/D bits as ratified at commit c1abccf ("Merge pull request
+            #25 from ved-rivos/ratified") of riscv-svadu. Please refer to Svade
+            dt-binding description for more details.
+
         - const: svinval
           description:
             The standard Svinval supervisor-level extension for fine-grained
-- 
2.17.1


