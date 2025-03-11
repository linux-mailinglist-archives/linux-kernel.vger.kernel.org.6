Return-Path: <linux-kernel+bounces-555937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D117AA5BE88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2671716D8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA3241681;
	Tue, 11 Mar 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P4Zt+Atv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8A23F295
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691298; cv=none; b=iaTXpA6PHTwJwqn2o1m/XSfTRSmTcC3IlQGCQI0bYQuXKw6rS8mGI522RLi/2/M7wDfRUPPIIhZSjhD78EqYSMXI1eTa2nwNrbV3KihIk6uQ7q4k2PtIA5FyjcbwO495aWTccJJ+BwqzEU1mpG0TuNipqjkK7FbE3ATkIIgi3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691298; c=relaxed/simple;
	bh=6FoDHKm/IvqMFFTDF89XEqmk3tJS307tMpypFl9jMBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiedNh3lABvoaMewyjeKa/zCMZLiGVgvk2nBYG3ar3atzmyaAsb+TbBKOyNmRrmhk67hbcR2TopqpTZjGeidixFwqkkF2qc7iEeT9Q0k7gxmMVK/0d2+4xDeSg7YmSyMywuTWkzzCNcI8U2XOgB8s2u00vMlkqcrAwr8YhdOHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P4Zt+Atv reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 85BD040E015D;
	Tue, 11 Mar 2025 11:08:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kFmp49-u7aB8; Tue, 11 Mar 2025 11:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741691289; bh=z+65kDIXST/UOECqgOOH34uY1zY0eH6+FU1xcaAiXns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4Zt+AtvfNGMUZ/WPTiisrvG8nXHOktFuWtgse3C1omQ02E3Au0EcpJUJa3+SiKtc
	 IwK/+lBzGkw5ENG+Ruu+bnnSAKrmXbSEVlWyksyZSF36j8ABjM02Z/brkz4PCHoBLt
	 GtzpJ5PTLNFVOqD9PgjXXGtY3dURGSZZpI92i7zQ4NVsC2/uvijQ61NVH1npA2OjO+
	 FzRG9Dsv0rur1qp+b6ye+G0dm0MZB6LJMW8cjfQQmujli6CDGZ20x+u2qz6590W4D+
	 kOzn1Qp88VQfiBlqha/9F6ZrtkyH+JKtfa/1z4Sr9XmqNWLqmEKSA8CW2aEh+Zm+mr
	 u1VoO5cvk7neI00cDeE7PGD1iJiMUMMxEClg7S1if7wQwcdIkaGxb/oj+KSpdWpFqa
	 TpjxlmCsdBTkZIS/YhTAIesBtqIO/NbEhMAkUltHYUU5t7nBrHSwRd+nY3q0jTr25f
	 cHfm7n82OXYvVzMpf0Dfrbu9hLW9QOLCEx2u5IQUQUJxzcdZPi/BYJ2AXSfvQGQvpF
	 lVW8g+vGKemGw1wcwbETjxDP5cTAUTrjDAUkMmeWrF9YmQsYeD5JFvMhKGbj5PLw11
	 XYKEJjkeBUY1/717apvUFFGIp2Swa1/8rQO9HD1hlEwznDznTceVatPLn4o+IdWAZq
	 e/+raW2yt+IcBAK3rDdzu9LE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45B9740E0217;
	Tue, 11 Mar 2025 11:07:55 +0000 (UTC)
Date: Tue, 11 Mar 2025 12:07:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Joerg Roedel <jroedel@suse.de>, Alexey Gladkov <legion@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
References: <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:22:23AM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> I can live with that, as long as we make it possible to make e.g.
> /sys/guest/xen a link to /sys/hypervisor (if xen is the hypervisor
> the guest is directly running on). This means that /sys/guest/*/type
> should not conflict with /sys/hypervisor/type.

Yeah, so Joerg and I came up with this on IRC:

/sys/hypervisor/{sev,tdx}

* It should not disturb the current hierarchy there

* No need for a new hierarchy like /sys/guest - we haz enough and besides=
,
/sys/hypervisor sounds like the right place already

* ...

So yeah, I guess we can try this.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

