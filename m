Return-Path: <linux-kernel+bounces-386973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB99B4A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C99B23F37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2092076D9;
	Tue, 29 Oct 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CecyypnX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD82076A7;
	Tue, 29 Oct 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206517; cv=none; b=jvmWzFxZOBZMSiHothNmXtrLnWeJ20fD+MSimCswNnMM7uuI1iCXYZIZlMWFwirdOK6gKFeNkvddxdsFjutbNGBMIH7d6XhTpfa8HwVhpa5BEYjzRKYHQ+V8h18FnRBqaRpyrY5trLv90IXEZbAu0/EwzRzycSdIr2JxrsGzVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206517; c=relaxed/simple;
	bh=Lsn6cUl6/piUTCl/52Vf/xwrmNX/PrQdY6jSaVzS8is=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DpnaS+6bVAl7EjIaUvxy/d8mgj0la8yvJvQvWWiWdh28a16Fr7/M0c68sEQgdWRpmyX7xINIh27tdkXFkuA3u/7YyBhemG6x/Y8ET4/LXarQZt1lEp3JkwhVnQLScKbTSz1aAL8fkq1q0/qlBDaYF9DmEpvghSh+5CeEZHd45FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CecyypnX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730206515; x=1761742515;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lsn6cUl6/piUTCl/52Vf/xwrmNX/PrQdY6jSaVzS8is=;
  b=CecyypnXsPMXfB4bwtUBvkKY9JGXyRDC0jP8NvFtSkUZSycjLmnlyqE6
   rEW5rNnQxqLk+YKg8tynkBQ53naFoICu02Rey+AxaWPmJXNSFy5PiO3wc
   Gm6a8YqDrlgcVKZAA7j+1TRb8ySZkOqEBn9IyUybfK+MN4f7q37m0FXBa
   V0R5AAvUMO62rHoyUU/JbKL7u7ILFeomk2GeWbz0W+Zl9peMm6danScjL
   eVEEmhQwDCsyCVpDGrMW8NHy2J1th+9zJ56OO6oekFVBy9a9jHLq1LP9g
   aYfxSetRrnRHyUMYd9fpM4cQc4Nl0SrGHzj5pjbV3dH3yKXU/SKxowHDI
   Q==;
X-CSE-ConnectionGUID: jH8aE7H5QbGqjHrZLMFrVg==
X-CSE-MsgGUID: MHUpA5ygRcOE9ZHDTP5dJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="55248232"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="55248232"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:55:14 -0700
X-CSE-ConnectionGUID: 08CZRuXaQ929XhqN0Ac3kA==
X-CSE-MsgGUID: ioqTcKZCSN+lTuzSYMz2hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82097361"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:55:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 14:55:05 +0200 (EET)
To: Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
    Suma Hegde <suma.hegde@amd.com>
cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
    Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hsmp: mark hsmp_msg_desc_table[] as
 maybe_unused
In-Reply-To: <20241028163553.2452486-1-arnd@kernel.org>
Message-ID: <8aa437c2-43be-4ecf-88c4-f733b1e7f243@linux.intel.com>
References: <20241028163553.2452486-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Oct 2024, Arnd Bergmann wrote:

+ Hans

> From: Arnd Bergmann <arnd@arndb.de>
>
> After the file got split, there are now W=1 warnings for users that
> include it without referencing hsmp_msg_desc_table:
> 
> In file included from arch/x86/include/asm/amd_hsmp.h:6,
>                  from drivers/platform/x86/amd/hsmp/plat.c:12:
> arch/x86/include/uapi/asm/amd_hsmp.h:91:35: error: 'hsmp_msg_desc_table' defined but not used [-Werror=unused-const-variable=]
>    91 | static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
>       |                                   ^~~~~~~~~~~~~~~~~~~
> 
> Mark it as __attribute__((maybe_unused)) to shut up the warning but
> keep it in the file in case it is used from userland. The __maybe_unused
> shorthand unfurtunately isn't available in userspace, so this has to

unfortunately

> be the long form.
> 
> Fixes: e47c018a0ee6 ("platform/x86/amd/hsmp: Move platform device specific code to plat.c")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Ideally this array wouldn't be part of the UAPI at all, since it is
> not really a interface, but it's hard to know what part  of the header
> is actually used outside of the kernel.

Sadly this slipped through during review even if it was brought up by 
somebody back then. The (rather weak) reasoning for having it as a part of 
UAPI was seemingly accepted uncontested :-(.

> ---
>  arch/x86/include/uapi/asm/amd_hsmp.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h b/arch/x86/include/uapi/asm/amd_hsmp.h
> index e5d182c7373c..4a7cace06204 100644
> --- a/arch/x86/include/uapi/asm/amd_hsmp.h
> +++ b/arch/x86/include/uapi/asm/amd_hsmp.h
> @@ -88,7 +88,8 @@ struct hsmp_msg_desc {
>   *
>   * Not supported messages would return -ENOMSG.
>   */
> -static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
> +static const struct hsmp_msg_desc hsmp_msg_desc_table[]
> +				__attribute__((unused)) = {

It seems that the main goal why it was put into UAPI was "to give the user 
some reference about proper num_args and response_size for each message":

https://lore.kernel.org/all/CAPhsuW5V0BJT+YSwv1U=hRG0k9zBWXeRd=E1n4U5hvcnwEV3mQ@mail.gmail.com/

Are we actually expecting userspace to benefit from this in C form?
Suma? Hans?

>  	/* RESERVED */
>  	{0, 0, HSMP_RSVD},


-- 
 i.


