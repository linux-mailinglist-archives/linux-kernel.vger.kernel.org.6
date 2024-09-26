Return-Path: <linux-kernel+bounces-341001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D71987A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C269C1C21DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBAA17CA0A;
	Thu, 26 Sep 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Icgrvo99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94B27473
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382336; cv=none; b=Jwtlknuwa3yiCdXMVLAg1SW6FNF2Kh1g1KQ905nY4e3ik2UX37lT1U59bsD/t/FYIlIksIMTFbfOdMN0j37eLB4ZE0ibzOw67hWjC5Sxqm3QXm9xlE4x5qx/u+6ND8lV72VQIIzxi2jFYBAkfAEPf0YOti4p5FADMqIAMhshJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382336; c=relaxed/simple;
	bh=uo1/TibeEEJkOqpqWAtLS5x6ig9W4X8UBIhUYNoAjJc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i1G5Ggu0wO+z0fopxCQ5/mWqZr1yW/ZSeF7B5y2nxbl+Upth4p+tyRsvpAntVkhxdLPYE5j2ok+Sv3GP+f4elXzwjQCvsyc+y/Rs27b6XIi48xe95qarqeFElEt2XrZWeWL+q8Y1Vl3V29JrJIiPtuCnxDgp3RmUCChYBSk4wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Icgrvo99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEC3C4CEC5;
	Thu, 26 Sep 2024 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727382335;
	bh=uo1/TibeEEJkOqpqWAtLS5x6ig9W4X8UBIhUYNoAjJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Icgrvo992vgDctuO+wUc4EDdYcprB4eHV51xlW5Rr4kmhm6PmIjUzsU5tMB7o01ve
	 5gCY9EQ0u2ER/508IyH2PECvFENBZ5xy5Ds4uzwSxaH8BPvS4uQygMfQUS10CxXSFu
	 flpfk+/CFdDB5x3zhiH0ZTAzXOQIkUxN4sXw8Fqw=
Date: Thu, 26 Sep 2024 13:25:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gaoxiang17
 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] mm/cma: print total and used count in cma_alloc()
Message-Id: <20240926132534.8bd3acaf379ab592770e0d1b@linux-foundation.org>
In-Reply-To: <20240926120049.321514-1-gxxa03070307@gmail.com>
References: <20240926120049.321514-1-gxxa03070307@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Sep 2024 20:00:49 +0800 Xiang Gao <gxxa03070307@gmail.com> wrote:

> before:
> [   24.407814] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> [   24.413397] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> [   24.415886] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> 
> after:
> [   24.097989] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 64, request count 1, align 0)
> [   24.104260] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 65, request count 1, align 0)
> [   24.107504] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 66, request count 1, align 0)

OK, thanks.  We should explain why we're making this change!  The
previous version of the patch had "To better understand cma area during
debugging", but that isn't very specific.

Please tell us the use case - why is this information helpful?  How is
it used?


