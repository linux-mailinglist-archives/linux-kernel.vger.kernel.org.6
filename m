Return-Path: <linux-kernel+bounces-349578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94D98F899
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAE31F214FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651481B85EB;
	Thu,  3 Oct 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="INF6BWGZ"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310113C906
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989803; cv=none; b=t40oiBs2sbxj6f5PDALAt2Odjs7l5ckQxfEjX8MycXYSCijY4vLTwPsQfUQcxKbjavn/p0G6vCPuzvJakSgs1d8D0E6p7mMgZ4urDg8TzmUjjZ+HIG6T61g6tiQgMFUU0GYLrHmfnZZLeZXFegNMhKhFfI6SyCW03b6tWepn5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989803; c=relaxed/simple;
	bh=gOnpqVQxDRa0AsHcv520fsU+gyO1QLihiJp5whM4EX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBxnvtrTUvORXnce5YNmlv+4+EbjscJTktUesIsRWZOThUR7Nw9Pal5dJPIfgASS019UuZS6SiC1V19xu0MA+ziQG1voIH7KRtuu0AJSWW8x/tvzmPBilD8ShCw6TZYM0qSlU3RL+PRG2hbnQP6HUDQMVUTRWfAI3z57ywev+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=INF6BWGZ; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 29153 invoked from network); 3 Oct 2024 23:09:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1727989793; bh=/B72OQY3UXazz9DO5mTC1Ulshej0ST8FnRZ7Rrz8Urw=;
          h=Subject:To:Cc:From;
          b=INF6BWGZjxlPVD7+IC6CMOSMJMJDRDdeliUzhcjUS6SpD9SstwlyXS/5KdEzafju1
           Huwu08y3K9HUEMt/bUCgpMXe0Z/vjUiCZJpnAnH2TVWnK9s3XXf+WRC3712YJToO8+
           mmXDOAYdVSx1Xt4833y2PS0wk/zwMsHACVpUPLis=
Received: from 83.5.182.107.ipv4.supernova.orange.pl (HELO [192.168.3.100]) (olek2@wp.pl@[83.5.182.107])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 3 Oct 2024 23:09:53 +0200
Message-ID: <e770a088-c17b-4d6c-be96-2c28032b9130@wp.pl>
Date: Thu, 3 Oct 2024 23:09:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 05/10] net: lantiq_etop: move phy_disconnect to
 stop
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 shannon.nelson@amd.com
References: <20241001184607.193461-1-rosenp@gmail.com>
 <20241001184607.193461-6-rosenp@gmail.com>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20241001184607.193461-6-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 551cf454c491af86336e125fb7157593
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IbOE]                               

Hi Rosen,

On 1.10.2024 20:46, Rosen Penev wrote:
> phy is initialized in start, not in probe. Move to stop instead of
> remove to disconnect it earlier.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>   drivers/net/ethernet/lantiq_etop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index d1fcbfd3e255..9ca8f01585f6 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -447,6 +447,7 @@ ltq_etop_stop(struct net_device *dev)
>   
>   	netif_tx_stop_all_queues(dev);
>   	phy_stop(dev->phydev);
> +	phy_disconnect(dev->phydev);


Phy_disconnect() already calls phy_stop(). The second call is redundant.


Regards,
Aleksander


