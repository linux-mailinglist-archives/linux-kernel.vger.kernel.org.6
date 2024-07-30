Return-Path: <linux-kernel+bounces-267858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C7941774
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346DE281778
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377301A3039;
	Tue, 30 Jul 2024 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="clDeDsJF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rs9nfx7V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1BC1A3031;
	Tue, 30 Jul 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355737; cv=none; b=Kr2iEmvh8mQgMkbR9gm1CENHWkeEGcg/JqDcRF8WF/f8u0YiTbFnzkwwolbL6l+UuWc3w6v61fqcDoisG7bGZnsTy6lt4jWebDn5G6Tk6QNWFmtkWqPF/U4gAYEHViarTgoESYqe/0z0kBxNIju3pnjA7JFdBrL2UBeE00OMvBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355737; c=relaxed/simple;
	bh=AUOl71qABrzeaKwaAc3dEOJLIGaxiLw7FmxehLQCeWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ammqlf+2X3Wu3KZ6KF667FRZyv2VQfVz+9ipHdC0V5qURW1bkz8tLRVAoxLk3ZDH6+hjDj5YyPUZliVclySuQ7BSXbboBuzvMK+WhPEGe+FbqNKY3vVxYFtNl/sr333pi9Oxw52P9s6N5IJ964C29fyMdYI2wJsb+3SuK4J+3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=clDeDsJF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rs9nfx7V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722355733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf5ncwMTYgRBzu9F9xJhXESy8cHEXAFkcaiy7PaCMeM=;
	b=clDeDsJFEAMvnzvntn4kVt77+y/2o3CF1WUBWB4vXyTALtcwltwNWn6y9IlsJ2/ukfyaNv
	5QeNFaGYIbtE48Q7uXL0xcF5Axzt9r32hGmnKHz5sdaKnD/ICQeBGj7OlmiGz93zSkaQjy
	LeP/0ayTEmKJF1ItN/hPq26YuoXaRtqCpEosbIBhltncWS2a66+ecNnYqcmXKNkF2ZV7E7
	4N1NS3XwEEt4gMIX67yn2W/D46pP9LHTfUG94Yzm+X1AEpGyUpsKT5t8+ggJjlCK2wholP
	OsBlCyVsxmaq6Ew3GjW62bVHIgtwdGfYHQ8dS3pmiRku3CKXuY+30JPgkAP14w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722355733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf5ncwMTYgRBzu9F9xJhXESy8cHEXAFkcaiy7PaCMeM=;
	b=rs9nfx7VcbhhCaJnAEYG3iGOgnWaXyxwpsWRMp8Tsrs5eCPkqfABEOCTlo/Xs4JTyUSmTp
	f0ISQMlk0pGlc/DA==
To: Marek Maslanka <mmaslanka@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Marek Maslanka <mmaslanka@google.com>, Rajneesh Bhardwaj
 <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86:intel/pmc: Enable the ACPI PM Timer to
 be turned off when suspended
In-Reply-To: <20240730120546.1042515-1-mmaslanka@google.com>
References: <CAGcaFA2sQNRo9UThN-C1NOLtGUJ3sKzc=pEC9wdDWMi501iLsA@mail.gmail.com>
 <20240730120546.1042515-1-mmaslanka@google.com>
Date: Tue, 30 Jul 2024 18:08:53 +0200
Message-ID: <87cymu7tgq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek!

On Tue, Jul 30 2024 at 12:05, Marek Maslanka wrote:
> Allow to disable ACPI PM Timer on suspend and enable on resume. A
> disabled timer helps optimise power consumption when the system is
> suspended. On resume the timer is only reactivated if it was activated
> prior to suspend, so unless the ACPI PM timer is enabled in the BIOS,
> this won't change anything.
>
>  include/linux/clocksource.h           |  2 ++
>  kernel/time/clocksource.c             | 22 +++++++++++++

The changelog is completely silent about the core code change. That's
not how it works.

Add the core code change as a separate patch with a proper justification
and not hide it in the pile of the PMC changes without cc'ing the
relevant maintainers. It's documented how this works, no?

> +/*
> + * Enable or disable APCI PM Timer
> + *
> + * @return: Previous APCI PM Timer enabled state
> + */
> +static bool pmc_core_enable_apci_pm_timer(struct pmc_dev *pmcdev, bool enable)
> +{
> +	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> +	const struct pmc_reg_map *map = pmc->map;
> +	char cs_name[32];
> +	bool state;
> +	u32 reg;
> +
> +	if (!map->acpi_pm_tmr_ctl_offset)
> +		return false;
> +
> +	clocksource_current_cs_name(cs_name, sizeof(cs_name));
> +	if (strncmp(cs_name, "acpi_pm", sizeof(cs_name)) == 0)
> +		return false;
> +
> +	clocksource_suspend_cs_name(cs_name, sizeof(cs_name));
> +	if (strncmp(cs_name, "acpi_pm", sizeof(cs_name)) == 0)
> +		return false;

How would ACPI/PM ever be selected as a suspend clocksource? It's not
marked CLOCK_SOURCE_SUSPEND_NONSTOP.

There is a reason why clocksources have suspend/resume and
enable/disable callbacks. The latter allow you to turn it completely off
when it is not in use.

Something like the below should work. It's uncompiled, but you get the
idea.

Thanks,

        tglx
---
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -63,12 +63,40 @@ static u64 acpi_pm_read(struct clocksour
 	return (u64)read_pmtmr();
 }
 
+static bool acpi_pm_enabled;
+
+static void (*enable_callback)(bool enable);
+
+bool acpi_pm_register_enable_callback(void (*cb)(bool enable))
+{
+	enable_callback = cb;
+	if (cb)
+		cb(acpi_pm_enabled);
+}
+
+static int acpi_pm_enable(struct clocksource *cs)
+{
+	acpi_pm_enabled = true;
+	if (enable_callback)
+		enable_callback(true);
+	return 0;
+}
+
+static void acpi_pm_disable(struct clocksource *cs)
+{
+	acpi_pm_enabled = false;
+	if (enable_callback)
+		enable_callback(false);
+}
+
 static struct clocksource clocksource_acpi_pm = {
 	.name		= "acpi_pm",
 	.rating		= 200,
 	.read		= acpi_pm_read,
 	.mask		= (u64)ACPI_PM_MASK,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.enable		= acpi_pm_enable,
+	.disable	= acpi_pm_disable,
 };
 
 



