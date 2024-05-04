Return-Path: <linux-kernel+bounces-168636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB68BBB16
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C678F282B0B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4423763;
	Sat,  4 May 2024 12:14:38 +0000 (UTC)
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302A22616;
	Sat,  4 May 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824878; cv=none; b=psttxWOMMPGZuQ91400oTw3l4evqKrIy937vKZxto7s7DMEDibQ41h4nNC7vPXb8tAJSGKQzZbdgtr5EteyLtcuI1L7azrXLWIWWFMtQ/6p+HOB+sQ1S60hnWlymvndG80iziwHII/6Z9pfrliO1AM9bG76FwzH9DMKVrBgrxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824878; c=relaxed/simple;
	bh=DtSbZ3+OvoBO0Tvog94lU+WUttXC6WgpQYyQ3aTPybs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZIOEX11dkcU26NWw13Atp6zcrzmzBsxkuGcIAEHHOz5SCKSjGrjkpsRFK/FlLL/mYuIeWz2wNlTyZv4blGZ0PnFw4rAXz8mOZZ4r4wBy8c5jOa3k6P4qA0ZTm5sCM2//3Si9eRaPOR7eRD5vYelS86DSAF2URzGfJQplqzzTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de; spf=pass smtp.mailfrom=mariuszachmann.de; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariuszachmann.de
Received: from [2.211.228.80] (helo=marius.localnet)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mail@mariuszachmann.de>)
	id 1s3EHg-00FLWC-Gz;
	Sat, 04 May 2024 14:14:32 +0200
From: Marius Zachmann <mail@mariuszachmann.de>
To: linux-hwmon@vger.kernel.org, Aleksa Savic <savicaleksa83@gmail.com>
Cc: Jonas Malaco <jonas@protocubo.io>, Aleksa Savic <savicaleksa83@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/3] hwmon: (corsair-cpro) Use complete_all() instead of
 complete() in ccp_raw_event()
Date: Sat, 04 May 2024 14:14:32 +0200
Message-ID: <4888670.GXAFRqVoOG@marius>
In-Reply-To: <20240504092504.24158-3-savicaleksa83@gmail.com>
References:
 <20240504092504.24158-1-savicaleksa83@gmail.com>
 <20240504092504.24158-3-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Con-Id: 241080
X-Con-U: 0-mail

On 04.05.24 at 11:25:02 MESZ, Aleksa Savic wrote
> In ccp_raw_event(), the ccp->wait_input_report completion is
> completed once. Since we're waiting for exactly one report in
> send_usb_cmd(), use complete_all() instead of complete()
> to mark the completion as spent.
> 
> Fixes: 40c3a4454225 ("hwmon: add Corsair Commander Pro driver")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>  drivers/hwmon/corsair-cpro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index 8d85f66f8143..6ab4d2478b1f 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -140,7 +140,7 @@ static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  		return 0;
>  
>  	memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
> -	complete(&ccp->wait_input_report);
> +	complete_all(&ccp->wait_input_report);
>  
>  	return 0;
>  }
> 

Acked-by: Marius Zachmann <mail@mariuszachmann.de>




