Return-Path: <linux-kernel+bounces-438403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11C89EA0F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CF5166922
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330519D890;
	Mon,  9 Dec 2024 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="F+ILserq"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964E19CC2E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778840; cv=none; b=kesxT4JtqEVONervuA0qoIhwYqSI/B/w6Zewpbs+3nQqRKjU+FG2u5uzcGajsSLef/JmgBGmWmLbViPqb6I/7QwIx0hCdEAcH7BB7wlv7/3FLlThsMS8iR37ijW5O0bpFC1f4R79DMkekKLUw92HVYY4IV+VR9k9KNOXHC2c0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778840; c=relaxed/simple;
	bh=5w/1GVDKHJWgs4xyDKf1/0lotkZ7ARUgj/3LhKw1i6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obJA9gi0O96G/oRMuN+Cq3HJePZZyJCbVbo91zzbvKV/YsXH0BbhEQS8MaUEf3+n9u2xlzBlWUXyQRVt1SpCSXsvo+Jgxev9LxcbR6v6vOBfuTWrjRl0kfmA9yQxiuGD8+Ff3+bIK7InaZedQPsrxgwnnj5UOnZGdU54HZuuysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=F+ILserq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725e71a11f7so1204864b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 13:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1733778838; x=1734383638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkCQt7TdgCJWNDyhEFyO3ZpLHYLIIs4euAH1e9zYHNU=;
        b=F+ILserqrsbsd8fXgZpKISF1upAuA9aaxzQGSYx/vKKUNo40Cw8ShImZ7FhKUrItgl
         RS5zfZJ0foFWVO96uTlJ/rXUJeOSmDupbtvZ8rNE6tWWmffXPvWN+YecoieNmLzq0It5
         yTmzwCReg3TKtSZg7oGsaS2LOuNPIEYlEtk3pEjEfJIBjxlYblNIxZDEk6jYaKFakoiY
         XJnsFhsknQKsvR7si/xJM8cYA88LCDTX9GFHWo6PA0G5d6PBeUCOpYso49dPvJvGGh8Z
         TUkB0ox/4RSQOCOh50S2DefK/qkxwoPQkpWO9dHXdyC3N3XL2nOLrfHh8NEezsFMtE/w
         2nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733778838; x=1734383638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkCQt7TdgCJWNDyhEFyO3ZpLHYLIIs4euAH1e9zYHNU=;
        b=VTHs6GJdHnZEcd43bJcBM2UNZAmGcLyELzc7cAllXiDycGtZRykcjv3oIcn5uNGaJt
         1jr3wR9R7Wgqz6DbTDoLKuNql8eB8jMKeg4UFT4t+ho8xmispXc7vxTV2IqjoSDiP92N
         KxZgrvmo63Mb7q1woSQOwtNuwOmVtDdbdCoINkkceIWTyb1RnJWVYyucLoh2EQ2FvOQ6
         uVHQcr1BduMP+01qxIRK6G1qIfJlpRuExaKJVNSoiWdDCpZTvNu+PlH6Y+J+5h/Z+zXF
         kypnisTt4pqMdZz/9dqIm+YDzTM0kdla1c84ugeiS/p0ATykTg5UpPalnx5Qirc1hDkF
         vIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3+SlEMUdiVdIYj0Y5c5YTCT1bgptPUU31EXQLfHK7vHjoljCSehH37eHVzkmc4S286fVFyXn/Dog/sQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfI+C5u3jMVCvN0WtNh5FZGsS/swcyZ89RZUhV9sibtOnU+abY
	yzbYLBkoE59Gs941pHV8Mro4Yl2E92AIBWN1qHT6kksg9HdgEDjfapeu0qUzHFqDqY76izuE4Pc
	trK97JNyJi3OTPQ9HTrv6VMd/pnY52Upmcd8w
X-Gm-Gg: ASbGncto/yPNuNHIKcfvcVh45DKro5vvW3H5zp70mxpmj54zqE39uoNlL252eYFwjnA
	vOBVylVwkRlkcjXN+RPJqNgFrK1Y+z4BvpA==
X-Google-Smtp-Source: AGHT+IHdrnovaC/xg3D0TkTsajYdA73xG881IM297zQWFOO+gDgoCtARXZI3DV1isGiRbRGnysWRLfmroWuLEaxe6XY=
X-Received: by 2002:a05:6a20:4306:b0:1e1:a48f:1212 with SMTP id
 adf61e73a8af0-1e1b43c4e79mr1527539637.4.1733778837981; Mon, 09 Dec 2024
 13:13:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202191312.3d3c8097@kernel.org> <20241204122929.3492005-1-martin.ottens@fau.de>
 <CAM0EoMnTTQ-BtS0EBqB-5yNAAmvk9r67oX7n7S0Ywhc23s49EQ@mail.gmail.com> <b4f59f1c-b368-49ae-a0c4-cf6bf071c693@fau.de>
In-Reply-To: <b4f59f1c-b368-49ae-a0c4-cf6bf071c693@fau.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Dec 2024 16:13:47 -0500
Message-ID: <CAM0EoM=sHOh+aXg9abq6_7QLCaqH28Ve1rjSjnHNkZTsE7CuMQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: netem: account for backlog updates from
 child qdisc
To: Martin Ottens <martin.ottens@fau.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 11:37=E2=80=AFAM Martin Ottens <martin.ottens@fau.de=
> wrote:
>
> On 05.12.24 13:40, Jamal Hadi Salim wrote:
> > Would be nice to see the before and after (your change) output of the
> > stats to illustrate
>
> Setup is as described in my patch. I used a larger limit of
> 1000 for netem so that the overshoot of the qlen becomes more
> visible. Kernel is from the current net-next tree (the patch to
> sch_tbf referenced in my patch is already applied (1596a135e318)).
>

Ok, wasnt aware of this one..

>
> TCP before the fix (qlen is 1150p, exceeding the maximum of 1000p,
> netem qdisc becomes "locked" and stops accepting packets):
>
> qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
>  Sent 2760196 bytes 1843 pkt (dropped 389, overlimits 0 requeues 0)
>  backlog 4294560030b 1150p requeues 0
> qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
>  Sent 2760196 bytes 1843 pkt (dropped 327, overlimits 7356 requeues 0)
>  backlog 0b 0p requeues 0
>
> UDP (iperf3 sends 50Mbit/s) before the fix, no issues here:
>
> qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
>  Sent 71917940 bytes 48286 pkt (dropped 2415, overlimits 0 requeues 0)
>  backlog 643680b 432p requeues 0
> qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
>  Sent 71917940 bytes 48286 pkt (dropped 2415, overlimits 341057 requeues =
0)
>  backlog 311410b 209p requeues 0
>
> TCP after the fix (UDP is not affected by the fix):
>
> qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
>  Sent 94859934 bytes 62676 pkt (dropped 15, overlimits 0 requeues 0)
>  backlog 573806b 130p requeues 0
> qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
>  Sent 94859934 bytes 62676 pkt (dropped 324, overlimits 248442 requeues 0=
)
>  backlog 4542b 3p requeues 0
>

backlog being > 0 is a problem, unless your results are captured mid
test (instead of end of test)
I will validate on net-next and with your patch.

> > Your fix seems reasonable but I am curious: does this only happen with
> > TCP? If yes, perhaps the
> > GSO handling maybe contributing?
> > Can you run iperf with udp and see if the issue shows up again? Or
> > ping -f with size 1024.
>
> I was only able to reproduce this behavior with tbf and it happens
> only when GSO packets are segmented inside the tbf child qdisc. As
> shown above, UDP is therefore not affected. The behavior also occurs
> if this configuration is used on the "outgoing" interface of a system
> that just forwards packets between two networks and GRO is enabled on
> the "incoming" interface.

Ok, will do a quick check since i have cycles..

cheers,
jamal

