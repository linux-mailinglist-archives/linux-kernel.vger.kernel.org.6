Return-Path: <linux-kernel+bounces-218395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E590BF27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B213B283AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069A199259;
	Mon, 17 Jun 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cvjhYuw0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAD1990C9;
	Mon, 17 Jun 2024 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664291; cv=none; b=gR/DIdOL3780Z1EjkzrZsMC68mTnz2O13BsqQzRHGRSElATCCVpD2Z2VcyH7cHucxdo29xSzi63FWGU0uMCs9miJlcDCAmKHZLEkucLdZGxRks2r0sll7YHcjOZ1PsduoJKzYANQxzbOW5arosROUV9kXUWXIUYhueJdjqFiXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664291; c=relaxed/simple;
	bh=YdnmXRGisXeOdFSCMsRUE46ZndWRdnKFOdAjRpKmB1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hlrylBb1aLsBlfoDODZ6PtF/+Otd1L41b0op++oRd5Eyh6nHsPyNAUF9f0hYsFEshZoF5vxM7i2wj0/QborU7moCGTzwXNzSfQtEF4ROoGA7wFO1cxEBKtcnTOauj+fYqYEfozh7vzaNgkWqdkVsYvfXDoLPlKStxJxjjOAouiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cvjhYuw0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 927BB45E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718664289; bh=tgZ5hgb9Gf21KDYdEib2nJBRoH1w2xOfXPJe310ZmBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cvjhYuw077bLfEWVkm9B5y5MkRFtnN2/7arlWOO7bad+/c5EIZSmmsxUsPbBOEYjQ
	 ufEy35QWt09ug5fQPilU7spMPSYU1isz3ea/kkmCxABk/Dr+6aeJW7szpbPsNAa4po
	 tEWUN7mUfw1nB0rMxivttg0ZW0+SiU+wjuj7+aJ0vfMqUbHU6GjcKOWI6yW/5JtqJt
	 rZCuSOHc9XvpOyZWgd22iPaKNr/S8gbJP4Ej666iYP0pCsR2IpxXy1t5DLFeW5CQqt
	 euVA6wNmKKeDQpqt0mTD/FuDevW/lBoZgpFBa1kVyhH6JZ7tE+3uXxvmP5dvQL3zGJ
	 RiqX95vwBmMOQ==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 927BB45E08;
	Mon, 17 Jun 2024 22:44:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org, Nathan Lynch
 <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] Documentation: Remove the unused "topology_updates"
 from kernel-parameters.txt
In-Reply-To: <20240617060848.38937-1-thuth@redhat.com>
References: <20240617060848.38937-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 16:44:48 -0600
Message-ID: <87zfrjfau7.fsf@trenco.lwn.net>
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
>
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

Applied, thanks.

jon

