Return-Path: <linux-kernel+bounces-342360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473BB988DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71682828CA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 06:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A71019CCE7;
	Sat, 28 Sep 2024 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DuqcTp/9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1004A08
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727503880; cv=none; b=HA2bqXPseMGNFolcbOJw2jU3xN9ucvdKizWQbal/ypT1Lo1NwaYL+KGuXoV5RIwdrX4SSNz4KjjI7ACQ7+J2Gqbtw7lCIaHNpPDhUa3NrPcIcKALFYIvX5+oLleYkxSC07S7GH/FDi7eokCWycplLCSZcRre2FMNnrxb++X3Erc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727503880; c=relaxed/simple;
	bh=0nfg07gISJ0hduKB/h+3tQH2N1N8nAjDyUrcFD4rKpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiYYIkblZEIWhCoh4qRAbujG6JCpu9bnKJ/LwaHJ5UmfqPJLQ+MmFf0PeqZeN3ZtPzyBlLYCjmTt4Kb7o1h9sEGUMuLcd+rdEvcyYAlbhUp0shwTc2Lpu2OoDE+39ZZGD8u7nXSOMhQ1AJ9a19JjLyZLx5Ua4v7ia0aCucT3yNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DuqcTp/9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2855140E0198;
	Sat, 28 Sep 2024 06:11:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ICfbdaPbIOBX; Sat, 28 Sep 2024 06:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1727503860; bh=g/PN9npfORrgMBLWXSDx2B4kgS+VNanMYpUPMfxbEDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuqcTp/9IHtIh68GEoR5MVnOfDmURb0RVWPEQ8iVhLlox7lJzfPYrAERA1mgd6JkS
	 KSpAn2wlPFoeftT1gs6wAT4Y+U1mPJsGQFoa1WZT5JY3H55S02Z5IzCfOewzpmSPXo
	 xCBvKOLjUBLJlZOuuRzAqTsjfolwIzMxp8lkuGJ7uGCY9eIYWCPVTuLt87Mk+K4bYV
	 FqkGiMPpZtNQn7UENiIGjS1n72OSKq11lHNH3CljyveUqQ76k8fTVfVIep/htkCFE2
	 zKrDspUrCHfU5W8q+sKtlkDEF5ks0E8DxpcNCn4W4LUs4ZeW9ZIgqCp5k8L0/EndWD
	 FT8SRt01HQO324w+lTFX8nGRWKhyOw99waWMPajSBKsv45h3nIQ3EJkdYLJ4Pr3g4I
	 MD9xwI16gX6iVU918IsSypDiJIT7vTwnNKp2pW6ibEHbpaqcSxj25vrTx21twT+01m
	 bvFFuD9J8OP32hdF+jL0sG5vuOnhLOlApqz4i1Ni8bea1QuNQ4Ovd9uuV0qQMiFIGk
	 cCe97/y9q0a70mN+JMsCLqi21nNmEDYhd7HANHItMMvOdtbM6GOvVom3dJrgHl8GSL
	 RHYZL9wB7BgxwG6/jTCFm599l6vi0v+zIzIL3DyXEIKb7/4O0AVkY8VtN7sMNK58hY
	 hibNVb+ENT8BgM0gNpzhcZcQ=
Received: from nazgul.tnic (dynamic-176-005-049-203.176.5.pool.telefonica.de [176.5.49.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B05040E0169;
	Sat, 28 Sep 2024 06:10:56 +0000 (UTC)
Date: Sat, 28 Sep 2024 08:10:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>

On Fri, Sep 27, 2024 at 09:17:46AM -0600, Jens Axboe wrote:
> which seems plausible. And indeed, reverting that commit (and its fixup)
> on top of current -git does indeed solve it.

Can you send full dmesg from that kernel with the patch reverted and
also upload somewhere

/lib/firmware/amd-ucode/microcode_amd_fam19h.bin

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

