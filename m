Return-Path: <linux-kernel+bounces-187697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC908CD6C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFBC1F227F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E24E54C;
	Thu, 23 May 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="mldHXJ7D"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981AB662
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477041; cv=none; b=eO5JaZyxomtmQ3Itngiph45IObW946YFd3iehpD/Vc/DClZ3+59fPo0A3a7M05aWqk1g83qF7PRTcZEC6aM294KcOF25nalN/Ako1hvRNQYuoO7QGeC3eGNlNbZhqCErLDVwaj8CaI84SOQb+1Xw6v5AZ/2yzb7d4rCcWWQarpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477041; c=relaxed/simple;
	bh=+OSlJ65hztyqjUCjMnttvM3BQkUjzW+tKw7Kuooh12s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uz4uEdq5K7MMvsPFnABypX1pcM3XNqoFV9K8FQ1UxZkOtZnxKw2lMFugiHlxglUqcexazdeehT0UBcY9EVoHLKcrZLA0QuIEX1GmESK2zkrsDVH4r7VPrSVyumNU83Md/9Q8BNYT4CSWll9LzlV4zFzS3nHK/g3MoQ/3uq8CHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=mldHXJ7D; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=KvJPlzstfT6/U4tjXdaE8p4ykHzflFZIf4papy00MWc=; b=mldHXJ7D0RcTWYGQ
	XzTbqT3nMvYKn6lFHrKyrhVeu12iw2fB2TKclPAqx8znrZIA6k4oYvGFgT9PNGBgRkgave+5HAaah
	JowTkYco+GNq7QjzqLkDwDnYPn1syUoqPKEjtpcQbYk6Bvu/WwM5WuM8OcCTMws3vta6uJKabcR3X
	ip07TjwEMOTw+d4jbgxh/dmN4Aer7nT1nV+ZPeEwNfU9QGZF5OMx3e/qLb0LVoPKf96n11H3rOwei
	WHbVCyfZ1axpZjKQySGfmtjKUCI+bP8mWrY4JdTVkdIbWomN9kv4kO1R2sgY3bjS0z6MRKV8SJMS4
	OSatCmS1rp+SLOZ80w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sAA5N-002FNU-2I;
	Thu, 23 May 2024 15:10:29 +0000
Date: Thu, 23 May 2024 15:10:29 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Richard Weinberger <richard@nod.at>
Cc: hch <hch@lst.de>, linux-um <linux-um@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Message-ID: <Zk9cZdjhR4983Wpz@gallifrey>
References: <20240505001508.255096-1-linux@treblig.org>
 <20240506070648.GA6506@lst.de>
 <ZktoVIG500he350_@gallifrey>
 <20240520152049.GB398@lst.de>
 <1300720405.125947.1716233045712.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1300720405.125947.1716233045712.JavaMail.zimbra@nod.at>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:10:09 up 15 days,  2:24,  1 user,  load average: 0.02, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Richard Weinberger (richard@nod.at) wrote:
> ----- Ursprüngliche Mail -----
> > Von: "hch" <hch@lst.de>
> > An: "Dr. David Alan Gilbert" <linux@treblig.org>
> > CC: "hch" <hch@lst.de>, "richard" <richard@nod.at>, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>
> > Gesendet: Montag, 20. Mai 2024 17:20:49
> > Betreff: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
> 
> > On Mon, May 20, 2024 at 03:12:20PM +0000, Dr. David Alan Gilbert wrote:
> >> * Christoph Hellwig (hch@lst.de) wrote:
> >> > Looks good:
> >> > 
> >> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> 
> >> Thanks Christoph; any ideas who might take this?
> > 
> > Probably Richard who is alredy on Cc.
> 
> Yes, after the merge window.

Thanks; no rush, just trying to keep an eye on where each patch is
going.

Dave

> Thanks,
> //richard
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

