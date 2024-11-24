Return-Path: <linux-kernel+bounces-420311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25FC9D789E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99018282B82
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16517BED0;
	Sun, 24 Nov 2024 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D8ssIxss"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269D1531C1
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488042; cv=none; b=pKJCOQ8+2lIiriPw3H2KFjLUYOYqxMsFE7Sg0H6r2PwdBoRrjW4kfW9VMhqA0owWTHUdzapE67pErVnA47j8DCF/dh37bfRnNyEeDSkeaemoXl+OgBm3/kQgxUlyRiMT4tBD6spDAZavm4BiF7jSiLULhpGZ+lLSmeZfEUA9eiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488042; c=relaxed/simple;
	bh=GaQdMPFdNe40VY26/MbbYRPP1PnBJVuOeF5ZR1vbOSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJBvmtd12LTErlHjaNiNBEFHUEoa3o0lGSBvPH34jEkODdezaET6NWWxHk+X/EfPcwCaMwTlZWnydCJ2LpYlySW1epSwbLnjDbrGHafbEyIQr46hYBAD6NNOUQAGwrq8M3Omqsl5AZmdKMsUjnCQMGDVuQYDlJfb+DTChmJULDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D8ssIxss; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so181826766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732488039; x=1733092839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KXorZl1i4MgdQSpDUwpcPC/cMs/fMYzfPrdOviHNCjg=;
        b=D8ssIxssRI7h5WQRUnmgz6ZdGc0HPnJlCwdCxcrUOB88ZIa32ea3gsL5A7FEOZ/06K
         O45OOaYB8pvPTXe7QaNWWiGmAZXuFC/dplPZIJ3nff3EhRb08aq6ZyRC1OzhfbQQjDxY
         wtbgTxvN4Hl0t7uCCWyw6rFD8TgfKCwzNeaiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732488039; x=1733092839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXorZl1i4MgdQSpDUwpcPC/cMs/fMYzfPrdOviHNCjg=;
        b=Crel9sYPVrGZuym/Ov4NXdg+ehEyMqAt8r1Tf+viKkJZ6DnIBg9K4UT3vXK4LfDv7O
         KLmIRuXj2d2K00+7oQt28KQnHgNHMtK7H4JKl7WJQDMQQg+vysRp7GVHw068fT7Eb1iD
         fkQe8ZN0hnJ9ye2dQDR0cN1+f/kyBZlWds/KckKTb829CLdVVNKpKl3ypj/HcveBaLBv
         5bC5c1PSuTuUB9zKwm85veWQa+aXq2a3H6BqR5Dap36LFUjnAWBwI5R34XyS8O8TZBmo
         +nJGmfA0lAZS6moy0UFGo0Cr0cQv9d1LY2G5ev6QUR5QyfrjbOg+hjiKbjsJS5h7u/06
         ocdw==
X-Forwarded-Encrypted: i=1; AJvYcCVaZNFSnTSFkN1LO1dlWSacvtbUcTMjdKZPejC+wzkwmibPcksTkOMYbI0/vrg+qGLomeC7Y+cKtGxqMTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDnjO7PVZx1Q7mqnqUulPv7MRFOvwwzbHP1tM6mH5xyBRRawn
	bty+dYTNBXNusjB+1LKRM+CnP9Pcj5un/fQPIGvxyvwlF7M0wSb1qeCSbgsw+iqU2MW8dvegysw
	0cSgiEA==
X-Gm-Gg: ASbGncvLwdYkbhq6pb52RKAEGpIqHf5Ino/nDQGksuEPjZFOHx6fA7r7m0vJI1b+RmN
	V+QhhENrF9VWfa91c2twMDHwEiOMTTx+ZmW47mrYlOCOFT8jPF1FZQPpQoqt5det2ihikTm+MFk
	Oz6AQSvUKMb11VrllBvWKHgQQ7lwNRBbvENMEh19MFL2AEdmQCcA1c1wRaHxvIElP15bxMdwQCV
	AGPbgv5k4UzSTUYAXelH7kEwhj8NbMzXLLIFdaiWT8QXwrF9laDnDHZH0DU+oFo37InrM2C9h+j
	D214fKikANc8tXhVudfISDDf
X-Google-Smtp-Source: AGHT+IGauhkkKdXRMW5aga3Gb+ksgF8pZwmJKiW2g+Lz8fEVRiWT7THkir/dyQ5waIAYZdlK38lpZQ==
X-Received: by 2002:a17:907:7b86:b0:a99:ffa9:a27 with SMTP id a640c23a62f3a-aa4efea7ac6mr1249026966b.26.1732488039206;
        Sun, 24 Nov 2024 14:40:39 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa51b25335fsm348597966b.119.2024.11.24.14.40.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:40:37 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so9283308a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:40:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAMNm/dINwKiztvi2rf+7CPS1XE7bxfQhblCECrWjDZn/igTSgzxWGlXZtNIxpdYp04MxmgQkklOFZ3ng=@vger.kernel.org
X-Received: by 2002:a17:906:2932:b0:aa5:3853:553b with SMTP id
 a640c23a62f3a-aa5385357b4mr429896166b.20.1732488036958; Sun, 24 Nov 2024
 14:40:36 -0800 (PST)
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
 <20241124222450.GB3387508@ZenIV>
In-Reply-To: <20241124222450.GB3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 14:40:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0GvCCyuK7hG9MkXPrDTSPU1qFaQZm5GVL=Tc0BzN49w@mail.gmail.com>
Message-ID: <CAHk-=wh0GvCCyuK7hG9MkXPrDTSPU1qFaQZm5GVL=Tc0BzN49w@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 14:24, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Nov 24, 2024 at 02:10:30PM -0800, Linus Torvalds wrote:
>
> > I *do* think that we could perhaps extend (and rename) the
> > inode->i_size_seqcount to just cover all of the core inode metadata
> > stuff.
>
> That would bring ->i_size_seqcount to 64bit architectures and
> potentially extend the time it's being held quite a bit even
> on 32bit...

Yes. But it seems fairly benign.

*IF* somebody really cares, that is.

         Linus

