Return-Path: <linux-kernel+bounces-515596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD92A3668E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D276B172041
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697661C8635;
	Fri, 14 Feb 2025 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt0PH+ti"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674E1C84C6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562921; cv=none; b=j1DarwQB/8ez6xZ95xFcrIhTjWWTkfMLU9dQGnmgMt9FHKGuH3c2vvx5z9wdFcAe2qqjZNQ5X/GPphESE5DYfdYvo7XrrGH6Lm19tsIsyVDmn2frrbhV6hduAXr8n2wmThj3JL5LqAcb6iA6R0lEH1rC6adRGuc6rkFkZdKFVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562921; c=relaxed/simple;
	bh=jDZUbPR3az1p6TTvnGVdNLc+wKH51rUHZj5XjVm5igU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SV6gyDV7Toz6un6ZZf10BhdmYdSLD5b1I4GZ+y/OTcUzx5tQNmNqJbOBPGAeRXeoazaIf3/DPhpvqaUA+4SVOpg2b/yXmxmScFYsIszc5NYg2UMrB540JjjSqPI3psdFGge8tCtECVQf6XsHBT3jz1GpWsgpYzjeD95RlBni7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt0PH+ti; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so538222a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739562919; x=1740167719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXg7EqlSdEA/crnBb3uF53Gz+hB8878Qt+C1oVENMmY=;
        b=bt0PH+tis2o7Mm33SPDjQfucQIgyFBvocZByikkUJICaJjPkLB95JcQrZgbHAGWgBJ
         2c+/LNToYKEjCR5cxo0AXDMJl/+yF9Hq/x+9QpoABH1L57TTqvm6ZifzI4iLNTP+53Qy
         dF1pWZkFenatD8XGVzoabsWVKFW9dF5zcSwEkSVC5nAWYHiCDQpZ+EEAwsYX32v0rENE
         4uJWpng+/FpuBWY5bEU0GWv2Ihfco+TWzBUR6PmkAe9+hZ/XCS0g5i7tp4q7y3Z682jp
         0QpGhtf7Mf1MwPPn0KZsHGCdqkzMUNPtOZwv3hjDZHOeSw69fGGpkRam5g1RGDIR8Kd4
         Cw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562919; x=1740167719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXg7EqlSdEA/crnBb3uF53Gz+hB8878Qt+C1oVENMmY=;
        b=R5gETC2D2B1+9jU4zUecklqPRXMg4O/1onUNSysZne4PefzDaOqKzuqEBy/uc/vIVw
         f0xhI3nV9dANATYzTTVEHsQvOd89H4I/kUXhwmLbz3yq0yQ1EsaimUh+Hi8xuQvm1W8W
         38083AFZbJ09FxzwI/fzRady9cYRvTcZHojDdXfSNFSNJLh0OfyoVfZ9iO56XHzdsBOZ
         5ui7nSQGNs+d7lo/Z7mZLKZ7ooXPqzprl6GUlcSm3KjsUcjOpF0IxwnBnbSKr4OAsMHX
         c7dIFaEa0ACHn+PV0mlep6MKopws9lC7Vn+EwJk0QhRX1yW4OsBDgpDcTLDBwbY1QTPq
         Uvbw==
X-Forwarded-Encrypted: i=1; AJvYcCVjLHEAT3RgIv3yEzfRStnjyUimirESn88ZDVGunPWuWWLgziUHvuBtMKODEWRI6mK8gxNqrPRrKDzIgpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx39Q/dlxch/qj2kB2hn53vjlebREEhofzGVjxNy7aGqQqxB0k
	4/I47EU0N96Ys4vT3I2PHQT7NgrjbhbOQBZ4oh438q85naDCb9yq
X-Gm-Gg: ASbGncv/sJ+z/hNTfjmjFDqj78TXbvjguqoVeCnq5coEJLOIJNbbvAHVB4nMXQyXaTb
	olhZpct9kgjCNvq0/QO0xVqjFL1fb1+pMZgj/P7Oak4KAcFC6KTNvog8XsjJVRMrWZfaX1L23u5
	UcfyGYAwpVlAauVdl6Sn2SznHlLB/gWlcl20rD1FpD1WVucrbhDVTkdU8RTfjIn7/A+BKXRH6s3
	U3ZEfx3r8hxaBikcBjEexb7pY6kamvApbn0o4toh63wDwx7RlI/v8hWk8rJICUFw8dx+psmORnO
	A3s+MuN6CEVGSNRfgnDd5BK6hbul+0A=
X-Google-Smtp-Source: AGHT+IEuICp6EtALJXy283hrSRQaWrcDpqt0WHRnxkzJBQJ8uYfMznB+3fZfRTwEqjsTZ2Uk0MMhdQ==
X-Received: by 2002:a05:6a00:99a:b0:725:f1f2:43eb with SMTP id d2e1a72fcca58-732619706e7mr381284b3a.6.1739562918522;
        Fri, 14 Feb 2025 11:55:18 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm2670530b3a.75.2025.02.14.11.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:55:17 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	ajithpv.linux@gmail.com,
	roheetchavan@gmail.com,
	niharchaithanya@gmail.com,
	eleanor15x@gmail.com,
	everestkc@everestkc.com.np,
	kees@ijzerbout.nl,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	gascoar@gmail.com
Subject: [PATCH v2 0/5] staging: gpib: remove unused variables
Date: Fri, 14 Feb 2025 16:54:38 -0300
Message-ID: <20250214195456.104075-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove some unused variables found compiling with W=1.

v1 -> v2:

Address Kees Bakker review:

- Keep the post increment expression (i++) in patch 3.
- Keep the call to nec7210_update_status_nolock() in patch 4.

Gaston Gonzalez (5):
  staging: gpib: cb7210: remove unused variable
  staging: gpib: eastwood: remove unused variable
  staging: gpib: ni_usb: remove unused variable
  staging: gpib: tnt4882: remove unused variable
  staging: gpib: ines: remove unused variable

 drivers/staging/gpib/cb7210/cb7210.c        | 2 --
 drivers/staging/gpib/eastwood/fluke_gpib.c  | 2 --
 drivers/staging/gpib/ines/ines_gpib.c       | 2 --
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c   | 3 +--
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c | 3 +--
 5 files changed, 2 insertions(+), 10 deletions(-)

-- 
2.48.1


