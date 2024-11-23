Return-Path: <linux-kernel+bounces-419310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231ED9D6C40
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 00:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE9C28174E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 23:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4F19CC21;
	Sat, 23 Nov 2024 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fa0sCqVj"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5433A59
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732405496; cv=none; b=psjjUwcjIEBu7BE2SMeApFt8njP8Sfb5YKk7/trz9nSUbpcY0mMOHyUf+wfBLaeHYlMJGOuFa0WzU4zOeiLPKyPFm+YZZTkiCyhutplY0GFaAQR8rGepOABlKAoPqNr3H8iDRD9g57ZwCdXtGle76piT7Drb7VX/tDkWWIk05io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732405496; c=relaxed/simple;
	bh=g+Y4gOPLfF7M/YiCIO5Kef+8ZGTE+p61ejmOt/D4RFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkNAGrsVIoeloa97pfYFFMLXwFD2WUPWQLHgkJOLnWWcZxGLzvohAf4mdKIeB2tVRjFxF6h+LTd7I5aO+qAQqGwrlEDMSotcll9pxeVmoQOyXy2XkiXvSfjSe6wGgeNvjB5DQ7kZItPB7h/hHi2VsTQ+Xel2NJdZ7TM/wIUm8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fa0sCqVj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-432d86a3085so30662355e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 15:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732405493; x=1733010293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=at8LIYYL1RmfVcLpy4XjCtr1orBJfgH86YuW+3k46Do=;
        b=Fa0sCqVjazosBazQO/nRIe904Urgvnf/5coGB2ihvyA+v1oqjN2ncRk7HMZv0Kdita
         obSrl9JpNjjXkdpE2MaRWb8CUqkJdCHbic+o0cAwXJbqlvOBru1OgYT4gry4bwkiQiCh
         8+mJYX1zV4DTJoUkgf1Zo9SYUbE6h+Pvr8X0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732405493; x=1733010293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=at8LIYYL1RmfVcLpy4XjCtr1orBJfgH86YuW+3k46Do=;
        b=TCQA4fDcpaI8p17VoJXLV43PeCxjTquhwLF0GKxY+8cBUqL+sByBI/Uc6Hf49qHB9L
         ua0J8U4VT9FuNVGxjXLANzXWu62RQcEYc+URIiO9Uej9xUzSqPZSqZss1G2UCdOnCBk6
         mc3Ugb9vSLMx+/7WC/pOcnioa7DbrgCnX3/4xpqr5m8d+SBY1+6mTy7r6Xq5z3SNEWhe
         flF2in7JgJEi3ZeXXx3soDGgy9R71cZSF+Y/W7E/Cqp2L0h2vgewfcVsEG9IujLB9cDU
         qWZ2cWRJxxo6yBRda1tCcmZ3HKlOMwWDZGBZ6E/Zt6ocu6mjcd5XELoDEazs6wgtizws
         7iBA==
X-Forwarded-Encrypted: i=1; AJvYcCWfBnjZ66+F3DRTKQ+mem8ThJKKFJnhPuQhWfFoB/ayRCEQO0RhuAHj/VRo4TSoOUXXWktuMWjX7HT/hNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9bDAGBLfAjhAsA1squmFY6f5U85P06KKsQGlLP307tCjO+V2
	W1Ndod3fS0Pda1ay3+IOlk0EpBbXJBe7fu9U4flj0neAGOMxS+B/COcayMg2E65oCKzQQmbAdfM
	5fVY=
X-Gm-Gg: ASbGncv2r8LwL8H4aHcF1//S1nDXOATYgXTNKKcvrhbTmtNZFNfvGi9IRC0pBAhdUF6
	z/yILB6xfHNruo1BdyCVixcE2OakkBTfBPeUsIg4AamQqatjkgC6AJSnyuv/zzXJzWftfgeuW1U
	29a8ufAmU3n/32UuCxAwuZ4RRIvPXnwdIW1jD3LE9qW9OuTHXgRxRNOasqX25okp6JCvMncBzwN
	FfIiHKw3Xvzo0j4WhB3a31NS3HVXZ6wHr/uOZil4StZBRaWHpdWfELLazVYiB/PKfdGZZP5EJjl
	KTTJrYkRcI+vo36Ess2jQ1C5
X-Google-Smtp-Source: AGHT+IGACp7BhhnH6acb4+xIhe/ZW3D0P47U5ieDtTOJ1g3fAsSsB6Q3snduOJd1z6sh34wYkrYsDw==
X-Received: by 2002:a05:6000:2807:b0:382:4b2e:d42d with SMTP id ffacd0b85a97d-38260b6bd61mr4261787f8f.30.1732405492762;
        Sat, 23 Nov 2024 15:44:52 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a2d15sm2605950a12.11.2024.11.23.15.44.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 15:44:51 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa520699becso245798166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 15:44:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXupHxfCvO/oHz97ozT8peVKhxNuo+7DQnlWjTS5H6sJ8zG8STRGibzBvtYcrlfjQuzJzahiCFUu572ciw=@vger.kernel.org
X-Received: by 2002:a17:906:23ea:b0:aa5:479b:3d25 with SMTP id
 a640c23a62f3a-aa5479b3d7cmr24815866b.51.1732405490655; Sat, 23 Nov 2024
 15:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <680c14b5af9d43d6bc70d2c1e9321e01@AcuMS.aculab.com>
 <CAHk-=wgT4E+6YO0-SvdD=Gh6wSuUB3Bq_qOiErfZkobQ9gn6=Q@mail.gmail.com> <e92823fee58d44b6a50a83fd27206857@AcuMS.aculab.com>
In-Reply-To: <e92823fee58d44b6a50a83fd27206857@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 15:44:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsUQMM-FszR-D+myn9-B2pDidXG9DQWGKfAhU3azX==g@mail.gmail.com>
Message-ID: <CAHk-=whsUQMM-FszR-D+myn9-B2pDidXG9DQWGKfAhU3azX==g@mail.gmail.com>
Subject: Re: [PATCH] x86: Allow user accesses to the base of the guard page
To: David Laight <David.Laight@aculab.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Mikel Rychliski <mikel@mikelr.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 14:36, David Laight <David.Laight@aculab.com> wrote:
>
> The problem is that it is valid to pass a buffer that ends right
> at the end of valid user memory.

There's a difference between "valid" and "we care".

This is way past that case. The only possible reason for that
zero-byte thing at the end of the address space is somebody actively
looking for some edge case, not a real use.

               Linus

