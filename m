Return-Path: <linux-kernel+bounces-414806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F229D2E59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC08B3A350
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0A1D5ADC;
	Tue, 19 Nov 2024 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Oob14V6y"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58B1D2F74;
	Tue, 19 Nov 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039738; cv=none; b=mTYfGkJ3xo9qmwhi0llouxYcOQWolKVj89psiuGt7XFCH4VDjASXtAfgpFR5jiSeJpDYX0W+TX4WbwCCUolj+deOffNUg4CMZSiWS/F5DnteqCcEGBJgTW9WVEBeYkRWzgHkIyXwmpg+KcWmuLFhFI6JQzZiw1Z7zwYXM9Be8uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039738; c=relaxed/simple;
	bh=WBkC4x3oH+HjpkoWuprZ3+yelzSdxKIMIhjE3Q1t37s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUYk4bW2hKHHkqW2ABmrEGK9e+p97ih5lvmuFhp13u6GGKxzUkoNOf7qu24/riALpX2kYKcRuo/2d/Yp6lHEvDZqe6gPwqKBjC6MI5lBye6ImeX5T8dCGHVP0tBvbmbGh4nNPYrDP/om+LUpOzbDlb14/P7Ak1XPs5PHmNwj8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Oob14V6y; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 201BBA086F;
	Tue, 19 Nov 2024 19:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=g4/9K9HMLuruP/s9d86N
	LzQjUpmhboWBYp4iW27/LDY=; b=Oob14V6yZVpXg9Q+F4PZ+Vu49tH635mhzce0
	W1c7vrjHsjDNdPpg6gfpDajmKCRvjjtWlj5Tcg2Ri2n2gbUbQT7OqRBYuvyXZ00h
	cGa3xQnswHrZv3DSq5Z2xn3JzPmRA2uZ4/0gDFRryPsaf4CfZzWzkSi7I5OFzEk8
	p7LG6dMuKN+z9gF1ZhgKLU5+Bb2zNmssqjnUawJ8lXfFiBJ8qkX3cNrM2B2CKBtm
	L4HIO46hkWlSi1Ar+DecDp0X71ICI0HC0HXD1zfkfoEwlH3CJ3saSjsc6kcPic8A
	MViqINXLoTXTi36Lnu0EumeNodbI1c39xGJedyPmOlfr0bVOboA3YZX3a3LhDctS
	n2JBOWdi4V3HrMnrWFPDwnlAxTIP131BGKKOkr5Oj239BPCcNS0ZXdXJpycJYgA1
	1eem6Yd0bZpCAEwA6Kxt7xAf9TnkO1Sqsj0yyJVF9biv5OyOmLMKepVb1ixinn2L
	HRYi6VQgqmF+XKlPX/B8V7bg2N2tX5O1/WfRraTv+h46LhUJTy5fI71WRiKR7cDQ
	Mxrpda6Bc9WuBTHj28vppBQh/E5S4ZZNDEWgSVk5f30SmkfZh39x2fGDrLM1DgB7
	6lAl4iC0lIninpJDfrVgSbBKlxw+1KO80FjkirG2PqctMUfbwCfaZw20POI8Znsv
	ZTA+ZTU=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v5 7/8] dt-bindings: trivial-devices: Add Injoinic IP5306
Date: Tue, 19 Nov 2024 19:07:39 +0100
Message-ID: <20241119180741.2237692-7-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119180741.2237692-1-csokas.bence@prolan.hu>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732039725;VERSION=7980;MC=1249036192;ID=46212;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560766B

It is to be handled with the rest of the IP51xx/52xx family.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v5:
    * collected Rob's ACK

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 9bf0fb17a05e..1538f1ce3238 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -147,6 +147,8 @@ properties:
           - injoinic,ip5207
             # Injoinic IP5209 2.4A Power Bank IC with I2C
           - injoinic,ip5209
+            # Injoinic IP5306 2.1A Power Bank IC with I2C option
+          - injoinic,ip5306
             # Inspur Power System power supply unit version 1
           - inspur,ipsps1
             # Intersil ISL29028 Ambient Light and Proximity Sensor
-- 
2.34.1



