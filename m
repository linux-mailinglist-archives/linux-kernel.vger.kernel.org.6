Return-Path: <linux-kernel+bounces-273296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC8946704
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CBC281EAD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1057D101F2;
	Sat,  3 Aug 2024 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xY6xWY9l"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A6F9E4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655366; cv=none; b=R7CbyYnOJ6Xehg60EoGsdEEIZCxjxi3VYe1321B6DeDa/L049ndBTaE1bH4UzZ7lbbx9wrM9aIR6wwp1W/g/NSu/lFhM6gzuZy9CadwJOFd9eeCFEaFF8JN8/0YGBqJBwTMycLIeS2H8jTF0LgAO0UFuz2GT90D/oCqi43R/lAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655366; c=relaxed/simple;
	bh=2V/06i2RmUvlO+zSr7S7F/ykckUyzAhmZ5TEusO50W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZOtbOfPBUZ/853binCqmarQ7TDaclCjlQup5PeLCm5sy3iZssTz9gbPrbf/tQBtmpEMLkJ396yiwZh8mUTjc5aDVHKW7j+kNUg/XWnh2c7dO/4dYPlFV9ATT/9qB3re7HxlHHQ8oOGNvH9QG+hU0bRAJcLeYzVWaYe1GdclKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xY6xWY9l; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so12425776a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722655363; x=1723260163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V/06i2RmUvlO+zSr7S7F/ykckUyzAhmZ5TEusO50W4=;
        b=xY6xWY9lL8YB/PdfRma7MQlybZ7wVNTMJ/Ngws3z8QdbBvC+eW95khEmrkBpInpcV+
         oQf8iyRbVM+QEpUcwxGzZW80jmFevIMctSNOnug9NzJ5o1kTyXupFmr+ah5XjGPpUEix
         SU+yimoReIu3pBYn/uLjXmGTpJWXdOJ9u9qC8n7S5ZSf0Lv7yKnfzaqxJsI/IoMtgcqI
         PNsf6DvYhjQBDazlsZJcQG7kSiQoCdZel/5e2HCYmAtER7aFrIIsv8XHR0pd8q1QSy5h
         113Y23MicyjhwAERIA1f2IUq/+BPuMlcstfDpcxT9kDerN//MWOzd7zjnqP4kza8Edgh
         K6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722655363; x=1723260163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V/06i2RmUvlO+zSr7S7F/ykckUyzAhmZ5TEusO50W4=;
        b=ajcHtL5dZbuYEipOjgP0CxXN9X3ZtaFJLA5OjG/hrUaOwhwa6bszSDa8iKYue88z1a
         T/gdSDqMhbh7p9IbMcmoDOxysIpCxR8xGp1EH9P7LuRfuVnIIO5S7NDgZPhd7I8XC2s8
         rjDW+jCVR2ifjVAihi3giMyfd/yBYKN8vUjhlk4mma24Cg4FmIw091w9x/skJxJZ8iDx
         DqAlD3b0CrprO4jGv6PMMrFAOghP5jGnfucDuPFObsb2cTP4oE5arUlVhKeDf3Mps3Ec
         XUCN2FaRm1tEb2q7aLTCMcxgDmLyQQhvirhP/HnDuyna6pIjJubJhXgF4XbkG4YR7jbX
         Y9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpplEbmUqoBm1TI3qDi8TqjfRRssMutP6oJ6TryOBXcBVaYZUosCZV25CrD73rIEbg6d0m4w4oxpWm63w4gDzjc+9sKnRqcd1pvYoV
X-Gm-Message-State: AOJu0YxY60v7p0H+jwnmP8DtjQcEMkuzu7/ieZwPKvd0DLtp4XdS+P2w
	Z6t5Q3jrTkuLHEQKTLOgB3f0CeeiZ2ZpUTIvQoAgiSAPQeLnR82jSV2AMsk11gWUDyZINlCxAbN
	HQXgak6YucVWuV93l60/4RwL8GP8ZmcPMDkQw
X-Google-Smtp-Source: AGHT+IF3WLjswsizJerD/J9q/Bv0f3kbx9LG+/VDuY1yX8RvUOgkK0vBNoFLb3ai+VonbQI56jpLpl2gxnVsTpyBrHk=
X-Received: by 2002:a17:907:1ca2:b0:a7a:bd5a:1eb7 with SMTP id
 a640c23a62f3a-a7dc5105635mr380652466b.59.1722655362339; Fri, 02 Aug 2024
 20:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730222707.2324536-1-nphamcs@gmail.com> <20240730222707.2324536-3-nphamcs@gmail.com>
 <CAJD7tkbQMB1RBr1mDb_Ye+wvk97mD1D-+uFAxOEw0ZRLZp1yRQ@mail.gmail.com> <CAKEwX=PZy8FdBajsW3ai4CSrXfNzR5zAq28KwUVt92V4KgYtag@mail.gmail.com>
In-Reply-To: <CAKEwX=PZy8FdBajsW3ai4CSrXfNzR5zAq28KwUVt92V4KgYtag@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Aug 2024 20:22:04 -0700
Message-ID: <CAJD7tkbPR7ZCR9nTpn3SoF6hD8A7_CuPh+SffHG8Mdo=LSU55w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] zswap: increment swapin count for non-pivot
 swapped in pages
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 4:46=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Thu, Aug 1, 2024 at 1:02=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> >
> > Hmm, but there is a chance that these pages are not actually needed,
> > in which case we will unnecessarily increase the zswap protection.
> > Does the readahead window self-correct if the pages were not used?
>
> Hmm yeah it's kinda hard to predict if a swapped in page is strictly
> necessary in this context. We don't have this information at the time
> of the read.
>
> That said, I think erring on the side of safety is OK here - my
> understanding that readahead, while predictive in nature, only gets
> progressively more aggressive if we get signals that it's helpful (i.e
> the memory access patterns display sequential behavior).

If the readahead logic is expected to adapt in these situations (and I
think it is), then I think we are fine. Perhaps we should just leave a
comment that we may increase the protection more than we should for
those readahead cases.

>
> I think we also accept this slight inaccuracy (i.e for pages in the
> readahead window that might not necessarily be needed) the in
> workingset refault handling behavior. Could you fact check me,
> Johannes?
>
>
> >
> > > are also incrementing when the pages are read from the zswap pool, wh=
ich
> > > is inaccurate.
> >
> > I feel like this is the more important part. It should be the focus of
> > the commit log with more details (i.e. why is it wrong to increment
> > the zswap protection in this case).
>
> Yeah this is pretty important too :) Maybe I should make it clearer in
> the patch commit.
>
> >
> > Do we need a Fixes and cc:stable for this one? Maybe it can be moved
> > first to make backports easy.
>
> Hmm.
>
> *Technically*, this is broken in older versions of the shrinker as
> well, but it's more of an optimization than a bug that can crash the
> kernel, so I don't know if it qualifies for a Fixes tag?
>
> Another factor is, under the old scheme, this does not move the needle
> much - at least in my benchmarks. This is because the decaying
> behavior is so aggressive that incrementing the counter in a couple
> places does not matter, when it will be rapidly divided by half later.
> This fix only shows clear improvements when applied on top of the new
> second chance scheme.
>
> I don't have a strong opinion here, but it doesn't seem worth it to
> backport IMHO :)

I thought it's a simple change worth backporting, but if it doesn't
move the needle without the second chance algorithm then it's probably
not worth it.

I would still add the "Fixes" tag because technically the logic is
wrong without this patch, it increases the zswap protection when there
swapins from zswap which doesn't make much sense.

