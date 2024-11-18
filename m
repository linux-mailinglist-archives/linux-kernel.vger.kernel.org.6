Return-Path: <linux-kernel+bounces-412852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D969D1017
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9A8283E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017F1990AE;
	Mon, 18 Nov 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cOz4/eJQ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BE199385
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930358; cv=none; b=M+DQF0WzcTObWtFUmKN5EkZCUHWrvEcRi+tYTyapp9wtNf0+WBkEAT98eJtRzp1medyw1HkfBw7p/fAN64x4O1sv8gWFvZNGGFfTNvfMnAckVniQJTuVhs4JlQiaM+O+9ij9BbJWsSfw8r/yDzENJBz7lUjKMUUmSVhGJ60vdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930358; c=relaxed/simple;
	bh=Spn9vW+M6cN7uMtHKcA+03XPvwXZYK1hZpCWD850Uk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exp4ixN+n5P4XvAkaw7ZOWFf6gD/gK3NIHyq3zas34vh60KbOy7feXOhUd+UlPvnanurh+/SXpb80dw7eofYc1deRvFCXsZpj5plt0vi3FO5vAr9BMv9narMHFz31vhc2PaF5cTGfCipL3UdJ8yGjGOeIh8UsoNTxP/sODUENzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=cOz4/eJQ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso40279841fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1731930354; x=1732535154; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Spn9vW+M6cN7uMtHKcA+03XPvwXZYK1hZpCWD850Uk8=;
        b=cOz4/eJQ5h0hC2a2guYvDRYC14XmhaWGnpyNqDXKgE21OhcwucApy95QZCkIlac4UK
         7E6majAnAAMcolhxpCcJfNYgb603Aqq0FVbiO9M9tuUuGkoi/uHtpGXZQydYNM2f42qT
         PqNsulhNuNe17ShcKNnAYBMYKMmy7ulE2r+58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731930354; x=1732535154;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spn9vW+M6cN7uMtHKcA+03XPvwXZYK1hZpCWD850Uk8=;
        b=V1t83hNZCrtBodax8V9Z8Wk7zmRryuzwv4jkbXj1LD3NA0v9GlaWo3gPy0hbtDWEPf
         q+9nfRfy6NKne31XNVtv5S8O1ahEhye8GvWDSHCnvxrOpBl44ke83ptTwKz9tU5imTeC
         g8euGvJf4noejk+vOuW1YGl3Psx5E4vHaI+ruKNlgMjWrs5Ci4WueO7W2wHFBF9tf6KR
         72jE9vid0R64W5DV3Ye+kZ6UHM8nVodQgOU0/55PHdCU1LScMPHoGUl9LYqS/bheV/TB
         UQoemFjxFTE11PFtKruI6db550ggjfr8nDA/s12rRPdvCQKm6Dp0KPmcLzvtnmpm3sez
         57pg==
X-Forwarded-Encrypted: i=1; AJvYcCVUkFNErwz/zEBfyiTRLPeWP4LDfAjLvBmg22q+/gWiKy4k54wdksqzlxg6ZfcYaftAgez9mN3dRtQexvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9nlAUtB1TccehskrK+9PYi7HFbaOWZvdviucYKKJeZM3ZcSO
	aNbVdU5rsPIZm4bka/zw+wsJ0USzMa7Ray5N3pSz0rkA5Knoy9rfO7qAvCHTKL0=
X-Google-Smtp-Source: AGHT+IF2Iex7nZL2JNZbYy4IcrxkezkV2WhM9RWGMxPve6UnYUJn2AF0eHeV6r1+nM4WUaISdzM5QA==
X-Received: by 2002:a05:651c:b0f:b0:2ff:567f:9108 with SMTP id 38308e7fff4ca-2ff606fd180mr63639791fa.33.1731930354518;
        Mon, 18 Nov 2024 03:45:54 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69958d68sm9258231fa.38.2024.11.18.03.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:45:54 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,  Nir Lichtman <nir@lichtman.org>,
  ebiederm@xmission.com,  kees@kernel.org,  brauner@kernel.org,
  jack@suse.cz,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exec: make printable macro more concise
In-Reply-To: <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>
	(Linus Torvalds's message of "Sat, 16 Nov 2024 08:49:39 -0800")
References: <20241116061258.GA216473@lichtman.org>
	<20241116072804.GA3387508@ZenIV>
	<CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>
Date: Mon, 18 Nov 2024 12:46:02 +0100
Message-ID: <8734jon4sl.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 16 2024, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 15 Nov 2024 at 23:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> Now, whether that logics makes sense is a separate story;
>> that's before my time (1.3.60), so...
>
> Bah. The whole ctype stuff is a mess, partly because it's
> fundamentally a broken concept and depends on locale.
>
> The original ctype array was US-ASCII only, and at some point in the
> random past it got changed to be based on Latin1. Maybe indeed 1.3.60
> as you say, I didn't go digging around.
>
> And Latin1 is not only what I used to use, it's the "low range of
> unicode". So it makes *some* sense, but not a whole lot.

Yes, but the kernel's ctype is almost-but-not-quite latin1...

> It might be good to go back to US-ASCII just as a true lowest common
> denominator, because people who use the ctype macros almost certainly
> don't actually do it on unicode characters, they do it on bytes, and
> then UTF-8 will not actually DTRT with anything but US-ASCII anyway.

Exactly. But you said otherwise two years ago:
https://lore.kernel.org/lkml/3a2fa7c1-2e31-0479-761f-9c189f8ed8c3@rasmusvillemoes.dk/

Rasmus

