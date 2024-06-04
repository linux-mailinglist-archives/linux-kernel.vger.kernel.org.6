Return-Path: <linux-kernel+bounces-200662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1638FB31B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37390284920
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF90146012;
	Tue,  4 Jun 2024 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kV1oEn0N"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76C883D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506146; cv=none; b=OExCJ492atfvDRSbiwhbPsBeMtRrksTGcNHOFwGnW9eqIV7gj+XewoPWzmd/waAIFEP88RtjtTVhMa0WliwujO1QF4+oUvuoATQX/RJJZI7qvJtzAJ44C+1WacA6iIGgCeRAg/T+cqrBT5D1tfKk0CJl56DgUtHBcAewI3RvBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506146; c=relaxed/simple;
	bh=eqbTx8t2bF3ZyoyZVwd8n85rm6PyiSgX82HtLBpIFFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBNCS8opfe6odjmTaLU1UySwXUdH1mWhCAy8wprfJaNwdcpaK0FI43wPoSyYKOFtAFe+DqiABcbEI6zGTxh+IJDg3vfXVrFX4ntiedDIjR8N1mceb5DnkU5ouZEE5nzdU+TyLU1fsjjEVwYcngiqOwql9oef9pAQAApGMiVZ8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kV1oEn0N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JFHkCi7Gt/tcbF3MIwSvdiZj3IBjBWc/8244vSckI68=; b=kV1oEn0NQcQx8jNdBW3z7LX4WZ
	+GcW7YHj0PSYW1lvpr2xy8zaHWw3NywWlPUww5MLKBl3GWa8TzMg9wJ7zemIj7dPov552ieiiHySA
	qcwPfgWcv6f7CCU2VhFFqLAYS2c9H3h2HFxmkMskijRXqupmOGysyf8JV+ASnxeX9DXI9VPJXKbY2
	wZtGCCiiG1tJFhNzF+PZwjaTQJqioU0moWeaSDjartkqZoNUE2V46DVSriwGEV0uRGiKZ6y6ChVgu
	+uUKgYSXLZSQm6ciIDfhc47/z45xSWS+r34Lm/yZS9EhzjqGVZ6OFWVZy3wOHK3LFZv+/AsRULkOA
	bszS34jg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sETnv-0000000EqBr-1cXf;
	Tue, 04 Jun 2024 13:02:19 +0000
Date: Tue, 4 Jun 2024 14:02:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
	david@redhat.com
Subject: Re: [PATCH v6 00/15] Fast kernel headers: split linux/mm.h
Message-ID: <Zl8QW91FwZ9UpulZ@casper.infradead.org>
References: <20240604090845.2182265-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604090845.2182265-1-max.kellermann@ionos.com>

On Tue, Jun 04, 2024 at 11:08:30AM +0200, Max Kellermann wrote:
> This patch set aims to clean up the linux/mm.h header and reduce
> dependencies on it by moving parts out.

I am not a fan of these patches.  They will make it harder to work on
the MM system.  We briefly discussed them at LSFMM and nobody was in
favour of them.  I'm afraid you're shouting into the wind.


