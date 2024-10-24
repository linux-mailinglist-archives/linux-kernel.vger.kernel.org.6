Return-Path: <linux-kernel+bounces-380173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EAC9AE9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7223B237FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABE21EF09E;
	Thu, 24 Oct 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baZgbNbL"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21BC1EBA0E;
	Thu, 24 Oct 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782345; cv=none; b=Ue0FVr4MhP2IBtAiMqN7Xn+G+HwhUnzDOjg6hVtHDAoKwosu23vvmALgZuaWZCoPuF4aVUn/tVppz7w2eSZ6K5LyMbKZ+NqSSlesh7Hzr2G+pIE0W18nqgBJWK2njsojdZnvGKTy/qvwikMqz918FBcaV/1S2qfZvSCQW2HAFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782345; c=relaxed/simple;
	bh=DRfIphEOgJUshahw1YnLkABqA24RfciQZPbwe8tYfvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njqr2DPIWf2UDcXR6WSEO0g/hI4pi6UPPAY5WooDz2WF1ccv/NwSSCu1J7d9dWzM86U8JRVp/2QBD0NL4yzVWmCI0RhZYPp9vnoaYi8TJX1YOW1WCDSjdRadS/ccMztjtN/C8CaF0a10V1rrdzkEtTbS9ieUIqoTQSj3fYEQbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baZgbNbL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7eaebc773d8so135126a12.3;
        Thu, 24 Oct 2024 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729782343; x=1730387143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWBJiSooBXrWB0PqWLU3AE7jzD52ohebdb5ug3FRi2w=;
        b=baZgbNbLyQClQGhX8qDvKomUTeUtC0tmDAUEhKnYToyGp2NyhB+VOA058D2YPzNuzO
         FhnhEjnUeN4lenhpWdzzq1O3iIdQb5LvIRZUsLDOUaZW4vKmQ7irKM0Hw0YKMd/4ZMeK
         F+aoNYlPEkk7os81eIq5Aq68h46xJFkl5ScM3Zbtlzb8ie7oBYZ6Gfo2blnwQAMg9fIj
         Zwcq+1DOOXu3LW4IWOzM27gKdxTEA9Uhy9BBWnrxCu5JnDvVjYkRFQ6dSuNDtGfIjgP3
         qZWd4QuO7GONnMlErWybxedwuRBno9n4fCdBjvN8oP51Fku1aYAg+w/k42BxOSMvKsNE
         Ky+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782343; x=1730387143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWBJiSooBXrWB0PqWLU3AE7jzD52ohebdb5ug3FRi2w=;
        b=bdI6B0NpcDb/csgcju3YMPgg1VBugd+GP9nrDjDSXBWvTPwumLb59Iq/n19KyFdj4u
         +Icnv3gLQYj5NbXPAQcAMARmcS7WYNUnAhbNP9U4TiwcD5W+UkNQ/U02VDqcSAIBTA8j
         WuKVwRa5U+amHY+ssQziyD9lLOzKD8lt/5W+83/SrtbtBVRut9wQVw6oqWDaNohBW2CF
         bmpv8qHAQBXyGUfRnFFA1e75PIxcvvxNr/tO1Gdq4En1HA75eo92SH+jSGGz7+EzHuhX
         AElM7eGV8VyQmfRejAeUgn7OJsPEgy5UozvsuhHz+TaXM1HSildmwpGszDZyvtBfYo2m
         Y4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKry0rKSLkIR63+Xvc/40/1TdrTvkATFS1H4vBaIvr+EyiSXL4/8IurFeNkCtRvq0IVDLGtQSAwOPycL8=@vger.kernel.org, AJvYcCUTkc5Nnov2XNP2WvNM9qfloOfepQW/z7b8fglCZ5sBS0Wyxxp61hUXfk7HDNdRKTWf6gTT4YRIBxY/5V/OOEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstEB++drYHP2FSZ9KW2Jd6W3svMFnTo6J62iF7Nsii7fhW+wa
	PnS7orfYX3QtlabAL07lBLa5IX76k5CAQR0ukvS3sy48svvQoZR4A51XcQbYKtjhxDIQC9FzckE
	sIDcMfu8/QmD9sAG+5rLzpfXolR4=
X-Google-Smtp-Source: AGHT+IGQvroVX7tmmjtc3sz42EA/iaZPua4To/FGsIpICO8G6/XffrkIgPvXZyuCGi5MEyHksOxKHT1tkg6QdnYtYvA=
X-Received: by 2002:a17:90a:c918:b0:2e2:a667:1a11 with SMTP id
 98e67ed59e1d1-2e76b5b7e42mr3300913a91.1.1729782342905; Thu, 24 Oct 2024
 08:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
In-Reply-To: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 24 Oct 2024 17:05:30 +0200
Message-ID: <CANiq72=tywaM4n-6isLmpu5fC3uj5H7g4QfiaksXcaPH_Pfxaw@mail.gmail.com>
Subject: Re: [PATCH] rust: irq: add support for request_irq()
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

A couple procedural things on your latest patches (no need to send new
versions right away).

On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Both regular and threaded versions are supported.

I am not sure if the commit message was truncated, but it should
explain why the change is done and what is being changed. For
instance, it should mention who will need this upstream. Please see
other similar patches/series we have, e.g. one of the latest ones in Lore:

    https://lore.kernel.org/rust-for-linux/20241022213221.2383-1-dakr@kerne=
l.org/

> base-commit: 33c255312660653cf54f8019896b5dca28e3c580

Please try this one on top of `rust-next` -- you will get new Clippy
warnings about missing safety sections & comments.

Thanks!

Cheers,
Miguel

