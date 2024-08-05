Return-Path: <linux-kernel+bounces-274748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1502947C32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F31F22E29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE483BBDE;
	Mon,  5 Aug 2024 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fxIw/XNq"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D53B182
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865796; cv=none; b=lrdDRbJQz6XnqJvn/DlYcgKpPPbslh2vCzasY/TBVVAXeXaXtJC73jMBfxrasFHuMM2/j00LgjcfqPxM2p2NkjHGTqo8TY8PNjvzHISzJekzLptWg18MD8E5Rjh+WITOMBiSU37L80hoMBrSo23iLelbrXMWregunmZSzvsZCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865796; c=relaxed/simple;
	bh=yNh7w7ek58Vi3QqpMs8LiO5nEWV5jPa2H6RsFMXtAxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVWGDdkGlyGnNyN/Ew2dN8Le2OquLT7mQ/JyAFbD2yS+OcGgrzQ6XfNsj1xoFPh6CexJiV0yhf1EHPHTwufmPfiMz42G13//DH04YMGeWC/gA7Un1OPIf+AZTsSGiFpN36j7epJ5BOj/s9lQXjCaLn04ib91traNSt9fnnQu/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fxIw/XNq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso3314650a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722865791; x=1723470591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Btp5SpiDoTaXjfzBgUoTJOb9HX/H1xnbezUdqJI1/iQ=;
        b=fxIw/XNqoBa+mlVMQWzTpCXBMmhPgAm2ACV/XO8sug8xSufh71PLhV+LfvHNm5W+Pf
         IsGW897n3qAjti+H1L9UbuDOyjPHjaq4BLtPaldsj6MKEXNx4TL6ewcY2IkmdYYtA7PW
         iZdCTC2oZGsTD+CfuJryKwL4ahx1OC/OP7AwgGuOvFhRyWTrCvM9AK8yFlI3ZSYFbzAb
         AUCrZcG5AtrYWJAgR/ahNcDV5yLZZtlsaNQaiVR+xnE5quvreldHcjHMb7yO02scdb1P
         fg+WsAr/YPYm2wyZjTMhx50VRT39I+xNXaZXu7ppuTPHg3km6aNfB7DEG9PrrkpT9HKi
         JEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722865791; x=1723470591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Btp5SpiDoTaXjfzBgUoTJOb9HX/H1xnbezUdqJI1/iQ=;
        b=eEvnz8WPbZFpbzsduminSt0JkudJs+mRsr7mgr1WahQlgml3jTAatbRYBMsM+cAtGW
         pl9pFwHZllcvTknEDndItN7qfDnsXBXVovSMqpxaJezauSMx64OdYZDeqqJ8lz3ne4Jm
         o1HhB9Bv0mnVUEVM8K+dHxEno2auZ5wls4KDJjmtRCPzM5kK8JgQWsIr9AQf4kphrCzo
         eCtzQl+OV1sEHQBzHmDWidlkn7IRbS8eRQbCnyVJqB4YgCMgr9/eNAkxFDXPh+NA2XIR
         I6yXm8zRqTGbEKSODHYWVwdUs21ti0TWQ6CbfZC5zfHnZ+BogQBXf7FyvysVIRgU6Va3
         Cc+A==
X-Forwarded-Encrypted: i=1; AJvYcCUGJXqypEpB4/kXBi+SgvNZBNtVqq30urwS3nYKOU8zZ12+YDypKN836LIg6wILMv6R4ZbAFockRZWXiP4Mn1yvwZYwGfmu/C2+RqIm
X-Gm-Message-State: AOJu0YxNwlcuvrj4BtBbfHPzadp+PrMwK6DAPwuA6cI7wLm4zHZbe1w4
	TZjKvIQhX9SZCu8tqqkn5Vll2Q/uu1rMm0jGr1L+Rw3qqYwkOmPtxNXX2SrYueI=
X-Google-Smtp-Source: AGHT+IFtlw3on4JXnUjKe0Sqnkz1CMQY29uOC8RUqOoKoHsgXjgRFE6HR2mHY7IOcEhTV7o3f3bgTA==
X-Received: by 2002:a50:fe99:0:b0:5a2:abcb:c4cf with SMTP id 4fb4d7f45d1cf-5b7f4294f19mr8699601a12.22.1722865791375;
        Mon, 05 Aug 2024 06:49:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839d2ae7bsm4971097a12.39.2024.08.05.06.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 06:49:51 -0700 (PDT)
Date: Mon, 5 Aug 2024 15:49:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: takakura@valinux.co.jp
Cc: rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, akpm@linux-foundation.org, bhe@redhat.com,
	lukas@wunner.de, wangkefeng.wang@huawei.com, ubizjak@gmail.com,
	feng.tang@intel.com, j.granados@samsung.com,
	stephen.s.brennan@oracle.com, linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH v2 1/2] Handle flushing of CPU backtraces during panic
Message-ID: <ZrDYfU6SVrR2Hj02@pathway.suse.cz>
References: <20240803080444.221427-1-takakura@valinux.co.jp>
 <20240803081230.223512-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803081230.223512-1-takakura@valinux.co.jp>

On Sat 2024-08-03 17:12:30, takakura@valinux.co.jp wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
> 
> After panic, non-panicked CPU's has been unable to flush ringbuffer 
> while they can still write into it. This can affect CPU backtrace 
> triggered in panic only able to write into ringbuffer incapable of 
> flushing them.
> 
> Fix the issue by letting the panicked CPU handle the flushing of 
> ringbuffer right after non-panicked CPUs finished writing their
> backtraces.
> 
> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
> ---
>  kernel/panic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 7e2070925..f94923a63 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -252,8 +252,10 @@ void check_panic_on_warn(const char *origin)
>   */
>  static void panic_other_cpus_shutdown(bool crash_kexec)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
> +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
>  		trigger_all_cpu_backtrace();
> +		console_flush_on_panic(CONSOLE_FLUSH_PENDING);

Hmm, this is too dangerous.

console_flush_on_panic() is supposed to be called at the end on
panic() as the final desperate attempt to flush consoles.
It does not take console_lock(). It must not be called before
stopping non-panic() CPUs.

We would need to implement something like:

/**
 * console_try_flush - try to flush consoles when safe
 *
 * Context: Any, except for NMI.
 */
void console_try_flush(void)
{
	if (is_printk_legacy_deferred())
		return;

	if (console_trylock())
		console_unlock();
}

, where is_printk_legacy_deferred() is not yet in the mainline. It is a new
API proposed by the last version of a patchset adding adding write_atomic() callback,
see https://lore.kernel.org/all/20240804005138.3722656-24-john.ogness@linutronix.de/

Best Regards,
Petr

