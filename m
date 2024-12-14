Return-Path: <linux-kernel+bounces-446194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA579F20E9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B871887973
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 21:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD5A1B0F20;
	Sat, 14 Dec 2024 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UeqP2F/4"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143D19D07C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734210646; cv=none; b=SijbvRobxBRQcpi832OPILm8BFE57PN4orPvcf1qEjGBfzY97pTkcREbh7myK305WFCF34oTa7eWR3Nd8zhM0xpNtRjPoqhIGBHEE4g9P1ZOJgJNTr9KLBOnu9TGFl6wGJTz+ekqilT9HhcYQoezFywSTRiC96PzMEln7OwVVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734210646; c=relaxed/simple;
	bh=dizETgqchOGN9znBptIwYYp5DcUVnRRkyxawE40hqy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsWbCwie4U1KwrAe4HnjWLvN2vYEl+qtytA4m/wvCClq7WYMCmDEZ98fo4EJ3cnUV0jlLtW07jRnaBL2A8fgDBAY0hnliOmvH5Utu9uogpTNXQOIcogcO9CIX/QumF4PHMoXtYiBMHx9pfDEUMY3DGvNeMBlHLxk6js8utL2etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UeqP2F/4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f249f3b2so3879109a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 13:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734210643; x=1734815443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WY4ZfJ2+ctfZ1Zv59YN+ivx3+dAJ3DnG8Iv2rYTKPj8=;
        b=UeqP2F/49hwMyCCe/+3HhhrAGNMvDcfTb8eSOGITDMIZ5cPTnEhAOJMibzgGpq8fV4
         QI4ZomBlcTBm3UOxQj3PFOGUvVoUmjS6HB63owcxw4s0QLYgx2dOaZmgD4TC426cu2kl
         QLzbF/KHIlY7uf9BqHIxUx0WCZu3W/bkWs+F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734210643; x=1734815443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY4ZfJ2+ctfZ1Zv59YN+ivx3+dAJ3DnG8Iv2rYTKPj8=;
        b=Z9dR7jSoh1Pm9ZoEKjgTfU2Rn++GchgU13Gkr6yTCWHncafoqPGmN9aJcJTw9Fwrok
         4SdAqkmVnW7eMbsQ2hC8/dxBFQApY97IZ+CkJuy4vEVO6EiI5ICNcpTr14EZuCF6nVcH
         36M4hdkAquvD1HY0bmFreZfGUoul17x9ulgt+C9VbSehhaxUca8fw645tB0z2MQFykRJ
         Jb7PFL5zv+eNZvwJj1LTCeV7qC7Jwg7hDP+RHkI9amTSa/66KcLuANUrhHWOUz+gWaU1
         RkaJNupyTZexdbrg2MkJUmmFLCy7knb6zaiLiJxG+lBqT+/1Grf8axqNN0I5XYTVk6yI
         uJLw==
X-Forwarded-Encrypted: i=1; AJvYcCWcNPe3MfAw8dM77yt/9NeDLz+zmLECd1vm8mIfMUB3+xsmVBT2TE2WGYI+41wCtw7qMaKYOP3wHHVH61A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKGuEJ4mH/UZwgdq3XM1SgqUmZ5sXNnk8R62fHyCe8+tF1tFM
	tgepllZek5XTGGNhRcZ5XJsVL8FdE1tHPPgbTfh5tKWu4wZW1VKNtAh3Zp4X4ScVpp5AbpqNPRr
	haok=
X-Gm-Gg: ASbGncv+pjkCznhHAVcLG0eAhfF5YWnjj92GRuyYed3hzoQQj7n2BV4E2DuBZNUWXOq
	VJHg2sxwRDOhJYGto3KuvWlHHSJKV7bUGjn7VTF5KdxFQiDAdXIxGhYFMjuHo1/R+VfmaMf6JYy
	030doQdkv0//g/nhXK18spGmvj9LEjs+82kShbpin7XXFZG5FH7tpp/XQ+8lnLxkQvXrNBvXICC
	PQX9J9xy7vGg+OmsgIzPShhWTYV9IsjF64Jius9Cpfn0cri76jBGukRqVKiuohasZfrAh6BdqmK
	NQrgORx7MYtDtQ/7qJgiDH8dGJfqC6A=
X-Google-Smtp-Source: AGHT+IGrgYOPstrMDeSCU0a54jeo0DwWdNhsA3i1lZLTMLJlLA0nHOdIOkWYFO17ZTmop+ZWBcTvIA==
X-Received: by 2002:a05:6402:270f:b0:5d0:8f1c:d9d7 with SMTP id 4fb4d7f45d1cf-5d63c3007e4mr17035190a12.4.1734210642672;
        Sat, 14 Dec 2024 13:10:42 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9606b389sm134787066b.66.2024.12.14.13.10.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 13:10:41 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so375741466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 13:10:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVs4bNPl2+OTbjMN9oWhV+pZGO2Axgl4mPHB67Sl2KGkX9cI0VvLg+e3aUpsmbpCmrCwuoT60woTgh3iTc=@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:5d0:d3eb:a78f with SMTP id
 4fb4d7f45d1cf-5d63c157955mr17026663a12.0.1734210641295; Sat, 14 Dec 2024
 13:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125110646.50799-1-cgoettsche@seltendoof.de>
 <e43da8418fc54a5eba7cdbb594b24bb9@paul-moore.com> <f7bfbf89d2ac4b929637bbb25f749c96@AcuMS.aculab.com>
In-Reply-To: <f7bfbf89d2ac4b929637bbb25f749c96@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 13:10:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgraNfcOCZ4n_C+ircQkD_AhsPM-=z7snt+eLgE-6otkg@mail.gmail.com>
Message-ID: <CAHk-=wgraNfcOCZ4n_C+ircQkD_AhsPM-=z7snt+eLgE-6otkg@mail.gmail.com>
Subject: Re: [PATCH] selinux: use native iterator types
To: David Laight <David.Laight@aculab.com>
Cc: Paul Moore <paul@paul-moore.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 13:08, David Laight <David.Laight@aculab.com> wrote:
>
> Isn't this an example of why -Wsign-compare is entirely stupid and isn't enabled
> in the normal kernel build?

Yes. Please don't try to "fix" the warnings pointed out by that
completely broken warning.

I don't understand why some people seem to think "more warnings good".

-Wsign-compare is actively detrimental, and causes people to write
worse code (and often causes mindless type conversions that then
result in actual real bugs).

            Linus

