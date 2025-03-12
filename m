Return-Path: <linux-kernel+bounces-558542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EC0A5E766
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AD2174A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC81F03EF;
	Wed, 12 Mar 2025 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gkKBvUrz"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065F1E9B32;
	Wed, 12 Mar 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818424; cv=none; b=mHNCbRUD5M2F76QSJdPg8gnkiPT6VbBMW/5U/iVKvcyyM1Tb0ajqS/FJ/XbYHcztVvBETcil0lv9gJYm1zJyF/y4xPgRza2sv8lNwWhypLWInIbBLZP+uhvZ9+4udKA5aBXDDWEGE1QZEk2x4swGcblIT0l9PkN77ZE1JncT8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818424; c=relaxed/simple;
	bh=e35FjSVAvRqJw8XwAKmEAqbc55RiaFXBqqKCeCMqlDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VeDO3g8bBB/fsWzXD3GAOximyoNUS0vbwYd7/ffCx3HSTGtmzvR+9xIEdwOTqDTkxoOhFuqvU69pdBskaV3vgbnZR70o7dDi1wX/7D87FYHCmFrV7HyHyswihf4XBtAYBrrgtqtPBqRH3OAmVzVPLWQbmvPzcrlbF4bEJGmf4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gkKBvUrz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4161B41063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741818422; bh=xxL+8LhuOi8qnd+QuZQR12PXYmDYb9P5KqJMdTOYUKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gkKBvUrzAdgZpOrEyPfR+tfKJp4wUVN6qmteR+rppA7xW2Mfrdtzhsr7KXcRDDvIJ
	 D7t4rQk3Ow5T9mlJyJ2gYn80COIIqRP2sTWx+LFeTdziVKl/lsBh0T0e1CoxQklrO9
	 sG1X60emZSrrQ5+HIkl+GOwobgFhaViA/ooxOMAEeAXeZT80OIYehoL7BMxRF/63v9
	 FOrZ+NR9xPkAhmgzkD9nz8EwRnHPfsVkXR2FLQB0DPcYaCEdQ5kehdgQ9FQHda6D16
	 B6v6dd1KT4zUV54se/PNl2QVCXnxo1OeJ4bJMsJ1gZpxP4bsHAwtYB7hIwg+gnqoGT
	 kOIk8Id4AxQ3w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4161B41063;
	Wed, 12 Mar 2025 22:27:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Fritz Koenig <frkoenig@chromium.org>, Frederic Barrat
 <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fritz Koenig <frkoenig@chromium.org>
Subject: Re: [PATCH v2] Documentation: ocxl.rst: Update consortium site
In-Reply-To: <20250312-dead_site-v2-1-920a313743ee@chromium.org>
References: <20250312-dead_site-v2-1-920a313743ee@chromium.org>
Date: Wed, 12 Mar 2025 16:27:01 -0600
Message-ID: <871pv1nave.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Fritz Koenig <frkoenig@chromium.org> writes:

> Point to post-merger site.
>
> Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
> ---
> Changes in v2:
> - Update link per feedback
> - Update commit message to reflect sureness in corectness
> - Link to v1: https://lore.kernel.org/r/20250311-dead_site-v1-1-7ab3cea374f2@chromium.org
> ---
>  Documentation/userspace-api/accelerators/ocxl.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/userspace-api/accelerators/ocxl.rst b/Documentation/userspace-api/accelerators/ocxl.rst
> index db7570d5e50d..4e213af70237 100644
> --- a/Documentation/userspace-api/accelerators/ocxl.rst
> +++ b/Documentation/userspace-api/accelerators/ocxl.rst
> @@ -3,8 +3,11 @@ OpenCAPI (Open Coherent Accelerator Processor Interface)
>  ========================================================
>  
>  OpenCAPI is an interface between processors and accelerators. It aims
> -at being low-latency and high-bandwidth. The specification is
> -developed by the `OpenCAPI Consortium <http://opencapi.org/>`_.
> +at being low-latency and high-bandwidth.
> +
> +The specification was developed by the OpenCAPI Consortium, and is now
> +available from the `Compute Express Link Consortium
> +<https://computeexpresslink.org/resource/opencapi-specification-archive/>`_.
>  

Applied, thanks.

jon

