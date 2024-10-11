Return-Path: <linux-kernel+bounces-361760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1FB99ACAD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3341C2377E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98C1CF7DB;
	Fri, 11 Oct 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLTh9q4J"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08878BE5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675155; cv=none; b=UMtBqYPiq8lxKSZHWamhqymU2aB/hideZoXwbIsaigROp16tFs9YYEcI9tNOJD/bKRmdNUfRCEg4WuSjbpNdgporEh8S6OY4lK8GEXih7KeAnc6VgOMwnqPGc+ZD0fiKZKZ/ryndR2bQv9hEuqjFCYXh3wqoJpHJrlfxNtwrNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675155; c=relaxed/simple;
	bh=tgCk3Xe2aBGN1274tXU2mdrX2MWoBWYlMBw/IkjAhL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgpBYs7zYaNSseeorK/lPq85fNslXazbIeDHXnlwmTzaj3Avtt0hgyG8oBfPfNGkOsVIae7A2U+pUWkBcfH1D3QyDarWBzOwtsJh4cPnlmGh39bP4iG4BLGdhbHySuZhBMqX0XYchXPXtL+mutUtZqM3nKa/CSExyYHYHxvW2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLTh9q4J; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso1808687a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728675153; x=1729279953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXNn4Ly4G4neTYf4tTrsbFyNCo3UAgTeY9wRiKE/qto=;
        b=OLTh9q4JLS11DX7HUY1phCd2ruaVsCOwSGIDDP5pgwatDiYA7yIYD1nZXgXMRA918w
         fBhXP8EGr4DgIz0HGlwzqhN72M+Vt4o1u1D2j70Jv6MTxkseeFFZkSQ/ZeHf0F0wKiX7
         17Mgmq2wT4IfOnI08lS7Z2ECKSuRnmQahpDffHGzoAcfyIpsfQbS1J+XTK2I7UMV+tgn
         dNBxz00Ck0YMJcAzffQ/x4kgRPSjQFEAsiVuzJ8DiM0C8WmARddxBsjyQP8xFqh0/kWU
         rUOg+OBr3dXSxcq14wccva/5DrY6TEX8gXzhRKdh65kVjqZdaR8Lupgi87l+E+qkxA74
         n9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675153; x=1729279953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXNn4Ly4G4neTYf4tTrsbFyNCo3UAgTeY9wRiKE/qto=;
        b=DiW68h5ZP7dOyJr30o3vJYteURCfL/QQiMwNrY3ycMs2op+dgcXvyDjI9McZUW/Sxb
         0xLvbqPDW1zz4gcBUTHL8zvZl5nCZL7ZHjWVVJHpYG3hxS7YAArHIw1SzilfzPJBGRTI
         6Yv2iC25dxmB+GfeQKbURIjzvurpD8Ns7YEoWmFAG4g811ejfAXhkE7quGvu0LER32JY
         BdHw2syO1qD2FhZy3oLMCZAGCWpMfDY08i8vTodZFtfR0wK6qhteyVYE5Zsi6PiC9hIH
         Bb5MX8BGM3d3VqYBVrLa/RxBVrxlMz/P+fPJd5N3rDf1IzbuMxqVuVvjN9jgSOX6nJ2T
         2Ycw==
X-Forwarded-Encrypted: i=1; AJvYcCWVO+rMYAipeK1SIPSFUd4BxGEY5q4Noxa402h6NvgCyUzoP0jxgQ9XhuAfGQtcGn780PhRpJJGVfwvhps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvFi9puK1jx7362LuyAqLQCsD37eAN0WfCMaeswstXdmwjBk3H
	kUj0vHiv7hsWhQui8j0Co9Is7uuQe0V1D1rReNm7/5OyfxUuOcsWysV6CyOTV//tWoVAyBm/NT0
	LwFN5LXUutQ9gDNHXWbmnAi1xT+Zbs+KGpwvJENAPMCpNrSi4CtTG
X-Google-Smtp-Source: AGHT+IEq0tPjAJVy9zzh1HUzlSfx1yGwGjXhh4kvHy8ppZ4QEFMmboOCjJSDrwAx4+sjPa8CHPYiNorVcV6F6F0MDd4=
X-Received: by 2002:a17:90b:218c:b0:2e2:b46f:d92a with SMTP id
 98e67ed59e1d1-2e2f0a98b0cmr4063317a91.14.1728675152756; Fri, 11 Oct 2024
 12:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000047eb7e060b652d9a@google.com> <d7b91d4c-8498-49a8-86ad-27eceff18ae2@kernel.dk>
In-Reply-To: <d7b91d4c-8498-49a8-86ad-27eceff18ae2@kernel.dk>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 11 Oct 2024 21:32:20 +0200
Message-ID: <CANp29Y6Zvqt7K9_LWEPQ4X-n1WOJbN0W83wx7a6GRhRFuX_OLw@mail.gmail.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(minus most people and mailing lists)

On Fri, Oct 11, 2024 at 9:20=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On Thu, Nov 30, 2023 at 2:17?PM syzbot <syzbot+ed812ed461471ab17a0c@syzka=
ller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1006f178e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dca1e8655505=
e280
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Ded812ed461471=
ab17a0c
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14ec6e62e=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11964f7ce80=
000
>
> syz test: git://git.kernel.dk/linux btrace-fault

It should begin with a # :)

#syz test: git://git.kernel.dk/linux btrace-fault

--=20
Aleksandr

>
> --
> Jens Axboe
>
> --

