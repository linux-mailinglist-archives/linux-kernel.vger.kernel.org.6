Return-Path: <linux-kernel+bounces-257197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D5937688
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E841F21212
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A1679E5;
	Fri, 19 Jul 2024 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiLUCnqx"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4CEEEC0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384144; cv=none; b=MMsDQKt/5zzA4y/4Y5p+NbED9W5tG3fH2gSDQpOXl/l0z4lUgVbxQR00Ft67hJ29ftsj/XDISI4bpI3lyvMDHLuSdh811QULxLAEjxpt3+fEeWlPzNDQ6pTU3wYh7fz7/lbo/tzigqDBQlr+0mDu56sSC5V/mvXnXy7mwca9aN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384144; c=relaxed/simple;
	bh=Wn8Ba7KD2+L6bGve+NuxmCBMt18xZA/3TviLd33dsJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuZKBxLxBWUYNpAcfTs5UtLFOaTgtKbzO0h0fmEj9hpGRJlj8svQRIkDSpTjeiEs3w/DNp2j5sZH0FwGBXnczpWDl9qYH/PWByS83qw23GHCjF8brDQvp5pjm+pomhPRaZXKlHbFzx7H+mw70LmnFWClrIlznGWU4HmzDh3LlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiLUCnqx; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so24352241fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721384141; x=1721988941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD/NhfonoaA5s4lUItJI/2FWF/7nSqgzsVlJ0bSI5I8=;
        b=FiLUCnqxKxGgzNXa4ktP0FOpdweKFhncoOs2xMsOPlQLjen1vthwKM126BKIhLlRo7
         CXySHVJlWddmQ/hAqa7RpgAfe3rFyqwOKJoIbcGL+IPPexZF/Ie+ShocLlzZuLUbIEJ+
         5KbjlJz3lJkUgzQN2Y6BY5EQ7VOoyd9gdFUw1IMK9uxjS1YhNk9TUJ7inWXWWY7dWwbz
         5A5JOw4ReAIIWY7Xsex0Ypp/YwlfibsiIczOnwYE2XOVp2OVZfkwRSSiLOaW+gqykhTW
         49/+UZ6h/C73nc5M2UkuvhTPL6OKN2DOQHDsJF9knyTrvaQ5/iHiGrUuEFaSpGUVCOs0
         X0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721384141; x=1721988941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD/NhfonoaA5s4lUItJI/2FWF/7nSqgzsVlJ0bSI5I8=;
        b=MZb00dgSebKUd401uVxUKjkCkldFRp/gryGBJ15IAPQXLab/Mj/t9YNkv/0q8Auso2
         k/4Lam/YU1aYw2WgDhQqBZ0FHnnzoWfX++5n9l5Ztbp9DwUChDGbsfJXnmdoNP6QknHz
         daC/L2nKLBZsBZN8pWFYAVivWmA8xwNrEUWJH2T/JZ+3TynHYXzYBr5oap3/IjIyJOHS
         P+i6odvVA7VkcFmUvG94FAE9sOYbKo+zuVz/nCCm2vtD9LMq32ZdpHxHH1ZbcBt4fk6/
         x9rfAhaXhbd3VyfjPPK9BP/s87kWfnjjEAp22DfHh5v6s4w0UJm/stEzpfYRF+jI+2sm
         HXTA==
X-Forwarded-Encrypted: i=1; AJvYcCXBYVj3V3qQyaou+IiMEPwLAtTThrDRgW45JgdfVKKY0CesGL9G4tkBZslT0PcMlC/0P4+O7vv8UXl8VeuXn7y2bPVL2jFc3eTrdm2D
X-Gm-Message-State: AOJu0YzholhbHCW30/9eb3PZ/BzCTbBj0GRAJxiZX+YMuJ8Vh1hAL16v
	iykhYqZbduD2xQoB8cTqXdBtGF0qXRg/93JR/RxyQjbmzjhGJZvzADlgovid7TtCbRu8fEJ9l3B
	oUHenWMughiAOhdCkkTr1e2RKImo=
X-Google-Smtp-Source: AGHT+IFzw10BYcJOfdvoJZtYTcm2Gt0KuqeOvOaWGkbygxklhIPy2nIc7zHQXefmAC1uQUIGKIX1hy4eQbhbEhKkR5U=
X-Received: by 2002:a2e:9cd2:0:b0:2ec:3e02:9737 with SMTP id
 38308e7fff4ca-2ef05c552afmr39777491fa.2.1721384141122; Fri, 19 Jul 2024
 03:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719024010.3296488-1-maobibo@loongson.cn>
In-Reply-To: <20240719024010.3296488-1-maobibo@loongson.cn>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 19 Jul 2024 12:15:28 +0200
Message-ID: <CAFULd4bt5oiQq4_3jSDe+3P=1xtAhZ=34vLREqPVT9njjdWKSA@mail.gmail.com>
Subject: Re: [PATCH] locking/atomic: scripts: Fix type error in macro try_cmpxchg
To: Bibo Mao <maobibo@loongson.cn>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 4:40=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> When porting pv spinlock function on LoongArch system, there is
> compiling error such as:
>                  from linux/include/linux/smp.h:13,
>                  from linux/kernel/locking/qspinlock.c:16:
> linux/kernel/locking/qspinlock_paravirt.h: In function 'pv_kick_node':
> linux/include/linux/atomic/atomic-arch-fallback.h:242:34: error: initiali=
zation of 'u8 *' {aka 'unsigned char *'} from incompatible pointer type 'en=
um vcpu_state *' [-Wincompatible-pointer-types]
>   242 |         typeof(*(_ptr)) *___op =3D (_oldp), ___o =3D *___op, ___r=
; \
>       |                                  ^
> linux/atomic/atomic-instrumented.h:4908:9: note: in expansion of macro 'r=
aw_try_cmpxchg_relaxed'
>  4908 |         raw_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__)=
; \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~
> linux/kernel/locking/qspinlock_paravirt.h:377:14: note: in expansion of m=
acro 'try_cmpxchg_relaxed'
>   377 |         if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashed))

This points to the mismatch between "pn->state" and "old" variable.
The correct fix is:

--cut here--
diff --git a/kernel/locking/qspinlock_paravirt.h
b/kernel/locking/qspinlock_paravirt.h
index f5a36e67b593..ac2e22502741 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock
*node, struct mcs_spinlock *prev)
static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
{
       struct pv_node *pn =3D (struct pv_node *)node;
-       enum vcpu_state old =3D vcpu_halted;
+       u8 old =3D vcpu_halted;
       /*
        * If the vCPU is indeed halted, advance its state to match that of
        * pv_wait_node(). If OTOH this fails, the vCPU was running and will
--cut here--

Uros.

