Return-Path: <linux-kernel+bounces-217314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8F190AE38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE4128256B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F02197A60;
	Mon, 17 Jun 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VsGMHQcZ"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94302F32;
	Mon, 17 Jun 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628676; cv=none; b=lo1EDe9JYcnhKL3k/6w8mGxpOi6r0iFeMK66nePFGcQs3GuxLGDVOcvBM51lbGEduD0FZrN9fSo6GHoY0aFS10w80l1bSl7df1/FX+y0E9vIlIudN/ot6VTDM72J0DSMUe9RtJeyBmXmdYiRV3Zm3L9KH2vsqFq0/J/gH1qgdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628676; c=relaxed/simple;
	bh=GQBIFm5almhIw51sYg0vmZ+BK2iQ71Q6i4phxIiLcTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcIZtuCxSjBf1wglPiSp1hz2h4VVdZIYpkylznYj0G+qORGQo+mJuSpN2NNm2cnJAMIs+CvSzUYfXJ7FVg6a/I26syvlR+PPIg4Ugq867CvuKYjKEgD+igPHinPRLRniQk2d8IsK15G7MDOg+joHWQJfJ2tWgQ/qRHupnqXSP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=VsGMHQcZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718628667;
	bh=ksNm0n7vWVSacMAhdyZonglFoGiO3VwbDK5VPpn10LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VsGMHQcZmFQlJ8S0Q10/1sZLNumhCV+J+AhUyQfqoEsPdprNmQWnItth2Nda+WiiR
	 i1OFKN+sqJhTDq9tXep04oZ+fJFDTOO/tsLa3oMW5kRIipl8NWP7oI3Qv0+cZqYufQ
	 W/apLvq0CNqHdEQ00JQJseK8X7YbRd4qv14AkwulTm7cJpxYeapgwubEectMGrTXdN
	 HoVpNlksrxkeKiICLhyQbUDfZ/bu41bmKNiggrFr00WQc+RpG768315C6I9/jo4BXa
	 I3AsBbEsWfZhEkzZtLMfYl7LImgSHt1f6yvKWnBjx2vIB3lYm4jmMdUre4OK/u1c4g
	 3uJA/PjCa6s0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W2qWD3sKmz4w2K;
	Mon, 17 Jun 2024 22:51:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org, Nathan Lynch
 <nathanl@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] Documentation: Remove the unused "topology_updates"
 from kernel-parameters.txt
In-Reply-To: <20240617060848.38937-1-thuth@redhat.com>
References: <20240617060848.38937-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 22:51:03 +1000
Message-ID: <87frtb68co.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:
> The "topology_updates" switch has been removed four years ago in commit
> c30f931e891e ("powerpc/numa: remove ability to enable topology updates"),
> so let's remove this from the documentation, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ------
>  1 file changed, 6 deletions(-)

Oops, thanks for cleaning it up.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f58001338860..b75852f1a789 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6600,12 +6600,6 @@
>  			e.g. base its process migration decisions on it.
>  			Default is on.
>  
> -	topology_updates= [KNL, PPC, NUMA]
> -			Format: {off}
> -			Specify if the kernel should ignore (off)
> -			topology updates sent by the hypervisor to this
> -			LPAR.
> -
>  	torture.disable_onoff_at_boot= [KNL]
>  			Prevent the CPU-hotplug component of torturing
>  			until after init has spawned.
> -- 
> 2.45.2

