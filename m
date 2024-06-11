Return-Path: <linux-kernel+bounces-209538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70446903765
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F51B293F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66917625E;
	Tue, 11 Jun 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KurZBcQ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB717623F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096619; cv=none; b=eNvHXMqJaGXy47gi1BaBObM63957nkT6CTDZecIESZgeBodpPaBO9e6ll07XKprz9qwbNcUlgoEv2aSCBa+5GFPOUY1g9J+Pou3oYpSBnTprOASANUZzMvaui+Iq/ek2Q8ZoDzH54j5wT6DWilijA3fojxKotbctxOMhuOiQgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096619; c=relaxed/simple;
	bh=wU35Bt/W4Th7ebj0fz6w+yPys0fnerf+0iDw45DCtn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kN0ergeMTc00gIHd2iP4me5dwPHqtJo57yzSbrvzIjlaUwxKNeteairuSgQuxYgsZeeqISGFUhdIXXoT+YL+v/JibIj80Cuf3jS1CL2ouI4I/f/Gr65tudcptTAeD7BRRE2UhfjIQgwxPNbN8GTylJ0YsndglgjDZj4UDQmX80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KurZBcQ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718096617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLWHA3e+iEuCixJwfkXomh9A2UOMcv37vtzmFIMouF4=;
	b=KurZBcQ+NmLCKcwO+Ps8VIQczU7Oc2sm/pfqtbp+coWZMURoyRF0iEEugS9fErXgN39thu
	guZN6ACACaqVlTA5IxTuFyXkZittb2FDQ3MFnOcxhzApM7bX/IDTuhSY1JMs1pvDF9IVCV
	KTD22QR65J4Zw4qe6RW8fDkdwav9GHI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-AutPRsfkOv2ZszifxP4Eyw-1; Tue, 11 Jun 2024 05:03:29 -0400
X-MC-Unique: AutPRsfkOv2ZszifxP4Eyw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57c748dd112so556688a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718096608; x=1718701408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLWHA3e+iEuCixJwfkXomh9A2UOMcv37vtzmFIMouF4=;
        b=I6FJuYqPA9/6H6qKwK+UtV/gneq3WE3hVXLg1jBETmePmg5Su3ldFloAjMuUfyuFrT
         rucY0bUiUrwo6bAFkXLS+Lto0DAAUastgn587AncZ3mQ95KqylSqG/qGPmfMDosh1OWJ
         GpZciaLJxTMj5CSVyXrYjnCNi6xeaOHm98BTdH5iFsrvypyZ1KdBE64VrX8nc2XNCGGA
         YgkfT+flY+owQpu2ARhfq/vcOWCs25Yq9jUh1+n/CcWhueOh9aACs6RB36vQFeMiJjFs
         yU+mPFJVtIAcLBJ/FW8gAIuZ5TeEWC6XGjUyMex8O96Ot0js982xqRteVGjqyGlZsEOz
         brnA==
X-Forwarded-Encrypted: i=1; AJvYcCWwXEhREIuEohhHBVjXyDspi9FtjdebDk4yp/IT2qcCfKZ7EDZq04Wqq97lvK0bXPmzclKLIvXCjKzf2xO2WBuEHb2kZhYdiQsl+fWP
X-Gm-Message-State: AOJu0YxvQYs8J8Jzc0FQEjP/Xgax3tEr03FhGjZ8ULVXVI6usKbyV7R7
	lQWs9kVMmZOgTRu/Oj0cpzQYBCF2Wy4aWyFKFfe76W1YrcvMTJsE/bCEb7T/5P8+/S7K0ELMzXF
	78EMxojlaVc6uAe5C68tmabZCmszjZp72//4T8liWFY9+SfmMGj/FO+hrVgpwTw==
X-Received: by 2002:a50:8a82:0:b0:57a:33a5:9b71 with SMTP id 4fb4d7f45d1cf-57c50972f28mr9752096a12.33.1718096608137;
        Tue, 11 Jun 2024 02:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBNv7S2oEwkt1dYa7oWJiEJQJtRTwaghusj5MnBn4EV1Sy+PsswgNz9xRNTlMZV4hQSAwwSQ==
X-Received: by 2002:a50:8a82:0:b0:57a:33a5:9b71 with SMTP id 4fb4d7f45d1cf-57c50972f28mr9752074a12.33.1718096607760;
        Tue, 11 Jun 2024 02:03:27 -0700 (PDT)
Received: from [192.168.0.102] (host-95-245-118-97.retail.telecomitalia.it. [95.245.118.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae11a98csm8905551a12.48.2024.06.11.02.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 02:03:27 -0700 (PDT)
Message-ID: <b5f84790-8036-44cf-bfd9-0a43269a26d9@redhat.com>
Date: Tue, 11 Jun 2024 11:03:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] sched/rt: Rename realtime_{prio, task}() to
 rt_or_dl_{prio, task}()
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Metin Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240610192018.1567075-1-qyousef@layalina.io>
 <20240610192018.1567075-4-qyousef@layalina.io>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240610192018.1567075-4-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/24 21:20, Qais Yousef wrote:
> -	if (realtime_prio(p->prio)) /* includes deadline */
> +	if (rt_or_dl_prio(p->prio))

that is it... no thinking, no recall, no comment, no confusion...

-- Daniel.


