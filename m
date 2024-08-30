Return-Path: <linux-kernel+bounces-309073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA419665D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC371F23470
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93401BA28B;
	Fri, 30 Aug 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="zfLFKynq"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3941B8EBF
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032248; cv=none; b=lydMZGbQRkHy0+/w75az8CfRcCZeKu5t1M3k+HocqzjkPS7ADVfS+bjQ90KaZauZNEzDWhpNLRvlMhB6BZzomqkCn8EXbUHvLef8Y9DJUe3Gd8Hpp4ZpOSTOX0eWAumFxgOhaehYGL89lLz7PADztwzfhyJc5FY2zIghCof9wDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032248; c=relaxed/simple;
	bh=bIlIxGS4Fkuh9sfbYzRI8/VSht+5Uqa65aoRCnzW4i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6gZt2KMXzTr3/0Ut0MUPdxmlKHZmP/zyJEcMk4xXBWFfx8/LaPVgP1V71v9Xbi0Yl6QMJ+sW5mXLG4qafQ6UttsW7aP08FxqTQw4Gl+J2k2euD7cKPGQ7CvjBlKRBBw/ETyymEBS2lavqnOvJ3arkaa6HMsn+3WRZmpBus797A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=zfLFKynq; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5dca9cc71b2so1121133eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1725032246; x=1725637046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIlIxGS4Fkuh9sfbYzRI8/VSht+5Uqa65aoRCnzW4i4=;
        b=zfLFKynqjU29a2cMs9WcefAmWEjzVlsj0ZkvZ+mslEIwJ6ub+ysM7wzqQfwi+imDTq
         uKELK6zNknTDlboSiWNs7s9lS6Rp6aiFnUsF2q+/KUglTbVKjAfsWfkadfneH4UzDRQZ
         Fn+C8TP2IjkNN1qSOHK7uYIuyn6pdd909al82SeMxu++ZnjsGJimrS9a1FphqVFdr5pL
         I1a0lIi4TLwwJhLC5uUyVXg1wv9czFFHL6jY3c2pCDvj5krAv7Uc3GZYSejvtCl/Ivvr
         QXUCzkYiyhJbh/dfiBnnMO71kx0141kVXeihXWnaP6bec3femOCXQP2NBs0fx/NniLVB
         OEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032246; x=1725637046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIlIxGS4Fkuh9sfbYzRI8/VSht+5Uqa65aoRCnzW4i4=;
        b=eypIcgsPXMRka3gUH/7XrtUp8WE7lmA2S5sb0btcOGRRGdPwLXG0rr/a+m3f/ebgmW
         VvJ7QXe/py8c9in+DCEGe4UfoI8KDaLPi+b2rmQYgxAiac45WC7DpGZ6vmti3vssq5Hb
         rp1bVAs025J84hnsZBuOVj8+WvOFRh4jPas/aEGR839FQPjWF9h2zvc8c96pjfOYgN+0
         2UaUaurxGaNFK5z2Sph2B2BDCLyvVA5/8u/lV/3latLMlP6Mp2oEqGrI6HTZlCZkGw8X
         jf1MhDtfn9om9pov6DeMxm1b7yaTfPyi7RDqem4uYDk+F6QJYfVjrnNMMoMWdfgBpPT4
         J6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5BiBjVVU9Qlgxajqqcv9KIQmFdFZBrNzgawfz91G3KXjQ4bIPG+AxfU4tFc0WYzsXgQ97mQ6LrQSe/70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXMt0c6BPgsU4e9AdAHIv66XOCoJOPZa2oh6Lve2dUjKqrm0J
	MnxQBO9AVy2A0MrDo8F8zOAJLYsuqYZilNthu/hEv2s3u55zddKQobCqidENoqZ0uXDgjAAOM2v
	398vvoR/6JjU4UCij0wPmNcGs9S4BFLVYeLzsBA==
X-Google-Smtp-Source: AGHT+IEMOsx1yecc59LL8pG1QfZoOW0iZYfdgobhiqUG7wbaHzr+b5PQVVwb40bArXCze4oH+3B75ekFZtbkA6nO5eU=
X-Received: by 2002:a05:6808:1645:b0:3db:23d3:8404 with SMTP id
 5614622812f47-3df05e6203bmr6189707b6e.42.1725032245774; Fri, 30 Aug 2024
 08:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240828214524.1867954-1-max@kutsevol.com>
 <20240828214524.1867954-2-max@kutsevol.com> <ZtGGp9DRTy6X+PLv@gmail.com>
 <CAO6EAnUe5-Yr=TE4Edi5oHenUR+mHYCh7ob7xu55V_dUn7d28w@mail.gmail.com> <ZtHTSexXueMjYGh/@gmail.com>
In-Reply-To: <ZtHTSexXueMjYGh/@gmail.com>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Fri, 30 Aug 2024 11:37:15 -0400
Message-ID: <CAO6EAnXu1LO=erZYcm9UEcNBxVk=MwA4kKxAwfKq3fLntXzt0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Breno,

On Fri, Aug 30, 2024 at 10:12=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> Hello Maksym,
>
> On Fri, Aug 30, 2024 at 08:58:12AM -0400, Maksym Kutsevol wrote:
>
> > > I am not sure this if/else/endif is the best way. I am wondering if
> > > something like this would make the code simpler (uncompiled/untested)=
:
>
> > Two calls in two different places to netpoll_send_udp bothers you or
> > the way it has to distinct cases for enabled/disabled and you prefer to
> > have it as added steps for the case when it's enabled?
>
> I would say both. I try to reduce as much as possible the number of
> similar calls and #else(s) is the goal.
>
> At the same time, I admit it is easier said than done, and Jakub is
> usually the one that helps me to reach the last mile.
I see, ok.
I was more looking for possible (maybe impossible) compiler
optimizations in this case.

but access to nt->np probably makes it impossible anyway, I don't know
compilers well
enough to say.

I'll make it an if then, e.g.
if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)){

}

