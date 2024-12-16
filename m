Return-Path: <linux-kernel+bounces-446810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E57BF9F2966
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3A218862B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D5C25632;
	Mon, 16 Dec 2024 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="azaRBaeI"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2D10F4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734325577; cv=none; b=iSKOASZWhj+RKUgLzRsxIdo1ywrOG2S099eNX8fwucZXy48/x21T4gniLRP+GqUDUCuy4vcMzzAqYP72yHZ00zvuLrFoze+yG4j+NObB5xHO++/DnpFX5gIxznz4xUfw7dV6VPJsPhN/R1AbSgmGCRwhRYrHDoJu5ukxQ7j0WUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734325577; c=relaxed/simple;
	bh=kCRva32N0VhrNgQfChfjnrcWqJoDUo1iXfZ0ODPK70c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS0186qQyoWXcdIuT5OXBB7j2kUfUHRFEKWLJZBDTW67x4yFxQk1W8EBalhKkUwkx/r7eRg/1FKdiA0WzgS7uGrmRTKH3XlRmrQ5weSXvL06uCC2Cheep0o6E9eYcY9/EHyGKKGJJvc28VPVmymWRcwhHPXeT9WcC1E5k/PCAWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=azaRBaeI; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3022598e213so35748061fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 21:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734325574; x=1734930374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCRva32N0VhrNgQfChfjnrcWqJoDUo1iXfZ0ODPK70c=;
        b=azaRBaeIXKBmrQxHeg7eil9IwlxtRI7RD+KUYevzjWqTvRXER0+JsW20rEMWRKwAsP
         XdGGAdBylCoo4e5rAb4UexmI0GBbWRywRHd/Zs94JvzD0B+qjIfFS87CtPL4cvP1WCCX
         4y/eaubA7yHUD6ZWh8N4Sd8gjlqCdkFrNmBUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734325574; x=1734930374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCRva32N0VhrNgQfChfjnrcWqJoDUo1iXfZ0ODPK70c=;
        b=M9JBhYaZI6+odh93ufJW5QSUr6DG6zWMmMwuNs8KtLD4/tDaKCfNw55jjteluwVITj
         RQoHPgYkwZcDsGEPJ14OA2gtmuTh87ovnlyMUo/q7kQSPsQyzPn4uPjHXd6Q17DludmH
         dKF5KoOWWIPepIJapLEBBrrZLyYN3h+reDmy7R/fT36njFpbh+ZtoT4prlUxwfh4bM7f
         +4cRUKa/dtioQ5h5nbZj6fdFkyEdNyY29DDNcmdQEXOdBSxc+OzmGLhJVyVQGfeP9d3O
         HRJZBCdhgZBRK7Zs//giDM//BBKGHciVvQcQKCAA7aKLdvpwiRchxt40PtB3VmWstzaI
         bR8A==
X-Forwarded-Encrypted: i=1; AJvYcCWKr3qGWV1mUmAwfDkDHG6j+2BVIZlR9IDTXHn+M8jQxfAuFP5OcK6EvVXLvUOCjVxrjedIOgkabK/53uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFt1P4E3WLASyRbXw1eovHw+K1Ms7Yi20qMavea6XSl905IfJV
	VIXcn+npkqzRhhleHs+i9k299vR/LrMrimFCHoU5ZkmKjQ6kObaPpPJuZ80beAOJTIx23ArQM+1
	PojjcocA1k/6fqvrMIfk4/andmPTG7Rdy0u1F
X-Gm-Gg: ASbGncuQaJ5BLlGBoP4hkzEQ8V5CNO3P9qJKiVLApZGHSvg3OeF5neecYfu8s/kvdhH
	azNcZ60frb6Zh0965AxV2DcG+uAwTwIVpTwm17w==
X-Google-Smtp-Source: AGHT+IE2lSfy0plkHFYvqJzzMKQfZf0H0X0Pv4uKJBDZr2SBKnWb1wfneg9v2qKtvbV2M2+FSEtq4YdfQJ0p+sPWLjA=
X-Received: by 2002:a2e:be8a:0:b0:302:1c90:58de with SMTP id
 38308e7fff4ca-302544cd2a9mr45430851fa.33.1734325573758; Sun, 15 Dec 2024
 21:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212224114.888373-1-dualli@chromium.org> <20241212224114.888373-2-dualli@chromium.org>
 <20241215142723.3e7d22e7@kernel.org>
In-Reply-To: <20241215142723.3e7d22e7@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Sun, 15 Dec 2024 21:06:02 -0800
Message-ID: <CANBPYPi8Q2akivjbMCeThtHEw1L_rHErxL_Cwt=Xjf=B1fZ=-w@mail.gmail.com>
Subject: Re: [PATCH net-next v10 1/2] binderfs: add new binder devices to binder_devices
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

On Sun, Dec 15, 2024 at 2:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Dec 2024 14:41:13 -0800 Li Li wrote:
> > +/**
> > + * Add a binder device to binder_devices
>
> nit: kdoc is missing function name
>
> > + * @device: the new binder device to add to the global list
> > + *
> > + * Not reentrant as the list is not protected by any locks
> > + */
> > +void binder_add_device(struct binder_device *device);
>
> To be clear we do not intend to apply these patches to net-next,
> looks like binder patches are mostly handled by Greg KH. Please
> drop the net-next from the subject on future revisions to avoid
> confusion.


Got it. I'll modify the subject accordingly.

Meanwhile, Greg KH did say we need netlink experts to review
the netlink code. Please let me know if you have any more
comments about the netlink part of this patch so that I can
fix them in the next revision. Thank you!

