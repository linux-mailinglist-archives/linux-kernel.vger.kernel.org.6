Return-Path: <linux-kernel+bounces-228981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76949916958
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89221C20EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9BB1607AF;
	Tue, 25 Jun 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="aKFkQwV8"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30717C98
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323379; cv=none; b=CqQ/TvmwW56tYia9URznttLAzqsq1EBtOIzG+UEl4+6zmXjSs7gBkFvj6VKqJdtg41SpLfgNVBOKvNDDU2yhY2shnZVx9iGGuFKuvLaO7U/sP1gBRpGlYS8H92Xkhay9isodTI6WCykjV9kvrCKcJW4bFS6CEcVd2a5QeI7VsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323379; c=relaxed/simple;
	bh=AW4Z2MAaP0388kJzC8lYJYVxSwvwAF4UeHLV/nHLRjU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ij/iRSZ43HP91iHpaOQihsoCtuyMi5klxNhCVHStEaK1ppIBbdtig+bXPWxHedr3mwFM2QDdsWNcwhEbzJ9zVcRPA67q6SzIEdLnXZQW/XiyAbrpCj2THvSwBH3DlPtAuXWbSJGlEMcJnj2PbTl6b8FYeEbc09QdCB2tBv0iS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=aKFkQwV8; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719323362; x=1719582562;
	bh=AW4Z2MAaP0388kJzC8lYJYVxSwvwAF4UeHLV/nHLRjU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aKFkQwV8KD/82Ay3UrQhAsSlkq8RM5sUGqV3+aA5mOC9VCw/oUULR9pco6hldXMNA
	 2xt6vaTFmjLyTobH38nSkSA/zhZm0SrdYFrkjnKg9dXTHyGV1E8tHXo4ZJeBuHdl7s
	 4uV3SeTj5mYgwj+B4hRmLzQlaFMX7rJjhwBw/nBCTx/aQNPE2EWYNDru2slcD9YbZv
	 nguj3bfZyplXjewy3tabhgxpytO1/JgKwSUqMZusriNhWfjf2U8CDsDJ3/AspRHDeh
	 S+MQLKrPKsqov+lFbt8tRmh+5sMVYf0DlLPE2GYPAenro71KfH0fkyouh6r2I9+8MX
	 XRLlNlmeyninQ==
Date: Tue, 25 Jun 2024 13:49:17 +0000
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Stable linux-5.10.x regression triggered by MDS mitigation
Message-ID: <yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com>
In-Reply-To: <20240624170921.mep2x6pg4aiui4wh@desk>
References: <IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com> <20240624170921.mep2x6pg4aiui4wh@desk>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 1cfee52ed1850eead40bef0099ac1ae016436350
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, June 24th, 2024 at 20:09, Pawan Gupta <pawan.kumar.gupta@linux.i=
ntel.com> wrote:
> Below patch (for v6.10-rc5) should fix this. I didn't send this patch
> earlier because I havn't got a chance to make sure if it will work for
> other cases like modify_ldt().

Thank you for fixing this regression.

I tested your patch on 32-bit linux-5.10.220 inside VM, and now
dosemu seems to work OK.

I do have a related question:
In SYSENTER code path (that is not used by virtual-8086 mode),
there is CLEAR_CPU_BUFFERS just before STI and SYSEXIT, but that
CLEAR_CPU_BUFFERS happens after flags are restored with POPFL.
VERW opcode inside that CLEAR_CPU_BUFFERS modifies ZF flag.
Is that ZF flag damage OK?

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


