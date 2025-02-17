Return-Path: <linux-kernel+bounces-518108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5BA38A10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2A418945FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3E225A4E;
	Mon, 17 Feb 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5WuWEw5"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE3215F40
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811112; cv=none; b=XF4yHMUm4RI+RbIJP94vzPuOpk++7j8UbDGieO/xHIiqW4/00ibEloV5LCK3UCXfbxi/+cXlxay4Hlhcd4qS91WmRETtuHavxjI509MBFrPaxBv0x/YCSgq9Yhemk7yyw/HN1UPFbKqC+PdM54+8Eqt78SBuD92kwr51O+/Elx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811112; c=relaxed/simple;
	bh=i4kh4fE8tCNOERxMZKCNfd+nwooZ+CoVsb2/7WEDgPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVFf0KaW6ucPcZNevIg72vIbPjjfS+dUhc+nJh+OliewE+DKTHznIYFsvU7cvqe/56EYwa2YAAL4Imto1mbnr5ZMaBv6lRLpMRtw0Gko0oOZRS/p+TK4eofQs52HMpFYNT0q29/DXXS9La6tajco9B5pSji3ACReNXxRzwDzkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5WuWEw5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f3913569fso1082932f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811109; x=1740415909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2oH6tzTSJsdgiOYfb4nxFSWGTiJy2ivK4rT2/V8PqA=;
        b=P5WuWEw5lvtQkXXPRXMC56wRJc/naX9ozoQlLHJEeGbs0+pKMgRyBSnSL3M8CdUxrT
         E/ZlYgo/sAtjCGSI7nFK12ClB4gp909b3WJuTircRULGhredoDoghBbjPMbycFm/6Lej
         MY3h8DD2cD7kiBQ/Bac+STMpi9bzJV0n3i9R99tffVgx0Wx7yYnrvvW1HjvRzELxskkc
         t8bFDCq7dK2xHx82vuOQQycFD6q6ZK5swq9VpSfz/GPbf6Ao6AgKmpxa0o6xDb7z9iXR
         pZsu9+/zQIMQKkC+oZt8wGxqN/ZWGloQBun3M8zGiSkBmyCsJuMY7yWbW5P5KiYzyt3G
         ZhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811109; x=1740415909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2oH6tzTSJsdgiOYfb4nxFSWGTiJy2ivK4rT2/V8PqA=;
        b=gDGJt2tkOXcMIiHbaVeFkDIFO0hTCjxUo4yRJ1ZxAi+YiocT9SD1JCpW57DN5wnYI6
         lZ46ESl9UHIIfqiDClTF03Vthv+VBs6s9DX8aWtj4RI5u9YvbhoEXAW8J83axRbu8Bn6
         OdNpqlDVWQSrDhgnYBzFINFDSD5VtwEWhqWGpd/IsgKiA4PsqvMF4+krOA4EEbxakdCN
         oV17Xw6zwDFhC7f3TUTwTUtHiMFX3RlcWW7AIwCPOKh+Vmh903aleTkLUhx1fg0/kypv
         eAukBDB3zRzATggau0/EnnP0zQjM6vwiTkiqK6+Z0IIzNtslcaBQe1FtDL+PCcT7lV5+
         Pjew==
X-Forwarded-Encrypted: i=1; AJvYcCX/iWuFWUSQ+YNSrv2KZmKze+b05TaXLxDY28zAGfhYfXvrSWfbszFr9wMgBQYDnRs8qWiI5nzjahgakvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8iOAJkJOhHhXxixMC2TEc4R6dHFJFRIOf6Zof3IAoYnUl2+7
	De9SXhEehg/WPz6msfanoyHxdNimcbZSd/HVmCd7WGo+PVxJMWU70D0P244kLP5Dhm3CydCthKN
	JQHewnUUfp0u8iNu6k3mdjGm5vRw=
X-Gm-Gg: ASbGncvY81zpLr40pDv9E3DmUe3ilfPyudrEyE/wQF0LayRPRqWZ3ASQEkBb/vqCxGb
	V+Lovnav54k3ilbWvbyNAh1qINt1YK0YSvVcm3zRJDykjEiFbar7Kc45CPr/UoIg61dKeVqvGOs
	g=
X-Google-Smtp-Source: AGHT+IH0o4dLmtlknXlvC/OTn8YRpOAPkYUuYHzk774gCCCS/YCqn9aAJxQI0mTGtmb+b5LT3ywCjvU5rzNhsO+V6Ww=
X-Received: by 2002:a5d:64e6:0:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-38f3398735amr10306508f8f.0.1739811108606; Mon, 17 Feb 2025
 08:51:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213200228.1993588-1-longman@redhat.com> <20250214195242.2480920-1-longman@redhat.com>
In-Reply-To: <20250214195242.2480920-1-longman@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 17:51:37 +0100
X-Gm-Features: AWEUYZkOL6ftniWInMbuFfxoX1PJLv06k4--glS_oxL3qhOErs8KcVkmUmvHj7I
Message-ID: <CA+fCnZe=LD0h-0F9tQ=7=b3JbNEfEbp3C7j4w18nK3gAs3Ac9A@mail.gmail.com>
Subject: Re: [PATCH v4.1 4/4] locking/lockdep: Add kasan_check_byte() check in lock_acquire()
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:53=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> KASAN instrumentation of lockdep has been disabled as we don't need
> KASAN to check the validity of lockdep internal data structures and
> incur unnecessary performance overhead. However, the lockdep_map pointer
> passed in externally may not be valid (e.g. use-after-free) and we run
> the risk of using garbage data resulting in false lockdep reports.
>
> Add kasan_check_byte() call in lock_acquire() for non kernel core data
> object to catch invalid lockdep_map and print out a KASAN report before
> any lockdep splat, if any.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/lockdep.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 8436f017c74d..b15757e63626 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -57,6 +57,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/context_tracking.h>
>  #include <linux/console.h>
> +#include <linux/kasan.h>
>
>  #include <asm/sections.h>
>
> @@ -5830,6 +5831,14 @@ void lock_acquire(struct lockdep_map *lock, unsign=
ed int subclass,
>         if (!debug_locks)
>                 return;
>
> +       /*
> +        * As KASAN instrumentation is disabled and lock_acquire() is usu=
ally
> +        * the first lockdep call when a task tries to acquire a lock, ad=
d
> +        * kasan_check_byte() here to check for use-after-free and other
> +        * memory errors.
> +        */
> +       kasan_check_byte(lock);
> +
>         if (unlikely(!lockdep_enabled())) {
>                 /* XXX allow trylock from NMI ?!? */
>                 if (lockdep_nmi() && !trylock) {
> --
> 2.48.1
>

I wonder if kasan_check_read/write() would be a better fit here. Those
are intended for the compiler-based modes and are no-op for HW_TAGS.
But I assume lockdep will access this lock variable anyway, so HW_TAGS
will detect memory errors.

On the other hand, detecting a bug earlier is better, so
kasan_check_byte() seems the better choice. And lockdep is not
intended to be fast / used on production anyway, so the extra
instructions added by kasan_check_byte() for HW_TAGS don't matter.

I guess we can change this later, if there's ever a reason to do so.

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

