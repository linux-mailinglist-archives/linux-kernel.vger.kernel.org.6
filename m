Return-Path: <linux-kernel+bounces-281449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1244B94D70D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3A8B22543
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F7515FCEA;
	Fri,  9 Aug 2024 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NQWB0fco";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2NL9YSs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE715EFDA;
	Fri,  9 Aug 2024 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230928; cv=none; b=V/SNiY0gC3ZVdbfP6iOy9okvwVCGZgRYYUUn+f4QALZYAKRyFXn9kYHLjW0C0t7/YaUt/X6f5FSEU3endBG4gM6W1QaIq+AurG5Ret3v3BjQnl/6CDh4UqjvFc/Hi+E35IkRXRdXRBWjeZPUfK7ZJMQJDhP9qGr/yQsqgfP8Veo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230928; c=relaxed/simple;
	bh=c1o99fX7+tBBqVvuR7lu4QsGv9wT4U58AHFLlUyJR3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aot6BlLsHnfUkcrRtB1Sn3zpa/2dypmK/OpV0EMWE1c9XrIXUb5ozwn5iD81h75Z5qWoufmb1Z7ABacXEkY8b/0wtU58kvkGkzTCROpq9X5mOuYOjna8V3run3sqOsswtmvaHXbg6+QV0hMoloLxh4GIn4VaIlAA1vZJMdkpngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NQWB0fco; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U2NL9YSs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723230924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UP939gYCcrU3T02uBHEVFDKNfNyRN8nKtOxLjSZBKYk=;
	b=NQWB0fco/GMzY2UwNqL8g74zHsmlAeAms87dl7yquBD9A2ecZ4h1b5w2kMNHUsRYgqX7fN
	hYdSIhY545b3jO9iWRyOPBdijLW8v314K80KPEUSd80HBIq0/T0WUwuiKKMMLUnFsZ5jyx
	/MeNVL2y54oEDlWp4RCijYAUaafsLkhM5v0JxhDfAoH/+OyM/OOq3IN1/9r2e1EgdbokZr
	aF1Ix2T6Py35jB0cUFmh2UYhsrTajesxfkSqQMbOOBwEAkkWvWJ2JNiTIctW8peOvZwPiq
	OVpLv3+TKyeoLwIcE3qtQdecLXcVtCApqBs6gNJQFAstpCuLW/wjbOTrpVjilw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723230924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UP939gYCcrU3T02uBHEVFDKNfNyRN8nKtOxLjSZBKYk=;
	b=U2NL9YSsVUHes77gY3W48KXaBysC7uKvyQS+VcYlexQWIrRNOrbY4C2TqoNZy4i6UNfw/1
	+1GQgm/iFNxvYAAw==
To: Marek Maslanka <mmaslanka@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Marek Maslanka <mmaslanka@google.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Rajneesh Bhardwaj
 <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 1/2] clocksource: acpi_pm: Add external callback for
 suspend/resume
In-Reply-To: <20240809131343.1173369-1-mmaslanka@google.com>
References: <28567169-4588-002d-85b8-906d22f12f05@linux.intel.com>
 <20240809131343.1173369-1-mmaslanka@google.com>
Date: Fri, 09 Aug 2024 21:15:23 +0200
Message-ID: <87ed6xtsms.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 09 2024 at 13:13, Marek Maslanka wrote:
> --- a/drivers/clocksource/acpi_pm.c
> +++ b/drivers/clocksource/acpi_pm.c
> @@ -25,6 +25,12 @@
>  #include <asm/io.h>
>  #include <asm/time.h>
>  
> +#include "acpi_pm.h"

include/linux/acpi_pmtmr.h please

> +static void *suspend_resume_cb_data;
> +
> +static void (*suspend_resume_callback)(void *data, bool suspend);
> +
>  /*
>   * The I/O port the PMTMR resides at.
>   * The location is detected during setup_arch(),
> @@ -58,6 +64,25 @@ u32 acpi_pm_read_verified(void)
>  	return v2;
>  }
>  
> +void acpi_pm_register_suspend_resume_callback(void (*cb)(void *data, bool suspend),
> +					      void *data)

No line break required. Also the name wants to be acpi_pmtmr_... for the
global visible function so that it can't be confused with the power
management related acpi_pm_* functions

Thanks,

        tglx

