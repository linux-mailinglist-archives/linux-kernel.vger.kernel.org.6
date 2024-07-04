Return-Path: <linux-kernel+bounces-241305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DA492798D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840B11C20A15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA87A1B14FD;
	Thu,  4 Jul 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da8FYNKL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C51B14EF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105535; cv=none; b=ojDgYnO5tKDXCYNIQuuNo2268z3vTx9Tnov1SJeFzrRKy/FzmGGJa/IeK9HnTUEYVtE6oG5XH2wkmIHn5XdYFWKAvFINEcOqyJJhWRGvfIXneM8c11VUmJuTnL59QVPt7P3/wItX1ostm4jnul1rFfakOOtqwaZstQkWpLlMImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105535; c=relaxed/simple;
	bh=N3FvdvqUI/RpaPvNgUHSb1vVzFHCisvI1Y3XeoEUkdo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nmDcLTzq+GfASdFjKo2f4UcaoVGlyV0d3YrUYJGJCivPq0Ignop4fsWeBRFjYq1rDEklnrasZtG1cUiI9F42K9n8TWxnDAweKpHTnigvDzZ3B3rak3LvpfC4N/kBInpteAhz7f94Bvhw0yC0f0tZ+vYHJNjHhsMHU7n41EpRNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da8FYNKL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720105532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jT1nLd4pOr4eOcDqj2qthQWAmW5FIF2uUy9DJJrU6O4=;
	b=Da8FYNKL4uhdz605QHFFnMfHptHkGi+MI/HnbhtmspPDYjjx8cIByMrpu8f7fYMyrUFcns
	KdXGw4Wf9WMfAj1d9mSZYJjF+hflGkjOzAXZcBazjk/9aWqNUQgW4HGzdKcErM2t4wRhKT
	QCLmoNQz3YWzDvWAaKFb8BvO2djoWF0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-vxB6Zk_9NsKlaA6WLAUfGw-1; Thu,
 04 Jul 2024 11:05:29 -0400
X-MC-Unique: vxB6Zk_9NsKlaA6WLAUfGw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF1531935850;
	Thu,  4 Jul 2024 15:05:27 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69E4B1955F3B;
	Thu,  4 Jul 2024 15:05:27 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 68B6430C1C14; Thu,  4 Jul 2024 15:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 657543FB52;
	Thu,  4 Jul 2024 17:05:26 +0200 (CEST)
Date: Thu, 4 Jul 2024 17:05:26 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
    Sami Tolvanen <samitolvanen@google.com>, 
    Bart Van Assche <bvanassche@acm.org>, dm-devel@lists.linux.dev, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 0/7] dm-verity cleanups and optimizations
In-Reply-To: <20240703191546.GA1756@quark.localdomain>
Message-ID: <448e290-2c88-72ae-eaa9-c5d4b9388a42@redhat.com>
References: <20240702064835.120541-1-ebiggers@kernel.org> <20240703191546.GA1756@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On Wed, 3 Jul 2024, Eric Biggers wrote:

> On Mon, Jul 01, 2024 at 11:48:28PM -0700, Eric Biggers wrote:
> > This series contains some cleanups and optimizations for dm-verity that
> > I've split out from my multibuffer hashing series
> > https://lore.kernel.org/linux-crypto/20240621165922.77672-1-ebiggers@kernel.org/.
> > 
> > This series does not depend on any crypto API changes, so it can be
> > applied right away.
> > 
> > Eric Biggers (7):
> >   dm-verity: move hash algorithm setup into its own function
> >   dm-verity: move data hash mismatch handling into its own function
> >   dm-verity: make real_digest and want_digest fixed-length
> >   dm-verity: provide dma_alignment limit in io_hints
> >   dm-verity: always "map" the data blocks
> >   dm-verity: make verity_hash() take dm_verity_io instead of
> >     ahash_request
> >   dm-verity: hash blocks with shash import+finup when possible
> > 
> >  drivers/md/dm-verity-fec.c    |  32 +--
> >  drivers/md/dm-verity-fec.h    |   6 +-
> >  drivers/md/dm-verity-target.c | 461 ++++++++++++++++------------------
> >  drivers/md/dm-verity.h        |  39 ++-
> >  4 files changed, 242 insertions(+), 296 deletions(-)
> 
> Thanks for applying this, Mikulas!
> 
> I sent out a new version of "dm-verity: provide dma_alignment limit in io_hints"
> to address Christoph's comment.
> 
> Also, I noticed that when you applied the patches, patch 2 somehow ended up with
> the same commit message as patch 1.  Can you fix that?  Thanks!
> 
> - Eric

Hi

It should be fixed now.

Mikulas


