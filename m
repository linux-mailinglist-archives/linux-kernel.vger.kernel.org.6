Return-Path: <linux-kernel+bounces-532270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065FCA44ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2754219E0CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B891D63C6;
	Tue, 25 Feb 2025 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoH3j/SJ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01CC1C6FFF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509311; cv=none; b=h3t0E7Y6pSqAntFud7vcPfGkupZiClcHz23YhgfWe0F1PDm1YMwS5PZwd4N19Ors/+svQyp7RqnrA2mHH8fiC/c5lEjK7j2O26PkBURgqKGSh+FKRVdtXidzvoHc7toEvpmaIbVQZjB91F/UL9IiULEJJR8rcpXia3860AFoIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509311; c=relaxed/simple;
	bh=tCCjly+Qh5AY74QbK5LfS4mXEJXwkw/OWlEpJf5244k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0bNwWkmKTx9E6rvWiKKLRHu1T1sQC3Lrb9wvNpuMvCtTdpqKsU4JlHsNUyO4QoQ/9K5Ztjgz8uzTmYXEgnSTYCSvU2SSJYyYeG3E/Nt9q9eP5Y62/QsnitcMwhG/POz3TIji3r8oHF3rk1auCInAIJ8IHdAIa3119FdRlPbZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IoH3j/SJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb4944fa73so88051166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740509308; x=1741114108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oN23gi/Cv1G/Zd8ve35VhHoD43rI+bSAAj2I1PX/Ag=;
        b=IoH3j/SJJNMyiCNeXqg+0ck4j8VISqO5IN9kZ5nBdSnw9B3b4QcdgP5xP67i9rpDxX
         dmTS2sxtoRltGWqdZvOserGg7UJhrR3BixI/OXKBDKtSDThMkPp5Mze3LXLzGFV3g0tj
         pRHBYiCOKVK+GcpBi1OKpuL+ZuGa4xeBvln5nRp1fc4qz2YXfkMrT9SB4L7XWyoGujBn
         E3PYoLNkZoZr/RzT557MuOvqOthd1f1TCQkS0gihwQAnYtVIzvusr265UD/UOiC/c2CJ
         COQ9hrI/cMSEUg9jqyFs6q/yCivfqO6Gbmps9BmvaMKbdk0ilfCCcFVkhbbTxUCnYeQD
         g0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740509308; x=1741114108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oN23gi/Cv1G/Zd8ve35VhHoD43rI+bSAAj2I1PX/Ag=;
        b=NoIokCQKLOaHFTAfxEBD9ukl1wK5OEIliQZaDFoy/swOoNjHVKj7Vo0Xytm827X08K
         uYtwwbLMV8WbNDR3qvAraP0Gnv68yrhf4rJCbZJ89hzTTyZS9UH4N1FikhBwz6DmAV1Q
         1izWFNUQIOiM33ZbtA7sj1+YiJxh8tcAhKEt+5J9a5t++us7KOv915q98g5maBlm8XED
         Yf1ixaHriXPZs7AtnWG9irO1+amRbNZfROzHuQTdLTugBbZftoYPKqF943FtUZ5QkzOW
         bL+PR6uLj0FvzdEff8bIX64sBog7zwPaty7Ot3FkbX7HrnoKsMpXy8wUBkYg6/p6jyfM
         vHEw==
X-Forwarded-Encrypted: i=1; AJvYcCWXoRB3Byzf9+ZWQatVw12zFngOZUetRYV4T1owQkMSP3FvQx8ZjUqJe09B93AzBaq4lHD7ECxitRShiMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkH1PVwIh556N0+SJ7QWEDgHng/QIfV5rKRP3qMay2AM0j8dR
	LORqWQoOyD406kkCV1p9mn2FGWrRmDpXXlcRY2XDkVIRw06rSRVpd/q+/PwApJM=
X-Gm-Gg: ASbGnct/0I3kwsjwXWmGbHORGHC8lLYNoJSPJEuIvLHf/jUEtsSIcd7PV5mUCIL0Ao9
	h/EMaO4kU1cACkHWKroHnrtLmRRUlCN3lSjS6LN1UnH80/tQQW3UT4DLdqZnW16C20B333dyhDw
	Ls4gruPrNvSEa0dGC/5+k+ehT44MgN83dLbW+QNiKIdXGBEXsfFuGLA7HJUxukkNGKAH17S7PYU
	PlcuFMM1aW83q4pCm8nUJJ3mVByK7xjYp8JWtMbsdeaMutLoooyS/OhYHg6f5fcAfpbODDKhkYW
	sTRO/b43P7oVuSYjzKRiUC1aUl5T25pa9zvaSpb4GOL/mAX8N6y0tOn9toV4JQA0Kyox8qpoNFE
	=
X-Google-Smtp-Source: AGHT+IFKOZhRHtEHCCTN5BHVYVCPkFDsRkb7jCM4fs2ECH+kp2S3Jaa2qQ2qzrnOEoKDVZtT2N63uw==
X-Received: by 2002:a17:907:2d20:b0:ab6:b8e0:4f25 with SMTP id a640c23a62f3a-abc09a14d0dmr792407366b.4.1740509307824;
        Tue, 25 Feb 2025 10:48:27 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbf55sm185359466b.15.2025.02.25.10.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:48:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] docs: process: maintainer-soc-clean-dts: linux-next is decisive
Date: Tue, 25 Feb 2025 19:48:22 +0100
Message-ID: <20250225184822.213296-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225184822.213296-1-krzysztof.kozlowski@linaro.org>
References: <20250225184822.213296-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree bindings patches go usually via driver subsystem tree, so
obviously testing only SoC branches would result in new dtbs_check
warnings.  Mention that linux-next branch is decisice for zero-warnings
rule.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/process/maintainer-soc-clean-dts.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/maintainer-soc-clean-dts.rst b/Documentation/process/maintainer-soc-clean-dts.rst
index 1b32430d0cfc..5423fb7d6047 100644
--- a/Documentation/process/maintainer-soc-clean-dts.rst
+++ b/Documentation/process/maintainer-soc-clean-dts.rst
@@ -17,8 +17,9 @@ Strict DTS DT Schema and dtc Compliance
 No changes to the SoC platform Devicetree sources (DTS files) should introduce
 new ``make dtbs_check W=1`` warnings.  Warnings in a new board DTS, which are
 results of issues in an included DTSI file, are considered existing, not new
-warnings.  The platform maintainers have automation in place which should point
-out any new warnings.
+warnings.  For series split between different trees (DT bindings go via driver
+subsystem tree), warnings on linux-next are decisive.  The platform maintainers
+have automation in place which should point out any new warnings.
 
 If a commit introducing new warnings gets accepted somehow, the resulting
 issues shall be fixed in reasonable time (e.g. within one release) or the
-- 
2.43.0


