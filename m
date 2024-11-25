Return-Path: <linux-kernel+bounces-420365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599C99D798E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96B2B21F69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45A44A31;
	Mon, 25 Nov 2024 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YGCFWpE4"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E804A1A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496042; cv=none; b=YQDC0iTFDpaAIopPiqR8tcf+o5w6aYUueRF7sUa+IMkDdaP8lfVOpnLi5ng+4C01H6za9e+RgV6bKyd4tVhJg8MWVgPp+hZSrDn4s+H0SEzwOylErk2N9bEuCqZNCjjJ1RnlTKTNVL7T1O5uCd1tXcyWH7uI4l+82UVfXZxshlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496042; c=relaxed/simple;
	bh=hV6b252LM7V4424h3/YzSAq24BYPWuAcF95EXgeanbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKqFHpopMo+l40jxknKthDIbWAI+Ii6KHr8axkasVw22Av7kCQmfHCB8RtADFWJop0dNP0tbIrbX6maLydpRcQC99EMefdc1dObj6b5vkdK3hZCyTd4Cpof6lozxwRlLEhco5AFma02XWxcOAMogp41y+j2Wutb12O5Sj1Q5qGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YGCFWpE4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ed49edd41so643060366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732496037; x=1733100837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OaDErhfkpfqjfvyPli0HLvhV5o1yp7FB0uhP3zkxd5U=;
        b=YGCFWpE40tawgrFDvW65zeXqxHf2aGNazgUtgmTYgLaCYhXQJKJXj1mFIo5fX/hxP4
         pQ9WslFb2lpwoQataElc+sAX6LXXI1sYQxC4mYlIVmMUJM8aVBgNgAw0yq7HJF2QReNA
         aCPvfqorUkcB6//Cp5keQ72Y1Cpo7Yi0EbxhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496037; x=1733100837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaDErhfkpfqjfvyPli0HLvhV5o1yp7FB0uhP3zkxd5U=;
        b=FLUCqYTBf5OtGue5dkYDKD4442mvaHLBw9X82D1+MzdtppDO5f2YMSLO3J71/xacQJ
         kP/RPraCwjsVj+LthajJzrvmFc48yVtSHFbCipQLI7YpqS2hjF0BdBjJrqAMfwsCP6tG
         uzeGl3TJfS1hps8qZnAH4CA/fx6+M83iMwr54fNEcD760NX7rcFetcw/MZfDTR4o6Mxf
         GWGnjgPlKTV13hlcpaM0pK7QHXjlaPxfU4KEs6ZltEjP5zFGGGDZKXKzIKbWFQfAXXI3
         f5tWdUlwPcNqYLa/23tHR3kP+lcZ5xQ0yTUSo/basPaemeMCWzSLUQ1PKoibeTyihDAP
         pybw==
X-Forwarded-Encrypted: i=1; AJvYcCUQcSNBrHDLi2HQE2FFHOXndNbrPiYIbSOO953TbGJAp2Jgv8NWOMcgljvugGqlijDbe8/lBZN/rIY56iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkAjk4Pdmu7WoYJFK776XgA9sH4XSukaKtyp++AO5o7erdF/f
	T6LWMYM98g3EvDTBFeT7v3GGqXEU4ewgf659JHg42G3eONQlYbC4+8o9VwDkoeiTM6F4OC3VwDr
	h/vI6Fg==
X-Gm-Gg: ASbGncs6M0DpLI9GyKGVZJPPe6L2vHhiAwXPIN4OwfO10ahpT4pNDj2cNd8Ody8s0N2
	QiIIGbAkyse83Eo9btQzxKNYUmt+sQE4+4zzFeUsA8C3w6KGiXSkYcxPQmFjjHkNqHukife5BAr
	wPkz3Z3fqHp1YOym7+xXoCTWf0qwm9J7eMOi6xUzWuo4F0vgMpZpTXK2zwM+gitkDwKCJNLr21e
	RKYnIYJH1RTZeBVyhrq6l/ZseQlBdmo0VaDk4eL2CmcW8GCwruiL+bJdB3Laat1nN3wIyZZ0JyG
	4R2z6Gf6MUYLwL1vXIqM/SO1
X-Google-Smtp-Source: AGHT+IEY4gyQ06+tlAveXJIT+ISquEC4CV1rr5OejO3bFx+OO4tDdtCwR9Lo0qFU63xOmORN3OlGHA==
X-Received: by 2002:a17:907:8706:b0:a99:529d:81ae with SMTP id a640c23a62f3a-aa509d7960dmr806516366b.55.1732496037472;
        Sun, 24 Nov 2024 16:53:57 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b3000e6sm399820066b.80.2024.11.24.16.53.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 16:53:56 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed49edd41so643059466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:53:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4ZMt8iTKtymEBr/7yoxgrjQgOwY0P/ihMEub2kJ3H99UioIjFm24wx+ViOOjl9squxt6wiOSx/v575+k=@vger.kernel.org
X-Received: by 2002:a17:906:1daa:b0:aa5:3853:5531 with SMTP id
 a640c23a62f3a-aa53853579amr504011466b.33.1732496035955; Sun, 24 Nov 2024
 16:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn> <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV> <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV> <Z0OqCmbGz0P7hrrA@casper.infradead.org>
 <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com> <Z0O8ZYHI_1KAXSBF@casper.infradead.org>
In-Reply-To: <Z0O8ZYHI_1KAXSBF@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 16:53:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
Message-ID: <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 15:53, Matthew Wilcox <willy@infradead.org> wrote:
>
> a file time which is newer than the actual time of the file.  I tried
> to construct an example, and I couldn't.  eg:
>
> A:      WRITE_ONCE(inode->sec, 5)
> A:      WRITE_ONCE(inode->nsec, 950)
> A:      WRITE_ONCE(inode->sec, 6)
> B:      READ_ONCE(inode->nsec)
> B:      READ_ONCE(inode->sec)
> A:      WRITE_ONCE(inode->sec, 170)
> A:      WRITE_ONCE(inode->sec, 7)
> A:      WRITE_ONCE(inode->sec, 950)
> B:      READ_ONCE(inode->nsec)

I assume those WRITE_ONCE(170/190) should be nsec.

Also note that as long as you insist on using READ_ONCE, your example
is completely bogus due to memory ordering issues. It happens to work
on x86 where all reads are ordered, but on other architectures you'd
literally re-order the reads in question completely.

So assuming we make the read_once be "smp_read_acquire()" to make them
ordered wrt each other, and make the writes ordered with smp_wmb() or
smp_store_release(), I think it still can fail.

Look, let's write 5.000950, 6.000150 and 7.000950, while there is a
single reader (and let's assume these are all properly ordered reads
and writes):

  W1.s 5
  W1.ns 950
  W2.s 6
  R.ns (950)
  R.s (6)
  W2.ns 150
  W3.s 7
  W3.ns 950
  R.ns (950)

and look how the reader is happy, because it got the same nanoseconds
twice. But the reader thinks it had a time of 6.000950, and AT NO
POINT was that actually a valid time.

                    Linus

