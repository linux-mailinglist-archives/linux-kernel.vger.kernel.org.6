Return-Path: <linux-kernel+bounces-389725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F069B707B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5EF282554
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2B21766F;
	Wed, 30 Oct 2024 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="MKmUtxoe"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4771E47A0;
	Wed, 30 Oct 2024 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330901; cv=none; b=mCnq7wk3y9sl69snLLTc/qPE7DDpcV44Dq4VuKp5Mq85WIaJ4rA3XwLE8VA2EPMziq+2YnikxOSY5hIYBHo9nxFk+orD3x9vr/DZgiG6pJsQizP+w0hZRYmkY6NmtS2wgErLKYHFtbl1OF2dc7sYgveB9GMIPaAXof4erDWXg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330901; c=relaxed/simple;
	bh=lSSkp5xhn1ep7DpC4QCQhnlkJVwxLQXovx0RxkamEbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6IQDzJTrApd4tUAAJsMg8vRM4R92Bz+tN9wAawHVk/F+G9QPte0IPiyz1xXWDwYc6AMcJ5YtRMnGtJhPg8gfJQSI2Vo89J0k+mYA0CY7UVcXrkIrdGHd4i7tCjZLPsQazQh5z4WWU+g2oUW90Dhxh6lH1zsb0yGlRfFeg6PAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=MKmUtxoe; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FXyL3DypPFSd8TW3PTO+e+7t9NOqRV3fsU3dmjBNp60=; b=MKmUtxoe5Z2q52+0mEeOw3eGF5
	6QCc1rW8UPEIamWzpuROmb3mf6Q3sZYoUo3kaC6UBLnI8BVkjuff5oIrMIsCuLFqa/+GxLg00L4mL
	yBxltGbL7c2uHihNu4QiH9MXTD76hglYTAaPwooqe3BI2QwxYLk27NnlVnJ02jWtXg8NxwTQAa9B4
	cXEPqRLgDnvD95BwnSH+CfDjyNuF7D5oP74hoon7V8HGkbvj8DWm5+rbJsqlLapyvwIE0KPFYIQiS
	cM7WFjfQPlt6mhhhlFlqQqGA7wQ+lLjN7CpyLXx7jzCzRXMesk9acc8jVkAQab0RbE0/AjbNW9LLz
	JEH3A0Ug==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add compatible strings for Kobo Clara 2E
Date: Thu, 31 Oct 2024 00:27:44 +0100
Message-Id: <20241030232746.2644502-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030232746.2644502-1-andreas@kemnade.info>
References: <20241030232746.2644502-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds compatible strings for the Kobo Clara 2E eBook reader.
There are two variants differing in the EPD PMIC used.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177e..a78903076269b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -620,6 +620,14 @@ properties:
               - kobo,librah2o
           - const: fsl,imx6sll
 
+      - description: i.MX6SLL Kobo Clara 2e Rev. A/B
+        items:
+          - enum:
+              - kobo,clara2e-a
+              - kobo,clara2e-b
+          - const: kobo,clara2e
+          - const: fsl,imx6sll
+
       - description: i.MX6SX based Boards
         items:
           - enum:
-- 
2.39.5


