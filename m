Return-Path: <linux-kernel+bounces-189172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1798CEC71
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 00:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9411F219CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E7126F2A;
	Fri, 24 May 2024 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsgKbfBp"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EB3D3B8
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716590158; cv=none; b=B/nagVeBfxjnCmFGZbhvHWVqicWPrIYqE0lNMqECvFueyy8guvbmwRndAkMvyQ7MfKqEebBYaXVQWgc6L23KewG0DTbSRNMbBr4wBElcUcaGAnGsuSALwHBCsZzMgydz6WBkj1hJIKFS/XS2Qhfx01gLM2A6ClwZXhkVl1dQxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716590158; c=relaxed/simple;
	bh=M4VCk5Dt2iAzT91u/gVxNNQBx4fXfDo05VmnDW4PrRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqJ+9iQl6WNZzzxylpSBEwUlfra9sXXM7+UOqPIlWVjaAxT1oxqNTx3sCdSFooMsMvorWCI0zwjGRSLYi3Pq37aZzjr4cODxYNFLtwE3iIxOChOA97ZPlOjnGNV4/e52YVLKV6LM8eu4ZdllJLyb1AxjgnWZbqqoh4QBkhDlEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsgKbfBp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so10944095a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716590155; x=1717194955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4VCk5Dt2iAzT91u/gVxNNQBx4fXfDo05VmnDW4PrRs=;
        b=hsgKbfBpBqlkg//YouyxPSeFqOrOzjruprQy72rsJSWsIY2a3M1XDrgEBtWTMpsIwV
         CINY5EJh3JTDA1h8XgYVoVktDK3qoZCiIsrTPg82aiW3988GejA+hzs+re+JTwXezv/N
         Og52YFlxonbfJHQLdVEMQudHdlL826iJAIEjhMqigkRrJIW/sQN/cvz3k7I6o0tZr8zM
         CzbEFI/5Tr3M6ClWKA4oFkvS/kcmi1VIXi1B8QP0/ebrPgxBId2daJdxR1to1/FmrtP3
         vXrZ84eRqoTuWUrdqejhy+zPPcEjfG5V6vsqiezajnwkyAqBTx83gSljIBfm2r9OkJz9
         7swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716590155; x=1717194955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4VCk5Dt2iAzT91u/gVxNNQBx4fXfDo05VmnDW4PrRs=;
        b=vwfk1QwpFRh9NP5rrwfGb/nFM+roK/L+69sempdQSVfn8VMR/eXHiFIQt3riNrSUp+
         SSbMTqAoBRgw5eZbrHTm9v+m92M6H7fhXRft2LfohifDuPkjdVbLcYaFOt5fg5vi8iMJ
         nt6bNmyNlhKr8Ky19kf0nKyClf+bm28dOvnjAs4hdnWigcm8q3r+q8rbpt8pbrInNt7q
         W3dEQIHdYtbRnM17GyA1iR9Ofgv07FQZIWx+AxIsQfvIX0aN+u0IvsaFVdtkH7xFbfN4
         1YpA516S9pObVpXg3pXUXLWVPjJHQrqgRg3pDCeqsZqaTiucD6nPQNLVIYwFScBidGXd
         jUMw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9M9zwPbHv6jcBPXVkrds7Lmxacitp8Z8SVzySyfcSkeDgcGggpCuy1dzZJdRpDev/zh/OG3MeEJJ0Igxx12VmYhhrZPwZgqHa6Vb
X-Gm-Message-State: AOJu0YzbzHoQblS1zfKC9J5rei1cmAJ38dn5ak6KXkktg9S3gRNmIZ/f
	lLMDNWCWA4G79kmgT6lxHLaHcX4ssYOnStOQd7iI9MLhKpIddSXD9Qcz9felKQs=
X-Google-Smtp-Source: AGHT+IEoYoC3w04Q3y7BbD8fhPpPjz42RdyGJ8vVvhkiIz2RtEdt+0Vsq4dRJDybkSCXYA7IU2Fjwg==
X-Received: by 2002:a50:ab13:0:b0:578:5d83:bae2 with SMTP id 4fb4d7f45d1cf-5785d83bf4dmr1949090a12.15.1716590154619;
        Fri, 24 May 2024 15:35:54 -0700 (PDT)
Received: from rex (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57872da9dfbsm23821a12.2.2024.05.24.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 15:35:54 -0700 (PDT)
Date: Sat, 25 May 2024 00:35:52 +0200
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: kmsan: Fix hook for unaligned accesses
Message-ID: <ZlEWSIcHXnh/BqbW@rex>
References: <20240523215029.4160518-1-bjohannesmeyer@gmail.com>
 <CAG_fn=XR6KVQ=DbKZW3kNXsCHgULm2J7i6GCm8CZUjpjuk-d2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XR6KVQ=DbKZW3kNXsCHgULm2J7i6GCm8CZUjpjuk-d2A@mail.gmail.com>

On Fri, May 24, 2024 at 10:28:05AM +0200, Alexander Potapenko wrote:
> Nice catch! Does it fix any known bugs?

Not that I know of. Based on my cursory testing, it seems that
string_memcpy_fromio() is rarely called with an unaligned `from`, so
this is a bit of an edge case.

On that note: I tried creating a unit test for this, to verify that
an unaligned memcpy_fromio() would yield uninitialized data without the
patch, and would yield initialized data with the patch. However, what I
found is that kmsan_unpoison_memory() seems to always unpoison an entire
4-byte word, even if called with a `size` of less than 4. However, this
issue is somewhat unrelated to the patch at hand, so I'll create a
separate patch to demonstrate what I mean.

Thanks,
Brian

