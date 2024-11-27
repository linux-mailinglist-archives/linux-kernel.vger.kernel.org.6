Return-Path: <linux-kernel+bounces-423947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B659DAEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA92F16487B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6D20125E;
	Wed, 27 Nov 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdaDm7BF"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA114F90
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740582; cv=none; b=p/TW0pzwcRNpybApTAL5dbVGtrKDpEyQ8YuHg051wCc2/IPge70GYMpTukCPOF9xPsAG5b8o5Paxt9OzlBhYvyvXGmAOaicQkAdsZxWCHO96gEyGg0ZvijIYF54lFMnHs3resZoc6sbg7t18QGozPehrR6MZyBqwPhheEP5TruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740582; c=relaxed/simple;
	bh=QFyDa/68QwYpj7pl+Mjtnk1JssC3GT00QuuXUu0APR4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UNZDh9B8RY85iDeyoUb0lTiTE9aVcng5I3QG7lsWLXcSIWDqLsm0kztEtt3xWW5KYqEY8+foYb4b/IyKwVah15NnWkc5vTYQF4QQId1fA6otwLV7D+XOJo/7wOmbg2q6egZ6XHqMfD4ZxIlQmkMLTWWeYjx6Hsw6WDnDc/hAVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdaDm7BF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6eeb66727e7so1896577b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732740580; x=1733345380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2AW5yJ4KIbibtsF5qwJxVbTuffKlNF5I0rKiR3i9vh4=;
        b=GdaDm7BFoLufnOE3ktjmjTI6m/89hGEOPdSw6zkOor7u8VBfCB4HUKzFGVP+Rjc5KP
         5B7kIt6hFCZ7BoFaQ55EQLFuQTSqKAvfiloB6aya72P2T30hIUUbvOAz0mgJoUjkwl/3
         /kWXCvIVUbip3WSlI9sH4JAgUduhxOyGlraghfuYFCIlCUOltnxt0VTe+cCENKzzO52b
         /Al71IxOR9hJ/QezuArouK7njR8+zJ4Ep84LO6yKcz5uZuvG8mLHX2/DLydj0Jk0QxOT
         FDwz5IxVxiJmOZMPk5QSx/R6cftDKJEvWRS0eYPHJmbE4VrtqUadDqbpTylyXxxvidHc
         vtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732740580; x=1733345380;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2AW5yJ4KIbibtsF5qwJxVbTuffKlNF5I0rKiR3i9vh4=;
        b=aZ8pNs4LjA7Q1yUmRJpxes+OD8xgCSOAdvXFs+1UfND6y7J8QeXV3TeZAi95etMlV0
         0n78zmeoTbDmmVtPIvOwgf88hH5383r+0x73Tfd50AgiLsaQb0PhT7h8I9/j6ilPu4Ch
         uJ3T2LmE90Mw5k+47wzKQSo56UCMvWwhV3NSPh2w0p9nZX6OiqPZ360V9Z+ar3i8BbU3
         GLzhluKIamlE48h+iTgA+zvj9+gukPgDSKnXVSfG+DdQTfV0jIPXHsPzxcYucQvcEEv4
         4s4L1tFfMNISLn/inWHsecSncsr87h1G7NWS8ceQSqVGtIykbDNk8g2YVLxwv2Bz1lxL
         rerQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsqS7K+Q2U0sB8Lw2HQBwSvnbkOKP3HYi8B03Pz9v1Zq/oU9nLFDiBy0DYsMXJ1EnNkj11Zl862lPmc9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKu/Os919w2BoxwFOaL7fpZczN6YKMRD0tyAZ+PFN6O6AyAhHn
	ido2VD4V/a+pViedO0xgEkf0hPIOUYLM7rUySYvN2xKog29i0puneQRBfJCH/SE+ijYdxfvlLDt
	Pg6Vpv2j6GUzNeQ/5dwxJmByJ7f0QdMiD
X-Gm-Gg: ASbGnctdAyoBijk86Nk8Ws178uoA/hHoB9J1OyRFI8UOm+o1pvCHccCdw8vpjFlZQrv
	5IoJU/m/2aTRxZuW2b/7tAy7zO5MZ7HD2IMjIhk+u
X-Google-Smtp-Source: AGHT+IFKuj4PVa/5XiN66xPsvCV4558YJWHCtHUwL7Ht4D06xdTvBnaK+b5Vfbg/DDVh760KzDUfBjIpc0LeZVZXbG4=
X-Received: by 2002:a05:690c:4b93:b0:6ef:159c:f8a1 with SMTP id
 00721157ae682-6ef37281e23mr53055507b3.37.1732740579723; Wed, 27 Nov 2024
 12:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Julian Orth <ju.orth@gmail.com>
Date: Wed, 27 Nov 2024 21:49:29 +0100
Message-ID: <CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com>
Subject: Regression: mmap rejects shared, read-only mappings of write-sealed memfds
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since around

    5de19506 mm: resolve faulty mmap_region() error path behaviour

mmap rejects shared, read-only mapping of memfds that have a write-seal applied.

Before the commit, the code in mmap_region was

    if (file) {
        vma->vm_file = get_file(file);
        error = mmap_file(file, vma);
        if (error)
            goto unmap_and_free_vma;

        if (vma_is_shared_maywrite(vma)) {
            error = mapping_map_writable(file->f_mapping);

where mmap_file would clear the VM_MAYWRITE flag for write-sealed memfds.

After the commit, the code in mmap_region is simply

    if (file && is_shared_maywrite(vm_flags)) {
        int error = mapping_map_writable(file->f_mapping);

with mmap_file not being called until much later.

This regression seems to have been first released in 6.12 and is still
present on master.

