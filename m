Return-Path: <linux-kernel+bounces-251593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764389306AF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D061F24014
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3513C90C;
	Sat, 13 Jul 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZbriIsec"
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727741757D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720891239; cv=none; b=beORFpNnKDFYlpHtw0kGhzmoow1NwoaU1X8hi0JL8slzFUlhs9V9bRx8mgyrIZqjWJnihMyfcSZgttmOjdxjRds9nMTHOCkfG1WEN7dG+GOUTXPLegnTrYBulStuGAfk82v7WBko7ItBqC/jB22Bamowo3PvzS6KnAeK0tkPimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720891239; c=relaxed/simple;
	bh=ANQHS9HUmHlYvmKjLH/u/zyALfJtBztdbVB93inesCY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=USQQvQUxAzKv+4ABFIyxn2UmQSif2rBb9bu+lJ4KsAeyAL82DhWbgN4FN4iHfdJ/dXn0kbb5iiLnWAGFPo5+ieW7kWx07BzCGRAQKExY+X5dZwOPH6d3/ZePzatgEN1ga9HwHzSg3kv+H4Rw2D+EKnlzq2AqZs4G4KN/7iH8YwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZbriIsec; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=irhr7zf4fvc5vobsx2qwtpj2my.protonmail; t=1720891228; x=1721150428;
	bh=eJcIiNtsTLDnA2FylVg1vCQcHDpyde2OGog/Rht7LOI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZbriIsectR261a0qO0Pgo+T/m4HnIL6gJjNVJdWrD6UmhU/KdGjR8pIFbC+l96ga+
	 EbHf0GYn2ixPguXYRk4slJj2fS4YqjZmDdAHXeJdsHqSQuY5ZSXFS7PRbZweEl5EOW
	 8rVYKZg6KKLq+/67t1ighCiDPsYrnu0nkNptRXKnquuw8SYioRH/rhJbHAfFAOU4fA
	 h0xOtaucsxkNVidTEpwnfySziOj2YMlPuY4lh3tfkCe9WQxl5k7g7td8OzqyEW4CTc
	 5LKx1V8P4sXkYhZhSUIdc1b1wJoBQYvysQ94qpegMU9BJ9eJo+jd+Ykg1TQ2RY+nNv
	 i3W5G53n4dP6w==
Date: Sat, 13 Jul 2024 17:20:17 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
From: Tj <tj.iam.tj@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "1075713@bugs.debian.org" <1075713@bugs.debian.org>
Subject: Regression: firmware/sysfb.c device path
Message-ID: <lLyvPFC_APGHNfyGNHRpQy5izBikkaTPOpHooZIT3fFAoJPquSI31ZMueA99XTdr8ysir3X7O7IMdc6za-0m79vr_claeparHhoRouVgHOI=@proton.me>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 9cbf234fcfc8491f556759df5cff1f03e8cddffa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The recent commits to add the parent device path broke Debian's kvm based Q=
A workers for testing installer ISOs after a kernel upgrade from v6.8.12 to=
 v6.9.7. For the details:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1075713

It took some time to  track it down since the superficial symptom appeared =
to involve the QXL driver. It turned out however to be the fbdev driver; sp=
ecifically the change in the parent device path in sysfs reported between t=
he two kernels:

6.8.12:=20

/sys/class/graphics/fb0 -> ../../devices/platform/vesa-framebuffer.0/graphi=
cs/fb0

6.9.7:

/sys/class/graphics/fb0 -> ../../devices/pci0000:00/0000:00:01.0/vesa-frame=
buffer.0/graphics/fb0

This breaks xserver-xorg-core's libfbdevhw.so because it differentiates cod=
e-paths based on whether "devices/pci" is matched in the symlink.

See hw/xfree86/fbdevhw/fbdevhw.c::fbdev_open()

https://gitlab.freedesktop.org/xorg/xserver/-/blob/master/hw/xfree86/fbdevh=
w/fbdevhw.c?ref_type=3Dheads#L381

