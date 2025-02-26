Return-Path: <linux-kernel+bounces-534269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA61CA464FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55131422D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B670921CA0F;
	Wed, 26 Feb 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxRRi/9C"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8E1BE871;
	Wed, 26 Feb 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583815; cv=none; b=Vl/KfZs8bf9bAi1ZJ5D9OYe8zzV5bue0ugwMOhMNkR45dzgsJOYsHzTYBtvghxVqQUuQn7DGzRPll1peCI0kF27wpGE1IjsQLeHFBLGaZwMy7Sn3Q1It0DhB2gz8wX6ZOBKdrwsNnUNAYqGQKr6ydr5NYuUBuonrM3gjMTQffkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583815; c=relaxed/simple;
	bh=n/FqSTcE/8HvPW4IJOfw5V2A6b81ymsqyNJD/R1vubg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDHEtu5aBi8B5ftaqY9ZxWAgsbGVpwjYuedl+KuM3c5byr8eFH408ssvV3jSHwET8CrGKnL8s/LM0cXoSM7wXTD5t1Iq76sKEZFg3kJ8Iwb0mavWqd+npMgOGZVVIjxTeUdPObL7e/mq7JafHeEmpRnu4H79EpiBacPogfR9lRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxRRi/9C; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54843052bcdso4103046e87.1;
        Wed, 26 Feb 2025 07:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740583811; x=1741188611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/FqSTcE/8HvPW4IJOfw5V2A6b81ymsqyNJD/R1vubg=;
        b=YxRRi/9C3V4ugijl+v4z5SlN8SNezRsTgUWF/BEOwBzYgYJyEUmePOtVmC5/6SJgHk
         /9lI9TtN1xFlB5tlfH7VVLqE8QBjXwW1qNIJvq2Ea/ufVxpszKXwGjXxaPA6jwV+aAfL
         OTmdPFjasftdOgMNkJkoFC+NysT+EgFAxPCrYqere2kR6ihErv+EaN4QGpmdiVW23JsI
         SPDqDEq1BHe6tUcnkF2N/Hocsm7pTcvyNOg2kv9nK76tXiBXM03nuvMiGR2FS+krvAi6
         ZysyMrrnVOuP/UErPZvietytPg3a6JHAEQ9aUpHeHNL4diUrO/riVNM3HSgZ2alIAFZu
         7ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583811; x=1741188611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/FqSTcE/8HvPW4IJOfw5V2A6b81ymsqyNJD/R1vubg=;
        b=IajYv4VvISX3aVQDypw/zh70FRvSwThz4WghBelZ2PHp6NgHV/VVJVw2zYumXbBSgk
         K5Pj2SWSkRq1k70OqjIeWGA9RmYJZoMAMlJKL8kdZH1yecOFd+nCEMnf+ZhtF0QCsxGg
         i+jE6qEWlyQHIdQ8HRqJ7s/hF5wIUYsvhYeYdV4NXtDTIQQO5qGQ4RUETM1xxQajUKAX
         EF32MQbTnczPjx5A2jnzHwM2iWYXnmHb500ynIKRdC2IhSYwkqOteuzc8Bdbr20vaolr
         EhjqUIlEr8+4b0hxmsyScXhsfjCipidK2zfqhx/u51sw6h8h5gSrmjTdzpoSBuRlhPyj
         JRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUStApi3eASvQzSXrepFMjRPSC6hb5avvRgyKZpnC8v4qc3mJgYl4FD6D6ZPdu2SieGNHnPpxVJ3QQF/P+aVpc=@vger.kernel.org, AJvYcCWY9RW8MlI1qxgmkT2pYI+Rix42zpzQZaeG0BUegTzqglp151OpdYXvDRsQwyCpdSPnkraiPFjMMSQ0ahg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6Q1K7s1P/Mk6GMLfs9tW1Odf2yTwLPKnT0Yi+AhudzZjzi2f
	sPwoQrWu1RyyLOTBB9D5iXdZjt/Dic8RhX3yWwxCNczFBdGmslt6fQllET+Jp3GbEwQh7oolMX6
	ld2ZZVz1OPajA5m0cmj0CQQFq73Q=
X-Gm-Gg: ASbGncsaLh4aKLiedeY/69CJa/xwxuYzWd4cr+P1lDbsA3YUSJACjmYIplHh5jiupCA
	JpKPoEKjD7ia0zG6yGgf2Hn6rckqZKTHA3FZe+7LrmdarK7ZS/HLtjHOIYAgTtncWKvYislHWUk
	QvxV1xh0o9nYYYTODBCgYLXr4=
X-Google-Smtp-Source: AGHT+IHmc+PzqwS+outfLQ38vbk5z3siIKpnZ8sUuq6O7LHX3HsuaWl4k4ydDi97DhI63UhGjGHkp8zw0AHEQ4KgAQA=
X-Received: by 2002:a05:6512:104b:b0:545:4cb:b25d with SMTP id
 2adb3069b0e04-548510d655cmr4959681e87.13.1740583811307; Wed, 26 Feb 2025
 07:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
 <q5sIYQbnCqKmdnZZy-eaKvSUY7O5pOy2-QzwWwCo9VoormFcKS6RS3OVIIby-Pf5PDpTRh67txem3sXQKSB1JQ==@protonmail.internalid>
 <CAJ-ks9nj8+fXM_oo0LJo4O6Q=skFRcHwz8TLxw-yB3QTcDF9GA@mail.gmail.com>
 <87cyf6xv7g.fsf@kernel.org> <Wy3wqzRK5qG3GyHC7oEg3NR3tv9-Uv7m_tmgKZTHNEU6aZX5hxrIXLudLfzQvuZNvIz1Av2fKzH5eTvomny1Vg==@protonmail.internalid>
 <CAJ-ks9=PR-Laj37NqG5s_TbKddONWxp4-Cf3C57AMk9z92mfDQ@mail.gmail.com>
 <87r03lvnx4.fsf@kernel.org> <RWZWPbf2ND3HRx_kFFVnjBngQMWjrmbidBCzyJr58iQsksyu5SpJVfCiEjf7WYWFOz6eWib5Q9j23QmbSqXyEQ==@protonmail.internalid>
 <CAJ-ks9mCvGJoeLhkGHLU-7Q-=g_4XHfX4DBX9w=ZcP4jpWXsPQ@mail.gmail.com> <87eczludtp.fsf@kernel.org>
In-Reply-To: <87eczludtp.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 26 Feb 2025 10:29:34 -0500
X-Gm-Features: AQ5f1JqpgZfyQpaHs48JSbPZFSEJ_TSBvHp-keREq2dCSgkPXbVYaJknxAC55Cw
Message-ID: <CAJ-ks9mozekrYvwFTJ4qKj3cpDa37+gUKefiZ1OscU9mP3NjuQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:48=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > Sorry, I meant HasHrTimer and HrTimerPointer rather than HrTimer and
> > HrTimerPointer.
>
> `HasHrTimer` is named so because it is meant to be implemented by types
> that contain a field of type `HrTimer`.
>
> `HrTimerPointer` is meant to be implemented by pointer types that point
> to types that implement `HasHrTimer`.
>
> They are different, and the naming reflect that.
>
> I will not rename `HasHrTimer` to `ContainsHrTimer`, because the rest of
> the rust kernel uses the `HasFoo` naming scheme.

The Has prefix makes sense in HasHrTimer. Shouldn't the name
HrTimerPointer also contain "Has"? HasHrTimerPointer would be
confusing, but perhaps PointerToHasHrTimer? It's a mouthful to be
sure.

