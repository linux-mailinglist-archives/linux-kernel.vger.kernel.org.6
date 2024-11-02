Return-Path: <linux-kernel+bounces-393329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CBA9B9F4E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3D52825FA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8DE17799F;
	Sat,  2 Nov 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqIUvCU1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129116EBED;
	Sat,  2 Nov 2024 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547242; cv=none; b=TKgwGRhy0h5Pac2+G3xQd45QtJcQ0uLoumivEirrliYIqKMjF0gGHAekViYEPyWLg/3uCxaMK8xCzgN7v29oluH1Eh1x2mIcB38bGaSzsjhkVCYr2DUa8w5Mn76g1ze7RuPlqkgnArmIj+4tF4o3vNTrhFL/UbMnrOjHw4WnMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547242; c=relaxed/simple;
	bh=8Toc6IFng2Tnsji7txr94Wiz0YYYryVDYAGQt80sQWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zal9K0JmvId35wM+wHxCWHRfN1f57jtFa9lyxEO2hLNozt0rXXPUStBh6fwvAtv46w3DLixmDdyYa/vZgINPDE05NJzzrq4CF3083oOVU0O0WjM8/efpsmNQAPDsIXPy+G+pk1+yWDZ8lApkd8Wrkn4+yZIh694WjMXaFYrBc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqIUvCU1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20caea61132so24353065ad.2;
        Sat, 02 Nov 2024 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730547241; x=1731152041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zrdCAeiD6RabuL/Tg4yBStUK0YW2zJOy12eTTTW6jE=;
        b=AqIUvCU1bh+Pa4rk5i+99FMBLfIfoE4S9Uz/ea0vwKTmlkwWn8qT206pciwoTheAQV
         QbZdVXTeOjRFy/PwQfVvKdCn9fHWOSO1kq5Ke/xf3RUfnGQrdZBdje2uQYMobX6ViU6q
         77/Ir7vCKnR8y8OcLbbXIPvJ/YCT6ILsDp47mPNf5zysF/qBZ/wqpfN6xV8iHAlv4RLN
         XgqAyCnnM2iqeNF015Pc9k5LzV/+8YrKUGUPhdZS1kbYZl70LGyt51i8qJ2Sj8hgZjU2
         gZxQNfu1fONi22Jjb9ZKL9EBs/zbs7KXCLIqo5bUh5wTO82Cbpq19fibTxP7HXNlTSWv
         h+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547241; x=1731152041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zrdCAeiD6RabuL/Tg4yBStUK0YW2zJOy12eTTTW6jE=;
        b=QqU7V8DlBICLBAz25ZIbjlte8nS/ViJSoU7/ZWjIDMYBufiE7s4FTHhoOrMv1BcjYx
         I2Kg3Go5xKmSfBwTPY0LQUv+dwuMI1kytkMWvhLiBXCeVV8M3BYWAtocPEsRYFNBXqBi
         O4jZ1DF4YQ148mW1j+k6OthO7LJDT7tO2tyQneNlr4/K+5NdAJlZKQ2NnKDuSMXFD+61
         GBdrqwCLbesBDiG324Hoh/ixZT+oz4HvygVbuTM9k3gDJqQ6puctjYJcDUZfjxvXDbbD
         wcw40SS0wHK6Bi2GXl6t5sSSliiLb26w9IPAJGRefeeP3Rg03HS/JYbHDoe14+4cFQsd
         MX/g==
X-Forwarded-Encrypted: i=1; AJvYcCXxGlMuMquBrtOWOQ69rWtEl4KzZ3mjO7sEOtVOGOh4sBxC6pjHLZzRgkA2VmWwCMGxjLl7tGP1kxhrmBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCT+ad5lDcd1NIQ8w7KhwRpyKnPruj3kgdelQBVr4PrRVKQvvF
	yuyocLbwgvE8dUgCT/yauU3h53HHUswHz1AJpi3HGMOxgaWNR+1G
X-Google-Smtp-Source: AGHT+IGC2g1aC2YkRztsD/2FH/X/4f1saVcpsTCvGvZjuc/hnIKVFEFZw6fQnqRepBc6PxglD0mZ8A==
X-Received: by 2002:a17:902:e5cf:b0:20c:705b:4123 with SMTP id d9443c01a7336-2111aef2713mr87504465ad.21.1730547240665;
        Sat, 02 Nov 2024 04:34:00 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc34sm32894405ad.51.2024.11.02.04.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:34:00 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: dts: sophgo: cv18xx: add emmc and sdio support
Date: Sat,  2 Nov 2024 19:33:25 +0800
Message-ID: <173054635857.778838.7207985849003780014.b4-ty@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025112902.1200716-1-inochiama@gmail.com>
References: <20241025112902.1200716-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 25 Oct 2024 19:28:58 +0800, Inochi Amaoto wrote:
> Since the sdhci driver is already supported, it is possible to
> add emmc and sdio device for cv18xx SoC.
> 
> Inochi Amaoto (2):
>   riscv: dts: sophgo: Add sdio configuration for Huashan Pi
>   riscv: dts: sophgo: Add emmc support for Huashan Pi
> 
> [...]

Applied to for-next, thanks!

[1/2] riscv: dts: sophgo: Add sdio configuration for Huashan Pi
      https://github.com/sophgo/linux/commit/06133f48a87144de40bbd3934fcaad449ecc1b93
[2/2] riscv: dts: sophgo: Add emmc support for Huashan Pi
      https://github.com/sophgo/linux/commit/b5cf65cc0fd00aa30ff218ec8170dd48e3cbe78d

Thanks,
Inochi


