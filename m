Return-Path: <linux-kernel+bounces-427654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B3F9E0466
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7651D1689E3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E062040BC;
	Mon,  2 Dec 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Il36N5Xd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0FB2040BA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148138; cv=none; b=rOsExau/CXScda8wIOdK3TnEMfTO88p2uALtWCYzwr5yd7aYW3CmMB3KfC1oSkkOF7gLp9LotYhMUa+z1NO1yWDwGS0OhcQgCQAZthp9vOVN5Aoieudr6YD4oB33CyvmK9VBWtij1TOxuDlgC6DtIbDKqYullBjfLgKaXV3RuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148138; c=relaxed/simple;
	bh=xEY/MYEzww5v0mEutJbZHHy0DYJ5xp3n5zeADP54oQM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=smk80Og+FWm5SHa4pcqQD7VgylUteb5DMJGiUQqhlxqpiglbG6+hkZIBOAPDfbnmUsfZ1lQxoMCJZyj7FT6tc9SIEW+ADesakVRgH6HQHywKymYWz4/FKe5gUtP8AlplZe8yJ7fRpvIRgE+YZV/nWe6rTThP88lTo2vHcoRFHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Il36N5Xd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434941aac88so3603955e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733148135; x=1733752935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFdTL5VEPeunnOwNpwyKpiYpCh3mlklnlXFkbGWKFNQ=;
        b=Il36N5XdHOijTPmyx0W4A+hb9woYKhF7acX1cEwefc1A0tcVqnQGodbUqy9m6K+5yu
         kkNIxMy/zjGi598u8K9lGyKEaR3raSjwcnccA8ctpoHUcCILqlm1LL6lFwbCAsozTJk/
         xcKnEuAi0+5S6dAg1bJhMLFDiFMW4A76QMsmHrD1tFaU4jCljMZwdR90mrFxVVDSLRag
         zJo4fXImBDclVoGlw++fRvE/xdRoQnjlbyjp1SZFwhd9GOiVybdtmjsYYsQQHh1d1vs7
         KATzl7crdPgDrkJN28ielGb+NlbdG1LEmpOGCPqUch4eEVGQTzPS9n3tTUje6vaTxgK8
         dQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148135; x=1733752935;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFdTL5VEPeunnOwNpwyKpiYpCh3mlklnlXFkbGWKFNQ=;
        b=IOXqT8LwuB5Q+oNwqwCHaKCMHhTUUpr3+jZXc/NkWvtRqlrzlKz3p5lC5Z71CmGsdM
         8p9zMPBC6gEHZk/qeROW+uRDgjRCpMDNGjp35IOf+tm2rY+PMRwzxdpBbRr3UO4wOr9b
         a7u+1dlrQKxwz39pR1Q+IYSNBcFoXuyuhLa/S84M12WOxS1Ie2tQjY0iz5Gk9jTWZTio
         J43Qb4+Tp9PJ2qyiR7K2vof5U5AqRXZQFMmI8XIC1k8lmUJOYWd4EwC94Za2FjmR4/zD
         LMs5KDJ+lMLxHc1RKxfAvGdYZ6cx+9tJ9voq7FOz+IVLgVJbzCZIv4+A368+o+wWCQdN
         A3bw==
X-Forwarded-Encrypted: i=1; AJvYcCW31bXVEPlk5Ng6e+qPyaIBPykVJJug3haEQ8b1D4UFNO/ABgVt6TIlDWviDtOpYEv9yOStbhxloxcIAyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp71Z/RXtyRwnpqzQrctMxUUwb6O1vdQDsFGCeKmLmooLR6jjW
	Hr//35JTqhOOVl7iJ5eIXGBS9Fib75hv6xQlk/EbGWPrfw79B05rUHUn5MxtMps=
X-Gm-Gg: ASbGncuBiGLi1zMepwuEH2HyVgQJaMoWvi8AarF7TSiaaQU2PrpzLl8z+0+lwBbktm2
	uTC5dEe15r46gif6YdBv44hFACR9is3pvjE4S95GcTtFdRRsOvIi/2J9Y2zdpOFrrTdkXDP3WhI
	jspEjjGChCzB3SKhqz3qcrpKijU1hwGiuBybd/NPcyaeUyTjjgGDKbLSrV+T/KUwGGy1uAZTEst
	gAWjq5djNi+K+uZl8ZJJKnIFJD8wAYbzByiVGTR1KQ0+AOLeELCAODWCUSFvkw4
X-Google-Smtp-Source: AGHT+IGxwUtz2qX6sl87AP1MAktuEdNdgWw/JHxE62KrZvo42zm/39LbfbWZORwukdi9PptFej8bKQ==
X-Received: by 2002:a05:600c:1d1e:b0:42c:aeee:da86 with SMTP id 5b1f17b1804b1-434a9e1ce8emr81193255e9.8.1733148133134;
        Mon, 02 Dec 2024 06:02:13 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7691b0sm184502815e9.17.2024.12.02.06.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:02:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sota4Ever <wachiturroxd150@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241114143636.374-1-wachiturroxd150@gmail.com>
References: <20241114143636.374-1-wachiturroxd150@gmail.com>
Subject: Re: [PATCH v3 0/2] Add support for Samsung Galaxy S20 FE
 (SM-G780F/r8s) [SoC Exynos990]
Message-Id: <173314813121.47662.7729149107568659652.b4-ty@linaro.org>
Date: Mon, 02 Dec 2024 15:02:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 14 Nov 2024 14:36:34 +0000, Sota4Ever wrote:
> From: Denzeel Oliva <wachiturroxd150@gmail.com>
> 
> Hello :),
> 
> I'm a newbie and I started getting interested 1 year ago.
> Well, that's the beginning,
> until I learn more about kernels and the C language,
> which is important in that.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: samsung: Add compatible for Samsung Galaxy S20 FE (SM-G780F)
      https://git.kernel.org/krzk/linux/c/9163693d368f00c02fb8a07beabe2c2f18fe0a32
[2/2] arm64: dts: Add initial support for Samsung Galaxy S20 FE (r8s)
      https://git.kernel.org/krzk/linux/c/706119fbbdff2f95a62d1665fb4234ebe4e9392c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


