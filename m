Return-Path: <linux-kernel+bounces-310668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D80BF967FDC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884571F220F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FF165EFC;
	Mon,  2 Sep 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="ImrgUVfy"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884A2032A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260368; cv=none; b=TZTSj1DpkHAkKKV2/ODxqyRohZ28uwchDOP2fR6HlJlNNNHbAsiH3E3oXsAXMXILiZ/PqdRb+55HFsVQXA3OWqpyYjN0xYJ+DpPrtprIHG25xtXxtZA4jcrJrbzrnHEsLANXS0Kkd5hXNOYzFayfU+7/v6S6qT2ywrBDO/Hsjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260368; c=relaxed/simple;
	bh=0l87flKyz2skC5h/nmiDVGhzHmePdyNo1cLPwg6KurU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7UQF9AfYo6QXXsZ0tDNqXlJ9xIRz4/fZKP9tMAanTxdpSZeIJJM05CPhq1WgPAHxWDqPLPlLl+34W0LOZVvJvW0rHijFVH1n8MnFtNJMhydROSd6jqDz4MJgVEC4uSX4K1Wiz4yaOZ5+/4PFyaDC2SFC/NKVhkQTY+8fpsJZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=ImrgUVfy; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58871697A1;
	Mon,  2 Sep 2024 02:52:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725259928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xPo/aeycxsYyFW1a06c2EYN+hFfylPJIDEUKB3y+AEA=;
	b=ImrgUVfyCScGbcqVk6ZmSGT45lHbEsEjtXh8X4ZkTkfnV33UoRWZo/g4K2oAC/qBzVOYHf
	1/HhtDT/tsDYiIxcXOabYOPJuEs3C+b4ETNepwI18yKjPUHiEsAzDjf0KFxsn5wOUjOgob
	1WQ8Bq5vhoFhUnKjwNF4yKnczBcHmNugSV5RJAJsoMUCkxBc8yjQJ6P4HkwI7Pgb5fV1KH
	kjPeHhlfznTg1PMYpe29e+dXVGPm11bEouU39xDqysbBiB7f7/3ofntuFxG7+SQMkW4GVA
	4anmOpyHxK8MfcZ//D0ihnj/Eazu2Sq0ZhzCCFmzpG0hP3SDwt+MQ8zlmdFtdA==
Date: Mon, 2 Sep 2024 14:52:00 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] erofs: use kmemdup_nul in erofs_fill_symlink
Message-ID: <xevmwnwrovlcueuxawmpse545faxoky5nbqlkpzebq7eajr3kr@khnm5umjvctk>
References: <20240902045100.285477-1-toolmanp@tlmp.cc>
 <20240902045100.285477-3-toolmanp@tlmp.cc>
 <843a19f2-254c-4025-8df3-fb25f0862b18@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843a19f2-254c-4025-8df3-fb25f0862b18@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 02, 2024 at 01:46:44PM GMT, Gao Xiang wrote:
> Hi Yiyang,
> 
> On 2024/9/2 12:51, Yiyang Wu wrote:
> > Remove open coding in erofs_fill_symlink.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> > Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> 
> Could we lift this patch as [PATCH 1/2]?
> 
No problem, it's fine to me.
> 
> 	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> 
> Missing blank here.
Fixed, thanks for pointing out.
> 
> Thanks,
> Gao Xiang

Best Regards,
Yiyang Wu

