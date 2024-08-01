Return-Path: <linux-kernel+bounces-271327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A075A944CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8441C2575D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBC91A7F70;
	Thu,  1 Aug 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqLiinCY"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD261A71F0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517888; cv=none; b=MDRc/yb4XcgFFDCU8ekqS37XAKYW9ggwQucjG1JjPeZVf571pOnVGsjvdPLRzvQCJ0NbYPyQMgg15KjtCU+00O5eQCpX+dSTiBbo2sW+lju9CwOioowQ77qHg6ryWNeLm4jaMHeYUaSun/HKmxv1AUmlq8bEsO60GfTmDXjLee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517888; c=relaxed/simple;
	bh=2b116E7FQ+pAYtecWSCYXvLNIyOFl3/kX7mBS1bwNII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/7IV5seVYKELDYItbVpNFgh2gBH+0ED571LSKvAiokch0LU9qGpCc3CVPI/W6F1dzgzOnc61/nerfRMBqIH5D3kUYc/CAPK2+dtteIn7M6/SP1OfvOd7siJWEuv4uwC5r6rf3vy9b0LSL96exUqsmS4PL9CmxZS2766ejnrMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqLiinCY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso33260a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722517885; x=1723122685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b116E7FQ+pAYtecWSCYXvLNIyOFl3/kX7mBS1bwNII=;
        b=vqLiinCYmYef02cBcAP6W1PYTAb/pziOpZKmvsHyM29athqMTPncZ6L6y2BXKWjIs0
         dcF51p4ZcZO3WCODIxVAk7BKVQJmURDdj36qV+KG/74n4mtu3JBq17U9FejQ7MT8yuyJ
         gBJT4fiuEPfb/uGsWUXRkml2grV+q5pEBBioe8fEEWLfeyjZk2CJkfnEoRWoBzm2NSFt
         4IN+OGzD9K7NBzLeAmJII3oj2qPAbgBlMq3kbZk0RqxO4tlUWbN9nkE2by7nqLmYJpwT
         yNFPRRGdH4WVb+LYF/+wk1s9zp2MdP4wRyH/ypGdxfxdaZJQzA4ZY4Hl5NYprZYFYofP
         lZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517885; x=1723122685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2b116E7FQ+pAYtecWSCYXvLNIyOFl3/kX7mBS1bwNII=;
        b=t5WkbqDmGG0nFXjbmCpPmACwtoP5dJuC7p9iIkxpqNVznnh6tyTD/4Tm370In2h/FE
         8EMUXFM7ryI+4K3pD3o+xKFwbirWWzPLXKrYYoOsdmPVjfiYEygk2za0ULdHhL3vH/3h
         SkUaPOFOLGpmgPzc8vfQPNEsv69z+oS36+WiaznrEMp0g2pZFa4AOCnatOs7uK3ruUYI
         WFsdFZD4C+N0dzis+grxeYCMuB5tf71sKCnmovWbnRveXwXrolz9g0neUJ1AP7kMweEq
         VwC614qXNDE9FbpibJfmAHEbBu1chOhW6YUVBf9imy9RRl5J9ZSr+rSQ65Mhw2bOJAPF
         74ag==
X-Forwarded-Encrypted: i=1; AJvYcCVYggfGsqrdZkVnr4OT2F3mVkmH5MpkdP+MLuEu6QSvRwrnP26hTqv0UtIfMkgRgEpBWgu/kPpOq160dHb1X4A7FM8LrbUdkh4rymIT
X-Gm-Message-State: AOJu0YzyjqaGx60IFMhn+U1bTnpTmkVK0eDAX4Tny38HekNeHJBtEoTP
	wE6KrQQXuzDilgfG8t3NA1vYNBVlILl9iNpNY51xhZ1rbMMbG2nXT1n+6v53QwheWSOIPoekZsl
	/PcIxi/NjQiDBHZ1gWwsHdVAW2ANj5CxWwaSq
X-Google-Smtp-Source: AGHT+IFevpRTlLOOrxC7yYbYRP1h87dcMwd4qr7VYtyfCAC11NtmKHVzp6yAK3m/U10SuH9s2y0P0OAqji9bRa412L8=
X-Received: by 2002:a05:6402:35c7:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5b740c8fc80mr81171a12.7.1722517884631; Thu, 01 Aug 2024
 06:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me>
In-Reply-To: <20240801111611.84743-1-kuro@kuroa.me>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 15:11:10 +0200
Message-ID: <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>, Lorenzo Colitti <lorenzo@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrote:
>
> We have some problem closing zero-window fin-wait-1 tcp sockets in our
> environment. This patch come from the investigation.
>
> Previously tcp_abort only sends out reset and calls tcp_done when the
> socket is not SOCK_DEAD aka. orphan. For orphan socket, it will only
> purging the write queue, but not close the socket and left it to the
> timer.
>
> While purging the write queue, tp->packets_out and sk->sk_write_queue
> is cleared along the way. However tcp_retransmit_timer have early
> return based on !tp->packets_out and tcp_probe_timer have early
> return based on !sk->sk_write_queue.
>
> This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> and socket not being killed by the timers. Converting a zero-windowed
> orphan to a forever orphan.
>
> This patch removes the SOCK_DEAD check in tcp_abort, making it send
> reset to peer and close the socket accordingly. Preventing the
> timer-less orphan from happening.
>
> Fixes: e05836ac07c7 ("tcp: purge write queue upon aborting the connection=
")
> Fixes: bffd168c3fc5 ("tcp: clear tp->packets_out when purging write queue=
")
> Signed-off-by: Xueming Feng <kuro@kuroa.me>

This seems legit, but are you sure these two blamed commits added this bug =
?

Even before them, we should have called tcp_done() right away, instead
of waiting for a (possibly long) timer to complete the job.

This might be important when killing millions of sockets on a busy server.

CC Lorenzo

Lorenzo, do you recall why your patch was testing the SOCK_DEAD flag ?

Thanks.

