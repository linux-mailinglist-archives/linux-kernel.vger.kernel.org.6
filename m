Return-Path: <linux-kernel+bounces-537391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AD5A48B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9883A62E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356627183D;
	Thu, 27 Feb 2025 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2WBulhY"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57053225775;
	Thu, 27 Feb 2025 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694837; cv=none; b=UdGZnV/iZ2whfbeA9fAz0FRBLOao4tnR4umIncsG3hfvOGDmDNckkh6S65Nb+etmgTHA8k+9XZc4oQxybk426Rew9nfZXf5yVu88dmUr76yBQO+7RsUf3+WjW0YNVqQGb7Lci/BbwMCvhBY0Jny1w+3EMt2iPk+jb4J9J9C4iUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694837; c=relaxed/simple;
	bh=HMDvo7nca0IFV2djIVMP9TfMU1YDS9A4fyz5CGnL46g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3wbJBPqEQ06vBGpV4O+YGHIeWlmlLdA7Up3C5/kPXbKGI40ubiLwh/OGNLFYREJhtZU6YYHv8v48mNXdncLIVLcZlOXaLB9UbI4Cl90Shqy9es7IxbN34+YNcpcT9qdBkTQUGaw7h7622O4qrd3p6BAgBTkfOzk8g7/YHxzg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2WBulhY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f403edb4eso870740f8f.3;
        Thu, 27 Feb 2025 14:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694835; x=1741299635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrMBhcvnNde1i07KOFR0r6p8VM2SE3/ilITXzHNVp4w=;
        b=B2WBulhYuTZ2DtEjIYHr3hHP6bI6CCp/9gBmVJJbO6ls28OP0ptMd7sGjgb3CLK5uk
         f/i6uTT9qttPe8/f4Z5r7y1wADRNDpx/xgQdZOuOngqlhKmlpR/H1DsFDPO0LXYdx1yJ
         u7NcwD13uTKEWGne6+Ocve9dyZD3xMsXhdolVQuuO+9kBwQBSQh9rLgdPKlnwwrM+t3B
         Pr7p7QcQOGDdmx5mBYGliZN7M7bPdDGRVkW+A7iVBDVh/qQKkYNJJs78lLYeaj6AyOcc
         YUnLYcsIx26dLXQFvw5cQxd9aQ00WD9W9GgYqpSbpqPcGDcflVsgsXmdDpyzp9ZtW5FL
         sPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694835; x=1741299635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrMBhcvnNde1i07KOFR0r6p8VM2SE3/ilITXzHNVp4w=;
        b=KhlNApMMDQnEHs7u/7xESZ2B+PvlFIBGLrQXPlonjPm/WX3/ZFSezjRJVX1TG3wgnB
         jeaq3ahpgvezMUUI2JyyA0VqOxuFEMtVJixQUhzFEaXVQALYhnGNny44HzfAJmH5gmmN
         QkTooU1s0O792EiqY59S658Pr+8GCyik1h7K3n/BX/llhnRR3pdYJbCU5WG6XrVyza+W
         Cb+KobcGk9duE+/SWnKE1XHHrCsELF/ngOKqMU5QrTytju4bRrNIBeiSeK2fdZLbHN0N
         goZdWV+bmasGdTegGhRXohaFPy6Cc0K7EN6qoCzJQNfYNc4AObRYJSojLDkMtDi4uWz0
         DoBA==
X-Forwarded-Encrypted: i=1; AJvYcCUDq66OpHsAeHHp3B4HJMiVRdn3OZeA9Hht/Pdg3MrTIc1fxDX0A6vuFbFNY2j7RsfumUTpFsfNP3Xn9MANGrk=@vger.kernel.org, AJvYcCVAkFJuZjXCWUuGgmO8GikBMqAm5C5Sf8Ezu0oUnX6jsCYzdeNkjeofI9k05gjozTWLoIicNcza/Zgp740=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75FVE27SzzX23Aee4w/3gntMS6mkcf4L5tidDi7azbavFlXME
	dzpYuntV/uKruZAGg5oQrGvNTfz1exIKtjXo2yH22Iwiw631V4eE
X-Gm-Gg: ASbGncvD9h0lmbhbSB6EDJWvFLVeSxCKnoO2oGD4FddjmPZtSif8hUiiDoxQmwtsYvJ
	qg/fd6yVesT/vySO0TsnqLiZa3WSycKafO3dZhdzYXiQ0kYJfgm0AuStPB3TQ50WdBYKhDslc98
	iiB7wMmCKCzb5eSYLbKGsKjj0V8iYf4gv0nlcslgXBd5eWxsBMVjg13RytSWS1ej/Zbv9M5uTpg
	kSC9L9D1CDBwZTsTJU+7n5pcaKQTVaIuzDNP+hHvRH0qAGeS7sV/7jcsIuQWK3Ru+Ol3C1z+A+u
	nhrjxbLsYC8wytjA1RxhMVBaAZ5uj3Cos+ftZw2HZqg8xNgcgMBv3w3zFvEGpkCr
X-Google-Smtp-Source: AGHT+IEaqnAUI9UG6zLvTdn8dszXRMwLgW2Zlu6WgMIs55bnF0eZzkoVW8qvrLxaNKmcJm1y5wML2A==
X-Received: by 2002:a5d:598d:0:b0:38d:de45:bf98 with SMTP id ffacd0b85a97d-390ec7c6adbmr630691f8f.8.1740694833583;
        Thu, 27 Feb 2025 14:20:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6739sm3221628f8f.22.2025.02.27.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:20:32 -0800 (PST)
Date: Thu, 27 Feb 2025 22:20:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Martin Uecker <uecker@tugraz.at>, Ralf
 Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>, Ventura Jack
 <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250227222030.3fd32466@pumpkin>
In-Reply-To: <72bd8dc3-8a46-47b1-ac60-6b9b18b54f69@paulmck-laptop>
References: <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
	<ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
	<CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
	<20250226162655.65ba4b51@gandalf.local.home>
	<CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
	<20250226165619.64998576@gandalf.local.home>
	<20250226171321.714f3b75@gandalf.local.home>
	<CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
	<20250226173534.44b42190@gandalf.local.home>
	<20250227204722.653ce86b@pumpkin>
	<72bd8dc3-8a46-47b1-ac60-6b9b18b54f69@paulmck-laptop>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 13:41:15 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Thu, Feb 27, 2025 at 08:47:22PM +0000, David Laight wrote:
> > On Wed, 26 Feb 2025 17:35:34 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > On Wed, 26 Feb 2025 14:22:26 -0800
> > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >   
> > > > > But if I used:
> > > > >
> > > > >         if (global > 1000)
> > > > >                 goto out;
> > > > >         x = global;      
> > > > 
> > > > which can have the TUCTOU issue because 'global' is read twice.    
> > > 
> > > Correct, but if the variable had some other protection, like a lock held
> > > when this function was called, it is fine to do and the compiler may
> > > optimize it or not and still have the same result.
> > > 
> > > I guess you can sum this up to:
> > > 
> > >   The compiler should never assume it's safe to read a global more than the
> > >   code specifies, but if the code reads a global more than once, it's fine
> > >   to cache the multiple reads.
> > > 
> > > Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> > > And when I do use it, it is more to prevent write tearing as you mentioned.  
> > 
> > Except that (IIRC) it is actually valid for the compiler to write something
> > entirely unrelated to a memory location before writing the expected value.
> > (eg use it instead of stack for a register spill+reload.)
> > Not gcc doesn't do that - but the standard lets it do it.  
> 
> Or replace a write with a read, a check, and a write only if the read
> returns some other value than the one to be written.  Also not something
> I have seen, but something that the standard permits.

Or if you write code that does that, assume it can just to the write.
So dirtying a cache line.

	David

> 
> 							Thanx, Paul


