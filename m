Return-Path: <linux-kernel+bounces-352086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 820079919FB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1ACB22EFB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FE315F33A;
	Sat,  5 Oct 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ZfWUJcgD"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DFF156F39
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728156938; cv=none; b=WcuNxz0LMCLHCwYmVB0WC8IHo3D7Kt6+jXCrMOVfh6aG2Hwdo2WCNZJKgW/CGRe9aJ1E67GLMldp3M0pQkhBqIFazq5qKtwL3sR1S3KIwB1zTYK6FAcbBmpgRoY2cHdCSkCKNpYp6bv3k+AZMeWc1UB54ck3lIh8jaWuwvcT95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728156938; c=relaxed/simple;
	bh=PWhRz5ntv1PMjmqcUQQ24v+XFnMX1HVF2DLDKHaUGLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lVRZvffCk4NblOsOS280bSsjLHnSiKxhoEGo+u6ctWH/y4zbvD/N0XD5WiJOFgUYOGEAdwuRhrqtdnXk6lCjes17ddYsGi2vD9Z16+pYjVZoK2tNkPD+7spj0RvIOICo4GOcsBGVur8jr1L5zU9LmL+WroZphXID29OZ2+Y9Yi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=ZfWUJcgD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e06acff261so2283753a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728156936; x=1728761736; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eUo8PbLV7DzH/3OkoXZxex7mQaAy2ITOpmg7h/Bwg5k=;
        b=ZfWUJcgDI3MUh9dNCp1TyJci+kXy22/aaIe4q6vbL7SYnih08jrXhYZnuBp6X2hjsq
         3oAYTOM7J1RR0QB8zWn5KrUCPDx5IOH966Z/EnW+TIraQqIRzisOrwRAWewOvNbKoBG2
         efIMpKZ9bY3ERg9xw2CW2cOIHkDVuFaYWJwnfm9Z7kWW4jCmCV98vovH0ijz/AQ4RL+9
         7yJggycg/KkAk0znmuKwteekzbGj3k2GxcZZEhobahOEBBloKToZ+HLJXlM8xr1Dob7E
         TTmBYUCi50H6bmeTOaHX9v/ukgtNiBd8Pmbx6Dis1plH+s5WxirMrE1eOJa7TBQf2HAW
         sPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728156936; x=1728761736;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUo8PbLV7DzH/3OkoXZxex7mQaAy2ITOpmg7h/Bwg5k=;
        b=dS5+c7f4x3b1UN0bMu4LS9eGUeMWwX4uVzT3y1fp3F+z9Ct+asza6Jp2JiFUadPoUq
         aajo4d6xWnCmVKJKHGw4w3LTCZOveNPBNuUseHk6OlClaRS4OxKZHOY/YOA0Pqb1umd0
         /xCZrMCrM0YZy8sQM5xwdUVvxwg9XKrIy/0Yjh4Ad9xlKS1Brs8XgCRX9djYYreGtdgO
         3r7vjeTLs0TXwyI1Ac5/dzEzJrrrAb2GdQ0kZdv4iUahaAaPgwmSHLcT+L2LskZWzXSB
         SoJ3W8kppOLMJ1WkwdqlWNMLkRHTQuQlc1oyIG3znIuFKka9hX0+F/WgJlhAa6UG7WpE
         F0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUIfJb0rVHVD0QbaOkxsbSfzisv5e2ZQrCuYxEjpUKBhD/MYFxkXPKhQHufyHL0CRma7nFvKu6evsGydc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypksVfe5DENy13jKZpa0+apc25g1JpHfLXx6g+NvxFLbrwXrcz
	zReK4/bS6yqMiCiN/5QES+Tca12Av8h28zzoN0ceiWJIZEF2a6xOR1/aXPuG214=
X-Google-Smtp-Source: AGHT+IHtwrV24xE/l+gDAETrNQXp2UVakTLTo1slvBKGsduAnZc+2iZyU7ukJKrX33skCIK41Z8bZQ==
X-Received: by 2002:a17:90b:1b05:b0:2d3:cd5c:15bb with SMTP id 98e67ed59e1d1-2e1e63698a6mr8331157a91.25.1728156936433;
        Sat, 05 Oct 2024 12:35:36 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20ae6dfa4sm2208372a91.2.2024.10.05.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 12:35:35 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH 0/2] pinctrl: th1520: Improve code quality
Date: Sat, 05 Oct 2024 12:35:26 -0700
Message-Id: <20241005-th1520-pinctrl-fixes-v1-0-5c65dffa0d00@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP+UAWcC/x3LQQqAIBBA0avErBsYLS26SrSonGogLFQiiO6et
 Hx8/gORg3CErngg8CVRDp+hygLmbfQro7hs0KRrRWQwbcpowlP8nMKOi9wc0Wlyk22rtmELeT0
 D/yGf/fC+H2w6r2FmAAAA
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.1

Two code quality improvements for the new TH1520 pinctrl driver [1]:

 - Linus suggested using guarded mutexs so I've converted the thp->mutex
   lock to that usage in the first patch.
 - The 2nd patch is a fix for a missing return value that smatch found.

The series is based on the linusw devel branch [2].

[1] https://lore.kernel.org/lkml/CACRpkdavPAv2sPRREQhx_A7EtOj6Ld_n+NcO+vH0QCnfVedXKw@mail.gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
Drew Fustini (2):
      pinctrl: th1520: Convert to thp->mutex to guarded mutex
      pinctrl: th1520: Fix return value for unknown pin error

 drivers/pinctrl/pinctrl-th1520.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)
---
base-commit: 2694868880705e8f6bb61b24b1b25adc42a4a217
change-id: 20241005-th1520-pinctrl-fixes-d20db68387e6

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


