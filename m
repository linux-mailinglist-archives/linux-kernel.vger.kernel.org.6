Return-Path: <linux-kernel+bounces-520450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C23A3AA28
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B7F3ADCC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599CF1D618A;
	Tue, 18 Feb 2025 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dVwwM/Nm"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836017A313;
	Tue, 18 Feb 2025 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910725; cv=none; b=OGlfrLebEsKiiHG7X/eKySrEZDljWSeflD/zNmrFZbKO8/7p6V4C6AC3RZq/14K/OYrD1MaBkYi1QD1PjgxYgtY1L9y2O3/kd/NIGR27HIPR6jo5mbaKIbanJzCs9HEGCvqPVQsTq2vld6i48FkhsQCbH66uqIe7S+KvX46N4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910725; c=relaxed/simple;
	bh=38iCzgyTFznwlQu/it3NDkH9y4ipGroHGb/uCkNizGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HNYbgjqkepslRcvqX/B+PAaVAr50/26um3D8ajonfgCbRzvj/obDqR2CY8CAua7y3tOQyegNwE/zgVUExrs6Nwi1KplA9qNGouTxnfzyeLci0BbkeKzOLrECyyxde+RwdF/+38j8Fwpv09kWND5HNz0VINNXvrU1p02QPLVGHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dVwwM/Nm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 92DB0411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739910723; bh=ZeMpIwiNJkaqVN2VlEPNKfjRBKw3/WouIDf+tqsA8h0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dVwwM/NmOgvZ2pfyMZ5xQXyevDf7tBqOOGiwmM26ZWL+JndUPwloCbOjPSvAph1pK
	 GD95Hp71PpXQVyFlBlghbEkuyaweAok+/6w+KhBOqmNfU2xRi/eAdHEGJMl6cewyP2
	 7BwScQbQ3M1WLt0vy6oIsaXKULOCv8rEK/eEkOsCJxFabOe+T8ZD5EAVjehVNc4W1e
	 hNOwBrPiPXyZ+ZNhA8EzmrjTVPyW2MAbnUMegmFmNLeagxSXAnFnlNd/jI+rNk302k
	 IWWSZrsGZGPxRIhf+dskLl8HNo1pG46skyKW7lFtaohCD2+JQsh8nrEMFr1V8UOUi1
	 wOMBazgtJ66fg==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 92DB0411AF;
	Tue, 18 Feb 2025 20:32:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yu-Chun Lin <eleanor15x@gmail.com>, akpm@linux-foundation.org,
 visitorckw@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 jserv@ccns.ncku.edu.tw, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH] Documentation/core-api: min_heap: update for variable
 types change
In-Reply-To: <20250215155421.2010336-1-eleanor15x@gmail.com>
References: <20250215155421.2010336-1-eleanor15x@gmail.com>
Date: Tue, 18 Feb 2025 13:32:02 -0700
Message-ID: <87h64rnge5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yu-Chun Lin <eleanor15x@gmail.com> writes:

> Update the documentation to reflect the change in variable types of
> 'nr' and 'size' from 'int' to 'size_t', ensuring consistency with
> commit dec6c0aac4fc ("lib min_heap: Switch to size_t").
>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> ---
>  Documentation/core-api/min_heap.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/core-api/min_heap.rst b/Documentation/core-api/min_heap.rst
> index 683bc6d09f00..9f57766581df 100644
> --- a/Documentation/core-api/min_heap.rst
> +++ b/Documentation/core-api/min_heap.rst
> @@ -47,8 +47,8 @@ Example:
>  
>      #define MIN_HEAP_PREALLOCATED(_type, _name, _nr)
>      struct _name {
> -        int nr;         /* Number of elements in the heap */
> -        int size;       /* Maximum number of elements that can be held */
> +        size_t nr;         /* Number of elements in the heap */
> +        size_t size;       /* Maximum number of elements that can be held */
>          _type *data;    /* Pointer to the heap data */

Applied, thanks.

jon

