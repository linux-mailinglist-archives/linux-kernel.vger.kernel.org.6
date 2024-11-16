Return-Path: <linux-kernel+bounces-411778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB36F9CFF75
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8828BB24BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B227715;
	Sat, 16 Nov 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0LlfG4W"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2FD529;
	Sat, 16 Nov 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731770628; cv=none; b=TZyjG4eaF9CZ79JQh7Dax4G5HIMga1B1T1R30VuOIjDgASY5thGE8XDRdjc/31LSe+mn52pIjeNG+js0s92deQIigwB5ZCY+/qIsU0UCMY+6svjBSJLAQqPxQ/ZR4kPZ3GPLnJs1FV2PJrHfx7axsxAZajGcbVmE9rdhCYV5Mlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731770628; c=relaxed/simple;
	bh=GwfmAa5qnQq6mMnjIjgsfJOxOYrGpAQlt6L3gg12Viw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuTXU/lJZwhW+wRCpF1gdtHK6+pxavzUlXTPmySd4u4sWyhH1LlGGWkOe1pIjfphxfHzZlbHPfb7OUbWNGbmp2KYD6wjwokoiu7xJbaKjXzw4CUA8iyeIDxJoDdFcSsYqf5v3XEZfodEO/10uUXlaul644Ls6bq1XQ768/Z8OrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0LlfG4W; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5fbc40239so226382b6e.3;
        Sat, 16 Nov 2024 07:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731770626; x=1732375426; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aUhMLr+Os6n2IcHWR2ztmJRnW+7I9tUgOIUzcmvqJXk=;
        b=Y0LlfG4WXnVTAdfDw5hOQ34HJY2rPzAZt5B3ZpckOpWcCxm4e5vHUIhr9VnMqfO8sb
         lnOTFdBhxyRsDJOcztKoGEr8Fsbeh6Rfewzo37tO3KnRPUE8YqxFyNDRhTIALrHcI7PT
         C1O4WgghHWAKDT/K7G87Mdnp5EAHU6+6BtQQRnDLOx6pE4q/u+rTXDJoju1r+BsL1VSQ
         qtU0n4PA8YyhenI+NCHfZNlM3QQ1o6xM+5tlIiUcSkCHk4fIm8EETOvWiTDIf8JxHG3x
         /jOWn5l1UsBKWT5b5fpKYlFm9UZExRCsb1Vluu00v3boSdJTbAZHpbJg0IUt1eiiMl/R
         S0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731770626; x=1732375426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUhMLr+Os6n2IcHWR2ztmJRnW+7I9tUgOIUzcmvqJXk=;
        b=aqLms4g+z3mmMf9iTUcp7vfEvitm6sCFpewXSPkP/PhfT6YyvvGu95DdAhTp+0ahyy
         Y5c8tam5GwRHeHT3KOUC7QhmGqy4/zPWXlciz2h08LhlJ/Ohp+m8taNAVbvlN/N8IBFf
         2dryEilk1WnYziUBkLFBR3P9NWd8JDbkxYuSoR8UFx6S++LSvLbdeKr2MIpN7NqU8owU
         jRQ9EPgpCRAK2mM/ausRimpNJDdYx2bXmXHtEY6ml2a/gnqP1PDua2/SM+ReRT9xdqSu
         XDeEEw6Lgt0rK6na7mmjBRVqHDtaODkVO9es5IsQWMA42tOlHrCHcp4ng1LmONZbIBU7
         POGw==
X-Forwarded-Encrypted: i=1; AJvYcCUWHgq6JJ4vCFDQpXf+JPzB7o25yy8i0rUp9QK25vFF7BzAovU5EEmo+ucUktFzEz8YmGtxWxxbhdoYTogC2jKOsepqqA==@vger.kernel.org, AJvYcCXkUwFUlyo16dX8vA/6udnbsRK9jRs5Ry6b3APxOXtI/fkUGlsffA+2+m7SjJQdFDCMffXyfUsPKp7XKSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjOCRD8K7yEbdHttVBqU0f+/YjkfrNVjpbGeCev71wF6m5/fAE
	tORtvjgUJLEkzKsecGhYy6Trvhsyc87L0HjUoZWMqZqNwVuEpkFW
X-Google-Smtp-Source: AGHT+IHXul5z9iBJ5gjEx1u2zVz42H4jXYI+4yOMmOzXIDpr+zo/Y85jQdqfj6U3CjDBP4QW6RFw9g==
X-Received: by 2002:a05:6871:d202:b0:288:6c52:ffab with SMTP id 586e51a60fabf-2962de0d27fmr5281588fac.24.1731770625932;
        Sat, 16 Nov 2024 07:23:45 -0800 (PST)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651b36ab7sm866722fac.48.2024.11.16.07.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 07:23:45 -0800 (PST)
Date: Sat, 16 Nov 2024 12:23:41 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: w_armin@gmx.de, hdegoede@redhat.com, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH 0/5] Better thermal mode probing + support for 9 models
Message-ID: <hemkijs35bx73dulvhgpuzjq2ahkwcyggrhk64mmtvdblbj3p3@rwau36643fpw>
References: <20241111183308.14081-3-kuurtb@gmail.com>
 <173176940782.1711.698562469347976245.b4-ty@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173176940782.1711.698562469347976245.b4-ty@linux.intel.com>

On Sat, Nov 16, 2024 at 05:03:27PM +0200, Ilpo Järvinen wrote:
> On Mon, 11 Nov 2024 15:33:10 -0300, Kurt Borja wrote:
> 
> > I added models for all the acpidumps I could find. Also I find a way to
> > not brute force create_thermal_profile and that's always a good thing.
> > 
> > I hope you all have a great week!
> > 
> > Kurt Borja (5):
> >   alienware-wmi: order alienware_quirks[] alphabetically
> >   alienware-wmi: extends the list of supported models
> >   alienware-wmi: Adds support to Alienware x17 R2
> >   alienware-wmi: create_thermal_profile no longer brute-forces IDs
> >   Documentation: alienware-wmi: Describe THERMAL_INFORMATION operation
> >     0x02
> > 
> > [...]
> 
> 
> Thank you for your contribution, it has been applied to my local
> review-ilpo branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo branch only once I've pushed my
> local branch there, which might take a while.

Thank you Ilpo!

Regards,
Kurt

> 
> The list of commits applied:
> [1/5] alienware-wmi: order alienware_quirks[] alphabetically
>       commit: 2b8dc45b8ca31e3a0ed1d71cfc042b9b7af85dfb
> [2/5] alienware-wmi: extends the list of supported models
>       commit: 1c1eb70e7d235f5feb7b68861637a5fd0b52a9fd
> [3/5] alienware-wmi: Adds support to Alienware x17 R2
>       commit: 01bd181d21cf65e43f30948f9216571218732a12
> [4/5] alienware-wmi: create_thermal_profile no longer brute-forces IDs
>       commit: bfcda5cbcdb642a64d5b8a0229842dca7917ac6e
> [5/5] Documentation: alienware-wmi: Describe THERMAL_INFORMATION operation 0x02
>       commit: 6674c5a0eeb55143cd10514d0083624e056e7d13
> 
> --
>  i.
> 

