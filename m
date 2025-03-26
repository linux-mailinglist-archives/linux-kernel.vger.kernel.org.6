Return-Path: <linux-kernel+bounces-577608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E053FA71F57
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2661C7A484C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A8217F36;
	Wed, 26 Mar 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RcLxu09W"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA9255E55
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018041; cv=none; b=WG7cpvfi7Qf8YFFHka/hkMq1/0md2ER4R6Fs5U4DDD8jDc1j9DxeG2m8AP9D4xp7m7OsOQinn7vshyFJ5u15Apcvv94zGCWvClQe7O4i3zhkYfW1cvqphpE8aJ2bkNX/rluXG6tbzD2mFdKHs47Zk/FuEFSMrNdi1Ugwz5vn9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018041; c=relaxed/simple;
	bh=6JmmSbRQ8MpL+89HMfAzj2vUP7QBs0D+i13dt/VsGmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFosiIxoeqfShy+mhshLgAvgC7wozsriv8q0ixs0x0WIs9hgMgEeUFhxpwdM/IVuu+jeELahwN57grYrvJExL0XLpzU+yu82QYxiyEaQpjnl4ModKQp1bGV+Oe9CrIIwESkKu54xMPiIVxnjW4MRnvLuRcROhMOwSeCvvR/rjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RcLxu09W; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so30222066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743018037; x=1743622837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTnx5GpAo0KL0E3TtxHMmgaX5DlYUN52FQs+TSmcpSY=;
        b=RcLxu09WxsKH8GB5HRO67X5F/6OuKRnuZvhKok9QsexNcUFSW6Rmn2t0Ty5nXszw/5
         RAm/SEdA5qvPiudPe7nP4KqSFoWyk+LHpME68see2CnpqSE/dsI6F0WNMzy1gRfey9M6
         /OBCvpoK8BHxmGJhuQy3pm4tVLLY9QE1YQKkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743018037; x=1743622837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTnx5GpAo0KL0E3TtxHMmgaX5DlYUN52FQs+TSmcpSY=;
        b=knbn+tdH7WxfcoTGWDe3//ba+5pnmLcPlFzFObSeW0o0fLGehDtWULbyYUcLiWG3EI
         Qshn+nm54gRBz8HqfvoZKIMBFqUWaEep6GEb+XOWPl7RbUOqxJo2PUP70FZNMuuM6cwT
         GKAtc5VCCjPqRURu7IywO0OCShPqf4X4jdZdqLK2gCjVIJ+m3/EXHuMeUSHuZD5Apc2C
         RYJzz1QnPrEJWdqyWfYx+obIZ40ZXjfmh7Ar13Jy1VfXicqZxdj/gN0H4cKFiQcI81Rz
         HA7KdEJVUvWLGVgFGrVpSwaISKpXMKIkmCtqica53jjRIQYu3n1jeqp92h+6zaCQZLg1
         4mqg==
X-Forwarded-Encrypted: i=1; AJvYcCXo+lyCtjsK7xE2uvLzod/4A91wXP9tRDlCiN/zSj0rQ/oxM2j2hIPxGu+e1qjEorDboMKRAX673uRJg74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrmdeeiWQ2xfJMijjgF+3MCio1DX3j+yuWxhVfV+/RcBH5qsK
	2nDkuEltLNUB+p9EtP+5dgS2YyZG3OR6WW8OHE+3gileOIrNPv92sDmLG9RqwpTI7u8EFOA29d1
	it3Szlg==
X-Gm-Gg: ASbGncs1zIBxqAQcPGfeOqr2O5ilyXsIR+Ec5WSW3lPEGrBUXRa0XIUbniJLtjH5t3+
	memb5V6X9nG8XLbms4l4q+a9cIU5yYO+aQ9aJKKMaq27HZp0+5Re5oDPsBsBHSpgCiu6/ORh1Yg
	6tucJkfAmEHuvtfzmLSNLoNZc9nXnNuO2O3p87QkfkEpZfRShmQ1O8kjEOLYU6zyDBMS26wvdM7
	9jRB8bbpNfX0dTAX0YczD5/CrK0r+2htB6mZLdOSuBEtZM8YicaeBoEXlslSgN0DvOMA8Rs8jEd
	knIOl3plwnqz+K5Gw2OinB653gRUDL32Abt0d42JjMiOM9ohcDxcJ5gwqdhLQpylcUmjw3Q5BGE
	OHhpNUY/DRuzH9yRn89g=
X-Google-Smtp-Source: AGHT+IEtF4Qn8myywzSvJCAUD+nDB8IFSueIEfVGPJypeuOWuDLrtvAR5uywJbw/70nyrVNHzMNN9Q==
X-Received: by 2002:a17:907:7241:b0:ac4:4b5:2433 with SMTP id a640c23a62f3a-ac6fb0fd675mr72630866b.41.1743018037214;
        Wed, 26 Mar 2025 12:40:37 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e531fsm1073121066b.65.2025.03.26.12.40.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 12:40:36 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso368715a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:40:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqkEGkKOk/+m6/Ghj4Dpcjf4jF8b3+5hkLPwnB8GGnGGb+uA7mBmlL25iCLPvFOwd579MQ5Nt7xlbcbJY=@vger.kernel.org
X-Received: by 2002:a17:906:d553:b0:abf:641a:5727 with SMTP id
 a640c23a62f3a-ac6fae44e6fmr66686466b.7.1743018036263; Wed, 26 Mar 2025
 12:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com> <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 12:40:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
X-Gm-Features: AQ5f1JoV2NGzR0LooAp6oXwmVVp2SH1Bo3tIPZjlGoykS6sG1BTk0PCL13rM5D8
Message-ID: <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 11:36, Paul Moore <paul@paul-moore.com> wrote:
>
> From my perspective this is largely a continuation of our discussion
> last April, and considering that you ignored my response then, I'm not
> sure typing out a meaningful reply here is a good use of my time.

What you are saying is that I have complained about added overhead
before, and you aren't even willing to explain why new code was added?

> Anyone who is interested can find that thread on lore, unfortunately
> much of my response still applies.

That thread was similar in that yes, it was complaining about extra
overhead of the lsm code. Not just me, btw.

But your respose doesn't make sense. I asked for *why* this was added.
You're saying "I am not going to answer because you've complained
about other overhead before".

I actually went and tried to find the discussion on the mailing lists,
and nowhere *there* did I find an explanation for why this was done
either.

In other words: why were new policy entries added? The commit message
and the list explains what the commit *does*, but doesn't explain
*why* it does it.

I'm cc'ing the other people involved, exactly *because* we've had the
whole discussion before, and because I want to see explanations for
*why* new policy hooks are added to the security layers.

I really think that "policy hooks just because policy hooks" is not
acceptable. And the reason it's not acceptable is exactly the fact
that we have a bad history of various random policies becoming
problematic over time.

There needs to be a *reason* for a policy hook stated. Not "there are
no matching policy hooks".

And I do not see why firmware loading should be a policy issue if the
kernel code that initiated the firmware load (ie the module load that
*was* checked for policy) was already done.

Do I believe this particular case is going to be a performance issue? No.

Do I strongly feel that any additional hooks need *EXPLANATIONS*? Hell yes.

                 Linus

