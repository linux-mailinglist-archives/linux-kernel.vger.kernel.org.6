Return-Path: <linux-kernel+bounces-365245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A654899DF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A241F22F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB82C18B48A;
	Tue, 15 Oct 2024 07:40:54 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B317DFE3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978054; cv=none; b=UybY2PjNgF4XmFIBhJ6WzRWhpieClnCEzbapeta6t49kgaHP253t3+akKb5B3kRdeGOD70glNy50qv5lWYMR2+QEndRANwbOjAMIuAHWjRR9aNCqDxbqOIIqMo8Dtdxgq/TlFrDbLsMaiJM46BBdMQqEn2q6MQskOJOOxjMZCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978054; c=relaxed/simple;
	bh=yKX171mOs+ZMz0LC9AqbWdVjEyq6IeyCaI6EMSKlMQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkkyw0wZ9OLsWc8hOsBk5cQDWmZAckW3ZROgovVql/eziK70+godYVcVppoATWOrSq0GxWS6k388xAmaVyxU8B37bH3343SkuxcJElUbNIb3s6cDypb8n6RhzaO/oSekhaaoMRlLv+oQqmA9YJ18Ln1gPhK28TXQ0uEDGLQS65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8878F227ABA; Tue, 15 Oct 2024 09:40:43 +0200 (CEST)
Date: Tue, 15 Oct 2024 09:40:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, stefani@seibold.net,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kfifo: don't include dma-mapping.h in kfifo.h
Message-ID: <20241015074043.GB24501@lst.de>
References: <20241014144643.51917-1-hch@lst.de> <2861f304-c8d9-4e56-8a91-9ddf6d7b05a5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2861f304-c8d9-4e56-8a91-9ddf6d7b05a5@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 09:38:24AM +0200, Jiri Slaby wrote:
> On 14. 10. 24, 16:46, Christoph Hellwig wrote:
>> Nothing in kfifo.h needs dma-mapping.h.  Drop the include to
>> reduce include bloat.
>
> Except DMA_MAPPING_ERROR.

DMA_MAPPING_ERROR is never used by kfifo.h itself.  It is used
by user of the header that instanciate one of the macros that use
it.

> The header should stay self-contained.

It does with this patch.  You can include it as the only header
in a source file and will work fine.  I've actually tried that.

>
> -- 
> js
> suse labs
---end quoted text---

