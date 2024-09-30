Return-Path: <linux-kernel+bounces-343908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28098A122
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A003B1F250BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D734E18DF98;
	Mon, 30 Sep 2024 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHpXS+zL"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9014389F;
	Mon, 30 Sep 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697044; cv=none; b=kywp7i/cv4XKCAvl4W1jemJbArtNaDgBQHDC1/bSm/TpgmQiNoDUQg52nz3LD9GQN+1u4BO3BSy3P8Ngmw2rmVa00eFlV6Bcis7+emjcsHkVHHD5gkUW0cf/5iDFEHdc4W0M2VPoldmlnsk+Tg9FEUJVou/LAKZcQj050O+3tJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697044; c=relaxed/simple;
	bh=qfQ2EiZqD5vcsrovD8hhUoWgpRkhCrJ10vdyVg+F1wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTC/dC5K5bYOadzOWTrOxF3bXlalG/9iXjLYaMXxpUUOpaWWMIhUe9Ytum674gUQ+/0wBOnBialMkcbhvD7dIeSvDzaNuNGpRz90h7/pWu+poMdiHTwzAWsB6Yl9TNX43ed3xi0vLzqu2TNULTPqH0XRFlSAcgFl9EMeBGRsSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHpXS+zL; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4583209a17dso44965971cf.1;
        Mon, 30 Sep 2024 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727697042; x=1728301842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddZGWypd5cyuy1pCNayFxwdGn0BiN3JekvRbwCRmagQ=;
        b=ZHpXS+zL2irGotX5eeqxoawyvw4gPQb9bVRvexPXRNJ+USQK3OgF7P2A4KkSGxxAKL
         FX6J37pXqDWqvXz8QaHry90wpZqplOpswAAb7emTgAlFab4B1KCJVgGk6AZ8O1UimtDJ
         9oDtt+dWeLhH4QLRlwqkwYOQYDJ55CvcYnrxRnOFsz3QFtATkz8k0T2fz6h4CqwxQGev
         NgtwyH1V1jrWNDWdGgVwfEE5QreOwnWM3yiIpX8ItHhzZd1RoVecqwwwOzOGABPqICJH
         xTsNAFxg3dhhej5zzdD1bKg4Y0qpSMIts9/4A3IPEnJlK7r97XW2zZF6rQLyTYqvLIDi
         M2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697042; x=1728301842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddZGWypd5cyuy1pCNayFxwdGn0BiN3JekvRbwCRmagQ=;
        b=lnhZpST8zFkqhc7SqS2y4FV5ARoh+MOHr6hrfzAmsW+arJqV0yAL4Uyod6WRYIPpd6
         mSQxpeDXyEo5rvdeOQs6CnmeDgjpVLSLAkvEdbDTB4+Xj09D2gDUnLqAxqI/8KIQdSTw
         cnQyrbpI4MZqNuTRNBI+WGLIHLM4apEnY+1Ljzw7P/92fWb51v4F4I4jjbYI/tyLGnG3
         tN2zOo+27qXk3p9c+5VBvXAmW6L0gl9dCu+oXnmUjCDQiUuWXy+BZhveD5ab0ASDTJJ1
         eV1o0Rgc93Cw0mBTL3SVVeJjhfjGtnaJuSFMdbnpmuVU9dnjNw4HY8h42usVO484rpGS
         M1dA==
X-Forwarded-Encrypted: i=1; AJvYcCVsBTD+jdI6ZfY8cqs+IpYoXqF+kGFRWqOu4L+aStC322mYeg0FhsG4VrFZZ5PgQJkJ8QeNsU+9G607UaJvBVc=@vger.kernel.org, AJvYcCWgys8dswh9+TEyeyiqVD+289KNNfd9L9BgHE27InZQy5VIHDPbZ7rXNKjx8uapT9dK3X3bWuAVabf7sEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/r/Tph84pzKF5jqikHVUS3VatPn6NSTSVRUWUPnVyY/DUDLz
	pXOQHtpoWP5IdwLMev2KuPvOun5/nqh5V540eCGYspgia/ecAFu8caVWFLTLYml0PPnhimuunbN
	HZJ7dnymgAQlMUnSsADFs/Icby2g=
X-Google-Smtp-Source: AGHT+IE5SMhbL96JMTF0Ho4kCIdu+GskaC0oU6CLX+zbtIzmimhIHYmamGhNzOfp2zJtqqx3re/s4YGCH/4K+YjjPGY=
X-Received: by 2002:a05:622a:613:b0:458:4353:609f with SMTP id
 d75a77b69052e-45c9f2a637fmr210585241cf.59.1727697041600; Mon, 30 Sep 2024
 04:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM_RzfbQK5fzqXQN89JCEzD1Bz5ZtQdAz3xD0yaYFx_GC7Pm0Q@mail.gmail.com>
 <2024093044-emblaze-disrupt-d479@gregkh>
In-Reply-To: <2024093044-emblaze-disrupt-d479@gregkh>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Mon, 30 Sep 2024 08:50:05 -0300
Message-ID: <CAM_Rzfaa49C29kGf7YoUvhaADTQzN_QYvdNJDTfakU10=7U+Dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] device: rust: change the name function
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org, 
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> writes:
>
> On Sun, Sep 29, 2024 at 10:38:47AM -0300, Guilherme Gi=C3=A1como Sim=C3=
=B5es wrote:
> > This function increments the refcount by this command
> > "bindings::get_device(prt)"
> > This can be confused because the function Arc::from_raw() from
> > standard library, doesn't
> > increment the refcount.
> > Then, this function "Device::from_raw()" will be renamed for don't
> > make confusion
> > in the future.
>
> Please wrap the lines here properly so they show up in a sane way :)
>
> >
> > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> > ---
> >  rust/kernel/device.rs   | 2 +-
> >  rust/kernel/firmware.rs | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 851018eef885..ecffaff041e0 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -51,7 +51,7 @@ impl Device {
> >      ///
> >      /// It must also be ensured that `bindings::device::release` can
> > be called from any thread.
>
> Your patch is line-wrapped and can not be applied :(
>
> Please read the email documentation in the kernel for how to use gmail
> to send patches out (hint, almost never do so, but you can use git
> send-email through it), that will help you in sending changes that can
> be applied.

So, I really send the patch with gmail. But, I make this because my
git send-email have any bug and I don't fix this.
I'll see what's happening with my send-email and send the next patch throug=
h it.


>
> >      /// While not officially documented, this should be the case for
> > any `struct device`.
> > -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> > +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self>=
 {
>
> With this change, nothing broke?  Does nothing call this code yet?  I
> thought the firmware interface did that, but I could be wrong...
>
> thanks,
>
> greg k-h

This change don't broke nothing. The Device::from_raw() don't is used
yet. The firmware only have a Documentation for calling the
Device::from_raw()
and I change this Doc too.

