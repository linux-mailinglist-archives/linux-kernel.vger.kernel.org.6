Return-Path: <linux-kernel+bounces-336147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7797EFB5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302C31F21CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBBD19E960;
	Mon, 23 Sep 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzntAr1c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD3FC0B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110916; cv=none; b=BYZ3dC7ZU4yBgdSNFrbODY3HgT1nS5WdP36mrD/uyGlyhn3kCYIP2fsf3bFXwPVB2uGBddwaguDGdaiUW42SPr1htA9IDs8ROxM9T07HTFBqgU9dBRKFt4HzNUdaf8ZQPAwowNqU8TIJd6M2xeT0BlLZMso9GxmBwIOZTxhTDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110916; c=relaxed/simple;
	bh=HvTfVZZWM0K8iF6PzBs/xfSFi6UFaHmIMl1EeMGe6E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ8Qchu8K78ZEaF7X7vrmDJfUJ5F8LKkr6IHUuHiDEQQZI899/f0xoQHFRnKRGL1Um9AcNPeIbZL2crJ9lCuJPdlKp5CR8LneohQp2GorXqrKTI1wvXI/Yp+ydxvzgM7guPn2d6PwsGDzaDiyV2GoU87HZvvj7HbBibKIPOyRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzntAr1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E224C4CEC4;
	Mon, 23 Sep 2024 17:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727110915;
	bh=HvTfVZZWM0K8iF6PzBs/xfSFi6UFaHmIMl1EeMGe6E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzntAr1cXjVe5kTjVhDrCoiZt3saJ/7XnPo21DQPS9oD+3VDSVvBISXHRC50+51Ig
	 G7/XNPkwEkA4nyFqVNWEh/Vz4QwomgCtC6opJCRaN9iYHuVticymUq5v95OHt59Ld9
	 3dxKJdw8NJyXHDOOD8TLNPZY6qhiRSApjNqJCertLMB7Zlbg6bOrgTpyxUgphyVt/w
	 GDKOLuDe+3FvJjJZ94r6FZv9oAlnA395ATar4/74RYj2AZZuB6JSpyPwyvwM/IXXAd
	 M3QPZ3kOPi96q2qEbEwEC8FA5SU4VPhEfQRspkfxUph6XmzYCfbfehLk4I+io3Vhuv
	 b0NpLauiGT6lw==
Date: Mon, 23 Sep 2024 07:01:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: Andrea Righi <andrea.righi@linux.dev>,
	David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <ZvGfAqVgbB_p4SKX@slm.duckdns.org>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
 <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
 <20240923104548.GA308802@pauld.westford.csb>
 <ZvGJ_xT2LhYJHQbZ@slm.duckdns.org>
 <20240923160007.GA313849@pauld.westford.csb>
 <ZvGYjKAB07VJW7jq@gpd3>
 <ZvGbkCWR7AbgA6ug@slm.duckdns.org>
 <20240923165749.GB313849@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923165749.GB313849@pauld.westford.csb>

Hello,

On Mon, Sep 23, 2024 at 12:57:49PM -0400, Phil Auld wrote:
..
> > I'll apply as-is. Let's add per-scheduler load seq separately.
> 
> Thanks! I was thinking that per-scheduler you could just snapshot the
> global counter (either before or after increment) on load. Then you
> could easily tell when each was loaded relative to each other etc.

Yeap.

> Especially while "per-scheduler" is defined by string comparison I'd
> prefer not to rely on that for this use case. 

Thanks.

-- 
tejun

