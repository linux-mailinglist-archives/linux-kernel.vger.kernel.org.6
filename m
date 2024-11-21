Return-Path: <linux-kernel+bounces-416494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E79D45D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2201F21932
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3970831;
	Thu, 21 Nov 2024 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W98XJXQB"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1A43AA1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157158; cv=none; b=IK/gK07TrUmlAW0orcDDBHsNHrGBOyxMHofC1aaj1gYrvn548u7a/Uv/GTOx7EN1JYDCs9TfDJl15FyNb/BCTdYPzAj5+3NOtbnZI4cg8B9fYEgJ2AetwhMzcz4UflFlndj5tpFbaCFXZcuk2cjAvLo8yMLUaN4lCNEKRQT6yRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157158; c=relaxed/simple;
	bh=TAI9Owk28kv6v5bd0BAEAkNc+VKgpC5JvpKi3v2bQd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVIVTk1vQLwPRQeol7ISDcQXXIENaJu69LY++nh1b0jqPhl94ah1qDO7/a12SO2gltzBZxy0x3uj907nydAopufs94MlCFTCem9LGwA0gZ/9lR5GMZrGnv9pLEQfbVrSLMK4fF61egjq2W47Vv+seKhBzq5jBs0SQYbgw6eo0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W98XJXQB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9ec86a67feso78232966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732157154; x=1732761954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBRgLZfJt3TUy7eInBHoe+dA6rZbgdHVPZ1EAwIgSxA=;
        b=W98XJXQBcSurcDQrG8Volvfz+qVcb/hvtthI8J54Mzo5cMBfAm9VhEJdBbjMVP9Pbh
         8M4oR3hplX9xb7h7GfywTYgxtJHw6Mm+7zW4/I8tBEU5hVbzCeLisKv9POIc2d68dqcu
         1ZzsTlF5Gz975I/+ciNhuW0WiFq5F+WJXwUdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157154; x=1732761954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBRgLZfJt3TUy7eInBHoe+dA6rZbgdHVPZ1EAwIgSxA=;
        b=WwKZCMUOIcs+GU1T48EqldXTGxMA+iABqoVqDXgixyKwFT4C8s7Ddj4tJ4sLtDVQDL
         QvvlVIHBxjrlimzkkMNmKkX3a6yGPu3jIx3yrZ5qTuKIoBuGwP42LiJ7zUjRBv6eMKqv
         G5aK84EEshh4FqH7PvnYusgaGi8Y7CGsuzXQUG4KNefcd5QAgeKASP9U8fY01xhuD6NV
         5RMQKyIbNNihC2pp17wedMZGC/duqossKc1mydmquUlfZLcnQNrsvIeLm0IcgPVJ2qRU
         N6Z/Ty1h9Nq/GWpPMG2DXOzXAhFhXK8TyHSngQhEQ7/9vR1pRsroCglGAxLLNZbfmb+u
         J2ng==
X-Forwarded-Encrypted: i=1; AJvYcCWouisskWw1lH3B2GpuAIDcmztOi0aQT0dbWlXVaYvN8uGGj58ulW+VtUkvqNQ1k0shVYyI5EW4xGAULf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy1IQv0d/+fNUMJRq0Y5TkKGyV9M+kEKLefwF/3CveHSCwkVgR
	0IL3GgQZARieZWq/iHGNMGucEbPEbvfO+lMgi7qCyqVEpEClPQwdUoyNcgWTkUx2CMjrtrsMQrE
	XgyY=
X-Gm-Gg: ASbGncu/LF2BrNX4xygcSDpjayDt9SLDlcZZT9Pf1M46qLh74LSWMhYRvqGw/MhR42q
	ZIXVlnCcqK5JnIZhIfgJbyXkNm9p7PCAConhzInewwJOB93BeIdGSeiohgGybWjckmHAY+T9krJ
	pU1yXquaQYzSuUJnTtzX/ruogFQRTYReqnq6xeeF7VzXVNkF19XKO/e1xOTmiSudlhAnxwNpq2x
	XzEJoCDORXXobRJ1txaBhvYzGAeP9oIBtIAI05Cvoj4fxQRNLUD4J2Kd2uH+GzT4pL9j3uHoMIS
	HA+e6hfMMmDqtBAv1xNYfPOJ
X-Google-Smtp-Source: AGHT+IH0KOjBKKuneorT90Tsy2Uy9hjt4mgjdRVdeE4ELi7JZzlrj6Q0DwTn8fdLIPzO2YzeJQp7vg==
X-Received: by 2002:a17:907:2da7:b0:a9a:bbcc:508c with SMTP id a640c23a62f3a-aa4dd52c70bmr459123966b.2.1732157153985;
        Wed, 20 Nov 2024 18:45:53 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f419d412sm25709666b.84.2024.11.20.18.45.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 18:45:53 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ec86a67feso78230066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:45:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXv1VhjwljhoNPBN1gAnnb14Geg5/DElax84BDJdV8GN/1Y9V3R1RaCrDsw4urXAEmIhv748pZxsoyqHJs=@vger.kernel.org
X-Received: by 2002:a17:907:2da2:b0:a9a:ad8:fc56 with SMTP id
 a640c23a62f3a-aa4dd70b6e7mr441535366b.44.1732157152277; Wed, 20 Nov 2024
 18:45:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org> <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
In-Reply-To: <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 18:45:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgv8mo=qfy6bLSdiWYFR4CPei_V6hC0_o_hDhtZS9SYPQ@mail.gmail.com>
Message-ID: <CAHk-=wgv8mo=qfy6bLSdiWYFR4CPei_V6hC0_o_hDhtZS9SYPQ@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Nir Lichtman <nir@lichtman.org>, syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 18:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > Again binfmt_script still uses it.
>
> Ahh, yeah, we can't just get rid of it.

Actually, that reminds me: we've had issues with this horrible fdpath
hack before due to close-on-exec, and that's why we have
BINPRM_FLAGS_PATH_INACCESSIBLE.

And that's independent of the whole "/proc isn't always mounted", so
that the /dev/fd/%d/.. paths don't work at all.

It would probably have been much nicer if we just put the real path of
the dentry originally in ->fdpath, but I suspect it's too late to fix
now: it would _mostly_ be a more reliable and meaningful path, and it
would fix the close-on-exec situation, but I would not be surprised if
we have some horrible  user that really depends on the 'fd' being the
only way to actually access it (either due to permission issues, or
because of it having been actively unlinked).

              Linus

