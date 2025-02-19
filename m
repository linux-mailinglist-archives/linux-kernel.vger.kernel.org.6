Return-Path: <linux-kernel+bounces-521374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42EA3BC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47B63AC878
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D294C1DED4A;
	Wed, 19 Feb 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdfkQV3I"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C61A840D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963323; cv=none; b=kqOO6GH7j0lZx+f8dwkt74CutPvcV9gr0g+h5+3lw69Ag+WmJKNxX7HU2d2zoMpvLsktOgVYyN0JQkgcQ1bM53TdKx6HyvKjYkPkyfvVOrloLyUCL+zIpdsQCigquv7UXfTN4DKmtf/0r7OpIoUldhuX4vrnhxPU2qtmybWGbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963323; c=relaxed/simple;
	bh=d3hwHJnXhEL3U4lpXF9O3OIISXIqjdYjDDjV0op+bOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U4AIm2cQ7EOLrMNmylcVXfTq2CtWHOprFuJdpESoJDJwVpj3ctkuLwqAN9aezH129yvnyoN981zffDesXDh/O9D3p7DsZz1rs4lxr09ZVKp36YCXLdD7KxDHiw37sezdu1kdWJpkb5VKJGMi3hRT2VMlx5M/LeEMlwg1DItVJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LdfkQV3I; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dbf65c0c4fso1179065a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739963320; x=1740568120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WCJJBquXtU0xuWId0qAETv4tq4g6KwlnFXnMWiiOMA=;
        b=LdfkQV3I9uFlaiHeZYjrm+4Wz9+psWWBUln9N+WPNAZVWJl1kO0akRrXF9pkH3xaKz
         OSZbh63rO0PJUedgkL1UPmzYVzfxhS/ske8ofY5paug09iduLdNg65X9AKeGMuzzUrR/
         S3YiOda4SUfD0Etj0C3IG0baJQTCz0Nd5QgwKH8ZB8BPbn6DhSVCCQMHkoqIaakEJ6r5
         P+luwxzvp3q0LZZvZgkcMB15MI58CiT4bdxBeyrOH/RikWZ4nTdOzC9qdyI0vjsd2TlT
         4nwtSaXZCH+CCb8ErAoWU/o7hMAzROzZ/v8CzSBe50go2Pt+PinqzTfDp0PYJ3VXY0v4
         BHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739963320; x=1740568120;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WCJJBquXtU0xuWId0qAETv4tq4g6KwlnFXnMWiiOMA=;
        b=O4fdaYuNQ/LZU/+n4gWoYYl0+EOrQU3MUIzpl4uHYRQZWab17q7HmW2qV/bi8S5/Aa
         lotYUkBPc0xtT6xYbPUAQa7Zq+/U1D+cO+aOQOglbBg/XSJdnMoNkPwsOkVN34xaI55t
         JufvxeFgswStTmX9ndym+JFYqtwzB9oCj5DUZ0fGxzEjp5jsF7VT4Hhm31gycQloceiU
         BOT13ZMcJ+irvCHv2HOAGjAj69VRDSqw+Wj+Su0cYGhxleo5uE861ovKvVhuy/Tr8a93
         xrPxwTVysAaLheH1ysfDu+CwqpBD+rYggTl5nEzoMN8wFrZjLdhNebDmScBML7AuGCFq
         cEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhrD0uW3WRiTne0OkKKdyZYC4DWLefPUFEzdBKrkGVPz+YBCtgFQ466xC8eBLliP7eNNGcpDRyw3NCoI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ky/k1xlCosFpU01El5LD7scSmkLnQxMmgOPS5e1K4lBp8oCx
	CYjQeCcdDpRg2kFUHUAdyApl8zlC7LZkIYk5gy65MBM1OXx7HqNuday92o4AaT0=
X-Gm-Gg: ASbGnct8qRB126n/aLT5TJv0j55Mr8dylfpwgK9p4Ak3bGp3ucRR2MYd1rCOQf5Y4jg
	IJVquEOMBieW0r+BGhF+dQxhXB7hKD4j65DevMIet9tcxAIMNlIwahdqv5cg5L2NcL1rRl/Gswp
	aFo7E7hs+oXg/IqBHF2cojjT8gNmEfG2aWAlxTPVwCA9Y6G/y83wivaU7GCJ6aav76Npp6DyBFF
	ai/HK1TJgWkCyUJG8OEX0mIuZnHO3XGAj8izG9+PBh8AaSwP8zY/ySjYyuS5/t7BA9/57xYLP94
	2gLWoVe/8T9WmlbVb+jGr8gSvbAfzqE=
X-Google-Smtp-Source: AGHT+IEfgYfUdIbS9nfRVc6N/GSxlxs4zzk9e7TbLbd8Y1WZWb4NpfyhDpkjxjKwSOnEvxlwN1WD4Q==
X-Received: by 2002:a05:6402:2356:b0:5dc:d9c7:a61f with SMTP id 4fb4d7f45d1cf-5e036169cbfmr6699580a12.7.1739963319786;
        Wed, 19 Feb 2025 03:08:39 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e8dsm10158156a12.14.2025.02.19.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:08:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250215112716.159110-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250215112716.159110-1-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: [PATCH v1 0/4] dt-bindings: soc: samsung: sysreg, pmu, chipid
 for 2200
Message-Id: <173996331626.137285.15610592693231757243.b4-ty@linaro.org>
Date: Wed, 19 Feb 2025 12:08:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 15 Feb 2025 13:27:12 +0200, Ivaylo Ivanov wrote:
> Hey folks,
> 
> This patchset adds support for chipid of Exynos 2200, as well as
> documents sysreg, pmu and chipid compatibles for that SoC.
> 
> Best regards,
> Ivaylo
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: soc: samsung: exynos-sysreg: add sysreg compatibles for exynos2200
      https://git.kernel.org/krzk/linux/c/cd6381a6ed69747fbe1f8ddb926b00786027894a
[2/4] dt-bindings: soc: samsung: exynos-pmu: add exynos2200 compatible
      https://git.kernel.org/krzk/linux/c/801a116bb82431446cedf942842561348a2c67e6
[3/4] dt-bindings: hwinfo: samsung,exynos-chipid: add exynos2200 compatible
      https://git.kernel.org/krzk/linux/c/28e113a133b5033b47ffaadfc3e96994e6c5e132
[4/4] soc: samsung: exynos-chipid: add exynos2200 SoC support
      https://git.kernel.org/krzk/linux/c/c86e967e6ba73ec6ac2a189073e0f7b0f1313788

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


