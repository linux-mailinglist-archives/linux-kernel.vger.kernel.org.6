Return-Path: <linux-kernel+bounces-417515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FAA9D5502
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171401F2331D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3C71BD9FC;
	Thu, 21 Nov 2024 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aZjmgd4L"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FF146A6B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225762; cv=none; b=JaVG4xGJGYXXBBi1av0RUc0wj78urLfA8ESYWGZPVRGb8gmG6FkHWyvMGCk3ApcnrRodbXmFCUYYdl48p4RI4byetJgU1omvyKpae+enLpB6Z2Pdi4Y4Pa33jOpsEtKpOpb2mTiVkDZzaSIgTr1YS2uqxbdbqDiSFoHWP1wa56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225762; c=relaxed/simple;
	bh=ini3uXddICpzT9Be4YUOD/geEYhh6WICb04ARNkwDOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGa43UhyZ+MIqGRMNPAkisnGCbt2t7r78usl0jkM+10XX6vGAFeKVO8jxPtoFngobBSEmHSmdopwnuKrFc+uvUvZCPTmHZTpSxqWvrYOHBxez54mW3Zfdyf0gNJpc/tBCq1RoMQJ20TcJGWU1UBGAgMybIEzLLMLJyT2thXi85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aZjmgd4L; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso4410333a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732225758; x=1732830558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TfVVm57+39vyQiBr1wjImanE6DYIN3guLCtS4ZUhdY=;
        b=aZjmgd4LEYhG4tajd4lnI1G5QK8zXKHO9tuqBOKlU6Av/U4rjvJVBbF5pwtLPWvI9/
         wpRehQ1jZxhMiU1+T0X0T1VqvAI9/6aGN9Hnbm4/xssGsW70FIX2cPI81p0/SFmM7oZQ
         j/CorqTd/nGe6+UhSnqed7P7umJBgLGPsSLP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225758; x=1732830558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TfVVm57+39vyQiBr1wjImanE6DYIN3guLCtS4ZUhdY=;
        b=KuOy0Kn0a40S17RDBk5+5/LCVkGizx121PgzdBsw53YmBFxGVJzlDygKFLuXTzyUiB
         3sm7tiH1ef6h4TLDgx3pur0kStI8ukjXpGsNZXy6jYg8Kc4PtsMVXA3S1IYRXOOU+sY5
         GAy2yp2/ZIVA1276XwabD2Yq5wCK0u5doLb5MOA5Chj1vbfDQ3JDq4H51fshWkSVM9Qj
         Fr9L+quQCmOnPZcP/oX1Ko1QS9ZIY77bZ85VSfb+Vnuj88LtFuMVMHXmuRiqZqI0u2WN
         plOT4gFAWSzvJznHwedh0sqMwFHK2FAxc5w2McEf2c1kfEpE6q1S40l4oeckaMRLEVJ2
         2VuA==
X-Forwarded-Encrypted: i=1; AJvYcCW/bW+JqCWcynOi54aQE0h7o4Vp9t3Cg0GyIyJ61ncdKVDUdCAo9bY4STWbCmXxZpLJw1tW1QR7xbXscpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx20384GD0GoSIrcnPj3qwD0huWxReHeSIFHS1Z5qErS+hrXPgH
	ShG/G6hc6kIAaOh7Twkckjt8zGmtQAvRxSJ8jmrisErdGm+g8ELQCaCso0+KpSNA2VaNnkogaBI
	xE3s=
X-Gm-Gg: ASbGncvaNCkaZljKbyf5lsYbZbiW8DRWnepAEnkGs42DQh3gkSVybKRJmYLChHOo4qU
	J10Z2YAnjuhdXJ89ayqVIyJ+/XE2r/WXjlVfLwaQGla/KbKA0Li9W8iS79M8wzBV2RCgbsWkiGA
	Ekjx/xuj48QFUqChlN5L0x/lknlZkSon7UdBI1+L248+Fm1PWlfIZr6MvnFfgn8XaHlDiVrUiFa
	S6muf4lzRWt3qmJcry/pzAAIxndspQB5D7cqXq6y5rFcCnveg4oTDhL7F6NHtIkkieljHz30g2U
	FeJoO2Gb9qx8uyr4IyMX/iQg
X-Google-Smtp-Source: AGHT+IFz1vh2AHqWxcxWKZZZXg3jU6kAA2tAPKVR8EuoFZXPNs6n1b+YrzJFDLL3WC1g/yfhjZCvsw==
X-Received: by 2002:a17:907:1c9d:b0:a9e:e1a5:755f with SMTP id a640c23a62f3a-aa4ef9433f3mr457016766b.1.1732225758261;
        Thu, 21 Nov 2024 13:49:18 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28ddeesm17734266b.27.2024.11.21.13.49.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:49:16 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so4830017a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:49:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlaRN3soI5UTnymHGGDU8awmd4xtqHop47p+M9OzpQnpCe01TLmB2WHvCSTDZRaZMu6yt5YFEodrLOTcY=@vger.kernel.org
X-Received: by 2002:a17:907:3fa7:b0:a9a:cea7:1294 with SMTP id
 a640c23a62f3a-aa4efe2a359mr473179366b.21.1732225756061; Thu, 21 Nov 2024
 13:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org> <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl> <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
 <Zz91LyHzxxOLEma_@kawka3.in.waw.pl> <CAHk-=whv4q-RBXmc9G7NZ4GiATqE_ORU05f=9g00HkQXbV7vqw@mail.gmail.com>
 <202411211011.C2E3ABEAB@keescook> <CAHk-=wgfX4dvvKo8PrPZj76Z2ULMMK2RvaF+O7QhLnwOSBYdhQ@mail.gmail.com>
 <Zz-mmg9tEj7EbPlm@kawka3.in.waw.pl>
In-Reply-To: <Zz-mmg9tEj7EbPlm@kawka3.in.waw.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2024 13:48:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whF03ueoCM7M0vbcTy7fRvv+g9h_rnafurNJ1OEj71cEA@mail.gmail.com>
Message-ID: <CAHk-=whF03ueoCM7M0vbcTy7fRvv+g9h_rnafurNJ1OEj71cEA@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Cc: Kees Cook <kees@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Nir Lichtman <nir@lichtman.org>, syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Nov 2024 at 13:31, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
>
> The point is that comm _is_ used in many places that matter. I'm not
> sure what you're trying to say really, since in the second half of
> your mail you actually showed an example where this is true.

Really, let me say this one more time: if you don't like the dentry
name, don't give execveat() a bare file descriptor that has no other
name, and claim that you want to use some completely unrelated third
thing that has nothing to do with it except in your little
dream-world.

The dentry name is not just fine, it's THE TRUTH. It's fundamentally
what you are executing.

It's better than - and fundamentally different from - argv[0], which
is something entirely different and is defined to be available
elsewhere.

If you have done an open() that followed a symlink, the name *behind*
the symlink is the *CORRECT* name. So when you then do an execveat(),
it's literally the thing *behind* the symlink that you are executing.

You are trying to claim that people want argv[0]. No they don't. If
they wanted argv[0], they'd use /proc/*/cmdline, which already give
you that, and more.

And if they don't want argv[0], then they get the name that the
executable was started with. Which is the name *behind* the symlink
that was resolved by the (preceding) 'open()'.

I'm trying to explain to you that comm[] IS NOT, AND HAS NEVER BEEN,
argv[0]. The two have *never* matched up and been the same thing. It's
simply not how execve() works.

I understand that you seem to *think* that it is how execve() works or
should work, but that's your hangup, and has no actual basis in
reality.

I'm telling you that comm[] is not argv[0], and has never been argv[0]. Eve=
r.

I will not take that idiotic patch that tries to change decades of
history, based on what is purely your personal misunderstanding of
what argv[0] is, and does something *stupid* and slow, when something
much more true is right there in the dentry name.

I don't even understand why you care about the symlink thing. You did
an open, you followed the symlink, the file no longer points to the
symlink, trying to claim that it does is simply not *true* in any
shape or form.

Here's a hint for you: do the same open, but never execute it. Then
look in /proc/*/fd and see what that says. Horror of horrors, it
doesn't show the symlink. It shows what it pointed to.

And before you start arguing about that too, let me just say that
we're not changing that *either*.

           Linus

