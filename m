Return-Path: <linux-kernel+bounces-307644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795E89650B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E6A1F24A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479BB1BAECF;
	Thu, 29 Aug 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpK0YSf0"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C661B652E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963009; cv=none; b=uWCc+UHe8co1JrnttkURIKLQY/vIjzU4l0/Ld469slonrGjom2xG/rWYrmsBukNj3USa+lcJh88wvlLfG0TDEpjuk7h9LLOA37cTtwv0RkFMfM/NqnQKd4ME1agR00unwi9519JBR4h9ilLYZXPmdEMhX3dUpoGersC8DN9v7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963009; c=relaxed/simple;
	bh=Iv0nram+hMde9A6+V/Nhy4IAnUZ/iQZXPvpsf4ATybU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tigpnYquLaaOcsFNZZdgb3lbE0ceBNacjewosnT6vdwCaKD2jvZrzZSS5CCA/qBIGuclpnZC7MkVdXxVIGYSfZHwx0W3w5eDcqt8BUMa8gOPT1ehkrkis/PclgYUQ1mtwL7rP5YtKCRM+ghRwqJ+RaLQhYtMETsb7WKRFZ6UFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpK0YSf0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-202018541afso13055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724963007; x=1725567807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iv0nram+hMde9A6+V/Nhy4IAnUZ/iQZXPvpsf4ATybU=;
        b=xpK0YSf06ZDts+8Lvjrzs6kse2zAs1odgSbF9n0R7MMxVK5iXnQ/1fEQiX4WWrLrme
         keHJsRhLpXy8sBh2/0DtrYErfWSdFCZRERVpHYiQdKR1aHc+DTVnDVEahVDznJDJQUo6
         c2+FN1h1YXFHJHhtiC0NRoYlMmJUYtkcS9ZHP4Q4ZnJ72mF/3I8MfVHrW6IBe8UAJlkX
         t2RXSO3WAfb8X+dNnVImVk6HSMggS4+ZSpX4ryV93QIkVI0I2BW4CNl/jk1jkVVH6TgC
         hP2orxkg63XkbMhofs5hudJaITMi5K/KtucGRiWqzryOJl3jTXt/DR1SmkA61aam+hVa
         e4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724963007; x=1725567807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iv0nram+hMde9A6+V/Nhy4IAnUZ/iQZXPvpsf4ATybU=;
        b=LP6WkMT0hhjJDcWpiWmOkMbbv155xpiloPD71oSVtsJXMH3K1/k/dyq9mYvnGfx61K
         tW6sOJxrQTrjAz5xmAfPQZaobtITQ4PY5Cn9+IFqUmnxmEOjpnKURlXoWPTBqu3YepJF
         j5lriNxX/CtJZ/ZUgV6+e/c/49rRNHlWK893vKBhmaX2hDUuBKZjLdLG+NJqow6NxTmN
         6IjOP/LpYbYsoa4eYm+OtKSkDuHV1qMl76NHURWt7JRviheNcvcqaRaozGgS49p8dTgF
         xGhaLreY1Sl3DdEHgpUj2qEe846Rw5i6g3JA2Uz42tZIlCvipYhTTHK78cu1zfoWw3+2
         M/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTGP1OmRX6bUwL/orvO5dJ/6W+ZRUBPuqGdjqcJ/ZJpWQx7SOEK/ptj9Al0vnHV+v1nY33YARguXu/Ooo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6W06QAi1aqyNqMLJ/B0ZWCji9Ikns1ycdgJVARX6tiW9v7J83
	JJFxXvfz4LKnCSHpZ1L+eNuQPagHABrCynbmWoUg9/JLDWLQeYJC1CSirlUc4hMwLgX6liGJ3vV
	LbTEmeWq/xXnnhVkpfz5cxG4VSMo2VrsZanaU
X-Google-Smtp-Source: AGHT+IGBH5Hs5IwU/+WhvREPe+6gjLlNZ0hPKyvj2VhSl+HfN9Vj0g5NCglCep91U8aw0jgzQy4XJ/V0IeT07QGzPvw=
X-Received: by 2002:a17:902:e892:b0:201:dc7b:a882 with SMTP id
 d9443c01a7336-20523b3ee98mr651105ad.26.1724963006843; Thu, 29 Aug 2024
 13:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANikGpf0OmGMSkksH_ihW9_yXVAL25xKD4CBy8d1gpKj0inPjQ@mail.gmail.com>
In-Reply-To: <CANikGpf0OmGMSkksH_ihW9_yXVAL25xKD4CBy8d1gpKj0inPjQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 29 Aug 2024 22:22:49 +0200
Message-ID: <CAG48ez3b-FCz7+4MH=CmhbhmSfTT4FTrDAJfbL5UvufRut7ixg@mail.gmail.com>
Subject: Re: BUG: kernel panic: corrupted stack end in worker_thread
To: Juefei Pu <juefei.pu@email.ucr.edu>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:49=E2=80=AFAM Juefei Pu <juefei.pu@email.ucr.edu>=
 wrote:
> Hello,
> We found the following issue using syzkaller on Linux v6.10.
> The PoC generated by Syzkaller can have the kernel panic.
> The full report including the Syzkaller reproducer:
> https://gist.github.com/TomAPU/a96f6ccff8be688eb2870a71ef4d035d
>
> The brief report is below:
>
> Syzkaller hit 'kernel panic: corrupted stack end in worker_thread' bug.
>
> Kernel panic - not syncing: corrupted stack end detected inside scheduler

I assume you're fuzzing without CONFIG_VMAP_STACK? Please make sure to
set CONFIG_VMAP_STACK=3Dy in your kernel config, that will give much
better diagnostics when you hit a stack overrun like this, instead of
causing random corruption and running into the corrupted stack end
detection.

(Note that if you're using KASAN, you have to enable
CONFIG_KASAN_VMALLOC in order for CONFIG_VMAP_STACK to work.)

