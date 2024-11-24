Return-Path: <linux-kernel+bounces-420295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3469D7873
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F43A1631FE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809F1632FA;
	Sun, 24 Nov 2024 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hr+2msdC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053672500A7
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732485818; cv=none; b=iHstA/2OGVY57lY+eSJ1lB6QDE2PN14z6CRv/LIgAccpf/jHx7lLiabdaZ3D4TLNH2GhaHnvV6fLjEkapVdjzv5v62LLWJ0/pE+Qy+kwkSHIG9NIzWIY2z0H3dJIFeTdU3ZKJiKWNkR0+JqqEDJBlXVilpp20KK0OWasNAn/vjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732485818; c=relaxed/simple;
	bh=iX94XKfZ7f0NO+joOYX0MDrnEIpOJQpUrddQEZ6qTtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfVwg6K5J3l0YAbRTlmVa9pxRJHCk/KjPzx8YQZQlkDoslwpVbNz19mDLbao2ooak91eIF+rY+f6NSt1+BNd8htdLJR6xzv1dnhKJsY6wYIoWz/mcx0wi7or51USun1BBQy0G9p0A82W06Hwn0PB6R58aYhISqZqRsoNP2s/Tnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hr+2msdC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfabc686c8so4590874a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732485815; x=1733090615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ERBLAMwfDvyFZlAfhe6oQ+WFB88uOyEhfAk9kyMRbGg=;
        b=Hr+2msdC3637mFCUt5Jk+FL3CbAyJEZ67IvFVfWdMxs1RV/XhesvZ8DQ7osM/KHF9j
         tv8kv09eO30Y6EeINO+TQrd7sK8BJLdnPj9rK6YKrLfzS/1EOUnhUhlA7yLFvYhMM0QV
         cySOP5tBcm51pqWsGJqb9f+q+1AHIgRPVO5UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732485815; x=1733090615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERBLAMwfDvyFZlAfhe6oQ+WFB88uOyEhfAk9kyMRbGg=;
        b=QbiOFWJlP9b3WnBu+n7ke8vzGB4ayJ+cb89TLftDsVgoV03TCLkAbvL3xRl+oy604S
         yqa4eeZlKGpUmE9os4XuOcT/4jC1FtNhQXUE3JevRtb5Ga94QbPkddwz7nTukmH39OvI
         U5omS5/WPTqhOPi1yhlDdKzo5ZM0D+z6XGbeRXckb7dJSO8J540qO30XKzzqCoAEMipV
         ZCcZL4KMfIXmjBqRLIxJNmQLaHFWnlOsGveq/q+Hwi32jkkPTqqiFQarfS0l3Y4gYI4y
         McDX+IkPAb6yT1nNISm3gep7LxARO0XRjLprqtwKA/JxUDxS1sXK31lNJI97WEcV1pq9
         cPYg==
X-Forwarded-Encrypted: i=1; AJvYcCXIw4w2g8UvfTy8SUmJ6kArmj+MbQ6NibMFd0vzjaDBRWAWPCg5XV+aU1jGGpJjTVrMTN79ieSff+mIK3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsBlVS+yXwZaNatyxstNpbKSPNBubpsWKmuBJn/tfQ6SB2qKP
	YK8iMpsCCEzoEYUb5BpChsTxqRvfDigebuAKcOJ71M6/EbxOsLVIwJcu7uuesxGqJ60CqY+JwWR
	XJksowg==
X-Gm-Gg: ASbGncv7GIrM/hxoS3R0+StqDkddds3lRKB49beEPqMoiBpe4c5AxPeaKlRFukwFxQi
	Z6pT6EWmjuMunqTbzef5OdacUVdE3uMIMhFvZgnArNJIq73tjZpXUNciWlZFc6bxXG8nVfpw9wc
	/7Xj/0GJ4THmFGdOI1i7D5rb4ZStSLcnkWhw6X7hIqOaGydk4KLZ2pG5fIHaQ+W70bEfs2Kx9ki
	7kkS5twNbJ4lVG9cSfpZK3XTNBY7gMN7BrLSshu6n4myjgciDeOpMxeFJvZ4q9enAxRH0yBePyI
	FtzJdN0mCEg3VtYi9qKV2rmc
X-Google-Smtp-Source: AGHT+IELbxoP9VoPDgSNr0GyKUzHu1aQaLbjhrJpQmUgF+MNV3q+0xsgKSV/wjFPt42RWvNnYm2YAg==
X-Received: by 2002:a05:6402:2551:b0:5cf:f453:4bac with SMTP id 4fb4d7f45d1cf-5d02060d32bmr9136400a12.19.1732485815079;
        Sun, 24 Nov 2024 14:03:35 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3fc6besm3414937a12.55.2024.11.24.14.03.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:03:34 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa51d32fa69so325498966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:03:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJLp59W3Bsh+Gt0fS9EUAS1DiA68foZUJGGaueSr9prZ9VpZ0MJlHi8sUwIv85Ex4vzTdtNfq2+brGy+U=@vger.kernel.org
X-Received: by 2002:a17:906:1daa:b0:aa5:3853:5531 with SMTP id
 a640c23a62f3a-aa53853579amr485003366b.33.1732485812755; Sun, 24 Nov 2024
 14:03:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0edca3e5d2194cdf9812a8ccb42216e9@AcuMS.aculab.com>
 <CAHk-=wik4GHHXNXgzK-4S=yK=7BsNnrvEnSX3Funu6BFr=Pryw@mail.gmail.com> <b90410d3f213496ebfdd2f561281791b@AcuMS.aculab.com>
In-Reply-To: <b90410d3f213496ebfdd2f561281791b@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 14:03:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgq1eEoUFK5mSUM6d53USDRaWY4G+ctTNEw9w_PsUqf1w@mail.gmail.com>
Message-ID: <CAHk-=wgq1eEoUFK5mSUM6d53USDRaWY4G+ctTNEw9w_PsUqf1w@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Allow user accesses to the base of the guard page
To: David Laight <David.Laight@aculab.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Mikel Rychliski <mikel@mikelr.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 12:49, David Laight <David.Laight@aculab.com> wrote:
>
> Doesn't that just need a <= changed to < ?
> (And possibly of name)

Well, more importantly, it means that we can't use the same helper
function at all.

> > but I suspect that I'm too chicken to actually do that.
> >
> > Please somebody convince me.
>
> I didn't know you really had a 'chicken streak' :-)

Actually, looking at some of the users of access_ok(), my chicken
streak just got wider.

Most of them are trivial, but when masking out the pure 'sizeof(x)'
things (that the "statically smaller than one page" case will filter
out anyway), there's a few scary ones in the vhost code and the drm
code that makes me go "those are checking ring buffer sizes and may
not access the end result in any order".

So trying to optimize access_ok() is probably not worth the heartburn.  Oh well.

               Linus

