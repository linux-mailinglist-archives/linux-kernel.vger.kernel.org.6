Return-Path: <linux-kernel+bounces-289037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D59954176
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C221F2380B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BA780C0C;
	Fri, 16 Aug 2024 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yCmdOpVB"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00923C24
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787997; cv=none; b=IYeztBjGNP7WqboS+7P0Mj0HFQdY9iZImMHKWRIM9VIeJ+n/LcYhG1Q3Fw6wzpYfyi7tDu129nacQxFPlQXmNlhjj2tvGqv7LBu4JHiej2igXmC6A1bg2HoeyxIkc7ojJASTWLIHRVCPBmz+8UzSFhQf0FwR7J8lkfM+xldKm/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787997; c=relaxed/simple;
	bh=oVBVUiFzHKFNRyydue40KRHhoEHa8OSF2s1y6FpP9Yc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mHuiSWNHnr2XRQluSw0mB3RfKBmL9xpLKZoRGj7IvfqNg1IkPUrnGXq5C8eO8AfnjKY7GPg3LjJLZxyqEBdL31AB5vxtOFeppUXxVV0e05KU79XKB2OR5pBw4ff1E7A9AEJsHf9ESXLizLF3yKA79z+Zy9/A4GO2w4d+H/5vP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yCmdOpVB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zOCx/yhRLMyGOlVLnFvOTRFA/rCMKs9v6IWO0bkSMLE=;
	t=1723787993; x=1724997593; b=yCmdOpVBAEzU4TicnSB/02tuw7u3M2GWnwY9erMTKEaOzIH
	7US/aMkaU3+Gj+8K0ZpTnZwOiHOhXeHOqup+BHt5d7lenGUf8Cp0uM+N7gApXPpuUKEj0TeMgSHML
	FXfxbs6qsxN9a/PU683oPKZ74rrKlMrKfyLPmQwZFuMahb5jQjD9WX2nz0JO8Awu4sJOtuVxMWVEl
	mSjzuDGNkGcVLTEdO/TVH7lKVNULq3KkW4oxKw7VHz2jLgBMgph/eG26TGUnB/HSgI4ZJguX/RR0P
	VmbRhmtQBPCOKlgHo65FPGg/itYW868mKLNeE9de/4b0KPMNyTg4mjm0zSvmbCVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sepzt-000000026cX-3j83;
	Fri, 16 Aug 2024 07:59:38 +0200
Message-ID: <3be8448cfb2aeb39e0e73856a701101dc8a0f04f.camel@sipsolutions.net>
Subject: Re: [PATCH 4/6] um: Remove unused mm_fd field from mm_id
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 16 Aug 2024 07:59:35 +0200
In-Reply-To: <20240816015447.320394-5-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
	 <20240816015447.320394-5-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Tiwei,

On Fri, 2024-08-16 at 09:54 +0800, Tiwei Bie wrote:
> It's no longer used since the removal of the SKAS3/4 support.
>=20
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
> =C2=A0arch/um/include/shared/skas/mm_id.h | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/arch/um/include/shared/skas/mm_id.h
> b/arch/um/include/shared/skas/mm_id.h
> index 1e76ba40feba..b3571a8afec9 100644
> --- a/arch/um/include/shared/skas/mm_id.h
> +++ b/arch/um/include/shared/skas/mm_id.h
> @@ -8,7 +8,6 @@
> =C2=A0
> =C2=A0struct mm_id {
> =C2=A0	union {
> -		int mm_fd;
> =C2=A0		int pid;
> =C2=A0	} u;
> =C2=A0	unsigned long stack;

Maybe we should also remove the union here while at it? It is pretty
pointless after all.

Benjamin

