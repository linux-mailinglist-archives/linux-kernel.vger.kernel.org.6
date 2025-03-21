Return-Path: <linux-kernel+bounces-571989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA00AA6C510
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28D6189A319
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F96231C8D;
	Fri, 21 Mar 2025 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IYYF0198"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384C230BF8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592260; cv=none; b=UIfFmS9W7+tlPue7zL2A1MB2UzvjVk4IZ+MByeODV4blVq3jyaJDAUrFlnCAOqqzWOXcxwJDB/CJVGlHV5CP0TY0wt8xAFq9hHROZCQq7MpRcWEw6quCV3Ze1e1NNEGJq4MBkMo/vaabj3KssE9VNXJD99iUXQVMOe+Z1KPvAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592260; c=relaxed/simple;
	bh=xgEexH4YlzNQooQdAkGITDiRNkQG2ag5mUu5UecmzPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwhMS+Laa4ySYxNPWUN9ncHwV4jgaB1kuxqnQNU0hqR0X3P8LDOgqDyZlFIWBjYjX2LXaN9LJJmX/vvi3641FvndjsarDfccFuQfw7xv0k9h8VXAkgPBNFnOCZI8TZ+oNBaaHj9X+jWnElDbH/cpFxrjo09pecUWBeNu2I+Np/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IYYF0198; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff73032ac0so613168a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742592258; x=1743197058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgEexH4YlzNQooQdAkGITDiRNkQG2ag5mUu5UecmzPo=;
        b=IYYF01985D9yvKCk2MjWBG431+Jzo8ey8cwDWapZo+t/ACvSnefnWLeOQEceH0cZb5
         1GhaKhd6WKFN1VJG8TYbPLRZkQ6ElZlTejKCVp8byI9LIu/hVDfIjNrDZkod4tnT4bB6
         5BeLTa06w71yjAEiHXfd++Ft2sESA87vp+dt/9JD2JeCFsEVveh/9t/JXin7QUQybWRy
         /+XU4I2M9bIzJQ6uPyJgWnVEAZuZegYNJgL3hUtcTZtMXUsbC/xCH14hD/9tgyRchwib
         oY9C88Kjm0GyPhnKxDXYaha9ELJ/G/4VynWHO1RnjW66Xk2CQ1kNIkoX7PIW5DM5fvaQ
         j9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742592258; x=1743197058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgEexH4YlzNQooQdAkGITDiRNkQG2ag5mUu5UecmzPo=;
        b=uad9xq5JNUmRqP/P2MFa8qshWT1aAv+CM2fY/qFfqf7GzB1KBiPwwA1GUJpMpui44e
         gPT301NqkBh1hMSBfTf2y1w/ApwZiS+DQ9YGNXsgYiXxFkilRE4UagJ9Hj1Xen5Hbuai
         WbifCbgn7QZZvfOWAVFmwbUKdbUrKmD0WbEnYsIkbRN4SlChS+0QEzbX0H04JYgRLBz9
         +f42C75dgG088tvWEb2N7MEr4PGdC8aC30XKAlB8dNRZJsUW88V7YCQo4lH7WfH1XfaS
         7irQv0PNYEgHesw8e2T4OA6hr4Te0C10hTf8oFwEAmOGWt4I8EtHhQQnxk2xNDrQ2dOE
         60Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVeoMrTHFNeYfEhRc/tYmIe7+Ts7Zdcfu5NC36oSfLcBn/sTjwWp7svVmslIJSfAhMbIA+D73aqVjQLeM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKu6GoJmZP2mOBWJ5mO/M7PytsKEu7FqgxS8j9IQruVoYbBlZ
	Mw6NtdY8KgbgzMuH64i/TPA1xTYT9iVkw7xKhcWeMwnKPr3UlaxSZbCKhf4qB+gI/xsdblw71KM
	MpFNIDlmBIPc2WXBXU6mwI5tQVEoOCJLqE36IMA==
X-Gm-Gg: ASbGnctZelp7RZKYJp+vW7qErfTVIATjRdclcQ45mjQou+8cp1zB36kOGGJh7Dd08kP
	LXeWMV9H06MXRXA1DpL8CJxaRwwBluyHXOegiOLlh9SInXBoFEdFvOO8gGHQpqA+NzwU4utbH7c
	QHkFlQW3oAaQ7UeXIPdweB8pnm
X-Google-Smtp-Source: AGHT+IEWKjJGtm5ghineH2xwXYNT84KCnqIRLDNZSQSW8P28Btfs8lapQkXp4I96X8icAPuhtpGyDCSg8I4uBIG6u90=
X-Received: by 2002:a17:90b:3a86:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-3030fe6df4bmr2143070a91.2.1742592257499; Fri, 21 Mar 2025
 14:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321184819.3847386-1-csander@purestorage.com> <5588f0fe-c7dc-457f-853a-8687bddd2d36@gmail.com>
In-Reply-To: <5588f0fe-c7dc-457f-853a-8687bddd2d36@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 21 Mar 2025 14:24:06 -0700
X-Gm-Features: AQ5f1JovqdCIrHb51iECUiV7-0VxJPfIpPS2a0CZYqJvx9jgCUTe3TWJ9VOPsBk
Message-ID: <CADUfDZo5qKymN515sFKma1Eua0bUxThM5yr_LeQHR=ahQuS_wg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going async
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 1:23=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 3/21/25 18:48, Caleb Sander Mateos wrote:
> > To use ublk zero copy, an application submits a sequence of io_uring
> > operations:
> > (1) Register a ublk request's buffer into the fixed buffer table
> > (2) Use the fixed buffer in some I/O operation
> > (3) Unregister the buffer from the fixed buffer table
> >
> > The ordering of these operations is critical; if the fixed buffer looku=
p
> > occurs before the register or after the unregister operation, the I/O
> > will fail with EFAULT or even corrupt a different ublk request's buffer=
.
> > It is possible to guarantee the correct order by linking the operations=
,
> > but that adds overhead and doesn't allow multiple I/O operations to
> > execute in parallel using the same ublk request's buffer. Ideally, the
> > application could just submit the register, I/O, and unregister SQEs in
> > the desired order without links and io_uring would ensure the ordering.
> > This mostly works, leveraging the fact that each io_uring SQE is preppe=
d
> > and issued non-blocking in order (barring link, drain, and force-async
> > flags). But it requires the fixed buffer lookup to occur during the
> > initial non-blocking issue.
>
> In other words, leveraging internal details that is not a part
> of the uapi, should never be relied upon by the user and is fragile.
> Any drain request or IOSQE_ASYNC and it'll break, or for any reason
> why it might be desirable to change the behaviour in the future.
>
> Sorry, but no, we absolutely can't have that, it'll be an absolute
> nightmare to maintain as basically every request scheduling decision
> now becomes a part of the uapi.

I thought we discussed this on the ublk zero copy patchset, but I
can't seem to find the email. My recollection is that Jens thought it
was reasonable for userspace to rely on the sequential prep + issue of
each SQE as long as it's not setting any of these flags that affect
their order. (Please correct me if that's not what you remember.)
I don't have a strong opinion about whether or not io_uring should
provide this guarantee, but I was under the impression this had
already been decided. I was just trying to fix the few gaps in this
guarantee, but I'm fine dropping the patches if Jens also feels
userspace shouldn't rely on this io_uring behavior.

>
> There is an api to order requests, if you want to order them you
> either have to use that or do it in user space. In your particular
> case you can try to opportunistically issue them without ordering
> by making sure the reg buffer slot is not reused in the meantime
> and handling request failures.

Yes, I am aware of the other options. Unfortunately, io_uring's linked
operation interface isn't rich enough to express an arbitrary
dependency graph. We have multiple I/O operations operating on the
same ublk request's buffer, so we would either need to link the I/O
operations (which would prevent them from executing in parallel), or
use a separate register/unregister operation for every I/O operation
(which has considerable overhead). We can also wait for the completion
of the I/O operations before submitting the unregister operation, but
that adds latency to the ublk request and requires another
io_uring_enter syscall.

We are using separate registered buffer indices for each ublk request
so at least this scenario doesn't lead to data corruption. And we can
certainly handle the EFAULT when the operation goes asynchronous, but
it would be preferable not to need to do that.

Best,
Caleb

