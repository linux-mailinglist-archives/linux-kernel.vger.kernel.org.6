Return-Path: <linux-kernel+bounces-227349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5D914FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F3D1F23482
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5CF14D294;
	Mon, 24 Jun 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JaE85CEK"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27513D526
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239141; cv=none; b=KU09JTycxnHdShbwCjoT1t+9wfZ00X4FiIL5j7oG/4pj8Q+b6cPHvgrsBTEY+cJh6hm7f+NtcQpuUdSAFi1gBZx3OP/aKJX5nJls4p7IsLJG2CNJWAayQzV33LjHbZE3gMPvVCS2vpiv6C0w+l4z0/6/0uE+4MF5wjLm7veYnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239141; c=relaxed/simple;
	bh=9w+SgEUo4YzWwo55bCoro5vgsSv1CzIfvImz5JftMI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLfjDp+31jEXA0IFH/C9D1LVEXqnAM8Ya+uJ/6VxnQXdTQoR+tuWNIPHrZzFBsGCNs0k3VKY4467wVaLzKIP9sliD90ir9TSJQUh+be7uNmkmkzgBkFeewsgErk3Z8wWBBPIbA/wXmXCgzueZqUvW8GmBjp2fQnlkK6l0O2UxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JaE85CEK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso7735555a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719239138; x=1719843938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/9kohSBG4FdkY1BWlsZbiSjgCXQ3rr1u7yY2MmJjbM=;
        b=JaE85CEK1ep481EyK2cpsbEGfinLbh8DjFaYc4MOdCQaspgK2t3Ip0JI3JcYb1iRTA
         4ywOS+hRxgi8YKazOeVNEpgKqTGcrjVuGOjWFeSZ7lMHVgM10KLju3k/M+JjTIXBjysl
         Zosp8E5Dk5exrPbnEiH9b5YJX5HHgrzpGE48Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719239138; x=1719843938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/9kohSBG4FdkY1BWlsZbiSjgCXQ3rr1u7yY2MmJjbM=;
        b=tkD5bHAuzGgDoW3/lldcsSRHQxZLr2NMnqoxpMah4wkPGkuRk8sXeEnd1JsUSwOjl6
         Kwo1KLwaCFYUtu3iFf0ob32OSHCFsuUgLESvwnIQfRi3vpPYemdGJ96ghOgHs3jwcT38
         8rPFS865GKX/apifb8q5W0g7cPiZkzhNTjfd2KJSR3huLNga+LBlFGeBAaIHw23+HjVB
         qWP15EpDsiZAn7THW0xeLzbuPxe8nGkLxHA5F3HOTiAYAMnyN2ZJA16Ad8FCsgCvyxg3
         J4jp+6RBxx4G32pX284In6WFfKoJmdjNwESeQwwU3JlOKpiAXqzmVnHNwCY4ZQ+h98xT
         htDw==
X-Forwarded-Encrypted: i=1; AJvYcCWHDCBaC3jR7b94OZYhTmTnQBVxITiX5Uy56cX/HxD8umg2KDB0N2k03xMB4JTdj2WyXB95uFMcmXsKSJViK6QQvqkyW+PZlRLY26jM
X-Gm-Message-State: AOJu0YwNfkh/HufIX75udkdlAIk7RvHM051Yl4ilcHgad0iaSXRD8u8a
	V5GsvsTwYUIk3I/fwGVlsJrz3iNx2SwZZpdsRrBShZTH/pzahv8Zy6niqp52ci7sPOn6H0DNHBx
	B5JH6yw==
X-Google-Smtp-Source: AGHT+IGMQInL4PPNCGFlJaYDeRQyfjkLNi6U23JLkmxgwDygH7HRp/K22DwYua4uKz3KCLnuvBn9dQ==
X-Received: by 2002:a05:6402:3593:b0:57d:5442:a709 with SMTP id 4fb4d7f45d1cf-57d5442a847mr3648846a12.0.1719239137999;
        Mon, 24 Jun 2024 07:25:37 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303da378sm4682986a12.18.2024.06.24.07.25.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 07:25:37 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so895366866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:25:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjBw+fy0+7ZgTVJHbAK+XHo+0/7icakL2/9nsRfS+R8JILArUM+svuXx4NkoCZV7xzyVLNpBlWQZFkLQyxgqzO/YLowqPmHhqNIqsQ
X-Received: by 2002:a17:906:d103:b0:a6f:6f98:e3dc with SMTP id
 a640c23a62f3a-a6ffe39c94fmr534258666b.10.1719239116553; Mon, 24 Jun 2024
 07:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501151312.635565-1-tj@kernel.org> <20240501151312.635565-20-tj@kernel.org>
 <20240624124618.GO31592@noisy.programming.kicks-ass.net>
In-Reply-To: <20240624124618.GO31592@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Jun 2024 10:25:00 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjWaMPF7d=BDicVk_+DcYYf5tfKbuK+_Mi4QvNmyeKS1Q@mail.gmail.com>
Message-ID: <CAHk-=wjWaMPF7d=BDicVk_+DcYYf5tfKbuK+_Mi4QvNmyeKS1Q@mail.gmail.com>
Subject: Re: [PATCH 19/39] sched_ext: Print sched_ext info when dumping stack
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 08:46, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Also, if we consider 2s complement, does the above actually make sense?

jiffies_to_msecs() does not work on 2s complement. It just takes
'unsigned long', and just considers large positive numbers to be
exactly that - not a negative jiffy.

We have a separate jiffies_delta_to_msecs(), but that clamps to zero.
So again, it doesn't actually work for negative jiffies.

Side note: jiffies_to_msecs() seems to return an "unsigned int". That
seems a bit odd.

             Linus

