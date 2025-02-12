Return-Path: <linux-kernel+bounces-511855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB070A3309B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9DA3A62BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C902B200BA1;
	Wed, 12 Feb 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXUfPL4W"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B51FF7C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391459; cv=none; b=PzAqoKEboj3kTxBgcPn4xXKS7WpXp5vJ9gXapsm89QYLZSAyIcDUKTMP3LaFft5Uxia3KiKxZpgF+8/kJqoI4Z3O7qzMwp85X6Z7SpIirr57wre3uN78nKE/sYJbJ+N15nks7g63xL10afoHQ4RWx8YiDEVUeZawNO3MEb/qpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391459; c=relaxed/simple;
	bh=5UoI9R/vnHMC/e5ewh7O59UF8eSXn33Jwv18AA32wMo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bS3OwJYd62eqJcdFCH3Nf54PAS9Sx1iArN99g2uVznokeSwQqpadetLjQv5i9V+Hye1RZ0EMmeoKc5jvlhT06HYNMvV3BSaOG9jtThBf86x5GsBsqsW1y6EfqW5NysVR/QUvbeUU/CiW/1OPV//GCH2HCgoBXr7twy8sIsGboqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXUfPL4W; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f20fc478dso15986f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391456; x=1739996256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbCZq/KdfJ+rz1uUl+K724BtkWwa151wsTK5+/vxmtI=;
        b=yXUfPL4WImdCKVd1sHNMY2dY3MDlgeG+hEfGI+q9GW3hrf32Yn6xSt+cqF+sfRPtOu
         xvqS+9SQB8vfSuMfmAsbdJvcLq3zHsZISLpad2WnxCzvjeVQhM3CoJJW+SOK+YrDkLBE
         yCa0xGDQe6OJRDtI8DKjPBZuwQsE319eG+a3Tn674BIYMyx/J/Cexsx8K56p4bixe8Ck
         H7aPoWgBkKtrFUZ3lk9fvHNck0lV84R6RCqmicjwLGXDrWIV7eu+EokWy7IqhYVrHOY+
         HqCk+EZ6V/wEGaHsX5wJWIoVCNK+UxCLfwQuoFowGkAL26anvLaR7CeyVZUkZhtR9lY7
         wXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391456; x=1739996256;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbCZq/KdfJ+rz1uUl+K724BtkWwa151wsTK5+/vxmtI=;
        b=IYohyvG90pXWes49n/iKIBqplL29sucxsmKpiYDytKuLx1LU1jiuil1tVQXICN687f
         BdoFxC8r7K9y1Qp96jsmgQt27n3gTXOhddqangj3f8B7DK9NFzHK4ENYCKYqS6tjA6Gy
         GVHrpJ7VTP4UAcJxjUHJ2B8npgWtwi+RsXtm6NeGLIFI7bXUiz5x9B0a5Va7KL8a4H0V
         mriP98Kh/58M1bHkm3BHvs2yPL0RBgLPBC05Ck3VMMmRo5DekM6Zq5uqDWikIPNXXphp
         snhmrkJn/5XRNx8oirYMzgj4l8p2kc4dlsHdbUys48+Ce4eLSg6AhIocaem3zUkWkih0
         sqfw==
X-Forwarded-Encrypted: i=1; AJvYcCXH8phrmUMA15QNosH3EiR9hrZ5XnRzLHCO+U6QDUTFxQF9lw62EUoeW4WdzSC9P9RNXnwz+xiMNj9n7Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGZ919Axp5JjGNBpq5Y63DfbU5Tgu/tc8PwwbsCRMLmPULnkg
	CLEycD0G7gnaHpSqvbhUYlx/cArM0yesp3E/s4D+eV+prU57BkWfU0FRiw08y3w=
X-Gm-Gg: ASbGncu45noCl9gLtrWG/A3qsjHsLQVv3mzEPSaAJ81jYgWTmiKomX26jL9R7ju1DrS
	fJfxlCbUV+Y4wEX7/ipnA438LMELb0U+AKIWftHrwXcr52Cib21AqQI+6sd9dIpYZ8O+/iRugoz
	9u35YILdSpy2afGX0HP+RRuSARnlprjRFYZCFbVWyi/idt8XBdjrkldGnnZwouSpNYffFX4GMaf
	tKH2YQtVJaiNAYxfVdSfqFQ0sfy8h1uN56vr4k3gY4DYmEeXefHO7mPoupOppG4hrid1cCA24to
	RoCcEfIqfd5lcaxNmi9MD4odbcTjU6g=
X-Google-Smtp-Source: AGHT+IHEzgbSwZhcHl5Unf6X40IETyxliC9eFPUo1deP0nfYqwIuq7PnG2+W9zZlMsgMg2uyJ/GJjg==
X-Received: by 2002:a05:6000:4184:b0:38d:eb4b:f9aa with SMTP id ffacd0b85a97d-38deb4bfccemr1276223f8f.5.1739391455757;
        Wed, 12 Feb 2025 12:17:35 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38e6ccc8c1dsm2386845f8f.101.2025.02.12.12.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:17:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241222145257.31451-1-krzysztof.kozlowski@linaro.org>
References: <20241222145257.31451-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos8895: Rename PMU nodes to fixup
 sorting
Message-Id: <173939145421.15132.11778260219053817821.b4-ty@linaro.org>
Date: Wed, 12 Feb 2025 21:17:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 22 Dec 2024 15:52:57 +0100, Krzysztof Kozlowski wrote:
> Nodes should be sorted by name but it is also nice to have same class of
> devices together, so rename both PMU nodes (A53 and M2) to use "pmu"
> prefix, instead of suffix.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos8895: Rename PMU nodes to fixup sorting
      https://git.kernel.org/krzk/linux/c/ee24a95b891a215b5fbd2f6814754301070653c0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


