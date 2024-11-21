Return-Path: <linux-kernel+bounces-416485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327D29D45BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90BF1F21FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A6427447;
	Thu, 21 Nov 2024 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0YbIPdJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6419A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732156183; cv=none; b=FGHFothG9FmS3mWJCR0+ry3DYtvO1XZsh5tsZ1RJ+ub7eix9MQXpviTI6GCuAQZLYZhWy0Nt9sFZffEIM3+R3Y591qNzX2tdeUcIW+bEuioGiA8hwSYoUhPXsZWSsylul3Mtf4PMCSaJ0R7ubS2JmS1kcmG5vtgJ4vCOwQsvkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732156183; c=relaxed/simple;
	bh=0ytbXT8imuofcKIPoWDodsOwesbWgAvq0MlCY+uF9SA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PghjBUP65mbHZuj4xPTDR5yWYW/I56QtJ3VFiPU7I+93AjJlEzav0vAPp94oOZ0p94Toz/Cz4getcj4oaLlPxBacFHMutl6HVdJcoj9kxe+0ddVmr21tWYL7/QnBRYx/J4aHUi78wqrl29XA9bQdCLwhmES326titu1C5rLlhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0YbIPdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1872EC4CECD;
	Thu, 21 Nov 2024 02:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732156183;
	bh=0ytbXT8imuofcKIPoWDodsOwesbWgAvq0MlCY+uF9SA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=A0YbIPdJ/6uI9xVOQyjYYiRY2Cs93NsqSMzw6nX4lyPHHgw8Pnluaave4GaabtQSa
	 JwqJ/hcGg7OVMIUxjMbNGQp6prGW70mPuBglAU+4lQzfilldtKJeT7YodsEyssnB9T
	 yC9GrrFhr3Nab3adEid6J4nCf7hY5nzzMQfEjs+vX7A4q5c10GnvAlCI+ybEPX6EE1
	 XtFvNY1dIgdGxfAl16yBJMwGJCUAt8cpK+O/2SREvjwS5VV6IrH13qkbJiYG8+3SWH
	 3YDAq0VI/uxkEbaK2wKTKZ/PGTwmYsa0AGRKM8FeMeC6B511EPR4Ek5tiLYDpse/qr
	 Bp6TwNYoURaug==
Date: Wed, 20 Nov 2024 18:29:44 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dan Carpenter <dan.carpenter@linaro.org>, Nir Lichtman <nir@lichtman.org>,
 syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com,
 Tycho Andersen <tandersen@netflix.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com> <87jzcxv227.fsf@email.froward.int.ebiederm.org> <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
Message-ID: <BD9581DF-19D1-4A22-BE03-65E383C8A3D3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 20, 2024 6:23:55 PM PST, Linus Torvalds <torvalds@linux-founda=
tion=2Eorg> wrote:
>But we're *not* adding a new complete garbage "copy random stuff badly
>from user space" thing=2E

I'll drop this and resend the PR=2E

I think using the dentry should work, as you say=2E Though with a more par=
anoid hat on, I wonder if it could be an info leak if the original filename=
 isn't "visible" in the context it's running in; containers do weird stuff=
=2E (But I'm hard-pressed to imagine how the filename would actually be a u=
seful "secret"=2E)

-Kees

--=20
Kees Cook

