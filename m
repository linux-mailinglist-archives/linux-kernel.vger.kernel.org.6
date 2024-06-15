Return-Path: <linux-kernel+bounces-215652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F524909583
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E72B21D80
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCA19D8AF;
	Sat, 15 Jun 2024 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WiLWtApZ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9990173
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417044; cv=none; b=XogUfJEAmqO3SR8EGFoCnBkcSpeHk6j1FYubGt78TuenxeIpMAIbyvoyGdxaQlNWbXLij71GmvfOkgI1KnbLSNOEBJUPMyVGLgbBIoWezZ2VDUHpvVS48WFCZSJ5b4T7ElABeth/zy7lHFjyyuAopW917twYMIQFwPKVyBXW688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417044; c=relaxed/simple;
	bh=rpZvw9XLEKpYCseIpXEkSatocTf20gqMAbN76hCnHR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWxZzfv8DO/Fu613NjZJr7+a5J9o2C79cqbPBT7Sjx3uuaCkCLr+jrYHDC2eR6TGJFOWmhTPN6XS3tIoRejo02XhH8fSqEkyD3PAvNj1NiAxGUzs7zNMJFBo62WtLT3+SihsGYDm2iFIj2NEtYjJEBLlHFadqSnHoOu9pChwEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WiLWtApZ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eadaac1d28so27759781fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718417040; x=1719021840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJY6cmqgIo4QzbPjFJCYb3fkRY6vEH1kGUNF5UfRoaY=;
        b=WiLWtApZsfqx3Jcsq8/YdnRkUQy/Rv4mglC2RMcTjUk/Yfyt+Yf0PVn7hmot+06O+f
         iY+w7dk7IGWs+PzhX+MZArRZNr4MpZKl2sYVM/9Q/tRU1ve4LP/MqqAxr01WdRYa2w78
         sqBPNJdtElQMNHSt50XO4UGQgtVZZK5i3F4WbeqMXFaf3Rru8TZGu2OQbhMg27cQvEmt
         fWavhzF48ZFpsC0gZmCcJacJBhHd0B0AWkbSb4LYGD1vcloFpCJT1InAc7UqlNWHH9GV
         qIOOox6gKZpc0u1xkE+GtoDhNbLrnSdVYyypjNAYsJcD/l5YKo4vQD9+qC/pihoHAFk8
         aKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417040; x=1719021840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJY6cmqgIo4QzbPjFJCYb3fkRY6vEH1kGUNF5UfRoaY=;
        b=tErYMC/31aTGAasT0S29doXM61HcMK6IozjS+Myu149LitldRCyjYnHp9IyrEi/24F
         7HonK9YSpPkCIRB1rcfxaTUhuNGG12pa+4QAYn6K2H6IYKsnb+xAwH28y3iQ1oukQg97
         Co8hPyftO7ClHS2dttej09P+Sen6DVfozSqpgk7/nrt4pjoHCtXbmNccGwwUtGW+MyVu
         ubC79bYiRjKABk0vAaUydS4RWDkcog/9mCnvtAYWG1jZpffqfp60Ysbi9VqQ5NFPb+1X
         cabPUMH3IJxNUmMGX7ueR1sqPYX6iorNn/NrVKED/2gx3cRPksuWtKlDDPdAPCBu323v
         Tl5w==
X-Forwarded-Encrypted: i=1; AJvYcCXbzwcvWqvZF9g1O8a597wZAxLX9/FbVu5O0pQp4B10sz/m17/nLiWZ1d/jj9JYXn4ftG5ScfhHsTGXaoohh8Zy9T0WLse5VXHUfNay
X-Gm-Message-State: AOJu0YwkY1lAnF8rlBgaAQ3Axn7p/caIjIStjL9SYbk1BgcCuIOP1UmF
	B04XS4/TyXJ9Rnq7QONGsI0IIX2Z2DDAW6xWvO17ij4UR4xfPrTz44LGDNhgdFI=
X-Google-Smtp-Source: AGHT+IFmM+dfyVMho99Mx9NOoZZ+DemtrUH0RcguBm6o/Ak9z9VlZpmwhuqfVw10Q7QX2HYYbQjZ3Q==
X-Received: by 2002:a2e:a601:0:b0:2ec:18e5:e686 with SMTP id 38308e7fff4ca-2ec18e5e7d2mr22180571fa.33.1718417039933;
        Fri, 14 Jun 2024 19:03:59 -0700 (PDT)
Received: from localhost (2001-b011-fa04-32f9-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:32f9:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e564c5sm39154145ad.24.2024.06.14.19.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 19:03:59 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v2 1/2] docs: stable-kernel-rules: provide example of specifing target series
Date: Sat, 15 Jun 2024 10:03:50 +0800
Message-ID: <20240615020356.5595-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a concrete example of how to specify what stable series should be
targeted for change inclusion. Looking around on the stable mailing list this
seems like a common practice already, so let mention that in the documentation
as well (but worded so it is not interpreted as the only way to do so).

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Change from v1: 
- "asks that the patch to be included in..." is edit to "asks that the
  patch is included in..." for better wording (Paul)
---
 Documentation/process/stable-kernel-rules.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index edf90bbe30f4..d22aa2280f6e 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -57,10 +57,13 @@ options for cases where a mainlined patch needs adjustments to apply in older
 series (for example due to API changes).
 
 When using option 2 or 3 you can ask for your change to be included in specific
-stable series. When doing so, ensure the fix or an equivalent is applicable,
-submitted, or already present in all newer stable trees still supported. This is
-meant to prevent regressions that users might later encounter on updating, if
-e.g. a fix merged for 5.19-rc1 would be backported to 5.10.y, but not to 5.15.y.
+stable series, one way to do so is by specifying the target series in the
+subject prefix (e.g. '[PATCH stable 5.15 5.10]' asks that the patch is
+included in both 5.10.y and 5.15.y). When doing so, ensure the fix or an
+equivalent is applicable, submitted, or already present in all newer stable
+trees still supported. This is meant to prevent regressions that users might
+later encounter on updating, if e.g. a fix merged for 5.19-rc1 would be
+backported to 5.10.y, but not to 5.15.y.
 
 .. _option_1:
 
-- 
2.45.2


