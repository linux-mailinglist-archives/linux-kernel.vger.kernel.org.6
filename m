Return-Path: <linux-kernel+bounces-249449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0192EBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE37E283A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7E16C84C;
	Thu, 11 Jul 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brWeXE3S"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABC1662FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712503; cv=none; b=sSd3Lgkd610z288JvZxVZbuXCbhY3fKNl5E+sqSSQwCX2pMU/kbwdYnIHe86z5WKrXqRH2V5BD5JjBdibYJwVIIpZ6c3qv3ccHARNi1T8dqOWHz9sJ77jflIKXtYXh4yfs8S6zshclA80N95YoJm/3hzUPuftbBjpzT4RzwyjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712503; c=relaxed/simple;
	bh=h74SYtaDurtWVMNe12MxjW2lrtvwlW5PQSKC1xWTX6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWu7CWNYsK0xsUDsew/WfmQ0zoo3AdWPMBJinswHrMezEyVUVEk/E792NijjP8OmhpqQ+ASES4lV2+9X7gl3sioj6TY64CZ1VqJrTJYD46iPbgyd6B5j8dQ/2YWq/5F0pkxCCs8tgfg87UWIuDHRdfws9rLQXtOWxFZtZcEsmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brWeXE3S; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266f796e67so70825e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720712499; x=1721317299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h74SYtaDurtWVMNe12MxjW2lrtvwlW5PQSKC1xWTX6k=;
        b=brWeXE3SDJ+uVb9dBB2XMSlzt8/Kt+uPdTnVW5lWs1eRQe9Hg1int2wXMEUbNTTXfn
         1RH5FBKOCxXIagdOLezHUGdc7b9/cCUqNcAyNVLwqvAnWt7UGsrhEqNMPyW2ScPkEMO3
         1wHjUe1OpIPZV0BjAsLYJ92n0vkiOVgoD2zMKFRNf6JJQnMC2IkLeg/n+yffvaI+W1PD
         eIAA8Z16JlkMnA1EL4D5a31Xuwu0QzxuGFFa+itBSciwh7iNUa7AvFfVEP6KLu56b3qd
         b674/XlOm4sDPm7T9XKgUpafqVJ4CI6cR2EQrsLsHw0UNBPTmVmuC/uepBC1z3cfFv5Z
         oSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720712499; x=1721317299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h74SYtaDurtWVMNe12MxjW2lrtvwlW5PQSKC1xWTX6k=;
        b=YjNUa679d5zUKRI3i6qlNbUlKra3PVP6zuHqXJr59kENzgc5wdQYyJgP/D1UXtPblX
         M0Xe5JoFfymszqudREnRHGIn78znJSTJpOKukL23IAQ0xP1PO0uUJAwnw3GT8X11Pqbe
         dftlCQ8swX7/p9vcq3PgDJ7ghpArLMgW2IJ3/fceLc+5zhexuPFVxl4gx8DIbIfZn3SK
         HYQsdmEIoEliDxTfaJLBHP3XyGTfQ9WqsaCKk9fF3dOYUdgUGCsOoYfxxO65jN5DDsbF
         NaJchNKaFjVst/0Qcz74ZZp1QqMC079id9gQgrrlOivW5uj4ZdOctJy20TXqmW+5ozll
         noXw==
X-Forwarded-Encrypted: i=1; AJvYcCWk8nVNNht2sLaDyRDLxlgdu8Mbf5ZIHBE9AlMqU1rBzuGXUTB7haMv36m+4VNtg+ASk4aSFBuy6niIvb5cn7MEgAGVYssnCxMdF/pL
X-Gm-Message-State: AOJu0YwwuZaA/uJ29bxJANh07TGB4BQ49me9jPKo7lnsih30Drm8jD/G
	lm/nlaKJRtxmCFB3RDs30WlWKHHlR2p3d68o9hImynveruQGFDN+9V45bWsB3OVbyq9rTwdHFBR
	4gD1ZFbt+DHRjT4lnKWZ1O3ln6DHZwxbndDcb
X-Google-Smtp-Source: AGHT+IHqsH8u6qwFJLBhhqu6nDqLgqH34jJy4y2QgSKBLi1LsZ+No2szVtZGkUHRDFSFjzp+JHcGZ7kloKTfhDAvrLU=
X-Received: by 2002:a05:600c:4f08:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-4279976a51bmr1709895e9.1.1720712498599; Thu, 11 Jul 2024
 08:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709125433.4026177-1-leitao@debian.org> <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
 <Zo5uRR8tOswuMhq0@gmail.com> <CANn89iLssOFT2JDfjk9LYh8SVzWZv8tRGS_6ziTLcUTqvqTwYQ@mail.gmail.com>
 <279c95ad-a716-415b-a050-b323e21bec31@intel.com>
In-Reply-To: <279c95ad-a716-415b-a050-b323e21bec31@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jul 2024 08:41:27 -0700
Message-ID: <CANn89iLfpHam2pcha0R3Y8OBZiwsevDEM-kbhzB2Vv5UYgC7xw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device _properly_
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, keescook@chromium.org, horms@kernel.org, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:54=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 10 Jul 2024 10:04:39 -0700
>
> > This is because of the =E2=80=98const=E2=80=99 qualifier of the paramet=
er.
> >
> > This could be solved with _Generic() later, if we want to keep the
> > const qualifier.
>
> I tried _Generic() when I was working on this patch and it seems like
> lots of drivers need to be fixed first. They pass a const &net_device,
> but assign the result to a non-const variable and modify fields there.
> That's why I bet up on this and just casted to (void *) for now.

Right, I will clean things up in the next cycle.

