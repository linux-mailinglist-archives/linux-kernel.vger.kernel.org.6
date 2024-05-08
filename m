Return-Path: <linux-kernel+bounces-173366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF198BFF78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8891C234CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443585925;
	Wed,  8 May 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="oaLWVIBR"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF985281
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176173; cv=none; b=JTZ7wbTgkiF0Fjt51LdFs60xCOLSf40rJRBAnEt7dMS7e9oQy1tvxcbIwDCdKrbwMf1D26JBva5leXzvzbj0xeJOBejsQvHu/OCBljM+4P1vtZyNPCDtC8LceEryfPY/6311Z8BZ9QdnKGC03J1A1a+WGvDTwhGwoYP5SGWTxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176173; c=relaxed/simple;
	bh=mpiOMSIo8N5CvTUQbGXsw/wRovpyhcBVyz7wHpXiX54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ASlDeZxDXk5OP7nc7BdWEU862cMbMD1zoaTkVSwhlHVCi8sDpmX5aEFdaCcjbaVzFVtUqhY7WX5N1G/e5st4RoiSPWZ3tuFM1lvHdGkUiGEVOlU9WMfTSwT6f3IG4X+Nax/VLgcc1OVzkFymvoNvQdMWokAIAqFl3u1iT63x6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=oaLWVIBR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1715176169;
	bh=Dj3GCx1b2Hv1ldLYLeGFgz7QVzoUwpL4vNUihbESG4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oaLWVIBRmA3DNMsBzS2quTFluM+qCWDh/14ih77v55tHuPU6xcCHEa9+v/GzoDcOf
	 IMVg6hOLXBbwYDvPmTPsZZAWz7HB6vTyw1bxfbwxMpw3BZf2tkxFE8BXBJoM3pKGYE
	 82hs7urcc58Sx9blYTSKXvsBscdqpNpKg5BvVp6vko0SJ+fHsUfHVNyXm56aLrNRj+
	 sxXjAIP6L44h7ywCZ6wLl9gz39zwDHcU0AQMbJUarpkI06qm0h2JlVyU0b8vqmrjg9
	 ZUJ/ZyQosH5bhzH0clZBg5A0R2BlCTWQicQTKh5e++64khrEwqEobCmGToMyk40BKT
	 IWMEpPIhadrzA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGj55p0Gz4wb0;
	Wed,  8 May 2024 23:49:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/8] powerpc: Fix typos
In-Reply-To: <20240103231605.1801364-8-helgaas@kernel.org>
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-8-helgaas@kernel.org>
Date: Wed, 08 May 2024 23:49:29 +1000
Message-ID: <87le4kmn12.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Helgaas <helgaas@kernel.org> writes:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Fix typos, most reported by "codespell arch/powerpc".  Only touches
> comments, no code changes.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org

Applied to powerpc/next.

[1/1] powerpc: Fix typos
      https://git.kernel.org/powerpc/c/0ddbbb8960eaf91c7b432ec80566dfa60a8d79e4

cheers

