Return-Path: <linux-kernel+bounces-286597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C556951CED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDE928904C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339A1B373A;
	Wed, 14 Aug 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxgzAmyM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E01B32B7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645261; cv=none; b=KM48ZbSIhV4gfF2qzfEj3F0JmkAnh5PqG9odBjfy/C4RJRlabnSMVgG0nNPrf8Yo0wSGS92amz/ehfAbx5i7DnjSOt06q8o5QOivlKokYRTBdpgyQbhDjcxRMTLvWfS/87SoLas+awMBVrmwwdv3G1oZ7twtiXJXXyzGFgk9BEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645261; c=relaxed/simple;
	bh=e2B9/Cs7d4Es4Ydx4mTglOtYWxfhlPYZWRfMX/o6h50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sOQ5SW5Z05+AeBglwn14IJq8k1Fyrz99yRz6xAywGswtHFfnq4mrxUA5fiI0l6+5u0ouuBmOzVDKpZNwEVPLOtu3kNUQpwvJFCXVKM7CXtdqGQhK5usbazrJZHSEIsIjnuYG6KsgttwTTrOXAnIEek3dLFvYcDcIWD66bfKSrKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxgzAmyM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42808071810so49854075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723645258; x=1724250058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dydVKtkIk6+whYZz2cb1BbukGAXA5bfaejUInxNgps=;
        b=zxgzAmyMn+UnboQXscXLY7FHL3TXF30/Y0wY9sA0w9DCuCYE9SPmPupf5iUB2xwDtd
         UP1GcbduEKgIA9yVF2Eb0RPv0Vj8NutVfE+oR0ENUtlPKp4KYs8XCdyQo3GIuGZ9H3CL
         Uxe5i3E/+8cLQMcOfFjxxutGNx1rSdrKEnLsJ8ISZaJWl8fEI+S4dmxTIiCzbHo1oFor
         Ly5d2uITzdgWzRqlDKjD0FKFhX2SysrwKgjNV/LHO4+/WwsWpdzZSaxH4ojB7DsfxwCI
         XE+LQmVqLVcEAEWs9FvONJ/a8T/4w21Z9NEVRlh0KEV60yRhogejMzLdKCFIgtGWRQfn
         84TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723645258; x=1724250058;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dydVKtkIk6+whYZz2cb1BbukGAXA5bfaejUInxNgps=;
        b=kMOFMq7zKfBAJ69m+l9uoClJFAmGjoklA/rcyj38qdi7zoGrl1Zaxs7nsAsLLOii3t
         EdHjR5rJW9JAume/WlweBnlOB6edpMimPzI22vNF/aYPutgMnY+vH93Y8phRJDVF+W8H
         B/thA0gK+8Pxds61rDkb+xxpUdeD7DG4RVkt4uQuAuZwAYln5HGF6X3b6jlZ2yeqUp8T
         QXSQCKB4V2DTJymo2NnMIeqjMlSoc86AN32yZjdc5Y1tPs1B3tXSJIJvRCJhhH38Lhzy
         BlIUCWGSn0DoImdQOVJ+GOlYea6lLzwWLwTXB84I37Q1TZL3TyYz+zXIZuGojsSOm3lT
         DMPA==
X-Forwarded-Encrypted: i=1; AJvYcCXmqP53qS9mBFAeno8kCxvEChy0aJofgGZlBjkYZ8kjv2AIsX/j5jQAIAnPWzEXh0w8X8ASm0Qqa3AjQHHSbLEGEQaPGm/6hXr6bo4z
X-Gm-Message-State: AOJu0YxY1KrXbLu/lpq/W8E5DoV4r/IU1FEI8+EMcIEgCsxMMB3FaPXZ
	xjiyDmLqrKPQxd6O040ZwtUTB4LGPiJmvtRGFk1ymIRIhw3EyXbBpcFPLNuvNig=
X-Google-Smtp-Source: AGHT+IEULeUH1zJX9vJZQF4v6AJw/7s/pzWL+QO+XM+pg43wSACflFFsEcM6MgGiffHSOP/3R2h+aA==
X-Received: by 2002:a05:600c:354b:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-429dd260171mr23585065e9.27.1723645257861;
        Wed, 14 Aug 2024 07:20:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded327f8sm21211085e9.18.2024.08.14.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:20:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20240812123055.124123-1-krzysztof.kozlowski@linaro.org>
References: <20240812123055.124123-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] memory: tegra186-emc: drop unused
 to_tegra186_emc()
Message-Id: <172364525673.95325.14279036440219295213.b4-ty@linaro.org>
Date: Wed, 14 Aug 2024 16:20:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 12 Aug 2024 14:30:55 +0200, Krzysztof Kozlowski wrote:
> to_tegra186_emc() is not used, W=1 builds:
> 
>   tegra186-emc.c:38:36: error: unused function 'to_tegra186_emc' [-Werror,-Wunused-function]
> 
> 

Applied, thanks!

[1/1] memory: tegra186-emc: drop unused to_tegra186_emc()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/67dd9e861add38755a7c5d29e25dd0f6cb4116ab

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


