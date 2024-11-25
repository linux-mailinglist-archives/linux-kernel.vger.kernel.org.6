Return-Path: <linux-kernel+bounces-421652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C79D8DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4D72870ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEFE1C07EA;
	Mon, 25 Nov 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Jf47JGX3"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0EF1CD2C;
	Mon, 25 Nov 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570194; cv=none; b=NpDrPdpasjz7LMHjy4WG1Fw3Weg7oopQwTEDx6Ewe9KUfnsCG4m2ft5GJ0sGNtHMTgJgwaX2EaeJfkOB6y1HYlnTpXvotlZmMIB+K8qJ9RFZ3hFo/b85YiVHK/UJRbidD2/Jy9uIacvmsty56bAWq71jP62ReQCCzrQPqa6AKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570194; c=relaxed/simple;
	bh=wcI/NCMCFMQUuTyyf5N15ek7gwSDZ1OQWkxDRHpJvrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSRE31DRjcmbKbZJKFg04McZ2bZPlFT1TG29Yt3jEywfBh82JmGaUXTyNIJ3i+qqPnLWrHThZoikeL/4URX+ldo1SgNznALTsefHtuLDqwP8bjAp63L/PadMUWqnaq2Ffrq8MNr8we0Mp17oriyL9AhPUffgbGcRqf1ncuY3QP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Jf47JGX3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=1DnQ+i4tsEd3vHsMii1AxSuGRqH1mnpsnn76tYUkBak=; b=Jf47JGX38Pu0rcftvB3xNbb6Yf
	4ZPdTpGY8ejY40SEiK2e+ye4ofvLdS0thaN86xHIdEefI9OZTRWZJ+5x/VwYt1TcXmpyDeCeoDVQs
	j7KlKpLKerxa4QAQNzNFb2EeKz+oHxjaKM96qrQvlKBqGxuiccJhk34O9SUnl6caTjaK8rUT08pVC
	Jtj9Y6hu7QOSM/zsp5t9bSIFanbaMgDsIKovihfe5Z8kHACY36p51YCVJO/Qe2Anl44audFtDU/KF
	qQxQ7TJPQYGlOl+M+jLaV2+uH7L6T3dbIAwTKn7AvhqfE0Mi4m6sy5VGWTDA1w4dwkQgVQaqMOzeB
	P40ijq4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFgeQ-00000001hN2-3S5j;
	Mon, 25 Nov 2024 21:29:46 +0000
Date: Mon, 25 Nov 2024 21:29:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>, cve@kernel.org,
	linux-cve-announce@vger.kernel.org, linux-kernel@vger.kernel.org,
	aha310510@gmail.com, Hugh Dickins <hughd@google.com>
Subject: Re: CVE-2024-50228: mm: shmem: fix data-race in shmem_getattr()
Message-ID: <20241125212946.GE3387508@ZenIV>
References: <2024110928-CVE-2024-50228-7a2a@gregkh>
 <c51f4d84-1f38-b099-dbd0-a89d78400625@huawei.com>
 <2024112552-wish-oboe-1b91@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024112552-wish-oboe-1b91@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 25, 2024 at 10:16:37PM +0100, Greg KH wrote:
> On Mon, Nov 25, 2024 at 03:49:44PM +0800, Nanyong Sun wrote:
> > Hi Greg,
> >   Will this CVE be rejected in the future? This patch has introduced a
> > problem and has been reverted:
> > https://lore.kernel.org/all/20241116233053.F1FBAC4CEC3@smtp.kernel.org/T/
> > 
> 
> What is the git commit id of this change?  Is it in Linus's tree yet?
> And did the original syzbot splat get fixed some other way?

Revert in mainline is d1aa0c04294e29883d65eac6c2f72fe95cc7c049; patch
had really been pointless and we'd better watch out for its analogues
being introduced.

IMO "fixes a data-race" in patch description has become a serious red flag
for review by now.  Some of them are valid, some are pointless and occasionally
actively harmful.

