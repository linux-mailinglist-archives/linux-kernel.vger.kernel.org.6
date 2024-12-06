Return-Path: <linux-kernel+bounces-435753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F969E7BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26946283FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38C11F9EC6;
	Fri,  6 Dec 2024 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIznDt0F"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C622C6C3;
	Fri,  6 Dec 2024 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524958; cv=none; b=idj3W4mRVSWVGgRMtDSgCFbtNGcLQHCuqDEIFaCrgOmEJOpphT2fkhmz9Lu+QxvYU/bVfTktBDbQna0TGLVDiyrTJbjtONr9Conq/1iG4CnLMnz9BPLHso2LYDf2iejl/8dx2nankOVcdAnFRVIq5HsdL4BuiDklPDZ0p9fdSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524958; c=relaxed/simple;
	bh=M2pQrx0Zxdfzn5dIXjJR2h2zCQni1Hrbon2Xgsz3qpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah8/aLzR74RabAnXHLVStG/0frnee0LoXUVxW7P+QoxwHegfD6VD19Me9OVbSrYx+YO7z5EIrKm7BMKCgsPwq9XzI8W6jmJpdwnxQpKwR9cD7E45NDY5iny7h51wtt/NWsXbQjjSK9NhaY8SxB8dcjOeqHSF2b6utacCrQxvfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIznDt0F; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef6ee55225so137100a91.0;
        Fri, 06 Dec 2024 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733524956; x=1734129756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsnbuIPYfeBdRy1SDZEK7y34MrfhKqG3TLLpG8cZXiQ=;
        b=KIznDt0FAxVoDyjnHU1eOmEKpsWR5Tozwc4Fh2ewT3bvAYYHyf3AfNmmFlD6Z/88Or
         vAUuO+8M114PM+c8cfoxo2JHg3iis4lcrRerQdn7GlnqG+FQVWkoxDAuTaBKYJRJ8KPa
         HMW9p5u3ZZWlImCzY23XhiqQVPCA2HpcI2HuDP1qdNVAAB6pB6jqlOdOg8sWuOf/Y5f+
         XwIreVEOFBO27PgyUtMIFsDr1724PxE4reDzZ3qgut+9oosz3/oSSGJdJeT7Hki65NlG
         lC+x6sJbY9AS6hAh8l0YE0zt8uzLl14U0BAbpVS75gcKTvGiM+l/ODC8XW/kRI3969eA
         SQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733524956; x=1734129756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsnbuIPYfeBdRy1SDZEK7y34MrfhKqG3TLLpG8cZXiQ=;
        b=DvyL/t6YFhEOP4ovFK0Bq0uT0bXDVQSd5TGA291yz3wcG1U7enbOOzyDOgI7ZBh2eu
         ERNFxSyp0DgcdyXsjZIEOq1/79HbQ7+a9U9pUsHlcKeCpz0UaLlUKoSBHTn88/cPTOJf
         lG/rOxJ+3Qn335L+FqropS0wnj+x3YxbD7Fqppi0nJouvibG76r86CDGBdoprsPfYR3U
         NGo9dVrvSVwH5olN3tKhpJmUKCBS9v7S/q+9WI+6H4tiUcJYWqgujG+ibxwIiD1aAKXY
         w/R25Q8jbQz9SumqfPcrdw9muujwd8BBmM3DqnwKPSOaHeOjqDEYOsosr/N+XdTMn8Je
         5A+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtUb5TXni5tHNY1U1PNaIfDI+wkYYmtfneutYP/1ut6k49mzQpUd7fR6xBbm5DFh1oMOzkUiuVr+GGLOlRWmc=@vger.kernel.org, AJvYcCWWWBwuIEKbnDkHAe6/PK1dAvZ0VDlgkZKQNLkWzAy5LqCuXCUZ2n6I9YoHhxAvNQO6XxroSOCzN7WybaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnU3q3FO8oakoU2tjyNWYQA5gTPD538aeXNLPzQOdEiwXDaQe
	MXJ4PBrcq9OGZP3wuD9nzfzjgvkXZckEIAbCwGW8WdvkpJSo+L6TlbNDgmggpUlS/Aip13llby9
	V+0Vohd7izic12r/lMikklEDooHA=
X-Gm-Gg: ASbGnctsfW8eatXUtxJLlbDY4CpFoyTNpfLpbOCGpGHmygW8IXkVEZ3qs8Snll0Bfo0
	Nlw4CswKC2g3LuHiJzzXwo7C8YPKBFCg=
X-Google-Smtp-Source: AGHT+IH+7qgcaJhI7tLEith6fGepZEdgrwl1mT/d6IlaO4lR2WvUrJl4izuR/DxUXvND5D+aDPteyWPEwlqOYk387cY=
X-Received: by 2002:a17:90b:38cd:b0:2ea:c2d3:a079 with SMTP id
 98e67ed59e1d1-2ef69949ac6mr2675447a91.3.1733524956383; Fri, 06 Dec 2024
 14:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com>
 <20241206211905.444952-1-trintaeoitogc@gmail.com>
In-Reply-To: <20241206211905.444952-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Dec 2024 23:42:24 +0100
Message-ID: <CANiq72mH+t0-4Vz1O2dXts8rUzkW9XT2enz+KERbuXe+SokvCg@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: add authors
To: guilherme giacomo simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	fujita.tomonori@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, tahbertschinger@gmail.com, 
	tmgross@umich.edu, walmeida@microsoft.com, wcampbell1995@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:19=E2=80=AFPM guilherme giacomo simoes
<trintaeoitogc@gmail.com> wrote:
>
> And how in the first option I would need found all modules that have the =
author
> tags and I would need change the code (from `author: "author"` to `author=
:
> ["author"])`, I was think that is the best don't change in a thing that i=
s
> already work well.

I understand what you mean, but changing a few existing lines here and
there is fine. There aren't that many modules out there. If we are
going to change this, then the best time is now. Backporting should
not be too bad either.

In any case, in general, I would focus in deciding what we want to end
up with, and then we can discuss how to get there (assuming there was
a problem getting there).

> - Accepting several "author" fields and append them all into a list.
> because in the modules the developers would need a several author field i=
f the
> module is development for several author. And the module! macro would gro=
w a lot.
> Like:
>   author: guilherme,
>   author: miguel,
>   author: another_poor_developer,
>   ....

Sorry, I am not sure I understand what you mean. Yes, the idea of this
option is to repeat one line per author, but that is not a big deal: C
modules do that already.

> I make this change because, the for() would need repeat for the alias and=
 for
> the authors and for avoid unnecessary code repetition I create the
> emit_arr_str() function.

In general, it is best to mention it in the commit message or, even
better, do the cleanup in another patch. Having said that, I am not
sure I would introduce the function -- we are not really saving lines
and it is yet one more function to read.

Thanks!

Cheers,
Miguel

