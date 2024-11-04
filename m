Return-Path: <linux-kernel+bounces-394430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C499BAF13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D9DB22DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58ED1AA7BE;
	Mon,  4 Nov 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK/2whAt"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FFBBA34;
	Mon,  4 Nov 2024 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711248; cv=none; b=aR3aft0NkykK9OCzL6HM4xNbVdGRdc7poTJZumLbYpEc5DpCGt1qRoofF7gBkqekyTtF9goa/tbeh4wX1epp4KX+bC4t6LUaNkOJyLtjGYBmxHSitPFXnb2WRn+PCHb2g5zKVu1HN6KtdyuL8KtuXngWPpi1lrjja6VVUpxIUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711248; c=relaxed/simple;
	bh=l8feMzHqADrUWkfK3B2a24SwdCTyO9v2Z8rV0lEtYyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzzhlSyCtAXb9L3q4NhF6MYnj7eNcbU2rNM+QJlwesDq+TT5BsdsZdfjnScuu0IPz0vUS35CL10ANrCUnU1icTtoixYaD1Rr7ATecJcvkaWhjT+JcKgw8FflkELKyFTlyI9LUhx4igyrw66EE34p/C9HIt0+DP5tGU/KdCxKjvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NK/2whAt; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so33964851fa.3;
        Mon, 04 Nov 2024 01:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730711244; x=1731316044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRVygYYgtqhDfCSjCh/hlbUBPe53PGWa/m2/kjkbR0s=;
        b=NK/2whAtCinqVekfNoEc4p1Xy7GihOQoYOY1S4otNVGAxPkmrSQZmisWcw4dKI9Mwo
         T3FVjjvlVNNuT6BG0N7k4E8JoPHmgH12Aoeuls0w7E9aWSo5yWuMeB3LYM/qLEr6SoY4
         3sHh+N3BQlnwPJjCPFDOeQm92IPPknxnaarH1ZjKlcIquVyvXSkBlVSifCg67qwOLamz
         YZbYtem5WcLgEIWR37vIF+xKKlT5CCXHznIr0hzZt/SdHRql2pGRrZmRS1VFcLGJAGOG
         ouzoo28BuMRfk5008Cz3ekrpsq3GGCmwhD7YzBF8cZw2KafOukkcw8p590Y/yQsCUD0w
         HdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711244; x=1731316044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRVygYYgtqhDfCSjCh/hlbUBPe53PGWa/m2/kjkbR0s=;
        b=hyMXCCM64SiyYCL9gclJAdDAK2Ie28KUHkmUilCIl44yRH1vj+gfcUfGP7rE8KfHE2
         RBLrAvpWJ57iF8vPXmTJgGjYd5CMLCjOKn+lKXNqQ7WjlMNGexopi+HXsTIT2qnKgAR/
         d0xuG/56e47EISURSHMUnmX9vMBWAywupH7xzCWAcCntkHf3BMLG2t8KN3oh6pSDb2VC
         xWyBfw84DHzC/Q5OlLPutZ+MbFIre7qX4tiq7JZGq10lbopnLBHupMJ6vvAmVj8mxRWs
         4J5Y1W+VBU/CIqD1tB2RgyhVNJ0x0+2nX7RQL5lYSpggKlVFJ+N0/gGVbiRuE4vtMcbE
         C/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBLxUv/1VxOJJB0VZGrwSPPXbI4gkU6SZw2Efu5ivhOUU5G6ZlRwfaN7CfHEXLyFHdFqOOj6Rg0wOI9A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBt9vq0b9KRpO+rMISiiIlfIh4T9GzCN/Ww1GHwBocop9UNj1A
	zHWmkLTBIWDaVG/EPeydTGmgwQ6B+YAf/TmeAadO2n+9WWKX2RWsbG9NnQ==
X-Google-Smtp-Source: AGHT+IHdp5undXaZPicN2YKH8sLBO8EC7WDOuDqfhtDTBhU0REj77XSALj6gvlWHsGxQP7L2nzqoXg==
X-Received: by 2002:a05:651c:210f:b0:2fb:5038:3eb4 with SMTP id 38308e7fff4ca-2fcbe078dbcmr150050251fa.29.1730711243719;
        Mon, 04 Nov 2024 01:07:23 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a6070sm15829991fa.89.2024.11.04.01.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:07:22 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: daniel.almeida@collabora.com,
	a.hindborg@kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 0/2] Add dma coherent allocator abstraction
Date: Mon,  4 Nov 2024 11:06:32 +0200
Message-ID: <20241104090711.3000818-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the dma coherent allocator.

Changes since v2:
- Fixed missing header for generating the bindings.

Changes since v1:
- Fix missing info in commit log where EOVERFLOW is used
- Restrict the dma coherent allocator to numeric types for now for valid
  behaviour.
- Build slice dynamically.

Abdiel Janulgue (2):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 165 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 4 files changed, 168 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: ae7851c29747fa3765ecb722fe722117a346f988
-- 
2.43.0


