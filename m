Return-Path: <linux-kernel+bounces-178509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B320B8C4ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D4D282856
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A6D1292FC;
	Tue, 14 May 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kg9oIGwM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8C12839D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678899; cv=none; b=jy+7+SWAFKzqJhGuaq8VUHt2ortzOhXZ8wu8kKqlecd+Wm+oMDD9n9u8PD+YauF1pXmA6Bc3QwXeNQIhGfMay+f8Q48KtDnzOUFDW5sAakHnaqOkIFAjtq/+6i8i7YlsJ2Q8jqwXV1BXfRBotAOd3oV2aUL7aL70XUOKQGe80Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678899; c=relaxed/simple;
	bh=DqHHoI65OvUgPEHL2oxMDBqzW8QRLCa0rCxkgZXC7xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6vlIuf6PVaU1V6jIYsEA1iE6QNJWVC2gr89PL0rfU2mtnTbJT6zU0bKcrJFencaiAp4ADMba1kIw4wWdILqMhYOuS1Nf6UIg8/xo7YdYFIhXrRl3hsl64qWylBabjT5RmPe7BcoxyIfM4U+jOohASmNj7SB8Wwz+9G/PWIpitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Kg9oIGwM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C015C40E01A3;
	Tue, 14 May 2024 09:28:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ftB-Th5vj2rx; Tue, 14 May 2024 09:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715678879; bh=6ucOCJE4+Kar9qDgY6QHWqSgiolWFSGwPos5dUJhWG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kg9oIGwMHviI3+7vHsiI0dLgh7uikScL6rkglz9cOKMfjAViJ8EzJp3EzdVmrSPC4
	 FAi/dej/C8dhVKdUDhlje2j4T0a/zp9LSZYImDDZvcD8UdddmzqYTdvpKx5qMTnMsa
	 EKMcBJwxEFLkS0dJNq6qTUcOrTjdc7pE7lvy9gnD/YesgQnD/L3hXCGM+Iyw+ZlQao
	 hL16GEuLD5wSq7gCBPZ4ht5yTzulgxB5TvHg7hJOdJzCgFTiCQgugHAK5UKoq697NK
	 S0CJ0AxVw1yTanENoomOOV0SnxNe3Jc90w31yDqQv/5b9/RDXZLm30Nrn20DTuEeGU
	 TbKfmtuLXRu3xMZcAOz8wA7YZgfGiwyzoiQ+fHojuuUjAOscFM2wuVwbx8rx54Av4l
	 m/A9wmrODQDch9/MXJ701gnXmYmUVHlin3MMJavn1WHzp7FS665Ig1Xe/2nhgg/MQJ
	 OWkCKMaWpGxZuIR0q2pq+oVcHMUDZbeBc5UTbDNrpdIJ4sZLqWgx8BWfDrxvAHY39h
	 KzXPmbDbWrMxf+NHlHvQU3sCncWUv4nsoKXqFDCJabAEt2BupIMeeb8AfN+OdwbZ+q
	 3AKUtKS3CkU0dVMieCQ8ZLrMgN/rgjfKlcLD5/ePUPiS9sSUNtGZuaGvTN8qJ+hNNA
	 jjwleKIf1SQ8apEQhhLCywU0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CB2C40E016A;
	Tue, 14 May 2024 09:27:53 +0000 (UTC)
Date: Tue, 14 May 2024 11:27:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	the arch/x86 maintainers <x86@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/shstk change for v6.10
Message-ID: <20240514092746.GAZkMukkJ_q59aZQTH@fat_crate.local>
References: <ZkHLrqO1HdfQb71Z@gmail.com>
 <CAHk-=wiAXOLja2AqBzPZE+k9DKX0wjBGKZT+m2DN_hariyA0Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiAXOLja2AqBzPZE+k9DKX0wjBGKZT+m2DN_hariyA0Pw@mail.gmail.com>

On Mon, May 13, 2024 at 07:38:13PM -0700, Linus Torvalds wrote:
> I've pulled this, but does anybody actually use x32? I feel like it
> was a failed experiment. No?

Well, I did ask that at the time:

https://lore.kernel.org/r/20240322164912.GAZf22iBdqdkIFcrsl@fat_crate.local

The answer on another subthread was: "Because it just works?"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

