Return-Path: <linux-kernel+bounces-228109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139AD915AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBB6B2122B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514B12B93;
	Tue, 25 Jun 2024 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSL0Dwx5"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA822125B9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274759; cv=none; b=WZz3mSIjnk8d01p16LVWwbqN6HEfaMz97OfjxLXVbZdw9hRlgZKYZsDODf5Cvn8Crq87ceklLcpkgfpqencBmPI9JeSQyrNNtAm4iPkfArHe3VXVfy3arIX68DCREdq/gNVzH7aLr3pMTeagei+CyGwC5cZaOKJt/8+vdsBR3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274759; c=relaxed/simple;
	bh=dckFVr3/GfUH92A9tYvvXeg00H4lY1QYlBaJfiJl24g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwhVbvveOxtOgHWTicLrKGhGHNff4QcqnOuUjzfHtuxA1cguFIpbJlWn2zfO3c7mcW8cVilhosRvOrlNFMvpke4flN05a2ZjguL9XdDkjX1MSYn2OkYbFQr3yqHJcjeyc4eWERPdBhLnDFJpmq9t2Uj49dMtDwGD6JMnAatTI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSL0Dwx5; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f8d0a00a35so4616585a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274757; x=1719879557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pyOoMK7V4v4BHzPq80Mqo0kstWoJWiliHgL/3qhOFw=;
        b=mSL0Dwx5QXfcT2NqCNsKGpEVTZS57M9kmDBb4BbbJF+wdn0eievwx1ArV9uGY2Js5K
         oWvQuc6qqWoT9dn46r99XuQ6SqAhTNiBrGg+epVYD7YXdESUk09baWWvmdJprW86a8Aw
         3zEdCWu8XliXFGVuHqiH1QLp0qUhm7+VpX5jTfLTiWClinRIgT9MnuqMNksPju2wh430
         GltFwuEr+rec+vOQxyCCUBkjBKkT2OXF/XDUSrsR4gkLPDwAKkiJkgnWX2oaPcUhiOt8
         tC9PrstTBgWyxI1m6BULvgpf577d5Pq6Do9BVqh8QMOLxHKkyJXN1GZoXUCq6WhFypP3
         MXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274757; x=1719879557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pyOoMK7V4v4BHzPq80Mqo0kstWoJWiliHgL/3qhOFw=;
        b=BOvodk/xEtUfTR03cVSn0AQAfaZzOlL4PLU1QeD9/fGeRsBbz3IK2mKt9aSWl6co3b
         kgGQM2kspWIiKpSqGB2v7JLuAlqGNc5J7dHBIe1eVxtZoaC7ow4pcTHG3XcKK7Q8Ph/6
         iWes/E6sHsc4HeWIYctWtETumsNdU4eWdtE5Ko14KkFFf43zp0IWZxNxx1nu1rVH8S0B
         rMoD7+LxGSsDa4m7LZtSkq+80bDAllPbeki8j1SYuzjKOXD+aJ9A0GMKFe2VriCnUvyI
         Qlul0QfKoILbv3ZpCn/+DuGQiXbtS2nr4RxDT8PChfwj40PXhUI2o9ZJ3/lgBeHIYu5W
         eEvw==
X-Forwarded-Encrypted: i=1; AJvYcCUqh4Y8PULPfWrADa5RFIxqnw/f2ffSneuYzmHH91E0RhJ4xPQ4/VKDZlkhSVwtyvHZH6+o2kZj6OFoXvRJJAXk96jFcIMHU2NWBTK8
X-Gm-Message-State: AOJu0YwRNzRNiKm9PlB+D5DzaILN5WC0Hlngakxw0l2+xIfV0gE1/Zf2
	FeekzTsYZoWiil8cxC8N60+uB6zT+TsijYS2T12NEwVhBoWqf2U95JY4Ti8DRrcBzyUeb8GLwKp
	VMm5A31OPG7GoUJi7hCZrj+QxPL/s4jv+64r7
X-Google-Smtp-Source: AGHT+IFy/0niS7cFsouCtNPG/UmEBy1HBCOzAzSpsKxPjsRrOkvuz+x0iZWOJL7T68SwJpYrHYoV5jOp9u0qfWXjUqw=
X-Received: by 2002:a05:6870:224b:b0:254:7936:e1df with SMTP id
 586e51a60fabf-25cfcdf8cc9mr6578086fac.22.1719274756681; Mon, 24 Jun 2024
 17:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523014540.372255-1-avagin@google.com> <20240523093334.GD15163@redhat.com>
In-Reply-To: <20240523093334.GD15163@redhat.com>
From: Andrei Vagin <avagin@google.com>
Date: Mon, 24 Jun 2024 17:19:06 -0700
Message-ID: <CAEWA0a5tUkdbKH1UBE6Yw1uW5tdAMLehmOm9Q15ypPivo0-heg@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] seccomp: improve handling of SECCOMP_IOCTL_NOTIF_RECV
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 2:35=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/23, Andrei Vagin wrote:
> >
> > This patch set addresses two problems with the SECCOMP_IOCTL_NOTIF_RECV
> > ioctl:
> > * it doesn't return when the seccomp filter becomes unused (all tasks
> >   have exited).
> > * EPOLLHUP is triggered not when a task exits, but rather when its zomb=
ie
> >   is collected.
>
> It seems that 2/3 also fixes another minor problem.
>
> Suppose that a group leader installs the new filter without
> SECCOMP_FILTER_FLAG_TSYNC, exits, and becomes a zombie. It can't be
> released until all its sub-threads exit.
>
> After that, without 2/3, SECCOMP_FILTER_FLAG_TSYNC from any other thread
> can never succeed, seccomp_can_sync_threads() will check a zombie leader
> and is_ancestor() will fail.
>
> Right?

It is right. I can introduce a self test for this case too, but let's
do that in a separate patch set.

>
> Oleg.
>

