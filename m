Return-Path: <linux-kernel+bounces-420328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AE19D78E9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3844E282DB9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D8D185949;
	Sun, 24 Nov 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bmCUk95Y"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BBF16F8F5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488260; cv=none; b=A5buzEaHCxDx0wIf2WJAf2wKC3Daxxu6ZbSrh8Wlu2wUxh3qkUAEiM46PpL7G071UgBtcJKJVbjCRAkf8rMg65cOHXAcIkpyKFnHs02lcL52btR5wKJz9ybO3RGJGkLeWF/eZstyfhbnuw5LDfKGePAcVnrl15jPxRBfWuvSlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488260; c=relaxed/simple;
	bh=3s4l9EUOb159JQOwNguTdmw9Fzaozv+iX1wE3Tf2zE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC7GcqGBxoXQMkHgXla9VpcOeOy0HSXIkbofC80SJZteF/6cExb3codgvkw0Wtv1XQA1Dw9iPwknQisw9x3vHOhXbmSj5njAfwQ63Undd2z/HmrIeL2uA7LdSyZ10LDxVG+BxkkvIsrAUCi2ICOGtMGH/QxRLyA9UdZa0ZHWXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bmCUk95Y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382296631f1so3056394f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732488257; x=1733093057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qB+G6WrdsdoCxIwUW+ykYIm2moN5DapLNSVJz4cIiDg=;
        b=bmCUk95YZyxjBfGzaZTaAVanop0AqMsgzjwQdVYPcalgUtWAgkWexXU9Swt4WSYY+m
         PKYng/kiPowOQOo4O3AD4zRwmxJQW0LqesjxDR9jBu5K3y4Mcf5EkHn67R7Zelr2etXj
         Y+ugmmT5CyxUoRRNe9gq/gZRyuSvJSlxaW1GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732488257; x=1733093057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qB+G6WrdsdoCxIwUW+ykYIm2moN5DapLNSVJz4cIiDg=;
        b=q1Sj0T6T6B5HCXAl7a0J70wsWugUhqkCVNxFzR3DWn9WxfLk/cPFFxxQx8WLtcC9sx
         5/qdHZ8r8hPikzooYjmrCfU0bn+41LzCcIxQOHn9eOL51vZayTzkw6Jh57HFdSX/Cxua
         +bFBxy2Pc66PGzugLBV9UjaXsCt4YMaX2eW2/UhZptOOwQrBa17E1einKa60Mb8zoJ+L
         BCe0GMmGuFR79o5+1xEWm4LuuiWzfGAmmarchOie1ng7bXXO+HDasTyzmkzH391wAdK4
         4DDID1qw8bMDuBSkIaR2ydqBbJt4dIiGWUf/ZROVyHGyWnON+ZX93WgmWQoC9raEdVfH
         ipJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzp0m7RVaRtSjpePgVnh8As68hO02TXE4HYpxxuofIyYtFepUF2XGxtq22zfpokAkiFVFLHFCakAD7UpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTKv69897eeaYwO/s8M8WMeiueAI+8UhdcvS/eY+xFA9aJE70
	/NA4x7l6AvohJfgRSh3LCnW+DVMhKt5lcG6z8ygDuOkGUyzvwZJciQym3hXWKsfBhaIzrMIHml+
	xgaW3Sg==
X-Gm-Gg: ASbGnctOk/u/xUmVSq6oSY9Ec9d2fm5U//MMlsr3K3fie1MQXVe2PStKQXeZe/1Ta3z
	iNIBze84hL0DwFQdWz3p1QmSVg1Lpe/xZseSFnZe+j1g/F7xoHoOGo5sL8Vi/TYMoIIEv0XPuSX
	d33esYpZZH2Ll+RT1LmsTilKyhwrW+KMW0+RvrD0l+ILQvfOjUAb2ztw+jJ7Ro9nZ6Ez8MNmLk7
	gAegivd48u2Cv+dO+ZeGHdzE7B9xunB3j9I8THAum8CvNbcG6TOC4o/7FNBhMXnDJ8M7/WrEc4h
	TOMmEYVmFuwiwabZ4sahb458
X-Google-Smtp-Source: AGHT+IEhhNIp5Q59U+aR3PJgUN2zlC0f+unQlKvq4oW3YsWMLK/hhVVLCKIeaRCiFZAY55w+v+BOcA==
X-Received: by 2002:a5d:64cb:0:b0:382:4ffa:c0a8 with SMTP id ffacd0b85a97d-38260b6149dmr8332052f8f.21.1732488257407;
        Sun, 24 Nov 2024 14:44:17 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d8603dfsm3463306a12.26.2024.11.24.14.44.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:44:15 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa51d32fa69so327879266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:44:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLvrM/NQhKSzN4cePhSFFJN8EogvhnRx1rzrB8jA1TNvvS5aXr2hd5a06ZbPX5vPIk7BsslG19tmBcptw=@vger.kernel.org
X-Received: by 2002:a17:906:d511:b0:a99:e939:d69e with SMTP id
 a640c23a62f3a-aa509d790f8mr782019366b.51.1732488254135; Sun, 24 Nov 2024
 14:44:14 -0800 (PST)
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
In-Reply-To: <Z0OqCmbGz0P7hrrA@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 14:43:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
Message-ID: <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 14:34, Matthew Wilcox <willy@infradead.org> wrote:
>
> Could we just do:
>
> again:
>         nsec = READ_ONCE(inode->nsec)
>         sec = READ_ONCE(inode->sec)
>         if (READ_ONCE(inode->nsec) != nsec)
>                 goto again;

No. You would need to use the right memory ordering barriers.

And make sure the writes are in the right order.

And even then it wouldn't protect against the race in theory, since
two (separate) time writes could make that nsec check work, even when
the 'sec' read wouldn't necessarily match *either* of the matching
nsec cases.

So it might catch some case of value tearing, and make a "this happens
in once in a blue moon" turn into a "this happens once in five blue
moons" situation instead.

But anybody who really cares about this case would presumably still
care about the "once in five blue moons" case too.

             Linus

