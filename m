Return-Path: <linux-kernel+bounces-261061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFB093B26E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7CE1C237B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB474158A26;
	Wed, 24 Jul 2024 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="JQy6XQfu"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C575159209
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830254; cv=none; b=a1QXkXjzdpZjQgcH/21LWB8CWj6zIsluwALdlP8GjaGBQOnGq6Se1FzR2i6mmXdzj/DbeBGFGgblzeIySz+ujeNwqQrEPbhUZse6CCVhYH/303kLpcTLRHSM0Bm7ur82AO+QEgcCHrykjUUjycJguyE/xOeFUyR34l7c45yEEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830254; c=relaxed/simple;
	bh=WCJyBobz6smTbmKlx36emfO2oVXSkOoGiLvQctDNI5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTmahulmBQNjFPSkKz5wm3R1bMKF66rfrSG0DKViTnxBAYoKqRQ/IS4aUxMPcDV88CLeHdPWyCuY3YSIe1k+kkDArLDWr4BoC/KWhjHI8BOLEGpL697S6DOjr5o9dkj922UOR/cHbTLfbIg5VNQBEibxs66G5lgWUoLT85SjTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=JQy6XQfu; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5d3113168so39126556d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721830251; x=1722435051; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vycBET30X6TjGJ5PxFXWeaVz1FTniAKOujocO4/MY08=;
        b=JQy6XQfuPgOtRijMsXOHkDzVLSjHYHANRoaj0NU6A/7AMW2PFHpCITrMnqCWs/2OrB
         Jt6aCGBuGJR90KvtZm64YXKot57k3cNIgepQHWGVay9KDYTJoWtICFRcacZm33vWPq4q
         JwhW8T4a6EObAZh2Ixo+Bqk9k6NqwkkPF5RSZKxPOWaBI0WLXpWnOqBHUzM439atQ/7I
         XlcmHP4G1AsV6G3AzclkrFSPJNUSOVMRIi+uW6LD6W4Uy1zd73ocKH1SEqm+8xU/z/LL
         t7wnphmTdsC8ffUjVyentszi7bkl8XacqikhV/NovSZKO3vSbzIS0t0g3Tf4+ynnhuCU
         7dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830251; x=1722435051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vycBET30X6TjGJ5PxFXWeaVz1FTniAKOujocO4/MY08=;
        b=n3OD+nBXXaWQAOwx144T4PHliBi31nYHMOBK//8CmmppU617ndswZGOvAn5OysNLZN
         9Y08mzdq3+H/DVGbwkLs3g9pINoAev3JOwSht6ESpqxiMuepl4mlpDHxTW0ij9BRxS9c
         6CLypf0wYszmmqx5BZyjm0uWYD2TiPZZzWTOL+C3kSGXhRknBkKZCFJznpxIMYEyFBmo
         gcjuVpiBXXsPqfKbZk4L76tByi0l05EkYRKUthEsupCkBjCHO2g+FSXFWQr6CQOX/oQ1
         DSj3CVN/Dvmsrf53fCnc/fbnMx9LO9O8SI43CXWtFRBIB0vJukdvSG3IqzgagXeH0p3v
         rzsw==
X-Forwarded-Encrypted: i=1; AJvYcCVTKLHkewpOwU2U/eQkt+XXco1WggtWPjDW1BRZXgqXHClArCKqUKR+Mg8l/DVByTrh/ADZONWTna4MvEux7W+s2iu1B1gTt9HbWF3X
X-Gm-Message-State: AOJu0YyeZEGg0J/Gu4nuz/Wf5PelhlGRVL1BQQ2S8ce0GhvqjHkWGV0C
	DC93g9ms5nOfi76mkxZim13AKHJJ3lJ6QhDmvc2W5yV9SQq9ldql+wKOyQB+fQ==
X-Google-Smtp-Source: AGHT+IGM3RVQIsmIhKHe+YhNWt5+A1vmr9zp7TqkJna6ypfgkB+6E1J84W5dnHC4XkQwB87beI4ukQ==
X-Received: by 2002:a05:6214:40e:b0:6b7:a1be:a76a with SMTP id 6a1803df08f44-6b9907f5f34mr24105356d6.57.1721830251109;
        Wed, 24 Jul 2024 07:10:51 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7f15c6sm57372646d6.68.2024.07.24.07.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:10:50 -0700 (PDT)
Date: Wed, 24 Jul 2024 10:10:48 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Brownell <david-b@pacbell.net>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: hub_port_reset: Remove extra 40 ms reset
 recovery time
Message-ID: <c7c299e7-605c-4bd6-afad-dfbfe266aa7e@rowland.harvard.edu>
References: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724111524.25441-1-pmenzel@molgen.mpg.de>

On Wed, Jul 24, 2024 at 01:15:23PM +0200, Paul Menzel wrote:
> This basically reverts commit b789696af8b4102b7cc26dec30c2c51ce51ee18b
> ("[PATCH] USB: relax usbcore reset timings") from 2005.
> 
> This adds unneeded 40 ms during resume from suspend on a majority of

Wrong.  It adds 40 ms to the recovery time from a port reset -- see the 
commit's title.  Suspend and resume do not in general involve port 
resets (although sometimes they do).

> devices, where it’s not needed, like the Dell XPS 13 9360/0596KF, BIOS
> 2.21.0 06/02/2022 with

> The commit messages unfortunately does not list the devices needing this.
> Should they surface again, these should be added to the quirk list for
> USB_QUIRK_HUB_SLOW_RESET.

This quirk applies to hubs that need extra time when one of their ports 
gets reset.  However, it seems likely that the patch you are reverting 
was meant to help the device attached to the port, not the hub itself.  
Which would mean that the adding hubs to the quirk list won't help 
unless every hub is added -- in which case there's no point reverting 
the patch.

Furthermore, should any of these bad hubs or devices still be in use, 
your change would cause them to stop working reliably.  It would be a 
regression.

A better approach would be to add a sysfs boolean attribute to the hub 
driver to enable the 40-ms reset-recovery delay, and make it default to 
True.  Then people who don't need the delay could disable it from 
userspace, say by a udev rule.

Alan Stern

> Fixes: b789696af8b4 ("[PATCH] USB: relax usbcore reset timings")
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: David Brownell <david-b@pacbell.net>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/usb/core/hub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 4b93c0bd1d4b..487d5fe60f0c 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3110,7 +3110,7 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
>  			usleep_range(10000, 12000);
>  		else {
>  			/* TRSTRCY = 10 ms; plus some extra */
> -			reset_recovery_time = 10 + 40;
> +			reset_recovery_time = 10;
>  
>  			/* Hub needs extra delay after resetting its port. */
>  			if (hub->hdev->quirks & USB_QUIRK_HUB_SLOW_RESET)
> -- 
> 2.45.2
> 
> 

