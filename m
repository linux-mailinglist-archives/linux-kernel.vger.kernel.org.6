Return-Path: <linux-kernel+bounces-201019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3758FB834
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E711C2439E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618C145A03;
	Tue,  4 Jun 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKbbDg05"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163243236
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516673; cv=none; b=GGXnpXx/Qf23F7Qa53nfxG8SWruwWc7QAeO0Zn4Jlk8b3MqqyVHKPM+iOzOVu7WIUTPux8tXiHytgmRl4ixFEjEI0mOxvQQIVZuz50uzQBmggG+VJdhob6volAt4F6SLejnA2wIKW5W2GnsFONjnkUSlGXIl4i8MJwfm1bI8Bj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516673; c=relaxed/simple;
	bh=vhZYleApZN8kWLF7LONqg/TsuUedJgn2Sb+eQ5I6y7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ey809fdFdVj1alKyIDNeF1mz31+e1gMubdr6refQx9kTlsh3rgYJ8xoHwVMgLK+ubdxZ2rGp5iDhAPZocjd3n4ohTygmtKp+5xcmI2AO4hGNDXHIODX9nQQRvxDYh30Lu0uYtEYRTGIErUrXktZitoEIWIRtfW9Mv8ed9IhVvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKbbDg05; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717516671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iY8Smgr4TinEDzI3seLjT/wKu7RCmTGwq48l1prhDuY=;
	b=IKbbDg05aeYlzeVyOGR5sTiEYHoKFphtl8FkuRmTU4qDy53FrBOKrOBiSmf2M6PeC3vWzG
	VpqeMKHxlUGZH5LnRLIOELPPacrtrvWziz+cjNbytBkrdBq6Ui5lXaoPJi6lXAzHBa3BJF
	7YGEnwK9PrSZvb8ISJxiGyeN3rYmPW0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-PWp6JmfpNbCTJrCqW0Q0Ng-1; Tue, 04 Jun 2024 11:57:49 -0400
X-MC-Unique: PWp6JmfpNbCTJrCqW0Q0Ng-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6861bb1c0bso219618766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516668; x=1718121468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iY8Smgr4TinEDzI3seLjT/wKu7RCmTGwq48l1prhDuY=;
        b=vcRjRi1/VXVQ9YrsoWmyPawogreuCHqZGcCgOpDvtMpA59L3MM8MKxNO14NUOLrmyO
         DtljdT4Tg4pFUU7xG9TQLqPUX1aOb5MDRV3i4/r2SWf9rwCQ3Vr29sU4FmsmarIIOLls
         0e5bqKt7ZTH60Vg44CpgLyV5/kNy+u5VwoXgZq19+n0HWFfNGbCU1qAUt19NjmpUDS6a
         AKT8Q7pPBTgHDOvCvEmIegn4tQJBZE30sKM2XhcsBYxp3hmsW5NFFv98LSBkEKxpW5hG
         9PxbO6k5Ox1CR94Jcp9pcgT1j+tTS9BHgkNNpJ/FRbfAMsBEuTx0WwUnvFUfkE53e0JI
         Nw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoRMKUga4Ac0Q9NSBzAJDW8hl2uSnFkzp9IP30+TSEPbZH55nMJJQnzQzNLwAfyLVBxOcFhKp1oZxUriolD1KgXBioK0qqf/h84Czi
X-Gm-Message-State: AOJu0Yy3GrEoJCZRCGEXMjc9mQSWM67IKG0ncJaMHjYRABNTIFWHsSdT
	QEjs4DMc9eunfp93WuTvdvWCAOP8o0wwlPrtWwZxkB7IG7LIt4/ZsodMUoW3dscrY2Egrw7M7Bx
	1SrUtbNfrcQMgFbjSHa8nagLHFQSmbTlFD9jOCCAUCLRjwJ+6gtShi3Dwhom22w==
X-Received: by 2002:a50:d65d:0:b0:578:64b9:d02e with SMTP id 4fb4d7f45d1cf-57a8bcd7c9emr10595a12.40.1717516668754;
        Tue, 04 Jun 2024 08:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ80kTYg345fHCJuh2+pANonRw+zjSWqYbitUEjpOBdxl6OvwCwCuHkL4bn4QKZ8cVZwCvRA==
X-Received: by 2002:a50:d65d:0:b0:578:64b9:d02e with SMTP id 4fb4d7f45d1cf-57a8bcd7c9emr10582a12.40.1717516668361;
        Tue, 04 Jun 2024 08:57:48 -0700 (PDT)
Received: from [192.168.0.161] (host-87-11-37-195.retail.telecomitalia.it. [87.11.37.195])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a86a6a5d3sm898050a12.65.2024.06.04.08.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 08:57:47 -0700 (PDT)
Message-ID: <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
Date: Tue, 4 Jun 2024 17:57:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
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
 linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240604144228.1356121-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 16:42, Qais Yousef wrote:
> -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> +	    (wakeup_rt && !realtime_task(p)) ||

I do not like bikeshedding, and no hard feelings...

But rt is a shortened version of realtime, and so it is making *it less*
clear that we also have DL here.

I know we can always read the comments, but we can do without changes
as well...

I would suggest finding the plural version for realtime_task()... so
we know it is not about the "rt" scheduler, but rt and dl schedulers.

-- Daniel


