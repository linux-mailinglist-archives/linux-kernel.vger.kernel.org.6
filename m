Return-Path: <linux-kernel+bounces-266497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8CD9400A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740AC1F2334D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF7B18D4C2;
	Mon, 29 Jul 2024 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL3GNcyI"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA418C35F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290115; cv=none; b=NFUnOXG/qYLCpRBfS/OlZcdKIiMbDkIjs0IcpD6W37CjzKUH/O9GT1/Hw9FwB9wfg5yRjj5dbKLAp5dbnN+NZP32gtfZyFPs7pQt0BJvB3PF0bHCQv/7P7lZqPvyGrQbml6ZH6hUnG2mPSorB2JZTLM7lnJP8yOVYZP9Juko+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290115; c=relaxed/simple;
	bh=vKZzxme3+8GRc4j+6Hu52+kqUU1i1p5BUMeAGAdHVTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3jRT3Z/Rd0LUE1573Gx+4S67wQIIl09/KKY43XjZnl3zf8Xa0EheSTK4ssclIpxEhZvdvntGrc9yIbP5sQpE18fJwgsU7av6c4y8gixS1JCwAjYbTm545lY+/Nt1cqCgpdn9EvqLaWs2DHe7aUdaltuKarvjQTJ5aDYIUFOrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL3GNcyI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cf93dc11c6so1656257a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722290113; x=1722894913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKZzxme3+8GRc4j+6Hu52+kqUU1i1p5BUMeAGAdHVTQ=;
        b=dL3GNcyIewBzK9skNFJIPZouEPkObjTPZWYhM8x2jsukn5V+DCPVupk/iBk0ZPw0SC
         wYLXdUX+BKYMQHbHVTcWbv27KBwtD/WTktfeAke+kv2hcCsFrRAnY+KWMt/SD9nSWjPp
         UcsrFdGGCsms0v4zWQKG+ijSRVpLXL6rJKeiZxkH58WL3PdowWQwGcYqP4/zA+DMXFYZ
         ekIf2+Lx4ulYDFvpg0pfBlX77gtrj6RZjYY6FWPr96tRMriUGoTHDSH53e0u/o0UPfJK
         SGU156D5bkDesvh7yU9ud8ytJPLGu+Rms/89/boBoDPjJ3EFjJRwEFRZMfkHyNxb2v09
         boSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290113; x=1722894913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKZzxme3+8GRc4j+6Hu52+kqUU1i1p5BUMeAGAdHVTQ=;
        b=u0CKlpE/QbBh97aNn4zfZiy5V6wYx4TqbMJj1lPf42RTl+pq3lrn3Ed8xpPPZyQzNB
         MRtu4ik5CjpdmLAWn87G0us+vPyP96CVU6d9Cs/xHzO75v46pum964abzDZS3WiP7UkB
         fa01EXQkx9tf2N3dC3wUONH3O8NmdVwMFa3g9oXe+msnvGeI+o/+/96jYADBSTc5wxYH
         UVgUm3tgtsYbV2lumTw1V7jBqDfCaV20XehEyTk3ImevEx0iVom9Wa0Qlpr28dRe+2zN
         Y+GRapMazVJsaPLNKJGZATOu9WCV7ca+UaI8hOEOqtAXpjruPYoRBqYY7JKxLR4DWkcB
         yJlw==
X-Forwarded-Encrypted: i=1; AJvYcCVvopcVUkIzjqy1mR7PmEgbBtphqnfpWBP3dWG5yRaoU3TRQ0hN5w+IJkG4fQVR/CQV2DXf7cUIKHt5qpDcua5HuYEBOj4gQP+tAdAz
X-Gm-Message-State: AOJu0Yw0MURiZ+qhtS7WGwCnMeYu44BWG9XvNjgDrFjyBwsuz+hO+T1+
	7jus5OM0qUpC7Fk4IakeyE+TV7N74Lh0ZUD3Ix8T3E8DWMlYQlE5ey/pDXANIcBj0RQcUXwNmRG
	wm7M2s6nAKyvsuKJX6l7VLqJhx6E=
X-Google-Smtp-Source: AGHT+IFxBK99aCFy4PO2Zss0YefeIvqtS1n+5cL3OOdIrhSWftr3LBt+eUy0+Uzc4K4AHH4waY6piMSJxnb6Es9e168=
X-Received: by 2002:a17:90a:5d8c:b0:2ca:a625:f9e9 with SMTP id
 98e67ed59e1d1-2cf7e841c2amr10454711a91.42.1722290113210; Mon, 29 Jul 2024
 14:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729-clang-format-for-each-macro-update-v1-1-9c554ecfec3e@gmail.com>
 <CANiq72kFpS5BE7Ea8=Z6SUi_Y2RAt5wsssHyqL3ocgR1UOHJMg@mail.gmail.com> <17e81b06-7778-44f4-94cd-6a2b1fe5c7e0@gmail.com>
In-Reply-To: <17e81b06-7778-44f4-94cd-6a2b1fe5c7e0@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Jul 2024 23:55:01 +0200
Message-ID: <CANiq72mByZfV62bXkd366GNX1ReF92=rUf9Dyh165Ce+Wc3F2Q@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Update with v6.11-rc1's `for_each` macro list
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:39=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> A quick test threw 326 extra macros that are defined in internal headers
> under drivers/ and arch/. Including internal headers would remove the
> need to update the list if a macro is moved from inlcude/ to an internal
> header, but the list will need to be updated much more often.

There would be more changes in each iteration (which is why we avoided
scanning everything in the beginning), but currently it is
best-effort. If nowadays there are subsystems that want to start
considering soft-enforcing `clang-format` and that is why they need
them updated as soon as possible, then we should discuss other
alternatives (please let me know if that is the case!).

For instance, we could try to somehow divide the list into individual
subsystems, so that they control it and can perform the updates at the
same time in their commits as needed.

Anyway, for the time being, we should avoid editing the list "manually".

Cheers,
Miguel

