Return-Path: <linux-kernel+bounces-527179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147A2A40828
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A563A561A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D83420AF64;
	Sat, 22 Feb 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX4ewBRp"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FA20ADCA;
	Sat, 22 Feb 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225439; cv=none; b=mnaiGESx3DcaGXDkH9B34deaIDVozTHXMYtWTiPyinbjD0g6lipxDUuiNp/TWKe9UmHINhesPOKWPR2Qz4yZFbFXEqx2+R940RCf+cAzUMH9QcW/EblTN9OtQY0A7ujU7lGSufjU5rxPJBiPBjpPuzxAAKELofqT2f92Wit2UEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225439; c=relaxed/simple;
	bh=k8Kw9fTb38/cukuIx7cYkzV4WopEC22ARdKY9BegNI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8YubVyQvM+wg12oMSwf2+DpjDB2HFEd8BYbmBQIab6UuA6lJj5TX7YE0f+s4u+hEiM8ZjkS5NXEpxzYw8urLDmIM5PV65QFt8DrVOgtaDeHtEzBTydHr4UlbkoZJXoyYnHmDh0/udCnQN8pCo7BwsFzEFzW78MCamC9DTvy7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX4ewBRp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so771384a91.1;
        Sat, 22 Feb 2025 03:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740225436; x=1740830236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp1yvo8hDO1YnlX+IIsswIMzYCeujUd6RQ8/J0Ivxts=;
        b=TX4ewBRp/wR5LzoXHUyYzYM5atcecY6kcz5rELDbHgi1pdg1K1AO076K0ndMu+JQTR
         VPtkO8vZ/ZxKXepJ0szfmKtBxlr7/DyNdzanXgRnMCL404V+VYShzOiTWZpjMwDegT5R
         S1XKJl6iJfuig8DV9InAIiKINHDPXbScRTMh6t6m46no7NafNDZqt1b9x1d3nJb/Oe3K
         Zur5Ml3FaaLsfS16F9RHxv/kRBi8ITfkKFelp8Q26AkwQOl1hkmMbfqP7r4flMvCJFd7
         NErmFV47DbgcJIybBnzTLpG/730d3eOjZLZEbBvFVc/o00ftffF08PmcrNh//VbjFjyP
         Tdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740225436; x=1740830236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp1yvo8hDO1YnlX+IIsswIMzYCeujUd6RQ8/J0Ivxts=;
        b=fTE2Sd14EfJa+eD90cWvrqETXegL/Tetum0XQp7gt5Fw9CtUClymB7wyMSD/UwI9CH
         mOW2dv+uGqG1jE3hvKmBxIkXbY9l4kQYSriVgTl8kuqlinJa5P7d9D2XDDXMs1dZBiyr
         tY4SYbP/NT73u4hlEBbRO5+lpl4bRJqr+COE9cWSdfkpTCSwUgfyPs65/2Y9ZwI+9+ma
         FgO/csqpfZItvSZf4gdZ0eFHlWHe+ApgiiZykwER78LvNvj70NJHyosAFBcfrjp/khgz
         bSUwMAKmD16CVz3tb8/7bFDAguWD98KpvxU4zJNRkh3kzSocEUPUblmkYbaXhD4kZhe+
         8KKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG6vSe+pQZZ84reMciKOwxSw0QzCEJrEIgqFUVJB8u0OwBgK0dPSp9Kyd6/edIdxIFAq0fZ3t1JZt8ZZY=@vger.kernel.org, AJvYcCUKohV7/d3vLSM8APZq84LMLwXpBUCsHJ4qXjLBapKHeAcaNhAXlg8Ndfqd+RKrcVPVpE3jOi+MiIdtRIstmu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8WP2GMpkmELbo/R2bHR2JvBH5oDaJ+ToxO+EJs3XxZ6XG+4D
	9Id5Sjp2w3m4ctN6NhOTgxR4UsSG0PQoeUUSXvE63vx00FygAbpGWOCU4KARG2Dg9lijjPhWJI1
	PH5vEA2T5Ssn4SNJNHRmGbzaRl+A=
X-Gm-Gg: ASbGncuYmUepsOIe7TeErFAQRphCACRMu3UQ3ZJyY1GEjfC7LeHC/3ydvHByqNmyTzr
	Ye+5U8C3dE3LduJuf2w36FK6rVQCn88OmBetPpdocJ1YlxbqXr5ktGpgE6Pn9Iq041UshRZGedm
	XOVJ0KpKg=
X-Google-Smtp-Source: AGHT+IGlsAmiE5dIklp9IecF13A7s+9czUmkwmlicXFmUm7rw2CkW65QSoq5b6aL/ccxWeLHRyQ+vb+zms4U77CMli4=
X-Received: by 2002:a17:90b:3805:b0:2fc:1845:9f68 with SMTP id
 98e67ed59e1d1-2fce7b3a743mr4089938a91.6.1740225435641; Sat, 22 Feb 2025
 03:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
 <CANiq72nsDgRJeKk=B7C9Zo7HL12az+ZLR27qxckqi5H=cmuV5w@mail.gmail.com>
 <Z7lP5VA374-TuNZz@kernel.org> <Z7lUcq3PycSSHiXx@kernel.org>
 <Z7lVeWFX-8uQJaJC@Mac.home> <f9b783dff11a923b53cb654a843af7ae33478f30.camel@kernel.org>
In-Reply-To: <f9b783dff11a923b53cb654a843af7ae33478f30.camel@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 12:57:03 +0100
X-Gm-Features: AWEUYZkUcuMZf7KnPNFWHj4D_W43YcdhaDo8JEBlm5DW4fsNxgoyXm6mCP3q6nA
Message-ID: <CANiq72=c9EZOuwjBz7FjvAe0Hw4Wbyg0w6Za8rZV1kf3uWCtNQ@mail.gmail.com>
Subject: Re: [PATCH] rust: workqueue: define built-in bh queues
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Wedson Almeida Filho <walmeida@microsoft.com>, 
	Nell Shamrell-Harrington <nells@linux.microsoft.com>, Dirk Behme <dirk.behme@gmail.com>, 
	Konstantin Andrikopoulos <kernel@mandragore.io>, Danilo Krummrich <dakr@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 7:04=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> Ah sorry! I have dyslexia (for real) and I did read that the patch
> was queued :-) Thanks for correcting and please do also the next
> time!
>
> I spent also last 48h awake setting up my personal Rust development
> and QA environment... [1]

Dyslexia and lack of sleep do not excuse yourself claiming anything
about "quality standards" of others and asking them to "really pay
more attention" as you did in the other message.

Even if you thought the patch was queued, you could have easily
checked whether it was merged or not before sending these messages.

Moreover, even if it was queued, the commit message could have been
fixed by the maintainer.

Finally, even if a maintainer applied it without fixing the message,
your message is uncalled for, both in tone and the in the fact that it
could have been a particular instance.

> I've been silently following this list for some time and this is a
> common problem that the commit messages are quite bad. Thus, I even
> wrote a public post about the topic now that I had this in mind:
>
> https://social.kernel.org/notice/ArMk27Ism4Citb90K0

This is, again, uncalled for.

We get a lot of new kernel contributors in the Rust for Linux mailing
list -- it is to be expected that their first few patches are not
great.

We do not control who posts to the mailing list, nor should we, and I
hope you are not trying to imply that the actual commit messages in
the branch are bad.

We have commit messages that are _pages_ long sometimes. We try to
follow the rules for every tag every single time. Same for tags sent
to mainline. So what are you talking about?

You suggest "Education" -- we have spent a *ton* of time teaching
newcomers how to contribute, how to write commit messages, how tags
work, etc. Not just in the mailing list, but in our Zulip and in
private too. Others can attest to this.

Moreover, I do take issue with your social media post. You claim:

    "Rust kernel patches should really level up on commit messages and
not merging random code with zero callers."

We do _not_ merge random code. In fact, my message above was Cc'ing
workqueue precisely because we do not just randomly merge code.

Not just that -- if you had actually checked the Git log, you would
have seen that Tejun himself merged the bulk of the content in that
file. So it seems now you have just blamed two different subsystems
entirely.

Regarding "zero callers": that is the usual rule, yes, but it can
happen when there are expected users in the future, and in the end it
is up to the judgement of the maintainers. For instance, in this file,
there are other queues that do not have users yet.

As for the rest of your social media post, I will ignore it before I rant m=
ore.

Thank you.

Cheers,
Miguel

