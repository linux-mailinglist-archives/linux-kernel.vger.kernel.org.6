Return-Path: <linux-kernel+bounces-235669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FFA91D829
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6EC28616D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757A8383AB;
	Mon,  1 Jul 2024 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FjuzUt4x"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDEF4A0F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816027; cv=none; b=beejHVZz+972ybXT03CZVa1ENXR9ZkuJOURtNrUceBAw10n3AEdE8J7qT/vSGCKQ+8+BLpz6rs/bdPKIYefa1NfdG2QTH0cFVPny2HWOnaCgF6hdXGk0UVhZ6obWZF/0V3OdywNcqavzRFx8rPc4kLfYCxK+WdpUdw7Ujw9L3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816027; c=relaxed/simple;
	bh=w/bD27FbT9dfXD0xVtt8O/vtTJE6hEYbgX0obX304/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3artD84Vi1YDcxXIYySfs/I5o+WxHFJccvLqR1YtOcJNDXbzjvgUK59js3g1TuTrVB03JCkGgg7QOcArZuOH0JB1SQZmcDNM10m2YrJrv6AaDe2amxYvNg9f6QWNrducze63dphCAh842a93Jqdy7jM+0LTnFfRyfLyGwF5/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FjuzUt4x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3463840E021F;
	Mon,  1 Jul 2024 06:40:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kDMs4mNFRqVZ; Mon,  1 Jul 2024 06:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719816020; bh=uNPW7RWvc4Gi05J3X2xFF1c8MpeXPWJhF4rBi+qDDxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjuzUt4x5qCBi/K4DaljMHytND6Dyjb9ueyXpmz7i5IVu19+k66CxmZosAP/Rf5Zb
	 m0NZ5gy9rDqCeV6ownVVND2XP3W9Mvsig4APlDibTPcELsxcf1RwkkE5X6ukL0AMn5
	 ZCjLTHGnbzrVyndfPifJiZaRb15dE88uVa/Q4onFFAiM4qlCtl6+jC15HNy+9nBUwO
	 B1v2nzDIUeyQRBHKfjSEHeYruvjErW69Jm9eKsPMn0H3rB7nG7AYgY+74CYRtVz0aH
	 UKDdc1lqchOVMWTPogjSJ+2cNAyh9OBH/ccHuP6ylEC79SPo2swv35+r1HLdgEmpr4
	 d3UGd+k7EeC4J1Qns23SfsdWS6koJ08sDCrI6bDGHrZIP56/1ca1cUqvcGsdaL4kKC
	 W8VE+Tw1ta+HAwTLixXTiRLX6gYrDfbto9dpCk1hGeQ7+KXVWvstqIKiuWOyk2BhkQ
	 yFVIFslQFAJkdxcLPMw+QWRlQIOAcfwbtrfwOwjuiUsRGSztXiTJEb6lHf13AZVpYZ
	 WqpKK0Ayi6DqU6lwUXMP/L/b31d3drOhLT1tU2ibkngxW/85lnKbCvS6dRtKeV7D53
	 bVymBZE7mHVdzy4Zt5BQRglZp1AJTrd8zDWegbnuAQnuiqkwCyAdX854qE79B7pwdO
	 pZsV+Xu/j/ac09DjXpWCT+O0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D8B540E021B;
	Mon,  1 Jul 2024 06:40:09 +0000 (UTC)
Date: Mon, 1 Jul 2024 08:40:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, peterz@infradead.org,
	brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: Re: [PATCH v6 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Message-ID: <20240701064002.GBZoJPQg2IXSCRa4sN@fat_crate.local>
References: <20230112072032.35626-1-xin3.li@intel.com>
 <20230112072032.35626-6-xin3.li@intel.com>
 <20240630160448.GAZoGCIHXRuBY8sLqW@fat_crate.local>
 <3A846C73-305E-4C55-B846-AC00657BA95B@zytor.com>
 <20240701060841.GAZoJH6XpJz6qyo-Lr@fat_crate.local>
 <38C69EA0-DB74-4D2A-ABB5-CB3F1D31FB0C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38C69EA0-DB74-4D2A-ABB5-CB3F1D31FB0C@zytor.com>

On Sun, Jun 30, 2024 at 11:31:42PM -0700, H. Peter Anvin wrote:
> Yes, all loads into a segment register are truncated to 16 bits.

Right, but are we saying that somewhere explicitly or it is too obvious so
that there's no need to?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

