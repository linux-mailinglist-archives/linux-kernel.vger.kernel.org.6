Return-Path: <linux-kernel+bounces-268005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E66941F43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48661F24885
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A418A6D7;
	Tue, 30 Jul 2024 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GazYpZul"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FD189902;
	Tue, 30 Jul 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363081; cv=none; b=oeGse4E98rIsXemt6XztURp8ROKgC7oQvZrBw7a/zqNmWh9O3yC8WKS0j7d+xH3l/toW9GhNmEerLQvB8IL5dBMj88sOQFaVLkxl5kLwEEdzQ4vthiHjize8RtSjzNMeNyJwAtRulm3wGMohWR1E6cApWY5lfKtQpC18G+xBbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363081; c=relaxed/simple;
	bh=A2wNrw8Y+kVgeuqUhxJzhLBK1f1VJnJJRpFt64QEsOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2b9NmrYQPG1uFkVXWdKfE3M6B0zHnW9/dHeG51KmGHliGWfFGDWeKF71Z1JyYXIVNK3QEfPA46TiHV2HZwJiUlMYkb0xWYyhpLB84T/d0dpU8Knoj9DM6dUr6BMY5Em1VzRHX/CEE3Hx9x8TRzAyRo6+i/dDo3cbBF5UC3obrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GazYpZul; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-71871d5e087so3670179a12.1;
        Tue, 30 Jul 2024 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722363079; x=1722967879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2wNrw8Y+kVgeuqUhxJzhLBK1f1VJnJJRpFt64QEsOQ=;
        b=GazYpZulkpdBvccNJhgnJ5wbLRePQtP1B9wqivzr/Hxj0GVgyuVZtHxKC610fIIeL9
         +/2vO1yGoom8XL3xtUBibmoEqTWi7Z1GrxkWnOc1iDzZ9XEYFRrPmq7BJOd0OZePlCMm
         t8cggCdk8oqFuoleQgH8fqbZoRA1043bir5prdMio6VYXh2YbEx07kZ/yrRB++SBRRxy
         j8OsW0eZBhyLMlHyn7R+RiyhOKllbGpNwO5dUZQrJIV2N0nyIGc6NuZBzSUODKJlV3hO
         +Lwof355pv8ppn+2S1tUpUw62suMqFKwEWAOgglQ4CRcaiikLlKCgOyxWqEmfRSRtrUN
         VppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363079; x=1722967879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2wNrw8Y+kVgeuqUhxJzhLBK1f1VJnJJRpFt64QEsOQ=;
        b=ZZsV+GIjkaNS6bYYSaW/Kt/m/TO6Ic/t6dKz4fYajiSjEb9hsax0LJRsE+jMEvAih4
         sWsIvf8tzEKywGSIQmdwxAZMmU7dFX5tqhTXJzEk6bF/TAAIVBIRYEIYBdhdAjM37Wwl
         Q3qf8ZooO4QZp2zBQSLU6XKOVw/nKhj81bFSR8dnQNUlTuTWiNzLvxt/8Gff1ZsuLAD0
         3dL1jpqCXp7+Rua+IqIRF3fe/K7JMf4IXBRH9MZNTOWPigEqlcUG86YrE9V/zxiWeEFx
         pJP9qKz6r3jEefW/ypa0/o/URhhOVx34Mn/dnXzoWpCyAQ+hSqd13i9iYUsKNP1fQ5FV
         30IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq5k7EiMM0zOdZDdNoHAB3FJilDZUc2SkVaAZ3Di/Kxs6CHUTDCBHVjDObbwmk7h+w3fem4SDNumHXZuSYgP6NTgQGmj11Cf7EZ2xI6mM=
X-Gm-Message-State: AOJu0Yx3npSAGIYfKEyxnf65I0Fd8M2zUHQzPUbvQktfkHWa/xxkxmef
	JwhG7dl2t85Bmu3CL1pI/3nzsCRb8mbd0n0EyKBcZ10x2ZPUmoGRW2aD5rMBzqDBjTxyUHFZfdO
	ARUWQf5TNlemWkX0yNFV4DSnzPdq/8FRf
X-Google-Smtp-Source: AGHT+IFwd250tTkl0bTPif3xPmWM66kiLTPARQdwt5NnueFukV66C5KTa0simy3aXenh0GwQBXTrHqiAPBxugA9JXb4=
X-Received: by 2002:a17:90b:388a:b0:2cd:ba3e:38a5 with SMTP id
 98e67ed59e1d1-2cf7e1facafmr12575997a91.21.1722363079377; Tue, 30 Jul 2024
 11:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
 <fc3e956c-4f0d-4705-8429-2b7c50e335ce@gmail.com> <CANiq72=kAdq4TsCPvMWBwdzngeOst8g2cGzkk1DxM2yW=V4emQ@mail.gmail.com>
 <d85d50d4-3f52-4440-a57a-260d7943179e@gmail.com>
In-Reply-To: <d85d50d4-3f52-4440-a57a-260d7943179e@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jul 2024 20:11:07 +0200
Message-ID: <CANiq72kGx=v3Q4Jpu204ZDQ4_RFuWL-myn_FvC7uAYYMf5uJ6A@mail.gmail.com>
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sven Van Asbroeck <thesven73@gmail.com>, 
	Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:35=E2=80=AFPM Christian Schrefl
<chrisi.schrefl@gmail.com> wrote:
>
> Did you apply it on 6.11-rc1?

Yeah.

> I think that I ran clippy, maybe that changed between 6.10 and 6.11.

It also triggers on top of v6.10-rc1 from a quick test (we had also
this lint or similar even before we were in mainline, I think), but no
worries, it is not a big deal :)

Cheers,
Miguel

