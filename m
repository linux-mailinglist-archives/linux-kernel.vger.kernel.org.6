Return-Path: <linux-kernel+bounces-183778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80DD8C9DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A5EB24A87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71857135A73;
	Mon, 20 May 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="rH9xSN6d"
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD64A2D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210894; cv=none; b=IZZslCCxiH2IYX+N/pPwkqbbJbJgmkC8sk4Wt5LyVIgeptGFOhzeeJkjF3aRifZFq/MqitFXsvI+vYsc8NKi2g9QeHjfBCc5/92gRatkZDNM89WhkFaYUUHoj6vk4jV08ZJDFFxAsS9Wwqb6QsZWpfoE+Dk7slMAoWtruBL1Wbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210894; c=relaxed/simple;
	bh=4FFRsUY+xzOJgk7w4ROPHEy8MihkfUn1f/M5hoqns3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbO6SGSYDmFI4QnA2WsfZscCluJHVb4LrMQSiFz4HbVnO+ROzNCtM0odJBB3yfALfGQdD0dNguoLlOMxRh/IVu226MLfL8zu5bxtMFR/FRiLzPeRU6bEq24T67VR7/PhjebEHPWcORFq+9FLjbo52gezpahF7KWwwjXdKPzaTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=rH9xSN6d; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
	by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 80D0560B79;
	Mon, 20 May 2024 16:13:14 +0300 (MSK)
Received: from [IPV6:2a02:6b8:8f:4:b109:a1eb:adad:8bd8] (unknown [2a02:6b8:8f:4:b109:a1eb:adad:8bd8])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id wCIgC50i3iE0-mi5SapIL;
	Mon, 20 May 2024 16:13:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1716210793;
	bh=d4oQfayslbqnsBQUxY4CRy6I3qaZw7cWiNjlJGC4TIA=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=rH9xSN6drHv3U1XPmTd22R4k5rXFQMXtsZNIbPSnh9RGsjGGk5vGwwXdo5GPxiFWQ
	 xmjodzWkq+BYVVon5xYKIz7qFuugzEsvLXOiMBeidBbo8FjZ95NrGmTeQcKMuWGPse
	 4wjZ1TYdEduq+L8dMPYazKSxHpNom18vhb13L9Lo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <17ab995a-cdc0-43ce-884c-48a263f219c3@yandex-team.ru>
Date: Mon, 20 May 2024 16:12:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!
What is the current status of the series?


On 5/7/24 08:30, Josh Poimboeuf wrote:
> In cloud environments it can be useful to *only* enable the vmexit
> mitigation and leave syscalls vulnerable.  Add that as an option.
> 
> This is similar to the old spectre_bhi=auto option which was removed
> with the following commit:
> 
>    36d4fe147c87 ("x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto")
> 
> with the main difference being that this has a more descriptive name and
> is disabled by default.
> 
> Requested-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 12 +++++++++---
>   arch/x86/kernel/cpu/bugs.c                      | 16 +++++++++++-----
>   2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 213d0719e2b7..9c1f63f04502 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6072,9 +6072,15 @@
>   			deployment of the HW BHI control and the SW BHB
>   			clearing sequence.
>   
> -			on   - (default) Enable the HW or SW mitigation
> -			       as needed.
> -			off  - Disable the mitigation.
> +			on     - (default) Enable the HW or SW mitigation as
> +				 needed.  This protects the kernel from
> +				 both syscalls and VMs.
> +			vmexit - On systems which don't have the HW mitigation
> +				 available, enable the SW mitigation on vmexit
> +				 ONLY.  On such systems, the host kernel is
> +				 protected from VM-originated BHI attacks, but
> +				 may still be vulnerable to syscall attacks.
> +			off    - Disable the mitigation.
>   
>   	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
>   			(indirect branch speculation) vulnerability.
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index ab18185894df..6974c8c9792d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1625,6 +1625,7 @@ static bool __init spec_ctrl_bhi_dis(void)
>   enum bhi_mitigations {
>   	BHI_MITIGATION_OFF,
>   	BHI_MITIGATION_ON,
> +	BHI_MITIGATION_VMEXIT_ONLY,
>   };
>   
>   static enum bhi_mitigations bhi_mitigation __ro_after_init =
> @@ -1639,6 +1640,8 @@ static int __init spectre_bhi_parse_cmdline(char *str)
>   		bhi_mitigation = BHI_MITIGATION_OFF;
>   	else if (!strcmp(str, "on"))
>   		bhi_mitigation = BHI_MITIGATION_ON;
> +	else if (!strcmp(str, "vmexit"))
> +		bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
>   	else
>   		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
>   
> @@ -1659,19 +1662,22 @@ static void __init bhi_select_mitigation(void)
>   			return;
>   	}
>   
> +	/* Mitigate in hardware if supported */
>   	if (spec_ctrl_bhi_dis())
>   		return;
>   
>   	if (!IS_ENABLED(CONFIG_X86_64))
>   		return;
>   
> -	/* Mitigate KVM by default */
> -	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> -	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
> +	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
> +		pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit only\n");
> +		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> +		return;
> +	}
>   
> -	/* Mitigate syscalls when the mitigation is forced =on */
> +	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and vm exit\n");
>   	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
> -	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
> +	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
>   }
>   
>   static void __init spectre_v2_select_mitigation(void)

-- 
Best regards,
Maksim Davydov

