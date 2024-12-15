Return-Path: <linux-kernel+bounces-446286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DA9F222C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2555C1886D30
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5ECA6B;
	Sun, 15 Dec 2024 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uwg+o/Sf"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE89454
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734237444; cv=none; b=Vh0O96hWya4vTIVYAcn3sP91Ux8Az0XBhVCZbOuhVt54IUBaCVhfdzwAkr3FiHqQASpZzT8+m+0t/MDZv9kSrTBsmGlvLhV2wpGTbCwS9z/nhEjsmQ9ST7KKKiZK3LRceQS2GU7lEBMLQ9mfjqgU0hRKG9nq2r6evhe8wiAr9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734237444; c=relaxed/simple;
	bh=lHnASJ3zbMBOYeEuXFmObrq1BdRXhpB5VIBG5Vz7Ky4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZNnrMJ8gUkFMhKJRLXzYYnmt8yXLt+X4PD4f4+CrD7Mb7hV+t+y+xXYuDexVAdqHhow33+yi2I/xgdnoaDXTN036gmeKk3LzO7B0U52VWxrgOFlfbUlPPznTDFfgy6IBRHafqH7CVH8BAvSBjM0e/tBYHz75Kj4p/8+MmIhtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uwg+o/Sf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso3905730a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734237440; x=1734842240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aTW8Z85aXj6hf86+M/PFC0hlgkTj220O66J/9hVmkOw=;
        b=Uwg+o/Sf7VXNTqgTyPV59wtqf2SNMVq7IQZaHWdZNlZH9Bn9dipcMBr+BniBm+Xx6E
         0HbBkTYKoLzsTFK8QGyV3xEnSuFU7M/Bms0E/4gvEvZtaNwlc6+JaI/Dn4hPMw4JM9YJ
         e7TI1z7ghtbLBa7OCZa5+rLxNobSacht7Fzmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734237440; x=1734842240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTW8Z85aXj6hf86+M/PFC0hlgkTj220O66J/9hVmkOw=;
        b=amcKmA+cNmEmZEnnpSWxlVHuPMQ2gFkRWWcI3CBt9nXPjHjGAP6Uy3qz9xSxvdspDw
         FxoPYMMm5TbtUlNDu8lYa7mS59cnpacEJSy+7TFj5pUUM6OihlN0iXz/+e5APRsNL5SJ
         HvHGtXyG9qYtSOelI3Pg3jEE6YmvBeNZXQs9Cyf9PVfPfewU4e1Q6OaaEOljoCxAcLqJ
         p0UgzPn5mW+m9BUyc4u+GDQd8COFxAg4UiCkISAuDvb+PqERDkiyYy8kQ9GkR1Z+01vS
         WrhjaLXFJVt+IjllrBcya0aJXqME5wPBfb3ctYap2vwp29MU0YGytTF2pF9bUC3Z0hSS
         rSMw==
X-Gm-Message-State: AOJu0YzIhneB84BQHHqPr8fpT6Q4oGNw96AIq9sBsMu3SNgKjfQV2FE0
	npiFr9CKXKbDFgrpIZCcdwlC1D1s3Isb/i4Hc7DALG4BNjpCVYv/ozDfv0gSdrfBFqEZMIxjWfm
	DB5Q=
X-Gm-Gg: ASbGncvp6W+vBVzK7WzkMtkbO5Q6hUAZ2ZiyE8wo3GbEPIMbEQAsBlOOuCE08XYdPaX
	iaC0OVMVndDSxMTQkw96CNh2RnpQmXe03vAo7CMuMZYPnCTK8pa8OWU948MnqIp/VxSvxsmu1Tp
	crrRcWge/fthHXbp27Jm2gMx+pAtXPh2P+IGvw6m/kHAhUdpnKRSwl5hH6OXRkobJKolMVN5qJG
	e8YiIHRzOjjVu+xT6madmFQKC/dX58x2uUroNUVzZis97qcCbYCLK47UdIObMj70WZMc9EXBHOn
	ZlEMjBn0UnDLoG8ZCS0CXLkv/SPINbY=
X-Google-Smtp-Source: AGHT+IE5gkZoSldTb18C0jpTwu4UM+XT5q2imLYpzd8cocQjM6xn8zJlSV5VyKWuuTIwm9KXyrZJJg==
X-Received: by 2002:a05:6402:3785:b0:5d0:b9c7:479a with SMTP id 4fb4d7f45d1cf-5d63c39faaamr6482127a12.25.1734237440474;
        Sat, 14 Dec 2024 20:37:20 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab5198sm1631400a12.8.2024.12.14.20.37.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 20:37:18 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so501187566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:37:18 -0800 (PST)
X-Received: by 2002:a17:906:cb8d:b0:aab:9535:47cf with SMTP id
 a640c23a62f3a-aab9535481amr367773766b.56.1734237437830; Sat, 14 Dec 2024
 20:37:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home> <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home> <CAHk-=whrxZwrdm2zHrTmEdRoiC_29XR+0nJpq2CkZjm-ZdOTNg@mail.gmail.com>
 <20241214232333.3c49c1e3@gandalf.local.home>
In-Reply-To: <20241214232333.3c49c1e3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 20:37:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi63xXZiCUsMC_3JCuBbYNT2wSiF0JE24fKbyS=yGu8hA@mail.gmail.com>
Message-ID: <CAHk-=wi63xXZiCUsMC_3JCuBbYNT2wSiF0JE24fKbyS=yGu8hA@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 20:23, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> We are using this for ChromeOS in ChromeBooks where we have to have KASLR
> on. And yes, I've documented that it has to be the same kernel to work and
> will not work for modules. That has been accepted by the users.

"Accepted by users" is not an argument for sh*t code quality.

This smells of all the horrors you had in tracefs. Bad, unmaintainable
code, that caused endless "fix up bugs because the code was doing bad
things".

Now you're doing the same thing here. Bad, unmaintainable code that
basically misuses the vsprintf code instead of misusing the VFS code.

I can rip it out if you refuse to do so. In the kernel we don't put in
random hacks like this that "users are ok with". Code needs to make
sense and be maintainable, not be a pile of garbage hackery that then
results in even more hackery because the first hackery was broken and
caused problems.

               Linus

