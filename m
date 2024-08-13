Return-Path: <linux-kernel+bounces-285428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0B950D60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C88C1C2290D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD51A3BD6;
	Tue, 13 Aug 2024 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AXG7hUxr"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C81A2C0F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578511; cv=none; b=JhYqcPtNi3FM5QUH690zCTg/KQcjzp/y0z8HyX3AqwwHDOQt5CjYpFPaOn/aFc5hFidNdszH5S9IAn2cOT3hHLfoEyMUU8U0l2WXhqMr1tpIm9leKYJ37ZbtKrl++bfGvJ2PsvYN8VzNLlHrgoSNT7+6Wu4rnXRcr6tBjzposi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578511; c=relaxed/simple;
	bh=4areZ/62J6EMKXDIYv5lW6H5nWkh0FvoS9vyc4LjK/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOOwdW2MheZG7xDpDP4ETYfym+H5YjiAmzYldW4uXk6iCLBVqJUMnXugfV69VHZf0bgWO+IV3Dg6WNjBf0JfIx2Q598l8b6rEPlSvJQfTamqsOSNz2hCinlzyE5AXgt3JOk8k2KB3Fifn3KsMQze8dJYvg/TqTjtOl8bjTpvBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AXG7hUxr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so6163871a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723578508; x=1724183308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QjFuZfVGPtR9PbK9byb3eXxihEv26v2AgdTDlVlJAnI=;
        b=AXG7hUxrEzvLBEohk66bbGKwkp6bapQWgK5bzvIC7VATYEXEmoDUTevcwnjpxUpwZk
         yMv+cfzK2EfmS6lHYhIM3zlwSXwOHWMFtyQFQo+97LXldvVQGkHWnaGA9H4xU92kvkpM
         qgAfCqha66a0EMiZNAcugz8O5dFEslndNzePI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723578508; x=1724183308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjFuZfVGPtR9PbK9byb3eXxihEv26v2AgdTDlVlJAnI=;
        b=CUiAx+RW2EzwHw8TeQ6VHhr5PJD5AdUneyaEueQyz50xzjd5rXquOtG0BTXxmHWYl/
         rf3MQ4ERJVgGrb2AN3hE4Xsc5Smz0+zgPq5XZUtwatxJxF2KVuYp/j4Ass5gPgMh50pr
         SmqWPPEcmb+RINJ7gw/rATMF4VawMAOBNOD7O27xgj2tgDmIh9BUmESFvGTJLwzCZr4A
         faRpgsOBJxxkUb+EeEWQAfBVQTRWa7hk1UQGBoulm7Zfbxdjlf/tFEX08aVCiihtdVWG
         vM7/7eE2Au3XHN2aEDK0vnAv3GnCrzHm9zVwF7Bg1zdEGVOMhHzgIPmCr0mc1o0/mMF8
         lM9w==
X-Forwarded-Encrypted: i=1; AJvYcCU3AmZeCyFW27aZFxrDJ0MqXlBN75MuqVYLxIUjlkolK800UZD3fI8olcgxo7EDhDnmvb95mozTgt4qpg+qzaF4Xrswj23KwshqWWtE
X-Gm-Message-State: AOJu0Yw3KAhCeUHcziMnk2W5a1474hJWjlX9IWKyz6jFnVv3i1usmouL
	v4YGumKE07QnllDpZRybm6aYQaXUGR6q0nhBfFN2qbjCfmGhAP+HOlkbUrxgst/nSuTo06CfYlc
	EnuE=
X-Google-Smtp-Source: AGHT+IH1YULzlV0qYpok1g+5qb5ps2u3SmYoych0S/1k/T6xXW0CxyMN4OYhsk0a9YT3OHIKug3gtA==
X-Received: by 2002:a17:906:cadc:b0:a7d:c696:76ee with SMTP id a640c23a62f3a-a8366c41d86mr30694466b.17.1723578507595;
        Tue, 13 Aug 2024 12:48:27 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f417f6fasm94237166b.189.2024.08.13.12.48.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 12:48:26 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so5336919a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:48:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGyS5eNwWn4GCXsdpr41JFYzMkhCstCCwsVEWRSV7GmbDrQ/TXKC3KTKvW0rXZEcEoW5mLdvamSpZRx4tQ2Ck0OwoME6zo4tTFWoWG
X-Received: by 2002:a05:6402:2102:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5bea1bf27c2mr540434a12.0.1723578506092; Tue, 13 Aug 2024
 12:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org> <183ee6fa-1d42-4a01-8446-4f20942680d2@redhat.com>
In-Reply-To: <183ee6fa-1d42-4a01-8446-4f20942680d2@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 13 Aug 2024 12:48:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgwpzsn9XvZt3zRgP87r4mSScD04P_g5JeiR1irN3vRA@mail.gmail.com>
Message-ID: <CAHk-=whgwpzsn9XvZt3zRgP87r4mSScD04P_g5JeiR1irN3vRA@mail.gmail.com>
Subject: Re: [PATCH RFC] Avoid memory barrier in read_seqcount() through load acquire
To: Waiman Long <longman@redhat.com>
Cc: cl@gentwo.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Aug 2024 at 12:01, Waiman Long <longman@redhat.com> wrote:
>
> Do we need a new ARCH flag?

I'm confused by that question.

That's clearly exactly what that ARCH_HAS_ACQUIRE_RELEASE is.

Obviously all architectures "have" it - in the sense that we always
have access to a "smp_load_acquire()/smp_store_release()".

But if the architecture doesn't support it natively, the old rmb/wmb
model may be preferred.

Although maybe we're at the point where we don't even care about that.

              Linus

