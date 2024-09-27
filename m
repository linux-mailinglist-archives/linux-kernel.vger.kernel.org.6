Return-Path: <linux-kernel+bounces-341713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6498840E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23428B22A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D418C00D;
	Fri, 27 Sep 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3k1KjeqN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D618BC3A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439520; cv=none; b=JlqpZAOsWe8XxJCBVpmMHMQx1xlj9X7L2VFDDVVM+qlTwliLrg68WIw3xOFqBhYxe8h+QAgMsavxwknV6WJrivlyXpDLOsn8Pe5Dsd/MmPywc6GQTBgV5j/iYI1LF7j/fInpKTHB2DMN0qTBXylsJl1pJU3lB0UfEZJ7oWrT3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439520; c=relaxed/simple;
	bh=dtX7p43c9EfWKtIYreh2ZNsXHQpGNGn8sWnAnM61D6s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tK4I03X+drNRip2HzqWjEiVof47OZGZOALWH1UkxMXIBdqTxQIfZHZWKg/GR6ue7uqqgl5CsIZGYn7jdjQOJBUnH/O5g2TNg7iQkABsU4hsUHOP9J8YVi4z6yX6j7bK9RctoBjsaOTtxUrHwRXM+97m/7YTFq8uPltOZ/RQH0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3k1KjeqN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e248f1fe4cso11133047b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 05:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727439518; x=1728044318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELDmQtxXpVLogwubqzTMS3LPGqaX3x3eR2JGyzb/QuM=;
        b=3k1KjeqNX5JTgkmYI+xNif+CNq4mk6p4l2MQA6LJjOxcf/j0jnVam9thFZ9igrsCRo
         ds9UjFKOuJEwVxdeg/p4ksfXPgbSRmqPFMrVVhTVf1oYA29q1EYdNciXViVcvomZn44G
         QwBPkrY2GEwQuNFt2g3yO1kePcDAh8j6abZi5oUDo72UC/USgn24jq8jE6Jbdeb3An9Z
         hRNdCoE22MYQxxiRM6k/wvvHX6Cm+PvmYUbYDMYdUNcQ+NTz/w8X0chAixpLf70x5EV4
         bjSACHLx6yTMKqkkVIWqZYJV2y83FE8XAaJ4uyqwN/mnFXXieuvRTeE62vO1kI/YbLYT
         ZOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727439518; x=1728044318;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELDmQtxXpVLogwubqzTMS3LPGqaX3x3eR2JGyzb/QuM=;
        b=FJCRHSYRmRpCp59Gs+U2Vrz9bl0R9xkwn8ZuiarlcyUmqvU3axCU11yIjJFAqim2nY
         I5cfnyEaZFbeWmTaFWLhz8YpuDKZyLiOq9MosPeQxGDJoW756iuDxm6Yh4AuVeonsKO7
         Cj+GlYzRSS2drd4KU78bhq0x5sTVh2BQaordTxlROt52e/+r2VAxhfERfwWnqPd46CU3
         T47nM7MlIwb1BOeXsV5vvQa9LqaSJct/AqOgAiwQszIzSSN84XS8zkcBZVZkVNc+RABQ
         zoIy4j46bT6+AhSi2qCwgqnX5xs4XSAQM+kz4ndlvIY0foTqmOjdmtKDejouzalAJ6qc
         5sGw==
X-Gm-Message-State: AOJu0Yw+OlAodUAFwHWCLt1jjvJGF17ig09MomZh7hb/KNIOQVRT/eXt
	QspZcvGw3/g/H5A2iYfz87FfTFEUiCkU1eOOXoxXgZVxK/IRm5WfVupv4nixs1K/C900iHRJCtW
	O60INFJs0p6F4OYlcFdDt8yVgydVnx3tqGPVeqkrCLaq2z9CTomcqBNXKgRWzPscCF8C8RlH2pQ
	Rbgi2WtwBqWv5GjVoPxL9JnZKqRc/ioZ9Pj6VHLJDnIWLz3g==
X-Google-Smtp-Source: AGHT+IE8KqmibgTKaZZdzfDMUva1eju3nSdBv4cAgVn21FeAJz0pOOF7lsLcDdkXOl488n6rYNwhPcAvyq/n
X-Received: from malysz.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:a1e])
 (user=jakiela job=sendgmr) by 2002:a05:690c:2b93:b0:6dd:bf69:7e06 with SMTP
 id 00721157ae682-6e247618d37mr58677b3.7.1727439517064; Fri, 27 Sep 2024
 05:18:37 -0700 (PDT)
Date: Fri, 27 Sep 2024 12:13:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927121418.4187550-1-jakiela@google.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8186
 Chinchou/Chinchou360 Chromebooks
From: "=?UTF-8?q?Albert=20Jakie=C5=82a?=" <jakiela@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "=?UTF-8?q?Albert=20Jakie=C5=82a?=" <jakiela@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	"=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=" <rafal@milecki.pl>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, 
	"=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=" <nfraprado@collabora.com>, Sean Wang <sean.wang@mediatek.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add entries for MT8186 based Chinchou/Chinchou360 Chromebooks.
These two are clamshell or convertible with touchscreen, stylus
and extra buttons.

Signed-off-by: Albert Jakie=C5=82a <jakiela@google.com>
---

Changes since v1:
- PATCH 1/2: Delete sku2147483647
- Link to v1: https://lore.kernel.org/all/20240925080353.2362879-1-jakiela@=
google.com/

---
 .../devicetree/bindings/arm/mediatek.yaml     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Document=
ation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..47efd96e5659 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -239,6 +239,28 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Chinchou360 (Asus Chromebook CZ11 Flip CZ1104F=
)
+        items:
+          - const: google,chinchou-sku16
+          - const: google,chinchou-sku18
+          - const: google,chinchou-sku19
+          - const: google,chinchou-sku21
+          - const: mediatek,mt8186
+      - description: Google Chinchou (Asus Chromebook CZ12 Flip CZ1204C)
+        items:
+          - const: google,chinchou-sku0
+          - const: google,chinchou-sku1
+          - const: google,chinchou-sku2
+          - const: google,chinchou-sku3
+          - const: google,chinchou-sku4
+          - const: google,chinchou-sku5
+          - const: google,chinchou-sku6
+          - const: google,chinchou-sku7
+          - const: google,chinchou-sku17
+          - const: google,chinchou-sku22
+          - const: google,chinchou-sku23
+          - const: google,chinchou
+          - const: mediatek,mt8186
       - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14=
M868))
         items:
           - const: google,steelix-sku393219
--=20
2.46.1.824.gd892dcdcdd-goog


