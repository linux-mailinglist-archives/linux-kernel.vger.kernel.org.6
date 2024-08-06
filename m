Return-Path: <linux-kernel+bounces-275714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7B9488F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98213B22EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE441BC9F0;
	Tue,  6 Aug 2024 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArZifdn9"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609B1B9B4E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 05:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922226; cv=none; b=soaCqEfnP+/Yk8H2wsV+SZzaJ3hWeON3/mbqeO2jzwZc2VavuWZTfx3j0N92XzBSRKkjZfesKKKX8kCsNswQ6yffUvxNkUbA242jLRKCbG8zV4Qpi2Q9NmYPx2WCTr0op0eZk96IUFf52IEmsyZ3/XhhsWpdGqTn4eaAjWoEMMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922226; c=relaxed/simple;
	bh=lsb6kbh6k72R3qIL5aRMx1yf9phwSqZ6jTpVRAmf60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLOeYKYLXtfeXk8VRARVe0g1SjjAkgtd9lK8fAcD+A6JB26U/RHZcQPyUS79kW5/06umWOiV0bdbwzDbw9xTfU0x+Cf266oulTms+PmED4Giw4X7AF1JqZyppkTmSEUB3RW9a+BMGMl9H3Vhul2Y9N4ianqmHyYkeL7did5y4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ArZifdn9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36ba3b06186so92742f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 22:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722922223; x=1723527023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPCVAIHeH9S7ZymysDPzhcgJG8KdopCxzMAed2EX/U4=;
        b=ArZifdn9b22o3OuuW/z63a43f82CmpfDcN0NOHoR5LF6NKDUy5kcIuDR1TPJoVeQsr
         42lHAvBByRhNoqKgjvgKewNR2n8gMdFVUsnbJT11n+m9uc6V63EtSCn3rAkQDdlteUVl
         n02zl3SuBypN+QS8LMTZoOjDFW9Rk7FPLFxZqiEMkbchki7d9Id/BUjFDJ1rcZ/LzQsu
         7W3E4ymSZCDuP9bQdZN0Z46HotQPHfPAQBke1mVudSsoKNshAEGrSZmFkWdA0L7OZ5UT
         Z0GsQDdTe34N+3qpytcXp3KPuUKlc7+0CqC9thXdfwoD4nLz6DLIZ/bM6SQWlxdiq/j5
         SdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722922223; x=1723527023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPCVAIHeH9S7ZymysDPzhcgJG8KdopCxzMAed2EX/U4=;
        b=XV/8engv987FD2Wpg51OE/UPhqRlCeDDKI7jd95NVWv1PRuqJ9L5Lh2U4B0t5cKSEM
         zDIem06tBJ2au+arzSVu35w58yNgDpEQo4ItsT51i6rQOIp/el0UHKQVRsypx88KuCiC
         +gyK+OuxeFHvnoD6r3wh/BAATA4gEY6O8tBbdXxUE7EsW1oGkSJILh1ZXDwv9w8biK4O
         SO2IUxFyWAHtGNMySjjormlVO6B1TSpASN7z9zMpX4ir83QdSfOsp13MiaXDG5+Ua/7k
         3iGPru45ao0/sG0ycgDWMxItJpHBVJmXM6iEDcyLqYdxOWPYKHrbnDtfZ9BrZ/yqeTmQ
         XaoA==
X-Forwarded-Encrypted: i=1; AJvYcCVhbtYq/uuSQOpTPp+9a3/4W7k8GGXnsNixeLEpshM6Sm0wqLSlE5UOxQqTk0JklAMl2KqxvtzytlGIXWyfEYLJshF9cCqxKS5H0LtB
X-Gm-Message-State: AOJu0Yz7w4fMfG4lxkt8qxD0HvgwvJZKsbL7o66qTACenqDqLYAO7sHz
	Rx14BwOmJzyP/47rRvnvhir5pV9eMzKUICZSX3EYpq8A+0SEyWs7DDTnNhhJYIo/sTWTD4DDA0N
	3
X-Google-Smtp-Source: AGHT+IFlbaZQ/fAx/6gzC6eXx57K1nLvOSyzyU5cUkM/2Lv1iisv8vdtktS+T7sHVnjYtvhEvfewFQ==
X-Received: by 2002:a5d:47a4:0:b0:368:35db:273c with SMTP id ffacd0b85a97d-36bbc0e435amr11296225f8f.18.1722922222155;
        Mon, 05 Aug 2024 22:30:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc8esm11685000f8f.19.2024.08.05.22.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 22:30:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Albrieux <jonathan.albrieux@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: iio: asahi-kasei,ak8975: drop incorrect AK09116 compatible
Date: Tue,  6 Aug 2024 07:30:16 +0200
Message-ID: <20240806053016.6401-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806053016.6401-1-krzysztof.kozlowski@linaro.org>
References: <20240806053016.6401-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All compatibles in this binding without prefixes were deprecated, so
adding a new deprecated one after some time is not allowed, because it
defies the core logic of deprecating things.

Drop the AK09916 vendorless compatible.

Fixes: 76e28aa97fa0 ("iio: magnetometer: ak8975: add AK09116 support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Offending commit did not even bother to Cc devicetree mailing list and
DT maintainers... Lovely. Let's ignore submitting patches and
maintainers just to sneak my important patch into the kernel.
---
 .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index 9790f75fc669..fe5145d3b73c 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -23,7 +23,6 @@ properties:
           - ak8963
           - ak09911
           - ak09912
-          - ak09916
         deprecated: true
 
   reg:
-- 
2.43.0


