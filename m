Return-Path: <linux-kernel+bounces-510042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9A1A3178B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB4160934
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53DA1E282D;
	Tue, 11 Feb 2025 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4ZYYE46"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A8266F16
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308890; cv=none; b=F4+E59maWeGhqtMSa1CmoDHiZH9QkdGsGEqKiqJo1O4PSLNSlTYqx6XwnVAWrtI1mVEKpUGQ5K8o/gn5TnWr6SixY2bOjh5LjXBvuh0vlYXic/pzAHgaXd1+flGLT+ZBh9Fb/8U0xmU83lb2VCBBvpaG8N/jO5z1LDiDBs/pmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308890; c=relaxed/simple;
	bh=gvapE1cYu2+xdjV1udH7CQGdRY9ys95teQpUtH9qBw4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t6SGV/vRUCxRhN5VCwNlkVFDIQRGLwBhLUOgo8h+VkLcGcWUrW4aRIOG6woRO0D4T/xvd25PimqQvWyIzxJWemNoE9R1YQqe16V0VQrfmRFklwL7YG4CzfnTI6hYbUpcIlOLVJj+CAIHiR/x4Olp3JyAvYIacNeo9fHyl9n9Ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ndesaulniers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4ZYYE46; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ndesaulniers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f6cd48c67so60033065ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 13:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739308888; x=1739913688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J5laP/V6+PcdzfWFMorJmNY0OQhJmHjPg9oB6Jm1t1s=;
        b=U4ZYYE46btJpUfve6JqocnMbshQAMuswD9trmvfu6Eq7PWWW9r5Iz5cF0WLygSkTaO
         8BXtkk9hgRHTIS5eLEdyopYn9ulaBYlhwhxH1Np9CyiS0x0WCC1UgjYnTQtdDdy3lT4h
         okVRGXbspZKWnVfXbogl5DUXSulONdOdOVgNzQE/XZEqyQ6gEcx500GrCpKo8e22/mcG
         OnDY27yqRxdUEYpQef9mP88+p75xrSay9dbt7pHnxI+Nr+9OCnrzhl/3gvIlcUYSnnGv
         gtLUxAxUeOpCWi6+B+5gZTpAsBZ750zTwMBUls2pfLPzviqqZw8XNYg+ncJU00NJnmM7
         DWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739308888; x=1739913688;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5laP/V6+PcdzfWFMorJmNY0OQhJmHjPg9oB6Jm1t1s=;
        b=GPs9dDLhvuGEJ35zoB+JGYgCsUggnYs6ZJ4HNnN106TG06GQ/2EC4gcehdN2Xl2Omn
         IfmxZD6iRWgQcwFwnczSrynP7fwr1BN/Xt90PyW/E8n0lbN+OCUlqo9LcrbOQUZ0Bkxj
         7KHNzw/VNst/IVD2iU7NE+4IWM1mA8NFrinqw3ZyiMlUKOHoDM+P/YJ1a6b+2Arv3DOT
         06zF99l9OcrkuxRT9doE1GDn2PsWR+2r7NY1x9xYNpVE2YxQRQhh7GrQR1O66o+EClsA
         x6bmIHVdLcgAKUYF6TRyrhBv2QdfFs7Jh2OrxdeCllSIrYRNtJEKJ5MnDV37wnU053IN
         i7nQ==
X-Gm-Message-State: AOJu0Yw5psMRWgx7UyOcqNBgt/GBO0bVNlNBxzbx/7zbO/Ac1XQg1FOn
	XC2OPt9UN5IyssYu2luVolXGEkXQ7+Du+IOjho+qed03gjgfGYj1FMStUPpqH5zOVnNW6nm1VIC
	Npfw+EC9lMRKk6YfR2vnpWhzcXw==
X-Google-Smtp-Source: AGHT+IGAKzorqUO7KM6w0kCd0fW1T3BTYIAaoXLiOL6bdIJjPVaOeVOw7PBDbcS6YgXs/sfyKhCVrm1lsVDrFiQhx3c=
X-Received: from pgbdr6.prod.google.com ([2002:a05:6a02:fc6:b0:ad5:b05:9f90])
 (user=ndesaulniers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da3:b0:1e1:a716:3157 with SMTP id adf61e73a8af0-1ee5c73b656mr1172787637.17.1739308888098;
 Tue, 11 Feb 2025 13:21:28 -0800 (PST)
Date: Tue, 11 Feb 2025 13:21:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250211212117.3195265-1-ndesaulniers@google.com>
Subject: [PATCH] mailmap: update my entry
From: Nick Desaulniers <ndesaulniers@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Pre-sharing some proof of secrets for updating this in the future.
0fc5fc718f5a76f69579b289aa09aa2b
a4a4b82be4b75bc2c62a54bc8362968810f0e259
f3789570f13e233eb6f92edde2e890257923b2a6893587d9205ee1508a0f3b32


 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ae0adc499f4a..c433f9cb130b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -530,6 +530,7 @@ Nicholas Piggin <npiggin@gmail.com> <npiggin@kernel.dk>
 Nicholas Piggin <npiggin@gmail.com> <npiggin@suse.de>
 Nicholas Piggin <npiggin@gmail.com> <nickpiggin@yahoo.com.au>
 Nicholas Piggin <npiggin@gmail.com> <piggin@cyberone.com.au>
+Nick Desaulniers <nick.desaulniers+lkml@gmail.com> <ndesaulniers@google.com>
 Nicolas Ferre <nicolas.ferre@microchip.com> <nicolas.ferre@atmel.com>
 Nicolas Pitre <nico@fluxnic.net> <nicolas.pitre@linaro.org>
 Nicolas Pitre <nico@fluxnic.net> <nico@linaro.org>
-- 
2.48.1.502.g6dc24dfdaf-goog


