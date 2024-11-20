Return-Path: <linux-kernel+bounces-416144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180029D40D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21CF280E36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489B15667B;
	Wed, 20 Nov 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d95i085E"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BA153BF7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122606; cv=none; b=Rs/J86fma+SB+a0AVZWaKTNTYEaBGNoppjjxhMwhReE1zetyyFW3BgjvtKBoC2MjiLmHm46tWNuabBQwKVKvrS6Wi4mQscYJkzG3FfhQq/oGK2XpmLa6AZ5vdThQnjUWGwPSooOKvnVjCOXkcP2OrN/quZTWpTzMUjWbwPb9olc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122606; c=relaxed/simple;
	bh=DI4mzrRhN1pXfPAx1Qmz4elhPEkPtm63o6O/v8ByJz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhsxVbp92hGGZQMTpD+P5CcjG0N9Sxbhmo8upXzQowXn2eFJZ2UjMz5/rx6BoIjQdc+OuT0vasJn4R/Im0099e2Hxd3gkWyrdIk1L3adqnULVj2as1j/90MkTE0iLPFEQ4QAPDvI9liPwNSQ4MQ6AVvy1P4XnykNeI/KMcKVN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d95i085E; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfc035649bso5632405a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732122602; x=1732727402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uVFQpj1IlF/pwYf52lZknl0pPtpf2sXOXdQjvKyV+Rc=;
        b=d95i085EDtcDAx2ZoHkKEC4R+26NFE12uo/B7ntPObJRKSSeXCPdk3H/bjmNrjIfo8
         EnkMC2G1o0bprdKG5d3Ol8N3ZcwUwxRO91hPy64bET5Tu4D78qCIaoOjJ4O86bqAMWmA
         rs35QGw6b/zx+hfx8RonsZnEAmRpYrs3bOdy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122602; x=1732727402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVFQpj1IlF/pwYf52lZknl0pPtpf2sXOXdQjvKyV+Rc=;
        b=a48BjxUKXgLJItimg3tN6N9AlqwvpFYRa/WVW74lJCXheugKyLJgyllcSoOFDBeFnl
         obqMdPDvccAZCzV3T0BIvb1d6DplLil5EyvBWB5NhqrgF54rzJkJDesEN9oOSlkxCQfL
         7Giao2nQLGLh4m3JO6L7NVeGZLOtLez+ChrXFGtKqZhw1PdJgGoxTEAis4/HIt1/1Ikk
         dcmmpNPLSpKFvczrCiUGAj80LfSgGXaSqQTq2MHtS4APKAlaVZWfd4RQj/aZCqoIirms
         cK/SsYMTNXG/DQ7i2fiGyu9b5RQMUY2inedklGyn1bIwPBp26dbVq4rXq+cXAI8HnU8b
         aFPw==
X-Forwarded-Encrypted: i=1; AJvYcCXCDVMSLF+qE8A53TssyQ5oY4hzwF1hMa/CwjwINCC8z2ZUyZLPxdQuR+DPBoYVXsG2GeUGCPyA+b4IzSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5Fbi9aj5hrxvzZ2WvpwVFaeMEXdn48N/a+DQn7eaLCyJW5wb
	BIClR+CK2WBng1YOCBtJmZhJ51aijbiI4Dq93noyYBGYjr+gugN/HAoPNkM2SYFr5jqpJzLCMzq
	QPOpkDg==
X-Google-Smtp-Source: AGHT+IGsb9ZGv9WhPbTIIqzxKrfi/bgU9xEUqJWfp6H3tT1cRaFMUWyjlqpvou2KVL/Hy+z6Fe43SA==
X-Received: by 2002:a05:6402:908:b0:5cf:9c4e:a4a7 with SMTP id 4fb4d7f45d1cf-5cff4cf6c93mr2524173a12.33.1732122602170;
        Wed, 20 Nov 2024 09:10:02 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff44ef803sm1038505a12.28.2024.11.20.09.10.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 09:10:01 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a850270e2so425566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:10:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2dDHwSl0NTIbh5AVCmTU6dup4sw+u5tUlKLcABvBoC76FnyMePyOQiyT9qivQ8yVytE6l7ob9t0qZY2c=@vger.kernel.org
X-Received: by 2002:a17:907:787:b0:a9e:c881:80bd with SMTP id
 a640c23a62f3a-aa4dd719b2dmr250045066b.37.1732122601222; Wed, 20 Nov 2024
 09:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-vfs-netfs-7df3b2479ea4@brauner> <CAHk-=wjCHJc--j0mLyOsWQ1Qhk0f5zq+sBdiK7wp9wmFHV=Q2g@mail.gmail.com>
 <20241120-abermals-inkrafttreten-8b838a76833f@brauner>
In-Reply-To: <20241120-abermals-inkrafttreten-8b838a76833f@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 09:09:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicQOQ1mkZqtX0eEWOxBG9Dih+b3DvmGnyY2oVe2vn8RQ@mail.gmail.com>
Message-ID: <CAHk-=wicQOQ1mkZqtX0eEWOxBG9Dih+b3DvmGnyY2oVe2vn8RQ@mail.gmail.com>
Subject: Re: [GIT PULL] vfs netfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 00:49, Christian Brauner <brauner@kernel.org> wrote:
>
> The base of the branch is definitely v6.12-rc1. The branch is simply
> vfs.netfs with vfs-6.13.netfs tag. And the branch looks perfectly fine.

The branch looks fine, it was just the pull request that contained old
stale commits that you had already sent me.

> I think the issue was that I sent you the fixes tag you mention below
> that contained some fixes that were in vfs.netfs. So afterwards I just
> didn't rebase vfs.netfs but merged two other series on top of it with
> v6.12-rc1 as parent. And I think that might've somehow confused the git
> request-pull call.

Oh, you shouldn't rebase. But it also sounds like you are actually
tracking the bases for your branches manually. You shouldn't do that
either.

All you need to do is fetch from upstream, so that git sees what I
have, and then when you do the pull request, you tell it not the base
of the branch, but just what upstream has. git will then figure out
the base from that.

                Linus

