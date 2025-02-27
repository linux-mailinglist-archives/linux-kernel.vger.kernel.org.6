Return-Path: <linux-kernel+bounces-537285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1EBA48A16
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37809188FB7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9F270ECE;
	Thu, 27 Feb 2025 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCCj4EBq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC00225405;
	Thu, 27 Feb 2025 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689248; cv=none; b=OV2wlefMsXePNZpxidNi2nPaqh+JCcNWjNMFgmA32sq1LXRSJDrier91zh603XrFWFCTi5jF7GQc8vc3QlPMy+QxQTRVzijdeIf6g4ioodSEM6FXn9BhOUorat8eiPJO2MVTwQEo1ZOcpq/w2S674Jgm2lQSofKEZ8sSEmTszjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689248; c=relaxed/simple;
	bh=4Cz2YpoTHmPtHkOS68fh+sUr/fCWd1Ola9ZLsLZtMjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZMNPp3g22jZZ/bf7avgQNDp/r69p3fxsUrGsAQk+UIaRBERI0SU9r6msswiI8uhnlhSMIeDZsn9Jv+uv5T5opikk9P8DiC5TSCeZroGJZcTScRWlJyh1uaMFTwxcNlc0vkqGNPBvfYtug/RjAFYs1xKwdoTX4SHPgNIvpLxxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCCj4EBq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399deda38cso9815865e9.1;
        Thu, 27 Feb 2025 12:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740689245; x=1741294045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQQPqcJQz5kC+gdnMR2nVLYPbdgKeZprBZgNoDqESvI=;
        b=aCCj4EBq3e8lr1az8BIvJWwXFqsPt9Bs9/QZYI1yxGlu5MvUqVPqETdK0AVzyAj14D
         ZP+lM2zHQGPqTCobhdbsiToR7bpOthXtkpPhD+IIfX1F096tpu3yO4ih0zfydCrjsF5i
         LeXdUTRl90Rej6Bbl2AArAc514Ua8RNmFlrtLaN/oLNb4aPnTVlUbEd5J0cLL0J29zmy
         wWdw78oS8EITNka1mEdF8Au9o5DqRePDfcGcZWLj4BPGjIqCAR+aUkqyndXWBoZTSO/m
         AbMYVCRHXg05T1n9JBPLrt8I5miOsO4ItnKcTTwbWd5gPfw5H40OpTRhBNJCe+vE/JQ1
         6Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740689245; x=1741294045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQQPqcJQz5kC+gdnMR2nVLYPbdgKeZprBZgNoDqESvI=;
        b=ejEcPcPXAkNJGl4DJiqnMzs693+B1PUh4KHdmp8+UUqY9LHpWUVEwKJkWWGprUD4xq
         O2uqjY9s2s94sdILmhz6PMXnTDizUrYx+qy+6Ux5hsJRbD/pdxuujdUztkRVLzUPrmb1
         GCfQviX/9vCw8aFC4eIiy3grMh0AL9lOJaCJJiNE1ZKjilTuNE4lEaD78GmYVhF4W816
         VoRNaX1ZXoKBqihqvAKL+xhfptYK/Ms/Gmbu5R5TKtTX452cSh9Pg1D+bBKdVf+Cz1Bu
         7JNJS6yP0GH30AP6AtBPXQPSOEp1wnIODvmZGZkxB2cffmMTypuCkBbtscsgb/oqda7P
         0xuA==
X-Forwarded-Encrypted: i=1; AJvYcCU2IjXPAt2v0iOWIH6ofbR+iEMpWvWk5Kp3i7HEyWCWWsIEG163u83xA9w6VMg5BMrGq04/j+WFzfECVQc=@vger.kernel.org, AJvYcCW1cvxeLvxO56wQswQKxCq/I2Q4C0moVlYJOyrTYnhg14Pu1gRN16CQD7SOIofihHQIUQGQwGvh+yu2ynlDSXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNyvx9sEdJNBPLW+zmJO+zpPri3gKPjT1b9lhDJpYXUvLNb+q1
	JDsa+9TrQ01yGT1y16IcjxI2w0/xn6LfStuZRZMuAjXiWq2UqtXX
X-Gm-Gg: ASbGncuC42IRskAc4DT0K7LUNoEc9m7+i6eF5Yi6TOy4tCbQebMfxmTqorOBr8xTU4L
	mOLWjaP1ssz2J/W3xklh4KtXFT9bsz3CNAfJn+tBB3R3PE4cMghEyBo0gd/avjVmEmymJz591Bb
	1rubUW2kP8hXpRlkhQTCTz/spd/MTW6Q69RSSAcOG3RLg13oOJU6pKP24e0FA0xVsR5O9CqHvOM
	B/Pl7Sc1xUL25XD4dP69+CbEMjV3NzvUASfdrKWJwDFpLdjYfQegWaNam0OeaEHLG7kDCkJT6+V
	kE+0ihm7/3l+uB0UUugOJXKzoZgIYEzKWJ8oqOvDnQEQTiIVHXDP5LAOwv8UAXiA
X-Google-Smtp-Source: AGHT+IELp/ltp2+Tc9OTbSKyIGmqwP78lBZ8wP6ARPo+Nb6Lsvnj4kNu47cm6JSoAPSU4T43nlym1A==
X-Received: by 2002:a05:600c:3506:b0:439:9828:c44b with SMTP id 5b1f17b1804b1-43ba6704220mr5378135e9.14.1740689244666;
        Thu, 27 Feb 2025 12:47:24 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58717esm65285695e9.33.2025.02.27.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:47:24 -0800 (PST)
Date: Thu, 27 Feb 2025 20:47:22 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker
 <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Ventura Jack
 <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250227204722.653ce86b@pumpkin>
In-Reply-To: <20250226173534.44b42190@gandalf.local.home>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	<CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	<CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	<CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	<CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
	<5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
	<CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
	<ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
	<CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
	<20250226162655.65ba4b51@gandalf.local.home>
	<CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
	<20250226165619.64998576@gandalf.local.home>
	<20250226171321.714f3b75@gandalf.local.home>
	<CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
	<20250226173534.44b42190@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 17:35:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 26 Feb 2025 14:22:26 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > > But if I used:
> > >
> > >         if (global > 1000)
> > >                 goto out;
> > >         x = global;    
> > 
> > which can have the TUCTOU issue because 'global' is read twice.  
> 
> Correct, but if the variable had some other protection, like a lock held
> when this function was called, it is fine to do and the compiler may
> optimize it or not and still have the same result.
> 
> I guess you can sum this up to:
> 
>   The compiler should never assume it's safe to read a global more than the
>   code specifies, but if the code reads a global more than once, it's fine
>   to cache the multiple reads.
> 
> Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> And when I do use it, it is more to prevent write tearing as you mentioned.

Except that (IIRC) it is actually valid for the compiler to write something
entirely unrelated to a memory location before writing the expected value.
(eg use it instead of stack for a register spill+reload.)
Not gcc doesn't do that - but the standard lets it do it.

	David

> 
> -- Steve
> 


