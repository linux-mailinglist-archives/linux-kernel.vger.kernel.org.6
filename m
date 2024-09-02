Return-Path: <linux-kernel+bounces-311362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9F396880C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6BF1C21D83
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C11919C571;
	Mon,  2 Sep 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0Pubn1Y"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BDB205E09
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281766; cv=none; b=iK06N9RqdqLHszX/q50lwSUNJrHhvTDCDCb/QcF87jnenq6/OJqTxoZdaY2x13x3wUFKLWNSOuiPs6eQ7PAOefA9PxWZWe45p9/WOWRRFS2ShrG7IH0gCL4/ZABLC2l4nFKqfUouFCU6npBCCFXpaGJRHseLggcOWT7mxrqRwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281766; c=relaxed/simple;
	bh=RLumHEb7qWE4JfyCA5WnXvYQKHxzAU+asHtpAq54IBg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nvAhHBLQIrnvut+6at1OHwnr2V6lXDxoC/kVIQ+CXFjUiSeMGQgBG8QiXr1Lg61bNkKA6obKEFjK1SDKWP8JXsnZPOqssZRx64H1K9myJMCq4k/PDNRZEebdxS6tRde4ZYVuDzLvcwhYn+2Oy+Ei4OykHavHpGW8MksQC+PPxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0Pubn1Y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a1acb51a7so17019366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725281757; x=1725886557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRq1nfnnUhUMRuP7ndrQm92a5ybx/cYKL+FVE11lKTg=;
        b=C0Pubn1YVZMNhnWyD7TAI/WWwpxckCyzaf8DoWdkhQ4nV08WfGX9k/khFMExUi5Y4j
         HYEe1pcoV3pI5JZXz5M4iV5p6TOr9kEAQ2AcWFTBxIlVism6vJD86ZtxCChPyI2YDmWj
         cOOcWxqg6TnaDEYJu9NN603orPUD/4kgjiIXfWmdatzp2xceNyHWVMEjD4R/TubYUxo2
         RWQG0s5Mbx6GunquOOD8QmPvPu6J7yAEAIe3e2o9bTO6sTrAY3dSN0qYAbNjNmhBscqC
         NDzgUSTyqLr6GXB42c51HRG6EqfVhAk87VSR96UIYJdOpOSpmQinpMO2zMzZXbFLwa2j
         uHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281757; x=1725886557;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRq1nfnnUhUMRuP7ndrQm92a5ybx/cYKL+FVE11lKTg=;
        b=vgnYfc97gqHNpY+2tj1IJBh8WkfY92fY85Q2l+rfp9e8ey6LnnO58MiQXoVisb/n/+
         Lin2wFoEgIHM76qiqCbYl47R3NtTFwon3PvXdiDRzA7zt7py5tnGBsMQ7y3TTecX3h+q
         diIlPezLc+tIPzCspBPIKQA4RATdKo4rKWrsy8NujAUVg0ev9Z8fXpmot6eK8ggdr2jx
         QYDz/O/pFTWej+OS/ijwelHjrgnbYvCf5x/Ph9l4fot354u5mkplPQv++h8cYF76QOH2
         R5caOr+lk6edNQwlqwv/Iccj2CNos3766EC3QfMwHFR3k3sZ3Q3feXRB9C9iZjaTHIjd
         zOcA==
X-Forwarded-Encrypted: i=1; AJvYcCUMx0MDLJEt+ez+JrNdVEgUSe+eMVzC+9JkW4E2WKMEl9s62nBf7quJptvXigtyFgw9wRsvlEsWgpYgekQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMh7kocMS1MubQdtOTwzt4Zm3dSv9H7HuilTrnJMthGfJH/8Lk
	E09uBgeUgCZDgj0YsNd3g6A3SFgEqCyZgyyGWKSRAUQuxWT67EH2g83HFM+7XC6D9hUK+6rNLF6
	A
X-Google-Smtp-Source: AGHT+IEoQ4/Dfc500DOxwirAQ3QPvKcm4UqzswYSK6n4xJfPLS8U3/M0gXvKw2QuMJYLiGjD5OQvnA==
X-Received: by 2002:a17:907:944c:b0:a89:d1cd:1936 with SMTP id a640c23a62f3a-a8a1d29ba5emr10139966b.3.1725281756767;
        Mon, 02 Sep 2024 05:55:56 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb410sm558203166b.21.2024.09.02.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:55:56 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240811151737.106194-1-krzysztof.kozlowski@linaro.org>
References: <20240811151737.106194-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: nvmem: st,stm32-romem: add missing
 "unevaluatedProperties" on child nodes
Message-Id: <172528175582.63217.5487746839450506262.b4-ty@linaro.org>
Date: Mon, 02 Sep 2024 13:55:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Sun, 11 Aug 2024 17:17:37 +0200, Krzysztof Kozlowski wrote:
> All nodes need an explicit additionalProperties or unevaluatedProperties
> unless a $ref has one that's false.  Fixing this for STM32
> Factory-programmed data binding needs referencing fixed layout schema
> for children.  Add reference to the NVMEM deprecated cells for the
> schema to be complete.
> 
> This fixes dt_binding_check warning:
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: nvmem: st,stm32-romem: add missing "unevaluatedProperties" on child nodes
      commit: 0d1d52a2d43b56d6bd33328583c81d85c1aa97f6

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


