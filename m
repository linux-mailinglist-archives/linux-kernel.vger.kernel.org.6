Return-Path: <linux-kernel+bounces-180395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8938C6DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5121F22500
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0715B548;
	Wed, 15 May 2024 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwvtWq94"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907801FC4
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809346; cv=none; b=Avn5soeAtZm5Hb+NODnvCyUAZMwf0HUsa7IoJybTRHpBEficcNlur5JrL8nPudBTdNZUCUYieCYdnGzY2RATXLuPr2WePIKjvR72KvBlznpZSgTWRHrU2J5YJht0sp9c5EjnMnBi/nXqzq9msUXWv4ZR31UXn4vGNcBj5W8M91I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809346; c=relaxed/simple;
	bh=MK0GT5U6TGjZWZCbbcndd1n1OAqP1jMr72KmQoMHoso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAePf1iCMLK7yA5lBnnE5ZLjVwLi2VJyHykUd1cgkdkJI3xBPW45DqgLlq0rsCySCc1yAYkrpPCsaFpMo7Ee8CrVzwrdEkQDx2gAElOYK+T7Iw9RbFF7Z0JTwgH8yReg1ggEWgzjo7W/LwD73xrBkPc+0DHDaviLNOseKDq5Nhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwvtWq94; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7f34ebbcde4so2265390241.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715809343; x=1716414143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuWaZOrYxVBktYIPE8wQ9/5sOB1xMLG0jqqM5TYjEm8=;
        b=cwvtWq94SwDFYs0pPfsiS7X9ceWF8WkX1cvPc7dzDlAicJ21s8MlihDdaSwE8ty2s/
         kPNW44JReIACblv+zXsyUy5GcRwV/haMxFOMgdYs1b+IQcy4YHS/WGAevyGtS168R90K
         o3BA0JVBqAC+65UdLt/8dxZsg9wskt5CN12f0+7eFAntwYYlJnoyONoM/5+WhRabGErV
         3fUoDd5hRX8gEOOTIDPk0qY7dgzWDkUckfzL/QiREed3y65yrMWdrvxaxAorW3bHdz2u
         xoTSlBxA3MV51LBXK08pB/q23WXZE59d09MhfbV3wJX2LSVi68bERIHtSo1+0wkX6G45
         ZHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809343; x=1716414143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuWaZOrYxVBktYIPE8wQ9/5sOB1xMLG0jqqM5TYjEm8=;
        b=KEUqIaTXDUpU7wwphDGenOLEoRIHPSFc38fF06BrX2UFK/F/ZwsyyB4x3ifz12coZr
         LAfZHoIQDNsc4Q0VymOktk36k10XnGYZcjmwB1yH2FbpnaY03zO64Zj7hsqwPnN7SR/W
         KCY8ZoYo1lv+zPTY8wQg2kPIF5oxkXJ/vfjcoEW38sYTotC5t25zNqfG5bwdQBi5mue4
         mP+m9ogZhS2sCfMD65ewBq1PgJdg0B6QFLfvIJJih5LJdIrLNaRGBONuJpNX8rlO2QS+
         hmdi0PfSoD39Q5tw2nNkvv9V2vZcUqK4zCobGXvy59Fpm3ljudypkiEa4Cfjv7moFQuV
         gdhg==
X-Forwarded-Encrypted: i=1; AJvYcCXASm6zRrP0PYhoqdSJXW8kscef1JH87wfqVHsB5i2D0mnSpfDMHc7sOb5bSNSdnOITcAsnx+pCFKu2woxzJYhl7iS9rwGpm96/SwDu
X-Gm-Message-State: AOJu0YzUmYhVntKCcsTtF1BM3OCFSk7v20j3GAIp2lWnaDEFCJbjA6+J
	+U72MqZpzhPH97NSfjRHtRL9EK5QFkFvSmWCECsDfg1UJxUwS+mIDZ2TwyxED3XOsf6w9ZcIB/f
	iO0aeiCH21jNORcgBOrG84/tBjhO8HVC45zo0
X-Google-Smtp-Source: AGHT+IGTR+bti0CQLCOZ5eyh2lgs75ddRrOKhCJ1KKNZmIYzL/+erBlRT7fIv+p78lv4lO+RDEBRJUjnefqT30gubco=
X-Received: by 2002:a05:6122:1699:b0:4df:1a28:5e3c with SMTP id
 71dfb90a1353d-4df88138a64mr16748298e0c.0.1715809343258; Wed, 15 May 2024
 14:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514160926.1309778-1-cmllamas@google.com> <CAH5fLgjzVHSAQBF5-C1BthK1jspAGRr1z4SQXdQepkeVL9Eq2A@mail.gmail.com>
 <ZkTlG-ZNHRYXnHLQ@google.com> <ZkTmNLxhlPlHdQCW@google.com>
In-Reply-To: <ZkTmNLxhlPlHdQCW@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 15 May 2024 23:42:11 +0200
Message-ID: <CAH5fLgi1YUE7DHV86GcZaaUKX+RDkOXwHqKBRVR3YFyj0T6dLQ@mail.gmail.com>
Subject: Re: [PATCH v2] binder: use bitmap for faster descriptor lookup
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Tim Murray <timmurray@google.com>, John Stultz <jstultz@google.com>, 
	Steven Moreland <smoreland@google.com>, Nick Chen <chenjia3@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 6:43=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Wed, May 15, 2024 at 04:38:51PM +0000, Carlos Llamas wrote:
> > On Wed, May 15, 2024 at 05:29:29PM +0200, Alice Ryhl wrote:
> > > On Tue, May 14, 2024 at 6:09=E2=80=AFPM Carlos Llamas <cmllamas@googl=
e.com> wrote:
> > > > +static inline int
> > > > +dbitmap_get_first_zero_bit(struct dbitmap *dmap, unsigned long *bi=
t)
> > > > +{
> > > > +       unsigned long n;
> > > > +
> > > > +       n =3D find_first_zero_bit(dmap->map, dmap->nbits);
> > > > +       if (unlikely(n =3D=3D dmap->nbits))
> > > > +               return -ENOSPC;
> > > > +
> > > > +       *bit =3D n;
> > > > +       set_bit(n, dmap->map);
> > > > +
> > > > +       return 0;
> > > > +}
> > >
> > > Could we rename this method to something that makes it more clear tha=
t
> > > it's not just a getter, but that it actually also sets the bit?
> > >
> > > Alice
> >
> > Sure, what were you thinking? I had picked "get" and not just "find" to
> > indicate this behavior. However, I'll take any better ideas. The option
> > of dbitmap_find_and_set_first_zero_bit() seemed too long for me.
> >
> > --
> > Carlos Llamas
>
> I like dbitmap_acquire_first_zero_bit(). Sounds better?

acquire sounds good!

Alice

