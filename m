Return-Path: <linux-kernel+bounces-351901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A999176A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F770B21A04
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3DB14EC62;
	Sat,  5 Oct 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mubsxt4/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD381ACA
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728139226; cv=none; b=lW5T4w4dr+oixBMmcWy6QTszRlBnkBLevbrZT+XAIAsqTyXFrqHkYb1tQuGzZXFm1u+cj/yYAfcf4GPf2HHQB9YiS+oIcFxnZpYzey05+C3jsoi1upx07BFvQKge/aWSZ/mvfB8xfPT/n4P3zE4mjxdoGBCNhF+SvyGzqRU6ZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728139226; c=relaxed/simple;
	bh=uGh+4gdE5LQgYd7E5ZLXoUYBtb16V/gCEuRW1ySPGpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKrXTQmktr8AhpOTWNOwd3z4uV4+DCTA/EHjUlQ9ZG2papnye9kSWQe9aRC0xHG8jCV6q/DTZaoEIgpCAHJWDNr3rGLAzKTjerxi0zghJuCq0GrafdezRYHZ/rMRbmDDJetadZRNc6VLjFuuo+fFz2H88TNphpIRmkyOmWvE8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mubsxt4/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c8844f0ccaso3932660a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728139223; x=1728744023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpxOAbIA3+Cz4oZzWTD+l8nY2+JRz6STcaujwjCsosA=;
        b=mubsxt4/wN55l9BtaauZB1vdjdVIt1xttd8QtSOYJ3wRzKNe8vpp2fAYMcAT/1a8ln
         H1Egdvcm5s5OCRczANSn3kvEuSvDaSjmLS5eY6rvGP+0C1KnvDZMReiYjfStK4BYETjL
         qYl1RnabvciWhP4nvOhWw9Zc/hr7Ff+uwLLypxldxj/xItjhkjhQWYKcB97fZaTxx5cD
         CyE677a9J2TyWktITWA+tbPkMcMmNCca4766hu0BKVrh8YQW32v99Iwzhj79EZDCoglQ
         l3/ISTTTszr8KPf5HkBa9jnun0x78XFK+LdbGcyyKo/dYE9r0DOx+Gf9ulYHUPXPmjOs
         Z++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728139223; x=1728744023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpxOAbIA3+Cz4oZzWTD+l8nY2+JRz6STcaujwjCsosA=;
        b=FidE/rw56xE9q9b/ktltbrUsxoOYlVNPxudUgwIO7bZzJ1fy9pI12jQCbT/IH/sxG7
         8QRUmfXpZrEzouZbdfQ1quJE9U1QCmRVaC+D71Gv8fSYjHkt1sZ+LqYohgK0uATHdqFs
         4So7RNA9rAsbG2VbSbkklsUnvNKdbvyLNIxHXbevyP0dOMm+++w/N0nBvd67V1+tMQgD
         A2vUXKz8M282Z0Nbp3wKsbd3eXPmzDRBhDjK0Ovfte7Hb4MxbU6fYhNY861I+En+SeVt
         XfgxiIDJHq15jr4R0Cu/SW0QuBtDzLCTDvsiYEGAA1gdObB7dcn1HQgIx43Iw8WDPB4H
         RQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9qy7QKWIEJF7Up5WdupCQ1DofSWVMG0c9mE2QDz33sfmmW0aWQPPhec0gdUrGTk2u2Dv2MPLb3q7eHEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+2UfiWQRI4LOYyx7D2VKxuI/0zF13uUYN8Stwx1ZDpcOBIy8
	WCh8Sps/K6EmYfqOnNBsgJZFh8pm6Op4UKVWLBoeJSVo8B2ibuwaTtUhbDW9UCEJ7ZEPA1Qy15u
	YEazc83wazZCo6YbWdotShjXyzYw=
X-Google-Smtp-Source: AGHT+IHBOZgHxUrXj8c7rIQ8iMoB1mEKyvpsiMNDHax/yeMVkAy6dvJygCVxZKOFGZ0ogtVgIyN02fJQYU2ElY3+i4E=
X-Received: by 2002:a05:6402:2807:b0:5c8:8208:2929 with SMTP id
 4fb4d7f45d1cf-5c8d2e3078cmr5243686a12.20.1728139223434; Sat, 05 Oct 2024
 07:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005131643.7692-1-quic_pintu@quicinc.com> <a3f10804c9b793b90513301a08bdfb406959b6f8.camel@perches.com>
In-Reply-To: <a3f10804c9b793b90513301a08bdfb406959b6f8.camel@perches.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Sat, 5 Oct 2024 20:10:11 +0530
Message-ID: <CAOuPNLi1mUKW_vv0E6Ynzvdw_rHvCye+nAf2bWv6Qj9A8ofX1g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/psi: fix memory barrier without comment warnings
To: Joe Perches <joe@perches.com>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org, surenb@google.com, 
	peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 18:59, Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2024-10-05 at 18:46 +0530, Pintu Kumar wrote:
> > These warnings were reported by checkpatch.
> > Fix them with minor changes.
> > No functional changes.
> >
> > WARNING: memory barrier without comment
> > +       t = smp_load_acquire(trigger_ptr);
> >
> > WARNING: memory barrier without comment
> > +       smp_store_release(&seq->private, new);
> >
> > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> > Reviewed-by: Joe Perches <joe@perches.com>
>
> Please do not add signatures not given to you.
>
Ohk sorry, will remove it and send again.
Thank you.

