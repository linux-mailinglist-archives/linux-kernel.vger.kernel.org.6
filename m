Return-Path: <linux-kernel+bounces-419220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A059D6AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA24161BE1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7A1494CC;
	Sat, 23 Nov 2024 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VebvtSoz"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4A182C5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732388583; cv=none; b=Tq500Nb+hqglddZGf1alvG8z2cH0CVt3URWbexPJYJY2Nv8g3KK/6WMxRMviqEZn/ZoTjB/5GjVmWw0gOiYTBC/X5dIf2u2akWlTbTTGE/AWDEeKMreD7VCiJNKG4j8jyCBa8TGs8j/a4biRiQ7rhPFG9u3UXbrab2MH5PJOSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732388583; c=relaxed/simple;
	bh=btkd7bcQxHTADngVj0AV9fsC2d2mq9nAj2gXnskQc1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrVzu0/mEtCmaq3j0O1mOb3QpU9fNE4qCeHUkkdi+sx2CS6kaEllqIZvs/9HcK9ZuOCZuDmXDwD40AtChGS92tbam+HdYAf6L17hIJm+QO00BKxmvPuw8/A6upYFSTqVyb6w9xOutRBukOXM9lROV6SQjjiHQ7IKCIfnaDTmAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VebvtSoz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so3820303a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732388580; x=1732993380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ufinr/VRsCnZl1jhLb5tWhQ+vGOvxxlOxwqyVUO4hhI=;
        b=VebvtSozfk/XUSXfyzfSAr6cpivgPzbQvJ8rDF1e5h6GIe7TeiSzJqeodbYQ+23K/b
         Gftp8TZGLvmt5+zfHceYPvpnzGUGv/ONARRrqPZ8xwQ9QjPtROy6BIbv6YccV3aIcgFD
         IsDbg3wXzN66j1CswT7lSEEtvQMn4Ji2yknBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732388580; x=1732993380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufinr/VRsCnZl1jhLb5tWhQ+vGOvxxlOxwqyVUO4hhI=;
        b=Av8GNrc6lLLB3fBjLykef3ictpsnS19FPzE7j+iFu6EpdTx8oTimoALZzHohVLYIwJ
         LDoA3sc1GB8mG8q+mYsnKARvqpzmHWgiIITVA7u6sJks1L5D7I4olpnTBO8/NuPhm7Dy
         4FxExuqlfrYoXaMyBbBQs89tjJ/ONuv1SW4eGsR5nNpdjufSrI+c42HadzsSdsXwJ+1h
         onfLVYvVD53usvYmd8XLFkURt1fBt7WNA8x74aH+KqA7/vN8SkOPZlr6hJz+O1xvjjIY
         7+EY8mSxJr14kfg6ZLHo/Ftfp4TiyPczTZzy/5/W1pyPJW8SgsiMZo8bmCX1yXz9rcn9
         8JmA==
X-Forwarded-Encrypted: i=1; AJvYcCWoY7fnHUJ9/wtBEyCy8MitOpAkN2Ql+ArpfI+Ah5/RkgEVxRZrRFvnd4ctzDPq4C3iWUWe50Mi7yob3sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvED+6CK4u0F1kqMR67v5c12Z5wF9BZDxKeG7ySi/Qp4xXRDz
	c0EtUdmbgFBJxzLDzhSItJWqxaIM6RKYoAWwPxUxWzoZwGpy5ODb0mg2q2PpA3vDqXvSR1m88iZ
	+Euwl0g==
X-Gm-Gg: ASbGncuPP5Her+8djQknLxAy9w+e7O9eB1yZVoRujLQHkZOh28MRtax+Iv8oeGhXk4Z
	66tzzzasQvCV6n6usOWS3hdhM+U8zjQ9N09O9iaiJNVX+wIkCvf1RdVbL6rR3bvrazqmt2HRk/k
	/0zbZFBCnewxkckqh1xBS6b2kEa+v67UsdO/O1R6aYXi/+TYOa/1WtR6G/MdbiK/zNCDDwxZ68m
	K0izlAQZu1RQy1Iof1mLJYCFgEZ3cRIrWvV1iSz4Mgw6cLO7U6qhslaknRbmg6ROqJ78PUMiMN4
	kctYHSt6fkLsgCnQ1tBsV/y/
X-Google-Smtp-Source: AGHT+IFPL44fRnKvdkzbEg99H3wtx1tLB39yV6DcSowkzo2hPNVyzepPWPczBCpyeRx5yh9Bg7kSkg==
X-Received: by 2002:a05:6402:3486:b0:5cf:ac34:380a with SMTP id 4fb4d7f45d1cf-5d0207b2755mr4536946a12.29.1732388579686;
        Sat, 23 Nov 2024 11:02:59 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a2d15sm2410028a12.11.2024.11.23.11.02.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 11:02:58 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa545dc7105so4879966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:02:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXp2bqKn4QFB0pbwT11PeqSHQniI7X4QadoKDS9Lcp7Qm5aoddvvrGanaB2MMfwP+u8Cl7uwx/e+TLN5Io=@vger.kernel.org
X-Received: by 2002:a17:906:31d9:b0:aa4:a814:3f6c with SMTP id
 a640c23a62f3a-aa50995de95mr534603566b.8.1732388577220; Sat, 23 Nov 2024
 11:02:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <680c14b5af9d43d6bc70d2c1e9321e01@AcuMS.aculab.com>
In-Reply-To: <680c14b5af9d43d6bc70d2c1e9321e01@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 11:02:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgT4E+6YO0-SvdD=Gh6wSuUB3Bq_qOiErfZkobQ9gn6=Q@mail.gmail.com>
Message-ID: <CAHk-=wgT4E+6YO0-SvdD=Gh6wSuUB3Bq_qOiErfZkobQ9gn6=Q@mail.gmail.com>
Subject: Re: [PATCH] x86: Allow user accesses to the base of the guard page
To: David Laight <David.Laight@aculab.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Mikel Rychliski <mikel@mikelr.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 10:48, David Laight <David.Laight@aculab.com> wrote:
>
> In that case access_ok(ptr, size) will check that 'ptr + size'
> is a valid user address -

The point of USER_PTR_MAX is that the size never matters and we never
check it. So the "-1" is basically just the minimal size.

And the code does actually depend on the fact that the access has to
start *before* the boundary to work.

Now, we do have that whole "at least PAGE_SIZE of guard page", and so
the 1-byte minimal size doesn't actually matter, but I don't see the
point of the change.

In particular, I don't see when it would matter to do access_ok(ptr,
0) in the first place. Who does that, and why would it make any sense?

               Linus

