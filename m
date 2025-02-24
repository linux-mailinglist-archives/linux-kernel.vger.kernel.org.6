Return-Path: <linux-kernel+bounces-529898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C307A42C49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDF23B1DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7E1EA7F4;
	Mon, 24 Feb 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yyjpECE"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395019C54E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423853; cv=none; b=UgXq2ZbMPxSUJpQRUksuH0xgTg2fvL4wDuoBLXSNEDwSSt108va4IF8uykv9R32Pi342kHbJ9oABdS2m94qXQ7uiXbFH4/rHTA+L1rGiJUGyNnXYiQxoSA7KWGeVNpxwPrw61m4F4qpCH1/LtTH3+Vfs7ksn8buu89yjeXhYm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423853; c=relaxed/simple;
	bh=a7KIxKD7aoeoZOqCkxW8MiXflXZAnlr6LQmmaXMfXYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2ve4s79VehvS004frG5KnkHshje5Z2zRRyPZyY4BrN3hYJchlzZjkooKREALUZkzY/vtmzgCxagqjNiyPVrkqp/aujKhWp7a5XHpe1w/S9I33AKwq2BzX72oc04KoAUb1UALitdxioxXtH51LQJGHeXjqRjt5Xfk570PLqGKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yyjpECE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so8367445a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740423849; x=1741028649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nSSnIUgykCsOJjoRoPgBIV/Do11WjZXMG8oFwcXmD8=;
        b=1yyjpECEC4FwpamKSMT98G/jqqz0XOq+OwoJdHIsFjHqkj4Lo+y22qQdFqgBX+0T46
         CUL89o4mvo8J28S+iULL5fNo8DgpecmGspw7puUVQ4Z5rmtzZk4rtuQ9F4rCxqZyscTc
         jgSg2n8WzivwS/HTvHS9bdhpW0WU7oZzlLMEU8+qWsPM3OHGMcct6Yk1japA5v3cT5Wx
         s70mLRm047ZAW2urgoRQ/XZJVw0y9LeBSvmz2J5P3DQDMOh71LFMwI+NvPrxzGFWvhye
         GsL4eX6LSTe+vfXwtMaJXXiRLYFPDtw8qnFxpD10o2e7qP6y75BCflNhfSzYLJroZdfS
         T+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423849; x=1741028649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nSSnIUgykCsOJjoRoPgBIV/Do11WjZXMG8oFwcXmD8=;
        b=KmJ2A4nflL3z41oAxaWHrk7v0nHHdL4qfjQmUftgfu+qtL0SjpzymlQ+7y/r52zqBR
         I8mM0mUHsgu2NeZbKkeWP/sRlNMSmM6OXpIJJNZu+PwPTPUBn7/L6+/Qdx+uiwjdJDjb
         KYL2rCa7sjbwudynGLpFQmYrTi+LuYOXSrYli0gPaE8EcvEXLfEYOIB1uDefTzgP6vkj
         5YCvXNaPjQ8SkVZCqtVjlIaJFuHYVgmln+vdSJkDcPNMbu/Q/XW7lc+DdBqDg82qNZ70
         utQNsm6fQ7KzOSQU4tSgFV+NUs7FcwmM5+7+WwT1klDU5VWJs4fIXhudBChkx/ZXQ+7v
         7ssg==
X-Forwarded-Encrypted: i=1; AJvYcCX34FYkwtDalubEkA36xtGq+VDwnB5bem9pKeoLouX0zCdMzsXI88Yx9vz543WHZYCo59GqHJNFW+cBjU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRniBNwpWtfQxkb34sWNSz0tQjeygYAwaDfdTF+5xjO1apZZQE
	E9BHQ5j427tL6A4vLed3/pS55d7rRolee0rDdbO5YJ102rE8qNuNBk1A1khjYggx4TQZ4nkwC61
	s9L+hDu9Q11IXuF5nktghv1R6TGZMZwYZM5nD
X-Gm-Gg: ASbGncsq/kAvyMrg7FgGKLE3KlCKpeyBMsQFlSDZBxkHAZBWhdzLTh4E9SpHv8AzvuY
	RkDFf/J+w7opUrDLCc9XhBZVEuejdzPKzPOpjnd0bXMAzBHUnCGio1kQr5kvQb9S1u5AfO1irWT
	3WL83PHQ==
X-Google-Smtp-Source: AGHT+IGgQflHbqJ4UhoDf/fk2E5dvSe6cFNlfrPYK7uSbM45dr7J0xkIHLkRgPNbQ8e5rSTMONtTWGu2Ja+QKsZlfN8=
X-Received: by 2002:a05:6402:26d1:b0:5de:572c:72cf with SMTP id
 4fb4d7f45d1cf-5e0a12b7c27mr19854821a12.10.1740423848811; Mon, 24 Feb 2025
 11:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
In-Reply-To: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 20:03:57 +0100
X-Gm-Features: AWEUYZnNdis7E0SVF0S-h6-AU7K1RTAWbc2V10Km6GwZSmwi5zbMocT2Sf-WWMY
Message-ID: <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
To: Breno Leitao <leitao@debian.org>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:24=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Add a lightweight tracepoint to monitor TCP sendmsg operations, enabling
> the tracing of TCP messages being sent.
>
> Meta has been using BPF programs to monitor this function for years,
> indicating significant interest in observing this important
> functionality. Adding a proper tracepoint provides a stable API for all
> users who need visibility into TCP message transmission.
>
> The implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> creating unnecessary trace event infrastructure and tracefs exports,
> keeping the implementation minimal while stabilizing the API.
>
> Given that this patch creates a rawtracepoint, you could hook into it
> using regular tooling, like bpftrace, using regular rawtracepoint
> infrastructure, such as:
>
>         rawtracepoint:tcp_sendmsg_tp {
>                 ....
>         }

I would expect tcp_sendmsg() being stable enough ?

kprobe:tcp_sendmsg {
}

