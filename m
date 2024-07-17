Return-Path: <linux-kernel+bounces-254602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF1D933549
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C11A1C22161
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0EFA94C;
	Wed, 17 Jul 2024 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="c9jSFFLD"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09054ED8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181912; cv=none; b=JF0QZltioUYLGYRd4Bix9N7MPdRKzC+0G6TToQGQd7i07LGQCETWwyIdPomVY3Q3Xh1eTRkvqouEN89uoHVKWrmDihvjbhJaRx52buT89r1wtrN2ZSCo9x20Us1sR/EujGhes87b4CGX7Ywkxn3/9VoGW7yGykY6zk386zf6vkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181912; c=relaxed/simple;
	bh=DVHKqDQLLUUFwbi2Pwk2XnONdO0EgeZERTHVmSdoRrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYPyn5kEACadZ21APp++WobHkySIkp/l0a6CtMF2n9PX4LdCW43aS984bl+pjV1/77rAq5/K5XnuRbL7fITzvgWew7KjKXO8F2ngZE8/47Ix31wHHzYDHUv/QzqiYG5RdZKj6vVjr4gwwATVPGAWgXn5tKEo0mimX2aXqa7UIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=c9jSFFLD; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-81179da9049so259201241.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721181909; x=1721786709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb98yk6J4SdLGmha0L+RJ3mqUkJWd7sh/FIX4cg2jcw=;
        b=c9jSFFLDTCDycjZ5GkM+iWwutxu8JdpSHK/bqOyq1nju6Z0MqY8dEu8veDnrjwB6lo
         JKWELaJZ58ohMiNpshkcoMBZtk1VBZTaP6ocqLkajmDoWMmw8ZFTvct3FvcZC2G5VsQW
         jxZbqQYqEIlC50IRBcrbZuusaiINEFlusVdkaW4PXdyDcqY0Ti1u+oYTiMIPT7185lX5
         UX10SudB5SdB9VqmNcIlA4Qh/y5NV+efk2n/+iVF8vBNobTs3rqy/yCvVmsnrjyxlWCR
         JlkpulCqtjbp2zXdt5Jw5dZ0stgLE1F8vfx85fj7vVXv+n/EbwqDBh9YpJqMYlO5Wvhw
         VBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721181909; x=1721786709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb98yk6J4SdLGmha0L+RJ3mqUkJWd7sh/FIX4cg2jcw=;
        b=v2bRDD4oV3aDn0TTzqvfRjaiK6am/S6fefSDdVUX+M+E7CgYNLfMAM0zUiHI1zIoZb
         tlWrj9m+pfmjTFP8qMd3BXcRykU4KM+lrZIsf4b/thlx8jaK68gb73dT07kELXkKNFtE
         F6ax0YLO4HL0W/79k3T6pN2dK7btUPZwMvMbbEflwmfTBtfkgpBPlMEGkzOa2EkDatd+
         gKOdAt8Pcp8E3g93BDmeJyMMs9A3wUY82wz/xL7LDIF4cl5NA0x+vyBg+h3biGPjNADC
         ybBzL4M9ILez/Cg2UyekAhu4iKWNjEn5cOEtKrY/fCfVFw9vuI+45BH9Kk1VgT7hNzti
         0uJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+yJR3mKGiYiXnmekDAVIGy+ugjnJ8eM0u8MC3fZV1GQBHMjl3C+S5XxDUvhHwBByhjbHH9oHQKhX9mnp1aKY4Ld4q7nMND5d3ra+F
X-Gm-Message-State: AOJu0YzOScu7zdOCSjYIeK/YRP8Qf5319BP2gVPePzk67ZPvcpeZ/uST
	G82o0C32Uf2honMiBxE2LQheGgxhbha6O+Iy8RDqZEAgb3JsLCyc8XLmmrPx4Q==
X-Google-Smtp-Source: AGHT+IHursfxKZM9wHq0nNVc6NFooX86xt5HXnxIDXGC6rXDzNqDerEk/vuMH44nPoM2i/0jbbFmpg==
X-Received: by 2002:a05:6102:3e02:b0:48f:8d1a:ff8c with SMTP id ada2fe7eead31-49159731b59mr557408137.3.1721181908831;
        Tue, 16 Jul 2024 19:05:08 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::8080])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7c12b6sm41199391cf.13.2024.07.16.19.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 19:05:08 -0700 (PDT)
Date: Tue, 16 Jul 2024 22:05:05 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hongyu Xie <xy521521@gmail.com>
Cc: oneukum@suse.com, gregkh@linuxfoundation.org, brauner@kernel.org,
	jlayton@kernel.org, jack@suse.cz, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiehongyu1@kylinos.cn
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Message-ID: <ee0a5160-233a-485c-a34b-99d4a1e046c5@rowland.harvard.edu>
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
 <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
 <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
 <3073c8ce-1923-4816-a442-41b4cc333af9@suse.com>
 <6419a4e9-e084-4eb6-8376-9202930ea8be@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6419a4e9-e084-4eb6-8376-9202930ea8be@kylinos.cn>

I'm ignoring most of what you asked Oliver to focus on just one thing:

On Wed, Jul 17, 2024 at 09:43:38AM +0800, Hongyu Xie wrote:
> Even before usbfs->reset_resume is called (if there is one), the USB device
> has already been reset and in a good state.

You are wrong to think that being reset means the device is in a good 
state.

The userspace driver may have very carefully put the device into some 
non-default state with special settings.  All those settings will be 
lost when the device gets reset, and they will have to be reloaded 
before the device can function properly.  But the userspace driver won't 
even know this has happened unless the kernel tells it somehow.

Oliver is pointing out that the kernel has to tell the userspace driver 
that all the settings have been lost, so the driver will know it needs 
to load them back into the device.  Currently we have no way to send 
this information to the driver.  That's why usbfs doesn't have a 
reset_resume callback now.

Alan Stern

