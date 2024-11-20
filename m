Return-Path: <linux-kernel+bounces-416074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BEA9D3FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2BC2849FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75F1514F8;
	Wed, 20 Nov 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fhezj2jX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAA141987
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119329; cv=none; b=l86+xYrHceh3M9gYa4O/M1uRU89jmNCxkMRZf3zP07rMWFTRoGnw6WlZ6CW7f7afr4qon6+noY2l+HmOXiTh4iZhcJMk3MzLe0bpwqIydJeOASWPjwCcd2p9L9T4Tsb58Lwk8Ooz3WSSoS+8i7BRWT+yZ3yKBo0VtXHspLQXg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119329; c=relaxed/simple;
	bh=VNWYPyllDhn6wyHA8vHCBZcrdTpypW9KdBxrUGgTSiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lRmKzLrnBt2joHvZBh8nxhaqv3map3k403QCyp2jUYgbWjHaOIY74Pv+mgM5eOY55V4ShvFoZNZqBok/7pI255iKYxQZInk/6t2RC0bzqiVkazS9f6goPfRUBsz8QIYnRK7wiIieFWFXCWF7AwgfN3mzN8aqvalUYC0CL9AESkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fhezj2jX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732119326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s9neiNV5Ecw1Rm63FFkLc6Zp+LPvspTbTCjcardEBqA=;
	b=Fhezj2jXn7R4d6ndULg5zE43osuCLMh5xKDTAicP8shjBDavobsODvM7R/sjS0hFRTXhKl
	FF4kvX6Zt+7aeJ/CsgStV/BafxlyLbuiNHguNS6eWixJx63g/DCXPhlZRYV2fc1MaOo1Ij
	BfgMQN5WwMCE58El+i6tIvE251jtIEY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-gZa_dz_dPTCJkvPO6n76_g-1; Wed, 20 Nov 2024 11:15:24 -0500
X-MC-Unique: gZa_dz_dPTCJkvPO6n76_g-1
X-Mimecast-MFC-AGG-ID: gZa_dz_dPTCJkvPO6n76_g
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d41a3c9c9cso33772666d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119324; x=1732724124;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9neiNV5Ecw1Rm63FFkLc6Zp+LPvspTbTCjcardEBqA=;
        b=LvHft6W8LLqSfUIU5T+Gr3FYpnkbeBYhtvzsNGHk/+fZOdSOeFshY7Le9genN7hD2j
         WjzDwJnr5qwMDaLp00z70FaK3gynRXSjj/Wv322Qg8bvaWNdsFWeV1UsyFm71Mu3gUa+
         OqeWVu0BiiJqB5clVNHVaIgzWkGQjDRqUxFZ277zEksw2+Bx8yYT4T9Do+etWXbiXXqB
         gNNNYoDCtJikVy3HfAqq0n3T8MgOfXhFMUrfnGgexoSMxO5pymNOfUYNoCQsPJVFH37Y
         abj3F1IBdVkG5j7eld/XHsDyZJIdm8a05/3SZXLf+2q68pNQyMOL6/SzC6LEnV2azLox
         eR3g==
X-Gm-Message-State: AOJu0YyTlhptqT2ZgLbEMjNRNNXOZLNn4Llpl50EPjJDogNwvEDyraxC
	mEIaTyMKOcZoQAO2GUcdr5bUi7aAYY19u2KzbH+Ux/LJhHkDKzcgb6b+ZHDu5RO+hIjHC8uTFVN
	60RcpHWc/ykoVUHb1LKCzsPmXl34Q9Xz9qHUa8z5+oSVzzWdZSP+7LvQPzVWf3Q==
X-Gm-Gg: ASbGncu8SoV3coj+5VXB8DDXci1/qRzftwtzp31kXc4dwF+8FIQZYv6ZiH9uq1qt08A
	2vqM8SEkbTQTV1P5CLRouBpnW9KP9b3xWuhC3J8WZiVmXzwN9u6MSoYtTGZvNPFqXpvVbf/bQbF
	86fIt6P/MZRlNDqIC/tRGze9LprfjGT6SESYJ0icXjGM5Vz54V3BvlZlCuPnc41G/HQYDVT//m7
	q2k88va2pS1IXY7GYTI4sv+x4r1ngIBBHjRmtf/vd7bkIFV+nYuERRx5nYBmCGC+IJMmwcQv3d3
	CUeYb0PXyGP4ejV/A1akbc8RFjGbhfjJS7Q=
X-Received: by 2002:a05:6214:2aa7:b0:6d4:1f86:b1f2 with SMTP id 6a1803df08f44-6d4377bd8bcmr43340386d6.11.1732119324028;
        Wed, 20 Nov 2024 08:15:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErytLY/ydBtG/c68cV9sB/Rs0q2MHssCkf2mLl/ZoHSY4DaUVm1Hfo6p7yhhfkcknSTmK2WQ==
X-Received: by 2002:a05:6214:2aa7:b0:6d4:1f86:b1f2 with SMTP id 6a1803df08f44-6d4377bd8bcmr43339716d6.11.1732119323729;
        Wed, 20 Nov 2024 08:15:23 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812ab67sm12352206d6.88.2024.11.20.08.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:15:22 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel
 Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 04/15] rcu: Add a small-width RCU watching
 counter debug option
In-Reply-To: <20241120145049.GI19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-5-vschneid@redhat.com>
 <20241120145049.GI19989@noisy.programming.kicks-ass.net>
Date: Wed, 20 Nov 2024 17:15:14 +0100
Message-ID: <xhsmh1pz5j2zx.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/24 15:50, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 04:34:51PM +0100, Valentin Schneider wrote:
>> A later commit will reduce the size of the RCU watching counter to free up
>> some bits for another purpose. Paul suggested adding a config option to
>> test the extreme case where the counter is reduced to its minimum usable
>> width for rcutorture to poke at, so do that.
>> 
>> Make it only configurable under RCU_EXPERT. While at it, add a comment to
>> explain the layout of context_tracking->state.
>
> Note that this means it will get selected by allyesconfig and the like,
> is that desired?
>

I would say no

> If no, depends on !COMPILE_TEST can help here.

Noted, thank you!


