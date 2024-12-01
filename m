Return-Path: <linux-kernel+bounces-426676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C99DF686
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F013B1629EE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB951D5CE8;
	Sun,  1 Dec 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FG0bsvZF"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBB1CD15
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733072103; cv=none; b=N/kWv5wmbmnUm5GzZd28JIi+hawAE+5oooAiYiW+Qy1o151XBqx55dUJqbB2dhWLzhi4QQzgqHoi6lVyxeBTI4DePshrGPmZLM2Dnx3blq8RtnQBdiDrtLKRg1WybyN1rTqei7pXyX/e62ar5aCI6o+SgHQ7nJfWRc6gKtef5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733072103; c=relaxed/simple;
	bh=Wu7aLMR8bgAYmwBV8FIHf7YQhTXWw6T7z4NKroXjPYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg4nsJd/Mi9FMRvogE4QZH2CmOoNHFVZn+HxGLiFXp8Xq4HyvEJunzphEPsvqVxk6fSrwoyxjxjpYbYJ6i/O96rX+5Gr0zWJaXc1/56pgYTK7ywXEGI7t812fKTt/SdhxcH0rXIE2dOvbr4Hzu1tCMZs0kqj7AfcNlbFyqhR6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FG0bsvZF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0419so2264888a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733072099; x=1733676899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q5z2s0WfIwLJLVHUR6snQ9W2d5ktmXbetex9wVs407g=;
        b=FG0bsvZFpa3JWJ/zIwxbTGBhniCz9sjRZ2yCIcHp/CiJymhHvk8VGQDuodam5ewwEq
         pfdUhI8vyQfdGLmsdZY2Z/rvOJgO5hnoK8jBfZ+nbA3uuY/8lt8lPxupVTKIOKGmhoym
         eCw0MH8VPyhhZao/sodWuEpMVh/9Dpweo+Buc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733072099; x=1733676899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5z2s0WfIwLJLVHUR6snQ9W2d5ktmXbetex9wVs407g=;
        b=pqYHOWzZUV931fRjZJgATe3VnKlAFdC7W5R4mhRp9uxaSxI/evdclxIGy+HdOqQVmJ
         8O+92jZLTpuATiuKCXnyxEasKSQ0jojDeRQUxL48GtgPgBSENwJTDW8fXQdCqCGx3k/i
         7MQ9qPensKyrbGhzTtqd1VmqClT9w5s9Vpry88wOqAwBRp57AQU7FTUH3xMebvel8w8e
         MECXQyztWCeAywAYnuHGWXU5xldWEtKPQRfylxqPZQeDcoX9AzAAv5KsQW3dWPmJ4J4A
         R6px1ySO4C0fJJo63ts8YfGJdu/ZAsZJQODgqo8CIdeV+4GpZ0nmw4XgfRaPPl7CaJ5e
         FEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmqSXbGT//MC0/+hAZMQurnmQpDrX28aHOR6iYgrtj2Btx46B0IS5Gm8lxxDqjbDpmxKt9Ylspskuzgs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt59o6K135qDZZhRw//bgcNaVCEBkclLVloBe9yhr3s/Am+R0v
	Vgi3AMlV1tVRTXvbDnEowVjngKVTFbAFe07VbNeBL+w8meY5FZREtaxETivcwCNVEL3jWfTqpuA
	b7vQ=
X-Gm-Gg: ASbGncu36wyht2I4IQOP4Ra1IbVqBX7+NADlkr0T/LmEjv1+wQYpXGzEC0Uguv/oT+f
	AOvfWHF/uflaSfZa8OBcvrX69aFbUCpvwCoix78SSKZSNtbXqA6cOlhmaTycuhSyMqVCmXf+tG5
	pZMNeSKPCUICsfhNFsb5txoNZ71s6G+SDEmN3pFh8CV600bHXOVMKrpGAJCzdmLzW/vtQOUz1yn
	fV/YWe6TH0pWTYnSA7slNNZ06KDIPIjoSPG2nu+E2HNnsYsT0oCR151sIK06G537kPJPhMVJQwL
	rW7hqBbnkUXysKYRHubtarNa
X-Google-Smtp-Source: AGHT+IFK0ZVg5ddgLBXMHFCvIpD70vveEvyoYtpEVAZ+/mFzFZ0ERmaS7WLoCPp9vRTbhuL2RewBdQ==
X-Received: by 2002:a17:906:3153:b0:aa5:43ee:2ff6 with SMTP id a640c23a62f3a-aa580ee8d40mr1764715766b.1.1733072099509;
        Sun, 01 Dec 2024 08:54:59 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6a57sm419415666b.120.2024.12.01.08.54.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 08:54:58 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so367962966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 08:54:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUdzZE0WA0yM/mkFcCtGH9hSpsVxiEXPjDaSI25+MGDl9+agtkOfrscBg245STciAQtIWqHo2joxwAJDo=@vger.kernel.org
X-Received: by 2002:a17:906:3d29:b0:aa5:1699:e25a with SMTP id
 a640c23a62f3a-aa580ee98eamr1451183366b.10.1733072098046; Sun, 01 Dec 2024
 08:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130045437.work.390-kees@kernel.org> <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
 <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com> <20241201-konglomerat-genial-c1344842c88b@brauner>
In-Reply-To: <20241201-konglomerat-genial-c1344842c88b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Dec 2024 08:54:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcbq=2N8m5X8vJuUNgM9gpVjqpQzrnCsu19MP8SV5TYA@mail.gmail.com>
Message-ID: <CAHk-=wgcbq=2N8m5X8vJuUNgM9gpVjqpQzrnCsu19MP8SV5TYA@mail.gmail.com>
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH)
 case
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Dec 2024 at 06:17, Christian Brauner <brauner@kernel.org> wrote:
>
> /*
>  * Hold rcu lock to keep the name from being freed behind our back.
>  * Use cquire semantics to make sure the terminating NUL from
>  * __d_alloc() is seen.
>  *
>  * Note, we're deliberately sloppy here. We don't need to care about
>  * detecting a concurrent rename and just want a sensible name.
>  */

Sure. Note that even "sensible" isn't truly guaranteed in theory,
since a concurrent rename could be doing a "memcpy()" into the
dentry->d_name.name area at the same time on another CPU.

But "theoretically hard guarantees" isn't what this code cares about.

The only really hard rule is that the end result in comm[] needs to be
NUL-terminated at all times (and hey, even *that* is arguably a "don't
print garbage" rule rather than something truly fatal), and everything
else is "do the best you can".

Could we take the dentry lock to be really careful? Sure. We simply
don't care enough, and while other parts of execve() are much more
expensive, let's not.

              Linus

