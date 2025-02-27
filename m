Return-Path: <linux-kernel+bounces-537386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89618A48B39
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322CF16CAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A01272922;
	Thu, 27 Feb 2025 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQwIqjww"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B47272901;
	Thu, 27 Feb 2025 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694689; cv=none; b=kfbU0wk/XOuZvgaZIhlfWw/gSml4NruY/SeR0WDb46OUvw8yDA1H38JbkJydJfa2CrzhZW106jcscZcYM1IWMLiJqPYxg8vSlXaB+UU8oF7199anDrkBxJXhzVgu6J702iqzja2JaoGCRONZdGcB1ZX511EzhMugQ9rQvqy4QWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694689; c=relaxed/simple;
	bh=dpLPdoKIs3LeqgrVPPxuOQBBRUH3k8TIgoIASRxT7pA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sebWuJ9OdzEjgm/sLQ68c9E+FcGS1Qg1rk2/I48EhPC/4jq83brzcwaA4ttJ0KZfnqzkJ++YgVkmopxszPLgkdvSciajHjqepw33/Z2r8xOR1NLuV9rYVFzx02305hIfcGZW9AGj70uzr6MAgtwr0umCP1PDFuzkfu2Kvzia+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQwIqjww; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso10012055e9.0;
        Thu, 27 Feb 2025 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694684; x=1741299484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qE7pAv4W7yuiRGioyB5dU0oQhIbvtWoB+MtssPnANU=;
        b=BQwIqjwwjDGG+6h6R2MoWaDpqjK+12a4U2o+6l7r8UX/bXY0DLXhtfsrHJ6CF6PtM0
         BHc4utV+vI/unmD+Hriqhhtxgf9dqu46nxDg/e9a47SznNQa2Tb8OGEY8joE0O/83ncn
         1euVQnvwXfmnLe38TudXBqiBzu+mGwQu6civPi01pbf8WRyUHy22eubC6IkPRV3dkUUd
         mRLlISoc1odI7Q7YtvtUh0CFQdR6VHZ0pb7GL64xKNhZ1pRbUIPx7HWOI2FPXHG2WDUN
         1y+/lYdMk+zVTtG+fGLrlPSkC/rHVXIKbUg+jM2XxVkJD1+n6L8sHSHpYKgl9omLqT1W
         Fh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694684; x=1741299484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qE7pAv4W7yuiRGioyB5dU0oQhIbvtWoB+MtssPnANU=;
        b=oq31hlJYfNIME0+4oGnsSb1ptawUumvaEmi7h5xXhsMPW+d7x5RnL4sMp6s8hdpgn8
         Wwz157wn93cu5Ws+kI8P28jWM/2lnIaaD6XwF0tiiFLelkNE3+jkCae2DE5bRwtQPDej
         a3ZMzfG0o1QlzPN+CKaqSeAqeNtyv2gl/stvmXFvwnlkEy8n0XS+Uwq5hkm343nDFzzk
         +MCQp2bv+IkbHdXtGrB7qc1ufHEi4KDvgj3q7BBacY/rqxLA+e0Robutn1t23XLL6Qan
         TIM7W2jPK6IMNzBvqSwm91Gjw6QwctAsNBis/N7mt99+zPXyk+DRIa6QpCAe85zolqHg
         1gYg==
X-Forwarded-Encrypted: i=1; AJvYcCU1HE4E4NkEPVIs/WA/sHpbfNM04orucVRSGJGWlEaTdKILd8LZzu6Tv9wtUJDYjdwCpQftnGIGlhN3aYRJSXc=@vger.kernel.org, AJvYcCVTaWk4LTqPyIu63VQSh3Nv5xKVxw5LZ5DQHBM06Mx6yDqtMlF/6wVfVLBJr2BUiyK5kNRTsNceg+sPcBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeopchN4oSOi3K6dztnVapjebTCUJyzKoCcNr7qLNoy7k8kf30
	AOZRO0/gELCocklNCiVqZchoaZq0Q+emopxl5eezjrGRPxm/fBht
X-Gm-Gg: ASbGncvkPZ2jmja1cWR6pAp36FBZwImPhexW+fbS/zzmLRgUfZekKkfBAGzltb2CWnL
	8ZKw8E/Ul9I66PUWFx78BPd3pZ98/UmmjxiXoqdInGYcqOmIiowVwc6f7ZXcm3LAO45vG5c6/LN
	9pJCPkIuRylD6DJPKpE/Tbm1DzUX5xRh/jztle2Uii5r3/G/d7xA5kzq+4tjf9HyM7uvIU9b6/1
	QQeN2l7Z0H31CxvZiOz9J78dkWRGl17Svq5R9/vUkEPsiQBy8C7kP5YGUVlJUmkY+zclMxcs+8c
	ObYqQmbRoWmMDprrLTgQRAEDUNhwp+mmvnAKS9LStk4eLZTFB9mW0bkfAh1LIZy3
X-Google-Smtp-Source: AGHT+IEIpLxegfdcRnz87rqWS26ts4HVv2BxORGQ1GFs3CHTjTrNYdNUUZHlhyGNdIE5bGGu90EjBQ==
X-Received: by 2002:a05:600c:4351:b0:439:96a4:d2a8 with SMTP id 5b1f17b1804b1-43afdda613bmr39443845e9.5.1740694684396;
        Thu, 27 Feb 2025 14:18:04 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27aa85sm35486045e9.28.2025.02.27.14.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:18:03 -0800 (PST)
Date: Thu, 27 Feb 2025 22:18:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Ralf Jung <post@ralfj.de>, Ventura Jack <venturajack85@gmail.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo
 <gary@garyguo.net>, torvalds@linux-foundation.org, airlied@gmail.com,
 boqun.feng@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250227221801.63371d19@pumpkin>
In-Reply-To: <rps5yviwyghhalaqmib3seqj62efzweixiqwb5wglzor4gk75n@oxki5lhsvhrf>
References: <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
	<780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
	<CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
	<f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
	<CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
	<7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
	<CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
	<d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
	<CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
	<651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
	<rps5yviwyghhalaqmib3seqj62efzweixiqwb5wglzor4gk75n@oxki5lhsvhrf>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 15:22:20 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Thu, Feb 27, 2025 at 08:45:09PM +0100, Ralf Jung wrote:
> > Hi,
> >   
> > > > > If C was willing to break code as much as Rust, it would be easier to
> > > > > clean up C.  
> > > > 
> > > > Is that true? Gcc updates do break code.  
> > > 
> > > Surely not as much as Rust, right? From what I hear from users
> > > of Rust and of C, some Rust developers complain about
> > > Rust breaking a lot and being unstable, while I instead
> > > hear complaints about C and C++ being unwilling to break
> > > compatibility.  
> > 
> > Stable Rust code hardly ever breaks on a compiler update. I don't know which
> > users you are talking about here, and it's hard to reply anything concrete
> > to such a vague claim that you are making here. I also "hear" lots of
> > things, but we shouldn't treat hear-say as facts.
> > *Nightly* Rust features do break regularly, but nobody has any right to
> > complain about that -- nightly Rust is the playground for experimenting with
> > features that we know are no ready yet.  
> 
> It's also less important to avoid ever breaking working code than it was
> 20 years ago: more of the code we care about is open source, everyone is
> using source control, and with so much code on crates.io it's now
> possible to check what the potential impact would be.

Do you really want to change something that would break the linux kernel?
Even a compile-time breakage would be a PITA.
And the kernel is small by comparison with some other projects.

Look at all the problems because python-3 was incompatible with python-2.
You have to maintain compatibility.

Now there are some things in C (like functions 'falling of the bottom
without returning a value') that could sensibly be changed from warnings
to errors, but you can't decide to fix the priority of the bitwise &.

	David


> 
> This is a good thing as long as it's done judiciously, to evolve the
> language towards stronger semantics and fix safety issues in the
> cleanest way when found.


