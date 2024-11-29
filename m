Return-Path: <linux-kernel+bounces-425400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B59DC192
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94915281D07
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0D17ADF7;
	Fri, 29 Nov 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1c+/4LkU"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF638DD1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873005; cv=none; b=A6HLyu33bPEKPoi/FPz1chMwaIQsRnct1Pg3BAdtNfgFIwP4Bnl90io9G8xxQISn9LLhXAJlCPwCGZmVsJy22IT9+oEUz4pnmF4sxLkQf4zQYkEf3psHYbS1bGsu+0k+pNu8S+ljEW74uQ/YfxRc+dSfxmGw3gI4+Ge06eAPgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873005; c=relaxed/simple;
	bh=8t3kY5SgJeeomjAp9Nma5rNKtl6laUxXmUpc12ZBpxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsULz3eaj89HOAZ+cin7J+C+F71mlt1cbu4ry3QpiZTelt8BnN8IgW7cbPh+QBxNMvPf2SVxcCnAxspbaw9MMeOkWinhVf+KpwginzEVJ+Uuqe3mwiPX2ymkEBZLIhMW+AZgCl92XoUApy4TF1hzsgq4G64EW5jNYC5CoTPjXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1c+/4LkU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43497839b80so10124245e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732873002; x=1733477802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrJ1xpSSydL2yypnHXM9b9Zh7gz+ChkHhnTA/5HLSXw=;
        b=1c+/4LkU8zn+XV227w/l3A+BPdqO5bHlb8fa6BPhb5pUnoEt4p45UvDX4SI+MarkRD
         UVww4bXzZ+8kH1CPrIDbq2SBlD7mXNsHLocHZ8wLGs9eTOKupxEkuwSuaW7OWmWr/cZr
         CzSMRi0d8aUJ6o6pHg8IobxLYdLoKqHvfsnu+1XkqR17v7DczZkPITDXRAvWf9X0dqT2
         lYOEnfzsR3vp486blgjXhsTXl6FxUnDNov9QujyoIGHI7wqXS74FuHSRrz5/fy1E23DR
         CLYO2GvKVkSjHkUhfdkAmJWy/Fk6DY7IZycdj+Ev34oQlK3GPcSozBHVrTRMnf8SUt/H
         K96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732873002; x=1733477802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrJ1xpSSydL2yypnHXM9b9Zh7gz+ChkHhnTA/5HLSXw=;
        b=loQuuQhuE+XJ+WNC5poKxMnHqpoxKsr6Dq7ULZKA/ikbO457gBO9HZksEJ1AIRat2+
         K8+tM4xkV06uXnJNvPdexiJA2yjEq73Y91ezE+FhNunc1w0C60mCQ/CuSHBC6Rw0NiG9
         Em7KlfvbSE4zxU3an47RWhoeyiDhr9KMAx1fovvpKFmm+j7dt7joADHrzpWkJRV9Ci59
         j5ijyIlwJ8+qdSX1YF0s28zwNuFILmsCyPJz0XXL4S/nUH6nUgL9sDqx1ThnhK09SVIm
         Gl4n6d6M/TgBSe+MKEOnC5Kc/LRB31lhs0ebCFmEOyrbMnnf1yNBNk242eY2QQpdtd7v
         Uy8A==
X-Forwarded-Encrypted: i=1; AJvYcCWDz4dKvaAm2faJWk7Fp7/bl5vEh6kyovHUNI00zUG23c+C23793Bl/MU7RR62QRWSsWNrTB2g9QlTplVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyqJ1UzjWG4pK31rv6SRpQkuVXUWmisANj5tsBLLNcsnitFtX
	4ib1l8Of9T8uH9bm+obwR5EEi9ddqTcI+Os9zMYDo9GfmH4jdakuQ4q6TM6u7fWmZfmOPL6iUBB
	AuSbDgeiRE8eCYk9kgjzI4igdNGozx92Zn9rL
X-Gm-Gg: ASbGnctFEo3KryToKfyLzLII3G6sOAVoBQfZ92qBrwUrbeerr+yUYn7heNmut+ska4J
	iqrdBihU5aqTR3XsAsmc4XP0i9jmU9w5C3WvK5xeZfgXRl/LZb5vuEIVw0R3wrQ==
X-Google-Smtp-Source: AGHT+IFk8hpcLI10hK6W3ufJFeLf//pA41J0HZM/7GIaERJK+g9o591EijQd1TALxvLz/eJp//taxS6xk26drXmQRF8=
X-Received: by 2002:a05:6000:4012:b0:385:e0d6:fb48 with SMTP id
 ffacd0b85a97d-385e0d6fc5amr230415f8f.7.1732873002128; Fri, 29 Nov 2024
 01:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127131941.3444fbd9@gandalf.local.home> <CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 29 Nov 2024 10:36:30 +0100
Message-ID: <CAH5fLgg53QovLfA-C+j+E0FeQ8-gQgG76ZbeCN4-qEJ5KPOQEg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: More updates for 6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 8:55=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 27 Nov 2024 at 10:18, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > [
> >   NOTE: The rust tracepoint code added hooks to the same macros that we=
re
> >   modified in this pull request. The merge has non-trivial conflicts. I
> >   fixed it up in my "for-next" branch in the same repository. That bran=
ch
> >   was a merge of this branch into the commit where you pulled the rust
> >   tracepoint code.
>
> I checked my resolution against yours, and I don't think your
> resolution is right.
>
> You didn't check 'cond' on regular rust tracepoints, and you didn't do
> any locking on either kind.
>
> I've pushed out my resolution, and hopefully rust people can actually
> test it. I might just be full of it.
>
> That said, I also think that the "__rust_do_trace_##name" inline
> helper should just be renamed to "__trace_##name", and then the
> regular trace_##name() helper could use that inside the
> static_branch_unlikely() check. Because that seems to be the only real
> thing the "rust" version wants - avoiding the static branch
> infrastructure in favor of whatever rust infrastructure.

The Rust parts look reasonable to me, thanks!

Alice

