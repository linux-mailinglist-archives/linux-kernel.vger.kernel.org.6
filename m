Return-Path: <linux-kernel+bounces-513249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40BBA34662
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE213ABA15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4497139579;
	Thu, 13 Feb 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMq9hqi+"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91514645
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459586; cv=none; b=ZRT6mPNBbwsWQ6GqL/CSCYFVT67odwCAjWdSXj9qqDSMqufuh1urCUQX1LXaxgR3L3QjoiS+NkwWTahGcIPc0bNv7Jwxmf6CReUy7c5l9hMc8pzIksNeuGj/tewYECnh+c5AI5ZczXmSrXU9ad3ylUmROxdQ8WS071Xr86kIvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459586; c=relaxed/simple;
	bh=lyoq4If8j6FElTCaqypuhp1Huh2XObYByN8LkOK0Fxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l93St0wyc77cYMJnwJNUWWsnW7kSmO4bCsJeWa952yq9Pk8lYZ7BNxJIe9p8CBiMLp8rN35ibu436PdP59z9htVgfgUSy3gkziaNGUsT0JjHk8sPL/aW9kaNgiflLLOktGgBDyULpp3wt0QBs9FOQwtxLxSjYQgVujOyIEEpBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMq9hqi+; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5b32f64ffeso978745276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739459583; x=1740064383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+UqBvaR81xAW+Yhur+fD3JqxwLyDew4ZK5ittw4x98=;
        b=gMq9hqi+qHpaJQd18Ttdqg8Ss15KUkCHlFo1EM/e2S1q2l+y+m9s1FfybWsIgXCu13
         tAeKycCBB1RAzXzpQZfCK19P2MM50/5+w7RGZZ27k8Pn1VcwuNkJ0RY5AGf5UElAUhbN
         pgPCaaDEgTMn5tVMbm1M84xCJ1UnRyUX4Zh713v2vgKbsSbq46xF7qZZbWLqkUBOS4ZE
         Q7vUP/YhvkI94HMwLxRA8EcZ2Nd97/fwF8MT5r36RGT/kRJhKZfT8tiLAxDwQVdvMDze
         xtG4+0/IpBA3o0TanFShrVtsfcvLI8HPJ8p6bUxSI83hF8M+sgSBaPWGGxl9Txui4z5U
         fz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739459583; x=1740064383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+UqBvaR81xAW+Yhur+fD3JqxwLyDew4ZK5ittw4x98=;
        b=exjFaWIJUHilFQAIx91ommXa5LAocYsA3qCcFlGU/Cdbnkjmv/OVf0kkFzq5a6s6a1
         m6oxM0jucptFfOpROm7AjGOjrS4p8UV5y1GWPtaiY1jpGfQp0fhDVGl2/a8whpuqrP6o
         a5X/l2hSZmamnO2pr2MGzYm0Ohcj/BQSpZKo2cdmsTWvK/RfIdcfVnQHhm8e8sTvfryb
         /QaOeIdN14KEyyUihlKAwKQ1kU3IL3QHFGxuWUdRM4nP9b6931q7OSVRzbAoCcj3V4Gy
         /nYxvkWFcgueKu7yUNU9zwQaSi4BLzXNLRtn9f738VFyU4PZifcmQ1rNcPY+fZUfXIUM
         maGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPsye41mo6E/F+12ss0TPD9oa610Q27AY3dYmAH9hzQEZ01J4qLtr3ZPlMhjbFKMj/NOS/4R5sVxhZCcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJg0eX59i16zZaP2isKsB1As5965akZgUuwmjX31NQ4f4TDCD2
	TEeAbiFhbvfYMa7aDf7wCFWRVMqZd6+4YM42aj7AEP9KAo4A8prqjuavzZ3uXPxbpzWl9bGeZ/f
	C3C6JgnFKOHlaehG29Z69N1FuTQV0b5IvQ8J0YQ==
X-Gm-Gg: ASbGnct3BwfRtfbEmJjAFbQQtupzir6oO8HG7U+XRCQ1192pXyxJGRW0UrkXrmfZ+/h
	4DtH73VVKQMNeMgpva5mrGZGp1gmz4UyB98x7BvF2w6WZN0y+D1tG/bbTa30nUSbWKy+eoe+gTw
	==
X-Google-Smtp-Source: AGHT+IF5hBCoP4Zie8IlrY0QFEqPLwp9JZSFE9LUSCL5GsS/DSPtxQHgXpyDUSTfwvH7z1LyEPIm9JT/vGqEJ4uA2qk=
X-Received: by 2002:a05:6902:1003:b0:e57:8814:1399 with SMTP id
 3f1490d57ef6-e5d9f185e88mr7417122276.44.1739459583330; Thu, 13 Feb 2025
 07:13:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5X4L9L2ught_h4M3_oe_aTMALki6nJPh9M-3KmdDx6WswffQ@mail.gmail.com>
 <20250213121738.GA11596@willie-the-truck>
In-Reply-To: <20250213121738.GA11596@willie-the-truck>
From: Junlong li <zhuizhuhaomeng@gmail.com>
Date: Thu, 13 Feb 2025 23:12:51 +0800
X-Gm-Features: AWEUYZkVQ8XXTZq7KUdyZjKf03H4u57h2cLDnVw5ubIGkarMWzwQlBbVcYmy4ks
Message-ID: <CAN5X4L_p-h+8mb7dvhJEuT04GjfXKt6MMGUU2ah9=ZnQCVomqQ@mail.gmail.com>
Subject: Re: [PATCH] ptrace: Fix error handling in ptrace_hbp_get_initialised_bp
To: Will Deacon <will@kernel.org>
Cc: oleg@redhat.com, catalin.marinas@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your detailed explanation.
I misunderstood the meaning of the return value of the function
ptrace_hbp_get_event.


On Thu, Feb 13, 2025 at 8:17=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Wed, Feb 12, 2025 at 07:35:46PM +0800, Junlong li wrote:
> >    From b824aece318ed38666621610af7807e70831f964 Mon Sep 17 00:00:00 20=
01
> >    From: lijunlong <[1]lijunlong@openresty.com>
> >    Date: Wed, 12 Feb 2025 19:15:46 +0800
> >    Subject: [PATCH] ptrace: Fix error handling in
> >    ptrace_hbp_get_initialised_bp
> >
> >    The function ptrace_hbp_get_event() returns ERR_PTR(-EINVAL) on erro=
r,
> >    but ptrace_hbp_get_initialised_bp() was checking for NULL instead of
> >    using IS_ERR(). This could lead to incorrect error handling and
> >    potential issues when trying to create a new breakpoint event.
>
> Can you please give an example of how this goes wrong?
>
> >    Change the condition from:
> >        if (!bp)
> >    to:
> >        if (IS_ERR(bp))
> >
> >    This ensures proper error checking and maintains consistency with
> >    the error handling mechanism used by ptrace_hbp_get_event().
> >
> >    Signed-off-by: lijunlong [2]zhuizhuhaomeng@gmail.com
> >    ---
> >     arch/arm64/kernel/ptrace.c | 2 +-
> >     1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >    diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> >    index 0d022599eb61..3bf549b540b1 100644
> >    --- a/arch/arm64/kernel/ptrace.c
> >    +++ b/arch/arm64/kernel/ptrace.c
> >    @@ -414,7 +414,7 @@ static struct perf_event
> >    *ptrace_hbp_get_initialised_bp(unsigned int note_type,
> >     {
> >            struct perf_event *bp =3D ptrace_hbp_get_event(note_type, ts=
k, idx);
> >
> >    -       if (!bp)
> >    +       if (IS_ERR(bp))
> >                    bp =3D ptrace_hbp_create(note_type, tsk, idx);
>
> I think this change actually causes a problem.
>
> In the current code, ptrace_hbp_get_event() can return:
>
>  - An error if the note type is unknown or the index is out-of-bounds
>  - NULL if the relevant breakpoint has not yet been created
>  - The breakpoint pointer if it exists
>
> So, in the case of getting NULL back, we lazily create the breakpoint.
>
> Is it pretty? Hell no! But I'm not entirely sure it's broken, either.
>
> Will



--=20
-

