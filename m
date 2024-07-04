Return-Path: <linux-kernel+bounces-240719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BCB92719D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C131F22FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBC1A4F1E;
	Thu,  4 Jul 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JL1dlv0O"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35E1A4F0C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081450; cv=none; b=BPBnElVe8eRQizj2KoDCmJvP2y2TS2SN5XaznfqtA9WFUU9uwjn4gpPYDzBd+rz5DuBgYISZ1XPR+brI3d1Ud94d7lUAq50xU+r5TcrVUJ0yi7CoY8dEqC4DTwEK7PhbtTfiTPLJU2QqiwDssS3mz52ukzSyIQ4inHFjv/wJxXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081450; c=relaxed/simple;
	bh=SsZGFCSeNd6pOIw6sW2l2UnMS6vQBj2fSUuu2slqcz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAkih8VUTfvLXGv8lYgkGSNMtvQPVjqmC6TV5v5DO2oyKEIWMX9CpoogLpnlg9H8ky+9izZH5ZBKd1lzH2SWglocN6oFkveUquHCx6lDiLCzzND0CoEuzUaZZarXMW8VMPxJew2J20z2Bzv8FXeMBy0mQwOgGydJT113LTjvviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JL1dlv0O; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C8C940E0187;
	Thu,  4 Jul 2024 08:24:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RCBGzG_T4uXm; Thu,  4 Jul 2024 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720081441; bh=JdFPBoVuOCOhlNcwTSA2y/2iB7+DzbcvKLu2Me4HYvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL1dlv0OLpL2wZvWwrhVFdvY32gpN/Buooi04VrPufdWzrDo2PYY25Y7RJvxwHtro
	 4/quIxMAT2ew+Usv1/SDfskCZ7tFrfrBvQoTqwXuPcZlfpRrCWimlAdzToXN2dOiXA
	 nUd7nPnaUn+R63jF3Kdl1ptNXjQ1FXdVgAvt3URRSY0eTBow0j7ZyH06M23xYXh+jm
	 g5nxAtxomLJ/z6DxCtzuxHde+ew/R1j1Ip9Fmr+a0X4X2fkxTeurPNqicfO6I7/9zZ
	 zMIkoa1ar8GK4i5XFG0wfH2uXSx/f5Unk/YxHm1xqZ+lI0MvZ0PDBxPsImaM+NjPPF
	 TqgFfZVD/nMrN9kYGygQ2iflVEDvinUVbKBqbiw5B7oBs1qGXcdwFz7O7ltVvZNN9H
	 I8aAND5LqJDyCChy9hlHhTrkpf1PT2bc7IDIX4i9jyaKK2L/6tvwNrkUoVTDUma0Vp
	 0Sj9R5tXJApBHPZs5Mzi+H8II6ph/95IeDp6Msuiw+lA8u92JfELJuT3btkxXvIDY+
	 +JX7UIA8kxa2BAviAL/iKArEdi41mRmWetsZSl5IV0XgjSsu+jTH73X4tcJW1WwlO4
	 XjY1xBftzEeNVmthU5bHvOLj9RNKDaLyJXw5HHwnpGG6MCz5D/S5ctuMhHwp4saa6b
	 H+GqGHozh8ux2Q29Y7DrZ4zQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4ACDB40E0177;
	Thu,  4 Jul 2024 08:23:49 +0000 (UTC)
Date: Thu, 4 Jul 2024 10:23:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>, dave.hansen@intel.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
	nik.borisov@suse.com, houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
Message-ID: <20240704082343.GAZoZcD-yGxjYajcJT@fat_crate.local>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
 <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
 <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
 <56909a1e-b360-4090-945e-cf6ec623cccc@citrix.com>
 <ada20b3c-2935-4d4f-8daf-ba7b9a533877@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ada20b3c-2935-4d4f-8daf-ba7b9a533877@zytor.com>

On Wed, Jul 03, 2024 at 10:57:29PM -0700, Xin Li wrote:
> Won't it be way better if we could have all x86 vendors agree on it?

It would be way better if you simply do it as I suggested and stop debating.
One fine day you'll know why I'm adamant about it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

