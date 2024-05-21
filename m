Return-Path: <linux-kernel+bounces-184489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD0F8CA75B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8735CB21CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146013F9FB;
	Tue, 21 May 2024 04:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sC1Oadl3"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008A2E85A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716265919; cv=none; b=AWk5fK9EO5D/nFd1uLdGIi6Rict+ua5vn5n9VdisgNa2nKvK471z+l29myoD4k6oIM2YONoYysNTk8120Jl4F2KH3W68XTE9ljfjUMoTwC7RlKjOoU+FRp7DH5mLy6ll/dVOmCIF7EesqiVRmTfQvwNQWV1aryRRWbaDgeTXOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716265919; c=relaxed/simple;
	bh=O4FuQzq87q5Gl4pSbrtEQJa0TSgByHcVu33I3F4fdWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rIvCSYtWcq8AccPZXp/BVKoVZdq+/Cl18TBJBjeOHi+bonTSpauouEKFrE3Yv6CZydf6VKaYRD4rBDT3hQzb3s4Yz2SsoxfGpEKbspI/NkkEyO8gypHrtUlCLTZEG6dK78eYlRIPQsInhOFXtxaPX3s7YM6buDgzO/KKwlAOVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sC1Oadl3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61d21cf3d3bso215163647b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716265917; x=1716870717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYMeQLigsijt5Vd63qHRbjZn+nihymDP7t8hjQqISCc=;
        b=sC1Oadl3kSJGAnVlxLIQiRg0JJnbLGKJ/KMmhDDDdmev3hcSnNrV9w1A9q3u1TbMzk
         KZ3GvnZPRm8D5is0v8SnX5g1vjMWFey+Zp33Ww5gvaM6yq9WiEVQFZJ0lClwXnQ7J01M
         em1VB/1amepv1YMDWMyra0zQdV072sXFrZD/eZ6KfsljTMTiejHobKKDvvFXlKfdJnni
         c5AS5u26XwAj0zvB36ecLi18OMMImMOOcEreXY7/QC1lekTitBP+0EYYagATlqU1te9v
         YGEq64A9zTV6rM/eD2kPqyeE7btQEEMifL+/danONutEY2hx3P2STdyObbIf7HNPMbOQ
         vIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716265917; x=1716870717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYMeQLigsijt5Vd63qHRbjZn+nihymDP7t8hjQqISCc=;
        b=ZR+lrS3GH75Q3bb6oRBoOQ9wujhJcgAl4O0Qi8SvyqRuSBjwVVbjplpXI0bKcbpZA3
         annxS0NJorUVR/77QEuwgdw4VuQPIYlJT30PSfQb61zNdX+Dojkp/av/rwGJRyP57n6J
         ZgVUg8hU2q7r83O4ycx2ifHIQUwDEfJ3FulO3bPsHN3BCWMoPGkm9RvAZq7LZShGBHAN
         eaHejUi16ks6PlGGvpDJ0Qm05AEZhJoXgFS2lsrBT2y4apb6cHzBUw9Jj+hAcMSf32+Y
         ej329V2LGB5CLS1JRSXii/ZBdWg5LpaibmWM+in6+Fk2P4vZwpgLGMxcxTazE9TpwlqU
         m3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX96HLPjajbc89l/WMEMHr201jYkM2s74H7hjgfxvzefzgjn8m41GLCfXDgd7hlOKlCiLl+U0L+Z6gzgxmVgeLAx1dRpQibOr8SW4ls
X-Gm-Message-State: AOJu0YyN0NLqBPiYmaD4FL7pNzGkDoP0WdheMekYzRcHSS6mYxKClfL4
	INc9VGYnrnCh/FQSmiZ5u5vQAVKCE1RPFVYZ86lIYpROhLDksoKqoofACaAaZLp0WvRP0NdRZGP
	PjvH8nw==
X-Google-Smtp-Source: AGHT+IGra7LDlV/WZ5UamhBCkfq29NJw+HDOF+XRR9dlpCd+G7uItTgDC11Xhthi5wHFFB0MqqwnoJoDNeSg
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:ffe6:3bcf:e120:a07a])
 (user=davidai job=sendgmr) by 2002:a0d:d855:0:b0:627:8b31:e81 with SMTP id
 00721157ae682-6278b3116famr21076067b3.5.1716265916846; Mon, 20 May 2024
 21:31:56 -0700 (PDT)
Date: Mon, 20 May 2024 21:30:51 -0700
In-Reply-To: <20240521043102.2786284-1-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521043102.2786284-1-davidai@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240521043102.2786284-2-davidai@google.com>
Subject: [PATCH v6 1/2] dt-bindings: cpufreq: add virtual cpufreq device
From: David Dai <davidai@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, David Dai <davidai@google.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adding bindings to represent a virtual cpufreq device.

Virtual machines may expose MMIO regions for a virtual cpufreq device
for guests to read performance information or to request performance
selection. The virtual cpufreq device has an individual controller for
each performance domain. Performance points for a given domain can be
normalized across all domains for ease of allowing for virtual machines
to migrate between hosts.

Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: David Dai <davidai@google.com>
---
 .../cpufreq/qemu,virtual-cpufreq.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml
new file mode 100644
index 000000000000..018d98bcdc82
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/qemu,virtual-cpufreq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual CPUFreq
+
+maintainers:
+  - David Dai <davidai@google.com>
+  - Saravana Kannan <saravanak@google.com>
+
+description:
+  Virtual CPUFreq is a virtualized driver in guest kernels that sends performance
+  selection of its vCPUs as a hint to the host through MMIO regions. Each vCPU
+  is associated with a performance domain which can be shared with other vCPUs.
+  Each performance domain has its own set of registers for performance controls.
+
+properties:
+  compatible:
+    const: qemu,virtual-cpufreq
+
+  reg:
+    maxItems: 1
+    description:
+      Address and size of region containing performance controls for each of the
+      performance domains. Regions for each performance domain is placed
+      contiguously and contain registers for controlling DVFS(Dynamic Frequency
+      and Voltage) characteristics. The size of the region is proportional to
+      total number of performance domains.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      cpufreq@1040000 {
+        compatible = "qemu,virtual-cpufreq";
+        reg = <0x1040000 0x2000>;
+      };
+    };
-- 
2.45.0.215.g3402c0e53f-goog


