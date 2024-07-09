Return-Path: <linux-kernel+bounces-245014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A454892AD03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1611C216F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9817C9;
	Tue,  9 Jul 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I4ezVadx"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3FA21
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484032; cv=none; b=RED9CC8QkGoVko+QY3pWp+/iP8oFt6uZJ+ameaEaP9/kXNZsqjcbIsL4t969RVb0cLpjVt4+an9Qoqi2v4joNWH/VuBADs3eYxozLIXYYYbJgSeJO5I1dfBV9kqPkcHM3IWkRVbkqdrFmi9hcVbVacQWLvTG+ypUfFgTBMUC+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484032; c=relaxed/simple;
	bh=jCEm882SQslRgIBXsQn1kxrkykzNfCqulLb5W/QPZOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UMIUEv/+mOvXfSBG+/Zlb38c3HY5C0AW3p3/0isHPGT1tNFE8p6d4R31GuBa7jkGXg0yeENnUMoHgD0NaZEqNSsPKBHMIj4L0N6s84Emv1A8EY0xhPZZ3MaXE4RgmDiVFJLCAmnOvYiofLILhP9KzoT34Z/8hfr3rsRyD1DTVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I4ezVadx; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-77d3f00778cso357695a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720484029; x=1721088829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ht8VsBOkepq5zsjawGUoItW8opG98EOdGF+KrcqtpU=;
        b=I4ezVadxpOmDhCZWDWhmniYXfjHBYdtWnRLkEMpMBZU7IMAMPWuQcYwNK+uhbxM7rM
         J8gyLdlDcsdTnle06RNJntcsg86+zLG9eqhErO/ASNpVBXmYwkO111w8xDJy8zGnOtlU
         EiZL/XaltPd8sLZbpxCy1MBQ4ZnH+rv/pvLJTQYOcXuDgP/+q+MzFEz5Ebd5ANgCEkFt
         IsSgXyGYd1YQCNdtuJ+16FvMpetzNWIYZcL2EYD3EOYwNxq9v+u1BdQGRn4CFzeLbcxt
         pLBWbgtR8u4VvBaJSG6IcwqX/6t4pfI+JLHCgDnDkkR3Y8m7LhzT0CUollzZlSHFgkCD
         P6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720484029; x=1721088829;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ht8VsBOkepq5zsjawGUoItW8opG98EOdGF+KrcqtpU=;
        b=RlZAv+JCtBKXF3C83j34CuHbHJBKMgeI3OVC2BBwk4+IU94IeUd4W8qzFIodUK8GnO
         EzWS3nw0bXLrsB7n3bMhfgrtpaHeZrdlEGtQw7ymreZAyXc2ozjNJbab3qX4RWnvndEO
         JTi7PBWLgPBHxeUDtgMUnkROdUilWxdDgz0zTux9ifYd8auNb4Ri1Vv1b9G5zNDp938n
         DhM4pqqKsbGP1P+KeLNzyfNm8Ww7D3opZOAb0atn1UBcFR752XgJsXKztCUJZ27Mt+9o
         VpvpUWxB4fzYVX2jq2YJaapDuETK/RI6Zhw8RBHJguHOCG/8A+gU3U80PfEt8YuE1Q9L
         TsJw==
X-Forwarded-Encrypted: i=1; AJvYcCVpCH2g771f1E+vEKQrvZTOOdbWArUixj70jffIyBJ42YWMfXWsPDkY6uwG7s8gXNFEsyyx/bHjh/6POz1M5vfpdw+EksxotfegHbEj
X-Gm-Message-State: AOJu0YxgUW3p6ADAAFKBSDduUlzE4ZR1oqWCnuACy/LiWu5XYHEyXiD5
	EOkw1/seZqRRmLQTBpf9+AdX/zNEN9+d/Lf8m54dAqqusaQCzlRl69fem6wZsbM=
X-Google-Smtp-Source: AGHT+IGkWCCkWN2IpjJSaXA3XjI+bvmXyOSILAUhGaY1m2ht96DWj5nBOIO/mZVcokj6IO0IX3nQwA==
X-Received: by 2002:a05:6a21:78a9:b0:1bd:a048:7fcc with SMTP id adf61e73a8af0-1c2984c9eb4mr1004308637.46.1720484029558;
        Mon, 08 Jul 2024 17:13:49 -0700 (PDT)
Received: from localhost (97-126-77-189.tukw.qwest.net. [97.126.77.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad3837sm4238665ad.300.2024.07.08.17.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:13:49 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
In-Reply-To: <20240606165104.3031737-1-andriy.shevchenko@linux.intel.com>
References: <20240606165104.3031737-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ARM: omap2: Switch to use kmemdup_array()
Message-Id: <172048402893.4046096.641938212436686822.b4-ty@baylibre.com>
Date: Mon, 08 Jul 2024 17:13:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 06 Jun 2024 19:51:04 +0300, Andy Shevchenko wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> 

Applied, thanks!

[1/1] ARM: omap2: Switch to use kmemdup_array()
      commit: ea77ad3d2dccaf223c556886b067c5e2657b40aa

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


