Return-Path: <linux-kernel+bounces-440779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285389EC41E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F10718850EB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B191BE238;
	Wed, 11 Dec 2024 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ItRG7FKR"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FF6F30C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733893448; cv=none; b=n6a2xT4rC0sanX36eLt64lAl9LTiAIBAZWqPvbttrqQKYgxeISXcML7py6fvV8tfPVa1yoXCPOdMvyFseSq8zfoEY3vxIirYzefhedgaUyuTj40uB6WDBhdJ9vJHmU6FlNnedblpxamjBX32dSbMQNw3XlZ5sAq8yykHf2Iu88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733893448; c=relaxed/simple;
	bh=u3Kc0hb/a783UWEPH+kQlvZ9XoKM6SXBMA0EYOr0jtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaPBZacx70HPUgJuwKaz/UrCE9Qgcv831rp8aG8d174COqVVZfwiR8FTfBMS9URGON+jH5Vjg+rKjloNrirzMe96NsltRP6cHc7gfF2hSV2IQJBCHqau71bGLZXBzNsABsctcbmTp24AHqo5c+xPKH/OQz44pnv5ohXwjSf4KuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ItRG7FKR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u3Kc0hb/a783UWEPH+kQlvZ9XoKM6SXBMA0EYOr0jtg=; b=ItRG7FKR6O0PDRwGOb/XcqrZka
	5EE1XQ036FIwSAbEuTbZRlHQQRt7daemKRgiKoDFCyM2Te7izgnCwx6jVnOKfQy8pFXcUIpWXxtX2
	mZu8FCsWKdOX+63uJcsMCCEcR21LiNJxn7kMtjSqbya34i/Kg5PvdtPI79FznqCIYv+e3I/xuTEmu
	Nqx2roEQ6lAjskhdVQtynA4zSiisRYACQWzoAs1DvymqXjwQ2mC45RuiRA8JUqVT7oolhT1+8MptK
	FnKg0DeuR54Z2qZH47NyrFQLvUiJGyoSYtHhW4xEV5qDFFwipCCZVdKBdMy+O8SdMz6tGSs2CW7Pz
	2NGg+DQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLEtH-0000000DnO6-0kD9;
	Wed, 11 Dec 2024 05:04:03 +0000
Date: Tue, 10 Dec 2024 21:04:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	dan.j.williams@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, jane.chu@oracle.com, osalvador@suse.de,
	tglx@linutronix.de
Subject: Re: [PATCH 0/4] Remove problematic include in <asm/set_memory.h>
Message-ID: <Z1kdQyHnPd0jgIgZ@infradead.org>
References: <20241210184610.2080727-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210184610.2080727-1-kevin.brodsky@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 10, 2024 at 06:46:06PM +0000, Kevin Brodsky wrote:
> The need for this series arose from a completely unrelated series [1].
> Long story short, that series causes <linux/mm.h> to include
> <linux/set_memory.h>, which doesn't feel too unreasonable.

It is entirely unreasoable. <linux/mm.h> is inclued just about
everywhere and should not grow more fringe includes.

That btw doesn't invalidate any reason to not also reduce the amount
of crap included in <asm/set_memory.h>, as reducing include hell is
always good.


