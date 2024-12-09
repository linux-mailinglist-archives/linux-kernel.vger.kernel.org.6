Return-Path: <linux-kernel+bounces-438386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7FA9EA08F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A5E1883FED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6761199EB2;
	Mon,  9 Dec 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NpOt3JcG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB2C13A87C;
	Mon,  9 Dec 2024 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777151; cv=none; b=M26J3eitL27UAwpGiroosJQW8k1eSUQ5YZP726p1xX7/5B3lWkyoQYvxMr5V5fL6xKfWTLdRoGD2k3SF6KCQhiSxxMVNHJUyCmHHJ7U0v/aT4DOXCdx4e4YIAVZmOVv2WiGDl6kh1oL+UD5wZk0aKQDBBbUYc760/LqGfMmjjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777151; c=relaxed/simple;
	bh=qUAagJIpDF3OqJgI/JNeO9p1jV5nt1/ZYM9qFh72Rq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU3wrS9Ku3YeEt9f+KzRd9uFss3ikpJ47wbycJ42GuBqViOmG4ooRpqzuiYMgOnAODcyLwJMUcaGqgwP5h1Ic2PcJ0Raqi86p798tBnuBm761DM05qncKQBExvbcMWEWjZuW1gBBM04iBF9vydrAQltnWutiFHumCf0zclsb3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NpOt3JcG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 871AF40E015F;
	Mon,  9 Dec 2024 20:45:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5YwQo64KWpJT; Mon,  9 Dec 2024 20:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733777143; bh=kdtyQcVH1bqzeynb/peFrnCJsVTPGjh/mPNrfJwpEjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpOt3JcGjtGqouCpns/G7Iu2UhQq3lgUnes35i81H5hOnKs/jUybDb1PUfNxCsC5A
	 JYjerrRuWDdUngPoLP1s4x/uNHyoGaQkzBsSVuhrwnh3WK5hpMH0/WIkd3CzMptjnE
	 DHmraw+pxNr63fLH/xKg502y39l3RE3JKw40z89+GuYUb04gXwKxAQpaq+LS0c0oRb
	 a2xhPoXmIzBLFX96wI/ZRm17hrlEDoe6uKTvZMobSg7rLOakcdwP13t8m3ZvVrjyVc
	 7iISXSTP4WSbNqh4RF14BI1RHz1VB6F36yLchyORusRWkLHpui7KvJ+Fxe9NVQTXns
	 d4wJc7RH4+0DX2z6E6SRQbls6Hq0Quyw7mOwEprPCs8SdsaoEnT0w7sepSZJNSPDUZ
	 ynPtDkqheg7IE2P1sDHqRpo08N/iBD6L4GTjQKzZyuMZtDBB7B5h4Xa9OHtleBDEFM
	 8WVdMwphplpqWJx20c4U09RVxqA6kLksDsvE+30Gb4k5+By5HQxFNVD2eesi8Rci0B
	 Ze80Lz4DA8Ua3PhNi1+S7Ll6kaE1tgIaS9WkMHaHB5GNPGJyOBEvtEMT//0RGugttv
	 uz/byte27sFZOonhnLxDEXwJe7JoVSaDLsWSI5NNkY61uwSw5C47DLEd6T5uyLUhnR
	 LSC4XDagtPKn3U4hF8VbMk9Y=
Received: from zn.tnic (p200300EA971F9307329c23FFFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E0C3840E019C;
	Mon,  9 Dec 2024 20:45:28 +0000 (UTC)
Date: Mon, 9 Dec 2024 21:45:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v11 2/8] x86/resctrl: Prepare for per-CTRL_MON group
 mba_MBps control
Message-ID: <20241209204519.GAZ1dW3-NjcL4Sewaf@fat_crate.local>
References: <20241206163148.83828-1-tony.luck@intel.com>
 <20241206163148.83828-3-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206163148.83828-3-tony.luck@intel.com>

On Fri, Dec 06, 2024 at 08:31:42AM -0800, Tony Luck wrote:
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index d94abba1c716..fd05b937e2f4 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -49,6 +49,8 @@ enum resctrl_event_id {
>  	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
>  };
>  
> +extern enum resctrl_event_id mba_mbps_default_event;

Any reason this extern isn't in 

arch/x86/kernel/cpu/resctrl/internal.h

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

