Return-Path: <linux-kernel+bounces-350054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F198FF2A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B1C1C230C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4231448E4;
	Fri,  4 Oct 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sreq1pAj"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644513A257;
	Fri,  4 Oct 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032427; cv=none; b=GhUl2HFlnYcGMtRwa3DHzsNmagay9YTL2FZRVnE9N6MGs0sW4u+hUHrc26MR05RanXaRfmQ9Aw8wZ+wWe4wh4R+EivHoD9UHvmAzfwLIflSmG0Q80r52v2ai7i8solazjBIDZZVl5qZN4jtZ9z255VORGOPIgMWBi7vF1CokZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032427; c=relaxed/simple;
	bh=JWnxnBH/67sa2Eg50rmaQzoPoiXAmEKx92AhoGtH22k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sp9SIAbPSJtUY63TOmsOfHxEg0meKGo14EPNyG92M58VChqG6N3e/YuCI08WcTW11P6scRW420urvVtj2WArA49fGbqVLv094NVOI36QEx1hO0SpCLrRyI8+wnvHAtYvz/27zBloWZeBXJ+TPsTA0wQiwqLTJDsC7T+Orv7ppEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sreq1pAj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45830ff5b70so13877541cf.1;
        Fri, 04 Oct 2024 02:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728032425; x=1728637225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LSyBZcIG/Hlxsb/fNzByjsUQNuBYrRBNRwYFBJoo564=;
        b=Sreq1pAjekHC+v8ESlwOD9eVH+Y539/Aoy/NjMzSMxFmhtU7YDRumQE5EBKQbbNQaW
         JT+BNMqUJj3u3LdFpIGGNJR65UWXDc6LMkXxP3IW24A8YmMT9Q6ihaWFsKq1/OyyWCca
         g2pETo8FE1+pT3Zlfiih4eKt3MWq7CbyFmy73pONpXmO54Ox0yhhDvOF2WFYY+7xZWok
         QW54qF7Rvo0xw5eMwuQ1ioAi56KWrSD4OL1RqwxvRpql2zTt/dUGk5PW8PQSpGH88sPP
         b5PRuVqkB9D5Q0K6tVlm7v3g6QBMv/hN9WcwaAph7mmCNcWuPezfON6040FtXz0yWa04
         FfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032425; x=1728637225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSyBZcIG/Hlxsb/fNzByjsUQNuBYrRBNRwYFBJoo564=;
        b=Ker2nenPnmSsH7BWWmWRgi0P1I7OGP1VdUP3ufO0JbLqjmlKOjPtWM5LivTNZeKZ7x
         3dll/V9X9Gy354uojzp9smBw5/bvrABG4ZtaPK61p6v8fyOZH4SLZqCWkRUF/7X7xZSW
         GKcxsqz34m2fx2d/m/o92OP/T0Birskx2PO0m9yMmKkS4jN0zqyRXQXn24jAJDEkUcXU
         UbSKgYjFDn3Irou4Xzo2Rb8/oD2lOphvi8Gbgn4CjCWJy1/o9gPE48AYNoW3wfFjoRst
         GLW5iLD/DguFs21e/HQ+bm2IYX8GOQijFFsrEyYSruPkgq2S9qCrRrCuYrMtTIopznau
         7utA==
X-Forwarded-Encrypted: i=1; AJvYcCWEkuZyb3MoBYKwbiSC0JHPRAVHOfgvkA5n1B8w4biphL3j9x+bGUp2jv2e0VG+EaUCJrfHxJ8tIs/hYJF7eyk=@vger.kernel.org, AJvYcCXTj5cYsyxs+RV8Vy09GAzvYjnaJLVLzTZz2iD5VRkm5zLQ6GRluq+B9avvZNc3q72+EcGGNMU/h5qOwMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWcgVZ4IUerBpgbH5Txex0K1IlETSjCORrvxXuB6p+8J7pvMu
	qQd7BTBqiZTksP6UtfHuApWU03c3M77JTjJYyZIEUdLzgbQT+zfB93EZYSHjwdVgdrByD9Gkxcj
	rx2SxISd8yWWFBId4DtvqzYe+EMk=
X-Google-Smtp-Source: AGHT+IGKWnSncZ5atA0WaZ9lOASPli3mVJPnhC+gZ5xn8qYkbquhc6dtbrDki6tiu8n8zqmmCDu65I6T8+PiHbqIPi0=
X-Received: by 2002:a05:622a:4a06:b0:458:4ded:fe99 with SMTP id
 d75a77b69052e-45d9bae9820mr32463711cf.42.1728032425091; Fri, 04 Oct 2024
 02:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003221536.34826-1-iapain@gmail.com> <CANiq72k0c+QxWkxfZ5f2VvzYmaX4z9hQoYvbPtKfF3pwLq-E8Q@mail.gmail.com>
In-Reply-To: <CANiq72k0c+QxWkxfZ5f2VvzYmaX4z9hQoYvbPtKfF3pwLq-E8Q@mail.gmail.com>
From: Deepak <iapain@gmail.com>
Date: Fri, 4 Oct 2024 11:00:13 +0200
Message-ID: <CACD3TDPbBnZuvr0jJVtrgs_4AXXk1+HGZEH_uPp2iQVf+4Ff6A@mail.gmail.com>
Subject: Re: [PATCH] rust: update dbg macro outputs in docs
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Nell Shamrell-Harrington <nells@linux.microsoft.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the quick review. I will rework on this patch.

>   - It should explain what the change is and why it is done --
> currently it just says "outdated examples", without mentioning why
> they are updated or what the change is.

Sorry for not being outward with my commit message and thanks for
mentioning this. I will rework on that.

>   - Please read the notes in the GitHub issue to know what tags you
> should add above the Signed-off-by one.

I have clearly missed that. I will include this in next patch version

>   - Commit messages should not start with "Hi," (you can, however, add
> that kind of text/message below the `---` line and it will not go into
> the commit) and they should generally be written using the imperative
> mood.

Noted

>   - Did you copy the output from the standard library? Did you
> double-check if our output looks like that (in terms of the column
> number)? Mentioning this in the commit message is a good idea.

Output wasn't copied from std lib, instead it was adjusted to reflect examples.

>   - The GitHub issue mentioned the column numbers, so this is good;
> however, did you compare this file with the standard library one to
> check if other changes/improvements could be imported?

I did compare `std_vendor.rs` with std lib and I didn't observe any
change in the code. As mentioned in the GH issue, only inconsistency
which I did notice as well was the missing column number in outputs.

Cheers,
Deepak

