Return-Path: <linux-kernel+bounces-277687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A694A4BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B0F1F22AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6361D1F67;
	Wed,  7 Aug 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaH0JaAH"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945F61C6899;
	Wed,  7 Aug 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024268; cv=none; b=TS2WFExj3pJooHtGkHaQiaKcZqlc5EpkTMRg7OfdQIikrQpd7/ffYsRPumrCDOWlad5gmXsCmn/8G2EjZAZGMEe9pdm43A38j3bX7qvkO4mpdvjd/ics2OC6sRSdD6GKSF1W8EpCG6C775pD1MLLlGhFRB1XIVw4k+laznagZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024268; c=relaxed/simple;
	bh=x9RrYOQoqM0N/+EXIAcKxOANoIPzAEMXgY3AnYDZ7Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tInMfROiochYOWwUBUfBWRIyD5o69drHewuQ7LnkcOyw7WG5rICOP+oT4uvFXVutYgqFocI2MNuDC4wuJrADAgHg5HMtCl2avNJEVjxa807TDpwCAf+bXHt3lE842m8HlUeNz02vCN/nj+/xY0XZOz+HB7EJFpeJlIP0zl7d/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaH0JaAH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f16767830dso16532741fa.0;
        Wed, 07 Aug 2024 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723024265; x=1723629065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=poExAmqkt64eH1e6VYHoIlA0b9OJ8PRsnpcDsZX2m9Y=;
        b=GaH0JaAHv+fGsB6kyup1PuDxXad3hsm0nFCvy+Bo0hulVs8sSvBe6qPeQdGHHTTO05
         +sXN3RL7Fnr9Mhir0sin3iP3UazshrphKYCeQq5qyX4XfnEaVgtTU2VpGilU9qrzRwER
         AGXS2fs9sNVQIGOysU14iowWlmFSVVmPoULFH6vh3JdupW2J7WyygG/P5zgjWDf+TT79
         AVW+ovMpc5nXnIWYzs2TNoRjXj3+JuZ1aGbWs52htQPO0GDCOTt3PFWyFCMwa3C1hMra
         sSiAY4JXBc5ktzVkl3wT9Tr57svnDZddlf8HBLMYHM5qYT/koD2l3w5oYevxf/Cdu8qH
         ONog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024265; x=1723629065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poExAmqkt64eH1e6VYHoIlA0b9OJ8PRsnpcDsZX2m9Y=;
        b=W9QNAt1hSl/mtCx9ig24NeZsv5dbrxsQQkVJ9x6STFFYJYng6DFU+O3Y9PLDEGa1yM
         H6d7yPmFM9emQ+AFRMHI9Nuog833w0U2Tk2mW493mVI78uHmPcv98zEakeu8pTEuBGr1
         MztfSmyGusLR+PpXxDC29KFavJVRaHD9eY0YPBZ/gUGOqLzWpSqarSZm90CpABMkGP/G
         OWnWsIWrZZ2RnkeuBcu67AdY7uJsU16jJLdI4w9J5il5WTN5Yvv9VLU9NSusGZ/NCppS
         C5Nzu6da4pV4s71gNQ6aqkzypjO0synn+5fPngCnp8uhl2XkLmF4TY3qXilXs37uyjn+
         fLiw==
X-Forwarded-Encrypted: i=1; AJvYcCWsTHoGeuLLNszNRE1GWh1Jcdb7lGpjWAo/285ZfXNcPIblKezQuSLTyII7bpYHKzVg7G9VCG/GVipAmFuLwwXJGL6c87ysduyiDKTe
X-Gm-Message-State: AOJu0YwLGxrWw9WSyCZ+n6n9ic+3uZsbTe2+Rh2WilJY58X0eaoWDTzD
	EdgTEhxB9FQpSHX0bEHhBz7/mSdVC171TKVK3rI2EC7tLJMVRFI8M5hJBA==
X-Google-Smtp-Source: AGHT+IGtRm2MZyxQU5DjwTqC6R1Nmt8+aoLA0OU4Od4FnrlrFk85aBMUFhTKsEthWOj89EVGfQ9R8Q==
X-Received: by 2002:a2e:b04b:0:b0:2f0:1a44:cdea with SMTP id 38308e7fff4ca-2f15aaab091mr108222631fa.26.1723024264260;
        Wed, 07 Aug 2024 02:51:04 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580c546sm21499445e9.40.2024.08.07.02.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:51:03 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] watchdog: Fix spelling mistake in ABI documentation
Date: Wed,  7 Aug 2024 10:51:03 +0100
Message-Id: <20240807095103.4174982-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake, pretimeout_avaialable_governors should
be pretimeout_available_governors. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-watchdog | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
index 94fb74615951..70eabccf0557 100644
--- a/Documentation/ABI/testing/sysfs-class-watchdog
+++ b/Documentation/ABI/testing/sysfs-class-watchdog
@@ -76,7 +76,7 @@ Description:
 		timeout when the pretimeout interrupt is delivered.  Pretimeout
 		is an optional feature.
 
-What:		/sys/class/watchdog/watchdogn/pretimeout_avaialable_governors
+What:		/sys/class/watchdog/watchdogn/pretimeout_available_governors
 Date:		February 2017
 Contact:	Wim Van Sebroeck <wim@iguana.be>
 Description:
-- 
2.39.2


