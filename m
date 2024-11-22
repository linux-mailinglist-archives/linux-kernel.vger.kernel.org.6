Return-Path: <linux-kernel+bounces-418664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 690059D640A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1305B22075
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44411DF983;
	Fri, 22 Nov 2024 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABQM0Zy+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03D1DF967
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299395; cv=none; b=g1KIYaubcKC0Ryqbr+mce/TtSI7q1OomQfV/ErjLY+NZ3qlR+dmRrz8j/HvaB/HZbKBrcCkafbOxfQgeTlXVTg94nDH6a0Z9l+oV244vDR+MxauCw/I0+QYAdm/UqqGnWRKKOExirGZDos3SINq9IHsDDo1azysAVWbDSOibSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299395; c=relaxed/simple;
	bh=J6AjMBq4stUpxA1GLehzZ6jucYdaDMN+nmMzN/kGObE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhWG7hhnYi0SsxMVtNYR+KcsGxMjLlOCrGu3syBgoiRgJKIyYdIxvBmV63qepHOySlqUqvsrRaliqdE8gETrtBNnCoxMwlpIyB4WcwTQM0/yyZLu7lpzwOifDK37U/Vbbx4/5ZbUodQ68sPlqVS1wRKJXLeSTw39bolUMc4xW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABQM0Zy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B125AC4CECE;
	Fri, 22 Nov 2024 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732299394;
	bh=J6AjMBq4stUpxA1GLehzZ6jucYdaDMN+nmMzN/kGObE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABQM0Zy+hC+CzT2lz+t5Ov19yrZrilxlU+5hGcXh146NneOi2dORZxBpWZGgFK/9o
	 +f3I8XPFY/zKO5oTVo2scs/ywAX3p/hzaPN9MSiZAD72PWi+QKzV+w8pS3lx4pyaC9
	 9zfnV7RkcSytOuZ87K7gqoaGmkSto3cRgJGiTFiCjy0SuKDz5mZ/mauUPEytlyn/ww
	 qy2Jb57iaHgPMAYvq5QVMiAiO9dDren8Aeuz628ckSyWb7MRghiRz1h8fN/35er5AW
	 2eraQz2eQBJxiBXZVUjpSDTtt1mvjcXams244vhX8bhDfe4QK5K93kQ9QXgFKEtrnc
	 Cyl+ls1Kku5lA==
Date: Fri, 22 Nov 2024 11:16:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Bryan Gurney <bgurney@redhat.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, axboe@kernel.dk, mpe@ellerman.id.au,
	naveen@kernel.org, maddy@linux.ibm.com, kernel@xen0n.name,
	bmarzins@redhat.com
Subject: Re: [PATCH 1/1] nvme: always enable multipath
Message-ID: <Z0DKf0fd5xCmcp5j@kbusch-mbp.dhcp.thefacebook.com>
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
 <4bd8f843-6dfa-4c66-9e42-cf4245166844@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd8f843-6dfa-4c66-9e42-cf4245166844@redhat.com>

On Fri, Nov 22, 2024 at 12:52:51PM -0500, John Meneghini wrote:
> On 11/22/24 10:39, Keith Busch wrote:
> > Anyway, we only use the one physical function, so they're certainly not
> > multipath devices here. We disable the CONFIG option because while the
> > nvme multipath IO overhead is low, it's not zero.
> 
> Do we know what the performance impact is?  Has anybody measured the difference?

It doesn't benefit single path devices, so any cost for it is too high.
It's clearly not free.

