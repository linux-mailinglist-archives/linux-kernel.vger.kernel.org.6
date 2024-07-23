Return-Path: <linux-kernel+bounces-259740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB20F939C86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D65A282F30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF44414D28F;
	Tue, 23 Jul 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgiJpQUs"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D014C581
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722978; cv=none; b=qpFm8hdNKDFeav59JiTZIdOYasn5YJNzNtLxiCsbEruwcvba9oCK3A2yEY9HfhvzbY38HT7YE6DMNiYSzKagS3WTUK2U0np8TDE2giZlSr5JnQtdXwDdo9fmJSLIDCOWGa44pb8R0zB149LdwJEyQwjBB+5kYm79CaPLpu+1aAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722978; c=relaxed/simple;
	bh=bULiKcYtzRzlX0GiORBKSEHwonRwDFkZZ43sE1qZNew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Coy1VM9mvvWDNuMzGfAZ4EhiSr0CY7RuvrkztxKT+it48QgsPfp70XYS8gf3rgGItQeudgBnoTj6Z4KfXyGjzIS51EgMIGWlkyKGSVbD3bqQy7pX+sHN+IOvDMZD9vXUEzp8+eNXvzy90MNPtNJEeAn4wjMJA7QT/AOXHHekk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DgiJpQUs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso13111a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722974; x=1722327774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHzffdK1t29wgBUTlrheqQc/1FBrMdd1f0Xh1Fa/cyc=;
        b=DgiJpQUsHE6NgbimQXwzS8asrD0p7Sq1+4Vv+n8V6S7jxPgxatBpA/kMmSYj4TA1IN
         ECVgmajKP2rWl5Ahj6474oRkE5GS/n/e8MTeEp9Xr/n13r+4AqL6r9yczVUS9Ld9FGYg
         XpNFpY4KW1FYAsmr0fXku8FQFgNpLHgIIBmJSJVz/U7/enLukBB/cQZt/0D3xzneD1Gs
         f5Na+E0L2/rTdeCZPkZvXZfAdvxKUlbBeww/lmIqNl+/VRyI2zn/fhcm6W+AMWJVJOeW
         DqeSZc7jwxausTBHA5zRtvHSOcz/w4VxHhnslladpO/qWHZ1KTW+BxoUnBQDiHNEqAPR
         VMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722974; x=1722327774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHzffdK1t29wgBUTlrheqQc/1FBrMdd1f0Xh1Fa/cyc=;
        b=DVUnf+LUgviElYG7+4sBnb14hAvTLBN5ilX9Ek2nZdC6E/RFQQbsLmvKtrSwQ970ZR
         q+af9Ivud/KqWvhkTUXdUSO8QCDg8z2/reRV8eXO6RqQMmJKlMGB2Gp23ieaoimneNWx
         BRQNohnwyDQ+6zcKyndIarpzr3OVkDa9KOwestd9/l8WPt8rq/DmVmexxPhx3txuWR68
         i6jHCAjVokieSAsc6zhxtitOtMlUa5loBxPMMGZNDPUeNMjfZF2Zff/eKxZEudT0VdKd
         BZAoJVz3owseEzjwE0wdq9HBNaQ5nwtwxeo6ilwufX6E6Auff7IKHQnrEIHneaNsP1t0
         8+RA==
X-Forwarded-Encrypted: i=1; AJvYcCUqDlfBMngRijxysHMG43VZAe5NSQnG2NQOotwSfSiEpnHty1ZeJYSe6xSueXl9njdEgpAEDniPTbvRJMakElhsPjWL6wxcv+LLrFEF
X-Gm-Message-State: AOJu0Yw4Zly1/IUbxvVp+Iz90cnIVqOD5zggjqsj78MO//YtrMLxQWAf
	pSzk5bZMECYz3Az+62UwCPFXbbM77n42mIMkruSoVdXB9mDat9UJCK6mlx1qqpmI5Pe2YwPwQ+O
	oP/mg43oGy8UfmCJbASt/9vA6xeCW+szco9YX
X-Google-Smtp-Source: AGHT+IFloeNOLjx98DobvZlaIXggAhKgmTEsQyFXl+zDVn0YHqOhg/R7X7Lh2OPbveWF/8Lg8FOnw+q/voxghpl33uk=
X-Received: by 2002:a05:6402:34d6:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5a4a9300bddmr484291a12.7.1721722974127; Tue, 23 Jul 2024
 01:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <a2f181c3-92d7-4874-b402-50a54b6d289c@redhat.com>
In-Reply-To: <a2f181c3-92d7-4874-b402-50a54b6d289c@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 01:22:40 -0700
Message-ID: <CANn89iJ+sBaa3hbPceGytu+pj6u9z7+YQ_G6eL1S4sYMfPVQmw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp: restrict crossed SYN specific actions to SYN-ACK
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jerry Chu <hkchu@google.com>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:10=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/18/24 12:33, Matthieu Baerts (NGI0) wrote:
> > A recent commit in TCP affects TFO and MPTCP in some cases. The first
> > patch fixes that.
> >
> > The second one applies the same fix to another crossed SYN specific
> > action just before.
> >
> > These two fixes simply restrict what should be done only for crossed SY=
N
> > cases to packets with SYN-ACK flags.
> >
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> > Changes in v2:
> > - Patch 1/2 has a simpler and generic check (Kuniyuki), and an updated
> >    comment.
> > - New patch 2/2: a related fix
> > - Link to v1: https://lore.kernel.org/r/20240716-upstream-net-next-2024=
0716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org
>
> Re-adding Neal for awareness. It would be great if this could go through
> some packetdrill testing,
>

I am back in France, let me see what I can do.

