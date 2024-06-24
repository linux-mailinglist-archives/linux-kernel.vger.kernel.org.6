Return-Path: <linux-kernel+bounces-227347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCFC914FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B583281179
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD95517B511;
	Mon, 24 Jun 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dI5R5WlL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD8170834
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239103; cv=none; b=PtEdjLLjUWjLEsrIfhvJLHNCPzrR06PR10EWEEtgF37ywISkkd8L513MF5oKIo4v4Ary8bB5/DeSU40q7abRgtswFsbB3npnHBc/1CRijWN/Z/dShQi68PrE4PHyq1fg68g18czZ0psmkTU33bt2OxnAZtfjQDNRCPUh8m+fVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239103; c=relaxed/simple;
	bh=ydvc29uZPeUufls1MdORdbK86wNdSk4EEwEb/yEu8G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdroctWZcf0g325ujTHSWrQbvWCqVeqEnudlD+9DcMfuAjDVeVsqegfz78Z4W3RRuGz1Z+dPUFiFbp9/Gv9DwRkVd/8guNpnMManPbasORUVNP7qbCkKFF6QM5t7NBlDF6FiP87h9SvzDnLsOTd9iZfThn7fJx0DD/Q1UNGqd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dI5R5WlL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-356c4e926a3so4143295f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719239100; x=1719843900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiSfvHfbv/5xU72/ZLgMFqI54d7nKylYdFIP+ugA6ms=;
        b=dI5R5WlL4+ToHif5KJtUah3b1rrFboVfK7G4aoIZlJbcg4DnINnPnQsc5S/ZICa6sU
         5EwZA/k6AX+bKvp+hePgesUfVMLlRmvy4H4J6KRhZ5D9GxX0Ho96RfbhBVLPYHL+3WAq
         YgFWhaSh8SOUOHYn/s2qdr9+seVS3dCzYiqeWYUgPoDpm01RuLqPk7hmHvd7IyghGcOx
         0yAHGqBi7uSqt3kJ/OkMy8pQSstHaBEMJ5ha83QrrWxN2nxBXcWUdXK7w4R0wg5WRvMc
         p61sWSeFKKAKDSf8LzFN2Eb13ol9SfzCJlssqJI9fh9qbXEQA5x2zK6Y3/ARfEbnVDqx
         0k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719239100; x=1719843900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiSfvHfbv/5xU72/ZLgMFqI54d7nKylYdFIP+ugA6ms=;
        b=WwTIvRhIbkdMiomEJF93JgtUTf0+onr3m9R4s6UJSwZQ2Ri1fmgkZi+2G65scCCKyL
         iPLSO34o78BDnkBVWrDeu3EW5MOUG+oudFBjgVGRhPPpFxJMkX5qbVf69gmgYAhj5m6A
         UAAJ6GrXwlAliaX61RWKdEa3hWcALGRPcyb7C0x4aa98020WlLj6Y10ILItK2AKIXoC9
         72siuvDj1qduSgguYwIVYsWs/Bnh3xF5SVtWJ8J5d4//CU78KWKjluvnW6I/CB6Tg3b8
         JEbKQka+2GYVx1A9zx5NpVEYUOXZhNEYiGPsGZdg1gDltWMG1FbzDzwEcDLe61EnUwL7
         02pA==
X-Forwarded-Encrypted: i=1; AJvYcCU4IMDLcs3+wbeP2URkh77dSica2HW6IB/Y/Nr9r3BlJJVOCSug4cTI+D+FNji3l6eEY/daKwSHenCsB7AfjKCuWtPp/5H4mDKR1IaT
X-Gm-Message-State: AOJu0YyNJXkZTspdO76pptM9rCRJ7wB1uYcVFrUTtQpHmaRbcz+lUgA4
	n+gYwM1rcEiUNucFl0VGnCT0uJCOfcqInRzdYOOjAjvjK/JBu++y83bw0BqmfcVIwQOqN2dNWP9
	MPnGcYJV3MFSCUF9l6wcU+k7wWxGQaKl3GX/v
X-Google-Smtp-Source: AGHT+IF18T5l0y/8WaxjICwzgVTdu0fg0kna7EFCcFKG6GmypQyJ7UKdfCK2jSP3pwLln0Xl+RItGFCfe21mKIYk4v4=
X-Received: by 2002:a5d:6d8f:0:b0:366:eb42:8745 with SMTP id
 ffacd0b85a97d-366eb428828mr3237982f8f.30.1719239099629; Mon, 24 Jun 2024
 07:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618221347.106627-1-yutingtseng@google.com> <20240622031600.3762859-5-yutingtseng@google.com>
In-Reply-To: <20240622031600.3762859-5-yutingtseng@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 24 Jun 2024 16:24:46 +0200
Message-ID: <CAH5fLgjR7iLHaWGy0NAiKnOUKro7_fBLoqFFzkdjn926jUdyAA@mail.gmail.com>
Subject: Re: [PATCH v2] binder: frozen notification
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org, 
	arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 5:22=E2=80=AFAM Yu-Ting Tseng <yutingtseng@google.c=
om> wrote:
>
> Frozen processes present a significant challenge in binder transactions.
> When a process is frozen, it cannot, by design, accept and/or respond to
> binder transactions. As a result, the sender needs to adjust its
> behavior, such as postponing transactions until the peer process
> unfreezes. However, there is currently no way to subscribe to these
> state change events, making it impossible to implement frozen-aware
> behaviors efficiently.
>
> Introduce a binder API for subscribing to frozen state change events.
> This allows programs to react to changes in peer process state,
> mitigating issues related to binder transactions sent to frozen
> processes.
>
> Implementation details:
> For a given binder_ref, the state of frozen notification can be one of
> the followings:
> 1. Userspace doesn't want a notification. binder_ref->freeze is null.
> 2. Userspace wants a notification but none is in flight.
>    list_empty(&binder_ref->freeze->work.entry) =3D true
> 3. A notification is in flight and waiting to be read by userspace.
>    binder_ref_freeze.sent is false.
> 4. A notification was read by userspace and kernel is waiting for an ack.
>    binder_ref_freeze.sent is true.
>
> When a notification is in flight, new state change events are coalesced i=
nto
> the existing binder_ref_freeze struct. If userspace hasn't picked up the
> notification yet, the driver simply rewrites the state. Otherwise, the
> notification is flagged as requiring a resend, which will be performed
> once userspace acks the original notification that's inflight.
>
> See https://android-review.googlesource.com/c/platform/frameworks/native/=
+/3070045
> for how userspace is going to use this feature.
>
> Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>

[...]

> +               /*
> +                * There is already a freeze notification. Take it over a=
nd rewrite
> +                * the work type. If it was already sent, flag it for re-=
sending;
> +                * Otherwise it's pending and will be sent soon.
> +                */
> +               freeze->work.type =3D BINDER_WORK_CLEAR_DEATH_NOTIFICATIO=
N;

I have not done a comprehensive review yet, but this looks wrong.

Is there any chance that we could have a test in aosp that would have
caught this?

Alice

