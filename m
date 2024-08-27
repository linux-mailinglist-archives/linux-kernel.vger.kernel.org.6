Return-Path: <linux-kernel+bounces-302500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA995FF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575B02835FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A8E17C9B;
	Tue, 27 Aug 2024 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUWRQu9K"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A117BC9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727612; cv=none; b=SRUogMvk16dzSdYBu0bhHVK7CF2f8NyOZ3MAZ4tSDu8zwEB9HdVV37W7RhDZFJIFVXgl63Qva5ljkcgD69ihSSNTm1MHtxamVwb7dabYajFmB9zg6ey+PFCU3sjYtZxIzz3vV+dnuNR8wTl8flmNRfsXXbpDqs/NT8W20faAEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727612; c=relaxed/simple;
	bh=PesMy6+ZaljaMwUP3eDOzaceYGNPFc9NY5RXT3Ln9yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmn6mplLqzjpIVtIMnUUAlLDjb4Qjn7NqG4IHkw2N8mSVFoAFsfkQG7so96/t6ivRZLboFhXUWFo6jdS0/yXwwc/Fz6biIwhXPi38GSMTUY2zYat9O+eWX9bTjpMsMg+pNf3P5MYtrWgzEq+iZXZCPG8QdiKUFsZaOENvP7KUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DUWRQu9K; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7143ae1b48fso2866952b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724727608; x=1725332408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PesMy6+ZaljaMwUP3eDOzaceYGNPFc9NY5RXT3Ln9yg=;
        b=DUWRQu9Kxht9HThWcX9XTFl4YjNUzNeuYbv+W5x6cEtt6vTdwlcy7zM9ZvHllyJtzO
         iXNbGSU7TL8gjIBSbilBFT0/V+lsU4cPYrkYIpQ+G+/hHAV7Z5VaU/pr3k1jYUnplbUT
         PrYWVE+pXg2uIBgO4QDRQZ4v1+zYytIbmlGMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724727608; x=1725332408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PesMy6+ZaljaMwUP3eDOzaceYGNPFc9NY5RXT3Ln9yg=;
        b=dwAPJPpf3oLSo2thq60FFMiGbIckYzea6j/2L+4n4eNDYxj4WNpRtJS2zvrerV49Yv
         QTKvgkKLjhawfJ8CsVQCMe2dhqHaxvyH1iHwwYtwGoN63IkzGEK9hyxS+/J5ZK38/RU5
         eNoxmg3Gev4nIX1sS6zOFa5OTXL9hFlLxxL+s7znn+CshSZlB1gXFqlFmmEr0UiTqOnE
         OYy9WS+H474/MkLt05IloQEaPZ+4jZGRQqZ7cX6VUGYUI+O0YKbgDaGxDsxAX0GqO9rM
         heh/lu673bpXsd7Nj2xJj8++ilTYOB62dQEQ4Aplm0VT0oFe17Lyk4ZxrDDApNSDP+sg
         8NXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/0QHvahuGUCGxm+fRSS0UebtwWT6SGK0Ifa6xHZxhQhu+Gk3/je9RH02uFCeVFienXGRFiQaUGJT14Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxltFfLQdshi0IlpYgzo48iOOMdMKtw9Xp2LW/Ay6kM45iXp+mb
	zsGsYaFvNVfCc8pJSw12ObJ9W4LUF7kF8s2NivFrmIYiQFOc4hlJxT8fWdD7yitpuGePEz6Fxq5
	aKw==
X-Google-Smtp-Source: AGHT+IFK78ZmS9GOjCcCmoQPuNKVFGBBBu7c+n2hLfJEpPeYbZyCLZ7+Tdz3bgbJjJdUCSjMAJBOqw==
X-Received: by 2002:a05:6a00:1953:b0:706:b10c:548a with SMTP id d2e1a72fcca58-71445e77bacmr13464533b3a.22.1724727608350;
        Mon, 26 Aug 2024 20:00:08 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343094a8sm7691301b3a.166.2024.08.26.20.00.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 20:00:08 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202018541afso82155ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:00:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlHjxNhbn0Mqb+ZvNweD8MxuRqUoWftY9rlP2t35/dP37+FA+fLkfxBFvwUCQYgAaddwHu0j3jNKHgEuk=@vger.kernel.org
X-Received: by 2002:a17:903:187:b0:1fb:1a7:a64f with SMTP id
 d9443c01a7336-204e1351fa3mr1790775ad.20.1724727606755; Mon, 26 Aug 2024
 20:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825035422.900370-1-jon.lin@rock-chips.com>
 <Zs0BRsNdZdI69aXM@google.com> <27302919-5bcd-4bcd-bdad-02aa48e628e9@rock-chips.com>
In-Reply-To: <27302919-5bcd-4bcd-bdad-02aa48e628e9@rock-chips.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 26 Aug 2024 19:59:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMjN7dVUQWgfMULcD2KgF448-q=Ue2+MYUftK6Ra8MWhw@mail.gmail.com>
Message-ID: <CA+ASDXMjN7dVUQWgfMULcD2KgF448-q=Ue2+MYUftK6Ra8MWhw@mail.gmail.com>
Subject: Re: [PATCH] spi: rockchip: Avoid redundant clock disable in pm operation
To: Jon Lin <jon.lin@rock-chips.com>
Cc: broonie@kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 6:33=E2=80=AFPM Jon Lin <jon.lin@rock-chips.com> wr=
ote:
> On 2024/8/27 6:27, Brian Norris wrote:
> > It seems like you'd really be served well by
> > pm_runtime_force_{suspend,resume}() here, and in fact, that's what this
> > driver used to use before the breaking change (commit
> > e882575efc77). Why aren't you just going back to using it? (This is the
> > kind of thing I might expect in your commit message -- reasoning as to
> > why you're doing what you're doing.)
> >
> > And in fact, I already submitted a patch that resolves the above proble=
m
> > and does exactly that:
> >
> > https://lore.kernel.org/all/20240823214235.1718769-1-briannorris@chromi=
um.org/
> > [PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM handli=
ng
> >
> > Do you see any problem with it?
> >
>
> I have reviewed your submission and although the code has been
> simplified, the execution efficiency has decreased. So although it is a
> commonly used processing solution for SPI Upstream, I still hope to
> retain a more efficiency approach as I submitted.

What do you mean by "efficiency"? You mean because there's
indirection, via the PM runtime framework? If so, I doubt that's a
priority for this piece of functionality -- simplicity is more
important than a function call or two when talking about system
suspend.

Additionally, simplicity has additional benefits -- it heads off
questions that your more complex code doesn't address. For example,
are runtime PM and system PM mutually exclusive? Do we have to
coordinate with any pending autosuspend? (Reading through
https://docs.kernel.org/power/runtime_pm.html, I believe these are not
actually concerns, but it's really not obvious and takes a bit of
reading.) But your patch makes it more likely that runtime and system
PM states get out of sync.

Anyway, if the patches really are equivalent, I suppose it can be the
maintainer's choice as to which is preferable.

Brian

