Return-Path: <linux-kernel+bounces-211180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02E904E18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237FCB233F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AD716C871;
	Wed, 12 Jun 2024 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9DsUJ2w"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05722156228
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180782; cv=none; b=ZfPJwSuRCkfWRPVxL0VYgLCK4foR9WsKw0oFPUUgCXhjlVG3ppgdbO9DgP9ni0KkxaqtdL97UXWSFSgq+IDYaFgQoZV0XBxLDIiN7povq9/9PP5CcLdwoo2vHHQdu36I1B8PXZpbATK2EnafiE/3GvgCstBfXmV91Fa6daKlKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180782; c=relaxed/simple;
	bh=KQrSCqlzTrL7oFDzlM6tAW3pOhgm9VGMl0hJCXrUo+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvJZ+JnsdDffmo2ovFs17ZtPdMLenOZe28oWkc/bmsuirJsJD5p9why+Vixl1Eb/+UiU9zci86/H8a2YIzry6ZPKkS/sjRwNQKyqy4jkDixvogtWmW+D9h8P9/0h6vDsc/Tb9u+R0ETWOqc6A4FFcORF5By5pyOyVTUnUPR2GTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G9DsUJ2w; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f1c209893so4069940f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718180779; x=1718785579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD/AnD8jYjxQt+A8JZVZ4x+a3sskE6EWblVU1rCcOAs=;
        b=G9DsUJ2wA+M//WqZcDmUj7DcquMBBrdbYlqV5QB/trUzQ/JHo6VZqD0QDSB3q4qYbU
         fSt5zlLiKd3xBVpwGvJf/ohna73B+NIbZ7X7lr3yRJAPgDBljFdXO4d0Vh3HhYTzoVrz
         dmjL7knjBzdV7wSNITlwb8JVwuYb1nEWgwntxS8WlHt2XTr8dNy9Af4Q57ilSBCIY0Gc
         DnZ4Na7C9yOGize18Oj3gQweCWUaqgtNcgYuGTzpth0xvVadSpCjQYJPh+cUuujFW/+2
         uWRyStzA24PDG/IwltiUpv9uOEIFfiCxpyH5RoPFOQJOVAN5CmBpNGy98vpub2pS+W4H
         ZAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180779; x=1718785579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RD/AnD8jYjxQt+A8JZVZ4x+a3sskE6EWblVU1rCcOAs=;
        b=LZv6E1RDRCCGtiLYA1whMDrJslwpDjPlTRi7OQDSLg4o783lKiZlRp3sIm4ss9YCgw
         Xlx9iY4U/8+j4Ma9Vemg8mFXt+I1vRaXZMoEy1RQsPenRAiDjhydu1XkktU8s/LBZYFy
         m8XIYG2V11S3UwpuIlLA38NdaRnJr8gfZOfn+SO+yBinYiEAM3ZnnszchGE3kDPJ5TT2
         0MYSAWIl9z1S5hOkNjB0B8eU8eNwkaDXsWq6+bzYPTIb+0t8xZ9kcTNORBS3NB2e432O
         XWbN+ZwvLrx2fZWp9ceMAnYwHZBagq5C3jBPmRLA0QVb9kwagGSdCxSK2i6vstiS43hL
         qDeg==
X-Forwarded-Encrypted: i=1; AJvYcCXmWy0CbImd8EdPfg/W6yRiofUd5JAijBnIPTvEVkxZCj1Q4bMfG5Ev76v1jS3a4hkqQogZbbgxoWOScS2fjDipFb1i0WFaqehLTDvy
X-Gm-Message-State: AOJu0YyDhC6hJTsZk8f+DmMfl3Yc/CJ7ijiK1Tep2HUJVqB/XWYUx/jM
	OKHy9XMsinp0OXxgcxfprW3w7RUhTwymjgWjWgKk2xEv6IpKPRua7x1LcHpsZKI=
X-Google-Smtp-Source: AGHT+IErb8RFlvw6xH91ueUYnFs5XI7s0QBkhIDzPd1VcUWd7DB8bzcwthOaKdk+oT+Uq6R345A4uA==
X-Received: by 2002:adf:e6c2:0:b0:35f:225e:400f with SMTP id ffacd0b85a97d-35fe1c0a063mr870657f8f.30.1718180779272;
        Wed, 12 Jun 2024 01:26:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2d756539sm3702255f8f.90.2024.06.12.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:26:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Esben Haabendal <esben@geanix.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v3 1/3] memory: fsl_ifc: Make FSL_IFC config visible and selectable
Date: Wed, 12 Jun 2024 10:26:14 +0200
Message-ID: <171818062457.17232.8716946182820856760.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530-fsl-ifc-config-v3-1-1fd2c3d233dd@geanix.com>
References: <20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com> <20240530-fsl-ifc-config-v3-1-1fd2c3d233dd@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 30 May 2024 16:46:36 +0200, Esben Haabendal wrote:
> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
> driver selects FSL_IFC automatically, we need the CONFIG_FSL_IFC option to
> be selectable for platforms using fsl_ifc with NOR flash.
> 
> 

Applied first patch only, because:
1. I did not get acks for the defconfigs,
2. I do not consider stable defconfig as a hard-bisectability requirment, thus
it can break within one release as long as next is not affected.

The last statement is kind of not true, because next is now affected, so,
Esben, I think you should resend the defconfigs to respective platform
maintainers. To recall: arm64 goes via your SoC subarch/platform maintainers,
not arm64 maintainers.

Applied, thanks!

[1/3] memory: fsl_ifc: Make FSL_IFC config visible and selectable
      https://git.kernel.org/krzk/linux-mem-ctrl/c/9ba0cae3cac07c21c583f9ff194f74043f90d29c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

