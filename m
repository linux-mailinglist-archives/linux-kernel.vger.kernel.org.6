Return-Path: <linux-kernel+bounces-177982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A78C471C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43976B2290B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ADC3BB30;
	Mon, 13 May 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0/WOs7K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597081C6A4
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626014; cv=none; b=bTRUw6d4oCY2JkJGsSCT0pgpYHIzOA3WSF4PwtpIHQavufKDzZsXhqP65uvF9l0PhrzXngnJtO6IYgaPDWXaFc6H2W/TZOpci74iJikMtIE10CnJgWJgpSZQgmJ46opd9v4PRjvZGX3OLGLT16hiGFyh9k3Rxqc4ozpXxN9zD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626014; c=relaxed/simple;
	bh=SisZcXZqgcbTdXFFIU8xWo+kq/drZzZdUZzdlkD8UKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sl7SiG0CBt3Q2c7R216jDvQQkzbZVgZ/Ey836Okampa+L4pZSloVPP+IpLUC1T9SQ3gtYC6XcDwie/y2TVQlyyaqXx25xh4W2XLhIgMk1whEOkgeIQj1tOjcCZFgBrBfOsTPqFq7kYo0hQyJOA3uwCFVT9TdzaKpL5KXb2nQSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0/WOs7K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715626012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVIn2rWOpVhbTil8h2wwg1NNh+EXi/kd2LlnyPlZrH8=;
	b=H0/WOs7KcrLqhQSfg0gRMbrr6oZYMMiUpzEp6YKXl8Hfru2lzFUH7yFoJQF3SgpS9dmN57
	50InJTsX9A0gqclQ8taEymZO1O83lmMKe9AsM/Ucw97EDwuCkFQ21k4bDoojDrXlLWIrqF
	tx2s7HiL33ddxQNiUdxW3F58DqjrzlE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Pe6TrLu5MZKnZIUa5vvWwg-1; Mon, 13 May 2024 14:40:46 -0400
X-MC-Unique: Pe6TrLu5MZKnZIUa5vvWwg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43e1af4fbc4so13629941cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625646; x=1716230446;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVIn2rWOpVhbTil8h2wwg1NNh+EXi/kd2LlnyPlZrH8=;
        b=iqX6Fs5OHMo5Ujhys3AFyT68di+WBnFspP9cLgAQVALUKgqSDTVrdwNhUub7DNDQeI
         JinVtEnZENU8XnLHcByHMKmGwt1IAcrztN2LoWdjCslXEaxVRpfde9oS4BIQqm+3k7J1
         hojUQ5mRnt+e/BpH6cOry6Wwon7iNK4yl/3Y98mxsGalXBWxV47QXr2E3i10jfk67b8D
         CXcQqe11wVNOtWzUfpbQPOpeLB6O1dTKnBbsSP6kDID/YwZWS7oWppomIAzbCpKsxYqX
         Nq1fzKBIm5FKYIhb66HxHfIUBox82f7Ri32sDqGToy5f6h10PTiIUo+f/32hf2EaW1jX
         L1gA==
X-Forwarded-Encrypted: i=1; AJvYcCX0jBpadNi5Cjp8GI8T/tiIm/awTBxQdVauGWlGjuMIHE9xENBXgQGFjcA/4G4PbXpDw61sqQo3mMyT6FxiEeqPyMC1VVZBpa/tXb3s
X-Gm-Message-State: AOJu0YzaxKv13dutSSo/YxAVphFAK6A8h6GYoVfU5gznQ6BFP7KrXoCm
	F0drKOxwHKRFPcF7Ljq8twd+7CH89FOrP7CL3wHLbpbmD4MGmAjwbqFtu1Y2i2YMze3vHSudgPF
	Nq4hK+tyjtJASojBSs2FuV3ZDula9iT8fBgp4aUDlHdgRRMkCSTBGUuwjkLty/A==
X-Received: by 2002:ac8:7dd6:0:b0:43a:f7fb:bc4b with SMTP id d75a77b69052e-43dfdb0714amr109230421cf.14.1715625646259;
        Mon, 13 May 2024 11:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyEMwpDTnVPRtCr+Mg/v54BS100776/OI4rfOSjtaaCh2632huCZWaUGLfxNq0fFe9FHICXg==
X-Received: by 2002:ac8:7dd6:0:b0:43a:f7fb:bc4b with SMTP id d75a77b69052e-43dfdb0714amr109230311cf.14.1715625645923;
        Mon, 13 May 2024 11:40:45 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e1115dd3esm25071211cf.19.2024.05.13.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:40:45 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 27/27] context_tracking, rcu: Rename rcu_dyntick
 trace event into rcu_watching
In-Reply-To: <ZjuFUZXk4rYO4L2v@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-28-vschneid@redhat.com>
 <ZjuFUZXk4rYO4L2v@localhost.localdomain>
Date: Mon, 13 May 2024 20:40:42 +0200
Message-ID: <xhsmhr0e5h7x1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/24 15:59, Frederic Weisbecker wrote:
> Le Tue, Apr 30, 2024 at 11:17:31AM +0200, Valentin Schneider a =C3=A9crit=
 :
>> @@ -228,7 +228,7 @@ void noinstr ct_nmi_exit(void)
>>      }
>>
>>      /* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
>> -	trace_rcu_dyntick(TPS("Startirq"), ct_nmi_nesting(), 0, ct_rcu_watchin=
g());
>> +	trace_rcu_watching(TPS("Endirq"), ct_nmi_nesting(), 0, ct_rcu_watching=
());
>
> Ah the initial string was wrong and you're fixing it, right?
>
> Should be a seperate patch?
>

No, I'm just creating confusion for everyone involved (including myself) :(
Dynticks start when RCU stops watching, so the naming logic gets flipped on
its head.

If I take the original comment from
bd2b879a1ca5 ("rcu: Add tracing to irq/NMI dyntick-idle transitions")
"""
as argument: "Start" for entering dyntick-idle mode, "Startirq" for
entering it from irq/NMI
"""

So here "Startirq" means "start dyntick mode from IRQ". With the name
change, it should be "Endirq", since RCU stops watching, from IRQ...

I know, a lot of confusion for 0 functional change :(


