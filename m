Return-Path: <linux-kernel+bounces-541314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7EBA4BB4B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24055188BE7B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECD21F2369;
	Mon,  3 Mar 2025 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="k5ubPbsx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7OD48v0"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CED1F03E8;
	Mon,  3 Mar 2025 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995650; cv=none; b=bcg1yO0pJPRZYmvdk6jpjGEW8oxSZ+lrkyfXK3fnwsybJ9lvHtp+MYTuP2RZhBnGZWPTkfOXclUpW6fXujsc6FZ0pxhxkSG1/z6Nhy/cJNJO13MqS5eDrsrcBHP96Yu2oZkL1q1KEAVoQJsTJfaSOSxSI9BQQC9usSXUEWig8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995650; c=relaxed/simple;
	bh=FPylrXqr8mexepEWXAgPHj2+DeTVmkWyz6LJZ22uLe4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BQyQkhRyCdA5w/lZWpfeP9B3+mc259QVQQjVkFi7dOsNHypUmabzak3JBUbYiOU6zmOscDJZYqv5zOeYz3J0pBtk+LwMuCcr4dtIavGy5mmtuq9Dm90uIXm/VEFXV2L36vno5MFu28Z9X5chnGO2DfmLNg0ef2TxvSyplRhycAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=k5ubPbsx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d7OD48v0; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id CA0E1114015F;
	Mon,  3 Mar 2025 04:54:06 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 04:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740995646;
	 x=1741082046; bh=i0sKfI9tTTb1ZD2DRP7zdoUwuzXHxf4k0a/M8kjuyBs=; b=
	k5ubPbsx6tA/kYMwljhSBfc5Yvqwz/HTODm+iQfpLWPVHROMLQF1cbaGOGMIpYeB
	LWyMOo5S5eHBiFUNx68UlmhtjM8zgJuSkJOx10goK3BmDmeZuW/nB9GsEp9x931c
	KRRgXv9Dw9GmSH37cOA6NqUQztwJz0/nxjDCVSNnaY0eGEQRD8g67KxtuZnK1K8z
	6HCjEzYmJPphusUyuGkWj5qVgv0beyq0pzGC+jcORyRI7WvB982ByxOkV5PUrTIe
	jvZrVTNCMfpQkyT0Cs7wllg+cutFmntGhVNlBPjHCmlByLsgldFquvbfe43FUR4C
	g4L3XErkvwYUOSv/Axz+Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740995646; x=
	1741082046; bh=i0sKfI9tTTb1ZD2DRP7zdoUwuzXHxf4k0a/M8kjuyBs=; b=d
	7OD48v0w9JZvh49zjOhKBIFsiknSxygZ8q7KKlCQ/zfqv3Qy3OhIqkk7ba33of4e
	WKVvM0t0jce4ZsQw5VBv/c+RB+IgWdyTVOw15z0s/plzN42OjZT7/vAG6b9sD7+h
	KaNgm7AQwXSprf2q80kKi8s6VX5FXvY2BqZFyx9WDJTw9BVMaX4lnmuI9ndtno4F
	afnNq9E/nJYUwtqWooWy2A6ZTLR57zretvz8u1KO91hjGR9zGv4D3/9pkrnhNAuG
	N5f3Cb2rRNZRabjs3ZDzpQywLgc7ANkvAWlNP7EYsc0zNIbQTWBb/kcGQiWG8W4/
	f1ZaTa2G294MU2whSLcXg==
X-ME-Sender: <xms:PXzFZ1j8h2lARuucU8b4g6ryyv7zT6H60UdhcIrqCHfodbAZBHbHwg>
    <xme:PXzFZ6Cds1SpPMUIDAMnm5A1MQT9K2PAYonLzqzVYyzP5I7NtPmhs5Ry_-sOybfja
    3mKToBEK8_ebkAorZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehl
    ihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinh
    hugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigvghnqdguvghvvghlsehlihhsthhs
    rdigvghnphhrohhjvggtthdrohhrghdprhgtphhtthhopegsohhrihhsrdhoshhtrhhovh
    hskhihsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlsghulhifrghhnhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheplhhukhgrshdrsghulhifrghhnhesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:PXzFZ1E1-HaRsVwkZ1MhIegPAvtdR8mGUCheay-RQ2IP5t8ZMZEU3Q>
    <xmx:PXzFZ6TlJFElnaalbNy1m0NCFLMKP4Lb4tZgehC3tYqvYWMufvf_ig>
    <xmx:PXzFZyzjetqnFT-CQkBgwbqCrpfXHAc8tneFe15T8K4x8AOg23mBEQ>
    <xmx:PXzFZw7e4oNHlTkOvg9eXm2F0-krLJYvzuMIGwMvBHGelAY4NUwZEw>
    <xmx:PnzFZ9oIir42QEB-DozqsPBjsnF7ISxS98FsvsrM8lUkqPFOTMEimo4Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D37942220072; Mon,  3 Mar 2025 04:54:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Mar 2025 10:53:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lukas Bulwahn" <lbulwahn@redhat.com>, "Juergen Gross" <jgross@suse.com>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Lukas Bulwahn" <lukas.bulwahn@redhat.com>
Message-Id: <c4f1640e-3046-4ad4-accf-bdfa97a3ce17@app.fastmail.com>
In-Reply-To: <20250303093759.371445-1-lukas.bulwahn@redhat.com>
References: <20250303093759.371445-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] xen: Kconfig: Drop reference to obsolete configs MCORE2 and MK8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 3, 2025, at 10:37, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit f388f60ca904 ("x86/cpu: Drop configuration options for early 64-bit
> CPUs") removes the config symbols MCORE2 and MK8.
>
> With that, the references to those two config symbols in xen's x86 Kconfig
> are obsolete. Drop them.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Good catch!

> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index 77e788e928cd..98d8a50d2aed 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -9,7 +9,7 @@ config XEN
>  	select PARAVIRT_CLOCK
>  	select X86_HV_CALLBACK_VECTOR
>  	depends on X86_64 || (X86_32 && X86_PAE)
> -	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MCORE2 || MATOM || MK8)
> +	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MATOM)
>  	depends on X86_LOCAL_APIC && X86_TSC
>  	help
>  	  This is the Linux Xen port.  Enabling this will allow the

I suspect some or all all of the other three options should be
dropped as well, given that 32-bit XEN_PV guests are already
unsupported as of

commit a13f2ef168cb2a033a284eb841bcc481ffbc90cf
Author: Juergen Gross <jgross@suse.com>
Date:   Mon Jun 29 10:35:39 2020 +0200

    x86/xen: remove 32-bit Xen PV guest support
    
    Xen is requiring 64-bit machines today and since Xen 4.14 it can be
    built without 32-bit PV guest support. There is no need to carry the
    burden of 32-bit PV guest support in the kernel any longer, as new
    guests can be either HVM or PVH, or they can use a 64 bit kernel.
    
    Remove the 32-bit Xen PV support from the kernel.

and 32-bit Pentium4 and Atom CPUs don't run modern Xen hosts.
Most likely this should be

   depends on X86_64 || (X86_32 && X86_PAE && X86_GENERIC)

to say that running 32-bit XEN_PVHVM guests is still supported
allowed on 64-bit hosts, but not on pure 32-bit machines.

    Arnd

