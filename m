Return-Path: <linux-kernel+bounces-369944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856029A24B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B717E1C216AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321D21DE4FF;
	Thu, 17 Oct 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A09o1Gx5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF61DE3AF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174419; cv=none; b=gClfbb8EOgNm32dgc7QB6ZzVur1auFYkujiYETwYHZfx+O8ccb3SXo19YeTdqQU0kGlB8heL4x5lqMCVd5emFSrow4faU57ceaix118jXPds71iUceTsuB/5MaovJWMF7yG0kl6HptiFL0emqRtsrWdyf3gL9PMY2+EjEEoAN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174419; c=relaxed/simple;
	bh=wTedkcain79uf5yCEiAI61bbtWuqvd7xHHdRawQ81Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMuOtEsw8dEjrDFJoEzHNjOXJXYdCgk9ghl0AooApoPQ/LkitLlAn6zrhKFydtkLjX0140Xx1/QgWDRNwy/zFJZchJsot1pEi8zMqh2TisOW6JfbV8b37D6frDScxuDBZf4DyPK3OoP1J/VtP8L795Omxx1FEVx1UcCLvfiDYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A09o1Gx5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7D74F40E0263;
	Thu, 17 Oct 2024 14:13:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wtZMAw_AZJIi; Thu, 17 Oct 2024 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729174405; bh=rRozP/jnE2EjDN291Qoajz3TZOUHKQVyxd94o1u7j28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A09o1Gx5eR0MYOQO4m72Ne94sHjAeQhwE4FXwPGfAZFMkdWjHlFY2LiLytYwKmIXt
	 mIWsaniy2pdV3EyewDSVQzShqLu/ufjgv8J8ayPkYxXHtsviTx/gtTfxmlxAO66fVO
	 7YGttJodp0lqAWwoPU5FYcqPOBA/gj52CRpN1CCud/Up2V+rPkKWRcKVvUTsZrVczI
	 eR2Il1GK0/tWyiLc+eSbGUijKSOLcYXy540zeZ9kdri4Xi7Aj3bWUupaZbmW9ewymb
	 0RL4K7OociqYqeSETlAnqzmTuZfwhFYvzZS5deYyLESWyaM4sFdPSs4OxlPF5CKBRc
	 9mPUtFHP9W1+oR/eaVTS3CxH0EvaBbZkP1JO5CmLB6+huY8dH5CP9TTnJE4yK2aVAF
	 M4B5jPPenYHtmfijE5GEdqcLnd2n+Mefm2XAGDcSxnYD3ApiCbH8dhH9OOUdmuRB5+
	 BMg6hQ5V0Kp2nx/JeWNTk5zTdE8f0xIakUy0TqWnmzG+dEpmhyCQa4nuUzOQuJz6CY
	 6A2VDq+kH+AUTlz8zw++4RgfVPgtDDaTXdX1g2BmNYpwwz+ZlxrYYn20YlG5ghaq8m
	 /lIATZ9h/pxCJcODgeMbHWS1dJbNynon69ZWH0nWqqxNi9t1Zlr/2v5v9phkKAhKjp
	 W/AgZCqv6M2ANLqMlxgdsncE=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C60D40E0219;
	Thu, 17 Oct 2024 14:13:20 +0000 (UTC)
Date: Thu, 17 Oct 2024 16:13:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
References: <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
 <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
 <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
 <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
 <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>

On Thu, Oct 17, 2024 at 08:05:09AM -0600, Jens Axboe wrote:
> Same thing, doesn't boot, just hangs after loading the kernel.

Ohh, so it is not the patch application but something else in the code.

I presume "dis_ucode_ldr" on the kernel cmdline makes it boot?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

