Return-Path: <linux-kernel+bounces-316547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9EB96D113
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAA0B2453D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B1194A5B;
	Thu,  5 Sep 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fPi6X8yh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF91946BB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523143; cv=none; b=sQVmV51LSYXDMpHOTHoWJWe7fmzxas9qwQ/TxI8SdGpbC5yWnQZC2jUhJ7V3fycDCq0aFCAzPLbohVIW0puVquwssXmOgRQoYwhMu733LQcEpGedwbobvhqwDaOdJlspLlC0ateFUsKd7DS90rugFQH1uWnx7La1L3x4Mrh1pJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523143; c=relaxed/simple;
	bh=S4wg+N7dLtvOvfF5uGJECcWCNVHiuhHmcyXrxkMmoWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kejMU9KIUaaSiPtyxjJrJmHYfqxgtepnNrWsxaqo06pnS8NF2oT2IMQ8oqZi+3liIF8T213fsdg83LjvcDmEsAW3l2gNRVlOCWVuu1fNNO7+i0861zsValRO4SdR78JMMd6J8HaqPFQTFAxjlW61rwLcB/jK1f17BijKHfLhAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fPi6X8yh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42c94e59b93so8711035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523140; x=1726127940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4wg+N7dLtvOvfF5uGJECcWCNVHiuhHmcyXrxkMmoWQ=;
        b=fPi6X8yhNM31cx1NhF72LaKjsQf01NO4tQKcKkqS/maxUUyM89B/WxEyR1iBedGsA/
         F+SrEzB0XxlWI4MWQokFZkPUFliWuVLy81EZq47zf0fBkuz4VpJeu7p4XUfO9RftKtV7
         qII1uMBN808exzxDT5AYosBRAPtcLr/3YiwqmIzepqZAFz2JRgYIJzfJqm5NpexS/i/u
         VJwsllNV4X4IfBDdQNy2awh+GlDrZ0ww9s7JmiHfv9fOmUfI9SkTeF38cKywUxGLPwHr
         6WzykGaWo/HBtyl7O6pWjlVzDqq5Ygds9wNgeCwL6b9FfYnf8r0w4puuSNohTXPF+hZ0
         7xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523140; x=1726127940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4wg+N7dLtvOvfF5uGJECcWCNVHiuhHmcyXrxkMmoWQ=;
        b=uZmrdZHN3TIqelfpGi66n+kHMzdTGqtor7MKtjFsRuzC+5fZMovgw2D+9AmFHOlQBm
         9BuPkw06e+G9ONBWbPqNu9mdomwXwbJKMIvXdwZgTCJ6ViYVbMscD8CQqFvjBJHe3kbH
         MdBrbeBzadFgfjlxJiG7DB+Bc6pC5zNhOUeEl722byDFqsyzNnrh5sGTpraTXqr5DTKR
         ZtV5yKMfx3mUjo17j7N4h5rqf5WvD1qXjRLY86HIjgLKZDskjhtpAWW1Bgja1wP9x5vU
         GCu6aNYowFnVWcS5/Anjp9YTGjcOfUkdJOV4hfu5hOyOOg4nmMXIb2V3pdBNQBdwC12K
         K6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp3FeBDZOUA165u981wb2kKV8jUO1QoOZhA7s8gynacZP8fQl+A55fqQkZeTy1Oeqisv0+MW/w2SVO/Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9UmLl0JooJ139PIAiTfWUgPtECDP2Tk9db1hCNdEd9ljIYIQ
	cfNnoh/l6XjyKWBYtwiENHhOP3CMPWjCumATYBXy5+NqqDHdojqH2yFs9pjULi0tlp8Bz+aYS68
	72d+EvF010BY2bn0szE3DeRkdvYb6Ja7cIA5w
X-Google-Smtp-Source: AGHT+IGtCPMuGPM1tEnxEq9yaB7NNJmDwi3mMPagHojR/JnOLPZuTRsGFLFDq1TA5h0cNWIxOaDOSqYB5CqWwC4WUqE=
X-Received: by 2002:a5d:4a90:0:b0:376:e2f4:5414 with SMTP id
 ffacd0b85a97d-377998aaf1bmr3162540f8f.5.1725523139945; Thu, 05 Sep 2024
 00:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-4-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-4-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 09:58:48 +0200
Message-ID: <CAH5fLghNLZWjaABcztD8utC9VbPMUYGNYKjisPdV=vVYVF+H+w@mail.gmail.com>
Subject: Re: [PATCH 03/19] rust: types: avoid repetition in `{As,From}Bytes` impls
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In order to provide `// SAFETY` comments for every `unsafe impl`, we woul=
d
> need to repeat them, which is not very useful and would be harder to read=
.
>
> We could perhaps allow the lint (ideally within a small module), but we
> can take the chance to avoid the repetition of the `impl`s themselves
> too by using a small local macro, like in other places where we have
> had to do this sort of thing.
>
> Thus add the straightforward `impl_{from,as}bytes!` macros and use them
> to implement `FromBytes`.
>
> This, in turn, will allow us in the next patch to place a `// SAFETY`
> comment that defers to the actual invocation of the macro.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

