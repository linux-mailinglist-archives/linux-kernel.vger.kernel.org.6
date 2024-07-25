Return-Path: <linux-kernel+bounces-262692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616D93CAE5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD3D1C20FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C7143894;
	Thu, 25 Jul 2024 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ku6jC/wR"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FE32C8C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946846; cv=none; b=Rqq6huWVaaOGGZdwtbFaE9caZkvjp6QCYVOSfY1Y6rtXTKPfRuwTAfX9kWiFY8YrFiE0otTw4JzRmC34pluWxen91PlM6iAXfUD0nzJYL/mor2TzspxG79T3iOW2MXHFYRYmr1f7GpvNXY6WLCSYfQIxiMrUctIx6A0I8DEYwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946846; c=relaxed/simple;
	bh=cGgfznJEdI3Gx9UCrbE7PFhs00X7J6qVrZ1EvVju9Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXUXghj0OMtcFjqnfNPdXCl+p3W2+aRTyxTa1UTh64G6KYHTWp2cizhzvz8/zXLAHyGCVytcXydfjdF+0Ue6QF63l39ThwhviFeVmRVuBmNW7RswhA8wspxKa6LLkMu0VUq215Tx88yLjf8gMXOsbWXlReJkLW2F8xDml15yGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ku6jC/wR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52fc4388a64so1064630e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721946842; x=1722551642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGgfznJEdI3Gx9UCrbE7PFhs00X7J6qVrZ1EvVju9Sw=;
        b=ku6jC/wR2AdvyCTshrUsXJ0oKOxumZfMZAwkn0UkXhy5lCz8wXHUgs21V06GIUj7TT
         EeVbM4ljzKoZCPg1Y4GWt5suKTH/aIiGa+82//gCKhYSGHY4FcHNgOSOcKXU5EwPSJhr
         h7giFoSm+lV5hwfC87JrWXiStEoTtS+9sIn0Fxt2VoAGk7XIzDn7//8sDALDuTOu+Nb2
         OrGs0g97iE9Ta2uvnyafmknbAPuy6uvgINGn/L6B1ChTkHYsFH/ahAcB6zBRonQpkeLi
         aKR2lRKwE/c75BPtTa777H80oTT0EnM3zXecwc1tonafIizZ8kJTQhm951kKb/Lctzow
         zU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721946842; x=1722551642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGgfznJEdI3Gx9UCrbE7PFhs00X7J6qVrZ1EvVju9Sw=;
        b=WEb2ve85PLy2SXZDZgzCQJ/8Ge5onkNNzXvQYtGr1ITUPXmrI+IbDMNqgcbzV/qoPS
         7eCu5am/99zNP5ZPiXTby2emYun11n6rbAyGbKVs0w5gLIo1TQsRSz4/gqQr7vuyKmlF
         BCcyIOEoMS1QndoadwV3rPXCvja9Qzt8y9sxdbr0whO3uCWUHrps765qMQF5lv4j4MKq
         k8+Znti9qZgOh1gFZv/qlJ5j+0YwT+QPny9h4LNxc3IjGRHRf17ggF4URWbHskabnC1a
         tmkyUf6yztpRd6bj0GFSXqm7j9ITInxuTLeBcKZ4PIuSMnD47YfaID0B2G9zEL1vx82n
         HgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKeRKXbriHLWBFM9uCzjUJB9HEVAMDWGuKU+yON2SsWGivX+2haGytN/0tQTsdQMjADMkL4/+FR1V+mGaVFnLn5lV1dsOHx0vZhJUV
X-Gm-Message-State: AOJu0YypyDZSm+yU7nWTDJgxlcob1JC/GYYOLEoZpE60vD7DrP3Qqls2
	fdFmyvHmBTZI39s10GoDOsNDS54Pxx4hX89YppyOfbkQk4MMcaskwUt9+CeKqY81BQoLEQX3o2m
	K6QudtNiK6qBnuodoogcaRtkE6of7ZsHuyxcd
X-Google-Smtp-Source: AGHT+IEQq8tUhCv0tVkK5hp43CjLo7OghrupRMxYGedGT2oaKiTkLW8JJ09UHgIwz7Z5iBN1NgnX/NdQ+1dzTs757VU=
X-Received: by 2002:ac2:4f0f:0:b0:52f:154:661b with SMTP id
 2adb3069b0e04-52fd6087755mr2867109e87.11.1721946841759; Thu, 25 Jul 2024
 15:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724190214.1108049-1-kinseyho@google.com> <20240724190214.1108049-2-kinseyho@google.com>
 <20240725204346.GA1702603@cmpxchg.org>
In-Reply-To: <20240725204346.GA1702603@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jul 2024 15:33:23 -0700
Message-ID: <CAJD7tkbZkuak=VYa_FLQVa=n+9Yd5EBXq5pc11GSiqn1fy7etg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm: don't hold css->refcnt during traversal
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kinsey Ho <kinseyho@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 1:43=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Jul 24, 2024 at 07:02:11PM +0000, Kinsey Ho wrote:
> > To obtain the pointer to the saved memcg position, mem_cgroup_iter()
> > currently holds css->refcnt during memcg traversal only to put
> > css->refcnt at the end of the routine. This isn't necessary as an
> > rcu_read_lock is already held throughout the function.
> >
> > Remove css->refcnt usage during traversal by leveraging RCU.
>
> Eh, I don't know about this.
>
> RCU ensures that the css memory isn't freed.
>
> The tryget ensures that the css is still alive and valid.
>
> In this case, it just so happens that the sibling linkage is also rcu
> protected. But accessing random css members when the refcount is 0 is
> kind of sketchy. On the other hand, the refcount is guaranteed to be
> valid, and rcu + tryget is a common pattern.

To be fair, the documentation of css_next_descendant_pre() mentions
that the requirements are:
- Either cgroup_mutex or RCU lock is held.
- Both @pos and @root are accessible.
- @pos is a descendant of @root.

This reads to me like it is intentional that RCU protection is enough
for @pos and @root, and that the sibling linkage is RCU protected by
design. Perhaps we could clarify this further (whether at
css_next_descendant_pre(), or above the definition of the linkage
members).

>
> What does this buy us? The tryget is cheap.

mem_cgroup_iter() is not an easy function to follow, so I personally
appreciate the simplicity gains tbh.

