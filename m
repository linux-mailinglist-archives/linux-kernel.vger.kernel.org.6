Return-Path: <linux-kernel+bounces-537048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C848AA4877B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8D63AD862
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF62080C5;
	Thu, 27 Feb 2025 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5KRmxFu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68E204F97
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679746; cv=none; b=T9rOLZNGLfn7zHe4uT0UUZ0FsfYshCkaecCQCQLg23NFSUzOHNB8nIelidbqyDlRRpoae7cO9jAqjWttepUHJUDOFZbtFGDHhki0KBi19Mdmw77sOL5ezXp2/ifb1ZX/4kNatJLmry4pg30GNM1JJtRotNs00ThqvvTN546/PCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679746; c=relaxed/simple;
	bh=4/Xr3wej8TUE8T5wN/u0PlwjcrTvIvfnsmloyY9RnFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KIBqb6gIGaSOKKMYq+V84JtC0dAQzpCx9aesPWEdniiZjvA+OepooMOUp+BMg/XaO88d7fwtIMi6tY9SCvUedXi4mvzCINgwQoeGEKDECGw4Sm+3SB92kdwPWH61mKOri0YMF11LXm6HlOZPIi3J0Mc6dji8QIq+FaL1E2nlEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5KRmxFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740679743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqdnzIjR0oX24eIpfJlWao42wwxz6KJgRk8C8nAv0p0=;
	b=h5KRmxFuZQBoSUzeLyC2prbgIDH10lVeLUJGG1NHgLfAXw23NDJOWfsOVdd4TJgFH8x/Fx
	wbbqrFMu4BOj5iIlKgWkErmYHmqWOkD71kuCMpwYqjxKGNn6piVQv9PL6k8FIrzxZE1dmN
	iiv2iLZ2GcQDdgb7XH9uaisnjC84uwU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-UWiIouZhOE6sfLxs4HC8Gw-1; Thu, 27 Feb 2025 13:09:00 -0500
X-MC-Unique: UWiIouZhOE6sfLxs4HC8Gw-1
X-Mimecast-MFC-AGG-ID: UWiIouZhOE6sfLxs4HC8Gw_1740679739
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399304b329so6310375e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740679739; x=1741284539;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqdnzIjR0oX24eIpfJlWao42wwxz6KJgRk8C8nAv0p0=;
        b=gWCVYlfEo7rUNqxk149lbGBilkyFziIlK0XCD/88NFs63X6+VTPIeTKOK3EaZYguGc
         AGsygh6tlNbVVJHRgaivyo8r20T/cgXwH3RyQWWI2xhZtuDLxmsyHB5EsdvuTT3PjDY+
         /F2QXbLfx1pB2eMiEkzYX946jzcgeBzzGawQToIy0qrtNUDNB+j3oVQ5o8fo1aA+BQez
         B/rW+D7QhwL3e22rlf0p5Mq/S+teiTQa3Q0Q94aN/2ai1Me9r7khY4gqCoynROa1m73A
         xNwxF1scb7E9QJPG+MrEwd3SwiGKPtRLKmqhMKeM4IQIvuZ22GMG8+rxUgk7Ts57dkKS
         EfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP7G6iDGc03CGr8sVA2CORi7VEmQCHTHxcYsDHs+wDdk3ucymNcKjzAPXKGqCMB136N8z5ViDl6hROu/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpo2iIuEir5Sm9KFlzZkXnRpfQ8B5xsKvroxS5lxRYUqJFwEtH
	WLy/ocXzUJLZpdl5hii3cZXkKTYSviXmXPLof1ko+OqizIb7kUqLpqzcblwDDdCVLJhp/0eMZYl
	PQUTF2JvRWqqIOgES2fzn9FdZ6axxD+wiKXt4yjN7KuIJNHiD8pOgVdvGgWzkBg==
X-Gm-Gg: ASbGnctcHYY8Y9dbXPtKW7J3Yp77Vl9NN5yuY6dasyT/j3Of/tN1gwnBsttzgeL8C0Y
	VyzrK+NILgo/0OxFMI0XZdd4r3aofJlTHkDb0rTsqf4QK6ZmoMGlB20hbLw2RLP7Auh0OznYdjC
	ST5shSYEA4dwP6FY9/5Bwl7sQuocomXJKOBl0rfDOOHkcHn8njhEdAhH88W+FEIyQ3W+gkYADmj
	r26KFegkWywyHrdcS7cWezFwePwFHzLzTQtDgo056XoeXckQjKKSpKVCiRLEfg09o7eatSI4Qev
	hdcIGS6+5Lurxfk56gkjjwP5R1CQoavRZfWiUhNmeBPuI71Tt2nDF86hnnhtR6xHFZB5PE/yAPL
	g
X-Received: by 2002:a05:6000:2cd:b0:38d:e48b:1787 with SMTP id ffacd0b85a97d-390ec7cdc8fmr192649f8f.14.1740679738919;
        Thu, 27 Feb 2025 10:08:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELTtvIroCPM+cKclSTstunMw/NXRJEd4YL271a2yNntKT36ErIWah+cBEzTYK3tA0K8Gj2Wg==
X-Received: by 2002:a05:6000:2cd:b0:38d:e48b:1787 with SMTP id ffacd0b85a97d-390ec7cdc8fmr192599f8f.14.1740679738521;
        Thu, 27 Feb 2025 10:08:58 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d12sm2815690f8f.58.2025.02.27.10.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:08:58 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, sstabellini@kernel.org,
 tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, kees@kernel.org, aliceryhl@google.com, ojeda@kernel.org,
 samitolvanen@google.com, masahiroy@kernel.org, rppt@kernel.org,
 xur@google.com, paulmck@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
 puranjay@kernel.org, broonie@kernel.org, mbenes@suse.cz,
 sudeep.holla@arm.com, guohanjun@huawei.com, prarit@redhat.com,
 liuwei09@cestc.cn, Jonathan.Cameron@huawei.com, dwmw@amazon.co.uk,
 kristina.martsenko@arm.com, liaochang1@huawei.com, ptosi@google.com,
 thiago.bauermann@linaro.org, kevin.brodsky@arm.com, Dave.Martin@arm.com,
 joey.gouly@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH -next v6 8/8] arm64: entry: Switch to generic IRQ entry
In-Reply-To: <20250213130007.1418890-9-ruanjinjie@huawei.com>
References: <20250213130007.1418890-1-ruanjinjie@huawei.com>
 <20250213130007.1418890-9-ruanjinjie@huawei.com>
Date: Thu, 27 Feb 2025 19:08:56 +0100
Message-ID: <xhsmh4j0fl0p3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 13/02/25 21:00, Jinjie Ruan wrote:
> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
> to use the generic entry infrastructure from kernel/entry/*.
> The generic entry makes maintainers' work easier and codes
> more elegant.
>
> Switch arm64 to generic IRQ entry first, which removed duplicate 100+
> LOC and make Lazy preemption on arm64 available by adding a
> _TIF_NEED_RESCHED_LAZY bit and enabling ARCH_HAS_PREEMPT_LAZY.

Just a drive-by comment as I'm interested in lazy preemption for arm64;
this series doesn't actually enable lazy preemption, is that for a
follow-up with the rest of the generic entry stuff?

From a quick glance, it looks like everything is in place for enabling it.

> The next
> patch serise will switch to generic entry completely later. Switch to
> generic entry in two steps according to Mark's suggestion will make it
> easier to review.
>
> The changes are below:
>  - Remove *enter_from/exit_to_kernel_mode(), and wrap with generic
>    irqentry_enter/exit(). Also remove *enter_from/exit_to_user_mode(),
>    and wrap with generic enter_from/exit_to_user_mode() because they
>    are exactly the same so far.
>
>  - Remove arm64_enter/exit_nmi() and use generic irqentry_nmi_enter/exit()
>    because they're exactly the same, so the temporary arm64 version
>    irqentry_state can also be removed.
>
>  - Remove PREEMPT_DYNAMIC code, as generic entry do the same thing
>    if arm64 implement arch_irqentry_exit_need_resched().


