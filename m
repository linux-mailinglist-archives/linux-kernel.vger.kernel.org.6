Return-Path: <linux-kernel+bounces-360868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3288A99A0C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36C22868B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B1F20FABF;
	Fri, 11 Oct 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+SJNIBG"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761720B1F8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641126; cv=none; b=e727R8v15sr5z1oAySD+PRssr709muPKLvJUhpcwRJuZRZYTI7EAnbf7pg7syae1TCnTcgSYd3IjLd6d7HiYZVqK4uJoBuk3f80UkORT3OfXom5BbUP+H/z2PKoLtSsdF1X/q1Y8ge+MRvRqBVlSJuCA6YWHxzEWzalZtVgkWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641126; c=relaxed/simple;
	bh=mxSkfb+dSeKMdtYfSH9lFfkeg4NpOPOdNydr9hLFKcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZuvAxg5mpSOggBpDw4ZqLtoZTJW6T991iOGfskXzcEnfRitG2nzs+ap2tCuowDXKKcnm/8p2gCNZv99d+X1uNj0XXJjZYoR0rWnIfPD0SvNeLrLrHGSu3d1Dcfj9MPbwYm+PAAWmd2eUQwRk5PxqNVJAKt2vWP6wfCzzjed6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+SJNIBG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso891871a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728641125; x=1729245925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxSkfb+dSeKMdtYfSH9lFfkeg4NpOPOdNydr9hLFKcY=;
        b=A+SJNIBG+maytfX/eHcVJT6mOdUQRgyHkeKY6oJi8EvbMydFMj9H5V91KQFo4JsMZT
         I9qErn7zx+RubaBAjt0PAVqYZ96vwzPm+i0RucN4JNzEWibOTO7Z6+HI6Q1RXlau6ROl
         bkB2C7+jtitzxqYJMA3QHb6QAFG6rCE5bPPUjNtQ+Olq0y76C6xDuBxJ3jsuiSsOOqwI
         uA1ra2Xnuo8ut3QQ1p/Cscu8K6UrjZMHEQaRHRrbb1W3rDmNypuYdY7KByVsVyubAgAA
         7x9UQ/+KusJ5YcOwjn5tY49Lq7OsVsphGeR78QHn/sc1HF0Vl6AdctkuKJp+gkWgqIQg
         KfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641125; x=1729245925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxSkfb+dSeKMdtYfSH9lFfkeg4NpOPOdNydr9hLFKcY=;
        b=DGqGKHIxMS/0otJ0P8trsvTY1tT+fS42CIcc0w5DkLZaY5+vZQtkiMcVB/SMFJrnZr
         GlEEVaPzYPpjbOCJbqrxkuQAW0DX5rAxQ0xsOBWWdTzWnHpcD5smb9YUNtmk+mHS40eX
         aT/GJGzUfv6NB9IdEdh6ghDVN8r/0ZrUYaJr+ItIF2k4bT188W5R+hxDwY0Vhhd2vbyN
         Hnbv07DiVKPOXOcF3OSI5OvyuSBXYIqQqzOo8kyet1si8Cby7MPE6ExMkkkqqcAs+H2s
         hSHtUWPm5v8LKh+W+txtkPJ96dpOdNtd+7cLP1DwWKsUoGJgGZwVSmD1w/MkhmTVHRX4
         b8ng==
X-Forwarded-Encrypted: i=1; AJvYcCWjsZUZVcHZPPY2IBLVXiIFIT0mhQESg0XX6PGv/SC4hqHVp9yHwBB71ZUfI/IBlXcOFn9vVao4HBXpErs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaUsFCbKv7Aq751A2wvTFuJ9Tw2uRaeRLrs3ZB19zJx4WeALr
	MluXIf0Gos5nQPEJXUXldW05SaIg0hK8qx1GUKWOFnj+JYEbo89A+EBZCWv4/c/UdoFmwfS33Ww
	SM6ccBB5Af6jyQKHRWVvQRwii3EXWh33kiS/r
X-Google-Smtp-Source: AGHT+IGqT6CGYvtVs012J8Iqe+cx/RkHVOC/5K05DSnZykZN0WrAs6e9bNfrp9WhXtWF1tZIpzf0cxt1al2+qQ6jjyE=
X-Received: by 2002:a17:90a:4749:b0:2e0:89f2:f60c with SMTP id
 98e67ed59e1d1-2e2f0aebd8cmr3477663a91.11.1728641124382; Fri, 11 Oct 2024
 03:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6704d667.050a0220.1e4d62.0082.GAE@google.com> <5e42fd02-1470-4e4e-892b-edefd32fbc5a@redhat.com>
In-Reply-To: <5e42fd02-1470-4e4e-892b-edefd32fbc5a@redhat.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 11 Oct 2024 12:05:10 +0200
Message-ID: <CANp29Y5VG=yj1yFgQ+Co_1E+On_F8147s727ynKyuJXoaRQG3w@mail.gmail.com>
Subject: Re: [syzbot] [mm?] linux-next test error: kernel BUG in folio_add_new_anon_rmap
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+619c487ed60780dab217@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-next@vger.kernel.org, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Oct 8, 2024 at 3:11=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.10.24 08:51, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
< ... >
> >
>
> #syz fix: mm-add-pageanonnotksm-fix

Just curious: this is not the commit title that will be preserved when
the commit reaches the torvalds tree, right?

Syzbot uses commit titles to track which fuzzed kernel trees have
received each bug fix, so in this case the bot will become very
confused. If the final title is known, it's better to use that in the
syz fix command.

Thanks,
Aleksandr

>
>
> --
> Cheers,
>
> David / dhildenb
>

