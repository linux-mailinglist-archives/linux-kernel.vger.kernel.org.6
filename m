Return-Path: <linux-kernel+bounces-439855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEE09EB4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1571885B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826201BBBFC;
	Tue, 10 Dec 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="lIPzDDdG"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FBC1A0BD1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844553; cv=none; b=gmvh13+I+4iXwRmg9zrEbc08j8epTjnO/ychHOvhVouE8Jc/EJEvcLFwP8r4m7ZWlqac2IyGrWFLbim95CC/p9uoEVJlcB/zSTRDF+seJkUIA9kBW3dy4bK0xo0TlOKnpSZPhbrYGFfhT1+tmwYM6MXDwOjdhJaiyJvexPidhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844553; c=relaxed/simple;
	bh=cWs/c4TFgM8ytblaB0OKLNZx4QlCxkLj//Xce3vvX44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWkrSfiFBuha1Xqc3UwRINyPrcr85W3Yy2G7J01y0t3xgIsNp8Eu+1tg0lVeXT0DrHkPtMr3fr0p90w30cTqwDaznVej+gWru7cr4DhwjiY4l0IZKkqEHlNC24GgzjLrZaDFaF4Wvia7tFJiIi3sB3eWR7K2dZq6YV+55Fwimp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=lIPzDDdG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46784a8fef2so669011cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1733844551; x=1734449351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWs/c4TFgM8ytblaB0OKLNZx4QlCxkLj//Xce3vvX44=;
        b=lIPzDDdG+CPFJLeRFEhVcbofmEGtJJK88NVY754OdNlLRd9VKojIBZBv3k8elwwDPp
         hMCuB+yigMWGnH2XwWpdGaib/CgUdAFdioR4Ni2UULhO/D+UAkHhj0hfCjMQvrADJs2e
         9yGjrh5Fj0SylFY0c++Xr1R+DatjKJ2zn7dBvubth3oe1AbcWrtU91RUhEX11kBjIwCQ
         5O/CVXGOp3iMqzkIoepLLJWHse76B+RKRoOP9ohseQzC5eMJssPvulOMfTMWRjJ3/xAh
         s1ZJsYAoo+rkzZbtTO8bPkM333CZrKIQSAdxDQc9varOQn3VLiBchI+iFTmhIR3ActWV
         siew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844551; x=1734449351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWs/c4TFgM8ytblaB0OKLNZx4QlCxkLj//Xce3vvX44=;
        b=AffXpELsv7Czdlz4fzJzIZ0HvEK7/tDBlMJkoWH91WPNCjEDlqu9EvW+dIXMEWEvyW
         VlJfU9otjARzY4WAJOdNjhdPlQasyoPNmuOXXnNV9TI0J4UDzmv+9VMmjvBezOScBdZN
         ihsYILxbDOJLQEnAhYSXO/r6Y3Jc7jTxaqNpP+aLwIrwT9f44E9dCZTUIueKT0/IQUtJ
         0ZGgcEYG8idtKVhcpeLQJYuD9ruSy4SETi5zwF5eol1O5XnS8Tpw0Yl9r+hW11WQnHUQ
         ck9oi4eoikKD2i2gHgWiIsqW7n+rfhn2bUQY7F2U2v72RYwVZ3lhIReB+k8Tfw+P3B84
         OqxA==
X-Forwarded-Encrypted: i=1; AJvYcCVF4cDhrYCbuTeWQxyeKH8gZwp5DEhwjxnWF8kjqvUWtTD3zvysylVJFtieaos9paa1ZRwwCfEHyi53oCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6xCJIm/mg83/2plToKqqaIyoD+13V5qEbxODrtDU8whna/Rt
	Hly/nLzH94BNA7jph3DAG88d6K3XQNUAv1+28CxII1I8dayTNoUC2vaJGE2P35mvoQUs4SlzEHZ
	ALvmvi0+Li+lAVesQGkD9Ycp5kdjuUZqGVtQsERTcn89RnpCzIzxw48L8LYmAVvMsFkXdXfZLlO
	PdGNkSMCBZEM2URHdW03s6X67rTItolg==
X-Gm-Gg: ASbGncvZBp0OQ9XHmy7Eeiy0l+KpRfKXrgDelBuWePdB6zIAwbBmGEIhhBwMjNN2ZBe
	uSo46YLIUDo/SXgglFntMejdWLDkD3+NETw==
X-Google-Smtp-Source: AGHT+IFYp2J8sA1dyCVQ1vOCeeXRqBIzaSBN+hS+fa8YG0sEE7LCygde5whGIR2rD8IsQqAE7colLdcVHHr8uxRzDYs=
X-Received: by 2002:a05:622a:307:b0:461:1fc9:61a3 with SMTP id
 d75a77b69052e-46734ce0dccmr104642071cf.9.1733844551264; Tue, 10 Dec 2024
 07:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf> <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
In-Reply-To: <20241210145524.nnj43m23qe5sbski@skbuf>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Tue, 10 Dec 2024 16:28:54 +0100
Message-ID: <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll learning
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans@gmail.com>, 
	"Hans J. Schultz" <netdev@kapio-technology.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Di., 10. Dez. 2024 um 15:55 Uhr schrieb Vladimir Oltean
<vladimir.oltean@nxp.com>:
>
> On Tue, Dec 10, 2024 at 03:47:11PM +0100, Jonas Gorski wrote:
> > Huh, indeed. Unexpected decision, didn't think that this was
> > intentional. I wonder what the use case for that is.
> >
> > Ah well, then disregard my patch.
>
> The discussion was here, I don't remember the details:
> https://lore.kernel.org/all/20220630111634.610320-1-hans@kapio-technology=
.com/

Thanks for the pointer. Reading the discussion, it seems this was
before the explicit BR_PORT_MAB option and locked learning support, so
there was some ambiguity around whether learning on locked ports is
desired or not, and this was needed(?) for the out-of-tree(?) MAB
implementation.

But now that we do have an explicit flag for MAB, maybe this should be
revisited? Especially since with BR_PORT_MAB enabled, entries are
supposed to be learned as locked. But link local learned entries are
still learned unlocked. So no_linklocal_learn still needs to be
enabled for +locked, +learning, +mab.

AFACT at least Hans thought that this should be done when there an
explicit MAB opt in in
https://lore.kernel.org/all/CAKUejP6wCaOKiafvbxYqQs0-RibC0FMKtvkiG=3DR2Ts0X=
fa3-tg@mail.gmail.com/
and https://lore.kernel.org/all/CAKUejP6xR81p1QeSCnDP_3uh9owafdYr1pifeCzekz=
UvU3_dPw@mail.gmail.com/.

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294


