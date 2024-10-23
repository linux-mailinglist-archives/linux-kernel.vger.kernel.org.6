Return-Path: <linux-kernel+bounces-378740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004039AD4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D741F2310A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6D1D1F4D;
	Wed, 23 Oct 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DRUFrSX8"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A414B077
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711466; cv=none; b=R78uPpQLyDvoumI9sWHZbs7S+cmHviataQQDXNfRVW1hXj9geeseO/yH6pNzB8vObbXYR+YvrIigTNg8Snh8t5GvsoV1eeQCmvJthnSQgJBqRAoqISgwKcD8NYPCZawhXmcac6P1wo7XRjJXGXRjUDc5FxxiFkRlWpKq+EKNEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711466; c=relaxed/simple;
	bh=SEURKXC67CG/xeyRenvYrrgBTAb8w7etVKRliIV62vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/ttvMtWhvFxPjPf6O+zB1ZNnhWHGih9qRgPs4B3AIVpLmefagC/o4Y3sbSuPDo9rgMcYU88OUQOxPz4LA1bV21kFKvHaABq47AUjskVr/fLwqtoc8FLSOwWSX50SPvftpTW3ewl65Z/SyrPrWIiZbh53VCcjVfBMRxVH0G9Q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DRUFrSX8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c962c3e97dso167249a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729711462; x=1730316262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+e7T1vu9FNJZObzFlgyQWSw3AUTNv1bbvqIfeY1LjA=;
        b=DRUFrSX8xCUqoo0Sxr0M9JOEfyF8Qwc8c9yBQFEHAtR7sM24V7VxQxWKMe3cND6c/O
         ZdzzBGVRRxiud1CphKeuIlmNGU9urdefZysYt2i4uMb28H8wVnsLdM9meDEmN3U2dJpA
         nBPMIkqCpuH+lhjWgcNA58P1JAl81qesX387Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711462; x=1730316262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+e7T1vu9FNJZObzFlgyQWSw3AUTNv1bbvqIfeY1LjA=;
        b=gBRftlgFtg67TP/GIOCrux3DOP+4j77TOi/DwnN5gUpgYaYlvtiOddQKqjWPyb2Dmi
         6sTLzQYaxjYZ2aOqaEubnHouB5HJbAsb65EfgDw8FfHUlY0aIbWmVycEQ5HMiPPb1qlB
         TgRt9nSqUK+xUDgWxJzrJbA1wDLuFqTLSp46+9xeuW1XYTnHF9aZrx7DKdKQR9rP/UNM
         7Uu4Six7XlMwuE8vhm9dq+r37/oqsI+TACWIugKlIwCNNgerTzzJZc/da31muOCZHgNo
         R6egGRnwYZYwzk7ld+/gQ8BYrsCIgU+vOFj8RkKoQawCvXYBLaOdnmB1DgXyGG6KSPjX
         ZHnw==
X-Forwarded-Encrypted: i=1; AJvYcCWdLN/WohqK/3r3CWrr8r3xV4Cn7tyuzziRJegkQRHzvM74CoKtkMtiMTBjTAWnq5cfw7pDsVGcs5wdTn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy73XqFm7UvBgp/dFyRsqrrnhuH/GG3ZXmY3akcOWWENJXEJWuL
	ZJnRhJ31oDjmVH/CSVEplkpPS9ZbQEIhe6YAZKlYzB8XsunW56TQ8okjA2kg9bfU6Gp3kkpgCBm
	0UtszRA==
X-Google-Smtp-Source: AGHT+IFvMF9BI8yBVBDC5uTAZqsrvja9xhKgMtpQzD5z87OJgs5qnxgRD52U7xelOkfvenj4q6Or/g==
X-Received: by 2002:a05:6402:d06:b0:5c9:2a8c:8961 with SMTP id 4fb4d7f45d1cf-5cb8af6bbf0mr3430582a12.22.1729711462499;
        Wed, 23 Oct 2024 12:24:22 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b535sm4734192a12.68.2024.10.23.12.24.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:24:22 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a16b310f5so10108066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:24:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw6tp7oVd+KhhX4jze8gL4QAMzW9L9BkJ5RQDLQJPDWKa5HXRbXwiFzL62KVVUiArEzKzqXkftuuI5r9A=@vger.kernel.org
X-Received: by 2002:a17:906:f588:b0:a99:e831:1b52 with SMTP id
 a640c23a62f3a-a9abf96ce31mr356698866b.51.1729711461550; Wed, 23 Oct 2024
 12:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <ZxdyYjzxSktk34Zz@sashalap>
 <ZxiOjBRdO6EMAY4H@infradead.org> <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
 <CAHk-=wj4aSJsVA6weV7u9KD1yA74JZq3dYZKbUtxp=3o_esnVA@mail.gmail.com> <e4ac4459-faf6-48df-851a-a5204bdee4cd@paulmck-laptop>
In-Reply-To: <e4ac4459-faf6-48df-851a-a5204bdee4cd@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 12:24:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjT3EzfL3b37k1aNMPkmdyfaqNoxKiqsJz0rrOqnfky2w@mail.gmail.com>
Message-ID: <CAHk-=wjT3EzfL3b37k1aNMPkmdyfaqNoxKiqsJz0rrOqnfky2w@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: paulmck@kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 11:37, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Functional testing?

Yes. Things like the stuff that Guenter does every -rc, and that
invariably finds several issues every single merge window.

Like actually booting up the kernel on multiple different odd
architectures. But also much more complex things than just running a
torture test for a very small piece of the kernel.

The same way linux-next does the build testing on many different
architectures, and that often finds things that developers missed
simply because the bulk of developers are still purely on x86-64.

              Linus

