Return-Path: <linux-kernel+bounces-448529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C79F4155
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5C0188A2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C12145A0F;
	Tue, 17 Dec 2024 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfvNvpEd"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BE8615A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407635; cv=none; b=i6ZF0fD7TgiXjKDbWAh59LMo8TshYtQZk6V9zu29Pq+MC4kSyI4zvNHigwWS6N0BECe6VGA6fa3iddtUXEP6cDYcfwPAiRc7xWRwdl3EfExQlm7dB5T6YY3K2pmVSAaYEyzQ71EoyOIVFNeS6AVioFhhYwjN9n39ExOajA/G+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407635; c=relaxed/simple;
	bh=JjvSUlb0s668mPGWJCN5daNkwa+E19w4qhP7lmASwqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5K4TXH13iNjI6dSca1hEK/fS7wJpgZFQJfZBS3ruwBDd5UEGXkXKceGQJ6rr8mJYeJmFPL2t1ROJ/G0sKgSrlC9WWYqzjb/tXFEn2/7w1QD7utlAgNHCFs7wuGeY+tgQbGkO4sPDFQDSPtLZT//NWVV65x7o6664gzNtCbtJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfvNvpEd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so5097164e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734407631; x=1735012431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjvSUlb0s668mPGWJCN5daNkwa+E19w4qhP7lmASwqw=;
        b=JfvNvpEdPpWIdJa3d7+8og9fI37U6k2QsgcOXmXKDzaVq2nA+pxPcYqXqpy0gJkel6
         ckvHiF7fP9nuXAigThRQpfLUWRnz89oGF/PBBtbfKmZQ7ZT3UWW+fJDOE12h1kTqGyK3
         M/VLcSu602PDMe8O9ksJpKvpSJwM91kbgPL7m8T6Rh3muyoBxzmxKBGLVeIbEHNwuv4p
         rO6TiLoVElS6l+soOTPlnq281Ky1W0fBMymrnPAMvqfA7tJAQitn9I84Ib9Lk+wvy3uG
         T/dspzVI0zvp3aQhj8Huny5CLL/OEDYTyurZGD2v8VGYLU06cjPrCzaDbIKK/wytI4QN
         QNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734407631; x=1735012431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjvSUlb0s668mPGWJCN5daNkwa+E19w4qhP7lmASwqw=;
        b=XfTxqyYYX79VNDr+NEsX8Xs9gyWwrkiPGIqCGh7Tc41cTSFDr8SW78HiFMxluxNZE9
         6fYv3UcWM6KaJLHxzM3anUtDOMgIUpMf8TGXuBsH+3c70q06wdpRPFDn8AUBaqVAmgO8
         BBTwaSKnNUb1BE+0Nrik4BW5HPN2LyV0DJsbxIQ4vbanmG32juM7ycEmbLldsNhCjJzy
         VVlcibTFlXOJSYKtULgr9n7POuc+se+33bwmQJ0bwNI0u7GzEB/lx/YxwV56TTiDJ6/L
         dweq4i3ltmHUBu7ns8R/k6plJs8dPCspar2Q48xSMuVi2IAzZmukZkyqUObZ23zfVi0W
         5mmw==
X-Forwarded-Encrypted: i=1; AJvYcCXKehwgWRL7BCXmFE+3c+Ed1KYgGFMvvWWQ28nrkbvjmBzzs+4Rl5QusDeWiAccLcSfovbtz/TDGd1hWlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1WK0piXkY7EHYNpO0Rjf19dCk5Ac7Y0GFQwtYu98XGysd9be
	T+erFa+P+RhKQ506NisBKN17LNsVu+i4QCABsMf33txO+vM03Vkum6kkwc7un1ssF4qbNJcWy8N
	hBg3e6Gqptq7HhF3z7BePPwZ1OVXp1+s3b/2u
X-Gm-Gg: ASbGnctvYu3blgoznwAI9aWvYN7VDzLLUwBdhzUD8Nx/d0ilLBsEcv/UJMMrTXi+Vma
	6e5l3F6M3T04zW4sJ5yqnexfNL3Cn667Md5rD3g==
X-Google-Smtp-Source: AGHT+IEaU+0Dd9AvGqqW/gw3nElxtLBX5cPHOWjS/rZC4WRXjtt2rbtyzHwmhZDGDsLUxRYrcn3n+1g/30SrxJzWcCw=
X-Received: by 2002:a05:6512:2255:b0:540:1e17:10d2 with SMTP id
 2adb3069b0e04-54099b696c9mr4317280e87.49.1734407631461; Mon, 16 Dec 2024
 19:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212224114.888373-1-dualli@chromium.org> <20241212224114.888373-3-dualli@chromium.org>
 <Z2BtgqkPUZxE8B83@google.com> <CANBPYPhZ-_5=VMRoBxbfVb+AFb_qu49QH_hKOiSjX93E1GQA8A@mail.gmail.com>
 <20241216174111.3fdce872@kernel.org>
In-Reply-To: <20241216174111.3fdce872@kernel.org>
From: Li Li <dualli@google.com>
Date: Mon, 16 Dec 2024 19:53:40 -0800
Message-ID: <CA+xfxX6-cbTyyyTf1UL_A7DzagfrV+y0367MdO21+JdjW870ZA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] binder: report txn errors via generic netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, corbet@lwn.net, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, donald.hunter@gmail.com, 
	Greg KH <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	tkjos@android.com, maco@android.com, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, brauner@kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	Hridya Valsaraju <hridya@google.com>, Steven Moreland <smoreland@google.com>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024, 5:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wrot=
e:
>
> On Mon, 16 Dec 2024 10:58:10 -0800 Li Li wrote:
> > > not: There are several places where you have "netlink_nl" which seems
> > > kind of redundant to me. wdyt? IMO you should drop the "nl" in all of
> > > these cases.
> > >
> >
> > These are automatically generated from the yaml file. So let's just
> > keep them as is.
> > But it's a good suggestion to the owner of yaml parser.
>
> I think the unusual naming comes from fact that you call your netlink
> family binder_netlink. It's sort of like adding the word sysfs to the
> name of a sysfs file. I mean the user visible name, not code
> references...
>
> s/binder_netlink/binder/ will clean this up..


I did consider that but unfortunately that would result in a
conflicting binder.h in uapi header.

Probably "binder_report" or "bindererr"?

