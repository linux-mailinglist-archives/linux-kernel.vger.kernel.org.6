Return-Path: <linux-kernel+bounces-432797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D219E5070
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F38C18825E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851471D5165;
	Thu,  5 Dec 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fxnHcbl8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jGVVtIXm"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F344B1D4618
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389201; cv=none; b=VVWgihLMHvBb7pCM1FidhPP7zZeRhz98ByiF11tEVHNMSvRsgrmJeoGxp+3iMhNXWkHUTuP8U2AnPK+j0PHdkN2zo4trrSZObKWf0p8RcK/QNvyG9wo2u/HST9XpyVAR3vWvWWqmtkDEQL0uhRlDnMlPWNEmVKncLE29TdZ8TEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389201; c=relaxed/simple;
	bh=zsOwpa4T1jPC+e3g+4dto/kz/S/JegpZ30Z7Bvn73Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCd6ag11f3yc8VgUw15k8+Pb/XNuKUo8WXasf3xGSQZNVD0+2XUMu2eDxiDdj5bSfIPhrDFbFPqOWkfyLbvsLOGKsnA+Y3JM7hgVQGGNucSTclW9F/M5vL7XmahEYLubyTA8P8a+YCNm5AMvDSDEPCEwsTJLANbnBOk1r+ZSXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fxnHcbl8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jGVVtIXm; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DBBE92540244;
	Thu,  5 Dec 2024 03:59:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Dec 2024 03:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1733389198; x=
	1733475598; bh=wuT2PkkwVYkYU9AK+DF7DrhiXtqcwFLdzPycwTH9Dcs=; b=f
	xnHcbl8UBPq0IKO7l8rjgOyCfGqXr0pRLk93g83mnc5MOrNwKPiduuJWZzCHa0+y
	3zoBBgzfLBMXpaGYeEhBdXAbzo8DTiTuR/o0R0hjI82b+DdijFJwzvsOq1qBts63
	f+rH90ZyZkqkdZ6jUmOoWz07K8YLpM5SpMxUGSJxq+nVJuiBYEQbxXa1UY1NxmWA
	5dtfbUqdmBDWpePltBHfgzKOr8Ph9TMcwYdEm+eJWxi9uIJtFcZc++CpfDMCOae6
	GrgxbZEDQVKULf+y72k6lZpZcNpnCHpwIEVeHrKwmJNF3HCzqKUzM+6hRPiPy28N
	640NjGvieb5Qz4XxbuoKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733389198; x=1733475598; bh=wuT2PkkwVYkYU9AK+DF7DrhiXtqcwFLdzPy
	cwTH9Dcs=; b=jGVVtIXmM+9Z2Q8BXOLckcpdp+UsUBSXp/QRCqMGxYFa9SZ4drZ
	lwS1GW+/AOl6fOlYVlzvnoB1UdVWtkxexIJbQqRLjmS9Q3w34aUS2ghiBwEi3kFw
	3vNjgFDP/U4nX38ml7wBgoSR0OYwoyWW89NZ50sDfM14tBZteLLqru9+k7hPaaTi
	XoPMsmtOhZjVoZV92UnVpNBgsfKssgiIsQjAuz6uDih2NLlNDJpsaRGDirJIPBoX
	8zxsiD1YrbnHLldTgP5hLnKnV7Fek9wRjB1gKs54SUTtJ0fUr9FLk+J6rTgR/RB8
	7jg10DQzaGHmd1EjQB+4RYkEXwMz+ZZGzYA==
X-ME-Sender: <xms:jWtRZ8RhBS1tef7tCiv9d8u6qu4aNFTLNHUIJT0bldjnjgOKAgCmnA>
    <xme:jWtRZ5zUxmHHMVTaLUO_l3r-ilojQSjWRNPurlUm0WSUIHudu87DpmWkozjyFR7Ac
    7SHAwWkRX9NGyI1rrc>
X-ME-Received: <xmr:jWtRZ50G3YN9huYoTcIxyxdec5tLLSbUjxQncFcVSXSzjMFacI17aegepYF7I_0DptogQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeigdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhi
    rhhilhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtth
    hopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthht
    ohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthht
    ohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtg
    homhdprhgtphhtthhopehlihhnuhigqdgtohgtoheslhhishhtshdrlhhinhhugidruggv
    vh
X-ME-Proxy: <xmx:jmtRZwBLrDyW1_lqMlwz5_vxbBE4L2nkSr400LkVPb93oA0AjzOG9g>
    <xmx:jmtRZ1izAQGzck2w14mxf7r4EjGUbp4ACiJZyZeulCLV8oo0Tu2SDg>
    <xmx:jmtRZ8oI4RoxzznDGnv03LgvMoU7QeYVrX6v_lYYgpuS5jrxinXLUA>
    <xmx:jmtRZ4jLi1g_4n8BglJXnG8UvS9A0_hBsRqnK-jPJT1_L9-tdoiMxQ>
    <xmx:jmtRZ6bLGxnjfSvB9pRFeUURw8IgnCipUIYya4JAChcKX4TtcjBN-0Lw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 03:59:54 -0500 (EST)
Date: Thu, 5 Dec 2024 10:59:51 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Dump attributes and TD_CTLS on boot
Message-ID: <masdihuund2tead2a5mwi43gzsc65fylugebz4vdayyaxqzklt@2vqq4qu36mno>
References: <20241202072458.447455-1-kirill.shutemov@linux.intel.com>
 <29f0ca88-acab-45b8-a625-5f1b5ae23aee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f0ca88-acab-45b8-a625-5f1b5ae23aee@intel.com>

On Wed, Dec 04, 2024 at 10:41:17AM -0800, Dave Hansen wrote:
> On 12/1/24 23:24, Kirill A. Shutemov wrote:
> > Dump TD configuration on boot. Attributes and TD_CTLS define TD
> > behavior. This information is useful for tracking down bugs.
> 
> What's actually getting dumped? How noisy is it?
> 
> Could you provide real examples from a real system, please?

[    0.000000] tdx: Guest detected
[    0.000000] tdx: Attributes: SEPT_VE_DISABLE
[    0.000000] tdx: TD_CTLS: PENDING_VE_DISABLE ENUM_TOPOLOGY VIRT_CPUID2 REDUCE_VE

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

