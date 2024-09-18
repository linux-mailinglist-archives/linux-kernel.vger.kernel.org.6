Return-Path: <linux-kernel+bounces-332913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D6C97C0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8D81C20EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4271CA6AF;
	Wed, 18 Sep 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh8ChTs0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA51C8FB4;
	Wed, 18 Sep 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726689146; cv=none; b=Bc3Wu62vHYBQoO33eeDLitiyq2cOzAgIXuznYdD/yQCkmwSWtHNHM5zw2nO6cHrZvYi9tTTZPhzZ87EAnXdTIMj1fDmbdd6N70RmgSFwCXnqo9r6LztTMAKKuLvvg2c+yInEcjigPMieE+0Shb+yR54eCwqeeiYjdELoN2hvQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726689146; c=relaxed/simple;
	bh=KVQTJmUOix5X3CgjVBPJhTZmYLzmRscSQ3BbyC6k5WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xyl0Jf5lejQblvY0hSwE9XRxpjHkO4McGyZbq4njb0ymEy2yurM1tjwoW3FtBdgdd+sRpazKpmIw66tvyU90BS9soaAuHxlUpu6hfrMrDtV86D5txu7/2ixfkvcLQog85ojQbyQjP1ahaQR5DgnPVCjZ7iqvCmlNoj/x9eCxsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh8ChTs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1F8C4CEC2;
	Wed, 18 Sep 2024 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726689146;
	bh=KVQTJmUOix5X3CgjVBPJhTZmYLzmRscSQ3BbyC6k5WY=;
	h=From:To:Cc:Subject:Date:From;
	b=dh8ChTs0bvjKDyoK6+3sLNk8nKwYSKPl47Hzef6NvRHXzqxV0LsdqJlrlkAn85ZZA
	 SpcxtsopWZj/wIP3KE4HC8Dc3Xnf1XSIlbk3Rfszp2KXX4iDZCmb6s5PXGBEl3xfxu
	 /W646X3yUIHpivBnXXUAHppOPX2/Ev9868ks+LzxVfynUjpCMGr3HUBmK3iffplL7w
	 cCVvZEcpZ8pQmtv5SdSqi4wLSiBJAxCuvNcs6NIgixyH5ViuXOLxjWgow8chKDRJwc
	 oDvD2GW0uBlrhJZb+MAYS7JpGq4cSU73i4XiZ0TbvI99xUMnZrPCgWggcAn2ShLvR9
	 uTo2RTf4IStFQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] dt-bindings: writing-schema: Add details on YAML text blocks
Date: Wed, 18 Sep 2024 14:51:30 -0500
Message-ID: <20240918195130.2024205-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YAML format has a couple of different forms for multi-line text
blocks which control allowed characters and handling of line-breaks.
Getting this wrong is a common review issue. Either a literal block is
used when there's no formatting needed or a folded/literal block is
not used when there is formatting to maintain.

Add some descriptions of the different forms to point folks to in
reviews.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
I have a prototype yamllint addition to check this for us. Not sure
if it will be upstreamable given something that works for us is quite
easier than supporting any possible YAML.

Digging into this more, I had not realized that plain style can support
paragraphs with a blank line nor that folded (">") style maintains
indented lines. That probably means we could use those 2 just about
everywhere. Or maybe it's just easier to say use ">" everywhere (or
everywhere with more than 1 line).
---
 .../devicetree/bindings/writing-schema.rst    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 7e71cdd1d6de..eb8ced400c7e 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -43,6 +43,36 @@ description
   or device does, standards the device conforms to, and links to datasheets for
   more information.
 
+  The YAML format has several options for defining the formatting of the text
+  block. The options are controlled with indicator characters following the key
+  (e.g. "description: \|"). The minimum formatting needed for a block should be
+  used. The formatting controls can not only affect whether the YAML can be
+  parsed correctly, but are important when the text blocks are rendered to
+  another form. The options are as follows.
+
+  The default without any indicators is flowed, plain scalar style where single
+  line breaks and leading whitespace are stripped. Paragraphs are delimited by
+  blank lines (i.e. double line break). This style cannot contain ": " in it as
+  it will be interpretted as a key. Any " #" sequence will be interpretted as
+  a comment. There's other restrictions on characters as well. Most
+  restrictions are on what the first character can be.
+
+  The second style is folded which is indicated by ">" character. In addition
+  to maintaining line breaks on double line breaks, the folded style also
+  maintains leading whitespace beyond indentation of the first line. The line
+  breaks on indented lines are also maintained.
+
+  The third style is literal which is indicated by "\|" character. The literal
+  style maintains all line breaks and whitespace (beyond indentation of the
+  first line).
+
+  The above is not a complete description of YAML text blocks. More details on
+  multi-line YAML text blocks can be found online:
+
+  https://yaml-multiline.info/
+
+  https://www.yaml.info/learn/quote.html
+
 select
   Optional. A json-schema used to match nodes for applying the
   schema. By default, without 'select', nodes are matched against their possible
-- 
2.45.2


