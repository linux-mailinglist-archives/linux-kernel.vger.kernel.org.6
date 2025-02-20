Return-Path: <linux-kernel+bounces-524914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0BA3E8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5907A7A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F3267AF0;
	Thu, 20 Feb 2025 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxBspcVw"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E026463B;
	Thu, 20 Feb 2025 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094872; cv=none; b=p2i99PR9zlFMzkFmIQ9rzlfU/v583CfHBpLi9aLtH9LXu2coVh2QlrgXp3wS11yfxelapBzcnt/+MNtQdLbIC2wqd8PLQvB+NCzvXR3gpvLuoJxKO9oKGc3Q6v0RAcgn2km7Q4dv6KMyp0PT78+Kexvdyq6c+ygLhgN1iM/iO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094872; c=relaxed/simple;
	bh=irbzh/oe51A79xVYF3jxZzKe+dVGiUXNJMFjUvq6beY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZF8QlyZfkzMOwdR5p26lotGLBxkFG9fl/BlYfaWUhfLhosbhEioASwcQ6cpLxpnPCAFDsYOUCujKeamjT6F/fMoZpGlRxPCRtFIMwZgWEjHofuY6eT7gAiAjz9E0CcIt00raAufFrcgnxaNY8FX1ihW4At22pzspu3lR6dwMUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxBspcVw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so368180a91.0;
        Thu, 20 Feb 2025 15:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740094870; x=1740699670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irbzh/oe51A79xVYF3jxZzKe+dVGiUXNJMFjUvq6beY=;
        b=UxBspcVw702KjLZ2SYc+H3HdVoZNipdIGC84Qviuy/FU1w5m2WLBdWIjIn2yFDLcOi
         b5mOziwdkjqKBQsbSi/D+2mzpmalslm08ScWATcC84Iyo5FgVdr4RjVNeHZjN9+xJwlT
         xcAykwv24GlhyvyH8tERbOGpvQN3jQNlQjT2YzSMMMXcrL9J/ZEoPiXtcp/FiEjD85iR
         KWzwNVuA8+mFE5riTHvYCYvot3TFJucBm+0Qc9yPoB0MDyXJghemk3XmOlkMAbbqM1VI
         yxivh5vjsfvO8z8YUq+aZxOXFGyDgdvn7p/SQCGC2N+7Rn5+vSldQnx5cMCNzOF2lxC4
         GXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740094870; x=1740699670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irbzh/oe51A79xVYF3jxZzKe+dVGiUXNJMFjUvq6beY=;
        b=VXv7KyP64qsNxi75aErd0a6UQGTM4FktBfcJRZaXiw6ca3Jjovg8i2PX4dq7e+ND9K
         acIdao/FCQJRhynB6s8l1oQXWT6rEtbDmULIdJg4qj37Ha0Zga61WksaUQJ5PCBLg7DI
         vFd926y3F8u7MXSqQnPImxWsAQKp5xzdXgIzpxk6y/I/ZXPkaDS7+ysxFOHGT2JuFgFo
         IkIa4delWVSCUC6falP48SrHTAKGd37rR/Bro3BeOCA7DR/LMcjNCxkU/yXoUPRVWCYB
         uAaDyNnj5odj34FDzcBPk3tMb6+ia1SJNpsTPQRhUhLSz5w/ae7sqtzctmdBIdWYwAkx
         GITQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCuLIf6M+xxjwyOqXYdFDvjoAelGFIVI1yvCXWYYYd+Wk1vLRem3MNDdW/BgbGnjY9gGcpw5knvy4mdBc=@vger.kernel.org, AJvYcCXuxh3/Q00vSmgu7FMx8XCxpffxhZQ55zpeVfoZ1KmJUEOQ9HufnKmFh08AkDoXZEy0mQJl6MaqTn9mXzhNnrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJP5r0fBisYWtGHXeZOZEnoKevnXgrHULFOcEPH6Q15A5DX0U
	T7NWNiUhdfHQnVDFrcAXhagrX8WBDw9CrifDNvNEDeW+Axx8ALvG7fLsFMa7+rF6d6j1Ip3nky/
	EDxS6A9KSfnX7O/0r46LEULATVIc=
X-Gm-Gg: ASbGnctuzOW6gFxvSmazkbsPgjRFc6Mg1/zv+C8VaLH1Xwh48Hgjyq5ZLiI32qjkxYy
	bDa0tvFCYplP/wmQL1R5kBNu+Davhua1a4tXCN86LjvzfeI6N6RpNBNELssprAbbTAciKa523
X-Google-Smtp-Source: AGHT+IE3tTMC50ciOK+8N/4de26wZ6Pg8vooUK40uWXc0KvimGcWwvs1xaU2vMuCSIhfeBeWHEofydflMa9Ma5wDnkg=
X-Received: by 2002:a17:90b:1e05:b0:2fa:17d2:158 with SMTP id
 98e67ed59e1d1-2fce75dfdb1mr694090a91.0.1740094870138; Thu, 20 Feb 2025
 15:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7SwcnUzjZYfuJ4-@infradead.org> <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
 <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com>
 <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
 <CANiq72m5KB-X1zck1E43yffXOTeD4xRmZgDx_oUiNwR941ce0w@mail.gmail.com> <20250219170623.GB1789203@mit.edu>
In-Reply-To: <20250219170623.GB1789203@mit.edu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Feb 2025 00:40:57 +0100
X-Gm-Features: AWEUYZmuZcjvGrCyDvmTbEKuMO6tYd_p5yChnLfIZmwrF8AsdfajLNX5ZuOK-5U
Message-ID: <CANiq72=O+sz0mU-urYmviCm55GL0jWzsbjAJviJpT+3MLmQSCA@mail.gmail.com>
Subject: Re: Rust kernel policy
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 6:06=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> I do understand (now) what Wedson was trying to do, was to show off
> how expressive and powerful Rust can be, even in the face of a fairly
> complex interface.

Thanks for saying that.

> It turns out there were some good reasons for why
> the VFS handles inode creation, but in general, I'd encourage us to
> consider whether there are ways to change the abstractions on the C
> side so that:

Definitely -- improving the C side (not just for Rust callers, but
also for C ones) would be great, whether that is with extra
annotations/extensions or redesigns.

In the beginning (pre-merge), we tried hard not to require changes on
the C side, because we wanted to show that it is possible to use Rust
(i.e. create safe abstractions for C APIs) even with minimal or no
changes to C headers. We thought it was a useful property.

But then we got C maintainers that welcomed improvements that would
benefit both sides, which was nice to see, and opens up some doors --
as a simple example, Greg added made some APIs `const`-correct so that
we got the right pointer type on the Rust bindings.

So, yeah, anything in that direction (that either improves the C side
and/or simplifies the Rust bindings/abstractions) would be great.

Cheers,
Miguel

