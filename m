Return-Path: <linux-kernel+bounces-407637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096379C7051
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AB6289DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE51FB89D;
	Wed, 13 Nov 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G+0hAo59"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9671DF251
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503461; cv=none; b=k6VztuYzMG6Q/ZEp0vKa0orGq9DEgRKeeLJ/bkpNyHVMW0+YtGAIuGkcjsT/G7sa3ijAfrSlX8JG9EYM7RFqiO0BsEIjM9oNW3+H0/DeMF0zjVYF6AkC9jmqMDACaFXz9RtFAjd71s6vCdKjcHx11TUiG3Fw6Z2WxFw+WbSNZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503461; c=relaxed/simple;
	bh=QxiaoUTU7jyrQOVDF0RojWRQH9DttRiN/uEvHY9qeR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWRBb0HslxGFnaZbhaF/RP0YPwHaE7oMGvmun0M/bhQxJ9pgXtViq/q4wNE/Kk9ArAimGA4h4mZKQ13BzF/2M+CdyB7LkuWad4oeoQwXyfFQ8AuwYh44OlmHzQ4frFkPyQ3TCr+dOiM15DL1E3X9GPIDHCMp1EivjmUxT91m/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G+0hAo59; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 523F140E0220;
	Wed, 13 Nov 2024 13:10:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vuoekss1_OQ7; Wed, 13 Nov 2024 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731503450; bh=Sfzc03JVYWl2/fAcy2h3p7MYjG0zbRyB9F3VXqD2ySM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+0hAo59PhTUrskSe0BdZ/zZBYh/qtheA69kQzPV219hJ4ef4LnOp36m7tejA1uzu
	 wSlNCmRPJvtsw3sAITq9sXCy27+80Rcb3qDNZNhoStRbNfxe1OW/TyWUlcKw8LjHHK
	 zj+bdKa9MISwO/EKO0lJ5NC/9Sv4IS7eyyCO8Yobm/IvI+tO6QbWGviveDm2W5dBX1
	 h02b0X4cl8DJTecocLEmW0x4wmK1zg247d9zhgbzBZKTJ1t5RqGi7IUqYMddYK/zD2
	 XMupwUT5o1/gmpy1negiAAuRahyXyBAZe2+Lz81rwF0N/yCJXATwUOS0cgx3RiDlc8
	 serEms7L/sJLLXY6cbZJP9noL8sKYgfMtLNal9fPE//0KJwSwiFmZVgWSEQNfl9/VX
	 aMn+b0DMiTmsFI4VeP540DiuYtCN2Om8MDKBAeUHjtyzGTJ1f6/pzup1N413nWur0+
	 Q5ypYmSkaqnuMRJXDWjTH0MKeuQ0zvMP3kq9pIHhCcRfJV+p64dfTgDl0VeHR0+As5
	 A+f1w7PtMTJcalteJkqv1MF7wGHT9wHfnnYsx2Hraz+bU+SO6mHktiAGuGGArdg7VZ
	 M6QO5NpovUAGOJeNekKEwQ+Hhlz3sP9VnIhiNX0bpnje5WPRc1COmxa0HQ2+mV+Hxa
	 iyKzJyUuZSCSG1nQn/4xWlmE=
Received: from zn.tnic (p200300ea973a31a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:31a9:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABB6C40E0219;
	Wed, 13 Nov 2024 13:10:41 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:10:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <20241113131032.GDZzSlSIWTB0zS9Zey@fat_crate.local>
References: <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
 <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
 <20241102110618.GAZyYHquhmVJd4yM9O@fat_crate.local>
 <20241106112052.GCZytRFKTESZI8_3qD@fat_crate.local>
 <ZzSh0/i0HXDnfUof@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzSh0/i0HXDnfUof@MiWiFi-R3L-srv>

On Wed, Nov 13, 2024 at 08:55:47PM +0800, Baoquan He wrote:
> I finally got an available machine to test below patch, I can confirm
> that without it the breakage can be reproduced stably; with below patch
> applied the breakage is gone and vmcore dumping is successful.

Thanks, lemme queue it.

> Will post cleanup patch later. Thanks.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

