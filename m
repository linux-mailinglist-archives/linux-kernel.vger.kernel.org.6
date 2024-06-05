Return-Path: <linux-kernel+bounces-201906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84C8FC50B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FE51C21BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232818F2CE;
	Wed,  5 Jun 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zo0OKjyH"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAD191480
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573797; cv=none; b=QysZDiQQalXsZPu/HobUi+H2aZQhCbSmfRlUGVqHQccOkNAb5qrljw96ZB8taFPiQyLAC5O7INBlNfEb/Pz40vC3iNlgFYgh1MxyK/xZWRlPJUwB7OD7gaQePVC37Xc/j68wJe0cCg+COc4riLD2TQq07h5y6aZd15tvhNBm9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573797; c=relaxed/simple;
	bh=FE42yrx9mX2aAvYx08lkJboDb101vHDGkEUhaTj4lJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwWl4zwyeflOe+Xm9IAiVfUKrG2gDNZbu7tqCzW3IdkApwu0tdDyrbJMuV6IW/5o5fhExbtO9XwQ0UkC/ZyDuSh1cqgjUrK5m4FHef9VGoKJJz0Ng3XUB8E8rgrKLM7uIbBPno0GnyaYDfol2cvRGM/79zXWMVAf98TMY8nEUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zo0OKjyH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso5692a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717573794; x=1718178594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE42yrx9mX2aAvYx08lkJboDb101vHDGkEUhaTj4lJ0=;
        b=Zo0OKjyHOWyak4iKzhzb/hikUeH+VVrIsCk5lH8dHes06k36NykNFew7GCgzLAp3wB
         w11ve/gH0LYcDQnSox6EtBUj0Q4d/aYWoGJSuZaj7DSkZdc0vFApY55WyYPAJp/dQ/rd
         MXq6y4L1qDelhx+oot7lb3Fz/g0sd2jNOl0pn//WD870oKsO75ZaQ1/tpihCyeUiqph1
         rfoqh3M55m+rEsj+2tg6Z2JmnjrkM8WDm/PFrNcyrCS44dHdylE2Gs600Lyz3Oa2FZiU
         DMMXP7TP8i0Ba1hgUTnNrIZFmuXyqjnpOrdX6B2bxatxN13Dsj02m7+yX5iVngEcSdJk
         whJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573794; x=1718178594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE42yrx9mX2aAvYx08lkJboDb101vHDGkEUhaTj4lJ0=;
        b=lsHwiELsh2ERxkMrUMejJQVxJqcNq93JKKBE/u3yYn1cREUboFFsNPt19F+kOucaKY
         AxLfqua2j6IKnc2Nek5nHqCtGc2DNFf8BUYk1kbyblZlScFgevAXaxC9iL1/oeCVj+kO
         gotiV2w7onjmnYUuhqLQlTHHwUIpjByH/bZKCvD5j+dSYCLhE3uHm1bfDhkNo+d/R/VG
         TOOa+3qk/y75f9HapWUiVqvrR6nf1qiju9yGBY739K73324qvLX2wWPph1U4Os8QJMo8
         aCXy7UI1btPHDUm8FAGrh05MPhVD4c6RAua5krqDwAt3MbhN+nJxti7Kid4gRy1sidgs
         7JYw==
X-Forwarded-Encrypted: i=1; AJvYcCVjGNWTLjZd9sWVhJlNv15lPXnJQ+pJdv2jxkx5LiXITDBFA8Ve/qrF6YeLBHntLY1PerSyfPTr/4M79wF9qHGh/3NlYondLmc//4du
X-Gm-Message-State: AOJu0Ywb8LglSAOhomVO5cKCXyvn4pBzHACMHIHe1Kh2y2KSu60jrZC1
	hTVFxK7IJ9Q0jlpeyv83a6LJT/Sb8X1q7ilfCMSp4+60YlcbscgEP3Ca0/g01KM164gk4PjsZd6
	r0nrlROlqk8sykxmBZk4MaSGHVEybEmyRnjPk
X-Google-Smtp-Source: AGHT+IGik7WgbEwjTVgo9/fdJG7UMvJVLbNXpxM0I5UfVI/IX9afeT3W28dWzu7Du/gl9ewBx6vSxtl2TQVra+z+mLE=
X-Received: by 2002:a05:6402:288:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57a8d8de8bamr135300a12.0.1717573793552; Wed, 05 Jun 2024
 00:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com> <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 09:49:39 +0200
Message-ID: <CANn89i+BB1oZD-NScsfm-Stt7ykMNGij0b0dJYvit=PxyFOV8A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] net/tcp: Use static_branch_tcp_{md5,ao}
 to drop ifdefs
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:20=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> It's possible to clean-up some ifdefs by hiding that
> tcp_{md5,ao}_needed static branch is defined and compiled only
> under related configs, since commit 4c8530dc7d7d ("net/tcp: Only produce
> AO/MD5 logs if there are any keys").
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

