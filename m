Return-Path: <linux-kernel+bounces-336485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A53F983B64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4891C223AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9615E96;
	Tue, 24 Sep 2024 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="UQrCDYTV"
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166761B85FF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146591; cv=none; b=BSk/KxhE74xzuh8EV/JjdUXpvHeKyix/uQeptnXu0tJw1Ip57KnlYS5CKJPB/j//7c9hD699ACLzj8Or74uub3xGbk3ttYZapufH8xl+1wb5hRsUSW7qTs22VyVByiYtzjjfzundpVh0614ias0VpGfDsVkIxyIjrw+gtm67+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146591; c=relaxed/simple;
	bh=3r9orr/TrGhIkbJIar7PT7lPiK/7NZX5wnJT5ck+f0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeMt3QuV5/H+FDhW8n4uBB72Ckyo9VGaQXehyZk2tm5Ea0x8ZLWywsJsf8LZiEWyeL3mSwvabMF4bm9D/048OyvLZXNvL3xjSB5sXrijR5XEwrLkshaAmEo+SadvMbSqzpxk33aKZWElQC7MSku808xRdfaKlPVDcPtWBYbQRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=UQrCDYTV; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PNlnOtKzcBaTIBUSLwkMlSQRovYatJq4wqgn4uBydq8=; t=1727146589; x=1728010589; 
	b=UQrCDYTVb6wvflmJzFrdHxKc3Tzv8OceHhkmlrIYvGCJgpx5TuKWeVOruK1NciS4/7OSTfbWMhB
	nZZlzVjboc5gMbInRr53GbtqrC7RL4jOeUrImWJEhHTwn9zKoL0VxQ2NjRoF7BUS74ARCvvg6kK1d
	5fb0NYHv63DwVqdVYXWl9iEXqhChL2naXcHx5KrrdOljr68lBzNP7+GDqApJCCFvVjGuobwrNIGwg
	FAgLinbyivV4dPnVE5H47AgmEHCCBAVDO+4gtLEIK+IIr8e8Bo63xvbWxmcI5/P4fIGooWoXA/J8D
	JJ00y8Rb/lr+7Rg9GaO8OAQA9WHeVlGp82ww==;
Received: from [49.207.232.169] (helo=[192.168.0.101])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1ssvit-00EpJN-C9;
	Mon, 23 Sep 2024 22:56:19 -0400
Message-ID: <8ca7bf74-c6c7-405f-baff-adebd8957620@csail.mit.edu>
Date: Tue, 24 Sep 2024 08:26:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Content-Language: en-GB
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Saurabh Singh Sengar <ssengar@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "mgorman@techsingularity.net" <mgorman@techsingularity.net>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
 <TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <TYZP153MB0796B44322EAE4C712883201BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <SEZP153MB0791CB961FF0D1512DC47164BE632@SEZP153MB0791.APCP153.PROD.OUTLOOK.COM>
 <20240920011618.bb2d2a247ae59810aee6c39c@linux-foundation.org>
 <Zu0/nKB5oRF8Yvdk@csail.mit.edu>
 <529015dc-403c-7cc0-5b66-95739e1c78d2@gentwo.org>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
In-Reply-To: <529015dc-403c-7cc0-5b66-95739e1c78d2@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24-09-2024 01:47, Christoph Lameter (Ampere) wrote:
> On Fri, 20 Sep 2024, Srivatsa S. Bhat wrote:
> 
>> @Christoph, would you mind giving your Ack if this patch v2 looks good
>> to you, or kindly point out if there are any lingering concerns?
> 
> V2 looks good to me (unitialized pcp values result in slow operation but
> no negative other effects) and the late_initcall() is always executed.
> 
> Acked-by: Christoph Lameter <cl@linux.com>

Thanks a lot Christoph!

Andrew, could you please consider picking up the patch for the next release,
now that all the review comments have been addressed? Thank you very much!

Also, I'd like to add to this patch v2:

Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
 
Regards,
Srivatsa

