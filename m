Return-Path: <linux-kernel+bounces-525521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04EA3F0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACE019C0EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174DB207E1C;
	Fri, 21 Feb 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sktPy6l0"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C292045B9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130919; cv=none; b=g5Sdd0MUewX6p7jtQIkDx0YJbyc60cG03cc0B7IOzRXqjs1BCOZNE7HNzEap3iSaUiVjINQdOSTUDqg09y7mcn+IZS/DdW7fFn98C6OhQ8nAH3/nBPmvUYSMRF5YOcp+C8aWFkzJ+sg7vXgRsBnX4zRBRDu03H2F6KDQ2wbWLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130919; c=relaxed/simple;
	bh=IKR/9VGhkFlJ1I5hTuDF78Fb+ATo1J45kT4X3heZ8gs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MeriZOzr/STYQPNFfntNDL7XmyJjcRkFhOMqaUmteOaJAz/NWRN4eRhK7/zR1pTL0WS3F4xbb56LV/FyOY4huUXJ/4m0DH0Lo2KrJeU61bU52khqc7di2Q51gsnCB0H8TxYkponyMmnvqe3LXvuKDSJI3X1yDfKjfOTyJn98oHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sktPy6l0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ded7cb613eso325094a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740130916; x=1740735716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdXYR/I62+aZcxW37aH9KmdUU3jeSFhaY6J6vyoXK9Q=;
        b=sktPy6l0ghLaloebH3iJRPfolp5lpZWD7oWeG5/ZeYcIMJmoqwJpwQhyG2KLzNHw4f
         R9+U1pKHOhmXHb8g1okQ1UIwiq55Lfw53P2qHqflLhvcAq5KH3b+TmeBNg2HAHFUfHXe
         U+FtlolvhldLC2sMySbv0aZybiC/n/9nVIUn36yOnbHPWHLyZEvvuZI7jm1u2RC3oQcL
         m1BuuMOb/3Y8TPN8zj9Vb3K90lUqXgL6Gv0t9026M7pFPFEdBzd0freII3az3dWx1vc3
         7gudrR+8sJGlQk580BV3BsovdHc2Q8iTdBevhetclD8a0mT7ADmR2R3zHhVV3zhOXI/K
         HRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130916; x=1740735716;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdXYR/I62+aZcxW37aH9KmdUU3jeSFhaY6J6vyoXK9Q=;
        b=TfxcsgvKEd5riYN+k5otJ39Mzm91Jlrcz0swdyh/aw4BHri0M5EbnCCk6CpWEah2rG
         Fw4ku1VDVe2im3Sawfxua6iW7qrAzMcLM3c+O2+p0dJGAHmgKR0yIKsRkd1ocWrG8tG3
         S76S9DWB+XsXer8lASKoiolkhPMil7i6Fi+1SD4HW/DY31vfe0pagP2+WANIS+dQ2cbP
         6McWI79X7x4JrCSnIUCKKjrJCAu1wSJ3vFEM7FTyJgdOYrVjzHB+xoU3LzSYLdh6m3z9
         DKPls9aecPo3Dm4hNytPebC50tV5lRdI13m16RyrYDPsR0lMjIApB5VCd0SV8tHQdGVO
         wP2g==
X-Forwarded-Encrypted: i=1; AJvYcCVv2c3Md0oOu3ppHNZaBUwuRGtf9BPVwT1y9iRIH+PHMa9FhRSjjljYQpst6loTb9nn/XAxdNnMHxLh4bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Yv/IKf9r3HquyC4serFjFIggBq/p7H2RAKgToU+nEHUIrP/W
	GZ5h28hy8oblpmiiywAZUMVSkPgflWWsWi97mEQy3sWEFqeiYEtn0IyphD+S8pM=
X-Gm-Gg: ASbGncsalXoAGjXUpdhphTosv1VB0/wKTFBd01vb5K+tjYkplAcKQ02Km8o/Uvt/Sk1
	nbIe/5ZKFcrcEnZMKlMNDQhISWi0NFQEJRnr22So+WHWIG0RJyFPQh6GodNuQ+UqL15dDuQ8guk
	fOtu1U7Oudt+FujiEp9mcmKfUvd9uulR1Rm0/POd20KQYWL48xp/+ExvHDjdCRel8bE1gKZA7Ge
	4IKHAZh/ZaXwT7cSfGs8juaG7911sVHQuVnrAhexOxi5qc1+sygeAqT1cAjzNl3cwBxnnxuZDm/
	S+IB9gPQLkVLWxpxIRt7Njh5Pq5FwX/wVB/uwFZLSAe7zdou4xspF9bk5L4430DjKnkAykD8TE8
	u
X-Google-Smtp-Source: AGHT+IFL/lM+F0ktUjddFj5OzpJ2DJG7fI8Z19V6vvQBBy7jA2Fb4GY7EiIh5I5iCTTx716z+h+jMQ==
X-Received: by 2002:a05:6402:34c6:b0:5e0:8275:e9dc with SMTP id 4fb4d7f45d1cf-5e0b70bc3c3mr703304a12.1.1740130915955;
        Fri, 21 Feb 2025 01:41:55 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323226asm1617470366b.8.2025.02.21.01.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:41:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250219-exynos7870-v3-1-e384fb610cad@disroot.org>
References: <20250219-exynos7870-v3-0-e384fb610cad@disroot.org>
 <20250219-exynos7870-v3-1-e384fb610cad@disroot.org>
Subject: Re: (subset) [PATCH v3 1/7] dt-bindings: hwinfo:
 samsung,exynos-chipid: add exynos7870-chipid compatible
Message-Id: <174013091442.25434.11831404613747395475.b4-ty@linaro.org>
Date: Fri, 21 Feb 2025 10:41:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 19 Feb 2025 00:33:11 +0530, Kaustabh Chakraborty wrote:
> Document the compatible string "samsung,exynos7870-chipid". The
> registers are entirely compatible with "samsung,exynos4210-chipid".
> 
> 

Applied, thanks!

[1/7] dt-bindings: hwinfo: samsung,exynos-chipid: add exynos7870-chipid compatible
      https://git.kernel.org/krzk/linux/c/0a86ea5534a9e4ae988a2e174e741b102d8a8691

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


