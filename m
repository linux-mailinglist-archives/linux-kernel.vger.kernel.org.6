Return-Path: <linux-kernel+bounces-335425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A59797E599
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF904281469
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACFE11187;
	Mon, 23 Sep 2024 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlpHXRzW"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2F28EB
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727068848; cv=none; b=ANruqTb9Iz0Du5+6sKjQstFTEidQ+N4XMPgTWSGgCWcfB0qVCm5BrjzrOCpxzldxw0Lox1+DS7CSOLH2v/Rsw5Mbnfu8KW/96CW4fA3ovwRQVtko5lfpAWs+G/pCi6hVfzzxIodo+1GB2z7owRMzmvDqOyP9AItHklry6Tpvz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727068848; c=relaxed/simple;
	bh=uqn3cQMhfaV0KwCVWFayJzV7U/7lVl30UA8M6UaGhHk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ctcz4FGQ4GKcaT+bC5MITl3wS/gRpqamo4r+UgAP8sfr/QcC9N4wY5bx1XXsH7tC3b/Gc5lqCNv2pNHaOuhpoT5z7vblmB6ohFbeOWtZbQ0z6lhjvT8Fl39HoOTImn00fvc9/gTAdX1DBrpymDMXa1H39uwXffw3iHRsOHtlkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlpHXRzW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71971d20a95so2624847b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727068846; x=1727673646; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x7Q3h2SawaWR+sw9PYfDN+KcfCiaOHpGieRaMWQOs6Y=;
        b=AlpHXRzWd+soOBUobh7E6rY4/OSa6ggMLLxrdQZ1d5Ae05l78Fe9M/bku2IbFs41kV
         AyQ6j00hHhCZIBOEGljM0tzuSRe+oS6VHkgFS2MakxCyJq0if5ASHVkN+DzmKx09wbIs
         kbQu7eXnlEhzzjFbnsXHHgUOl9hFx1UTRN2B1NUK5fGU9uW96LWJqcujfNxFcYeVeA8o
         67WoFQYGIdKTC9OBovfd0xIAmFOg8WQ+BHPUPi+8EHmqLNA+w+CbqMhmoVlDADp4hkLW
         fqoKbsR5DwIoyZVzkiCMTLwSUEB1iiKGV3mYaMbapDRIlAck0dOHiyZ1f1gKkoTfl8xc
         5xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727068846; x=1727673646;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7Q3h2SawaWR+sw9PYfDN+KcfCiaOHpGieRaMWQOs6Y=;
        b=V362UEgVTz2CCopZeaHCXKq/4qLmCGP0e8bDWRRFnBFoEKhXl9L/BxsAsReh89FD0E
         2ohtxNazlCgJJgqthN/555q2jZn8zi5b04PZx25H+yQQluNIpuMeUqbMpxhdvk0Nu+/X
         LLoCGExtk81LYdWqqzKzNxn8tF1wFfm/zmQJDV9oll+/At2oW8tGZKFsgQnQNeg/djo5
         CKBSOlGdLC2h7poyjHGCPHAshgKK2k5MPSxeOCU4ZeSIXndpUCJ0V3y8gLfgzXmhCI0q
         slJ12GD6j024H/aZwO25R5wuC/tDhiOXcLTIEBwjVF1yrYfeILWGsTZIRL9YXgkCk6er
         BJqw==
X-Forwarded-Encrypted: i=1; AJvYcCXcFfUdfgsAhs6PwfBP7+8yv18IOw/vb6KuaDM9xC8XQWte6bM2sBY3y+mkDykjli/SSDeYir24r0O3br4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbjSEiY3AyUya9OkvZ+7LAw7hruO6xEZP4poIyZv+PYb7DAPeN
	hgHWGI+cS8f1ZXViQTqorKREMzerlbHXYymVJTex+n/pLL2lcJ8B
X-Google-Smtp-Source: AGHT+IEgJn9OKt3pC4i9q2cvQwxoJM+LLyrR6saLnYmaNWreDtyQQqIFXVH8bK0Oqh4X2XHXoQur6A==
X-Received: by 2002:a05:6a00:1ad3:b0:717:8b4e:98b6 with SMTP id d2e1a72fcca58-7199c9f0bddmr15013739b3a.21.1727068845770;
        Sun, 22 Sep 2024 22:20:45 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a9707dsm13148165b3a.38.2024.09.22.22.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 22:20:45 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Luming Yu <luming.yu@shingroup.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, jialong.yang@shingroup.cn, luming.yu@gmail.com
Subject: Re: [RFC PATCH] powerpc/tlb: enable arch want batched unmap tlb flush
In-Reply-To: <3A7F514D32DFA545+ZvDZF58z6KTRqRjG@HX09040029.powercore.com.cn>
Date: Mon, 23 Sep 2024 10:48:11 +0530
Message-ID: <87ed5bymlo.fsf@gmail.com>
References: <9BC3D1299ECE8428+20240918092515.2121-2-luming.yu@shingroup.cn> <87frpsymf2.fsf@gmail.com> <3A7F514D32DFA545+ZvDZF58z6KTRqRjG@HX09040029.powercore.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Luming Yu <luming.yu@shingroup.cn> writes:

> On Sun, Sep 22, 2024 at 04:39:53PM +0530, Ritesh Harjani wrote:
>> Luming Yu <luming.yu@shingroup.cn> writes:
>> 
>> > From: Yu Luming <luming.yu@gmail.com>
>> >
>> > ppc always do its own tracking for batch tlb. By trivially enabling
>> > the ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH in ppc, ppc arch can re-use
>> > common code in rmap and reduce overhead and do optimization it could not
>> > have without a tlb flushing context at low architecture level.
>> 
>> I looked at this patch and other than the compile failure, this patch
>> still won't optimize anything. The idea of this config is that we want
>> to batch all the tlb flush operation at the end. By returning false from
>> should_defer_flush() (in this patch), we are saying we cannot defer
>> the flush and hence we do tlb flush in the same context of unmap.
> not exactly, as false return implies, we currently do nothing but relying on
> book3S_64's tlb batch implementation which contains a bit of defer optimization
> that we need to use a real benchmark to do some performance characterization.
>
> And I need to get my test bed ready for patch testing first. So I have to
> defer the real optimization in this area.
>> 
>> Anyway, I took a quick look at ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>> and I have a quick PoC for the same. I will soon post it.
> thanks for picking up the barton for the future collaboration on the
> potential common performance benefits among us for powerpc arch.

Sure Thanks, Luming. 
I have posted this work here [1].

[1]: https://lore.kernel.org/linuxppc-dev/cover.1727001426.git.ritesh.list@gmail.com/
-ritesh

