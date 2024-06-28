Return-Path: <linux-kernel+bounces-233250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FDA91B4D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAAB2825AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2391818C31;
	Fri, 28 Jun 2024 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+i5WErj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0C182B9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539834; cv=none; b=YmGzDCI0dAmvuji01mS6bTs0UWTOwwHKeB8mMzQzG3xlaXn81rOA1i4BLTLURciDjFXdwg/h7niucPw4HXLYABxcwibtxK0dMWJfOmhPDWtMbDgvjumX1GRbs98EQ+nmZgg33ANY3G74I1CquLeR2ejhJ6qzbv88hJeOGFv5ecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539834; c=relaxed/simple;
	bh=o9QsUi5KtANJWutFcD7dBh7rGe1woug+fHjH+SEn1zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQUTmPuowu+XlqEKsItd3P+s0ZfoanmFkb7nO25tR6zMgDLrx7hFxJPpHXLvYxjrPM//l2wSn1MY+o+zR3UBC7jusI5kqXmq0QbRceRSAuLpvLuHyr7sTF7fDwTmKAjxi8av2XmJXdvMLqLBs6K1V72S7Cle5b8VZS72ngaGIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+i5WErj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42566fb8302so925015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719539831; x=1720144631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdaZAQ4HUfDefTlEP/hETeG6fjoJctZ5CIj5rBpwQZ8=;
        b=d+i5WErjpSkUD0B6A13Ze7vbqimFnZLTdHbnQi3JQ1GR3eT7AY1YDVYnRF7KkzAPAC
         vm2XrfLJCbepJH+kMVSieTrfoCfnpT9hs7RzWNyZzhKgKnR54LHB++evccOK8oILZuDJ
         p2k0iEIBB5x1yKYa/X1a7l4FdpEWUmNsNGOygLScw5JivbgIlmotDlc7b6o+c7uTxu7p
         YOXugvucqcjRNq0mCbIFOfK2q9jvKKzth4rCt8JpO1Y666Eq47zY/tl4/70TNSau7nfM
         kumBq/9AHWvHzHHbZeAbiW6tqeufga3nafn6sVvtspjqZDbjFNw/xF6ojy/GUGdA5mor
         pz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719539831; x=1720144631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdaZAQ4HUfDefTlEP/hETeG6fjoJctZ5CIj5rBpwQZ8=;
        b=UVUzTCZu4yBv+EO0EkUeKDd8HbXclpaMq5s9LYBO7aULsp25eC59IWLJjNS22XJJZ0
         ZSzEU82rAJCUGs7MDjWtQcmLAbXILQ+wFPCeEccEeOr3EmBZ36T20AP180A2VuHjept2
         9DB5usy8rrIQHsxwTeSTUIh2Xyng04E5imQUxH+Zv9vw3eufEBQM9h701QiLA73pO/rZ
         qEJmsfwZ+2UyBp7wdYVjQ8bu8VA8b1Vq59GJRr3F7XIH6SogqlKpFWHJNcAf52BioIFY
         Etdk6Ym8i+7MLz+Mh9U8VE5M6vL2J9rcJfkEjrhtkuAwnrJHbdg6DAHPMh3BbzWoLlyD
         7HsA==
X-Forwarded-Encrypted: i=1; AJvYcCWinzqB5ww3UmELqUGqNRnPNaXPBswykBx+8mcwVXxSKN6zSbaovw9mtkLs0S8jVzCviNLN+whkVsdAsI4nETaS67UgxtIkuoaNTIey
X-Gm-Message-State: AOJu0Yxzsi5zSgv/9ZrnHhbwH+KfqFDIeEc8aOGbvsYoKlZtQPLi6B87
	0zDk079kmemWGVTmhBYTYH6vZ35w8GM7PvXbpyQ59DmUMYJkLLlYLvnuN87GZdZ+GIn7XfQ9MHI
	RP2wgHfMl4te7JYuAr5HPvBQorok=
X-Google-Smtp-Source: AGHT+IFxDQmI38oeRBR4XQAXWc7unx8iXVMbz34yb2r8JYQiDryeUNTed9LBi3xKXVW26JB4DEdf1BSzDPQJTaV7eFk=
X-Received: by 2002:a7b:c3d8:0:b0:424:a48f:4fe0 with SMTP id
 5b1f17b1804b1-424a48f5086mr60335445e9.26.1719539830891; Thu, 27 Jun 2024
 18:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rMfRmWoYdsyH6ibNKN8DSCL_DO8Wa08mWbe8t7vH21Dpw@mail.gmail.com>
 <86pls2isal.wl-maz@kernel.org> <20240627101207.0bbbead0@rorschach.local.home>
In-Reply-To: <20240627101207.0bbbead0@rorschach.local.home>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Fri, 28 Jun 2024 09:57:04 +0800
Message-ID: <CAJNi4rMiGGDHUO1L2Tegj8apwMmdbiCBS6UJfcNGKVfNMdBJwQ@mail.gmail.com>
Subject: Re: Will smp_call_function_single(cpu, ...) broadcast IPI to all
 other cpus?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, will@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi M. & Steve:

On Thu, Jun 27, 2024 at 10:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 27 Jun 2024 11:38:58 +0100
> Marc Zyngier <maz@kernel.org> wrote:
>
> > You may want to enable stack trace recording and find out for yourself
> > where these ipi_raise() calls are coming from.
>
> Try trace-cmd:
>
>   # trace-cmd start -e ipi_raise -R 'stacktrace if reason=3D=3D"Function =
call interrupts"'
>   # taskset -c 0 insmod /kmods/ipi_test.ko
>   # trace-cmd stop
>   # trace-cmd show
>
          insmod-3169    [000] ....1.. 51869.953886: ipi_raise:
target_mask=3D00000000,00000ffe (Function call interrupts)
          insmod-3169    [000] ....2.. 51869.953887: <stack trace>
 =3D> trace_event_raw_event_ipi_raise
 =3D> smp_cross_call
 =3D> arch_send_call_function_ipi_mask
 =3D> smp_call_function_many_cond
 =3D> kick_all_cpus_sync
 =3D> load_module
 =3D> __do_sys_finit_module
 =3D> __arm64_sys_finit_module
 =3D> invoke_syscall
 =3D> el0_svc_common.constprop.0
 =3D> do_el0_svc
 =3D> el0_svc
 =3D> el0t_64_sync_handler
 =3D> el0t_64_sync
          insmod-3169    [000] ....1.. 51869.953897: ipi_raise:
target_mask=3D00000000,00000ffe (Function call interrupts)
          insmod-3169    [000] ....2.. 51869.953898: <stack trace>
 =3D> trace_event_raw_event_ipi_raise
 =3D> smp_cross_call
 =3D> arch_send_call_function_ipi_mask
 =3D> smp_call_function_many_cond
 =3D> kick_all_cpus_sync
 =3D> load_module
 =3D> __do_sys_finit_module
 =3D> __arm64_sys_finit_module
 =3D> invoke_syscall
 =3D> el0_svc_common.constprop.0
 =3D> do_el0_svc
 =3D> el0_svc
 =3D> el0t_64_sync_handler
 =3D> el0t_64_sync
          insmod-3169    [000] ....1.. 51869.954145: ipi_raise:
target_mask=3D00000000,00000080 (Function call interrupts)
          insmod-3169    [000] ....2.. 51869.954146: <stack trace>
 =3D> trace_event_raw_event_ipi_raise
 =3D> smp_cross_call
 =3D> arch_send_call_function_single_ipi
 =3D> send_call_function_single_ipi
 =3D> generic_exec_single
 =3D> smp_call_function_single
 =3D> run_smp_call_function_test
 =3D> ipi_lat_init
 =3D> do_one_initcall
 =3D> do_init_module
 =3D> load_module

Ah, the first two IPIs raised from the load_module() ->
flush_module_icache() -> flush_icache_range() -> kick_all_cpus_sync()
-> smp_call_function(do_nothing, NULL, 1) chain.
Very powerful and great tool :) Thanks guys!

> -- Steve

