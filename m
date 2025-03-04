Return-Path: <linux-kernel+bounces-543441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADFBA4D597
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8BE3ADB14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481BC1F8BC9;
	Tue,  4 Mar 2025 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaH/ezKP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE61F8AE2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075258; cv=none; b=d/j2+ccehTLrUKNQCebLH9lRnelDH/hByoZdV31HuU0G1SVHxbxhX187852lMX/Fw3qKcpXr327B/q4z9dB0+AlFxMfpDN4da2bSA8NAs4IGI7CK2iqglZn/Wn3hRfewKCHSIzI+AZBb5CJazjcN0VA1XIqFQBusPVVCgN51nOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075258; c=relaxed/simple;
	bh=grlvUcq+n0ZHUeHH4YRjJJgBrlyFS1tT7OsIfZ6MtKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzYTEBgznc4xzpNXpnPF6APQO7YC0yAG9nb+IraoZjafZT2JgcKH4bdyoRzVe8ZjK1U6Cp8hA2Y6BkuKXwd6uLEZvI/phwxBQQwIBO2MXQ8uzsegCCssvfpxda0iXCK/V/1DfCuZEzVTsnc1tbuJahWFC/Ql/CqzRPDUbbzlH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaH/ezKP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741075254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFiLdPv0wJgydI+E9BMmh4MKMo+mTex0R96kXh25It4=;
	b=HaH/ezKPCy4lSBpk5Cg2gpZU3IKZNyrs8+2ka2A6fLTw/z6i8DDnK51px969K2F2orS86n
	sWc2GSnFv15HKPjAQFouQ/yoG9yau6x6mlQvWq6RJb1IMQ1AD5lPnPBvtuZjSC8VEDrAsF
	NYb3AhFFKiL/vsfvA7Ld4Y3ntC2pPjM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-wIEe4zmuMZqRksH1RFW_6w-1; Tue, 04 Mar 2025 03:00:53 -0500
X-MC-Unique: wIEe4zmuMZqRksH1RFW_6w-1
X-Mimecast-MFC-AGG-ID: wIEe4zmuMZqRksH1RFW_6w_1741075252
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac1e442740cso140405266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075252; x=1741680052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFiLdPv0wJgydI+E9BMmh4MKMo+mTex0R96kXh25It4=;
        b=ZZyY6EN9DPeUKJw/Rpaofta8IMno7Ka3WEkTjZzGY+GHNSErdnQSkk4hCJTzjcnTgH
         ewu6yroHJrZdf4iqF+HDTxP68P/90TUEI3hcp739lOTCXOLnOcov2XIvsU0s/GPfCFJR
         WVKg3TczvjrS1JBV2wU8G4FnWIHQaBaHpVx1nYCB7Dp48XDGH0uAcVAjENOOHG7xHbd/
         cN9WpJ/kGGGFuLfNsmNc+1lygxWXWuSyJyxeXB5cNuoy42Pm/6JVxm57sOdjsmkCwgKq
         gNLbRDxdQDnM1qu6jF5bj9AolIXTso4Y7JhgRacH6SZ/Pyv8XMgeiulumoKs6Z0L/Ksk
         eddQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkZn3hods0s+IGFKhWK18teAxJEbpOXsVmWR3QLN5Jkjo8t4SUT4GYUuDG9GwRNnDO8bQ2thZmiwcmkv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwICgn4qkyR+jg9UMXDHSPcny1p0nXgIg5ziyD0CyAPIQu2rBWC
	97MQDsAvSrnhS9MohzLtrMD3Phyd6zSLXbKHYBcvE1TxSQ8coJfnzorDx2WumJ8ofhPa9gBQLqX
	q2JN++zYIAAe721YBU3c8g6ECeYEiRW1lfUY3+tuGE0aSffnfKF2YiOeYQVPHRbAlwkMbJGhm6v
	mDPC/zUF1LchApm+CmS28akJE/tfzNJZ5/7T2N
X-Gm-Gg: ASbGncuEiZ9SOJJFR0CXPLd8eIbWPLiqkp42ODZmovXRWNq1oruG1WYJ379jNTnxoje
	Umv2VvFseR3g79uWvxludaiYhTkGIaBwjBv3A9C+gm/CTorUSDgdpcrWxrm2PExwv07SjXTFS
X-Received: by 2002:a17:907:97c9:b0:ac1:fa6f:4941 with SMTP id a640c23a62f3a-ac1fa6f56b3mr77297866b.13.1741075251961;
        Tue, 04 Mar 2025 00:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6YcRUoE+PQsHcF94LU8vESBGW89cDx3MC01IA3KlNUw4Ta0bQ9PK+pMZlo0Tp04vd/FuLAgkki0nl8YikaVQ=
X-Received: by 2002:a17:907:97c9:b0:ac1:fa6f:4941 with SMTP id
 a640c23a62f3a-ac1fa6f56b3mr77295666b.13.1741075251611; Tue, 04 Mar 2025
 00:00:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com>
 <20250227200623.60f20571@gandalf.local.home> <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
 <20250303150351.28007ad1@gandalf.local.home>
In-Reply-To: <20250303150351.28007ad1@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 4 Mar 2025 09:00:40 +0100
X-Gm-Features: AQ5f1JpjC5uI6iD9gjjgeuoX5GcZz2a7tfefoRMXBLfWQDJ3fcDoPMA4HZz7dWk
Message-ID: <CAP4=nvQ9pXYtihL7HTTRK=EzUEubtWbxDr78JswksSo-wa7zYw@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 3. 3. 2025 v 21:04 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org> =
napsal:
>
> Not sure what you mean by "main instance"?
>

By "main instance", I meant tool->trace.inst. My point was that
record->trace.inst, which is a different instance, would be still on.
But that's not the case, osnoise_stop_tracing() stops *all* osnoise
instances, not just the first one - sorry, that was my mistake.

>
> The code being changed is:
>
> -       if (osnoise_trace_is_off(tool, record)) {
> +       if (osnoise_trace_is_off(tool, record))
>                 printf("rtla osnoise hit stop tracing\n");
> -               if (params->trace_output) {
> -                       printf("  Saving trace to %s\n", params->trace_ou=
tput);
> -                       save_trace_to_file(record->trace.inst, params->tr=
ace_output);
> -               }
> +       if (params->trace_output) {
> +               printf("  Saving trace to %s\n", params->trace_output);
> +               save_trace_to_file(record->trace.inst, params->trace_outp=
ut);
>         }
>

So we need to stop tracing here, before we save the trace, if we want
to do that. Perhaps combining this with the cleanup patch [1] and
doing the stopping in save_trace_to_file would make sense?

[1] - https://lore.kernel.org/linux-trace-kernel/20250219115138.406075-1-co=
sta.shul@redhat.com/

Tomas


