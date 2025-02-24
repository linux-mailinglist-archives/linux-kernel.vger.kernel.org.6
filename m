Return-Path: <linux-kernel+bounces-528370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7779A416FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74F01670D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE924167F;
	Mon, 24 Feb 2025 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njvpp7yR"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CF22A80E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384783; cv=none; b=BLtjXPheiMY/Yh+/SB9A21DKMyLxzJ8S1UISBoqnVX9t1axLyEbYZ4ZWaBMwHWE5EE7yv1TNqAoFf/vknxLyfsqOBR5cxoqya/3bH01aFNV9Q3Zfvi1c2SeuoYhoWPkZYmSGb8X9yIYqK5CW6w8lbSELb8LmtzOHmDU5DwR57Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384783; c=relaxed/simple;
	bh=zm1XGdW8b7MAbdzYL+ivC3Vm7Q33WGsikbRPl+MehKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czTwy8XJEesUdI3NslJe6yWOlLNxItyQLAuT8b3RoOtRXBhQFjubui0J8+RIQFicG6cpj5RvzF3GkBmc77J7c9FuL4EqbkeAcSWNCx2M2vxIUp1UO40Vj3sz6dJjN0sD9zNBRxGWRi3xmQbTGiyBh+XPCPWLyNMiyz958f+Tj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=njvpp7yR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e04f2b1685so6137204a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740384780; x=1740989580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy/VDejTz9+C/5BlUy0JQ2ySPwy1T3j7TGBJKfwzWTE=;
        b=njvpp7yRglPfwx7t9O0F4oxTFetAtdRcb0rWJ7oujTljI3JCYHR6CzO7xNCyemNtoI
         Ce1nUPAJ4I5mv5fT3djW/1vKERx6Ac44G/UaNuGlSHhjT4CPEyrSlILnAxibnS5Hw+ka
         ssNYC1l9bcCC+ZPhpNorstAeL5ZLusJaBRNy7Hvr49w9HnXN2jrRiuIt4FO5TA1koGe/
         kLYDvbgT020gckVM/Ni2uhZQw79xZYhzzwCw6/Y74SxLdYOTciPGPmjQp7AhZS3TWfq2
         G0kOrJncmIY2fp4hTS584ISyKNf052Mi0F5NPpSKwFjFobjS+hewtwhNLaI/sDHfk/+S
         mWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384780; x=1740989580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy/VDejTz9+C/5BlUy0JQ2ySPwy1T3j7TGBJKfwzWTE=;
        b=FFN4kcOdfcHduG7NN0vOzpZaPy22P7PK0n8FZWIYZx2Vd+VpqF2xf1bnkbHeP2MUh8
         3tCVqII7bYml+fSgba7DQIsdOfkB9gH9t1TYi/Nxy7H3K7mI0n54+7/H56D1CwP3HaeY
         W3CvOO1cr9EoNkM0g+s238Eo1L9aVM9ANnkWRWMn+0C7MPXXLGeu06A/aE7L+emBEcdP
         R5GQ0mcNw6i2rZ5aHQi4amhsrbNWrS3AWv9bjSDpj7ukcySYlr1kGsJWJAWgKEN3FcbB
         lwQOC+YiP/Czi70dbY1gXtyGsAiYGzkplEyrLQndpOddIw7sXQ6ALU5cQRRqSlpv+3KQ
         PhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaunYMEuY/WhTR00mpm7wkuOFlShIP8AzfStghRmrQwdq9NEaAt2dRdgOn6fVqz2sRkkVKBF9pNtv6/64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhkAqYqNY+IKugGYM6dCj2XO73r/GhQmU667q1Rt/KL7CxNTZX
	0XHtccaYj9Kw0Sf0ayITlcm3MOTWprswP+OeQT38HeXH/LyPjZHjrp7XP0w2Rwk=
X-Gm-Gg: ASbGncuqc1OPTRxKwklWfMrf52DpsF2t7O2uU03MEgwtBKzuCn3uY8XRc2nyQfhssAe
	oNC5dgFTDhvnWsk5hOLTATI/i+NmO/wAhiZpohbavZetuDx0ALsadHBfSxdjsu3Yg9bWIRLzoxX
	seCwV+2ZOttd1yyeBdD05uRWlS171PAhPGu+t+t1BdIoYHCZaiPw38dfXn9XMcjhltwRrlTw80k
	8GC6pAv1grN3SUPe0YF5355KlIYVoxH2+CMPQ+JanwVd3aJn0boV4riabL7F+natL3CQBOLZrVF
	HKIbcG8eXEywjm/SzoUyaf5HOYdE6b0=
X-Google-Smtp-Source: AGHT+IHsJX9ApcHkuTvjiz8vGIYCMMUHA/6LWXZOxZXsrIXHc5WgXLFFAoSh0lWFQE/xDMuQC0Y3EQ==
X-Received: by 2002:a05:6402:3815:b0:5de:b438:1fdb with SMTP id 4fb4d7f45d1cf-5e0b7266b9amr27595493a12.30.1740384780220;
        Mon, 24 Feb 2025 00:13:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb7200144fsm1792040966b.184.2025.02.24.00.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:12:43 -0800 (PST)
Date: Mon, 24 Feb 2025 11:12:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Martin Uecker <uecker@tugraz.at>, Greg KH <gregkh@linuxfoundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <9a134f1b-a661-4372-9336-289d5734bcab@stanley.mountain>
References: <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh>
 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <2025022042-jot-favored-e755@gregkh>
 <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
 <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
 <20250221181154.GB2128534@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221181154.GB2128534@mit.edu>

On Fri, Feb 21, 2025 at 01:11:54PM -0500, Theodore Ts'o wrote:
> On Fri, Feb 21, 2025 at 12:48:11PM +0300, Dan Carpenter wrote:
> > On Thu, Feb 20, 2025 at 04:40:02PM +0100, Martin Uecker wrote:
> > > I mean "memory safe" in the sense that you can not have an OOB access
> > > or use-after-free or any other UB.  The idea would be to mark certain
> > > code regions as safe, e.g.
> > > 
> > > #pragma MEMORY_SAFETY STATIC
> > 
> > Could we tie this type of thing to a scope instead?  Maybe there
> > would be a compiler parameter to default on/off and then functions
> > and scopes could be on/off if we need more fine control.
> > 
> > This kind of #pragma is basically banned in the kernel.  It's used
> > in drivers/gpu/drm but it disables the Sparse static checker.
> 
> I'm not sure what you mean by "This kind of #pragma"?  There are quite
> a lot of pragma's in the kernel sources today; surely it's only a
> specific #pragma directive that disables sparse?
> 
> Not a global, general rule: if sparse sees a #pragma, it exits, stage left?
> 
> 					- Ted

Oh, yeah, you're right.  My bad.  Sparse ignores pragmas.

I was thinking of something else.  In the amdgpu driver, it uses
#pragma pack(), which Sparse ignores, then since structs aren't
packed the build time assert fails and that's actually what disables
Sparse.

  CHECK   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c: note: in included file (through drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h, drivers/gpu/drm/amd/amdgpu/amdgpu.h):
drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:414:49: error: static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"

regards,
dan carpenter

