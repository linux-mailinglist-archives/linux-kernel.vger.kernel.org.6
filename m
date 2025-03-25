Return-Path: <linux-kernel+bounces-574671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14150A6E84F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896E53B80D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704DA178372;
	Tue, 25 Mar 2025 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bl+nXr0c"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B088CA4E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742869496; cv=none; b=K8A0zG5Plnn0FQv74N9ULHXH3K2hnSdveVQ8rf+AFQTbxISTLZV0moHzCh+OF+Z85RHPRsOwHYSuSqItr+t34DKvYya5YVj75DWyq2omQhBmpBMDzLUPbq7kIVFuEp+JITw9cNJYOu692CBoWZG5v/3gAEhdCPKu32AI38a4YSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742869496; c=relaxed/simple;
	bh=tPu4PoNTvOpCZmOqaRYVZs29TsR2s4dj9lt2lmCaU9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpFAiseOHGb4VPxCKLlx5ht7GKt+YaySckp8yn2o1RnkF2A7B0mXwWG7IrRqcNACxkpyGe6tVn9T7Epp0K016sKFy7HazvSduExgffgWiJS0TkArPNAxN7YTLxjdPofk9L1pHlBOkV924uCbrRX/eMdd3xdqM95ABuAY4A+Nsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bl+nXr0c; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso5528a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742869493; x=1743474293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPu4PoNTvOpCZmOqaRYVZs29TsR2s4dj9lt2lmCaU9Q=;
        b=bl+nXr0cDic/fy6DieanwSHylZTzAtaX31tyY8nV16E4TCOSZEE9J7pJz+yb+v6kfR
         a9teJpjLPIl6vd4+D2Dk7Fm25K+LkgyAkxa4tfxB7sL9SMAVJbFJS7AaEwdi3DzZcY4s
         lulZ0pbD/11XdGnZyxk0DNHxYWkSAQrw+AJCkeynE2hCZuuzBgdH51ttos8Zrx0yBvEu
         RokSA3WiljCgsZPxKT/Tpb/LAETvBxZYrV5o+iUrslIBQkTV9Z190f+ljVHhtfIqeWhW
         H6sLmFssvX2+EhAsVLMTJXBRhPmmc/DoFysqy4L/7d+LhOyQiLf+DiHZZD5AQkhIMkM5
         jLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742869493; x=1743474293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPu4PoNTvOpCZmOqaRYVZs29TsR2s4dj9lt2lmCaU9Q=;
        b=cwDU3JjQWY2c9CAbRTwWhbc0qu4Yf0omq/nCi3tzJMIa578ZHCeM0IvlLP6mm588eH
         VfcY9jbyiX6NHkJHvcTz5Dj4Uq3tXGRz7AySYLFlnYP8AvMZx/13nDRFdaoYKP5643QV
         dPaNeNhc74i3xmMbP4HIYzrbxKjx7CqwVf8B6D5vW7G/4IEYvMI11lcwPUtKV60L7irK
         F+Rye8gZsQ48onR1+zqg5dykWkj0cEXP3Ot3gcux2GLi7etci6IRTDhQt7yziOGnbJAO
         2tJUXDfsubDnVTQyiBkt4mbjAjEM5JO5zPxW7zulSArMUgU5jkoDfXi4WsmwBfXCA2PG
         Kg/w==
X-Gm-Message-State: AOJu0Yw09sijn+VGwafSsEi+2ot0fYk83uOPNMCDnMCXTItr27DB3HEj
	12JT2/uUHQkDcAyA8q/bGeSy6+NdsMLYQjHP/umoQ3/jelIGePjn5QkDTtaeWh8fII6T6n4DvKL
	r+z1pqMKuO3dJkNEiwiXPsow1mT9aMWqthsFW
X-Gm-Gg: ASbGncu9c1M29xL5GAl/YfEHhmtERH5pocRGyXkHvS4kDRpHU1oivwWAHYwDwg5MqmD
	rf0JdJuRw9F+u3ljgTeM9QnHUJXm9PDy0rG2Ptpq4nuzmj8necDdNyLA5l7HyyCQUIYlDKuoVey
	nTD2Rnuo7RkGarfk9k8i2W783p4qAKl1arY6ZvsSES/1geGDg9RoNpM/MJPkngthV7
X-Google-Smtp-Source: AGHT+IH7o8kr1tk8DgEOjQsu3Lj8O1K/LxJznAnKKgVVncNcVNxeOD0uk4/nTtqBnOG5i9IhvljwaFZ0F5ibT19la9A=
X-Received: by 2002:a50:bae6:0:b0:5e5:7c1:43bd with SMTP id
 4fb4d7f45d1cf-5ec20b280fdmr226970a12.1.1742869493232; Mon, 24 Mar 2025
 19:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-2025-03-unwind-fixes-v1-0-acd774364768@google.com> <20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com>
In-Reply-To: <20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Mar 2025 03:24:17 +0100
X-Gm-Features: AQ5f1JpLG3AaHY66Jva60DeVx3Vb0fs0V2MwzwZh-_Y-IzOlu35XZB0L0VrkI5I
Message-ID: <CAG48ez0=dtR85yhy07jqvq9YC__3ocT_N_hpJMN4v-FfMs-PsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/dumpstack: Fix broken unwinding from exception stacks
To: x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	Dominik Brodowski <linux@dominikbrodowski.net>, Ingo Molnar <mingo@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Vernon Lovejoy <vlovejoy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 3:01=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> Originally, get_stack_pointer() used the regs provided by the caller; aft=
er
> that commit, get_stack_pointer() instead uses the regs at the top of the
> stack frame the unwinder is looking at. Often, there are no such regs at
> all, and "regs" is NULL, causing get_stack_pointer() to fall back to the
> task's current stack pointer, which is not what we want here, but probabl=
y
> happens to mostly work. Other times, the original regs will point to
> another regs frame - in that case, the linear guess unwind logic in
> show_trace_log_lvl() will start unwinding too far up the stack, causing t=
he
> first frame found by the proper unwinder to never be visited, resulting i=
n
> a stack trace consisting purely of guess lines.

I guess the subject line is kind of misleading - maybe "x86/dumpstack:
Fix misplaced assignment in unwinder" would be better?

