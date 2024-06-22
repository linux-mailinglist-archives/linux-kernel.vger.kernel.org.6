Return-Path: <linux-kernel+bounces-225700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E50913400
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB8AB233F7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22516F0F4;
	Sat, 22 Jun 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMSgJD9H"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331516EBF5;
	Sat, 22 Jun 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719060374; cv=none; b=QMSknOKbxFEwgxYeWx2qxk4kl8DczUAtkMS1Kh8Z+yHVNag0pjrLuPyqVjzzgdgV4ThUX2OS7xOVy9ssWagiFIOgQzxOCcAcf/3jL5E8he+qVHRy31AiqIezkQ+6/x+xcRbdI32VdPotzSnNgpAlLShSICEIk3KuWkRZkFY1Ksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719060374; c=relaxed/simple;
	bh=wguNbuw7FMvZL41k2nqi7sLsthh6o1r8emQiblZ3Bpo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izCN/Q+zd2JKOW9Cii6EXyfGYwv1ZRUMHa220HWalkbq+VIOulLv1tpfYZgjjKWO3q8Kda/DWv1kJy52c/+yFubdaCj7KH9mwot5UvMeW6y8Sl8vGedD9sSfYuEw4eCEkKvx0leeubPc+i5S8FhsJwMD1DxE3qsBkQfMIOM5bWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMSgJD9H; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso5363768a12.1;
        Sat, 22 Jun 2024 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719060370; x=1719665170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rYO/3H3r7dblkwk2TxcPuqguXSZncMIlUA/OhiIqjk=;
        b=BMSgJD9H6qaYsCvAiZKY8p3O4R2RbArXtj41KQDDxMLCYJ96p8ChcCryvoBTMST7Uh
         VZLh/2MwR+ww3HXa9jgX3HMHBJIvW7+GKtkbY2pW4Cl5CPmPX8f+6vHORW6Z809956LL
         o2OKV/RTRR7dIK53QN0+gCQXDzrdI1B8upnEVH8WFD94AGi+x/Jl0/6DCUPwiUbh1F8l
         gF6vMzZZsdUXytkwFvUUpOR5uNVALCeBp9BQgtakrsbfwfC9WWj+iiWrWPb9mV/7DpjC
         u1dczlAYTVxUMxJZHXF7LVOK7LEeb8JUnOTZ0Gn4qSVDHEAr2mN2+yMqlGx6M/WkcM7Q
         Fo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719060370; x=1719665170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rYO/3H3r7dblkwk2TxcPuqguXSZncMIlUA/OhiIqjk=;
        b=ibwvi88Km8nX1MVL15FusSggW+1v8DGmn48TEh4WdVaqH9kr0Do76NgDRhIXh71S2T
         QU5tLgHCbnb9S0ivka+r83BNZZbWQ6Qvrqt+Ijc+prqAllpvwlH4k4XoNPrKSZypH1om
         fxyc5od+4e5nqCLPytJN4S5eMmWjRZWLS3l1daxU4PsCuJUFzG2bAvsZUK6I4WnNiJFc
         bkfi7uaJiJXXUK5MlpzBdKWuxD4t2FYiGLi+IwlqVg9ubDmuEOuZgcePBc78F5aYdPG6
         DCl9eROb7yGpCWHPCDwazGl514iPDiMjFMrjh0OnQ1kyMMDEAqRIsRUkmFerA2zJzoIO
         WF3A==
X-Forwarded-Encrypted: i=1; AJvYcCXFtrdrbGkJ388Am66AUJAQJb5OuEpGg6Wy9J/XnRZyXYfYovtN04WCEBsuktE6ATtZXUUCqmYmbzVpDRirPyzryCntIx4vw/f9SvnDElxykJObvK+DbDpSMcJgseNsKr6y/hFe2rA+BgAhgJUcDuM9qAAi+BNhjMdNrhZrF8mrb0MTtbgK
X-Gm-Message-State: AOJu0YzFyyKESu7kwWnBLB0WKYb4za7QNxJp61XhAaXjd4fwZgrJnlBN
	SlFiPW5N7+TNmaVVN9V22m/9kLzXygEEOypMyKQ92MqY+cBpbMWO
X-Google-Smtp-Source: AGHT+IHUkvCwDmjtM5u94ZjAM6ZoN/Z0BO1NdF6gcnasiwVqh9Sdu5ciPtX5KTt+zJH6KRyvNqGWUA==
X-Received: by 2002:a50:d655:0:b0:57c:bec1:ff4b with SMTP id 4fb4d7f45d1cf-57d44c2daeemr866438a12.10.1719060370294;
        Sat, 22 Jun 2024 05:46:10 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d31f33086sm2122853a12.61.2024.06.22.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 05:46:10 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 1/2] dt-bindings: sound: add ti,pcm5424 to pcm512x
Date: Sat, 22 Jun 2024 12:46:02 +0000
Message-Id: <20240622124603.2606770-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622124603.2606770-1-christianshewitt@gmail.com>
References: <20240622124603.2606770-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ti,pcm5424 to the list of pcm512x compatible chips

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/sound/pcm512x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/pcm512x.txt b/Documentation/devicetree/bindings/sound/pcm512x.txt
index 77006a4aec4a..47878a6df608 100644
--- a/Documentation/devicetree/bindings/sound/pcm512x.txt
+++ b/Documentation/devicetree/bindings/sound/pcm512x.txt
@@ -6,7 +6,7 @@ on the board). The TAS575x devices only support I2C.
 Required properties:
 
   - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141",
-                 "ti,pcm5142", "ti,tas5754" or "ti,tas5756"
+                 "ti,pcm5142", "ti,pcm5242", "ti,tas5754" or "ti,tas5756"
 
   - reg : the I2C address of the device for I2C, the chip select
           number for SPI.
-- 
2.34.1


