Return-Path: <linux-kernel+bounces-423135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372089DA34F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A516631F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A310148314;
	Wed, 27 Nov 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gdZQeIuM"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41B77F10
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693583; cv=none; b=Rf7wWh5p3T1Iiq4oiTxG+ewvDlELhM2WuOmFPcmWmxEPjPo2cDSW/xmphvC7wpLISoRSr2q5W3g3N53w1YRZIz0ExozAUJwaXrrrjJbTfjgHkDCZDdPMwaqI3Ywj7Vdi7ApOrDlmcefrtLzIBPHOeHaYyscQTkxKlPztUiYF6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693583; c=relaxed/simple;
	bh=NFub0nakpRsmq3bNjhBqvGXTini1GDnZAkDIKXX8OzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pbDeT49v37j9wZF3LCJ9KoCwYy4pv94KXVmy4rpzfswKgANJMLpAWnOy/1aYeMwvROmKkcYEH6/O/dLg3K5FkGeHyRS7hneWdTToL0146HZd9Umit9Y35vlVcWjYAx6/K5vSuwH8XdVunxA4cF5Xqvcl2p6LB4qbzICb2JW9Xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gdZQeIuM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d4531d1309so36005576d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732693580; x=1733298380; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfnG/mg+dg4mMvgmniivU1lb5hziEpjBC3xCnLCoRuk=;
        b=gdZQeIuMgQD8vrP7FGys56i+dEE8OG7OdgvS6gSbCgKOPu9VTX973eS2tvadi4T1R/
         8981o6wPcUi5fDx7KrR0IDByy6dKG3hDZ6O5JG5KpxizXluD9bkJcqAElajB1d+WMCYL
         9317z0b94fGI5EBfnZQgNA1YDqwDN7r5YCRcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732693580; x=1733298380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfnG/mg+dg4mMvgmniivU1lb5hziEpjBC3xCnLCoRuk=;
        b=joxtPgaA907ns6YrmbNgVXKdOA6STKQChC20u1ZiEj77PbhDRzAs4mKqLUyV3QuZYJ
         Pg32YK53jnPPAxjHlkHUYY1Z3JmV+vO5Sflf8ajG9TLSo8MSo6fOWN7wNQaYBvTXNyPd
         hIj23y8CWEK/5yRUc7HJ+BW6pLs8jOs0DWLYpLJLDu6crU/SohPwTfTzww2DzWmCm6hz
         dOkLrW6ifOJ0Ok4f1Pih8Bp9Auo1lRZR+R6d7tJEvMU0z2UanzFn6bbtHBS6RFMCxwLm
         FJwvll10BNot1qWg0xQAvkSPdCb3omOUqVr4FIakVRpOYTYZLOYGT94D+Y+tlFdpNR27
         iObw==
X-Forwarded-Encrypted: i=1; AJvYcCW3yIn9+uCosDOr1jjgKfvu773mALgkTPuM4ZRkouMoZtfibYlRcugITqzsDdIGpPfw/w084JVYXI1JgTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCXrbLDCXXmP5QNxlJ+c6Y/N8sfKfvIDrrnmxMnZ/6RShAH4f
	XxDkS82SAgawWQH+GdWhulhBf3hSxch+o4Slg52MEL/8mKDl0eJIihyP3GFO3A==
X-Gm-Gg: ASbGncuI56yzezt4TqfVaI7U1YapIs+tXlm+urp4RGqYPFBIsxhfvu00vQ2lEER1Pds
	/jYh+HQSOcvvqEmmUpTnzg4eiUxDI7RDKUXMuAl24lP6RC/3PVpJ1WscUOzf8lbe4m8/kRmlzIa
	LzsZ2zDiU/4YIRHgHOReAluwNiT58+R5KMtLSW4EVZhT55fDNMhTLJzErSNWyKYwFbkMixQ40jg
	I0pO/b3Hfhh/4t3k4WD0bv6fWH61pS558Rx2QEGGsnNyi8QWzLRzH0UcsyyvhD90By7432pxADN
	PeGLtys7kvlu1BasksCpiNWz
X-Google-Smtp-Source: AGHT+IFfysEFAbHgZfaCoTo0H1CGxOVMO96onL+xqWkZS2/t9cNT8T6LeiMB0S6UXRh7Pn4PtadAag==
X-Received: by 2002:ad4:5cc7:0:b0:6d4:85f:ccac with SMTP id 6a1803df08f44-6d864d3eae0mr27270796d6.13.1732693580498;
        Tue, 26 Nov 2024 23:46:20 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a97b1asm63750386d6.40.2024.11.26.23.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:46:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/2] media: uvcvideo: Two fixes for async controls
Date: Wed, 27 Nov 2024 07:46:09 +0000
Message-Id: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHORmcC/x2MywqAIBAAf0X23IKa0ONXooPoVnuxUJJC/Pek4
 zDMFEgUmRLMokCkzInP0EB1Atxhw07IvjFoqY1SesA7O9z4QZve4FC7yRtpVG/9CK25IjX5/5a
 11g8rh5jVXwAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This patchset fixes two bugs with the async controls for the uvc driver.

They were found while implementing the granular PM, but I am sending
them as a separate patches, so they can be reviewed sooner. They fix
real issues in the driver that need to be taken care.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (2):
      media: uvcvideo: Do not set an async control owned by other fh
      media: uvcvideo: Remove dangling pointers

 drivers/media/usb/uvc/uvc_ctrl.c | 44 ++++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  3 +++
 3 files changed, 47 insertions(+), 2 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


