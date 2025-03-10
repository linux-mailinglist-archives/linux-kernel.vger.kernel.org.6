Return-Path: <linux-kernel+bounces-554064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE96A5927A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364F41888F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBDC227EB1;
	Mon, 10 Mar 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3lN4gNa"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96089227E82;
	Mon, 10 Mar 2025 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605292; cv=none; b=L18KjAMxUOQnPcH10MYbC3YBbk/SRnu6OwZTP02O5RALINlMllbyROKyxI5wpxvxQZQ+p3XltSpTx8FNb/D5UcNtAVgDs+G0f/FM/6ynhXTserlgqJgMrHQkSIRK+uttH2mJQRE5zLVYGSB3rTS7p9l4rxij55o6bNVLY2krYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605292; c=relaxed/simple;
	bh=J54wRrQQVJSLJARGl+xEZiKGzz8RGZc2ZSKwijSxwcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqjewJt1/1EGFEjiEbuwUcnlq9/r/TPvkHGR9CtSYR7s8kUC+w2im9qV7534bIPGLaVSEMj8rz80Gjpv/TqQHFrCqqGXA9odGW/HKVyNbD1j+HxEpr4rkJpSeNquxoc9XFeaKyQzCReZS8ydOR2hxUaGU8y09T/xhihc9E/MoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3lN4gNa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22409077c06so2115185ad.1;
        Mon, 10 Mar 2025 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741605290; x=1742210090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGMLPsPxAByIoDsl/7WiYU+MM6XdL4aeR3jkWi/CCYg=;
        b=S3lN4gNalQmkfnLJMkxlkwtD01Ist2WlUpkn7gmgKg1BN3ghGvRMVome+Np8cSmD7l
         t3eZmApiVVaPQX0pokhJNH/hqufM6RKwUj7uDXWNdFvoBSonlubxJ8E/pqDUQlGgK9IR
         xJMI+A5wZcxyz3Yn4hSF23CPbyWxR5N9FRcWPzK05szgRDX43iRv+94kTYli/vN9HR+C
         aGiPslWdGr9shvYD2ONXrGU43su518gzu7MZo0vT2+9AFHyDL/gABmtU4+EZ4ILzdPAl
         bPhiMlw8zokkDlWcn3N6WTXo0bO0w81SDwnRr36vimOni7ChQtBO4Y80B6wrVhXuVPi8
         iWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741605290; x=1742210090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGMLPsPxAByIoDsl/7WiYU+MM6XdL4aeR3jkWi/CCYg=;
        b=KEJMpBU4r5VqSW7yb1FPFVfhu9hXzrEDsbDVCvY40LE6f9DySi3yKeYK6IsjC2lHFy
         Aa8UNIk63+8aViYTaNwCqAne2sP4uYpbg0sF5LlseZ4iVm6O76kUbKgRxUD/1/Tc4v/n
         rVaVLo83tOj0UK/PM7IE03KbuSFQH2UwPAM7eeI9P9a0usMjPgoG8ASIsDNa7bRdfpr8
         8swurMLNxTkYMFBxGXGEyM62f3Oihl0l82dChzjphs7tvYdTdHZxCuQJCDE2gRbY2PJI
         eIF7dCxpnABlEV7YvE8qFuxQD7qfPGvg8tOfvE33y6GV1sf/wt9xdgowkIJvW5KUeTWJ
         ECGw==
X-Forwarded-Encrypted: i=1; AJvYcCUhu5VlfQePCs7B81K66cvOlMYyI/YeKdVtZKoWJOefxnURlQUrJNorFvUqdIyokFyGQcr53S5JWF7PRwhi/7A=@vger.kernel.org, AJvYcCVioElw411BeHEAbB2KQKXr+cKjXtnm4DFBwrmdk11BSPbS+bRmsavd/Bti5OzMO7uTXj/+g0veNqowAwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUz+NyK7BMlWRmVxEkpaLQ8PutOrZAKhSiRE8LXuzhSQxBDeuz
	C9ZGiiBPJeHixuot4pCfXAE9IU4CxDfWGgfr3vFzK7Tc7YbXssYb
X-Gm-Gg: ASbGncta5VQTIb8AKohsmOMhYMOJQZmRU/7f6JC4JKnJ7WFa8jIKHCQZNLmr8Rzgtq7
	K6mxVWshE2u2mdrDQVk0eES7b/FtBcGtxNeYGe2I+NiXXJfyUu8znroKDCr14lqw7RFIAY+sha+
	mZ9WPu5dyhUmtyLJMgwiKxLnnEZZ5WHRSucfqs4pkiOB6ms2OuXzPbywZMlHFytIveLqRzCSUoJ
	1yiELE0lz3TLXpe1H93U9y6i2CgnFnCB4QuuYiq6nG5iwrf34sYyMWeBzZO+AJLHtB3xIFTX4HK
	qx1i9AStC5iLG8LcgUhf5GWRXD2s/tfYALQsQXBifeoxGGihM41sdnPs8a9VogZo3cQLOviJ
X-Google-Smtp-Source: AGHT+IEKcMqT8qMmkXop6BbmEzOjN9wFaJDBkqRHfpR/m+dq6KKezCtMdPfy5IDlm/YNjV+o9m6GgQ==
X-Received: by 2002:a05:6a00:3c87:b0:732:a24:7354 with SMTP id d2e1a72fcca58-736aa9e74b6mr16966200b3a.4.1741605289737;
        Mon, 10 Mar 2025 04:14:49 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:ab5a:ffac:d2bd:d230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736a93be530sm6555245b3a.86.2025.03.10.04.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 04:14:49 -0700 (PDT)
Date: Mon, 10 Mar 2025 19:14:44 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	jserv@ccns.ncku.edu.tw
Subject: Re: [RFC PATCH 1/2] rust: list: Implement normal initializer for
 ListLinks
Message-ID: <Z87JpNJU5gxN0YgS@vaxr-BM6660-BM6360>
References: <20250310073040.423383-1-richard120310@gmail.com>
 <20250310073040.423383-2-richard120310@gmail.com>
 <Z860iWGtaEFMD2hj@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z860iWGtaEFMD2hj@google.com>

On Mon, Mar 10, 2025 at 09:44:41AM +0000, Alice Ryhl wrote:
> On Mon, Mar 10, 2025 at 03:30:39PM +0800, I Hsin Cheng wrote:
> > Currently ListLinks only supports to create an initializer through
> > "new()", which will need further initialization because the return type
> > of "new()" is "impl Pininit<Self>". Not even "ListLinksSlefPtr" use the
> > method to create a new instance of "ListLinks".
> > 
> > Implement a normal method to create a new instance of type "ListLinks".
> > This may be redundant as long as there exist a convenient and proper way
> > to deal with "ListLinks::new()".
> > 
> > For now it's introduce for the simplicity of examples in the following
> > patches.
> > 
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> 
> This change is not good. The ListLinks type has an invariant about when
> the pointers are null. The existing constructor argues that the
> invariant is satisfied because pin-init initializers can't be used in an
> existing Arc. Why is that satisfied here?
> 
> Alice

Hi Alice,

Thanks for your kindly review. Indeed , I was trying to find a way to
cope with "ListLinks::new()", wondering if there's any macros like
"ListLinks::try_pin_init!()" to help us deal with "impl PinInit", so I
try to send a RFC patch for it.

Sorry I overlooked "commit 52ae96f"[1], it demonstrate a good way to
handle the basic structure for "List", I'll fix the patch and send a v2
as soon as possible.

Still I would love to ask why don't we provide "ListLinks::pin_init" or
"ListLinks::try_pin_init" to support for the pin-init initializer
returned by "ListLink::new()" ? Maybe there're special reasons behind
the pin-init initializer here ? I would love to learn if that's
possible.

I tried "Kbox::pint_init" but it
wouldn't give variable of type "ListLinks".

Best regards,
I Hsin Cheng

