Return-Path: <linux-kernel+bounces-416372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D740C9D43EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8362833E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880AF19B3ED;
	Wed, 20 Nov 2024 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SqmcAhJP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5814885D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141985; cv=none; b=TQHU6reTdm//hBkiFEh79XHllgU/rQQieigIrVdrhTK+DE95ecA7s4YlXWGALcfOa3frDUw2kgwXvC3pHte7sE1WDB2rQcJWYk9q/dP1jgQcTm1ETopbGmotoB8jg/FYFCE5BkM7Gcek+8pYRaMfY0t3FM4ozx0kAkNPzHXSLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141985; c=relaxed/simple;
	bh=ZW/OJgWLeFbjei46IAPX/4Cz7LMxgTjOd/pJAhr2qyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpsoJvIrpCQ2XW7fNzfDXbJ/UgMe7GytXm1o0TZZsnHsDWaa/pt9zHSsaxufJN01yzFGLbecCBhHlh98QaBcTmfHkAEtRosFnY8tIxCbIbfVDf1bV7NuWbfZ9+9M8Q9cUVmvJsz+VcIcB/VBO7JRF/dTgy0RH92yeMx9IgeZLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SqmcAhJP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so46268666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732141982; x=1732746782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko48x4KlSLfqkqiHilhm1LDzZc0/qFH+wFE90LYYo2c=;
        b=SqmcAhJPt15XUcvalIdY/42ACRciNFWsIj155tH+wrtva+hWvlgQKPlTNgc8Nbmq7Z
         XbXCsC4ij5dKDxbxnGgBC7H6iunijE8nbwuCn6hqlFOQxjYXNJKGq0eAjaqlLWWimsw/
         hy8uF3RrL3suiT/BbxgX+f46Sb5/qfkIu08sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732141982; x=1732746782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ko48x4KlSLfqkqiHilhm1LDzZc0/qFH+wFE90LYYo2c=;
        b=LqS9L900tZiBVYTl2MKKYQMLVmG9rqXqv/EHjOkk18chO3px8GfOLzN5kau1ql/UxH
         tvK6quYdXXkHktRlOBkuWSQTfNcFaT6IYYv9nNa5f4x4vITVwG6+qx9SCK5ljkMPuzuB
         vMZwonTj99Cn8eXoO+oXW52N0D36wHcLw18tK0pMhq6BrkIiC2sugrds2lprdVLZJFmD
         3fnsOtsxg7u7RzNw+rzcNwrX+YWBbqIn8cQytceG4UUBupWq2yDRb5anq6MTMQ+T3us6
         huQPvbpkYimeBog+jg7dBhpShy754W5hx4EJMxsxtyzEOMyzrDXyRXdwsxg/wgnCL86R
         yIFw==
X-Gm-Message-State: AOJu0YzJzH9litd2OwwkrJgd+C9NhnYxztHZIfr+PDUtvVvN5pCrfBew
	SxKqjfzyM3ZU8PcyEsekpVGjdi0l/1CrXVHEHaMqSDBSvwQiv6d4ax1v1vjB9mgKxU8/DMrCTSj
	qiOJE/Q==
X-Gm-Gg: ASbGncvfIYsWqFB/aPKAz9zTZAzm1DXUI1eirMXyG3AkZzcR9ycEBbdEa4DPUQdiS9f
	aGOE2XiMew6mmjK+mCIoNQSDZwvYW5gAxgHSlj+7OoCgaC/44cLZDQDKhApZK6+DRo0sZ2YPt4c
	KRfdRzvBxTwfcRfEq34yqdrYJF14HS/CLUO44cg/e8CmjgWeZLVu1s9BnUofx3BlGdYC/vGvgWK
	x1UsUvfZZOXmUqa/Y+0buFSxjqK/jnc4J74SAJIU46yqnLkiIJL5Qbuz6ewfbFoayoH4d5x9akH
	vPsH35/M06Tx/Jk4YH2qNIpD
X-Google-Smtp-Source: AGHT+IHB2EH31Dc3+e1ZhZoBhDdtJI4JXYZJ+CQ8EuhCC3l4M4ZLI9QIy4+e1dFYMM/3RKkEuA4oLQ==
X-Received: by 2002:a17:907:1c0d:b0:a99:f0cf:f571 with SMTP id a640c23a62f3a-aa4dd57e0b9mr400059666b.33.1732141981756;
        Wed, 20 Nov 2024 14:33:01 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d33b7sm7067266b.100.2024.11.20.14.33.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 14:33:01 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso43146966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:33:00 -0800 (PST)
X-Received: by 2002:a17:906:ee8d:b0:a9a:634:dd2 with SMTP id
 a640c23a62f3a-aa4dd71b718mr452705166b.43.1732141980572; Wed, 20 Nov 2024
 14:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook>
In-Reply-To: <202411190900.FE40FA5@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 14:32:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
Message-ID: <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Nir Lichtman <nir@lichtman.org>, 
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 09:00, Kees Cook <kees@kernel.org> wrote:
>
> - exec: Use argv[0] for "comm" with AT_EMPTY_PATH (Tycho Andersen,
>   Dan Carpenter, Nir Lichtman)

Ugh. I *really* despise this one.

People: we *have* a filename. It's right there in the dentry. Which is
right there as bprm->file->f_dentry.dentry.

And that's actually going to match the actual execcutable, unlike, for
example, argv[0], which can be filled in with random data.

*AND* we don't need any silly and expensive get_user_arg_ptr() and
strndup_user() copy for it, which does that user access twice.

And no, we shouldn't fall back to the horrid thing that bprm->fdpath
does either. That's the thing that you apparently thought was too ugly
to use, and literally the *only* use of it was for this case.

The reason that code existed at all was to generate a filename, and
because we didn't use to have access to the 'bprm->file' back in the
days.

But that was changed by commit 978ffcbf00d8 ("execve: open the
executable file before doing anything else").

So I really really think that what this code *should* have done is

 - get rid of fdpath that you made pointless by not using it for 'comm[]'

 - teach the code to use the dentry name instead

because this horrible hack is too broken to live.

             Linus

