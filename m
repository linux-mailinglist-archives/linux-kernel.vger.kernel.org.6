Return-Path: <linux-kernel+bounces-208857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C79029EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9AF284A61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F60481DA;
	Mon, 10 Jun 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BS4mV88J"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD22E859
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051149; cv=none; b=FolxuammWUT7bsmDDD8p70016hLca+k+uiA4fIoQLVdWK9jcR7BweqnnsqkFETNCdMzw8qUnvkTPA+xAyXpAE07C5PGGfOew+I/5e+rXGO3sg6hl+lAmEqJDKaZOo3xiljY39BBbqY56Y0QkVQNJCVkuCe4uQ1HBhkl31cFWzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051149; c=relaxed/simple;
	bh=SONlq9bXQbAkTw0EihI5/xjKerm7ff58Ryq6LfBbhF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDFrKfsCdIi2sAFe0+XqB0sKIMg90oC8S+infvPRtxYSpRcriyUmzyPJs9pSLvXDxdVZsHZ7/KgDi2CXsuLRUspf/a0bXU4AOMS827pPSYus94suFMWzo5Wjv1xPDkvYPvZaWVcStaycJ0aY617oT96Vzi8UWuv/j19qe7GXW30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BS4mV88J; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so3758775a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718051146; x=1718655946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wH3mYXJPFC56KG/UdINpo4FbUx5USQeX53C3PDh1Bk=;
        b=BS4mV88JHJcQKOZH4AjD/VXAJRB4cGA+sC/iEuSHK1446agPTX8IyrvQxzYXAcDKrz
         /jxI4dUEFadkJGS9o+OFujWmP8VmZ5LHersUiOFaltIVoPQORYzB3qfd6xeMnlIOACA1
         7ociECb8aVwKYIzvu7VHQY1nu840AiC10HUeseLxS28KI1IgwqUa8QQTlKhs71S6+Zlw
         XUZu4bfEmcnNt/X7iZF+Ext3RIfANRLjNA4G5sqHv0ketyjXscSebxmeLo5hoT2KVMP3
         LdGLT1cItVzGnsZ3O8850AVnsYU8pW60fLbVNJgIf/sn1QdvyTKownzX3WKscDGgpMIs
         ozrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718051146; x=1718655946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wH3mYXJPFC56KG/UdINpo4FbUx5USQeX53C3PDh1Bk=;
        b=m25wruZTwYPdYir1Nt7Igj6wnwRH1enJJWnZI84aQomqrP538mWKomdtRm7W7ni54a
         xxIVx9rJxdfBQ43UtV2XsQvQ79rmAB6lqtUjiDz0uPI7pKMfX8fpaaVqeQ13Tw8jZduS
         ztMFx9r6aMrCmFIBPDc5NNBSiFABEq5WXiMJz60lPhSW07SWKpgKl8NcOh47jC6JySmy
         APxjhQ9H6uAlVz+iz7Vi5Rh5olkg/t04Yhr3GLEtDaVZhOyzkBrshkpL3dSjUoLzUY+9
         D2GoABPKrsRQmNDxyjuiSfX9uweoyyySFvo39DeclHsJUxR0dx5URoqfok+JVuO7M505
         RIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkNVma4VsAEQzFWj7Id4pTR+H6IGGZPU2wKucXyizapDIrPd0T7O/lAzaBSXh7+92TbeKjjnLGKx2obd6Jt3K5GrLtFGG87zK9C80j
X-Gm-Message-State: AOJu0YwzanwZ+u9RaxGC84qYt3sLqUZZeKtBh/+vws0bVuU+Qi9xc7d8
	3U006Dj2TU6Rd24fwAI3zWuq696LAzKoJfI86hMh7Ph+CvTwzVu1wWKJSWChar1itLvOBDMeHHK
	DqpUGa7Zvmq437FVnYpDMKlIXKxWYVlOKhC3edA==
X-Google-Smtp-Source: AGHT+IFeNM+vnJ0I5dqzaSHadBEEqlOnv2kTGQITQ/wXOYx520e/KZSJn/7E3GvgAEEb7/zIgfGp2FD5q2fX1wytAaQ=
X-Received: by 2002:a50:8751:0:b0:57c:7f3b:6b9c with SMTP id
 4fb4d7f45d1cf-57c7f3b6bbdmr2819913a12.5.1718051146118; Mon, 10 Jun 2024
 13:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717529533.git.yan@cloudflare.com> <983c54f98746bd42d778b99840435d0a93963cb3.1717529533.git.yan@cloudflare.com>
 <20240605195750.1a225963@gandalf.local.home> <CAO3-PbqRNRduSAyN9CtaxPFsOs9xtGHruu1ACfJ5e-mrvTo2Cw@mail.gmail.com>
 <20240610125422.252da487@rorschach.local.home>
In-Reply-To: <20240610125422.252da487@rorschach.local.home>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 10 Jun 2024 15:25:34 -0500
Message-ID: <CAO3-PbpX1RCcYgr_xKVoO=MYOrP6jBhtGuTbptjRMjR=VAvthQ@mail.gmail.com>
Subject: Re: [RFC v3 net-next 1/7] net: add rx_sk to trace_kfree_skb
To: Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Mina Almasry <almasrymina@google.com>, 
	Florian Westphal <fw@strlen.de>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Borkmann <daniel@iogearbox.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Neil Horman <nhorman@tuxdriver.com>, 
	linux-trace-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:54=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 6 Jun 2024 10:37:46 -0500
> Yan Zhai <yan@cloudflare.com> wrote:
>
> > > name: kfree_skb
> > > ID: 1799
> > > format:
> > >         field:unsigned short common_type;       offset:0;       size:=
2; signed:0;
> > >         field:unsigned char common_flags;       offset:2;       size:=
1; signed:0;
> > >         field:unsigned char common_preempt_count;       offset:3;    =
   size:1; signed:0;
> > >         field:int common_pid;   offset:4;       size:4; signed:1;
> > >
> > >         field:void * skbaddr;   offset:8;       size:8; signed:0;
> > >         field:void * location;  offset:16;      size:8; signed:0;
> > >         field:unsigned short protocol;  offset:24;      size:2; signe=
d:0;
> > >         field:enum skb_drop_reason reason;      offset:28;      size:=
4; signed:0;
> > >
> > > Notice that "protocol" is 2 bytes in size at offset 24, but "reason" =
starts
> > > at offset 28. This means at offset 26, there's a 2 byte hole.
> > >
> > The reason I added the pointer as the last argument is trying to
> > minimize the surprise to existing TP users, because for common ABIs
> > it's fine to omit later arguments when defining a function, but it
> > needs change and recompilation if the order of arguments changed.
>
> Nothing should be hard coding the offsets of the fields. This is
> exported to user space so that tools can see where the fields are.
> That's the purpose of libtraceevent. The fields should be movable and
> not affect anything. There should be no need to recompile.
>
Oh I misunderstood previously. I was also thinking about the argument
order in TP_PROTO, but what you mentioned is just the order in
TP_STRUCT__entry, correct? I'd prefer to not change the argument order
but the struct field order can definitely be aligned better here.

Yan

> >
> > Looking at the actual format after the change, it does not add a new
> > hole since protocol and reason are already packed into the same 8-byte
> > block, so rx_skaddr starts at 8-byte aligned offset:
> >
> > # cat /sys/kernel/debug/tracing/events/skb/kfree_skb/format
> > name: kfree_skb
> > ID: 2260
> > format:
> >         field:unsigned short common_type;       offset:0;
> > size:2; signed:0;
> >         field:unsigned char common_flags;       offset:2;
> > size:1; signed:0;
> >         field:unsigned char common_preempt_count;       offset:3;
> >  size:1; signed:0;
> >         field:int common_pid;   offset:4;       size:4; signed:1;
> >
> >         field:void * skbaddr;   offset:8;       size:8; signed:0;
> >         field:void * location;  offset:16;      size:8; signed:0;
> >         field:unsigned short protocol;  offset:24;      size:2; signed:=
0;
> >         field:enum skb_drop_reason reason;      offset:28;
> > size:4; signed:0;
> >         field:void * rx_skaddr; offset:32;      size:8; signed:0;
> >
> > Do you think we still need to change the order?
>
> Up to you, just wanted to point it out.
>
> -- Steve
>

