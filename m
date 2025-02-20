Return-Path: <linux-kernel+bounces-523816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBDEA3DB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4FA19C19AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EBB1F55F5;
	Thu, 20 Feb 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3t75xax"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD035942
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059212; cv=none; b=mAYII3kVpmZ9DhCHCoRHJCbAQIx5OhtbiJjDfVIyH98QLtnOKMiya6y8DHVN+u6hY/kP6+1jq/3pgydSfoBeWx71JIL38vwnbESnhlRS2lyDOBq7E0Wleqsh97IjSDIOiDDlY+5hzpvbt8B3cIriBr3/BlXjGR3tvN5jdzS2AY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059212; c=relaxed/simple;
	bh=1jVbThmX/xBa44klFEKjAJ5W34MO3vftIlESOdgboYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1ZyUSQeTfOBcBhFfBQpl6pmifQH/+bRzBQvr1IgpKPEK0AGqMKvTnNnB59r3B86Vkr5LNmFKcQxfM73Ui4aeH/1BC6tupLf34qN+79jZ2sj6A83Sy1/bjJWxpX/YL7qLoU/d5gL/z6CqoU6GrvaKTYrFE8YgntELn8QDHWNv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D3t75xax; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso1493756a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740059209; x=1740664009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zn8iEIUMrS40tjZsG1qyBPqsWfjDSZ0FtFQ9slyGvJ4=;
        b=D3t75xaxbMbBs5SEYz8soWwwNhJBAX14DFyj9Gyk27nUzXSMddSJOjnFejCKBJdmwU
         6c6I/bKv1SIOAxpP9fcKrcynHla32Jovp8Q7uG6cuRLwuwHo9NTuMFrXBgIyvfsDpt0H
         +0CXlcaAArdZ/6niJJry2uLCsAiQSzueqSaMNoDfbRv1h8Hbor9A5iywvpqMoZrhpCWg
         CgaJ8ZwyOTU4cbYrUJDH4lXqVlAnu97PS0jg0Ssele8mMsFBwCMpJqUJUTMfL/JeT4sa
         OGFdsq+CXElJPN17hb6y2foAYPozBXdSC0IRC6PGKdhBdJAvtjKWmEkVS7frMjcxubkB
         st1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740059209; x=1740664009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn8iEIUMrS40tjZsG1qyBPqsWfjDSZ0FtFQ9slyGvJ4=;
        b=d0IEjNQrFJGludIYCyvbw7hTscbFflwB2v/I6DNoRqPRTCzcRY3cjMGpQ1/QqEBY28
         CiyF176FQuNRjPx7WQfJtvVr07sR4c8gwzDVBjBCID60Nt/gDXxeUF7LLa0jJWr3/0vu
         XzvoJY95Z+tpPfP8jZrOuo9CI+9lo2xPbGkgLk9xa3x4GCdiV74dNyEYJSQfdWajxc1U
         VLbsEda1pgp+8ji4OeWyll+9gfvDM8X/n14bxiaTKbfkCNdHm720KpbKDjUuc+4e7gf9
         Uqk7akWK7LEwExncPb+pTK7Q7SukcZ2BM841wb4q+3U1x24J8kLoJug9opnRm/ciB8uk
         Gl6A==
X-Forwarded-Encrypted: i=1; AJvYcCWgweSEthPb2ZyNZd+/F+N/bci1aGJ8WDLzEQygD2SWnUvgHiaMGvCW5FZPwFMkyFsJgTY07toGK4G1wwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUOlPDzSsYDSX4pk5zwE9c9NJWGuaEk7dUWprSrQ0UsZ/u45Pe
	Ax7FGrqV2imW0849a/wUJarxGVm3te8TpkUf5uSVeI16C9RkyKpZeVq0J8/OGOk=
X-Gm-Gg: ASbGncsBu0nU9Ucpgkse1zULH3Ap5GnFFfCRa3tI22Ya8+3o1O/fYhnkLCrP4N0U0T5
	k/BFRhksuXLzZSgcFseIu76hdDeybX4ahz83ymVl5K/bVcdRbmd67uwpSgBg1umtYQeK7zVkjZC
	OedYu3ZqanniYKrAc2UJgd2iqRvn/oc93RwLKeWxeVUY4rKKbWI8emQTY4KSwEi7oI7+JAECo9D
	pQH3WWzYInp9IBQMdujM4mVJ7snFo52OFB3e9JuO4feXl2w3dVSnNX5MZ735H7enKquGOJcgV1A
	emmiflw0AMSGqWn+iCEJ
X-Google-Smtp-Source: AGHT+IEfkrRQ85xe9pOj5R5EwLaYpo72DL1cc79Csvepxg+wxeNncqBoFZXg3h/koqsH8dAFU2C0hg==
X-Received: by 2002:a05:6402:40c4:b0:5dc:929a:a726 with SMTP id 4fb4d7f45d1cf-5e0a4bae4bemr1740318a12.26.1740059208978;
        Thu, 20 Feb 2025 05:46:48 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece1b4e80sm12119627a12.13.2025.02.20.05.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 05:46:48 -0800 (PST)
Date: Thu, 20 Feb 2025 16:46:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev, Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: Rust kernel policy
Message-ID: <962fa158-5315-4d93-afb1-8a1c08787ad8@stanley.mountain>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh>
 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>

On Thu, Feb 20, 2025 at 09:57:29AM +0100, Martin Uecker wrote:
> In particulary, I have a relatively concrete plan to have a memory safe
> mode for C that can be toggled for some region of code and would make
> sure there is no UB or memory safety issues left (I am experimenting with
> this in the GCC FE).  So the idea is that one could start to activate this
> for certain critical regions of code to make sure there is no signed
> integer overflow or OOB access in it.

I don't think diferentiating between signed and unsigned integer
overflows is useful.  In the kernel, most security issues from integer
overflows are from unsigned integer overflows.  Kees says that we
should warn about "Unexpected" behavior instead of "Undefined".  In fact,
Justin Stitt has done the opposite of what you're doing and only checks
for unsigned overflows.  He created a sanitizer that warns about integer
overflows involving size_t type (which is unsigned), because sizes are
so important.  (Checking only size_t avoids probably the largest source
of harmless integer overflows which is dealing with time).

The sanitizer has a list of exceptions like if (a < a + b) where the
integer overflow is idiomatic.  But the concern was that there might be
other deliberate integer overflows which aren't in the exception list so
Justin also created a macro to turn off the santizer.

	x = wrapping_ok(a + b);

What I would like is a similar macro so we could write code like:

	x = saturate_math(a + b + c + d * d_size);

If anything overflowed the result would be ULONG_MAX.  In the kernel,
we have the size_add() and size_mul() macros which do saturation math
instead of wrapping math but we'd have to say:

	x = size_add(a, size_add(b, size_add(c, size_add(size_mul(d, d_size)))));

Which is super ugly.  Maybe we could create something like this macro?

#define saturate_math(x) ({             \
        unsigned long res;              \
        __trap_overflow(label_name));   \
        res = (x);                      \
        if (0) {                        \
lable_name:                             \
                res = ULONG_MAX;        \
        }                               \
        res;                            \
})

regards,
dan carpenter


