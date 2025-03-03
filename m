Return-Path: <linux-kernel+bounces-542844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE899A4CE66
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F89173AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50072343AB;
	Mon,  3 Mar 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UStRtFMt"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8FB21507B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041386; cv=none; b=t3qet5HO/auhlBFiHUBmQg8r62LQ7BzF4DCXzh+xZZMu+jyHkGqH+qz6iljzWBA0QC55YKEsOWGznGjxoHbsHw96umjibFZdFTeNn8yy25SbRBpSkCMtfk/claU+xFlzoiIyg9/HyzuewTkK0WxGzc5qwqB2qFYQlJ/1CKijDV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041386; c=relaxed/simple;
	bh=E8IK1YxlvKjv85U+RewdJBr9DRn99tzMqZBsuWCK1hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukdH0or/LPsY2e9svo/Z2SoLSkYEu+Lb4FjZSswex6OqITcqxXbN4/J1gT2+IxefYvaWG9HT+Go+U+WWe5d0CpOtXMPz/CajkfDIS/XavjulaTz9QgfkIYX4Zze3l5BwAooK8Qcl4jHt30fgEc7bFYQYMROp47NmLKylirLVKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UStRtFMt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb37dso2746613a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741041383; x=1741646183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goNQpqu1GYYsi3IOrpMNuRocCYgIewdDJpbqVB8lELI=;
        b=UStRtFMteFZIIDiNYoIzlF0sKQWdRz1sHN97lfvCjM1kyWaCfvF40y7RDYBSytCjwk
         Lhrjp2I8eOe7CPyemkZL1iF1gK35QEPjuIRSqa1hD9rBQ4Mb/KnNK749pNNGkeXttix/
         MALKkH5srfmyRF7ZHZCqsXXdHNJMR0+cK90Gf6gZVCyNzaBOMRqFguBhs9pf357pLLG9
         w43ilA/0SlZCnau2sVL3D1FiazUknSTGRegXjZVyKtR25leClAdYlDw1nc91zl6VOMBv
         ybQ22iyaTYLwpguwyxCyotUZdFONjcHTERCBSTOE+XvrhgLDdzQGcxC05CHqHtkDAs87
         sbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741041383; x=1741646183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goNQpqu1GYYsi3IOrpMNuRocCYgIewdDJpbqVB8lELI=;
        b=Ytwi6ILtq5a8IxOwjzq63TjnTaSYz+vLwo+/hHuo0Ae4Nbc8pTulowioJ2NQEBS+jk
         htxp/Y9n7ZtOSI4YY5QJf7EBrmqT4EjQWj+4Jb4iHDLusGPf2WT1L+alVNxLPMTkAxWZ
         ufyOw+QHaaZoX77siKBo+2asYysRRlO444vRhYqSfyELQW7PYKyDtyYiALWIkrHZhLjw
         Wc61u1RAH6v/u8QNt5TtIdzXs31YXZMR8qL6xjoqTqHlnQFtZe2FrdhVAoIvSIQFdA8q
         pGmT7g1CuAOuCJ8bJkX03ETevqXSf8aBSYjrUBnc+HWXpd+sVYIxKRliYUhFMbqxp3Sf
         2r1A==
X-Forwarded-Encrypted: i=1; AJvYcCWDxndWP1/AEJghIrnTUIBiIVBMnebXzKBx/HL4hbXhF4AqIs9nYiXoS+67hZfqQ0eyNMUrw1CwaUwCFFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4X9xl4vUhbkDoJgamB+pM+dMk3KkoKc/a12QuFw5beJYqlUh
	5QIhiUxuE0776OFmXLz2vzuExV9dsN3pgOgywN/ZCl5DTLECxMNIqOB5thUqixzfkAelxg5Exhp
	tXVzADe0JfC6cjWLDyfDPk8tdssM=
X-Gm-Gg: ASbGncvOn1f8VmaRTeUIXVXQ7RvA6zEy9zl23MaknlNn1X9FeVxqP68LZkIIBm9065T
	M8Scv/YsSZMGQOiahE9z0BksEPOI7FWmRNEElMzlqnbL9RlNhHDE+7D/RewNRdfeFCqGSkn8iDZ
	CbUmZVT9wMgu9b5lYUVL3xWoOT
X-Google-Smtp-Source: AGHT+IE+PnnYfMCwgMy73pwSP89MxxGHaikqADX9oJLzVlPkuzT24iHvjtpaJ8Z9WHOB0YAPysmWKpQu3/96ZaQ0d54=
X-Received: by 2002:a05:6402:848:b0:5dc:d10a:1be8 with SMTP id
 4fb4d7f45d1cf-5e4d6b0e6c9mr17146680a12.19.1741041382208; Mon, 03 Mar 2025
 14:36:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303134908.423242-1-mjguzik@gmail.com> <20250303142425.bf8668d1875aa47e0dadf6d6@linux-foundation.org>
In-Reply-To: <20250303142425.bf8668d1875aa47e0dadf6d6@linux-foundation.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 3 Mar 2025 23:36:10 +0100
X-Gm-Features: AQ5f1JqJG2jRj2GFZWUoHveWlsLO4_VmgQELVNwzIw1zmb2UUiA9dopVVZBnGKY
Message-ID: <CAGudoHEWQN-3V+5nxPhbwdXpgp1C-Z01F0qBGoUnHEmxUgGbnw@mail.gmail.com>
Subject: Re: [PATCH] signal: avoid clearing TIF_SIGPENDING in
 recalc_sigpending() if unset
To: Andrew Morton <akpm@linux-foundation.org>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 11:24=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon,  3 Mar 2025 14:49:08 +0100 Mateusz Guzik <mjguzik@gmail.com> wrot=
e:
>
> > Clearing is an atomic op and the flag is not set most of the time.
> >
> > When creating and destroying threads in the same process with the
> > pthread family, the primary bottleneck is calls to sigprocmask which
> > take the process-wide sighand lock.
> >
> > Avoiding the atomic gives me a 2% bump in start/teardown rate at 24-cor=
e
> > scale.
> >
>
> Neat.  Perhaps add an unlikely() also?
>
> --- a/kernel/signal.c~signal-avoid-clearing-tif_sigpending-in-recalc_sigp=
ending-if-unset-fix
> +++ a/kernel/signal.c
> @@ -177,7 +177,7 @@ static bool recalc_sigpending_tsk(struct
>  void recalc_sigpending(void)
>  {
>         if (!recalc_sigpending_tsk(current) && !freezing(current)) {
> -               if (test_thread_flag(TIF_SIGPENDING))
> +               if (unlikely(test_thread_flag(TIF_SIGPENDING)))
>                         clear_thread_flag(TIF_SIGPENDING);
>         }
>  }
> _
>

Ye that makes sense, I don't think Oleg is going to object :)

Thanks for a quick turn around to you both,

--=20
Mateusz Guzik <mjguzik gmail.com>

