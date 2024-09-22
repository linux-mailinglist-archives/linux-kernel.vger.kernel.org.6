Return-Path: <linux-kernel+bounces-335087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104FC97E0E0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DF21F2124A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435FC193065;
	Sun, 22 Sep 2024 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0fxh4Te"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11274171088;
	Sun, 22 Sep 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727000460; cv=none; b=VfVVyrOsCpKc9cz8ghCoTFgBQHuTLdFbhqK96SCpwRfnCHGd6n3vSIzEAtnfe35lQP/GSr0FckGkmOX5zQELTrQFgoXu1sr9cfdeXdliIOGsDomRXwzgkWEXmtqmBPJ9txUiEzYYAPjmjzjeRiAsIol0uAnsGz9wzDV1bvD4QVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727000460; c=relaxed/simple;
	bh=yPWN0XWyy9cZhHF2ut81Am2moEqz7TnAc7F+vtgkCE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfZIgx6WC5GrF5PjFZTTmn8ujW1h8CvB9ge8rp0OW82B/SrqzhGETPUoC3APVmzZVo0VsGaqQAv7hoEVFZKDnLvtT2JG/6V1cKw1C+4TW+ct9FR7pyLHRYn4dW2D+UFO7OCJjo6F9goXqc8m8yuJStY78VkeX/gnPlRLhyHv2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0fxh4Te; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-205909afad3so40563995ad.2;
        Sun, 22 Sep 2024 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727000458; x=1727605258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdphpHCR8aVbgwIQ4xKroiJuMuvQa/f/rPNkLNXJpng=;
        b=e0fxh4TestRp3kpU99wJ5u20dG/RMcoxbcZszrcY7m5CCXJDUKfmxrEop7IfVjNtMF
         DQKmvigp75Huw3XL9O1jT+6JGdOvkQIprCFi2PrT5J/t6cFYk2sZL11vjdlPBDY/scS5
         jZr+yWwP5RQm3kN+m1JokUxhJXkl0DqjSbf2l0YS+snbDl0j+wBTsqmxjZhuKna9+zRd
         T/5voAFbNHOfcJAhsBMoCls2IWCnkNmMc8TeDgvJplcMR3y2BpxHbeZouFQCWdzGr3I8
         VuJy2lwTfEjPyHRo3pA4/pZkeEwB5Mh3IZQURNhkOw/oLCY53fBTApPhcLQMSxzhDPcr
         BYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727000458; x=1727605258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdphpHCR8aVbgwIQ4xKroiJuMuvQa/f/rPNkLNXJpng=;
        b=ZBhbOR00W83WnqfHRQFXt9rBOxK/2kQj2QxmkSRnrEfj0Y6Zlf49aEtKe+v8ZqTb6Z
         aMBvCxjYTSVbtASayK6cyM6St2buZL+NLwX46jU+5ocTMxlGZQj8ajciOGwFbQ1U2i5i
         /zy7pDn3pC264fB6jj168aNC7p5cQ432tpbt7Cr46OmGMF1BFlPmq2j5kxhCn4HaOuym
         AGnpKBFAy7yDk7Jv1T/gXu/0HT0ocu3KthgNcWliMj1gWTg8bAb+mFsphfFxCjotbdmE
         FZA5vxnmaHKy1oEQPIgT3EgEkk7fAGdIS88KjtCHN2qQUJoNe2VgLc01Ae1P73d3ic/d
         ZPrw==
X-Forwarded-Encrypted: i=1; AJvYcCW0NtpmCe5OiY6dk5STHfErplTHGanih05zBzN07T8yqEoW8rRvehmbMUEg4ooRA51+9IUtwo9dNqVS@vger.kernel.org, AJvYcCWYVuGNWpzfek4e8I2/JfyG6rq9FZHz6/IiANYNLmOPhOlRgvanzql/9fHU7gU4A3FGlGWnjrNjOdYVVicQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSUYJXuNQ0GBA2hANTpdS6LGpuVsuYvPfdGqf9wcCeX6YlfFI
	qvU9MF35pFhxswc/7DZzXMhgXBpNDlg4OGLVyCBXdFv3GOgwbSiV
X-Google-Smtp-Source: AGHT+IHJFkRgYfEyGcG2xVh86zCa2dDUxlM9NiNctUcc86+jKhYpj9NQ0sCDUu7kuXl6CrzEV+ZQ+g==
X-Received: by 2002:a17:902:cf05:b0:208:d857:1014 with SMTP id d9443c01a7336-208d8573fb1mr110231715ad.28.1727000458325;
        Sun, 22 Sep 2024 03:20:58 -0700 (PDT)
Received: from localhost.localdomain (111-240-85-119.dynamic-ip.hinet.net. [111.240.85.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946f3558sm118619615ad.183.2024.09.22.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 03:20:58 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: andyshrk@163.com
Cc: andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	minhuadotchen@gmail.com,
	robh@kernel.org,
	s.hauer@pengutronix.de
Subject: [PATCH v3 06/15] drm/rockchip: vop2: include rockchip_drm_drv.h
Date: Sun, 22 Sep 2024 18:20:32 +0800
Message-ID: <20240922102032.564-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920082122.6742-1-andyshrk@163.com>
References: <20240920082122.6742-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Move rockchip_drm_drv.h in rockchip_drm_vop2.h to fix the follow
>sparse warning:
>
>ARCH=arm64 LLVM=1 make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>mrproper defconfig all  -j12
>
>drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:502:24: sparse:
>warning: symbol 'vop2_platform_driver' was not declared. Should it
>be static?
>
>It is also beneficial for the upcoming support for rk3576.
>
>Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
>Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

Reviewed-by: Min-Hua Chen <minhuadotchen@gmail.com>


