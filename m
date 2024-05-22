Return-Path: <linux-kernel+bounces-186792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA28CC93B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AEBB21C15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B818F1494A7;
	Wed, 22 May 2024 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cYGB4NaX"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E49146A71
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418424; cv=none; b=K6Mm8GwJUwCWy2x1w4eCls5HKrfg+TxzvnWdEyfbXlea6UCbsx5sXyKHe4avH+ba9gW/JQV0cibrvdDQTdYb0/tbYIz5o1ShwJIa5lbxWNEyIUsLMrjNMMQJskVFE1/vLSt3GbLPdNm+U+In20Q/wPQS/hljOmn+aLHsGLEayz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418424; c=relaxed/simple;
	bh=s+AFZiWYdfo9LHxXiFDhhaTaz5In1NnrT6e/kTcTOec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A793TuUOnylTDdutjFmLJVf6sGxCnbhXZh/azWnfxcf+e+NJ81HWWBSBiTvOlzsnVY5Tg038kFyUmQjbeDmgevIdXDV3EVUGLp0ET7bSM16AK7h3qSCcOJ1U6+/tTUcyBReg+JPcqBygWB633g1ERH2eqsW5IXYV80D6/dL8gIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cYGB4NaX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so1067335566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716418420; x=1717023220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5pQI3o2sJHQ9VDDihE2wM0f+XoWWITjrXXHCRcKXU50=;
        b=cYGB4NaXjHoGhca3ct5DdOYiHDbjeYgf/lCZgYEQVXHA4Fd/2rhq6+ihkXNLqF1Vol
         NC60TUEV3/o7Cx0ouNwYyRVjZrvx3ioRVS5Zyzyk5+8acNKiXgb9B6xUj6jbxZl37MsV
         BQv7jYJxwnztR/fVhohWau7RZvr9VvsMl8qlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418420; x=1717023220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pQI3o2sJHQ9VDDihE2wM0f+XoWWITjrXXHCRcKXU50=;
        b=gj9nMSASjoMDIbiU13SptyOpVHnd3VRow7nGCT6uzPElySZ7bMn88OoaLXgOQTIuur
         N3emLIbxsAoieniHM41OXb3bYg3ifxU3aIBKU2dS/1yChSTYU63jOQqU/d8O50HS4b5K
         39D4NwDua22/xLRKT2I4YjXO4IiOTvkzBwOGC5Kl9p7sjiloP6DjUeC9lCnoriZBpo5R
         anZzLUI4lJZfGmJ7ZJM7fnaC19H+ajUd7BC3vsjFekqtad43FgAsnIxlt5/pBo9Flkl1
         HndVHSVPJKb8/cuUOhuAW9IPhJxo7REkG6iSlKG4KCdbEzvklP9wjQXHysxIOylTYjbS
         PLUg==
X-Forwarded-Encrypted: i=1; AJvYcCWfIVRjxBQ/B+wLBEDMcdLUE/GLL5HtZbtvJuEo14Pup2tGYOFbE/4tbmF8WvIanUEp8Szq0br5McXJTLXx0zHbYq3uMeCl4Rc+LnPl
X-Gm-Message-State: AOJu0YwKin8YSx4cj2mcrsRri4dQHZR+GBFzGbZnJSvdUGh9/Xlqw6IF
	9GV4hgIvVtSPYmZpEwEdkSzkQs2XwSIwuLbGt/G3BF5XqP7ke1rOodyzAI+pqP9Jsfsy3AonKgT
	nVi+FiQ==
X-Google-Smtp-Source: AGHT+IHIKrbZ3tAdnyJaDxItxKWbNavySLH3OjcdECQmXepNSvHRG5z6zZE2bbfp6kU4ruF+PsaEeQ==
X-Received: by 2002:a17:906:b251:b0:a62:2e8b:2ca9 with SMTP id a640c23a62f3a-a622e8b2dafmr161714266b.67.1716418420536;
        Wed, 22 May 2024 15:53:40 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7f78sm1828748366b.133.2024.05.22.15.53.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 15:53:39 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59cc765c29so147140666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:53:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1ECfKa3gYR5QdfLOK0a1JYC1Vq3//QqbExzBGgzkH/4KrwBNy8Tpv49tdqW3nayqKY+6POTIeRnXQ5vu3uwgeDDa1nN3hklPim2jn
X-Received: by 2002:a17:906:6945:b0:a5c:df23:c9c6 with SMTP id
 a640c23a62f3a-a62281673cemr222082266b.47.1716418419345; Wed, 22 May 2024
 15:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano> <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain> <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano> <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
 <07512097-8198-4a84-b166-ef9809c2913b@notapiano> <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
In-Reply-To: <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 May 2024 15:53:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com>
Message-ID: <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com>
Subject: Re: [v3 PATCH] hwrng: core - Remove add_early_randomness
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Eric Biggers <ebiggers@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, regressions@lists.linux.dev, kernel@collabora.com, 
	Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 22:38, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> In this particular configuration, the deadlock doesn't exist because
> the warning triggered at a point before modules were even available.
> However, the deadlock can be real because any module loaded would
> invoke async_synchronize_full.

I think this crapectomy is good regardless of any deadlock - the
"register this driver" should not just blindly call back into the
driver.

That said, looking at the code in question, there are other oddities
going on. Even the "we found a favorite new rng" case looks rather
strange. The thread we use - nice and asynchronous - seems to sleep
only if the randomness source is emptied.

What if you have a really good source of hw randomness? That looks
like a busy loop to me, but hopefully I'm missing something obvious.

So I think this hw_random code has other serious issues, and I get the
feeling there might be more code that needs looking at..

              Linus

