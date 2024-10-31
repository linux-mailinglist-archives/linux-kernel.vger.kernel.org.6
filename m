Return-Path: <linux-kernel+bounces-391269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775ED9B849D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0064B1F237CC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D11CCEEC;
	Thu, 31 Oct 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CYNKNlmx"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2BD14A4F3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407671; cv=none; b=lPOylmJLMeruGzQhgaPEhpUXZTezxwtuSuwYi04Qy6uihfy2J8W9MOPw4nCpE8KNkOI6xthrLKxpmMHbEqUaboVhYdtmHVj8qGsA0sYvZcaa2ZkO1dPV5a/7pcr7ito0IKaGaN/PpxRyruGxiew1nP+vm8B4r8+T0lwheCLgoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407671; c=relaxed/simple;
	bh=LA2kxQTEYdVZLGp1k9PWf+jvRLv3J+pclp8bu/Z+MZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YS0XbHnmw0IpNuuKdgQoueRkZ5dGLXhfxTMPQviFVgPX1/3Rk3iEIjSDx55xXn8YIJKUuX6yCie6xj8IwYvP4TMdXZyUYYFACjkvFsTBZlrcB2Sc00rzfz42m3KFRxkSKg/m/LrQKx9qPPoPO+cJnksi6kccNG43L1fu6IEW8Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CYNKNlmx; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241031204737euoutp01ba3d20983c4fe8d25ac87826a8f4f2b9~DpJiqFInJ1761517615euoutp01t
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:47:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241031204737euoutp01ba3d20983c4fe8d25ac87826a8f4f2b9~DpJiqFInJ1761517615euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730407657;
	bh=bcy6XB4drLGQ91Hj3yeaQos3MgyWXtw63xNApEC7seA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYNKNlmxE94UjOQwVnErajIwuGkd1CNxGtmnopqnhNzRD1Ul0ILVEukLVNuATfGE5
	 FIzNb6o9OvGiTT80v7eM0p0zCv9IFnp8kZ8LoRDtZHsmtR5YNcwAXjvWk711uS7M5s
	 bX+hZikPErB/FML0vQig+SLQDbCJCL8lCeETU1g0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241031204736eucas1p1279b8dd0ddac1a2501d54066bd76d5a4~DpJhZHV-P2981929819eucas1p1N;
	Thu, 31 Oct 2024 20:47:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DD.C6.20409.7ECE3276; Thu, 31
	Oct 2024 20:47:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241031204735eucas1p2cfe90f4279c3db29b0af1e61ac29904d~DpJgxtgmw3276032760eucas1p2X;
	Thu, 31 Oct 2024 20:47:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241031204735eusmtrp17f0701f25650e2541679f605b0341db3~DpJgxEqJE2946129461eusmtrp1D;
	Thu, 31 Oct 2024 20:47:35 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-1b-6723ece7884b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2E.20.19654.7ECE3276; Thu, 31
	Oct 2024 20:47:35 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241031204734eusmtip1658680ee384ae2da9e4c285b487a4326~DpJfy94yI1402214022eusmtip1g;
	Thu, 31 Oct 2024 20:47:34 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com, samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: mailbox: Add thead,th1520-mailbox
 bindings
Date: Thu, 31 Oct 2024 21:47:22 +0100
Message-Id: <20241031204723.1149912-3-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031204723.1149912-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djPc7rP3yinGxy5bGWx9fcsdos1e88x
	Wcw/co7V4t6lLUwWlzpXMFq82NvIYnFtxVx2i5ez7rFZ7H29ld3i8q45bBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF6nNXWCxa9k9hcRDymNXQy+bx5uVLFo/DHV/YPXbOusvu
	sWlVJ5vHnWt72Dw2L6n3aFl7jMnj/b6rbB59W1Yxelxqvs7u8XmTXABPFJdNSmpOZllqkb5d
	AlfGxw8T2QtWy1Vsv3qIuYFxm3gXIyeHhICJxJZvE9i7GLk4hARWMEpsfHyFHSQhJPCFUWLp
	TmWIxGdGic/3HzDDdLy4/oENIrGcUWL63Cao9jeMEg8bzjKBVLEJGEk8WD6fFSQhIrCeSeLZ
	7mVgVcwCRxklNkx7CrZEWCBQ4sH6LWAdLAKqElO/vgKL8wrYS7ycdIIdYp+8xP6DZ8F2cwo4
	SMze1QpVIyhxcuYTFhCbGaimeetsqPt2c0p8fAL1nYtEw/V5jBC2sMSr41ugZspInJ7cwwJh
	50s82PoJqrdGYmfPcSjbWuLOuV9Af3IAzdeUWL9LHyLsKLG15zc7SFhCgE/ixltBiAv4JCZt
	m84MEeaV6GgTgqhWk5ja0wu39NyKbUwQtofEr0cX2CcwKs5C8sssJL/MQti7gJF5FaN4amlx
	bnpqsVFearlecWJucWleul5yfu4mRmBqPP3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE90OBcroQ
	b0piZVVqUX58UWlOavEhRmkOFiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QDk6PT5tgJn1m/
	s3iJHMi2etTjdFj1ZnTXITmXjReDO1sMehUO3ddPqn8RM5NjWzY/f57jf5vo6oe8P7pKd/Kt
	Fnh6J4NVbWoOE/f8b2eCZdkXb2vMEll4vyJI//uNDS2b1Nfo/nmxiLF9ddP2rRrrF/ucXN5o
	+LDi1LllMafu78rX/hvTxmNzTuzcFTefJfYyS//Mqha/3d0SxdJ4b90MH+NdntKnAvdXLrwz
	r+Nr/4H1U/T43cIyv8YWcq96/SW2+JDrOiaz3G3Cq4JvVnCrbW6r2m+QFTC5QLap7bDzwVLf
	Rt7N+Wt018rwn1trFTrTsEpA+CPf30CNCX99u6RcYjs1tlysnhwSEpDjsSZViaU4I9FQi7mo
	OBEAlkSB5PwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7rP3yinG3zpF7DY+nsWu8WaveeY
	LOYfOcdqce/SFiaLS50rGC1e7G1ksbi2Yi67xctZ99gs9r7eym5xedccNottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg91i9bkrLBYt+6ewOAh5zGroZfN48/Ili8fhji/sHjtn3WX3
	2LSqk83jzrU9bB6bl9R7tKw9xuTxft9VNo++LasYPS41X2f3+LxJLoAnSs+mKL+0JFUhI7+4
	xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j44eJ7AWr5Sq2Xz3E3MC4
	TbyLkZNDQsBE4sX1D2xdjFwcQgJLGSVmzzjBDJGQkbjW/ZIFwhaW+HOtC6roFaPE83v3GEES
	bAJGEg+Wz2cFsUUE9jNJvD5bBGIzC5xklFg8Wx/EFhbwl9g6YSZYDYuAqsTUr6/YQWxeAXuJ
	l5NOsEMskJfYf/As2GJOAQeJ2btaweJCQDVHW/dA1QtKnJz5hAVivrxE89bZzBMYBWYhSc1C
	klrAyLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMIq3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBW
	EuH9UKCcLsSbklhZlVqUH19UmpNafIjRFOjuicxSosn5wDSSVxJvaGZgamhiZmlgamlmrCTO
	y3blfJqQQHpiSWp2ampBahFMHxMHp1QD00btVe2JXTMcnmyKcJm821462UHzW3fwz81fbCxj
	nzlO43wqe8ffrPqvyLJWBqk5YacX76gXu3R9/eyctVNUfsjtYXv7aE9P457kYouvmoV/uPy2
	7b/f+EuQ5dQhV4eS3xrre29dOPeRu+fXlbwjCnsnML7YkXZo0aTn+xVfBJX0hbC6BgUu1H1U
	Eckw+17rQ0kZY8nLDlPPu25cWyv7PecsW+uNeWoxl+ayXv1vsfnp5ySVy/XxSvy7vypUKUt/
	l1ie9rHMcW7bshuRS6efdr2gY5e/uWfvFjXRU193+gTXuHXtWr1jzZTbz5/mz9ErW2sd9cqq
	XyPplEvkot8xv02vP020a5wSc2nq1xbONl4lluKMREMt5qLiRAAGgSpUawMAAA==
X-CMS-MailID: 20241031204735eucas1p2cfe90f4279c3db29b0af1e61ac29904d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241031204735eucas1p2cfe90f4279c3db29b0af1e61ac29904d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241031204735eucas1p2cfe90f4279c3db29b0af1e61ac29904d
References: <20241031204723.1149912-1-m.wilczynski@samsung.com>
	<CGME20241031204735eucas1p2cfe90f4279c3db29b0af1e61ac29904d@eucas1p2.samsung.com>

Add bindings for the mailbox controller. This work is based on the vendor
kernel. [1]

Link: https://github.com/revyos/thead-kernel.git [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mailbox/thead,th1520-mbox.yaml   | 89 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
new file mode 100644
index 000000000000..0971fb97896e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/thead,th1520-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-head TH1520 Mailbox Controller
+
+description:
+  The T-head mailbox controller enables communication and coordination between
+  cores within the SoC by passing messages (e.g., data, status, and control)
+  through mailbox channels. It also allows one core to signal another processor
+  using interrupts via the Interrupt Controller Unit (ICU).
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+properties:
+  compatible:
+    const: thead,th1520-mbox
+
+  clocks:
+    items:
+      - description: Clock for the local mailbox
+      - description: Clock for remote ICU 0
+      - description: Clock for remote ICU 1
+      - description: Clock for remote ICU 2
+
+  clock-names:
+    items:
+      - const: clk-local
+      - const: clk-remote-icu0
+      - const: clk-remote-icu1
+      - const: clk-remote-icu2
+
+  reg:
+    items:
+      - description: Mailbox local base address
+      - description: Remote ICU 0 base address
+      - description: Remote ICU 1 base address
+      - description: Remote ICU 2 base address
+
+  reg-names:
+    items:
+      - const: local
+      - const: remote-icu0
+      - const: remote-icu1
+      - const: remote-icu2
+
+  interrupts:
+    maxItems: 1
+
+  '#mbox-cells':
+    const: 1
+    description:
+      The one and only cell describes destination CPU ID.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - reg
+  - reg-names
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      mailbox@ffffc38000 {
+        compatible = "thead,th1520-mbox";
+        reg = <0xff 0xffc38000 0x0 0x4000>,
+              <0xff 0xffc44000 0x0 0x1000>,
+              <0xff 0xffc4c000 0x0 0x1000>,
+              <0xff 0xffc54000 0x0 0x1000>;
+        reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
+        clocks = <&clk CLK_MBOX0>, <&clk CLK_MBOX1>, <&clk CLK_MBOX2>,
+                 <&clk CLK_MBOX3>;
+        clock-names = "clk-local", "clk-remote-icu0", "clk-remote-icu1",
+                      "clk-remote-icu2";
+        interrupts = <28>;
+        #mbox-cells = <1>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index df36684221ff..506cdea74694 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19816,6 +19816,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
 F:	drivers/mailbox/mailbox-th1520.c
-- 
2.34.1


