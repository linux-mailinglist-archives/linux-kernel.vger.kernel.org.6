Return-Path: <linux-kernel+bounces-188911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85788CE86A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1ACB219C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83AE12E1CA;
	Fri, 24 May 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB2kUAOR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEE1E52C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566513; cv=none; b=KE36b5XX0EeclgMqcDoGN6qcZVC75AhTY1M/oCjuDDq5k5FesSEEWDYpOf1Em1l2aUqJaDrFe1Yl+jNZVgmx2QkNXJbd64BNLgh2+WnjyK2kOw1r59AAiGRN4I+zWoWrxBUC6GZCz4KUT+xGQPpR/EI8/Nox4CNcUHFE5W8ftUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566513; c=relaxed/simple;
	bh=gpmn/L/CKIjmdBWM+e87XryHHA3qf/UV+ODH/mboJAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqGISur+aGYV39BQZWuRWHoEEIND5ZgjBamDs40z9UD3H0eQpxkiUmajqk6coslN4crkrtzMaYYZNnY+cJW5aIb3OmMac/OtX+gfedy5p+TfY71OgBkyzIwbIJsmpGTLn+8fksCEotvp9mO6Y0xEpj90OVHyB9+v/CsvghLbxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB2kUAOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41A7C2BBFC;
	Fri, 24 May 2024 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716566512;
	bh=gpmn/L/CKIjmdBWM+e87XryHHA3qf/UV+ODH/mboJAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CB2kUAORBi58asZ36d3lwq+uvSFUOAXiinqr9tfxAL0GoCBGUg1rO5yDzwj3xFU3g
	 BpfLVl2v/UIUaqM3dvcViU076dMWfBT9LTSwUeFR2JOucA2HpXGBmy0PSYTaMUptus
	 IQxjbumAE9DVU+JxWMt/dVRj6N1PALbox7z5lOG6Ji5zuJWBxFDg0+SapnpL1jjyi4
	 7TKYD03kNMkNbfOObxFyGT1ViLumE0994zijEO+uSY8OafiqEI5M+wBHYwVucTVqlt
	 QfsLFhNSsRg9VZKrURKayjAiUcW1+yOR+1mrqI45byuDOAaj51/b2R5XzVgYTw/fF8
	 Yn3IuSYcDK8gg==
Date: Fri, 24 May 2024 10:01:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com,
	c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Message-ID: <ZlC57Zvr1qmtEyEY@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240523113915epcas5p32626cec7fb138355e74415534a3ece36@epcas5p3.samsung.com>
 <20240523113149.29174-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523113149.29174-1-kundan.kumar@samsung.com>

On Thu, May 23, 2024 at 05:01:49PM +0530, Kundan Kumar wrote:
> bio_vec start offset may be relatively large particularly when large
> folio gets added to the bio. A bigger offset will result in avoiding the
> single-segment mapping optimization and end up using expensive
> mempool_alloc further.
> 
> Rather than using absolute value, adjust bv_offset by
> NVME_CTRL_PAGE_SIZE while checking if segment can be fitted into one/two
> PRP entries.

Thanks, applied to nvme-6.10.

