Return-Path: <linux-kernel+bounces-309114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E35796665F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD6B1C2157E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031B41B3B1A;
	Fri, 30 Aug 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou5/bhBh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0B1B3B29;
	Fri, 30 Aug 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033648; cv=none; b=hYkZZ6WP0vxmPmAFgrpq3kmx3Z9NwGuH4tFZYo0rd5MLEiwSQgYU8Rx72axgSUeQ4/Eo9fxDfoJq8ejf18opEQbVQaEmCSnebkTk5hbvUU6WMdLd0qlTnoNzMFn34mb69+L1jn64/YlB95PK6Mr0QINdJDOLdFs7VXi4vjmjuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033648; c=relaxed/simple;
	bh=e2ooacAGqA5dHErurauU3KfmxSqJxEuGxU4wMtSkdD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQjbAvM4YYL8ssVao+npkuhyz8VXl4HuFuLNGI/t+nxb7iB18j8FMF03NZvkxBcMTYU4Q+QtKlFI6hMHr0OZAhWdUqoy+ewTC/7KlNZovY6XEvru9jPE/4Aii6oXkZOYetKNBzqVdnqbA7ZzL+2JeFvLS+otK6QLFajZ0q/aIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou5/bhBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59C6C4CEC2;
	Fri, 30 Aug 2024 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725033647;
	bh=e2ooacAGqA5dHErurauU3KfmxSqJxEuGxU4wMtSkdD4=;
	h=From:To:Cc:Subject:Date:From;
	b=ou5/bhBhncqikoOKRJULJA+eUVKnoU7LXLWIDYwLsevqlDN7xxWOpl3OnuZ0wFxTb
	 KqD5f7mZwuiEpH48woKEVG3s95hgU88U3SXNIRufFz4cmoZb6+Nc+4sxvEU9TF84+3
	 c+L+45ZeUPsnsGcKsTpRA5unWG8K5ttXk8SG7Ju5+oEvHa2v06imS54b+0HrTaU0V1
	 7ITIi/ZHNsYWv/afX53mnAfdW1rhwtggSFqBsuRzMeVF/zelYygEeN+GA9fW7d5yWt
	 nkoeqTdAEe/cajqp+4SqICip9+xJZfykniKK3nvVQPZOxp7v8TgwN8qyZgarDdpM8b
	 MMtjLKr8/HgHA==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	cyril.jean@microchip.com,
	valentina.fernandezalanis@microchip.com,
	nitin.deshpande@microchip.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC v1] dt-bindings: add IP versioning document for Microchip FPGAs
Date: Fri, 30 Aug 2024 17:00:40 +0100
Message-ID: <20240830-culinary-cautious-2c2c19902dcb@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2667; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Z3HmH34EeUu+XenREat9qVvRSS8pNw8HmrcNSBeOGrs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkX3yyvcOed5WQdIBV5+J3amiCTY7FNi1TWPowqq5ozw Ur0VaZjRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACaybicjw/kVapqhl2Xl/N57 it9/VdZSfz5/+hOjj2vVpRcaCiWVaTL84XmSUXN4l7GasMbEW4LeijryXwQOdCTfe+SQ+yUgfeF 1VgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

This is a pretty rough document I conjured up in 5 minutes, to document
my expectations for compatible strings for both our FPGA IP blocks and
reference designs that we ship, a la the one that exists for SiFive IPs.
There's been some internal conversations lately about this naming etc,
so good to have something written down.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
cc: cyril.jean@microchip.com
CC: valentina.fernandezalanis@microchip.com
CC: nitin.deshpande@microchip.com
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 .../bindings/microchip/ip-versioning.txt      | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/microchip/ip-versioning.txt

diff --git a/Documentation/devicetree/bindings/microchip/ip-versioning.txt b/Documentation/devicetree/bindings/microchip/ip-versioning.txt
new file mode 100644
index 000000000000..4a4e0e74c4e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/microchip/ip-versioning.txt
@@ -0,0 +1,34 @@
+Devicetree compatible string versioning for Microchip FPGA IP blocks and reference designs
+
+This document describes the versioning guidelines for compatible strings
+used on Microchip FPGA IP blocks and reference designs.
+
+IP block-specific compatible strings are in the form:
+"microchip,<ip-block-name>-rtl-v<major version number>"
+or optionally:
+"microchip,<ip-block-name>-rtl-v<major version number>.<minor version number>"
+
+<ip-block-name> should be the name of the IP in Libero's IP catalog.
+In most cases a major version should be sufficient, as breaking changes are
+intended to be accompanied by a version update, but if not, the optional minor
+version should be used,
+
+An example is:
+  compatible = "microchip,corei2c-rtl-v7";
+
+If the IP is integrated as a "hard" peripheral in an SoC, the expectation is
+that there will be a fallback to the IP block it was derived from, if
+appropriate, such as:
+  compatible = "microchip,mpfs-i2c", "microchip,corei2c-rtl-v7";
+
+The versioning scheme for reference designs that Microchip provides for its
+development kits is similar:
+"microchip,<soc>-<board>-reference-rtl-v<yymm>".
+
+This should be followed by a fallback compatible belonging to the board itself:
+"microchip,<soc>-<board>"
+and then one for the soc:
+"microchip,<soc>"
+
+For example:
+  compatible = "microchip,mpfs-icicle-reference-rtl-v2210", "microchip,mpfs-icicle-kit", "microchip,mpfs";
-- 
2.45.2


