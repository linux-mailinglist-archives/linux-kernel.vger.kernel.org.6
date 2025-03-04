Return-Path: <linux-kernel+bounces-544228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35069A4DF16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50A17A2978
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A132040A8;
	Tue,  4 Mar 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SoV3RxCr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D681202C2D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094582; cv=none; b=SLq3WDaOUumqkOLEXPhQTCzVW4Q9tdv9IRVDiP9Xt5fgyEOEtToTFsg0dE/I6xje8zYyui8SmGQI3QiX8Kcf2G1pqyk5UTQGOwpvk0bIA7f9QYTIsyvOEv5wG62G7hpKEF8L5LqJkQwuyAWuxcY/JVpuoZ4Fbd++TeSzMzCkrjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094582; c=relaxed/simple;
	bh=LucAxxQ8iSYgVnrDiZN4OBa90Ko9/yFYcT5nBONuFVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjH4YdXJcfJbFRpVngy8j/7PamWNZExqkj+F4mFEnyIH0VDFmS1mtD6xEu8N4pkswEt71TR9tA9glzxfo4pIQCEkN5ADJoIlZRUpf3yg2EEN8UP474Ypi2X6R9/onwCclxGdDHA2J5fIZXhOOioNb68R5ZwmVUMDIWGY33jTfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SoV3RxCr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bcc02ca41so6124595e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741094579; x=1741699379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKemR72QQvf6XL47yr6QberZCs+n8ZFGTmMjxnmdOGQ=;
        b=SoV3RxCr553URewXUpWG593pBM4bjdVl35Yn2VHuGh/5qXf+OmnE1H1dX/7lY/RLR1
         OhwfgWULpSwd/gg/BY41yuUezP94Nce8FyIPNC8tUQQoKHtwpWtmWWgSncfB/5gkHIFo
         OQFgIoDdmGF4WbBDQMnGCvlGTQa3RU7pTBS9SxvuqeG1r0rQGxkOCJPzIrpbW1ZW0sue
         2M//2vMt7ybBNSApce1SK5VkrDNAp0+peeJef6XEqWnO+sQVddXWdsKUTl2kEHg6n6aH
         uitSFEmvI9dveJcA7wxIEUHEjMw2Vg9CEjOsSxuKDeZjqEtJdQzINM43B6danxu5n6Vj
         hmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741094579; x=1741699379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKemR72QQvf6XL47yr6QberZCs+n8ZFGTmMjxnmdOGQ=;
        b=sJ1yPekkVKWG83fB0KeNPVTe5LPxU2AXM1n/tmpOV+HfH+pHBbJdNC8thPimGP6bHM
         tSRqKmfWveiMJj11tbUWJQPu470fw4Fu+DQLF8cgaQ5A6uAv2ALtMZd1GQjYEOeQEH08
         6Q6bwBJPzVe/+NobwwaZAxNU5GAxQLHoihglK1qhbV729A66Vq1zTB7H0OuQ1YzDCvpl
         Gq1yjwLoGvn/+WWFZXumfUOmE0bqT5DGK03o2BxdWFnrveS8jTDyjif7XL/x+4Mwcq5k
         FCwfoXrQwQ0Q10Cx/oILXf4v3ItxCcDBP3oZaBGd1XI1Lf2sE6TMtDX1T8s+Sq5DfTQ/
         n6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5xlwgOJ+QgZRbtaVU8+4iSdvHBmWBLtEuqPWaTlI8nqR2HB99Cw4mdQYOuuiG8Km8GRHsdc1n4WLa2Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9DOaqxc1tbBm8QR+0xMXcSJtBjNm3MBXnMVWxcMSSBO+/lfk5
	y5SVoOuW33QhaSiGC/br5Fd03jqaR1jwgVm0jphu5ytoa8YuE5WQWo7vV/I+Rz0=
X-Gm-Gg: ASbGncuNokLyu4cxTpZxixfX5Cq8jtxGuSlKlUV7iGai9vVFId69BcxSQrsXn0ud7kQ
	+uNaqUeTxncICZhKkaBGb9YVFLSGtIDyQWsKD/rX4xjrpcDvCFAAt5s218Sl+5g0bo/EW0drUFr
	EVb2pykO5LcFniv08OVMlO3w80MqNiQ0uGbQNmFFOw8ME03dC2k15LKkcgogKy4XSjOxAFdrRzT
	+CfvfK0/D43mFwXHGE/NbeoxxCzPOckWnidEzi7ps/Q0N3mnwlf4iiN/X0jzK6/07rtYmggZukG
	2YCVhMR0RZ7jF64m1k6l3TLyQ+H3b4ULMw==
X-Google-Smtp-Source: AGHT+IGmmEKby4h8bgKI+EYiCxdfm8Dp9+9pdQxP8kluXGw4ta/eUlTluI6isvvbzxZ4bpEkGRqD5A==
X-Received: by 2002:a05:600c:4f02:b0:439:6e08:f4 with SMTP id 5b1f17b1804b1-43ba6a83dbamr119220085e9.26.1741094578717;
        Tue, 04 Mar 2025 05:22:58 -0800 (PST)
Received: from pathway ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc48fc886sm61874425e9.4.2025.03.04.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:22:58 -0800 (PST)
Date: Tue, 4 Mar 2025 14:22:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Donghyeok Choe <d7271.choe@samsung.com>, linux-kernel@vger.kernel.org,
	takakura@valinux.co.jp, youngmin.nam@samsung.com,
	hajun.sung@samsung.com, seungh.jung@samsung.com,
	jh1012.choi@samsung.com
Subject: Re: printk: selective deactivation of feature ignoring non panic
 cpu's messages
Message-ID: <Z8b-ljGnw57GpJb0@pathway>
References: <CGME20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0@epcas2p3.samsung.com>
 <20250226031628.GB592457@tiffany>
 <84ikoxxrfy.fsf@jogness.linutronix.de>
 <Z78eGNIuG_-CVOGl@pathway.suse.cz>
 <8434fytakt.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8434fytakt.fsf@jogness.linutronix.de>

On Fri 2025-02-28 15:26:34, John Ogness wrote:
> On 2025-02-26, Petr Mladek <pmladek@suse.com> wrote:
> > I wonder if this is actually safe. I recall that we simplified the
> > design somewhere because we expected that non-panic CPUs will not
> > add messages.
> 
> Perhaps you are recalling commit 7412dc6d55ee ("dump_stack: Do not get
> cpu_sync for panic CPU").

Yeah.

> > I am not sure that I found all locations. But
> > we might want to revise:
> >
> >
> > 1st problem: _prb_read_valid() skips non-finalized records on non-panic CPUs.
> >
> >    opinion: We should not do it in this case.
> 
> I don't know. This could result in seeing even less output if some CPU
> didn't finalize a record.

But it might also drop messages which are just being added.
And the person enabling the new option is explicitly interested
into the messages from non-panic CPUs.

To make it clear. I do not want to revert the change. But I would
avoid the skip when the new option is used.

The messages might be skipped later when CPUs are stopped.
The information is already available via the @legacy_allow_panic_sync
variable.

I mean something like:

--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2143,7 +2143,9 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * But it would have the sequence number returned
 			 * by "prb_next_reserve_seq() - 1".
 			 */
-			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
+			if (this_cpu_in_panic() &&
+			    (!printk_debug_non_panic_cpus || legacy_allow_panic_sync)
+			    ((*seq + 1) < prb_next_reserve_seq(rb)))
 				(*seq)++;
 			else
 				return false;

Sigh, I am not much happy with the complexity. But if we did not
do it then people might have hard times to realize why the messages
from non-panic CPUs are skipped. Especially because this behavior is
pretty hidden in the log buffer code...

Another motivation is the thread about processing panic notifiers
before stopping CPU. It is still not clear whether it is really
needed. But it is another case where panic() did not work as
expected because a non-panic CPU did not finish a work,
see https://lore.kernel.org/all/20250221022328.47078-1-ryotkkr98@gmail.com/

> > 2nd problem: Is _prb_read_valid() actually safe when
> > 	panic_triggering_all_cpu_backtrace is true?
> >
> >    opinion: It should be safe because the backtraces from different CPUs
> > 	are serialized via printk_cpu_sync_get_irqsave().
> 
> To clarify, by "safe" you mean it does not skip backtrace records from
> other CPUs.
>
> It does not skip their records because trigger_all_cpu_backtrace() waits
> (up to 10 seconds) for the other CPUs to finish storing their backtraces
> before continuing.

OK, I propose the following changes:

  + rename the option to "printk_debug_non_panic_cpus"

  + do not skip the messages in _prb_read_valid() when this option
    is used before the non-panic CPUs are stopped.

Best Regards,
Petr

