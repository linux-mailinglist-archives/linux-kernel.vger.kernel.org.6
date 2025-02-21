Return-Path: <linux-kernel+bounces-525759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E008A3F488
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DBF422259
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF93207650;
	Fri, 21 Feb 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXZFo0gB"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22932206F08
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141287; cv=none; b=I8ThW7nKI5ttXB9KWtLmHQOX/3nPxFH5jn9rsPzWkIWuupXQ/C2Zt1zXACQyLi08bmoywq/SDW6VjLMu0zp4FOjvGQMlFHJIryORtgoU1O9/lKY5YoONWzGkyMBgR4P2Vos6ANaVcayWxQFAttorXx4kFijYyAgVZ0qdl8hc6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141287; c=relaxed/simple;
	bh=IwlIFw8WztXM2dTZ0OP/NTjSOYWfpYwXsMecMPxuAVg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F2bttOEhzFl/CM3CXUzXBN+FZ9srH9RTUaffIxLAUsZcv4mEY9c1QUQsrhmex4mG0fRJKsNgfaZpFdYDxAH3ateTj3Tk0Zz152aozB++QADHxLtIFvuYI7XyIiiEaPiD3JnXC2UzhL9BaXvfOCKZDE+90DxM33J9FgsN421dJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXZFo0gB; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86718541914so1670246241.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740141283; x=1740746083; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXPNWUVSi/Z3nWA3ki6UAPZZ/B0/QJQLsW5HpgQTzVY=;
        b=RXZFo0gB++K+iqIY7KUUdg4KB4loCNC+s6FK1iUcP7Ky4MJ4kBq7p6HhXJdWBBq1YW
         tOlUGd93YsUBr9pPN76ah8WjPvxCV/Av9a3YMr4FlG0a8aEF8U7SljxT4ItV1kQZxs12
         7r2WqBb865hs+OqBQLoEyT2Ixk1RP+6Q/CgTNSd/rDlZn7NrQTCzBMdgRVpc2HNLLiw4
         WgZA41Jnogs3unbo50U9Wgr/PebxaFLp8M5346NppJbqAnMIIlOZ9USNTjAi5iA6yCR8
         cnKeoELd0lfa6CFla5RnUz5gec6FitJqhcnfVwpkDo2sXF8dtm6r+cIR72Js8fzHRweb
         E7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740141283; x=1740746083;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXPNWUVSi/Z3nWA3ki6UAPZZ/B0/QJQLsW5HpgQTzVY=;
        b=g7+pcK8XD41CwRb8sWQ0WJ+I1xpoMIon8nE194foHyon8pGV7+nZnrwkLOMjd53tnj
         F782Zgn92Ty6jrit+YQU7dKfGpGQ4LzuPaL5/TVXfP8GZJWkJ3UkA+yFWUhml8hkLOyu
         zs9HKl7l9ctch4Qe7Qm6dZ4nbMEK0H6k12e1iEiVdn4PrkWY4xh0QyK4pWZMirWp+1b7
         BCxwvC+GX/0wP6uJVzG0bb2CQkVnZwYh4/nMAqC7CdkQVPxlSYNuy+8RakGHpaq0434o
         jSsHhWS+1776dpZ8BnFmaLTW6be+6b4YCYY+kt7tdj+E2dk7O1bLwgc6xfy4RjUv7OsN
         RiWg==
X-Gm-Message-State: AOJu0Yw+ku6ClXDdhIPecuRUbO7pk6UK2LZ0keqXUgzn5v8Eh8dZSm+F
	w46SntC8QF2vR394KFh3v/wRWARiCEJbkuzxUwUnWd8IrhZ6SZp79f1T9/+dgYt+/SO5ja4GoT7
	1GKMBtQilQ9olyldXV7FQrhuyNCEMUSaUVIA=
X-Gm-Gg: ASbGncuwZVqWIDWl3g9G84+ygTtbhZar0lBuFuH3CYOAR3GTvPLzxq9R6BPyRAhnF30
	jT8dYXefPPyzULHAtLPmItsoGcqjsx+HkpxA9FJt5TTdeYCWwY0E3JVXtn1T1QcpmMpe8XodvHZ
	G+GL06iw==
X-Google-Smtp-Source: AGHT+IEEZLp1aZtBEy9I1Juug1btbuTDFd3UjoAIOF9Ho+vgr8CTUaypZ75uAMNSySBOwJiHwv2T4mFizaorSZJffMI=
X-Received: by 2002:a05:6102:c4d:b0:4bb:c5ad:af1a with SMTP id
 ada2fe7eead31-4be992c1f10mr3917437137.7.1740141283390; Fri, 21 Feb 2025
 04:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 21 Feb 2025 13:34:32 +0100
X-Gm-Features: AWEUYZnSAbx_IgOJs6seecQMKQZVedkfk9dR8ptWZDOJkFrQJsOtUKLBjok_zh0
Message-ID: <CAA85sZvMaUJdPU4FyUN2CSK6ymvNFvym6VX7mM=NXcOnLW7Kyg@mail.gmail.com>
Subject: [6.13.x] vga not reset on boot?
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a Supermicro A2SDi-12C-HLN4F that I use as a firewall...

I was using the remote IPMI iKVM (as in in browser access) to
configure the machine when
i noticed that reboot didn't actually cange, it never updates so the
last thing is says is "rebooting system"
even after several reboots, it just sticks there.

I figured it was a bug in the iKVM but today i connected a monitor,
and it's the same....

It's using:
lspci -vv  -s 05:00.0
05:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED
Graphics Family (rev 30) (prog-if 00 [VGA controller])
DeviceName: ASPEED Video AST2400
Subsystem: Super Micro Computer Inc Device 0969
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 15
IOMMU group: 18
Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=128K]
Region 2: I/O ports at d000 [size=128]
Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
Address: 0000000000000000  Data: 0000

I don't quite know how to debug this or understand how the kernel
could make this happen - i'd assume that the bios post would reset it
but no...

