Return-Path: <linux-kernel+bounces-425401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA749DC194
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC0B281F10
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEAB17836B;
	Fri, 29 Nov 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSA6j/IE"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF014F135
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873189; cv=none; b=MxGLT69ELNlCz3muZlTW9jQDc/YjQIOY5iRdbGZ2OGt48sEvPEyUyZ90bfU9lc+dJMqRtfWZYrci+T+74oCdx83Z9P1DYJy591SpXiLrXpnB8EEr3NQSJ7/4tZFcMgJduUSJ9COFMIXdRMUjN5gCew6IsboRJZA1tEL8IUDVYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873189; c=relaxed/simple;
	bh=L3osPo90oS2YjcMtWFuj0/oOrtLAaDGO//RQeyLR3Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEIJRGVZ+An7SzrlG9bwGXNeS7q6xoToK+qFg4id1q38itPPs8NGMhzVWRUhZs6wwkHZpDEiafNGdRYJ+b0v30O7LVcsVcWowVbnU2wZfJNwqpMkbY8MVJzFGMOwqLUh0aGL6Qo3ill/SRmFrYsp7mUJgBQwXVOrvcmrlq8VWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSA6j/IE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385dbf79881so384108f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732873185; x=1733477985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT81x1pPOl28Snzb/99o88eoaL2m9foxASU5Of2oJ18=;
        b=FSA6j/IEvwxRMhTj0gF0JqdsHenqP87bWORKyTMdCtX97/JI2TboHrYORoa/3+v4ca
         lYrx7WJqJoIkJyl7ylpethKcdCCHaSJMTivNzqP4QhHIP+whYMDDxDKkjtF4wNDCUACC
         J5N8mH6yB3f8rS2ajAV1NSkHFCJ/y53o0977JH8O1eRJWsKiKmseTfh987HoILXXFvGJ
         q4WjQ8fnZv4OznDq4/yTUaNI9dd2YRXw4NwjrpSCL97idM7rpnr4oPmp5rs51RjZ9QSp
         GAfSDY+dswjpaUAXV09YDVSAIP0A2sIuGvJYdrrd7xla2SG94q3gwkjAz/iZrZMUe1Me
         As0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732873185; x=1733477985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GT81x1pPOl28Snzb/99o88eoaL2m9foxASU5Of2oJ18=;
        b=j/n73F7y/5FHb+hzlYGbzzjG5RIt2+HNZswhp46Ii5DzzZ57wRS1ru7VZu37bH5rjx
         b1kW6mz9bbDU5zo92/UPjjCRoS4v2k+sBD+I4bAl7SlQ0oqWQTRI/IQsOS7oSG01jdw9
         H4NVFQ02kU2wM6EdOBRUrFQlfmR5kL4iBm/8uvurN77LJOx8Fe7M5JDfNgk4IvGqR34T
         0qHIUMciquTfC7u3Se3LLX5sYhn+4wYm0WuU5KOaUl67bGpxL35qHj7I9Zk+q+bGC8dp
         tNxPnY2k4hImQ54nXZuWX2PA0pmh/K1vBGivQmu58opcWa29SUJrmVTxg8XXJidOSAvS
         Moew==
X-Forwarded-Encrypted: i=1; AJvYcCWxOU/92Tqu53hgnuU4TcJY7tGknZ7LNXEDZ9Y+2JpjnSruSo5QsSXG60OyAO39b1eRr14WbSAFdVkI70U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxABRJUbEybAehuTklBx46YAT3CIzhFWjFfCIZZG8JQMJ2ifwTZ
	grdS1GMq6B1vwRlWS0zb8MjXUrAf8H8KsJF7tlJLgDgce051jzDEF5cO/v9Qxvvw1hZjA92bICk
	E6+WKZNioi2yyaaYwwCQFbX1+ViW0rrXls2qV
X-Gm-Gg: ASbGncuOY591xa+Fd8xzHlq4cXGKEOzc7Fzivpo49zh8PK6fxyUF4cqWrCJl6v8ixvX
	cYranF4U++IIU8p4b3dEbvjrP7FdhTxH47YnvsXi+fJVhX9kbRMqzfAmEzsW53w==
X-Google-Smtp-Source: AGHT+IHY54qZUYFh/rP95d81UhUWr1C9OkxG5bJJIM/6YiD8OXmaBDPNhQwhsb79jT1ZPBps/8tz9O4ifcPbEOACApI=
X-Received: by 2002:a05:6000:1787:b0:382:2386:ceaf with SMTP id
 ffacd0b85a97d-385cbd89c39mr5852413f8f.27.1732873185258; Fri, 29 Nov 2024
 01:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128141323.481033-1-pbonzini@redhat.com> <20241128141323.481033-2-pbonzini@redhat.com>
 <CAH5fLgjJbzAbf5CO3xjHxcThpqju3j0tNdo+QiGupARVmoThYw@mail.gmail.com> <d7f045c1-79df-4592-a116-01874f402de4@redhat.com>
In-Reply-To: <d7f045c1-79df-4592-a116-01874f402de4@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 29 Nov 2024 10:39:33 +0100
Message-ID: <CAH5fLggHKuYT+s=tejnF-N63QOwcsAAeWb+LDLe0uO1sT3bdsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Zeroable: allow struct update syntax outside
 init macros
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	boqun.feng@gmail.com, ojeda@kernel.org, benno.lossin@proton.me, 
	axboe@kernel.dk, tmgross@umich.edu, bjorn3_gh@protonmail.com, 
	gary@garyguo.net, alex.gaynor@gmail.com, a.hindborg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 5:43=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 11/28/24 15:40, Alice Ryhl wrote:
> >> The definition of the ZERO constant requires adding a Sized boundary, =
but
> >> this is not a problem either because neither slices nor trait objects
> >> are zeroable.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >
> > Slices are zeroable. I know they don't implement the trait,
>
> Right, I should have used the uppercase "Zeroable" for clarity.
>
> > but they could implement it, and this could be used to implement e.g.:
> >
> > pub fn write_zero<T: Zeroed + ?Sized>(value: &mut T) {
> >      memset(0, ...);
> > }
>
> Yeah, that would be I think
>
>      pub fn write_zero<T: Zeroable + ?Sized>(value: &mut T) {
>          unsafe {
>             ptr::write_bytes((value as *mut T).cast::<u8>(), 0,
>                              std::mem::size_of_val(value))
>          }
>      }
>
> ?  And it works for both sized values and slices.  If Zeroable is
> limited to sized types, I guess you could still do:
>
>      pub fn write_zero_slice<T: Zeroable>(value: &mut [T]) {
>          ptr::write_bytes(value.as_mut_ptr(), 0, value.len())
>      }
>
> So the question is whether the ZERO constant is worthwhile enough, to
> justify the limitation of the Sized bound (e.g. having separate
> write_zero and write_zero_slice in the future).

Why not both?

If you change the constant to a const fn, then you don't have to rule
out either use-case.

Alice

