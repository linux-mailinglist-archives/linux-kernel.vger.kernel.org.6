Return-Path: <linux-kernel+bounces-332890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E8397C05C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DFB1C20B67
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C631CA6B4;
	Wed, 18 Sep 2024 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Bt3rhmht"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C61C9DE6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687261; cv=none; b=dNbGUoYIpcFnCR5IIU7QrRDkR2JxM2T4NmzZkx8qIruMVaTGCCTvP9saQYqU5t//gfPVpSmBlMNZpufh17pnCTSqGBKxSh0KT/A8gB9JZo6Y/GgtI+GOlqFHNn20aymPiz0kDwSeZiW2Mz3J+EZWzshlwKPwk+drx8yfgYDlnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687261; c=relaxed/simple;
	bh=GPDnvOQmDNoTNAwAqjIAY1nv5/5exNjJjwrpjZrU4BM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WDonWMNsDEuVwj7vR4lkb87iCccGkdQ+PVEiNBIzGbCU0JBRvFbMhNdOX9Q5cGkugzQ/w3vt7MDwj3CtP2FGg/z1CYfoR9F+E/1wojQfQ4tYLIB5rrHmjmNGg5QFLKJWgdvL06WF68USl8Cl37HH5ab32bKVX5SxjySUCLtA3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Bt3rhmht; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687251; x=1726946451;
	bh=bgCLcn+VxNdyZFA3cXzhIR8niBnzK73a4Fq/ioQ9wrs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Bt3rhmhtIuD+sEH752mHkO3//yY9Gd6rbSxO1dW3hl2qxRXN4JlwG8VxcD7tO4I/V
	 13SYA0xs13y+z15trdjfpBNOSCI8psm8mv8+fWlBvxElLTnh4K++LGkGw3bacp4ANz
	 HdxMZRZaSdkYhYpjmTvJJHP1HF1aIN5FE2QloWaP7iFiN+EvOtKk3mhcGkbZsqwz7b
	 niUjBTtzOjY/7i28A61dNefGfk9mqoJaH2fO7ia3hSTcuTFF0rLBikutQGREMuCZLB
	 lSNwhBdxQYHmH6A/UofZatq3x+8XFzOYjCRL2vmJj9Nm98dBl9Y9oJy5AyZQ6sA3h7
	 uGtGkeCgZuTSg==
Date: Wed, 18 Sep 2024 19:20:44 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 00/14] staging: vt6655: Tidy up s_uGetDataDuration function
Message-ID: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 6e65479baa7c259186c86fbdd43a988ea3d4ba0f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series tidies up s_uGetDataDuration function by renaming its parameter=
s and
variables from camel case (including Hungarian notation) to snake case, and
fixing its declaration formatting.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>

Dominik Karol Pi=C4=85tkowski (14):
  staging: vt6655: s_uGetDataDuration: Rename pDevice parameter
  staging: vt6655: s_uGetDataDuration: Rename byDurType parameter
  staging: vt6655: s_uGetDataDuration: Rename cbFrameLength parameter
  staging: vt6655: s_uGetDataDuration: Rename byPktType parameter
  staging: vt6655: s_uGetDataDuration: Rename wRate parameter
  staging: vt6655: s_uGetDataDuration: Rename bNeedAck parameter
  staging: vt6655: s_uGetDataDuration: Rename uFragIdx parameter
  staging: vt6655: s_uGetDataDuration: Rename cbLastFragmentSize
    parameter
  staging: vt6655: s_uGetDataDuration: Rename uMACfragNum parameter
  staging: vt6655: s_uGetDataDuration: Rename byFBOption parameter
  staging: vt6655: s_uGetDataDuration: Rename bLastFrag variable
  staging: vt6655: s_uGetDataDuration: Rename uAckTime variable
  staging: vt6655: s_uGetDataDuration: Rename uNextPktTime variable
  staging: vt6655: s_uGetDataDuration: Fix declaration formatting

 drivers/staging/vt6655/rxtx.c | 110 ++++++++++++++++------------------
 1 file changed, 53 insertions(+), 57 deletions(-)

--=20
2.34.1



