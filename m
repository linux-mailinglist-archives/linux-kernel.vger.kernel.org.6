Return-Path: <linux-kernel+bounces-398782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF99BF606
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA6E1C2240F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5563207A1A;
	Wed,  6 Nov 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC+aXuHF"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98692190678;
	Wed,  6 Nov 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919935; cv=none; b=rkoYwdZW177z7E0LZRzL41B2CLWiwh7gvXXXf/Mibg4cqW1QapcDhBQhJjwAfxyIhMuH0P4XoicqjUG5gCHe/5OAOrT9xKBBwr76gUG4mBpyXg945w3iD/P4Gt0zP+irfojaYRLfFcAZ0s3EChi+5aQtfnrTUTj67gagCjYhaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919935; c=relaxed/simple;
	bh=4jUzCdYPHAJnoEwNBEJqr1bW5kUIGsQiJGk7Y/lI4mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0hbXYruMSKflHDSbUZ+30cTpCeQyrrWTb1WBILX+lCNzxAYdv3ecrNEo2LHzKfnx5WNlv7NtxbHCs3Rfv04VygNYiN8Qk2zyYGDr8YWAXqnfqRTGhwzHYkDihiX82cdJ5BXWHD9cTM8qZXK4wA8Z8dtk5UO6abseKM5Po5rQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC+aXuHF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e690479cso45357e87.3;
        Wed, 06 Nov 2024 11:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730919932; x=1731524732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpTHncWMkMv9zIRpY4TqK3oFCmm5xn64bcnWELKNPJE=;
        b=JC+aXuHF7+pcMhQbpsT8OcYQsthcqg0pljUZhjczFm8oaSkvPFKe5exFrWHoBbtpbo
         ENp8vMvJcDOa3XFm1fnDgNSSg7i5O8LX30c4WL/FDE+cRoT8pFGEtyV4qDBHu2MvtWVi
         KS86NTWnOB3fzg+oG842ii64wjMlgeDx48T7OeZ4F/Q15FdFqZf9T06UDPTD2Mwkwvav
         B83s6wwJEzT4Mn/BV/Sy9NiLGcmvK4wtRfIg56nigyBHHgktVUMyInI/QPxPWREpzAPS
         08XghgiWuUjrEemE3YTreEy5kBHuyqSNvqa6J8pCx01CTTsh3QPRLujNA2sd1PQ8U82a
         ZlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919932; x=1731524732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpTHncWMkMv9zIRpY4TqK3oFCmm5xn64bcnWELKNPJE=;
        b=wVIu3/H3XqfPKnHiKmEFXoK8Qls3eW9hkv/zdQATCqtqA5Mqnl1xAAV+QH7h3MlgCY
         m5yw2VR15GPbqMeDLccdTAt8+tXDu83OtOakacatUQnrTMZjiqlIXX+1Q5qRaSO2i4oX
         5WKVdaynKEDbQvVFlHVjELQvijUZAj0erk/vXn+OoAA556Ti2eCbw5XhrjlF96QsK4W9
         TLBDa9zgM49OW80/2g2iKS5OSA46+etXKdOGUAd/VFVeV9bpcF09DHIObOFWEQjO2Ej9
         2Oow/JK0qTyA0/p6pjDf51aPe8C3IbLBfQ3VDTrNrETFvvOt60kOIyOFmNBnTYlauFPR
         kfnA==
X-Forwarded-Encrypted: i=1; AJvYcCX6mCYM2xNU7503zhDJbOF7xDpcMkaTSFUS1bzDGVos3OJdNE8/A85M+GOOdu1wJMRA9Z4RV+AAbUMj4Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMmOlYH0KDUj8nr+Euhfm48uAeGUxKt3n9inrMwoARmnl3tgW
	AZVq2PKzssxfCjZRgr1qHYin0U9+Gj2FDEMdUa+il/JJQqx7GPvIRyqKzQ==
X-Google-Smtp-Source: AGHT+IGEor+7zD+u330H557Suhcp5eKkaVdt5wNtOe/FNk3O42MzAo0FSC1LeXPo8y3gu3hireahAQ==
X-Received: by 2002:a05:6512:39d1:b0:539:8b02:8f1d with SMTP id 2adb3069b0e04-53d65df2a2fmr10829214e87.30.1730919931330;
        Wed, 06 Nov 2024 11:05:31 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6b102casm3106827a12.87.2024.11.06.11.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:05:31 -0800 (PST)
Date: Wed, 6 Nov 2024 20:05:29 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] arm64: dts: sprd: sp9860g-1h10: fix
 constant-charge-voltage-max-microvolt property
Message-ID: <aa557091d9494fdaa3eda75803f9ea97014c8832.1730918663.git.stano.jakubek@gmail.com>
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

This property has hyphens/dashes, not underscores.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
- collect Baolin's R-b

 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 095b24a31313..cd8b1069e387 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -71,7 +71,7 @@ bat: battery {
 		compatible = "simple-battery";
 		charge-full-design-microamp-hours = <1900000>;
 		charge-term-current-microamp = <120000>;
-		constant_charge_voltage_max_microvolt = <4350000>;
+		constant-charge-voltage-max-microvolt = <4350000>;
 		internal-resistance-micro-ohms = <250000>;
 		ocv-capacity-celsius = <20>;
 		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
-- 
2.43.0


