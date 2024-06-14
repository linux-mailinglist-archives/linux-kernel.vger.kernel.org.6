Return-Path: <linux-kernel+bounces-214590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6275B9086DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC8E1F246C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B71922C7;
	Fri, 14 Jun 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sIE1IM6w"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C349191496
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355521; cv=none; b=icAoXeBP6SZcWcM0xQ3up8y2kOUvjil6rFF1uRlk4ww8aitYS4x8fArQk3qybYnDICQE2LXyLwrSuJf//LBechqS3jb2LsiN3TFDC8wIvix5JyMkdPh8E3KpDFiwrgpkYNTwbqVKJUgjvJPKyj8psVYIfcpmccExnbRjGmxLYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355521; c=relaxed/simple;
	bh=URmpVX+h4mlfzvCudxDs8P7msnxwTQi7z+C/vPARdO8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NtuxalHQNz33toaZc9UAaZSL/NMpPSJ8/d76pbOpjQE9VlvzTWDLjlP34btySLZddLNYccn0n10UZSuSV6mEHAN2R638NjWPlmVTO7bQNltPp0XBTMrsJwfq3ksyjUoqWsyc06uyOwM1qbvruspwdoo/Hsz1UYSv/YfSp3plzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sIE1IM6w; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36084187525so248676f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718355517; x=1718960317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdYyUMalkTDxkfe8DhCeZo415hoYlYCOiWfh55zkm74=;
        b=sIE1IM6wTzZbA2n/M7MHfRak/+tL9UJaabvQeKyDTWBONyx+oj60Un9OKIiS2Twpt6
         /8c+CdxpM/AN+yqiy1/3TUOgTDw1N1/Dj7L83N+P+8EuggPykpkdBQqAH5DgTzptAZKO
         1dpE/nhmCOR6Bf1neJAq4vLWd7hcsPI+OZw6Pbb8Ia42nDWRJCVq5iaCV1MI+nlY5+mu
         DJgs3mW5oahyS0CslTb9Pondj6kQ0IBysLgrjqrLpPZWYt1Xny0m26en7h62ZpvQtHG7
         TrYMu/NGfHZR8yORh2gvWQkIGz53+PpWqvHKiT1ALn7IeLcfKA0LZOG6roS8p2sAaH2n
         Edqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718355517; x=1718960317;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdYyUMalkTDxkfe8DhCeZo415hoYlYCOiWfh55zkm74=;
        b=B6z0CmUOSZhrny8mAEcLFUpc1RhOBaH0EO623KbOEmZu221rKPa5I7TQuq2XEkVRWx
         9Kka3NarDZ/UtqcIla2Ys3LALM2Acuaf9qCds6/Svlloq+tZxDZtWJdKJP91t1yeKRoy
         FDUSNHptTlR+OsM6nuqI/LHKlo1ay/TYm5D9kDixUQ5MackBZDnxnBj3us8LgeG7Mw/d
         dKHKBVgjBJ/2LWPDpPLqkFN/q6XcpRW0h7Isv64wpCZ62hxmx1oSzjZpPB2r0eb++cDY
         OUqxro3pkl9a36mINgkerEdqKe7jmQ2CLJtQJUDNKJuIeKdR0e2s81qygJW0gkGXOqgj
         1ESg==
X-Forwarded-Encrypted: i=1; AJvYcCXXCXNwJp6EOKki5uruEW9VU1sTxt2OqKjh7GIsqiiSvdUw+LutlU/AQCNALodlAtKzKZDMq6w+P+yJqmrNDN/egfYO7YDCAqA6y6JQ
X-Gm-Message-State: AOJu0YxXWKJ91pCIphVYhfO60YgxFIiTHyLkn6NgQu2m4Tq+xzztXccY
	a7IJ5v60DpPzsxnBe/uvJXZI1A6ScG7Rw7YYehGnxzGnUh5l/jQNA1o5URNlunQ=
X-Google-Smtp-Source: AGHT+IGM9Wi7J+z+MS6fiYn0dNhK3jifJCaU6+orZ5nbibQS0YySF3uGnRU/B+esBgM56A84wA1law==
X-Received: by 2002:adf:dd8d:0:b0:35f:28fc:98eb with SMTP id ffacd0b85a97d-3607a764b54mr1322002f8f.18.1718355516988;
        Fri, 14 Jun 2024 01:58:36 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:d811:babc:4f8c:772b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36075c6fa4esm3632562f8f.67.2024.06.14.01.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:58:36 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240611133512.341817-1-jbrunet@baylibre.com>
References: <20240611133512.341817-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: meson: add missing MODULE_DESCRIPTION() macros
Message-Id: <171835551618.663007.10385411290888790860.b4-ty@baylibre.com>
Date: Fri, 14 Jun 2024 10:58:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Applied to clk-meson (v6.11/drivers), thanks!

[1/1] clk: meson: add missing MODULE_DESCRIPTION() macros
      https://github.com/BayLibre/clk-meson/commit/befe87380e21

Best regards,
--
Jerome


