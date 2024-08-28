Return-Path: <linux-kernel+bounces-305607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5114896311D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDF82863F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B651ABEA2;
	Wed, 28 Aug 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2Nyu08R"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742E2868B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874208; cv=none; b=MYsXr+g77j3EhxSFQvo6R0y+SZz+q5kkFG5SCk6Auf4eaHIZFfn5MzbxeqJ6i3Gvq0sITCFYS8xqGJCcERp1OBjZAicTbe10ufnRy8Tpx4f+EkyfY3rthx71jOX1LzsXj3UFOpMckdX6clBBwvuCyAZNC3Gm1v/pEq5A3vYII7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874208; c=relaxed/simple;
	bh=2auXkma/Ja6QypO6V2FHisMzp3Okm9avjUoUNXdgTR0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=t313fOypTQDHJv5klmuMU9BZobIV49q02gBRLXw46ahxcigelNkiJ6Z5/9B4bjDQqwx/HitnXmYYczO8Yoi/Or5xrHrNp9x5e+InmH5g580deb8AggEY5ecvgEgX2K/bdTn2X6wFMEfc+maMEZhZscaZN6R/+c/MeXkDZbCRjoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2Nyu08R; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c0ba23a5abso2922627a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724874205; x=1725479005; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2auXkma/Ja6QypO6V2FHisMzp3Okm9avjUoUNXdgTR0=;
        b=W2Nyu08Rah/kvwaiiH1/pEmWxmnwpsdIadG+2m18kuugpXowDYOv+KxH7bJV+jnOZ7
         qoi7fsrjvvLURVjp0o7kDIRMFPnoWYUrXTr1OoCyWahx1yKGPs6OXEUc852BdUCNvSVf
         TLYBuixCtywWS8AV8JvNryzdkbHMP3DHa6UOCC5/yE9R/MlPiDs9veC70ae2u4a03How
         P5SoNKBjh9kTgD3pAeByQWuLfCGHdkeRbnP5nlqDSCQ4/bzgKgWX7EpR+SFWL//A9+1y
         m3kE7VIuiN2Qq6L9brR+GPf8f69pNzdj0e6/Txiseflr7W4m9nXuXBrfAQThIbxKkPqc
         NwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874205; x=1725479005;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2auXkma/Ja6QypO6V2FHisMzp3Okm9avjUoUNXdgTR0=;
        b=qyfab73Xz5RaF4DVyVJ8GN59KzwsPWilawbb7ugRgKRg6eZ6yd996UpVFuSA9uC0R4
         NGZcVhpFhECVTXRdVMuYmEdheHIiYUJxkjHXTbtGMbUpnOpCx7+RhOisDfA/TtfWhMcm
         SvUWj559uCFJxMjvgUpnltJ4NDP1PeOoI1w89oWohE3mYDCQB/kJUz51tu+MZ0No+d36
         OKW9WNHB39ZnmaXpNH4+0HBua3BhItY7Prr7nvDkVC/Cs62fSoEqtlltSnJ54sB3sH+4
         ppKwI2jijztUrvF8wKk8wjSH8bLodeuAJ/zY9dVs/vYmnhwynZoy9pp3y9lXO2/uq5Kl
         FYXQ==
X-Gm-Message-State: AOJu0Yye8dR1cFXCaMO8y3D50cKOimOrcdokI2Sdv2X7QLVVC57zjz0w
	e4cUlCnlxJIXMPDVTNkluG6KmXniZtalKCeWbdYYvE8WcrqM8fLiPjfMt5L4Ner6WvMgqwGWLtS
	WHJKbMmjqkdsHHImyVHuRBPHV+go0uRGa
X-Google-Smtp-Source: AGHT+IGr3kZMZsI/u+up/JnZ1nFvYIdaqxSeCC8PG1BLbq6oRMm7ZNZmRnhFFTk//JWFVfBp0PgmzjSHWyM6qjstHb0=
X-Received: by 2002:a05:6402:518e:b0:5c0:bba6:860e with SMTP id
 4fb4d7f45d1cf-5c21ed52c4dmr425012a12.18.1724874204519; Wed, 28 Aug 2024
 12:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0K/RgNC+0YHQu9Cw0LIg0KHRgtGA0YPQutC10LLQuNGH?= <strukevich.y@gmail.com>
Date: Wed, 28 Aug 2024 22:43:13 +0300
Message-ID: <CANZCousW-sxBPyRpO-mU2rbH-tq_61qc0z1BShJ5+LPaOQXFhA@mail.gmail.com>
Subject: Random Freezes and Application/System Crashes When Disconnecting
 Charger on ASUS ROG Zephyrus Duo 16 with Kernel 6.10.x
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hardware Information:
Hardware Model: ASUSTeK COMPUTER INC. ROG Zephyrus Duo 16 GX650RX_GX650RX
Memory: 64,0 GiB
Processor: AMD Ryzen=E2=84=A2 9 6900HX with Radeon=E2=84=A2 Graphics =C3=97=
 16
Graphics: NVIDIA GeForce RTX 3080 Ti Laptop GPU
Disk Capacity: 2,0 TB

Software Information:
Firmware Version: GX650RX.319
OS Name: openSUSE Tumbleweed
OS Type: 64-bit
GNOME Version: 46
Windowing System: X11
Kernel Version: Linux 6.10.5-1-default


After updating to linux kernel 6.10.X (all versions from 0 to 5 issue
persists, on both, Ubuntu and SUSE) (btw on Windows everything okay,
so it's not hardware or bios/firmware issue), when disconnecting
charger my laptop starts randomly to freeze output (video/sound
output), making screen blank (black) or reporting SIGV from unknown
service.

This issue could be related to ASUS WMI (MUX chip) or layer for GPU
drivers (btw, issue persists on different version of drivers,
including NOUVEAU/NVIDIA drivers, currently using latest NVIDIA)

Also, it's highly depends on current performance mode of the system
(performance/balanced/power saver)
Power saver -> immediately
Performance -> immediately
Balanced -> from 1 second to ~5 minutes

Also, in balanced mode while charger disconnected, but during this
period when everything works applications randomly crashing (firefox
like example), the same issue observed when using power saver mode
with charger on Also, without charger GDM starts just 50% of the time
when rebooting

