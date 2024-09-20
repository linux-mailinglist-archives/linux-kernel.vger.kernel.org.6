Return-Path: <linux-kernel+bounces-334183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6A797D397
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3252728A94F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32B5142911;
	Fri, 20 Sep 2024 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="Fvrc0Ruh"
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0F13D601
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824361; cv=none; b=h4Ota8I8tcOfTzGK+UXL2pqEo79Oqh8hIREEw5cCYX07VTPsmFm0tH9c/3OCDdcseiqGLrpoaT/svFMAJIqfacNRsgPcly3XudlsNXnHG8X9Tly2qmZWSN0OzIS9xrSEDd0iRRgT7Cw79hlEcabGt05iUZJCTWXTIXDj7T2sfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824361; c=relaxed/simple;
	bh=GnTy81Z6xnDUolGMNveZHKeYOBpy/nCHaDOSWpWuoRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNWPYx/FVSBWIBBiC/rG63ryojPzc8Vj8JC0QUtLaZOwsM5lRBB7rz1SQMQnHoHfNCWklTqSd0F89mnxBISZ3HPDaHsTDT7Q+hfL7mxoL1IWniAZ9WPlWIQ1OsAZMFddGTOt1RArIcJ3swExF2RsJV5C8AZBpgGKzq+Px8+U8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=Fvrc0Ruh; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cyrARjeT/lT9YcWDnT0uZHLOlQFbO3MsOY7h3KINaHk=; t=1726824356; x=1727688356; 
	b=Fvrc0RuhPzjMj3UrmUUNrtuKFn4IUefuUExTRIe75/qf8eRfRmRZIxnmSdaPtmb7mqsaAWNDrHQ
	8vcHjNLtGGFhscRI/F6Zn4B5iPcUE02fjerON6+xUguYLJqHQhqfL2Yz2BEAnmun5Xo5e/z4BkXGW
	/l4RfZS+XhikmTao0BtKDgFjNw+v+7YhID2L9dJk+fDKvIwDDI1q5uaXFr9LtTcHtwIFq4lLtvyo1
	1bxXhBdQjHg+THBJePyp6TFxY548s/eIu53mF5K06QvvPAStOO79VeXh8mJd2OptR85ExZMs8W6pI
	82qZ75myCy23t+84diiqhkVPOtHT/dxr7Mnw==;
Received: from [172.179.10.40] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1srZtf-006Eq9-3r;
	Fri, 20 Sep 2024 05:25:51 -0400
Date: Fri, 20 Sep 2024 09:25:48 +0000
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"cl@linux.com" <cl@linux.com>
Subject: Re: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Message-ID: <Zu0/nKB5oRF8Yvdk@csail.mit.edu>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
 <TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <TYZP153MB0796B44322EAE4C712883201BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <SEZP153MB0791CB961FF0D1512DC47164BE632@SEZP153MB0791.APCP153.PROD.OUTLOOK.COM>
 <20240920011618.bb2d2a247ae59810aee6c39c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920011618.bb2d2a247ae59810aee6c39c@linux-foundation.org>

On Fri, Sep 20, 2024 at 01:16:18AM -0700, Andrew Morton wrote:
> On Thu, 19 Sep 2024 19:52:45 +0000 Saurabh Singh Sengar <ssengar@microsoft.com> wrote:
> 
> > > > >
> > > 
> > > Adding cl@linux.com instead of clameter@sgi.com for Christoph Lameter
> > > 
> > > - Saurabh
> > 
> > Hi Andrew,
> > 
> > Can we get this merge in for next kernel release.
> > Please let me know if there is any concern with this patch.
> > 
> 
> Anshuman's review comment remains unaddressed:
> https://lkml.kernel.org/r/b1dc2aa1-cd38-4f1f-89e9-6d009a619541@arm.com
> 
> Also, Christoph's observations from the v1 patch review haven't really
> been addressed.
> 
> So it sounds to me that an alternative implementation should be
> investigated?

I believe Saurabh had a follow-up discussion in person with Christoph
regarding this patch, following our talk on this topic at LPC:
https://lpc.events/event/18/contributions/1817/

@Christoph, would you mind giving your Ack if this patch v2 looks good
to you, or kindly point out if there are any lingering concerns?

Thanks a lot!

Regards,
Srivatsa
Microsoft Linux Systems Group

