Return-Path: <linux-kernel+bounces-219775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB690D7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F2289131
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716C13B780;
	Tue, 18 Jun 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HV97QNHt"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335913AD2B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725443; cv=none; b=RKnz7Wf1r9Am3QEZ2sTLpRx/PVgOCy7H2DiUUDWtxJKNFx+8C5PXhZP1PvvmL0RfWhG+B621OyAxqZaRzrdncTbGlfIOPNvFfOMliEut6YPvQyqVUEUAgErXigz5gnK+0yYMiiHpfkclrkSKV5rjs1Qa5beks9al0lp22rgNlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725443; c=relaxed/simple;
	bh=FAGlBqy4JBDt8y0wts2hlPUEXD7L16b572e1kQI9Upk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCSZVfvnX7rnjyKNHGTzoG8aYEDLINVUxdGsWlJCDLQiJwZn96rtbY5flqWjCZsQE34+EaRhmEWf9VLeC6AkXmoWfGNanNC1J0DAcuHcG0XE2n/qIhx8VlhdFFQZc9Zr5AMp5tbMzIBlO4k6KoCdqRvAvQ1YBBaIKndisvKNtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HV97QNHt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f9fe791f8so62195966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718725440; x=1719330240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCMSZa96o2nrKV3G9cdghkmIXburemNmuNpcxVHi410=;
        b=HV97QNHtNXVKXI0evqSctsPybgFNGhlrGpzH0XH3LdnNYjHon3q2pLuHKSPW5Tb8/C
         YzmWwbKeznA9OI67OY9eC/+/DO1IJ6MgLhvGWafxEqalvZwgVsTXm3LR2Ae1ZsTBWczz
         iN/QVWvJdywFZrrrWJsNu9RZnap2Dzp/EE/WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725440; x=1719330240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCMSZa96o2nrKV3G9cdghkmIXburemNmuNpcxVHi410=;
        b=oMx2VVRIysoIAR/6DOiepRiUpTGf34fz4JtIZ/4jz1ljvUOo1zLTBUlPkXDZZQyScb
         6/e5K+Vn3MzeTPaO+EhqF+pzvPWIZdkXi5UnpSg5URRezzEdlzSqsTa1rf+fQHfkOZG4
         +wCJSeMzmXnV+YruDzh0HCsaX3Vg1JpCPgnthr1S4uraSDH+a0/EpuF9NLP1iHfbkNo+
         TcMICckmxH7VmrWekF3KFWfbeFRiBye0n37P3/KvpJBeM37RwDYBPt5I4lS1mtVo+ZDo
         nbkhmPHegqPvNu5mNsP5agNefmgkMlekmD67tEXGIQoyA96Okwb47gXnEg/VVSQ3jcFq
         P/KQ==
X-Gm-Message-State: AOJu0YxxJOQ336MePwirD1Kev2unYgYIQhzqOkcy1QdWzPRpCoNKa9wq
	hYtV6GncAW+rAjzuidFGf08CcgcDhGoL6N59mCRp5rYv+pn1saM3O8g196qcePrfkEoL2VB48C5
	+04Q=
X-Google-Smtp-Source: AGHT+IGvUE/ktyCxW9Sa5SEtXb+yuGOhxSwB5BQldAsgZEOKYaMtpdSbs/KDuWRNd64gnRhGI5bf6A==
X-Received: by 2002:a17:907:d042:b0:a6f:9550:c0ee with SMTP id a640c23a62f3a-a6fa430f3f1mr15221066b.18.1718725440182;
        Tue, 18 Jun 2024 08:44:00 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db67c4sm629765366b.60.2024.06.18.08.43.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 08:43:59 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6269885572so1123201766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:43:59 -0700 (PDT)
X-Received: by 2002:a17:906:4903:b0:a6e:ab8b:aff4 with SMTP id
 a640c23a62f3a-a6f94e1f998mr181524566b.13.1718725439032; Tue, 18 Jun 2024
 08:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618105036.208a8860@rorschach.local.home>
In-Reply-To: <20240618105036.208a8860@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Jun 2024 08:43:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzYU-tOzxKg4f_i9G+D9No_r=uZ6g11w5UjkgfRZDf5g@mail.gmail.com>
Message-ID: <CAHk-=whzYU-tOzxKg4f_i9G+D9No_r=uZ6g11w5UjkgfRZDf5g@mail.gmail.com>
Subject: Re: Crash when CONFIG_FORCE_NR_CPUS is set and nr_cpus does not match
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jun 2024 at 07:50, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> I was confused to how rtpcp could be passing in a NULL pointer as it is
> a per cpu variable set up at boot. But I also noticed I was hitting
> this warning at boot up which I've been ignoring but now find it is
> related:
>
> [    0.128523] ------------[ cut here ]------------
> [    0.129275] WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:48 setup_nr_cpu_ids+0x11/0x30

Yeah, that warning very much means "you aren't running a valid config".

That said, I think FORCE_NR_CPUS was a mistake. It improves bitmask op
code generation a tiny bit (quite a lot actually on a micro level, but
not necessarily hugely noticeable in the big picture) by making
nr_cpu_ids a compile-time constant, but it's such a special-case
embedded-only (or "tuned for my particular machine") option that it's
just not worth it.

It's behind "EXPERT", and while that *should* mean that it doesn't get
enabled by default, I think the fact that many distros enable EXPERT
in their default distro config means that the whole thing has lost all
meaning.

If you start out with the distro config, you're magically an expert.
And when everybody is an expert, no one is.

                Linus

