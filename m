Return-Path: <linux-kernel+bounces-542536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709BCA4CACF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84BF97A75F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA10C22D4C4;
	Mon,  3 Mar 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TwMcwcWu"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427D22AE59
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025524; cv=none; b=pXEqj4Oz2qTqujhI995uxh5y2wi+Y3M6YoWklqd/l943xxuuRapyaGSVP1cVZLt1618wwC8QkvqKwVowth2fiFVNZLiod7mJ5xR9urvzf+YCLflfrEd9hjlQxo4aUYyhp74Rrs0dVZGu3J9t/XSHqwc6PFFhv0CcW81OrcwEgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025524; c=relaxed/simple;
	bh=TnxBPfGniWDH996lZir1svgM+Ifn3JDhQPzo3qayJiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrVaBL9joj3wHRtozri1p6rIgnjJSXqATTBvqcDIl5Ulv+YwZjv0KkswzvzrBkMDDXnBQK9oXHjAvPpamAZ7ZIuXam/0DtLbCLroDFcu/+i6PCmCWWD0P6oeNctJxd+XyfgUd26EPpRzfPCIZ/TItME/7wn9IybzTxdD06a6Rm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TwMcwcWu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1174343a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741025520; x=1741630320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3MNxRS6G3spvOqXxyEtEnmq/idBtxgbtnljLuGuoq0=;
        b=TwMcwcWulXN4r0N57cXPfeqbx+fitZ4mBF7+/x7D376XWs8LlpHzPKiM0dbMPxwKvi
         WF2hhtfaJRf2BvH3TA/FYCMIDfkS125we6IiaIieQG+PZgxFdi9HSCq/kgydrrDWG1PE
         JoaR0GTTmAA+umvhuc1dSAmJJUfQYQ1f+qAxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741025520; x=1741630320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3MNxRS6G3spvOqXxyEtEnmq/idBtxgbtnljLuGuoq0=;
        b=qtoBlH27bK40qpC7KL6t3HGuUTiOXnooku2crlsaGsCre59leXbZmSTmbqBpuzpntS
         gz5C0e4a4pdGyg4xmgiCDSEdX/ioAcB41yQKl4sHlYuIq/ohw90+Ynut4tZ55LgLTD2d
         izrh+4u3p9+0skheVm17L/CBzpH2FbQt3cFcyIEtEAUvUl3VVTu1PGrTr9BF36pY1zFo
         hDr4MwJgoGohtx1GrjxMsqOcRYFB7bDg8l7YC2eI490YjPaimPwpLqQ4PUZEp/Mfsane
         czTyBT+U6Bd77xBDO1O2WbHRdeETjdH0r5DrRewpcbjlyH6kOcT3YGEiVQUZEwrhU1Sj
         kM6g==
X-Forwarded-Encrypted: i=1; AJvYcCX6W7uEMucdSh+24dEY6EcogvuJAk9TVYO9kHO5Tetf4D7bmIaiNNI+cJjtACJjObeK3wwtmbtiv+dsOrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFzF+EZ+5s/ePII9mApnBnqtnaVyS9VE1ykukpWr5QhXh6bqT
	udXB8aow4u8L0ncKE9CaKgvWa/wqLHwOOwEjgggt57yg5pVHLUZTHMQD0L/djMNVBwpo1tSh9v4
	scBE=
X-Gm-Gg: ASbGncsYqyVBv54LbP1Uf9VZGNFOKQcxVsKicbeQ6d5ppfmk2tGKGui0XelYG6NMU4G
	qbe1R9AYgVJr/bFlDSQbFN3ozXFQgdi1Cr22ojPc4LYBWrmXJewbeFqa9b6vzV8yKvwtTIGAplf
	4hR3navsNmEWGVnkXrSazjwtw0sw5R1TaEvf23eAaQaK6dkvwMx2XW6RwgfCkkmwg8JAxzK7lCY
	/iUtymOZGx4vT+ENKvh4USZH+fdlKtSuc1LSSgNjnsPnYiamnlBmDjWUrl8+xliiXNHL+WzcO6u
	4q8deF5PvfrQeMMRAJzj45sGmnscwQgkblYWGWybOLXRmZoCU6oSb/M573n3xrop71TNDJIkQhF
	IXqRY6FTOcjjUbmEO88w=
X-Google-Smtp-Source: AGHT+IGKqSH0J7fSrwQOr4janBQCNgDG3zGMIjx+hoKNXWhfthnA0W7d5Ws9z6NxYGc/U03cNJbL7w==
X-Received: by 2002:a05:6402:5113:b0:5db:68bd:ab78 with SMTP id 4fb4d7f45d1cf-5e584ecb45bmr250232a12.10.1741025520098;
        Mon, 03 Mar 2025 10:12:00 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb4818sm7038978a12.64.2025.03.03.10.11.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:11:57 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so1583084a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:11:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+0lIC+ZzUxxMtd4zsG8umH3TuYbBkUYhXpnk4KilOPUKszZRf4POQL/UKGFEpquL0KAjxeiVl+5ggZ0I=@vger.kernel.org
X-Received: by 2002:a17:907:8701:b0:ac1:f247:69f5 with SMTP id
 a640c23a62f3a-ac1f24773b1mr1536466b.28.1741025516145; Mon, 03 Mar 2025
 10:11:56 -0800 (PST)
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
In-Reply-To: <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 08:11:39 -1000
X-Gmail-Original-Message-ID: <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo-KDGS5FfxZY52-hiw6AvppvhzrcZgtVg7pKdUaM30hFo6-N9SADGkoog
Message-ID: <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Oleg Nesterov <oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 07:55, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Can you guys try out the patch below?
>
> It changes things up so that there is no need to read 2 different vars.

No, please don't do it this way.

I think the memory ordering is interesting, and we ignored it -
incorrectly - because all the "normal" cases are done either under the
pipe lock (safe), or are done with "wait_event()" that will retry on
wakeups.

And then we got the subtle issues with "was woken, but raced with
order of operations" case got missed. This has probably been around
forever (possibly since we got rid of the BKL).

But I don't like the "add separate full/empty fields that duplicate
things", just to have those written always under the lock, and then
loaded as one op.

I think there are better models.

So I think I'd prefer the "add the barrier" model.

We could also possibly just make head/tail be 16-bit fields, and then
read things atomically by reading them as a single 32-bit word. That
would expose the (existing) alpha issues more, since alpha doesn't
have atomic 16-bit writes, but I can't find it in myself to care. I
guess we could make it be two aligned 32-bit fields on alpha, and just
use 64-bit reads.

We already treat those fields specially with the whole READ_ONCE()
dance, so treating them even more specially would not be a noticeably
different situation.

Hmm?

I just generally dislike redundant information in data structures.
Then you get into nasty cases where some path forgets to update the
redundant fields correctly. So I'd really just prefer the existing
model, just with being careful about this case.

                    Linus

