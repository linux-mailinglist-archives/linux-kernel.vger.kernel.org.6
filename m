Return-Path: <linux-kernel+bounces-353104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0B992889
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D86D1F23E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2580F1A3BD6;
	Mon,  7 Oct 2024 09:56:52 +0000 (UTC)
Received: from coelho.fi (coelho.fi [88.99.146.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF661B4F33
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.146.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295011; cv=none; b=dtgVOXPxXfuQtZJLuP/Z8Ko+WkGpyd63PUOfOf9SEKrHt0CW6NgxlACohHuVTADuGtjLhxq8uw8GsDLu4VxBbVH73WWkLAtXZAYqgZX7oSM1d/SLHF3drd8gwewA5CiCx1PEo9NuxrenjDdSZhHqTvhqO+An5lieSule4xuU8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295011; c=relaxed/simple;
	bh=YmEqY53txHcRZ4HognLxqtNWrbpyB7cRGAn2wCZLIrg=;
	h=Message-ID:From:To:Cc:Date:Content-Type:MIME-Version:Subject; b=gG04n3P53Wltlkg5fHrgT/SmHc3G9dnuNbMDVBqFOGfogMjELaeyn3VaPkVYY/nANQcQfzX+OEZb/SOoiWUy/Kmybdr4k2oDZ1zTUAnarjDrSQoFR2UXXWao6gopSuVCZ9s6KlLpe/k4bcqlL7JtcuP7FUainjd5r8M3VHgSnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi; spf=pass smtp.mailfrom=coelho.fi; arc=none smtp.client-ip=88.99.146.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelho.fi
Received: from 91-155-255-253.elisa-laajakaista.fi ([91.155.255.253] helo=[192.168.100.137])
	by coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <luca@coelho.fi>)
	id 1sxjs3-00000000IgQ-2xD8;
	Mon, 07 Oct 2024 12:17:43 +0300
Message-ID: <40555604c3f4be43bf72e72d5409eaece4be9320.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: linux-kernel@vger.kernel.org, mmaslanka@google.com
Cc: hdegoede@redhat.com, daniel.lezcano@linaro.org
Date: Mon, 07 Oct 2024 12:17:38 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
Subject: Regression in PMC code in 6.12-rc1

Hi Marek et al,

We have been facing some errors when running some of our Display CI
tests that seem to have been introduced by the following commit:

e86c8186d03a ("platform/x86:intel/pmc: Enable the ACPI PM Timer to be turne=
d off when suspended")

The errors we are getting look like this:

<4> [222.857770] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<4> [222.857771] [ BUG: Invalid wait context ]
<4> [222.857772] 6.12.0-rc1-xe #1 Not tainted
<4> [222.857773] -----------------------------
<4> [222.857774] swapper/4/0 is trying to lock:
<4> [222.857775] ffff8881174c88c8 (&pmcdev->lock){+.+.}-{3:3}, at: pmc_core=
_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_pmc_core]
<4> [222.857782] other info that might help us debug this:
<4> [222.857783] context-{4:4}
<4> [222.857784] 1 lock held by swapper/4/0:
<4> [222.857785]  #0: ffffffff83452258 (tick_freeze_lock){....}-{2:2}, at: =
tick_freeze+0x16/0x110
<4> [222.857791] stack backtrace:
<4> [222.857793] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 6.12.0-rc=
1-xe #1
<4> [222.857794] Hardware name: Intel Corporation Alder Lake Client Platfor=
m/AlderLake-P DDR5 RVP, BIOS RPLPFWI1.R00.4035.A00.2301200723 01/20/2023
<4> [222.857796] Call Trace:
<4> [222.857797]  <TASK>
<4> [222.857798]  dump_stack_lvl+0x80/0xc0
<4> [222.857802]  dump_stack+0x10/0x20
<4> [222.857805]  __lock_acquire+0x943/0x2800
<4> [222.857808]  ? stack_trace_save+0x4b/0x70
<4> [222.857812]  lock_acquire+0xc5/0x2f0
<4> [222.857814]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_=
pmc_core]
<4> [222.857817]  __mutex_lock+0xbe/0xc70
<4> [222.857819]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_=
pmc_core]
<4> [222.857822]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_=
pmc_core]
<4> [222.857825]  mutex_lock_nested+0x1b/0x30
<4> [222.857827]  ? mutex_lock_nested+0x1b/0x30
<4> [222.857828]  pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_pm=
c_core]
<4> [222.857831]  acpi_pm_suspend+0x23/0x40
<4> [222.857834]  clocksource_suspend+0x2b/0x50
<4> [222.857836]  timekeeping_suspend+0x22a/0x360
<4> [222.857839]  tick_freeze+0x89/0x110
<4> [222.857840]  enter_s2idle_proper+0x34/0x1d0
<4> [222.857843]  cpuidle_enter_s2idle+0xaa/0x120
<4> [222.857845]  ? tsc_verify_tsc_adjust+0x42/0x100
<4> [222.857849]  do_idle+0x221/0x250
<4> [222.857852]  cpu_startup_entry+0x29/0x30
<4> [222.857854]  start_secondary+0x12e/0x160
<4> [222.857856]  common_startup_64+0x13e/0x141
<4> [222.857859]  </TASK>

And the full logs can be found, for example, here:=20

https://intel-gfx-ci.01.org/tree/intel-xe/xe-2016-92d12099cc768f36cf676ee1b=
014442a5c5ba965/shard-adlp-3/igt@kms_flip@flip-vs-suspend-interruptible.htm=
l


Reverting this commit seems to prevent the problem.  Do you have any
idea what could be causing this and, more importantly, how to fix it?
:)

Thanks!

--
Cheers,
Luca.

