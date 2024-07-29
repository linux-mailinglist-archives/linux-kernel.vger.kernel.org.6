Return-Path: <linux-kernel+bounces-265740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33F93F56D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002701F22B56
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D5D145B06;
	Mon, 29 Jul 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xx2+iyqK"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA933CC4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256275; cv=none; b=eEEyXhEvfMyexX7i5HQrY6at6SfUkXETT+PmVV9kFO5lev+Tg1fjMyoNJvjEACnhL4AYWMhOtH6Gli3Tta32KEuTLjDTtPqnOILA9ai6aEBsJs/sG74TCPVMcBcY8NclI0os2F5qAwMr5hS4nIpgoQ/I+26Jv+EDW7GNlnfPKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256275; c=relaxed/simple;
	bh=DNhanqTWJd/OkgCTvbBYdOC5y5bwxHTguZCfFa1RUyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T5g6P1zJzS5DqcUe+hLHwyPamUIKzfDlKXH9IY5G/EvUZ87n+kpEDmh/HrwZI/wTvX7f8JtsIw04OWCxACym+tJkPWC/xnr/v+iCx44h7TmJAZz4JVTva4MU29yd43bajeKg1e0odq/Id+QlnLhYXjvF7z4pTxwoxCf6cPrERbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xx2+iyqK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so7593251e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722256272; x=1722861072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7hmd3mWm1gQNax1rdnBwm9X3nvRpjYNFyOf3EAYVg8=;
        b=Xx2+iyqK2xILW5rbylj88DdGnDjEPkDH+GfKyPJl4dz359q+EUq4MihYUQQ14EkytO
         hVHNdZk4bPDRfMAeRccC1KWZu70IfX1gTaUDAtAI5/4krI4reRk2R52Eva/2R7hQz7RI
         QbfG9Y5XK0fqiaQu+U5eGXu7WJwBkmh8S1rVvxurWwOl2aWWuAZwVyw5rC3bTGap9hFP
         Q7LWHzxwjd/18vb9++74fFlNqm1swXhp8r7+io8UhyZXOgII3h0O31RNi8Bi8LHnM3YB
         K0yteUmWUUzWqD4zAttuaPkv8NguKKsLPkxQaL1NtQnI/cHhaZtc89T3l6ZK5ZRco/ui
         w00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256272; x=1722861072;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7hmd3mWm1gQNax1rdnBwm9X3nvRpjYNFyOf3EAYVg8=;
        b=uSDP9xcjZRVjJ2lF+KHLavkgnsol3sJHaFgjk53Uu5Q24POySEE2y9B7RagRJMiiCt
         xnUYxIY19T75TzXuTN0jqL9WHz4sBGO4hDbTs1/SQXJRfH7Dbutaybew1/8ayYIv6LMP
         hlb906tIxD4j4ux4L4O8Y9y1If54++H5mDqC2x5GHvxaf7Z2C2wYnV2Rv4Xu2KR5d4IO
         8sBultle3i2BxsADetbUew5GYrdJq/NB7UdxvoRaja8HCcVLUNv84g5L6DSwt8iFj50S
         ZoGRror7kp6mAb38TqynLDtbKqRbFiCcGAyfNhj9YGojyOLmOtche9KVkkKBfinCooTz
         3P5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3joxe3lMrk2qgXVvvq9R7/5v1+nJDflf28+qgRKqawEziOsCh+UaU2II3STtmOw/k5Q9UjFctoyRUn4FM4iqtNMDYvsV+Jb5/L5LW
X-Gm-Message-State: AOJu0YxdwIxiCaR3W37fYFrZeqRF5qD8bUUm4gkdmuI29zvwvbAPH24a
	D9e4CtGibVvsPZNhdcIt2B6L1M2wdwPRfrbsR6lOtVC4TdPao7QxR/lcWL5MSxM=
X-Google-Smtp-Source: AGHT+IHmZcVRj+OQubC+Y9JLE+mJvdVS0zZVFUn2gdyL1G0hR405kWsdn6atd1FZXPPAZ9g+dW56PA==
X-Received: by 2002:ac2:4f07:0:b0:52c:df55:e110 with SMTP id 2adb3069b0e04-5309b26928bmr7668841e87.12.1722256271901;
        Mon, 29 Jul 2024 05:31:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab22ff1sm501973966b.35.2024.07.29.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:31:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: David Virag <virag.david003@gmail.com>
Cc: phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240713180607.147942-3-virag.david003@gmail.com>
References: <20240713180607.147942-3-virag.david003@gmail.com>
Subject: Re: [PATCH] arm64: dts: exynos: exynos7885-jackpotlte: Correct RAM
 amount to 4GB
Message-Id: <172225627029.280610.17022654796794760064.b4-ty@linaro.org>
Date: Mon, 29 Jul 2024 14:31:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sat, 13 Jul 2024 19:58:32 +0200, David Virag wrote:
> All known jackpotlte variants have 4GB of RAM, let's use it all.
> RAM was set to 3GB from a mistake in the vendor provided DTS file.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: exynos7885-jackpotlte: Correct RAM amount to 4GB
      https://git.kernel.org/krzk/linux/c/d281814b8f7a710a75258da883fb0dfe1329c031

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


