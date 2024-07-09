Return-Path: <linux-kernel+bounces-246158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A1D92BE59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8661C230A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B919D8BD;
	Tue,  9 Jul 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjM+1wvR"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912B15C9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538928; cv=none; b=W3GSuSIpg6wKcEHv9ryjIx1ITG4RTxflHVnA1taiARIAi10mIFRJew7U7DXtKPdN5rdNLdbEIyblP1zeeNtpYY/OaD8Vxsp7agVsR0pDwicEHY/PHMjzG7ksTqD79VCKb+uCTz9UytVoMlvqcZ+s0nrVnb9TKWMq2/ZXrvgETpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538928; c=relaxed/simple;
	bh=JZ5BZeaxbdiSFlXTOCSDXtgZTkCzn2hATfivmbxW4hA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TVQuthhDPHZb8qDwetv6wiCD0NdztNeAANZPoiicakAWPZruPB/OuW1e3Df8ar/6WE8VpA0zWrVX++j2PIp4dwrbvO22+o3LVXyExU3FjLuZepsd/M0lNxHueQjqWXdlyMZupPZ9cZyqjg3yOVNlqmGb4BVnCdhYJAoNJV4SLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjM+1wvR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea7d2a039so4387697e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720538925; x=1721143725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7VCefezFc30AtwGu+xav+TuUFtkI2yJOqQ6ST8ep6k=;
        b=jjM+1wvRQutEs9SuZSWxz5YwmC8hnmWBNWWfONxsPmlu2jQXG4tjlGpJ6Gc8KdjDeC
         szE4GkZIvC9vB+XCMqagIwrku2OnsUV94u0oHNduhlh8B1N6yVqvjYbyCeYZrEQa1e1E
         2hgemWFNKS9hH3FNLVm9p3NrVOtaQNJsu64tQ+7NGj3lyC+AtH7SKBrjMRXfaLA/voMB
         8HJMnvg/gwqHa9E5ehaxCsI0dZqI1rFu5IdxBKtiMKZY4ZlhGK/X2aqLL5p15eD1Uiov
         L/v1JkQyzkNeC4iVcAzd/0eJquOcXTQXejLQtvFMtyBLCERj+ep4HvT8rbRz0qpIsQYx
         1Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538925; x=1721143725;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7VCefezFc30AtwGu+xav+TuUFtkI2yJOqQ6ST8ep6k=;
        b=Z1PTFShxMjKiWCL3Tfo3wdo2EliQCowk7buHme1Efp8H2+eLDcGc9W/A/4V48cjbDg
         pbFNVQQxUfOWFZm8qc7IA94dlgdY+Az/q8M5B86/RGEv4XASAvVJPpiO/qISxlOpLCfu
         yZsmWtEy+7QKQR7e5CrIen6ZRK82ZE/DDwUimziVOIMntqzZ8Ula06bkP1ZoMhnE3N9M
         SIoR3X5qu3hzum5VdUYzBFR1UU6nI0u9F6yW+Axl2w8oyRk68cq2cYy4AbjsVnia8jSQ
         CVVqyqeg48cpZFuADN12YlzO9HfxbaLsG9NWvttSvzWdNK1/4oZ84eahVzGo6IYl/eGb
         4wWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRPkJvXOrX6DR0a0PV47f7f52qDGzhpqNxRTfZqF2rFzBhYekbFlbOO6FglGgSKLc3fXLoTEaanPKROrL/QkDnBZeaRpAtn4mr9J7L
X-Gm-Message-State: AOJu0Yww+xJtckK2pkMMdKFEQZMPCQMw8DoKsrakok0EW+CHzBr4nEuy
	ahUmwhPOwqFH7t42ANunPxNVbS7tFV+4xoJ+t4Yc3xkhNK4XmCQckk1PeqVBvXY+H2+ni5ykDTg
	nPCA=
X-Google-Smtp-Source: AGHT+IFa2X1bOPgyGU6tWNjQXbvCOo8F9vMPhtpQvUqb8MkspFBRD/98lPiJyeKG8fauhInR8IKF6Q==
X-Received: by 2002:ac2:4641:0:b0:52c:df5f:7b4e with SMTP id 2adb3069b0e04-52eb99a3087mr1588779e87.38.1720538924372;
        Tue, 09 Jul 2024 08:28:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab748sm2849119f8f.111.2024.07.09.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:28:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240705-s4_node-v1-1-646ca7ac4f09@amlogic.com>
References: <20240705-s4_node-v1-1-646ca7ac4f09@amlogic.com>
Subject: Re: [PATCH] arm64: dts: amlogic: enable some device nodes for S4
Message-Id: <172053892355.1166789.14049124707326749938.b4-ty@linaro.org>
Date: Tue, 09 Jul 2024 17:28:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Fri, 05 Jul 2024 13:39:16 +0800, Xianwei Zhao wrote:
> Enable some device nodes for AQ222 base S4, including
> SD, regulator and ethnernet node.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/1] arm64: dts: amlogic: enable some device nodes for S4
      https://git.kernel.org/amlogic/c/d3cc1daf38aaa0dd6546dd915ce5d536c250f3eb

These changes has been applied on the intermediate git tree [1].

The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


