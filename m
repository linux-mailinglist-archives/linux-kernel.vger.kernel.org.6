Return-Path: <linux-kernel+bounces-538807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC0A49D48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F64A7AA344
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470691EF365;
	Fri, 28 Feb 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="OaR8JR4B"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60126E63C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756085; cv=none; b=fpIzgizSnFP7u7maGIgjdFOy9+cw6U4E95hDr4mVUjf1bPT+RdL+vux75GFVKVZ3eJKYTyyUSuS7vLUNhUGSREo1RrRsOmYejzBGLpkxeAR4qMu2Mp/9TIVB1BVjjg0dgDJ3Z4BWNy1FoUL1rLEpoiNw0jOUgYiEyQa9x2cDOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756085; c=relaxed/simple;
	bh=KECKa7HXMO2S6P3OFCfRxoEsFc6wINxBWgMsRAegBDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSn1F12OS3ejiE/y1WSGHq7dhw93nxWNbcUnlEW0P6b+/kI6tHwcyGCTqDvte/4n7eFM0nrViVAaD7Eo5lkJ5ENWIR92gAkHBZM7pWW7+pX4q/af8FM+eKnyn8GVpXZxu8txW/nLWC5d5TbhfKmZOmIDT6OYe0z01GkpAntTVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=OaR8JR4B; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471f4909650so19403441cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1740756083; x=1741360883; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3zKHm2FbIZbRCZMx6XqxFdXnpMw66b0caIDo/gjHQJs=;
        b=OaR8JR4B2rsmX9MNxtyds+hdEtwp4u2R89Gve3RBe6+8WVE7oyQ9dq9/u+XZgsFt3G
         ojBWIgo0YQkzjsZhQIaY9iFrTXdzihv8ZnML9ta+89SgGgm5ojUG3ZGb3rU15V0xDt5u
         78U16ZVXeJjH36Lff8NFJsQhIwSTP2OJ9VsEkEpzbfmNuAF7xPrpNi0YXr/n/JEdQQJ+
         6akWM4Z2O4cMZFymi1Udxi/RCWQj9EavJmn28RsMoqGFzNoKWPHfLsd0t1i5ev61725t
         6yeh0hCWG305Ufnok5cZAwsncyI+MgEgg45Vwqafv8gO4/5EzZLvFPSgDfoyCPT47DTV
         fkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756083; x=1741360883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zKHm2FbIZbRCZMx6XqxFdXnpMw66b0caIDo/gjHQJs=;
        b=vaVS9+8M2WZhvDqad7BWxn2X53rzOh5BLLhPFIWnjgs2w+QonjDwtAr5hBeYkBVcAM
         7YiLOQNjxAl6CIV6KqJx4gUnCz6q0qX+VJFbMuyUCs5mo0ccs6KSmeWL1Nbe2WNsaJm+
         ck5K14NAUjwdsBrSWi4zwqGMy/WYcJkwWx0CBgZmkgdstVzKfXJA4kQAyA5zCbJfRNUK
         r/ldWagfqV75eA5kc1q7MjcyvBmw4nyKFAkz5DPtzQsMHO35UUKcrWaUwIw9g5CMZG0R
         7x3taYjIcycPL3C1HkLT2wUwSnQsZVlp8Ft9xTr+j9qQkOSJOXauLLotOqq7MN4f5GZm
         QKVw==
X-Forwarded-Encrypted: i=1; AJvYcCU/b0vkwkcux5Ci2kEQzyQYtfXiCH0qzr2hPP7s0HHudu5Wg7fyy743p4xHZRKwtoOrlIxrHu0w9d2athU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9VzfRffbxXBFujYPpqdJktM/dN8slC403FzIaWTo1sb560zj
	NG8dZhLFdyH5LGMtx7gsE9xGq95t+khL23QnIMnRnhjSKVR7Zg6JUfBzJyRipcPel+7xiyVr2e0
	=
X-Gm-Gg: ASbGncu25hW4qpW5eC5oE/g8hHJAX30bU+1l1yWbUo994RpD6/i9LDY+nDXOhCjI/mK
	iwkh7am9sOxcwTY1EbDnN/RUUhJ379OnZ0am8iuxqgvRNKJCGfqPqExrjV46MBBArjtmnt3ZlDO
	ZuBvdX4dmqhAPcy0CPJXT+4OStPk2pcXU3yZoxyazboiadw2K2YFI/06OzcGKvV1pBdNXxVz9Et
	O0O3Q3HzkpTcF1DMRYfQGCeOiNTFnqZ6Y/3dbh3eXeEV16LSKIp82JPLcM7xslfzCI8G0bqVkoV
	QatCww4eEp7sqU5UVI2+f3TNk/C7PLZ5rOcrUd4FgM2/nVwhp/aqsCQdlQ8SJzQv392L7ODTuay
	vMBuukcszx5TNsPaBlMw=
X-Google-Smtp-Source: AGHT+IGz9doxOFauOLj2SOAKNV3haWXF9zvTC5dsMiNswX+IYjm/SEucg/ksBBE7PfIwgTSgi/7JYg==
X-Received: by 2002:a05:622a:11d5:b0:472:12f1:ba4a with SMTP id d75a77b69052e-474bc051974mr52432911cf.4.1740756082757;
        Fri, 28 Feb 2025 07:21:22 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b4f9507sm26119881cf.27.2025.02.28.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:21:22 -0800 (PST)
Date: Fri, 28 Feb 2025 10:21:19 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: j.ne@posteo.net
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [usb-storage] [PATCH v3 0/9] usb: storage: Mark various arrays
 as const
Message-ID: <17654d89-a9f3-478b-90d5-0bc9ab838739@rowland.harvard.edu>
References: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>

On Fri, Feb 28, 2025 at 04:11:15PM +0100, 'Jonathan Neuschäfer via B4 Relay' via USB Mass Storage on Linux wrote:
> While reading code, I noticed that some arrays in USB mass storage
> drivers are declared static but not const, even though they are not
> modified. This patchset marks them const.
> 
> All patches were compile-tested.
> 
> Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
> ---
> Changes in v3:
> - Elaborate *why* const is a good idea
> - Link to v2: https://lore.kernel.org/r/20250226-misc-const-v2-0-ab655a4a29cc@posteo.net
> 
> Changes in v2:
> - Add new patches 2-9
> - Use consistent authorship information
> - Link to v1: https://lore.kernel.org/r/20250225-misc-const-v1-1-121ff3b86437@posteo.net
> 
> ---
> Jonathan Neuschäfer (9):
>       usb: storage: jumpshot: Use const for constant arrays
>       usb: storage: transport: Use const for constant array
>       usb: storage: alauda: Use const for card ID array
>       usb: storage: datafab: Use const for constant arrays
>       usb: storage: initializers: Use const for constant array
>       usb: storage: realtek_cr: Use const for constant arrays
>       usb: storage: sddr09: Use const for constant arrays
>       usb: storage: sddr55: Use const for constant arrays
>       usb: storage: shuttle_usbat: Use const for constant array
> 
>  drivers/usb/storage/alauda.c        |  8 ++++----
>  drivers/usb/storage/datafab.c       | 14 +++++++-------
>  drivers/usb/storage/initializers.c  |  2 +-
>  drivers/usb/storage/jumpshot.c      | 10 +++++-----
>  drivers/usb/storage/realtek_cr.c    |  6 +++---
>  drivers/usb/storage/sddr09.c        | 14 +++++++-------
>  drivers/usb/storage/sddr55.c        |  4 ++--
>  drivers/usb/storage/shuttle_usbat.c |  2 +-
>  drivers/usb/storage/transport.c     |  2 +-
>  9 files changed, 31 insertions(+), 31 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20240401-misc-const-e7b4cf20d5f9
> 
> Best regards,
> -- 
> Jonathan Neuschäfer <j.ne@posteo.net>

For all 9 patches:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>


