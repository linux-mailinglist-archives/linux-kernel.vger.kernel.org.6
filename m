Return-Path: <linux-kernel+bounces-340459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2819873B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E382282410
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62C62595;
	Thu, 26 Sep 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jmXU9Xu1"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73A611E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354390; cv=none; b=SrMfPbnbD6vsUBJrR3U2TTJmdRnPQ7CIRCs8l+GtO7aKpqAsQv4ml3+5yyBnl+7pTahoZfOIXgyWhxtbEJAkaBpjPj97aqT4jYVXpX5jYHUJ9JN3JbNtgY6U7rvdnoHssIUkPsmFz2+2GHVpOP90K5oQG4RwgnV/4upxO+Q/Me4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354390; c=relaxed/simple;
	bh=skLMy7f7c37t0z3nWcLfrDGCEYVCt+S0rBEfQwg9Em0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=akJkBWpW+L+6ZXFhQ5GozL6dq/VHrWbHffkW7O5YlznvRr91tlsjNxMjKrRBKXl6t5nahcPO3CB2Z9GVQGh0u6otpr15nM+7UVMZR/KjgdvOUKCm0lDAGXvlun+/xEkg0xTDx84SKsaMFz2diBioB5w7QQQEEc/NGFn4RFGVz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jmXU9Xu1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb806623eso7902355e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727354386; x=1727959186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQzQys66bp2Ld4WzPHqpjCSslimeJbMa4EBqGsAQRVw=;
        b=jmXU9Xu1r/c92Y7is6oX9gV7Sk5UzQAGEo799ExfxBFK+bzXJuxhRi5H5h1xEZLtKY
         14sMsOFdneEYEfNuvZBH5hz99WU2aRbwd79JEVHv+noNmWzOc63cz/smcvNJJptj6qBP
         42cZ3SSON26syfi3xrSIzOwWrW4M52GDv1RMXilcRq+s3IVbUNcoTOgqPp/Ii08OYTKR
         zR1k598xESUjmtE2N0nXCFNyZWKcWtHCloYQ2gE+eQuHt386eYkD77NdiWPv8iztuR95
         D0lPFXZ5DcLs29mso6McY3E6AYzT2C3ntTa5rjo3BhH3jegEYg0lc5OweJdow5gL2+4O
         rMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354386; x=1727959186;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQzQys66bp2Ld4WzPHqpjCSslimeJbMa4EBqGsAQRVw=;
        b=ryFbeklcyfBlxcARkHsvTGTSCfgsAa0rp5kTm0Z7UJug2MdZPQ+pWkOcX6YkdGx+3C
         smSTBPoLdSdej4QY/JJWWFGSOyd6YbNQmCcFRlGCcC+rR3GOkX8pX8UxWis9xbgLpla/
         vKMtpX1GKa46D44eku6L/Cj0GXzBavlVZCH+dT++9hKlkor1DICshO4f2YwMpwuqMe+I
         mdCdJj8AB7kN203fbTA3dHEi4VraxJaARKLMzI5KHLV81pOLclUm+PETpde77uI/hW7D
         W98pQv7jAQHwXdFFVzGqZKC7IehDFhT39zYC7urBz5szGmhyq8hQVOR+UFVGOFsI8wyQ
         y7+A==
X-Forwarded-Encrypted: i=1; AJvYcCVxul8EaWRDhxfHwVhy0+3WZqKdnEyF6Q3hwzd4C00TN8KhdtPZccZj4tW3/fR/TQ0Z3PSx9bEUxW2NVa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8R8QJ9yYteGum28F6jcRlHmgHh5Wo1RY0bmR2TV2ghT74RlBW
	wkfpIyvWWRek7dwU4jJQce08VVfdA1hpVfeyuYcUWnBXX4+RI5Gk/pVwLZrEuB0=
X-Google-Smtp-Source: AGHT+IF2ktbSn3Aj00xQyiv3ldfTlz4uwMS6dZVkDgJF576LsJ1mascH418BisllGC9fT21zJh/9dQ==
X-Received: by 2002:a05:600c:1d17:b0:42c:b309:8d18 with SMTP id 5b1f17b1804b1-42f50d550e3mr31033565e9.19.1727354385700;
        Thu, 26 Sep 2024 05:39:45 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:4a84:8f2f:8bdb:87])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e96a0d8eesm47177135e9.30.2024.09.26.05.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:39:44 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240925-clk-meson8b-spinlock-v1-1-50b7f2d02d7d@baylibre.com>
References: <20240925-clk-meson8b-spinlock-v1-1-50b7f2d02d7d@baylibre.com>
Subject: Re: [PATCH] clk: meson: meson8b: remove spinlock
Message-Id: <172735438430.200072.15149649780547409113.b4-ty@baylibre.com>
Date: Thu, 26 Sep 2024 14:39:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Applied to clk-meson (clk-meson-next), thanks!

[1/1] clk: meson: meson8b: remove spinlock
      https://github.com/BayLibre/clk-meson/commit/e736da1956cf

Best regards,
--
Jerome


