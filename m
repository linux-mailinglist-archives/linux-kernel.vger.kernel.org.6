Return-Path: <linux-kernel+bounces-266838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D59940854
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D141C22B37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40618EFF5;
	Tue, 30 Jul 2024 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVNXooDT"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF718EFD5;
	Tue, 30 Jul 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320613; cv=none; b=NCTbypisq9SnlBEaECPgO3KdsFd5fGtZWOaPaR+0wAPgB5mmSjWK0x1CD53i2ZltkQ7D3qXmq1JKk7qjRljBlWXGHQlSr31Oow7xEXqn6Q9VmyVR1fvr22iHvkOEpypVEMhsuBsMrQnCLMWM1rrut6PKQSCqtXceJvuG+PNGja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320613; c=relaxed/simple;
	bh=a8HKe7nWVj9A27Cm8KAmgztKTLuY1QbVvtkpFwJndHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Onu+W8mb3offVT1eYUrwjNhvJy9dwUmWs267LH2WAcR2z1/3rQDwJv3jWcJuABgRLgLpyv8xAgg03eMayptZL1p2FPuc+aa5ZLVktta7ghtj80rls3UIfTR+aZ8F62NHxkaoXPxmEISMsOVJ28OVp4FqzCXMxuV2u8CPLXlKWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVNXooDT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso3972041a12.1;
        Mon, 29 Jul 2024 23:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722320610; x=1722925410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=loIoRNYN1TT3oW5Nl89xFLXMprE3gwNGScDaaN9K4PE=;
        b=DVNXooDTXyGGaWIlUn6OevqQzQF9L8vlG/QIu5yCMB+yBSi3hhCK2XF6kaCq4TZcMb
         KsfYDcbFsJYEdOinHjs5JCYKIamxV0AeYyA43TNV/j9WjrlU/Jm/gIJ6iwK86lByWsre
         zKFZ5cqSCWWT5AOHwcxq9Sgm7p5quLWgIoD/GbajlpkyxbZgJTEcYxqtFhb0EhdhmMlr
         gHfzoyYNl8mb/sJnFKgV+s1doHVkah/cC9BTDEOkYkr/gz5+UxqgaCJBF4Xz7U6lxSIf
         LYAgMQ4X+O2mOnOoPEQa4Z5f7WXPNpLf+0VWbaEJpG4bEhDVgzwDYAxuGxSzbCkhPige
         Z+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722320610; x=1722925410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loIoRNYN1TT3oW5Nl89xFLXMprE3gwNGScDaaN9K4PE=;
        b=FJr0t726Xv2an/q6rlvBbSBESHoUSjjtFuyqHobh5NLACggwEDi01AUO/429fDSKRx
         0AhV7Qh40vTt10ylKKIzIsEHGjw00aqv9zQQp22czlvG6gbdLh0k1JwSrD+DYBxWbWj7
         qg1cS2zeFC+0KzEJa1Plcol22GbcKNbe9b7TVOkdHC8LFVpTO5Iht3zQajlIbhE8vuzO
         1FXPWS1lR/PyAtYY9uS8ocp5xFxMmba+DPDajDRiGZwIQxRjaJ7YDpb57/SLwm+7xsMd
         5n36/p4482yBVpinT+l0kOFKpNrfqIxgNIKpevX2t3NDJBnl9JGtixmkiCj4b7B4x+6j
         NHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNtetvkISbIMSdhhJ06zybV2Y+eXEAxJo4b1AHBJX6dWQKdrMXQJlYiSIxdLVKsDSahPygiGij1G8IDguDbK+Yz+gp1iDi8kVHaBKfc3h4sxglZhcShdR6GjORPqVnryfycYA4vBYQ0XA=
X-Gm-Message-State: AOJu0Yzx+QMT1wfCPSwmCcJjQGrkTKf4bvaadAKh5y92m1HWKKZfsUcJ
	8iCDCD2HG0VMA6Gw7InLRZQACgRz//ObVsN1qL4paIAIP98VZlZEhsNXSlT9
X-Google-Smtp-Source: AGHT+IFx11+/zuOr2XYaUGYazy72AY+RJlOkV4NWohq2UPA9SUmnZCIlDOesuKYZVlzQrU/9m+En4w==
X-Received: by 2002:a50:d4d6:0:b0:5a1:a447:9fab with SMTP id 4fb4d7f45d1cf-5b021d21e91mr4747849a12.28.1722320609365;
        Mon, 29 Jul 2024 23:23:29 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1ec5003008007610402bf2.dip0.t-ipconnect.de. [2003:cf:9f1e:c500:3008:76:1040:2bf2])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590d76sm6826134a12.24.2024.07.29.23.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:23:28 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] (asus-ec-sensors): remove VRM temp X570-E GAMING
Date: Tue, 30 Jul 2024 08:21:41 +0200
Message-ID: <20240730062320.5188-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no VRM temperature sensor in these motherboards.

v3: Change commit message, provide author's real name.
v2: Fix typo in the commit message.

Ross Brown (1):
  hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING

 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2


