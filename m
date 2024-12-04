Return-Path: <linux-kernel+bounces-431911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A4C9E44F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C721BC262C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C96217F54;
	Wed,  4 Dec 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0qLsgi0"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D6217F56
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333700; cv=none; b=ISX6S7LAMen5Xpg5zHZttxtzM/iASxB+Qrwrd4rNav9Y+PJX/RojogH2urkLG3eTWlbY1VXdDsbsprkQHS4UFn0wkutzsfIQMPB1hco2CoZikSJrC3RlsTejHcnHs4oVyx+qOMjMKY87sMpRvmmUEHSGoWl2jbeL1UAP0L+mic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333700; c=relaxed/simple;
	bh=dlihfuBp2YdmTwP/7phGNNouqWJWqjGdJ8qALliZeIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOh4bxHwNqYLoFVXMTaBhbc8nNm/56G8YXwKFO0mWYotbPtYzGDUdot6f+qKI2Ia5g+PFjHvDUmcj0IktqADJeVfE9P19jGqtzmd1u/mHQJSPE8dcQG8Aimkco8fcB9KrCDergT6AorwrLAvf9He6lFqg3WM2Pzojg5+uOWYVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0qLsgi0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7258bce5289so66677b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733333699; x=1733938499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlihfuBp2YdmTwP/7phGNNouqWJWqjGdJ8qALliZeIY=;
        b=N0qLsgi0Q029EI7QXQLQ8NRybU6WOfneD5UhNYsy0RKlgZ+1XxqRBrtI8QXkqj3IlC
         smbMCVRFzD83cJjbOGFnUivl7R9ux0hZ5d3jnVo9hRE3hEd24CVzQlTqPxbfBGO1TfnU
         r8NVRn7uhschJCYVp6DyvytBCU1ab/kf6PmdBaNmZdgGhxbRzXy6k72ti1d99oWH6/qz
         Nt/E2QOiR3EBkO29GU3IBFt5HRasqMFD8czBUor7siB+AnV5d56l+AOgTNATKDI/1Mse
         Wn9LGzTo1/rwliCCfoH1zhgsoPWSZbAbd84hMJco4wcsM4x01R8drzyOTXmDELQP0YCW
         xalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333699; x=1733938499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlihfuBp2YdmTwP/7phGNNouqWJWqjGdJ8qALliZeIY=;
        b=XkXsgiVZI2whl9LG4p0trxF7xUmo/eGbMRcOa+ty/1/7P3rRBlOcKHYvC4Xg5kYI6E
         a3SIzZFfpXzJPCgNHAtu/uIqQQmp5f0H2Ie+CzG/s2OsBmOYtKMuXHfrDhqyOMGCDPDO
         CqLTLEnR5uvVwT+ZOi5NWfDvQAojDmp9reh6T/yH4PfEB8Y8ynmvCH5xyYsnqiHKWtz7
         C4ec8tBOIRYe2x+GZg+fCP0kwRgqRcLOgAa+RZkPxSjjSZI0AjnjGFdinuowhOZz3h9/
         PNcYcInWPIC89dfBjoRM/Ts+5Va6BYQj2yKO5d8OIrywMSlO8MEr8KKncH5uJiq6etBI
         J4/g==
X-Forwarded-Encrypted: i=1; AJvYcCVRMT7uFynGr0zYIiB4x/2NFA7cLGReHR2Plsmg72YoSVfcQnub9NWfdK93AXQmDtZC0LZR2nHW7AacnNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5CdlV6jdR4TKVaB3oLctv6sXwQlc+HPg6jJ9xMsMYBErtMjY
	VFdShOVvQa8htUqa66itB72Mdm5hCI0hq4VQB4nCgTlcDtDxR2VcZXDHXMXhI0ICwrjp3O1qAtd
	XjxriCqHfZ80evhLUXzofb0kdhWcvo8uZ1tkt
X-Gm-Gg: ASbGncu7+CiTWQJNnzHyxVo5wfB1nu7lHyDKweOLitrOBpuNdRZSesZAZQT3+MP7cta
	RiiFVt6lAs19EaAKgJktFGyQKE8MT/2ZS6VxHfWO4EwvDMTSmwoJ6ds32KpgXYw==
X-Google-Smtp-Source: AGHT+IHRzC2VYGKnvKMJTo0lMqyoXM3QWGse1yWJvWexAnmSFEoDo0s4BM0ZVzAdXpM8Wl3GTl7EyEL7ik5RHAsQBfQ=
X-Received: by 2002:a17:90b:3b4c:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-2ef1cf04837mr7054839a91.27.1733333698535; Wed, 04 Dec 2024
 09:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67253504.050a0220.3c8d68.08e1.GAE@google.com> <67272d83.050a0220.35b515.0198.GAE@google.com>
 <1ce3a220-7f68-4a68-a76c-b37fdf9bfc70@kernel.dk> <CANp29Y5U3oMc3jYkxmnfd_9YYvWK3TwUhAbhA111k57AYRLd+A@mail.gmail.com>
 <9e8ccb61-e77a-4354-a848-81242625658c@kernel.dk>
In-Reply-To: <9e8ccb61-e77a-4354-a848-81242625658c@kernel.dk>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 4 Dec 2024 18:34:47 +0100
Message-ID: <CANp29Y4dWOk3Hk2NJbQSnSE-XoQfCv5vM1FM_FWr5Xbv+d3yFg@mail.gmail.com>
Subject: Re: [syzbot] [io-uring?] general protection fault in io_sqe_buffer_register
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+05c0f12a4d43d656817e@syzkaller.appspotmail.com>, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 6:14=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/4/24 10:11 AM, Aleksandr Nogikh wrote:
> > Hi Jens,
> >
> > Just in case:
> >
> > Syzbot reported this commit as the result of the cause (bug origin)
> > bisection, not as the commit after which the problem was gone. So
> > (unless it actually is a fixing commit) reporting it back via #syz fix
> > is not correct.
>
> The commit got fixed, and hence there isn't a good way to convey this
> to syzbot as far as I can tell. Just marking the updated one as the
> fixer seems to be the best/closest option.
>
> Other option is to mark it as invalid, but that also doesn't seem right.
>
> I'm fine doing whatever to get issues like this closed, but it's not
> an uncommon thing to have a buggy commit that's not upstream yet be
> fixed up and hence not have the issue anymore.

I see. You are right, thanks for the explanation!

There's indeed no better way to convey this at the moment. I've filed
https://github.com/google/syzkaller/issues/5567 to discuss what can be
done.

--=20
Aleksandr

>
> --
> Jens Axboe
>
> --

