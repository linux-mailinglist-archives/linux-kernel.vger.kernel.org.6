Return-Path: <linux-kernel+bounces-179281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A700F8C5E66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43814B21744
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8381FB5;
	Wed, 15 May 2024 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SgoAE5bx"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20273803
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715733849; cv=none; b=hoNR/RAKdLMJOcYFkLPDH8UZbPJO/ob7qiYBj3zNFHAw6bMwYTdU1353iVLHIuCctfeJGV76vAWsBmGloWtYf8+vXRK5el+RYgt9yWl7PbM6cqU/xwqTNX/jBPvfwCCPqAHgqZ12feoQ5q1L4BOQQOr/qaF8wAcacAe3I1QRLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715733849; c=relaxed/simple;
	bh=iyxC/dRXIM6KYxQfRCHr8g+kv1gexJCsm8khro+Q+uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU19HNaazjTpAUaoZWEWhlzZRtr86eRWUJL8sUcxgjbZVr/m3mGiMQGHC5w/iseG4sf6ZytIbuByMp0S54oYHN0i7La9FIWOC1KXv7TGv9sQeed+dR0lVOfssQE7ZeGRp2GyZFigFw7kUGDlWOLl4UkzAfVd4eTn/P+4/FZXKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SgoAE5bx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f0b6b682fso6793053e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715733845; x=1716338645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OZvAiAEdwWZe22j4pRu5oxfNYFobcCpcqXbwXMC6CU=;
        b=SgoAE5bx3eyQArxCKUggh8ht4aDxGQ4Fmm58StIU8mLqTWf6ul2yBiovIwYPXoO+Eg
         T1eJTDdSTUyWQIocGN3jSeKEi5j53Nj19Y00V9ZhbO/tDmr0sqsZ33Gf3nt6VvA9LDHv
         52m4bKkKzWuZnA/3xbaQbf1AVN872RTxZ7OGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715733845; x=1716338645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OZvAiAEdwWZe22j4pRu5oxfNYFobcCpcqXbwXMC6CU=;
        b=vropfLtg2WOc2sF1seUN+Uy1/zYyGN00NrpaOW4k6RQp9rxuQWqX1mKEOPb43ypHO2
         MZjjzf0kipj/jeMfbwH86CBr7XDGzQdJHSXwyqxB1dP0p1DvwTXa1ZW8C/zYb4G7XjoQ
         4ZcXha/9VOuX36Q1RRA+4bSkDFAARaOV2WMIWxKxJ1LJuhapX4lBdJ7D+PNNCopAe/IB
         ODvGpbvL/HMKYBICg7CCp0LA4JY//o4moiqDt9t3Jhho/CNM81UzuhlEPwJiAtIgruRN
         rGW+CNCyIEVHqjfMnwjkVmhLfHmwRLqlqqW8Y8l3kOeB8tWdg7mvyAXAXpFFiABOyjqW
         0FaA==
X-Forwarded-Encrypted: i=1; AJvYcCWPpXwY4SFzdcTBSBxgzy/WR97tzei0+t7ie9srG2S3Iuy0YUWkkdGnVtE3CF+aGOiAaW3s7mk5FoosBjDF5ljJqG/f826qmqKYXi2/
X-Gm-Message-State: AOJu0YzbGw4eVxR2HWneLM43uQPa6H27kzkkLuJuIlOz3+oencoXJbdg
	F+K0ILQlHpnwWxGBWuG1fAuB8MRG6WQQCWcM+eE0eQNC4V7k/s8hF2LMioDA44VbLUpyE6O6g4N
	NA8fQLQ==
X-Google-Smtp-Source: AGHT+IESFoGgn5qZwxZEGkXhK1PqrAdi4O6FmNIYSt49Y0KDUxPguwqe2RtseRNaU/EgQTryVQP7gA==
X-Received: by 2002:ac2:518d:0:b0:51c:d8f6:4e6f with SMTP id 2adb3069b0e04-5220fd7bd61mr11514972e87.40.1715733845077;
        Tue, 14 May 2024 17:44:05 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d2dcsm783787866b.44.2024.05.14.17.44.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 17:44:04 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59b81d087aso83611866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:44:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYEq5BkEQ6ta9hVlZD+TC29/Irp1P5YW/bRbGXGu9JIzBALu1xaMACwD54poxAQPe9rvSmEYquaT7fOWMDz0/6Lctq4u+Zm3kgy1rO
X-Received: by 2002:a17:906:a010:b0:a59:a9c0:57e6 with SMTP id
 a640c23a62f3a-a5a2d675dafmr1290775966b.75.1715733843947; Tue, 14 May 2024
 17:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org> <56001.1715726927@cvs.openbsd.org>
In-Reply-To: <56001.1715726927@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 17:43:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
Message-ID: <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, Liam.Howlett@oracle.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 15:48, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> and can't imagine it affecting a single application

Honestly, that's the reason for not caring.

You have to do actively wrong things for this to matter AT ALL.

So no, we're not making gratuitous changes for stupid reasons.

> I worry that the non-atomicity will one day be used by an attacker.

Blah blah blah. That's a made-up scare tactic if I ever heard one.
It's unworthy of you.

Anybody who does mprotect/mmap/munmap/whatever over multiple
independent memory mappings had better know exactly what mappings they
are touching. Otherwise they are *already* just doing random crap.

In other words: nobody actually does that. Yes, you have people who
first carve out one big area with an mmap(), and then do their own
memory management within that area. But the point is, they are very
much in control and if they do something inconsistent, they absolutely
only have themselves to blame.

And if you have some app that randomly does mprotect etc over multipl
memory mappings that it doesn't know what the f*^% they are, then
there is no saving such a piece of unbelievable garbahe.

So stop the pointless fear-mongering. Linux does the smart thing,
which is to not waste a single cycle on something that cannot possibly
be relevant.

             Linus

