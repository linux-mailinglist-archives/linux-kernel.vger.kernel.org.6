Return-Path: <linux-kernel+bounces-397149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58C9BD75E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E68F1C22119
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E30215F63;
	Tue,  5 Nov 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="facS9XCx"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1961FF7A5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840423; cv=none; b=TxHtf/BzTxVoqxkeT/4FoPX9qvOyBW4O6G47dT+i4po8HLNNbYgRqJ9nsk6fgMhEaQ7QT3paJ2CPe4vn4PezhuxXYBeQkTskceI09l4DUEw2DUlopyazSO4MZ75EwZzetjP0nU9xi5mRu5aQmJ8UYpL1cqDT7uOM+8mGn0RuSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840423; c=relaxed/simple;
	bh=MN2ruZ0VOrI2i0kohnHZRuWwCeg2TRdQb6aoQx1dOs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBIXwN8CH4ZbxZgQsbYHtr8FiG9ODBrzFfuALhHgHR1QywTuS5an0NB/NlziV4Hbk+RHrTQw+k7KqkItj7dPm+uQFy4W326j9WaDUNY8zUwIPwKZzm8YFyhhYiHfMqHKjZRN5TiBT+gvlCpcJKe/bn/nlTdU07Ny8HTczSq8PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=facS9XCx; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso55093221fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730840420; x=1731445220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN2ruZ0VOrI2i0kohnHZRuWwCeg2TRdQb6aoQx1dOs4=;
        b=facS9XCxnU62Ysu2QFAsSRYccKrjd8e0okW9XyP+sC5akqAG9LK1ykI6/F0DJOW2S3
         yS4H7AxwG9qMgkYDReZ01pnf+k4I1f70IRh3RJtyjBmDB+7V2qSdip3lkyuii7560l/4
         mn1cf29AiiUbuFqXTe9RyrGdQEX3okrtYvQ3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840420; x=1731445220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN2ruZ0VOrI2i0kohnHZRuWwCeg2TRdQb6aoQx1dOs4=;
        b=LONMlFrhKLxmEu45SCoUO/CKgs/vOc7sdLM5H9lCR5pP1PlwDshsA0obu4axd7CoSF
         xqofDHKjc0xm3+hUfLcwLg9eyw4UkTHmF9uQmmBWGOEESPsE9c72mwiREQQ86W1jZXKg
         SEYrcSmGgizD4nrMWn5fZXweaOEyITE4rsOMRaI3+3scmjihwNAko3tvaw8Kh2lbU/Lb
         ris0dCu6/yXY9ZoA7WlOTRftJOlr+rZQUvpCedWWP86LFc2u0WFE3wxVfQ8gapwb6HFa
         cwxIKzXhw8DxdLA8R71uNcG1efx+AsksRWHMKwEE82+T/1gpxLUfF5aRNrTQAT3OLzsp
         WWow==
X-Forwarded-Encrypted: i=1; AJvYcCV7lLqhvWLUb7+M60TV8yaNw8SEiMw3+DODbp1M2qjxiVp90eWpSbmyVYpC83hfRu6psr2+tPxWZm4yx5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4ckBVNHJw/DDm7+xqf2ldmxyV+66G8rBNrqzI4hFWV3SeiPj
	U0o5gn5vrro9tfE9zsFUSMBNGwfogaKMh7G+YbFuDTEgqEAyQic1xUywQKrkr6QYMrEfFrq0Uco
	pCHNPtk5NhQ92ZivZS0GqDOr9P9wo9U2SXzFU
X-Google-Smtp-Source: AGHT+IEwGFHiCBaTGoA+RhTutEqPmNN7Op7UcTLhRMCVmMlUY3axoyobc/qPEt3uOSIq9yaCFJ6R9bssTX2h26huqb4=
X-Received: by 2002:a05:651c:98d:b0:2f7:53b8:ca57 with SMTP id
 38308e7fff4ca-2fedb790772mr88326231fa.19.1730840419827; Tue, 05 Nov 2024
 13:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031092504.840708-1-dualli@chromium.org> <20241031092504.840708-3-dualli@chromium.org>
 <20241103151554.5fc79ce1@kernel.org> <CANBPYPj4VCYuhOTxPSHBGNtpRyG5wRzuMxRB49eSDXXjrxb7TA@mail.gmail.com>
 <20241104081928.7e383c93@kernel.org> <CANBPYPjo0KKm3JbPk=E8Nuv05i=EeR93PHWjSU8fcH-GVWV94w@mail.gmail.com>
 <20241104184139.3eb03c69@kernel.org>
In-Reply-To: <20241104184139.3eb03c69@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Tue, 5 Nov 2024 13:00:08 -0800
Message-ID: <CANBPYPjq5BC3t-kF2Kcbs4tdCd=Zzd4Qk3mzRg-qyda3tEE3sA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] binder: report txn errors via generic netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com, 
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	cmllamas@google.com, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 6:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 4 Nov 2024 09:12:37 -0800 Li Li wrote:
> > That's why binder genl uses unicast instead of multicast. The administr=
ation
> > process of the OS (Android in this case) always runs before any other u=
ser
> > applications, which registers itself to the kernel binder driver and us=
es it
> > exclusively. With a unified family name, the same userspace admin proce=
ss
> > has access to all binder contexts. With separate family names, each dom=
ain
> > admin process can register itself to the corresponding binder context.
>
> Side note - it'd be useful for my understanding to know what the binder
> families would be. You register them in binderfs_binder_device_create(),
> what creates the devices and how many do we expect?

There are 2 ways to create a new binder device.
1. Provide a list of devices (as strings) in boot cmd;
2. Call an API provided by binderfs in the system init process.

There are 3 domains as mentioned at
https://source.android.com/docs/core/architecture/hidl/binder-ipc#ipc

>
> Back to answering - I don't know why the same process would have to bind
> to all domains. You record which portid is bound to the context, the port=
id
> identifies the socket.
>
> BTW portids can get reused, do you need to do something when the admin
> process dies? To prevent normal user from binding to the same portid?

When the admin process dies, the kernel driver automatically releases the
binder fd and resets the netlink. So a normal user won't be able to bind
to the same portid. The admin process will respawn itself and re-initialize
everything.

>
> > So, do you think the current implementation of registering multiple fam=
ilies
> > with different names acceptable? Or is there a better way to do it? Tha=
nk
> > you very much!
>
> I don't see what having the separate families buys you.
> The genl family ID is added to the netlink message in nlmsg_type.
> That's it, it doesn't do anything else.
> You can add an attribute to the message to carry context->name
> and you'll be able to demux the messages.

You're right. Even though my userspace code uses different sockets to talk
to different binder genl families, the generic netlink socket doesn't enfor=
ce
this. Other apps can still use one socket to talk to different families.

I'll add a new attribute to demux the message, which should be able to achi=
eve
the same functionality.

