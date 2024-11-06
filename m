Return-Path: <linux-kernel+bounces-398785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854909BF60B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C7B1C22513
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F72208993;
	Wed,  6 Nov 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrlhC3aK"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09C20823B;
	Wed,  6 Nov 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919957; cv=none; b=BIjw/ULeulXrYDlmswu+nxBFnAJEr+l7dGBbOwyszmTxfPzm9BCa5DWmxEauzPRGdWr0lMrFryj1MrMfu1mUG2lKMWgeT4Y2Q/Zz2mvlKY4xghvtz/2tv0y15BS+qCgyXKdhCoeQneVBAcX6L6awn1+P/u6uHstxLzdg+eRGttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919957; c=relaxed/simple;
	bh=gYYE7WALIEpcM8xTZ87zKQaz0gv3EJqz8eHRA15wiPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgjjV0PrvLthq6RmRBtVg3apJEEdLriUbCuH6h8WfjFxoffG14LXHrgL4XvpAp2DLFNuHhByxJDJqz9ZkyUmQwtPY+bWPdGuP9AXMJ719gT8p3N01UKhP2+td7gxIuE3TEiLW+WS++5WXDxVHovOFLmJA0bkBa2yTABjlxI6GFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrlhC3aK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9eb3794a04so11760066b.3;
        Wed, 06 Nov 2024 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730919954; x=1731524754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cF7/ktaa6n7PwbzciOgKkGQIXgDWrklYx6VwJJpF/NE=;
        b=WrlhC3aK7USzGuMC61XHIIT9O9pPE5L4wGXBeTF5g6qpmc5IH8y3loaYHa2aGpp/f2
         PVwpHpL6zw5Qm00+GxLp1aqdMjerHQnPwpH0YWcs/wX8RVRm8vGIMKLWc057LKahGmhl
         VSE0j7nI76Q9bMx1kJLWKnXBeUhoMzZXOAg1/AiyJOIAdxHVPVihn4Ty8HKwBHwYpBnE
         +Dq4YZix1rk9zyzaZxXxJxOU/edrVACELBfPrb9p5VZOqDeS+miUIddcNJ9hzbYAgSmR
         SIusxKlfs3eMUoRIwjGulGmPm7/Vj0Vf3sor9DIsCCDuFkP8Hem2tHiMEGtH2TtxFbpH
         oZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919954; x=1731524754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF7/ktaa6n7PwbzciOgKkGQIXgDWrklYx6VwJJpF/NE=;
        b=pLNBhuJ/+mn/sPDqcJTg6fYnSuPtmpS2WfJlZ+RuJn1WVrbcpyZIQmNIlcMeBX1QQ+
         lFb6xFQMRCt+Jx4Ac7uuJnU3GWsyNtbQI4X+SZmPXED+qUHAfMOcuhkpAUz7DQ5I0flZ
         sET5FB5diHntsbHPDjXNvHirkgdmk6mnTqdG7jWJ/y+FLQstt8dkM8qkN8fo0bqAk4Bb
         /TZ25NQ9JoYO5YUiPUSEmedNwzjstcFoQ6AEwXdubGVc7OB2kI/hUZ4LUNyjCSiZrt8D
         pk2mgNeAH84iUqgrVIRNAPF3wM/kd+diMxr5hpGZyPZ+tZj90ZbcrQZzhOFZ0j9LovEq
         jWSw==
X-Forwarded-Encrypted: i=1; AJvYcCXKV1zYoZERuDITRGhZscmpZxYB7h9bcLhotqc7p4FRSz+ywvfg/rotRHNiceEvg+aRKjO+viVG1rorMfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHeN1BjfRT+EpdoUx1fMYBQCuEZW2oE/T0MF/0/L29TGLPMQF
	y2b56dZm1TCMRxBZ4nYi87HleJJHt64PePGD0CbRiNAaeMN7shG2Ioh9/g==
X-Google-Smtp-Source: AGHT+IHb0/KCYL04U0/vg62SxELEsU7lhBB6XVEUFvURcuXb8fhbHoL2HuGK0YgGOMa9LJAnenQfnQ==
X-Received: by 2002:a17:907:26cb:b0:a9a:c769:5a5 with SMTP id a640c23a62f3a-a9e3a6c9183mr3031181266b.50.1730919954233;
        Wed, 06 Nov 2024 11:05:54 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17cf906sm320785366b.112.2024.11.06.11.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:05:53 -0800 (PST)
Date: Wed, 6 Nov 2024 20:05:52 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: sprd: sc9863a: fix in-ports property
Message-ID: <5318a47282b8c15a3135fd12dacedb8aa70592e2.1730918663.git.stano.jakubek@gmail.com>
References: <cover.1730918663.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730918663.git.stano.jakubek@gmail.com>

This property is called "in-ports", not "in-port", fix it.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
- new patch

 arch/arm64/boot/dts/sprd/sc9863a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index e5a2857721e2..31172ac44adc 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -288,7 +288,7 @@ etf_little_out: endpoint {
 				};
 			};
 
-			in-port {
+			in-ports {
 				port {
 					etf_little_in: endpoint {
 						remote-endpoint =
-- 
2.43.0


