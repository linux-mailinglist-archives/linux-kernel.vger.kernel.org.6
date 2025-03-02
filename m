Return-Path: <linux-kernel+bounces-540707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19421A4B40A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7317A4531
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392601EB9F3;
	Sun,  2 Mar 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCQ6PmkS"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AF18BBA8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740939854; cv=none; b=Y6vjArh9XKamUaI0kgCjuuUaW5Yb/KcFYHSuRHOedbIFfqwaTGHir3czRb2uwKlzDoFdLBEEAVFnbphZkUt3you+suATgCaCdxbtSf3fJPoQDJeh0k1/wHSBQcY1jaaejcon/CcpqjJeEMZSDuZrz38qRCX63RpJkhMzjd2zANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740939854; c=relaxed/simple;
	bh=C9zY6t1+EC2nhlm1/e9Yr9bkvfNrm/Ne0NMCOeDtcDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+xuWiUDPYDOBowp+4b5vFocq327AXyokIxt2UFsW+cVMX1lzBJyu1F5N9/9IDAX+4lJacEa3QZGe0iAqMeD29AtOe8kX6I3TlkGgNe9XR5Dkpca0IMpxZpMc2+Qn2Q7C7BDTH3QMm3vi98cFJS7nJgh1Brrh/HijeIw96njQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rCQ6PmkS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-474d7e43b44so6899631cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 10:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740939852; x=1741544652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eplFgMaQsQyB+/Zy+raMLdi8B0lOyb9eqEbr6SEobIY=;
        b=rCQ6PmkSDgFk7OK6BOiESAekxK25VytSdURbdetsk1sqZkw7H7E+F8NXNmPzCfNzFt
         jnppyguQneGEone8CZ3NEhbWy6BA+9kt0B//H69zEptAJRT2s6xaOyU2XqXQxiSjGD9+
         cxuhUuea79Le694SIhtkTJ3CffW3FU5dYYGpWGgYvsNDQXAAZWD5SWZgV1GrffwFZ1q4
         jqJgL+x8eMk9Kwp9jYQkLZFqPebRZPYvz99qus93puLILKAy82gD/8CfSeNtEcSmjDYc
         gANNTmXb+nhu40igd3jTnSYXWX/4OH0g+S4BCMbXrOR48Kk+Jqr/HeSJVZX9gE/4JuwB
         whWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740939852; x=1741544652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eplFgMaQsQyB+/Zy+raMLdi8B0lOyb9eqEbr6SEobIY=;
        b=ixKXi70UN6meEEufuIkecXxDJo0JqS98sckndC2BGcy8KRRe/Q7BaNnns80YiO5Mta
         xe/JFyDCTfKTDi0cpviPGgghR8WoYIVD1t+apKSH4thY/mJMwVf7DCjOMeue4JrG0s8Z
         NNitvAo4zpHEhuM7/gWw9/pMJcrlrIrQxjmkUrlhx0/0aQHxt0Ff8aVQd8gE1fzbCd10
         iaFCGz295uY1R1+xWhbAkvgu11NQQQkl5iUuepHd1GXI1R0WQbx7mT18P8tDpPQkMnAA
         gQjfzZ51gFhYiEgJdfHVPo2WWoQnazhZLZwTsamFla0nDjec722dYhBiOdUK4cfjgNqe
         CAOw==
X-Forwarded-Encrypted: i=1; AJvYcCWx9UhDADlyJ1ZwsGVtsFUSptPjQpKOWOkEOkGFclf9F3EBHkZBhg5TS+kUIxf3Ry7Zin/ZS/R9SEBXmRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy345EPNooU90xi+9rUfmIvnp9QuGKTpU1uHBxLAIMaOaoFxahG
	acjuuXgiU+pnDO4Ba8JB3S0r9KWv5Tp/SgWiPX9UhfWyiucuROPx7OHlQaKyh+K+6Pc1XwHnk6g
	h6+WZWlcHg/ZGnc1nITC+M/R89Fh3ZHW7UZrN
X-Gm-Gg: ASbGnctVoWuR8PjyFf0E4is/zmtQ9XbbM0sBfoShoRSKhD3/ASDrG7pbHe4HgFqAwe5
	LKVbfQB1Aa30H6AC7MUsvIJ6JJ/+TLKIJdO4YcfoB5UuvWiz1mYaKs1LAfgmb2GzPvhWV1144zK
	Fd2DyT9O/HD+WZsE3zXuRIm2pj
X-Google-Smtp-Source: AGHT+IHoUp0qt690gXNPlU7guXUDhkYKEDbwO5J8amkbaeQJ9dEnWaV7+9NCNo2WRt5tUi1lg142+lTNChtitwgUcIo=
X-Received: by 2002:a05:622a:293:b0:472:3f6:92a2 with SMTP id
 d75a77b69052e-474bc0ee7d8mr177701781cf.38.1740939851650; Sun, 02 Mar 2025
 10:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302160657.127253-1-cgoettsche@seltendoof.de> <20250302160657.127253-7-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-7-cgoettsche@seltendoof.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 2 Mar 2025 19:24:00 +0100
X-Gm-Features: AQ5f1Jr0FDOQ9D4KLNOprqJYo7eUxi0ui0k4VkgLi_xZ_6fJwr97NMU8vRrNx1Q
Message-ID: <CANn89iLDDfWJqtxnC463t5aM_p4-4iUjVNfvuxZs=_DXeThGww@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] ipv4: reorder capability check last
To: cgzones@googlemail.com
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	cocci@inria.fr, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 5:07=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

