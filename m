Return-Path: <linux-kernel+bounces-518250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C1A38C42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B870C18911A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE291236A73;
	Mon, 17 Feb 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZeR7bPUg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0AF187858;
	Mon, 17 Feb 2025 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820168; cv=none; b=UveFId8kZuVs3SUbbvnA01CYH0R2sIt3Rc14OSN9FDKtESmlx8kEUrT2E9SZXXC9/SL5U/NKrKcth7dl2DcQl1froAPdJZLbS+4cHt3TvUrWbtIK4IHhLOVEEu92W4CzqLOhxe9xbnM9eaMQghwZN7WstGcVB7fUR+MjHrRYTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820168; c=relaxed/simple;
	bh=ijo4pvzem5MMENskXSi+EMmSoU5iA/MGnzwRm8gKSzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXieleRKb7jk19l14XMc169mwn72M59i2+vGYhSpZadCgnfOgIa0NvQodlGdyOLMfq3aHoevSHzemiukBiSBL7y4xbQ9N/HuP0OI3I2wiH2QjlVMXSuwJbjwx1WUfEZW4PEVkuM6dKc0/qiaQRskqJy6WoRtzue5OswWfh/+HpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZeR7bPUg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CCF1740E01A3;
	Mon, 17 Feb 2025 19:22:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Cs5sXHgQX4cq; Mon, 17 Feb 2025 19:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739820157; bh=tB7XeNDFmO+IfCmGxJnspw19Z/0mgsdm0DNMxGIAHBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeR7bPUg8cK06aQ93Y6dcqO7MwRB9nWkM9+n9luqsHXHR0Esn7fvFvk/GQprtvPNZ
	 oalxAxjl2rp+rWoV2v2ihIJUb/dy9l3kkx9pv1JzygvqmaNOrAa/pz/leMav82Hpz2
	 Y/qE7WzIOqV3rkjOqqWFY53eF6oUgu2hjD7Z5ZTB4y+Ltie9zu2XTZ5GJdYyrxFIHb
	 N80FbBO3NNleMEnm3Kccidy2jpQ3sQvjlN9nQpdo4qQj1PJ2uIeD2sFMxPQLF/3c7J
	 VsygtWVSV+uz0rZ6FKTE22KH2kSu7xhXSyu89IvhxSNewaHZULq3HATo9+iL986eWm
	 dBNlMDJKo9cnAr8HgwZDeDYLmcfHPYOXQXyFhLFjaYmB6xeQRz6GnbU5YD9nBs7z6e
	 u7MS9L2wostEEmp5ZLj/xPVVEdlr1j9PObvi6j17vVVKNf+NxlPE+Gpw7hLj/cHfzc
	 LPT0RkpXwYEAlvKPVivvuwWFxQ44X+ySrV0WYaTaQnixWvjmN6Gcc49eSypn+a4JSK
	 U6lX3sJpilrJqk8H92vTjMWZmMa41jU1ZxSa9JAYaTNeEtV8u1rkfqDgRfZw+zjb2I
	 dmqdj6Uz6JQihFd99w6/tJSC7mihywarpRY0rRObcnPxFb9yDYglqDZfq20912tXMK
	 0I1ZAJu58OcThhlmBWW0NE7I=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7850540E01AE;
	Mon, 17 Feb 2025 19:22:27 +0000 (UTC)
Date: Mon, 17 Feb 2025 20:22:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/3] x86/cpu: Enable modifying bug flags with
 {clear,set}puid
Message-ID: <20250217192221.GHZ7OMbf-bgNWZ8coq@fat_crate.local>
References: <20250129-force-cpu-bug-v2-0-5637b337b443@google.com>
 <20250129-force-cpu-bug-v2-3-5637b337b443@google.com>
 <20250217111029.GIZ7MZJUGJRoeiScgn@fat_crate.local>
 <CA+i-1C3fetiBYVbfpAbQEAnogzdza25pu2DosCiTT9YkXwt0yw@mail.gmail.com>
 <20250217170817.GGZ7NtAf-mg-zySpdP@fat_crate.local>
 <CA+i-1C0=tDMpfZqNq0aWns=cj70UOOmCAPOonmJi+MM7B6G9Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+i-1C0=tDMpfZqNq0aWns=cj70UOOmCAPOonmJi+MM7B6G9Kg@mail.gmail.com>

On Mon, Feb 17, 2025 at 06:20:33PM +0100, Brendan Jackman wrote:
> But for bugs, they all have a name. I was thinking that this was
> because they are defined by the kernel, that's what I meant by "It t
> doesn't make sense for a bug not to have a name", although now I think
> about it we could totally have a bug and not give it a user-visible
> name if we wanted to.

Right.

> Anyway, still think the current logic is what we want here:
> 
> - The new setcpuid should be consistent with the existing clearcpuid,
> i.e. accept numbers for the same things clearcpuid does.
> 
> - There are currently no bugs without names so for those, require the
> string for both setcpuid and clearcpuid. If we wanted to we could add
> number support later.

Right, let's not make this more than it is - a hacky interface for hacks - not
to be used in production anyway. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

