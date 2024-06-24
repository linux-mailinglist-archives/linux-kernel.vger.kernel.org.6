Return-Path: <linux-kernel+bounces-227688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F67915588
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3473E2838CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98419F465;
	Mon, 24 Jun 2024 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ML0Y+EyK"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56BA19EEC7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250769; cv=none; b=K79R0hPK7yew8bGeAzAnG5jJpaBqsMQgZuGl4ThrBhV+LH23JXeI0y4WYRm4uyfWcwYRuPwxT5UHXTx27OZgfzUjjDbdwz7bM3E8fPzkWycCX0Z8+Rt1h218xt4idKHjEGwqCBqUYzTJcKaVSlIrNXE8evPzJyejwQN+QuHqGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250769; c=relaxed/simple;
	bh=RmWwBKqpQhgnS45GQ4aaZI6SvIbgoTYxZp32M5eQP5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJuI6UWAizoiC39ULFrlZE72ejotJ6URHm5Zo+rJH66gF3pAqbnrruMYe1ekNg1W270fN7lFSQ50Iu1NBDnIOrCgaAtmletGQBBvzyS/c5JKMcjPS+ebb5t21DESP/GLnnTXA8F8+wkpzJU/QzGzLE8tUeqW/7WO/cCR+wymH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ML0Y+EyK; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7955841fddaso389568485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719250764; x=1719855564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bcigEvxElFnNf6XQZ1LGyn+920C2Rwm5nJUAotnto8=;
        b=ML0Y+EyKNiVdw+KpF8EYsjABUHPy2ApYl+20TlGRetEgKhyzKR1uVtdJQ1b6+78ea4
         1GmzoNFlLZXkd/28e1gra9helEvyM3LdVlJdyaEufFwizV+1sE5bh+htAt7hAxbvnz0j
         FoHFC4NweDvyltpghFKryt9BsG77nxUSwLQDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250764; x=1719855564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bcigEvxElFnNf6XQZ1LGyn+920C2Rwm5nJUAotnto8=;
        b=aR46vr/NzxptSzC26rIHc0G1bDhiP3NNHO2iaBW8WV1G2rdbShnWOcZ8xS0KtB5JAt
         hSSXQ5NGz8F3b4yHmitUZjSLvBpR+PUneXzBCBWRqx1FGC0vOt31Gw5DtsugvE//T02g
         6aHutkpTwfbt/MJY28+JGvreKDP9GTqIpLawIhhKeylYoF1SU0qEeFsow6JVJaKS0suQ
         AtyM0vUj5DsXeaevi+vILB4ZC/ExK/SyzVz/7u5qjUDFgXjiRk1O7xGVh2ttol8vO+Nw
         t3kLs4ufLcVAfBh1TRnYlfX/6sJ8ncPbkRbm7JvXqHDUWCiyYGSs0nZZfvAtg8JKhtcw
         HLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Y07X4AH/yEGYnPgczNtnuE9oCgpRB38OOmuHfH8bo0D/zX4PbwHgyN2UdGOfQW8hXs8vjQxzYQjrsfsriuJxX5bIPZHFC2DQNU4C
X-Gm-Message-State: AOJu0Yy/GMrrDbye/947ObVK1Bo/hd3OE81fz7RowACXMw1gHsKki0c4
	qBb3FRDFkhWBvyv12MHjg1HuZG+T4g1IgMjmAvaOt8NUaLKN3OjtF7GTJBBFWvST4vGCyPzIMcg
	=
X-Google-Smtp-Source: AGHT+IFGJpa04YFdHzSZsZCqzWMh72J2zGBNzXc0eEg8QU5PQpD9Gghx4oGm5vXyurM4L8+mAYM5SA==
X-Received: by 2002:a05:620a:270b:b0:795:50a9:f2f with SMTP id af79cd13be357-79bfd684d69mr159802085a.31.1719250764505;
        Mon, 24 Jun 2024 10:39:24 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b38acsm335393285a.41.2024.06.24.10.39.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 10:39:23 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4405dffca81so12871cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWe2glm/PYNvEIwc8Xy0Th40LjNCmG9tsvPOSJ7Ui5TxQ7kMkgMPKfwQUhZilPkCqKt+MrjPx0cKeQyr4T4vDhAJh3pSvLMMEOlqLyj
X-Received: by 2002:a05:622a:4b18:b0:444:e11d:709a with SMTP id
 d75a77b69052e-444f2520e93mr65771cf.20.1719250762638; Mon, 24 Jun 2024
 10:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org> <20240624133135.7445-2-johan+linaro@kernel.org>
In-Reply-To: <20240624133135.7445-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 10:39:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
Message-ID: <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: qcom-geni: fix hard lockup on buffer flush
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The Qualcomm GENI serial driver does not handle buffer flushing and used
> to print garbage characters when the circular buffer was cleared. Since
> commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo") this
> instead results in a lockup due to qcom_geni_serial_send_chunk_fifo()
> spinning indefinitely in the interrupt handler.
>
> This is easily triggered by interrupting a command such as dmesg in a
> serial console but can also happen when stopping a serial getty on
> reboot.
>
> Fix the immediate issue by printing NUL characters until the current TX
> command has been completed.
>
> Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't love this, though it's better than a hard lockup. I will note
that it doesn't exactly restore the old behavior which would have
(most likely) continued to output data that had previously been in the
FIFO but that had been cancelled.

...actually, if we're looking for a short term fix that mimics the old
behavior more closely, what would you think about having a
driver-local buffer that we fill when we kick off the transfer. Then
the data can't go away from underneath us. It's an extra copy, but
it's just a memory-to-memory copy which is much faster than the MMIO
copy we'll eventually need to do anyway... This local buffer would
essentially act as a larger FIFO.

You could choose the local buffer size to balance being able to cancel
quickly vs. using the FIFO efficiently.

-Doug

