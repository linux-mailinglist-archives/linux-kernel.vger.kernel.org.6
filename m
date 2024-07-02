Return-Path: <linux-kernel+bounces-238331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EDE924862
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2666D1C22D3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7275B1CE09E;
	Tue,  2 Jul 2024 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="ZK/NRk9x"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5B1CB31C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948829; cv=none; b=LtGIbiQ9W/dZRgA/0Q1HxYTRBUq1x8Y4fVCE0HnWOC0GycYlNaibF4sXWxHTi+XDFgZdha4jREP1S5ADkjSzfXRV/xJ0d3MT9x3Ch8zWL7CihtxyZ2/65grGBo1AF0Lj63LimUeOISc25kMjRUMFyYHwIero3iUxPDxtjT5u48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948829; c=relaxed/simple;
	bh=Ci0gli2ukLh8/ILSo+eWaZOd8wcW1O18VpJZfY8QL94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWOndYv+ah0+TfO/osyl6nPFuttRcgEiTZYCf01kz5WoC4n6lj9Eg1ycCYBWnVRHsWc7UU7oWMAxUkyEgm6y5InFQBlxi/tG0KkmGPEU1mz6xV3HJW9p79F9puuBnEapx7um0JJkY7pm/ws+/ScbX7OoCWUPfrKEAxFTDDi89GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=ZK/NRk9x; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a728f74c23dso531261766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1719948826; x=1720553626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o90MU1M/b/P6gLAgLcU5kBVt7H+vMzjULHOqzE6uuKg=;
        b=ZK/NRk9xwgLDWsuP4ke1sWGNkPeTEbdtyIeQKB4Jq4PGcyVQoHjcgMEqqSH0NeKa9h
         ip1kovlgYwfe45pd19Y65a+QDbuX1h5nCMUKvsMt+wJEZ4m4dsYUnHoT4lBio+hVJ7SD
         g5rX7IvM9dMsKP93EhG/013RbLfGDMnNFPAaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719948826; x=1720553626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o90MU1M/b/P6gLAgLcU5kBVt7H+vMzjULHOqzE6uuKg=;
        b=W8XRjxpP7EAet7eNAsR2jmOpFFqpSnXOklVLxV1ZfabC1iy7MhfpsD9TDTtZJmdGl3
         uOPGj/FoCDIM+5HPGzk1xEdkPsYFGBgITc3tsxI5QiOO8pLTXZMJrE+VGQcTulT+OT2N
         /Z8ZvcyeCpgO85xblbqxbKV9bfdUSw3tifYloIzmT52YAj52XZvBABnMBUGMHs0xrP1O
         6vJpnr+TfVljZ773DIvHKzUbJJv7jJA4/tvuwLlJOJuf/QEVNQylb86vUjw+pA5jWkW4
         oojxXEwG0QGs3YUxGdOjbPhpWPABN7tBfgLvk6FdNavA7WBWdPrK8Ls9r10FmLZeXY2t
         Ssxw==
X-Forwarded-Encrypted: i=1; AJvYcCX2/1G330XUOdul4ZzE2NxNqAidZk4PsH7vY9JPLg8ZsvvQQ8MYulbEiBOH3eUzxtIXLoPCh/0/M8PJTUe9yvyX6Rk9GJf1/Ut3MW4P
X-Gm-Message-State: AOJu0YxKpSCXj6ltzCB7ayRFvLK3iffvcTy/8NkXOFSegEoTCgg9mDpn
	2MgICD6SGJd7gDhCyZD87RcCZPzqF79CqUhIXmz/kD18xXDqjFujhDNFdyUkQXcJc9c1PsU7fZm
	DX+uRiKNbM09++orVzaS/bHMLqquB9x8bGRudCg==
X-Google-Smtp-Source: AGHT+IHvAM7qp+KTWeY40Xm9NLrTTMmJpI8aPm7mKiEFCui77t81nUHC4fhUhRsWMDP/GD7jDJ/iJImrI40zN8k7lls=
X-Received: by 2002:a17:907:2cc2:b0:a72:6055:788d with SMTP id
 a640c23a62f3a-a7514452aefmr821593466b.42.1719948825997; Tue, 02 Jul 2024
 12:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628021014.231976-1-avagin@google.com> <171959268390.3862573.835182164274208402.b4-ty@kernel.org>
In-Reply-To: <171959268390.3862573.835182164274208402.b4-ty@kernel.org>
From: Tycho Andersen <tandersen@netflix.com>
Date: Tue, 2 Jul 2024 13:33:34 -0600
Message-ID: <CABp92JBqtJ1Ov3MSKjNZNW94vVKLz4moyBNtj7DqPaG9SjR_ow@mail.gmail.com>
Subject: Re: [PATCH 0/4 v3] seccomp: improve handling of SECCOMP_IOCTL_NOTIF_RECV
To: Kees Cook <kees@kernel.org>
Cc: Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 10:38=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, 28 Jun 2024 02:10:10 +0000, Andrei Vagin wrote:
> > This patch set addresses two problems with the SECCOMP_IOCTL_NOTIF_RECV
> > ioctl:
> > * it doesn't return when the seccomp filter becomes unused (all tasks
> >   have exited).
> > * EPOLLHUP is triggered not when a task exits, but rather when its zomb=
ie
> >   is collected.
> >
> > [...]
>
> Applied to for-next/seccomp, thanks!

A little late to the party, but,

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

