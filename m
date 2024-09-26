Return-Path: <linux-kernel+bounces-340964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9131987995
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E9282850
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7517A938;
	Thu, 26 Sep 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fONW8FxL"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF601175D42
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727378300; cv=none; b=MNWqByGaBqGAKPP8Fo5hogIQAHDpXmzuwdq3xeZGihY8+ONJx0rpcs4P/40ood29CEvyxB92S1PYa7y/z4sBw8UQ0NNDBzWHwq4VNB9OCP3jUOqO6r1N4ZjP+qjC5cTRy5r+4gUyHtzS7tIIQkkR7YaM5kd8D4wxd/Wxz4do12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727378300; c=relaxed/simple;
	bh=v/LMChHIPdULBRffOUhtGPYw1P7XkINjKSQB0P3NvXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqjsxJugBkZLRvEZDoe8n/r6Yq+GMQJCLouzYaJ0MY+m4tcT/4tXKuSDUCfwzx0BUW67y/8AzNnmPbSAKVLD7d+JegozNhL7kl9WKODRyLw3JfWOkY5Vb7Zz3BfD6A3eLwz2Cl4ZZzq8BwB6qAHfCzyWh3PVcYKA8jCivGJkIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fONW8FxL; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53653682246so1702252e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727378297; x=1727983097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9L9OKN5fpu686IqPoFFWg+m2KoaIpCSuh7PJeN+XmFw=;
        b=fONW8FxLpRwpA2ztA7gZW0+FUJflpvUYj1HFp93QAqVq6HRC3WMmBpXvyVKIoaRQyE
         MK9dSqez5clUNrA0FBOc6awsAKHTm5CxVPf8SU3mW0lkoSGwL9vtjAltouTwLhCIixBr
         XoLdLJNU7mWIeeoLz+GsO3eek5mRkd97X9RJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727378297; x=1727983097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9L9OKN5fpu686IqPoFFWg+m2KoaIpCSuh7PJeN+XmFw=;
        b=tRxW/w8pqFu9vvvsO1puP3E2/y9CNSsjl26e1e2hW3sL5A6NH3kPlqcQ9ejVd/OQ9L
         se9/HvQQT2aXXnASzebG9V1XMod/vKcnGwm++f1wHQiKXM6QOMTJ9t91zZeOXJ3NrI7D
         d8p7FKlWMjXvxdOnU3HRxD5/0lGIKKvcNqAgjd3CbpkJPXvaDSIny3HOjxYJqkA+e4Fx
         9JGakJXFUqdUga9Zthh+IAFhCJK8fJbfElisWgjhexhU39le9qHcX8zVtYNtIDhpxHrP
         Nu/MpIkpC6cKg54Hy1/hRpINFR/AH9fvp0u3b7cFRz52JS8hPOAwi9/hAmLJzcGUHTzI
         39/A==
X-Forwarded-Encrypted: i=1; AJvYcCXliyzCNGTC0BqcpxmYR0w8AHSPYpDNjQNAQkIj1l5UFMye4/5tqPNvoJSaf+mFVRsiDhC36JdMOoNVdAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDrFXqTcZQCdCzjAHcbcgzEZw1be6kv1UWX2uLS2Yr7SJZlGu
	D7I88iymeLRvCyLwxgtTDfePFAIgvo7oWybud+11QZKkN9XYBbwnyFbWNr7BH6m7j1iWNVr9zMm
	3Z3TkUQ==
X-Google-Smtp-Source: AGHT+IFYfxkDehO8FYxohI/j0xrU/d7OJ86mya6tZ7MEFoWhPgpoPQSK3QmY7Z0Zz7FCLEW/uGH13w==
X-Received: by 2002:a05:6512:3343:b0:52e:9b92:4990 with SMTP id 2adb3069b0e04-5389fc44eacmr462304e87.32.1727378296728;
        Thu, 26 Sep 2024 12:18:16 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775d2esm30116566b.24.2024.09.26.12.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 12:18:15 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso197254266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:18:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX50IGe1nfAMgkfQCulhL1O4bWZGQz0KWdShzdufY07A4KQ/ceoRBhBWwiuYLVXIWi7AD41HoFyRWum/wQ=@vger.kernel.org
X-Received: by 2002:a17:907:3f18:b0:a8d:2c3e:7ed3 with SMTP id
 a640c23a62f3a-a93c492a738mr48686466b.35.1727378295065; Thu, 26 Sep 2024
 12:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202409160138.7E27F1A55@keescook> <d122ece6-3606-49de-ae4d-8da88846bef2@oracle.com>
 <CAHk-=wiJiePHNw3Whxm9n==h3-JwXojefAN3OiDzT89BO3jDew@mail.gmail.com> <874j625j1a.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874j625j1a.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Sep 2024 12:17:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg==rBvM9G4kkT3q5GQN2Pq3M7Vyu1VG+QS7XWmpshGYw@mail.gmail.com>
Message-ID: <CAHk-=wg==rBvM9G4kkT3q5GQN2Pq3M7Vyu1VG+QS7XWmpshGYw@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.12-rc1
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>, 
	Brian Mak <makb@juniper.net>, Jeff Xu <jeffxu@chromium.org>, 
	Roman Kisel <romank@linux.microsoft.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 12:10, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> One of the common causes for coredump truncation is weird interactions
> between io_uring and the coredump code.  (AKA kernel bugs).
>
> That is something you can't ask your debugger to tell you.
>
> So from 10,000 feet I think the idea is sane.

What? No. Adding printk's to chase kernel bugs is certainly a
time-honored tradition. But we don't leave them in the kernel sources
for posterity.

And none of the coredumpo failure reports had anything to do with
io_uring bugs anyway. They were literally "print out when disk filled
up or core dumps weren't enabled".

If you didn't get a core dump because the kernel didn't have core
dumps configured, we shouldn't print out some babying kernel message
about that.

None of this has anything to do with io_uring or kernel bugs.

                  Linus

