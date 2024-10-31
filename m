Return-Path: <linux-kernel+bounces-390761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E5D9B7E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC4CB21311
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEE219EEC0;
	Thu, 31 Oct 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zksPgy2w"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F86127B56
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388108; cv=none; b=rjXztNygauDZtLXM5HUfYmHcfFO2O+GfQUE1fEvsjHF0gq3pZUqXPb4QkZO8bH98gL2OcrKBWvDm+HlnJdCxsuRxojnEZpxZnuUrhwRt3yZqZz3vbzq84Z2gQ1jxSEXwiDMMRqx0ooNfy0RTSixpyI3QyZaiyKAQSQV6CIkFVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388108; c=relaxed/simple;
	bh=j6+Ya2SW+yfJz5lrOlTFeC8zmrf2vACRaRbpgHJ+iNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BS6YdA8uj7W/IRDHP47p//VxGKlUPapjzn/JxMKtLopDZ7HSuyyaK8DEeb4miOBoFB/aDdh7n+BebWgwK1dQV8cGow9jUiHpp66+AUp3mYp2pxdzyCiSJBe2WnqV6PMI7AZE1A7Oz2nt+WYIvDGayN9GHotq0hscLT5hCXmcsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zksPgy2w; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83aacecc8efso63855139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730388106; x=1730992906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6DRLiaAF06vSTpnmWA/JzrGwHB4JSnoNRs6CjLzTOo=;
        b=zksPgy2wkfOvFPnJaUulb9pmzbh+6mnwVa2yNLjIsqacy9IaUcPve6VBoNyTtMfvQU
         L33GxhvNpDSxAQJn/huMi993HGk/81ZVtfDurC/r3PO0nZkQmJXgAooG/a5ueZJBUX48
         LPtTjorasapaosiOl8j2hS3CPV/bUUFR41S8JLJyelqkxwnk61pk5is7T5TfKuoVUwgj
         f1BlNrTsVx1O+9y2QAji0NopYlYU9InQaaVpgmcf24F71ccqeYS+UMt//2aadSew3mwc
         fH9OjKdDWxpuA+NeMY+4hQ1myGE5Ldh5MImZZ6B4pYQlAuXf3sE54UZvkfmmwV+RK3zo
         yOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388106; x=1730992906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6DRLiaAF06vSTpnmWA/JzrGwHB4JSnoNRs6CjLzTOo=;
        b=d0qlvb+THDbci4Avdzu481Qn4dShUp6XOVBxj3LZJNC/oPKoWi8N3l7TnlWJ5uxa+d
         4bhmpqr9l7VrIiwZvBjXygCiDXWKnGJlLBdnTmx2CYaX0rsdp8P6yPMC6NZAuYA1V1g3
         7gxxCxFaCKNmo4uoSE5QavhzOKfxEZ7LCZcapbMyvGWZ4wc1NDGo8vGfxnVOB8B+gGdr
         gciOS7ZownaaX+wXSJJjuXcVTJ0yzaFFia0YZyCuRx/n+DZPcGIWYi+zWVZICEziVL18
         oEhAN7l9j8ejcq4qZbx2Q4a30ib8fOY1gtyP/qzKSN5H6hi3fru8At4X4jTCdfDzDpg0
         QH3w==
X-Forwarded-Encrypted: i=1; AJvYcCUkr6pOVgx7j2Kl9rOBJxwshkQsh30GwGiRKAbcxJ55xuvHmdqyV8UQtsXS8BdKT2+YmXcJ1hOEj5pNFxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUkOZSAR3Yx5GJF4L35IkQB0CsnC345M9L1lnMePHRdZbDHCEZ
	Sp3XWxivLENYwFyXOO2NB4LVurrg2ov88F+5M9PIr1p5n/hlIvVX2HlF4TVvSgQ=
X-Google-Smtp-Source: AGHT+IGGUaCMfX5oSCNwHpwRyR3bCSWZZozym4dVHbPqPiHULcwzzh+N6aXDrwQ+xURGyI+4gG/rGw==
X-Received: by 2002:a92:4b0b:0:b0:3a0:abd0:122 with SMTP id e9e14a558f8ab-3a6aff502e2mr2996645ab.8.1730388105857;
        Thu, 31 Oct 2024 08:21:45 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a43efsm332466173.128.2024.10.31.08.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 08:21:45 -0700 (PDT)
Message-ID: <878a0ef4-2870-49a8-83dd-ede33b513c40@kernel.dk>
Date: Thu, 31 Oct 2024 09:21:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 05/19] io_uring: Remove redundant hrtimer's
 callback function setup
To: Nam Cao <namcao@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, John Stultz <jstultz@google.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
References: <cover.1730386209.git.namcao@linutronix.de>
 <07b28dfd5691478a2d250f379c8b90dd37f9bb9a.1730386209.git.namcao@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <07b28dfd5691478a2d250f379c8b90dd37f9bb9a.1730386209.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 9:14 AM, Nam Cao wrote:
> The IORING_OP_TIMEOUT command uses hrtimer underneath. The timer's callback
> function is setup in io_timeout(), and then the callback function is setup
> again when the timer is rearmed.
> 
> Since the callback function is the same for both cases, the latter setup is
> redundant, therefore remove it.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  io_uring/timeout.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/io_uring/timeout.c b/io_uring/timeout.c
> index 9973876d91b0..2ffe5e1dc68a 100644
> --- a/io_uring/timeout.c
> +++ b/io_uring/timeout.c
> @@ -76,7 +76,6 @@ static void io_timeout_complete(struct io_kiocb *req, struct io_tw_state *ts)
>  			/* re-arm timer */
>  			spin_lock_irq(&ctx->timeout_lock);
>  			list_add(&timeout->list, ctx->timeout_list.prev);
> -			data->timer.function = io_timeout_fn;
>  			hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
>  			spin_unlock_irq(&ctx->timeout_lock);
>  			return;

Should be fine, io_timeout_complete() is only used for non-linked
timeouts.

Reviewed-by: Jens Axboe <axboe@kernel.dk:

-- 
Jens Axboe

