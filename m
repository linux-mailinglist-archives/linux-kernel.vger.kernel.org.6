Return-Path: <linux-kernel+bounces-254823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C96933829
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D011B22D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927E91CD0C;
	Wed, 17 Jul 2024 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cPMS+Vel"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2AD20B0F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202126; cv=none; b=MRan39PxQfesZSyjiJXK1QXmhGN/UfRSwXJrgsfi4ILp+xIO9rBNkCInP+2gvRgRIq+0UCZITtskSVjSMp096JfkP3mDFqJir8xNMBFLqGzW4YCEIRIZFDl0Q9EfymqXP8QdrWOLrNoFApy+UmjXoaR9htbv2QEWKgPw76+IuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202126; c=relaxed/simple;
	bh=OiffStuUSLh1cS5l+P2QiNDzFgzly7BoWKy89/nhqHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJ+/gX+l0qD2qiTUtf3RTSS1kZwS9/5EDWCHtqZ1yYG0+gsnEmorI1T2wlwdmEBw0dKiX0/6cB+kGSYmSYaEQXSL6FRmLuxKtdHcpdX7ygheRGsUMYGDaSINX2X0KVRcix13B2UKYZnNKPOn6v+imuJrxHZ0MR1eSfoP9Ff9Hu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cPMS+Vel; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367963ea053so5239370f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721202123; x=1721806923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8O2GqN4Vi7Z9MREfEbIQ23yM5JSotW2UOauCW1qsCXU=;
        b=cPMS+VellLfsaV8sKmXth6i9o052x3TkiO8S7Owqxzf/jl3TjkW9V6tTznE1aPgEuI
         8y4cifC2hFr9tgcZmgr/adFSiPxclYQJYcc2523+LE5IMQ+lueIwamIE/APc+NtdOEuG
         993RVWNbapqCRu92MgkKmJWqwn46zwKacc7ZhpUrivCxHWDTzDD6eJdOJT/m+YNnG1VM
         BavT5qAR3kACWzvnSDhphneIXu/9sdOblF9YFpQ6ClgmfVZ9rt5W7ql9I1nRPOhIgQGp
         JV06GzizTvopSVONYSDcpRL6lABZg7u9KzOvmtfdo0Xh1OrLqNVjEcIz5FC8BJD0EOw1
         VLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721202123; x=1721806923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8O2GqN4Vi7Z9MREfEbIQ23yM5JSotW2UOauCW1qsCXU=;
        b=xQrz7Ip5xzbst23umw3+fne1opp9Ig0pg7mj4PgfDpV93sw60Xd86aLT5g7Ftgxr77
         PUHKwMBap1ax3u3GIerSG4lrtmCuTz1ZzH65rWY2Km4USpSSxP/uN4YsMgE0Szu3UTTx
         zSv767XBSHY670MP5MwEkcafEnOI5rKHCQz6SekHCEqG+ziz0szZOooD1+QE6WIQuA32
         UhWfmepEpBtwnsYFVWF2LZqZvUi0fVjW4/61HIyIYZLfHBtSkQitWiwDR/g7BTDyWpO4
         ndSqAzdNjnB78kI5GbctDhvVADCG66rXipJE1vw4bCm/9bDc/TUQw5+uMnhIrxNaZ4ZT
         UIIw==
X-Forwarded-Encrypted: i=1; AJvYcCWxvqnEK6SHjIJBT+gqMkE6pwoxh3qZwFuJsZ7EnfnYbBr+zZpdTO0K+uiIvs9MKn+l4QE7V3lCc9dJhMbbw359GjPXDKc1RCE1er+7
X-Gm-Message-State: AOJu0YwTd4P38l3gA9kZwF1M8+vpMpgsC9gDTXDpH7u9JiWibIG3fuyW
	++irmINqTXQF4ASdMP3IxnodogADMPPuBM+HxkYK2Jr5XUDqJBYBTlYta7p5Amc=
X-Google-Smtp-Source: AGHT+IHzAG0DLEccG8M5eU2CIZi4PVHwhBeNXTo0q0B0a4qNJC7uN9NoXE53DDedUs1wstSZjx4fxQ==
X-Received: by 2002:a5d:528a:0:b0:366:ec30:adcd with SMTP id ffacd0b85a97d-368315f2017mr835182f8f.7.1721202122495;
        Wed, 17 Jul 2024 00:42:02 -0700 (PDT)
Received: from ?IPV6:2001:a61:137b:5001:be5a:c750:b487:ff1b? ([2001:a61:137b:5001:be5a:c750:b487:ff1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb9aasm10940535f8f.67.2024.07.17.00.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 00:42:02 -0700 (PDT)
Message-ID: <a648a2b3-026a-445c-8154-2da43b641570@suse.com>
Date: Wed, 17 Jul 2024 09:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
To: Hongyu Xie <xy521521@gmail.com>, stern@rowland.harvard.edu,
 oneukum@suse.com
Cc: gregkh@linuxfoundation.org, brauner@kernel.org, jlayton@kernel.org,
 jack@suse.cz, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehongyu1@kylinos.cn
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
 <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
 <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
 <3073c8ce-1923-4816-a442-41b4cc333af9@suse.com>
 <6419a4e9-e084-4eb6-8376-9202930ea8be@kylinos.cn>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <6419a4e9-e084-4eb6-8376-9202930ea8be@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.07.24 03:43, Hongyu Xie wrote:
> From: Hongyu Xie <xiehongyu1@kylinos.cn>

Hi,

sorry for being incomprehensible. I'll try to do better.

>  From what I know, that CONFIG_USB_DEFAULT_PERSIST is enabled by default. Then udev->persist_enabled is set to 1 and this causing udev->reset_resume set to 1 during init2 in hub_activate.
> During resume,
> usb_resume_both
>    usb_resume_device
>      generic_resume
>        usb_port_resume
>          finish_port_resume
>            usb_reset_and_verify_device (if udev->reset_resume is 1)
>              hub_port_init
>                hub_port_reset
>    usb_resume_interface (udev->reset_resume is 1 but usbfs doesn't have reset_resume implementation so set intf->needs_binding to 1, and it will be rebind in usb_resume_complete)

That is correct. But even if CONFIG_USB_DEFAULT_PERSIST were not set, losing power
would just lead to reenumeration by another code path. Devices reset themselves
when they are power cycled. There is no way around that.

> Even before usbfs->reset_resume is called (if there is one), the USB device has already been reset

Yes, it has been reset.

> and in a good state.

No, it is not. Or rather, it is in the wrong state. This is not a question of good and bad.
It is a question of being in the same state.
  
> After all that thaw_processes is called and user-space application runs again.

Yes. And user space does not know what has happened.
> 
> So I still don't understand why "the race necessarily exists". Can you show me an example that usbfs->reset_resume causes race?

Sure. Let's look at the example of a scanner attached to the host.

OS			Scanning process (in user space)
			1. Set a resolution
2. Going to S4
3. Returning to S0
			4. Initiate a scan

As you can see the system would now scan at the wrong resolution. Step#4
has to fail. As there is no synchronization between S4 and user space, initiating
the scan can always be the last step.
For this to work, reset_resume() would have to restore the correct resolution. The kernel
cannot do so.

	Regards
		Oliver

