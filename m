Return-Path: <linux-kernel+bounces-542596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 395D5A4CB6F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAE3188930D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65522E405;
	Mon,  3 Mar 2025 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M1LVSZkD"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFE1E285A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028167; cv=none; b=gFD3259/t/v2bbofzMGgE8FZ3bh7suyF4Um2iCG6I2e0rRabFHi66MkwonaNJEk1njlhpGJoP2AZdWRXZL3SInrQNiH+5M45XAu0YCDWYn7ECNgYl/ArXAm7skJDLiYrKSwQT5tLiTmNYCCjjwxPSkwe6KgbnUUo8Tw4rxjeNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028167; c=relaxed/simple;
	bh=40lZ1B3I0WpagjJJY3c7pknBCiXUw+PnTGKE9/WolFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gjmuy6qyqcQy/2YESOPWCT6I34+JHEFBYd3sg+9fAlrQNDF4J1KV0XReYR6seiE/qv0XwzVLw1fhXsZmKro7yY5XvT+FQuUihKbsZjMsQ/8QwE95v4VF9ZwNEWijZ0K2FkXYy+rq12DTsY0uUahHpnrzvLn73blmLi7tdb7//+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M1LVSZkD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4f5cc3172so5241835a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741028162; x=1741632962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSfhJwWsj+zXdSemjGaY4k9oeyz7B20wLL/Ct0QzSTI=;
        b=M1LVSZkDldcz9I4LJA5X3gQprKLSrcONjSFUo36f3NJbn33ZccfEagbWcekmF3keEq
         OzAprCqaQGLCQSISRvXNEmvydUq1eolauvf+EBwpiwtIv3V2tiQF5CP8VRxO+K6caEIq
         bmAmgtHlFzvxH9rzPpwzaWbK3gsCPtLM7Z68c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028162; x=1741632962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSfhJwWsj+zXdSemjGaY4k9oeyz7B20wLL/Ct0QzSTI=;
        b=JolUWcFI+csa1tAGRp7LEOdZHQtGqOBd16yBq7ygiaZkwSg7ne7kPr8/SplYQoNoj7
         bvcXizXlx07kqKkcZ+WTV0/O5pczKgyC1IBhDzfW/zKLm2gUb1Jt0Hdp8PUWE8Tat6Nz
         5vJRmcW+lPfQtMxNj+5Ng52PghyrpwXi8LprntX1H2ZPmljhUiIN12tyZnZ+f1j0eRwl
         JLAJ/igP5JHpq6aZNc426mw5X/Kf6v7RlVBpKZWAS9sG7/xiYS/gMeXKJWf6GqofwLSj
         hVPR15mmJKhO39nt98Pz7/M6Q/O7emyvet7otvSTa5eKYnQstW7aHaeAA/ysEnO0eCte
         zZXg==
X-Forwarded-Encrypted: i=1; AJvYcCWXApsxll9lpOfRFqIHnvDum83FYls0ZQq70KvUJyZH+oOl4ppey05Bew8NWbvu/UR4VgIxaQ90jCs2PRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2dMa1JIJIdZS15d6iCVWouJkWCytz3D4z9TFCkhuT3jX5RnW
	4B4IbFXcmOTPx4RkJlr6ZZjwjq9EGDuNvFIURmnK1tabZ6SxGGucUFbGj5HqyWr8X5O53kAvi2Q
	A658=
X-Gm-Gg: ASbGncs2LkfU0aDMJSRaJVo0kcPiJxx15RKZ6hiIkPBWtWbIKrFcTGaCt8l+NsTB5gS
	pAPiApta1/sx8TuN6lEWagTRn4C1EmYjj3xV/EiogAxingZY5vfHHsuCOJ1fJar1fgGwAwdmmXt
	n+Mv0Uw3Kwc47K13o1PTFvepIXhN/sU5rsWv9xovolkR60cq4tH/9Aa64g6Q2Y2QPpBZ2PpxQgn
	M/8rRm5wq6BQL+gI34D4w2zSSyghpbtgRR3FgIQFW8ZOn1SHUZh5X0pqOUrqsujRixVTrlUb8qF
	5pe+qTBVZZ2VYE1qL7RJQHRi89Irmk6CMg2VYO7a9IY3qsx4FDnCqSz2p+y3YLVCMejt6blB3fC
	fxLhbiyvYVkhf7fxzrWk=
X-Google-Smtp-Source: AGHT+IEoifFjmxIXFF4XcdjA+yh5jZl3O06uH1519swKAX/3MYCx6Oz4B3iVpzBBy37As86cx9TNYA==
X-Received: by 2002:a17:907:7213:b0:abf:75b8:cb38 with SMTP id a640c23a62f3a-abf75b8cc51mr641407066b.36.1741028161800;
        Mon, 03 Mar 2025 10:56:01 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf78023d7esm238287466b.34.2025.03.03.10.56.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:56:00 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e4f88ea298so5852246a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:56:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVBSHFIt6LY+aZ8+XH4SRtl53F0p0WW2eHUm+HT6IIERVhyBUEOSRlPoWYFmMXLIxZWUIBbT8oqXSbIHw=@vger.kernel.org
X-Received: by 2002:a17:907:6090:b0:abe:fa1a:4eab with SMTP id
 a640c23a62f3a-abf260d496dmr1907190066b.25.1741028160310; Mon, 03 Mar 2025
 10:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com> <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com> <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
In-Reply-To: <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 08:55:42 -1000
X-Gmail-Original-Message-ID: <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
X-Gm-Features: AQ5f1JooMQOhgpSZJUgMFpU_jRsla4fjvec84mqVPfIW7QyBHFNNtlSgyObw66Y
Message-ID: <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Oleg Nesterov <oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 08:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> The stock code already has a dedicated routine to advance the tail,
> adding one for head (instead of an ad-hoc increment) is borderline
> just clean up.

There's currently a fair number of open-coded assignments:

    git grep -E 'pipe->((tail)|(head)).*=' fs/

and some of those are under specific locking rules together with other
updates (ie the watch-queue 'note_loss' thing.

But hey, if some explicit empty/full flag is simpler, then it
certainly does fit with our current model too, since we already do
have those other flags (exactly like 'note_loss')

I do particularly hate seeing 'bool' in structures like this. On alpha
it is either fundamentally racy, or it's 32-bit. On other
architectures, it's typically 8 bits for a 1-bit value.

But we do have holes in that structure where it slots.

             Linus

