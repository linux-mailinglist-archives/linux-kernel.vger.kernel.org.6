Return-Path: <linux-kernel+bounces-288588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B9953C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0E81C241BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF500154BFE;
	Thu, 15 Aug 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBD/ahOG"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFDB14A097
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754908; cv=none; b=SBStQWJ5eOt7D2wcrMBDiWgRyb/mtWVyZDAZ1LZt78dGfK6s+v5xrLebMeag2FcgZ2xZ0akIRzwa8K7g9uTkA+JER83nkuIhHA+5rcdLM5BA5t4NSU7csLiWI1GhqopOLQBM99s9xY4sTwiTf3qpXeFcgWhYrptNdn56WY+Sfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754908; c=relaxed/simple;
	bh=UWFk8iT+QX+XvTdHdEEQEkz3sro4r7bOKwiITHQ68Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A38FXBCIJOx5ENKK1e2p3D0zf62H6ttGm1SPM+YtWKcP+dUhWUsZKspmxR7891b6pJZbsHNsoqPk1dnl7Dyw7J3mTlbHEkqpfd7gL5WpwqFWQpbyXLA2eKsibL7Sgwt7uEtdZSGKTExjGOMEn4gX0hwM/4IqNaMrkpQ/WOyu7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBD/ahOG; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84300e0ed69so235919241.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723754905; x=1724359705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWFk8iT+QX+XvTdHdEEQEkz3sro4r7bOKwiITHQ68Hw=;
        b=OBD/ahOGj+5fGqX/GCCCQTfdWEAnUgKQKT+Sd6w5eEB5nZlXJPqXRIam8j+7yKPx4n
         njES9omzgf5ihdA3NriJLGOvoD3AwFU3f5pRDs9b2rJbRCdLf1oRF0LsT1L8X/wAqc38
         tNMFnuS7Xrj5AaoMtcFLHg7frtJ+TsFmNFfzE8vDong1Yd5lWegJpnZcZqNN0qnqRDMg
         da7etcpFhJcOSQtOWfyHstSvvoitNTd8/q5LsWs/XeDhf2o9YXM4VkhwfeJKopLpy8GK
         tZPatHH4sIs82lEiY1UAotnrMr/swjB0dbC4R5XmTWZ6ldr7RkdZ1HtYcZaOqG5JbLsb
         zREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723754905; x=1724359705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWFk8iT+QX+XvTdHdEEQEkz3sro4r7bOKwiITHQ68Hw=;
        b=D5wOtfyAQMlKox1WkxwVqEIYUCtIimVkXA0+LCMjkdSO9SrnpZSdM4kTmlTfR03nic
         UwIsjnKlS5aSlSOIzwFNrbCCDA648dJSwt8XwP5eAnVLTb/BhvMy/IesPpeBoiRbfxUL
         C76QOk8M1wF/MHpz/s9bH+ljEva5Ok5eUxSw5zhfpZiFalR3vuHFunq+K7B4tS766B6x
         KwU9EtOFcrOn++zUdHoTYK5bh7qMZbDRPMU0gdV1WLHCKLqOWH18D2xNyzAofa/SCQMx
         vLq7bMZwN2HKunthahnltWi0RmwwU48ZWDF8z2v3bw8E4SjkYSg03GO90CuA/VUfvwI+
         G/XA==
X-Forwarded-Encrypted: i=1; AJvYcCWCO35HEyClO5bRjFZMfPUseDLFEd3neWTDWcpqg7rc9/Pg9v4T5SBb/SurgS5YVoKpUU9kHt1gNAaC2AynuHADZme9MEv90hH+AeTk
X-Gm-Message-State: AOJu0Yx4YOlD5qhWz8JyKQv6OTODWEyMq/saC+4arMUXqa24fyfylIgp
	hb/rbzDPNkXxLlFobMs/XaoHcNwWeg6Yt3sGIGP/IlihD76v7tdncVfN3Vu1cxZyu6ci5lykYQk
	dRYs3S75DLP+r+6VMiGkbEpXmx17g0RxpHX4y
X-Google-Smtp-Source: AGHT+IGVnfhBG4W19/FTRIrb1hsBS75Egz6aKroeRS9ZT/fPOBGhFknbNSjR/FE1Ln68gXD8vpeEUMfZUXOrDt+XP5Q=
X-Received: by 2002:a05:6102:f12:b0:492:773e:a362 with SMTP id
 ada2fe7eead31-4977999b09cmr1311619137.25.1723754905259; Thu, 15 Aug 2024
 13:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com> <CA+icZUUdevE_n4+PgwisFdpxz=7XwaMciVKn+XnDHo-=UqRZ7A@mail.gmail.com>
In-Reply-To: <CA+icZUUdevE_n4+PgwisFdpxz=7XwaMciVKn+XnDHo-=UqRZ7A@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 15 Aug 2024 20:47:49 +0000
Message-ID: <CABCJKueVBE0oZuvsDGy-etK-LcK5p5RJg_CQJQnPQ8MuMpGyEg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Implement DWARF modversions
To: sedat.dilek@gmail.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sedat,

On Thu, Aug 15, 2024 at 8:14=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> so this work is on top of Linux v6.11-rc3

Correct. git format-patch also adds the base commit to the end of the
cover letter.

> can you tag it as gendwarfksyms-v2?

Sure. Here you go:

https://github.com/samitolvanen/linux/commits/gendwarfksyms-v2/

Thanks for taking a look!

Sami

