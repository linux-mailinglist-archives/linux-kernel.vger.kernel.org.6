Return-Path: <linux-kernel+bounces-346245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F998C1AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2CB2817D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EAA1C3314;
	Tue,  1 Oct 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StNZD0E4"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CBA28FF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796767; cv=none; b=Gv/YvQEIAdu9xkG3Ti/Cwp9xAGlbgN5KFJQMYOLUGaq9BxA1ZGlDDfRFR94hdVIFaUpwOm+MYd7NkQH6RtOQT1Pf3nmA7fppJwdBDuOY1/d1I37bXhJ50HW64BvudMKJVSSGJ2ODTsWo7dI/z+3Spuih2AOY4jK/ygaGfWqUFoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796767; c=relaxed/simple;
	bh=TVmST8roP/lOiWwzHqvq4Zq0HdVB6kBRHJui5MusIkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+48iU2qLI0c6K3PJjuGJhl2Aqk44/t/VJJCz5OL6gU6oW1la8zmpjDtTMe4DpyPVTAipUSowb069cz46XVDqYXEDkpAiW1HTOJsJHNywjrw6KnGOovKQDVJYWgxeTaU21WVyTNkc6SdfaQbAEMur9mZHmkrMwd2EKMG2JlVPow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StNZD0E4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718ebb01fd2so827592b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727796765; x=1728401565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVmST8roP/lOiWwzHqvq4Zq0HdVB6kBRHJui5MusIkw=;
        b=StNZD0E4Xv3thNdVjGRlqmWmAjitY646eL9r7LXhjgSP9YaQlk3SKYeccpVxXRv6EO
         2UxQH+yKKRe7Cu+JJuSHjHt4qRy3/xf2sDcH1IDd91zrbQA1kTW3wQ1q87Sjsqd697/W
         YQP2gSMjLPCesLTT8n4rWIwIo1oLHOr4n6OKWwCv5aOwVhjsnIVneVxaWnyLpp1HLCHq
         KbKbX4huy0NBExErrY+ORxFP7Z9xS8KW0uPd1SYCOPHmhO4wtWldevN9kBUwd/DJtuKB
         e70dGohA5VqFw7UNQo0TjejdTMZlsUF+adYSBqMOBXVnpfMX8RIxIMrfA7dbdnRjKbGd
         znoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796765; x=1728401565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVmST8roP/lOiWwzHqvq4Zq0HdVB6kBRHJui5MusIkw=;
        b=QiBL7xDuWwGz0TQjfAT0mdcuMDZhkP/iTMNuQee1HFTSR8lbO8mhVrL4VRaxRUjYE3
         wKLoZ7ZioS8BO/Jzx4CyoVhMXQk7aD8yCiB0PAdfWqvmuXq72ck8kxGDjTDnEWhVp7qE
         rcXo/Ym7p7aGhoj8ki6ct2rtXuNLk0GYTli9kZFrDLUqwoJO/LxxEPxQs4oBhcyh/WMM
         jMh0zetoXcEDPpaBYZGxQolN6Ujx6aow2joD58cgm8+01BZXcjO87x9ZulbwhmUCnbQA
         FKXOHbyX9mf9lZqkbq1NZX3GrZSW6W3zuud2qKuTLxjldXoiszZK4RY+JM0gms5lucDZ
         hm6g==
X-Forwarded-Encrypted: i=1; AJvYcCV16eocE9LG/DLS0gLrpe4CpJMzn14b3DbiQAJsjDwoFAARvHwHcryvgRWJIrJaQM2odSAN2uHUQyCh8Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzJMFdWQVAQVCePQhSM4dUwNN9kYwYeflnIW5hm3C8MCMvjjp
	b8w7HQVQrYQh8UfhqJUcPpinp5CfuI6endfcQPXtAgEAt47IChsuouV9FZbb2Ukm9nxxBCP4d/H
	rjEMTlMqfcRLOFrkRL6KygHGJ8pJqb6YsysU=
X-Google-Smtp-Source: AGHT+IEyjFxzt5lUIxN7DAvyQ63Z2FQCgSbm/uK8/HS35pP1hESTjnggLgTwMcXsG5oZ3yrVlPmAC1tG0aIkiXvGHAY=
X-Received: by 2002:a05:6a21:3381:b0:1cf:2be2:5e5b with SMTP id
 adf61e73a8af0-1d5e2d9e0bdmr104262637.11.1727796765075; Tue, 01 Oct 2024
 08:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
 <CANiq72kqVFs5rfS_y0a40ZAygE5S+vkyb2Fv+B5BNzvuAa_hiQ@mail.gmail.com> <CAMuHMdUwt9_zU_2ytSMOoB1VJqZYwonHTZd-bSzpXxRwj2+XfA@mail.gmail.com>
In-Reply-To: <CAMuHMdUwt9_zU_2ytSMOoB1VJqZYwonHTZd-bSzpXxRwj2+XfA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 17:32:29 +0200
Message-ID: <CANiq72mU8AYmjcwfBww1wXyLW3WOzW2LE-WjwAT_uX0qirfmcQ@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc.h: Disable __retain on gcc-11
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:30=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> I should really update and resend my patch to sync all (different) values=
 and
> ranges spread across the Linux kernel documentation. And didn't we reach
> 2^24 objects in git a while ago, so conflicts are imminent?

Please do so! :)

> What's your definition of "all"? ;-)

That is definitely a nice list -- thanks!

> AFAIK, the gcc-specifics are in compiler-gcc.h...
>
> Fair enough....

Sounds good.

Cheers,
Miguel

