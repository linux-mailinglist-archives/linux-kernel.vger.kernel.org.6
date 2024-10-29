Return-Path: <linux-kernel+bounces-387253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853BB9B4E90
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151C31F23AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A384195FEA;
	Tue, 29 Oct 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhTJN25g"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2499195B18
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217194; cv=none; b=KPMZoPU/GoRIdTuN30CHB42+przF0sbxzdghjRuECtBKlpsReOU3IidZy3I7g/Rc3hx4CmPoktedMS0lXYU02FCnOC0PZtrSSyNMb5J2sZEwBHnBAoKJ9U4paGHhbinumWba8fIhg47tt8bMAooFzyh6OJvtRo1qt+lppmV/0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217194; c=relaxed/simple;
	bh=Q82MjAAJzY011abIoj9mr3/lCIvynpDz1KuaP8yYE3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx7gsIhv/Gz8w50YPBNn5YQXLpzlxF+bQ09kM5xJFZwBKupBFFGWJn8A4ItRxZXiMXL9g1vuYFUTFXw7KIGTPVOkWBJ1vLBjgV9rkHkmq6PrCLr5h6+ixZi46Rwxe9I325wJb+sneXDa2sf+LLGExhhQQpdd0lC8id3eC/SY3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dhTJN25g; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f2b95775so6509586e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730217191; x=1730821991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ll51C0PllLi1/aohJqQbI6RPBpDmFIRC+GA4ELQxeFw=;
        b=dhTJN25gmGQnWVvbZHc8HZzVc5aEPMmtMNvZJLvBmiFgavwUXcHdgbezBKjI/4x9DT
         1cBxNiLlrLyiJg8N2xdN4TU0WddqxEUkXcw/IHQQCdmuBiL9OzAR2f8lz7kSpN+G9HV6
         FalKknhrBFfMv2+BNq2IuzeXoQPmZ+HjPFu6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217191; x=1730821991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ll51C0PllLi1/aohJqQbI6RPBpDmFIRC+GA4ELQxeFw=;
        b=b6JhHdVEZtyuKkQK/ptOUxEVF7jgb/lHuAU6BN6w3sFaebhjzUH5HUIVjCKueLTxKm
         rlCa9xzG73zVtJer331gqElT9qajPKRGEc4oz7uoXNOW/dzRy8lwSfnBwv8Jyt4ATIoy
         WpbCvQ4k4FYd7TGJqbIfMh9gJE7GCDm20uXQU7TDjyU6tBXay9OGUvrxXycpobdE/kSP
         JGsd3bk9//8IAYFzfJGLeb9NZsAae8AEIU2Wi4Sdn/w/g0O0h0EUNMxdQte1d5DHJb1y
         WdnjI80lqsxT59VF5/DbysUd5Rpihyf+VijrOBlquGwmeKbOwQJuvpNqm+6X9AFo7XPu
         g/0g==
X-Forwarded-Encrypted: i=1; AJvYcCXmMoE77vHsB4YTbHLqgI/HzhH+qI9easgBFinaqr0kGKjXQRqGsBkDgYQeMuYNjFAfG9bQ+tiX3Ccg+9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7FeLCAOhDtHt9XHzVcsKnFVBehD9k7+XpRBbh4p2YkBqKoV+
	fqdtz2tp0ioPV/Ezk7rqyYDw6jqRKvdt8IhoznTL7oRR5dLkKSdAGxQ7TQ1RchmUtindixUfRVP
	uHZ2Tt6PlEOR5oKRpyR5GCRDa2+HRKQYUNU4b
X-Google-Smtp-Source: AGHT+IFq8kVq37MNUAjH9Q6myVE42MB00LVqimrYgoawu+grZEG8upkwKXnNYybcruxqIxH3d1HozSkgBqx+9rgCuS8=
X-Received: by 2002:a05:6512:1256:b0:535:6a34:b8c3 with SMTP id
 2adb3069b0e04-53b348b9fecmr8822368e87.5.1730217190707; Tue, 29 Oct 2024
 08:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028101952.775731-1-dualli@chromium.org> <20241028101952.775731-2-dualli@chromium.org>
 <20241029071437.2381adea@kernel.org>
In-Reply-To: <20241029071437.2381adea@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Tue, 29 Oct 2024 08:52:59 -0700
Message-ID: <CANBPYPiYAVDMeBUNRm8_wJojropMSL00UkGGV1ar+E3Y1STYfA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/1] binder: report txn errors via generic netlink
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

On Tue, Oct 29, 2024 at 7:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 28 Oct 2024 03:19:51 -0700 Li Li wrote:
> > +                     report.err =3D BR_ONEWAY_SPAM_SUSPECT;
> > +                     report.from_pid =3D proc->pid;
> > +                     report.from_tid =3D thread->pid;
> > +                     report.to_pid =3D target_proc ? target_proc->pid =
: 0;
> > +                     report.to_tid =3D target_thread ? target_thread->=
pid : 0;
> > +                     report.reply =3D reply;
> > +                     report.flags =3D tr->flags;
> > +                     report.code =3D tr->code;
> > +                     report.data_size =3D tr->data_size;
> > +                     binder_genl_send_report(context, &report, sizeof(=
report));
>
> Could you break this struct apart into individual attributes?
> Carrying binary structs in netlink has been done historically
> but we moved away from it. It undermines the ability to extend
> the output and do automatic error checking.

Sure!

>
> BTW if you would like to keep using the uapi/linux/android directory
> feel free to add this as the first patch of the series:
> https://github.com/kuba-moo/linux/commit/73fde49060cd89714029ccee5d37dcc3=
7b8291f6

Awesome. Thank you for the patch!

