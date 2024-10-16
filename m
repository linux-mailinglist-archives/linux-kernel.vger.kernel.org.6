Return-Path: <linux-kernel+bounces-367465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B5B9A02B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D621C24693
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20101BA89C;
	Wed, 16 Oct 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="old0oer5"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262461B3F3D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064183; cv=none; b=S0BWA25OLTzGAN5extUhqE6YuPs9FdCnm5aSyDQqZ1oSHWR+9zqZ8fCbntOytMoIFsXMg0EE0NaNvIAM7YxDY+li6v30Myn3zkNph1ZmCuxozVTrioHfTVzMcE2C0IQtsxSyTylZhmrdiYwGw6cFwuBlpc/+BwQtpMqM6U/6xGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064183; c=relaxed/simple;
	bh=qx8dj+f9N6uYx22MEEruzzPfngnsd0i0W/nabdG51DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjzGvHhDiK+fdldEupimhGgZvEVXsuiljgd9DwHvpeAQtnwlsb/jpVtL/J3xuIHcyw3Jscc7jL7uTMOfeLeKQ50IBmxIQ83nEnlGX0iBcxdCMTsCgWs8AQWoAozFUSqSvv2qbI9YuAoMqOPoyxCwEfrpMjGoFThUCWpj9Ej6nS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=old0oer5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OafRmAoHaK4TM/K6ajx4rHrM446tv8IYnsqz/V3KSbE=; b=old0oer5HSG2XSScMMNJQaRo2i
	y47AgEasnlPpAClTk6CI6RNJvzocjwE5tgA0g3sHpIw43RrqK/JZuL1tNEkIGK4AEilba9mKJs3Zp
	NTMMdCXOQqdGvqQa3cV3WTUzPNE+fxJ5iof98SOEffEIt+faObHdLozRYs6R60RF48kscZgmydiJ3
	WOT1Vhq8b7ieyIFse5/CCFm45Wz5WdhLI9QSQ+MNYr/7mZ/8PPeTYJZICGBnE1m67G5/ZTNTNZeyc
	L7t8MzguY8xBskWz2SwyOGapP50Za4unOtyH07/Rd/tiTkqirUTb5carnwiZv6YmpAHc0XyYFcCpm
	FuYgaeQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0yZv-0000000AqVh-2uVJ;
	Wed, 16 Oct 2024 07:36:19 +0000
Date: Wed, 16 Oct 2024 00:36:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: lizhe.67@bytedance.com
Cc: hch@infradead.org, akpm@linux-foundation.org, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Message-ID: <Zw9s86K0Dv2FZvt2@infradead.org>
References: <Zw9Hk_9OO-Aqsshc@infradead.org>
 <20241016073340.42565-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016073340.42565-1-lizhe.67@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 16, 2024 at 03:33:40PM +0800, lizhe.67@bytedance.com wrote:
> >> +extern int upgrade_read(struct rw_semaphore *sem);
> >
> >No need for the extern.  Also please make any new advanced funtionality
> 
> Sorry I don't understand why extern is not needed. If we remove it,
> we will encounter the following compilation error:

That sounds like you dropped the entire line above, and not just the
"extern ".


