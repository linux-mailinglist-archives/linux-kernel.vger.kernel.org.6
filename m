Return-Path: <linux-kernel+bounces-273907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38352946F74
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20311F219C7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C259147;
	Sun,  4 Aug 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2KSGKeH"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A43A29A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722783671; cv=none; b=k2KgkyP3fE3zn5nNYVfkSaqs2P5OcVNnsViBeTGvS+6XfVWnGOqTnRLghy+LGi6ZyReP9JVKRkQAU1pseQGBkeuDJPGA6FybcDf2sbmwXY+wIdhfoqN0YqNaXQyQGcd2LRnTJNGokZOQmn0Ed/3em448r+/MVnBDYi9Nd3ZJz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722783671; c=relaxed/simple;
	bh=CajBkE4wLrtMnRKOYpFG7Sh2NuylE8/OeJTwiS7Hdfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDQoQkIPaJHSHrPWBoSlHT9xUhi764Lz4cWtVJWFytiVL4L5wdKzWve5NWpViIv5opt5Z3utbwLFswcNCA7uV0z3xj5S68/aL/2ZvzS5SSz6QxgyO5x3dtqSsfwapnN63JtrZabEeJjkkF4K23CGoLRLPY0AGnSNGuEVNqRq0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C2KSGKeH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so8270984a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722783667; x=1723388467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEjWa4pkzcfMlCjLYLkJWGX9WM6UqKyJJKuJ1PAMiNg=;
        b=C2KSGKeHLw4GE6q6T6YzgXbRWfPd1I5z5W19+CFRkTKgPzzy1IhnPGuVTbiOE8kUUM
         G7e+dB9z+G+6xB0wA5Fo07RyjeWo7c59HnJEA6vzlOJjVnxklEh0FIxsx3YuFqmYKbjX
         owsXdUBr4rAXqo4W/PKxka02cmJq0F7z8UwdNcEe+Kxk5x4O1k5G86RRxtAksjARt7aV
         hoxNdK85O39DtVWNtHQReyBuDdwv8PLIpHMnhrxw3VZ1XUKcrXoNUlrfMoLth5ZQq2XY
         CcHUsXgvxCAx8LYncNainSCGZzsVfsOm5ExsQYBY54M2rQ1rRO5TeuXc3mtv8K2aP2t7
         Ey4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722783667; x=1723388467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEjWa4pkzcfMlCjLYLkJWGX9WM6UqKyJJKuJ1PAMiNg=;
        b=cs+6Mw7NvGnF5MgEanSirMY3nZuftaj5p+2a1dSPZZEL8PqYfJKSddnnMn1QQJCN7f
         sLjlau5AH3IVw0wfREpyyQxPd2yr00JEpsnNQHLEFdT3a1s4fsWIa5yF4uImL3KGx+AC
         NGTPjvNjQ/aQZ8z/e0dj3FAoVw9ZFzuk2wc8kwCltUCLtW//zPoo3EGQ7u+Mvyt1Egp6
         vFjYkNN5VQr3n+5JWYPGBQAttE0pljUwlQbihYPe1QkWstv501fm8VWlJrVUWG9ZDIda
         oVgzAuR6/RYB9wPsV/d/zF4ewYNZwasyfvzORdnLGFm1v5OA8V070IsAhqqY3liNOz2W
         +TJA==
X-Forwarded-Encrypted: i=1; AJvYcCVGmhfQoH+cF6uAIPotIhwCIMwX/G6P/vUWXj3h2nYB8H3ilRCiLqfUEdVhsWYTOLA4J0V/q1YGWT4VifShbbfIHgZUoeH56TLE3i+C
X-Gm-Message-State: AOJu0YyQfFSBklAD9AxEyxsPN3xnIMA1ea24DckcnXLS24gELEXLu707
	BtaDJtozbcv2ztH9ZNjFhKznVxR75UGtJjWCuwd4EH4JMN+rPv3Ce+164xmNvDE=
X-Google-Smtp-Source: AGHT+IFgQvjuEQMq5i8PxyVFOfHu5y8cX1lv6VnDLI0y40anOtcoAyMQrpAuVCM/qRgiuCYX9vZoyw==
X-Received: by 2002:a17:907:9406:b0:a7a:952b:95cf with SMTP id a640c23a62f3a-a7dbe66cc25mr826648966b.32.1722783667303;
        Sun, 04 Aug 2024 08:01:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3cbesm338973566b.5.2024.08.04.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 08:01:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add entry for Samsung Exynos850 SoC
Date: Sun,  4 Aug 2024 17:01:04 +0200
Message-ID: <172278365082.32845.11234581938403878166.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129204717.9091-1-semen.protsenko@linaro.org>
References: <20240129204717.9091-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 29 Jan 2024 14:47:17 -0600, Sam Protsenko wrote:
> Add maintainers entry for the Samsung Exynos850 SoC based platforms.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Add entry for Samsung Exynos850 SoC
      https://git.kernel.org/krzk/linux/c/265e472e12da17af754f584b6a2f11cedb94fe49

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

