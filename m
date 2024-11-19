Return-Path: <linux-kernel+bounces-414863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCADB9D2EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FCEAB2D1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861DC1D14FA;
	Tue, 19 Nov 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajZEFwjw"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B890192D77;
	Tue, 19 Nov 2024 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042905; cv=none; b=flnBjvDvH86UxL5vwF+pLFdB+Jp/y2aOTyAN64nuZ4O7gqeLDbBW27Iiv46CCfrihCNej5H2WT7c5jOKmyNmlAAk3dbim+SvSdqDw9/C6zSt5WmCznkQAhW2i943WyY91yKbvM6kkE7EUWgYZROIHFnpH+4fGu0KMC8jX+2MTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042905; c=relaxed/simple;
	bh=IWDFBcNvrqriRnoaP1Fh/nC/Xwv2LV5dAXxCyDI4iO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKodXQIoE/gldF544yyxdv7mw3ziVPzB0fmOKLjcYX/HDGpy8+KbHWg+iVebblhs3cRj5Mu+GLQr4EWu9luXDc8HKWjsdS4YOSBB9Y2UDrkcZATIFFcl44yniNilrcmxtWU6CjopLM28u8EyrM56chhrRQ+eNACbUdniHLYMtxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajZEFwjw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1056646a12.0;
        Tue, 19 Nov 2024 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732042903; x=1732647703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/LnMFGg33JNaBQ/NtN4BE1ZbxWEIqt6BhyRk4n/U74=;
        b=ajZEFwjwr/KEMF3VyylRc1iSn+HzmqvKvpkvwqrFYgDFkKlPf4Z2wQVV/z+T2ejL9Y
         ggtRje2W1T7dQE1jOiHKYx8kaN9dkznK0g9Cc7sRzKXOUDQJO95ipLdkUbHi5f9HJQPS
         o8U70scfih6/3eaTBX3F3+TlSmxN7KXaswNpKEb4IfT7hRWr2WJ+ymDmXLC6rz6BLD01
         H/vGOwy7aYLpcHP9XCoj9vofCIufT//AePlDasNrDRSOqz3y1nbr7a7nQjYQ/oFjJwCS
         MZd8dsH1dntciwosqhMeGMqwK4n3SE0gle/RJ2T36h0PTxwKQfU2hy5RGtQnle3f2gQb
         wkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732042903; x=1732647703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/LnMFGg33JNaBQ/NtN4BE1ZbxWEIqt6BhyRk4n/U74=;
        b=gou+a5QZ/rmDBBe2nNVa58RkEgY9Ge1sS8V6bR/0mDGfS+YwDLAciISe7ufxaLWxLf
         CzMptxvIkxomKAeSpKBxYaO/WYZc2HVQL6epSZf9RbPRdk8HwB4nl0JK4n4RtctcSPks
         gYDTHgQYYOcUTv45t3Ni39ZHYB1BDliHsF0Gt4IeoEH47va4GM1ITDwuFQSmWMU1UeXD
         uajqGJaB+hb87KqXW5zQQW5IcgNazkXuNrpJdUKEBW9am7vET5DrzJMQtQSnm09+w+sa
         D07vt3WuPTEU2ti9kvC+SzPp8+U6i99m3ZyrkkxTH/tBd4VPCHzEnzkrKJD3MwYmBBzp
         1/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUcRCw+fb27se1c9vzwdBWTju7HsHg0bDcs4fEEVvxMANKLeCtYoG9JGy8uNjuUox4vplc2YIk9tZD7TUE=@vger.kernel.org, AJvYcCXxUNUE+jmf4PuRlHrcRkmtJmfxLQtneZm0sD5n6SOcvo8jnnkRWdkeJmt6rXB33kfFJFXllbDifNROR89hOAaS3K0YIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxsk1C/C7BOKw38MMdX2CzB9TeyLBRo1qFxwnDZOcDOn/H66+t
	BaiYpSGzqr+lazEHbF/XeVdpIhNUad0NEiBgN4dvFsA/nZC5OqIm
X-Google-Smtp-Source: AGHT+IE7tHX/9456ev7XNe+vtXW0uAEdRPwD/fdLoI2xJROppw4b+UtgxXjhECP9Y6O+4nymqVLbWQ==
X-Received: by 2002:a05:6a21:6da2:b0:1dc:30b:324c with SMTP id adf61e73a8af0-1ddade0af02mr335769637.7.1732042902741;
        Tue, 19 Nov 2024 11:01:42 -0800 (PST)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c67a41sm8123370a12.49.2024.11.19.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 11:01:42 -0800 (PST)
Date: Tue, 19 Nov 2024 16:01:38 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, LKML <linux-kernel@vger.kernel.org>, 
	Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 4/5] alienware-wmi: Fix module init error handling
Message-ID: <wlgbeskxv3z3mpoaydcktkgqsn3g7vewhto6vcjarexlvsqlk2@ug5y4efk7yt6>
References: <20241119043523.25650-1-kuurtb@gmail.com>
 <940b49da-cbca-42d4-9a80-501465bc8cbe@web.de>
 <tuqhdoqturo2yjqcxgood3xagjloctouuxc4unqwdy3uqnvjau@xqqgw6jb7ztv>
 <31712d24-e1ae-0928-a7ab-a1f7116844ff@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31712d24-e1ae-0928-a7ab-a1f7116844ff@linux.intel.com>

On Tue, Nov 19, 2024 at 06:22:34PM +0200, Ilpo Järvinen wrote:
> On Tue, 19 Nov 2024, Kurt Borja wrote:
> 
> > On Tue, Nov 19, 2024 at 03:55:08PM +0100, Markus Elfring wrote:
> > > > Propagate led_classdev_register return value in case of error.
> > > > Call led_classdev_unregister in case sysfs_create_group fails.
> > > >
> > > > If alienware_zone_init fails, alienware_zone_exit should not be called
> > > > because the latter unregisters/removes the led class and the sysfs
> > > > group, which may not be registered/created if the former failed
> > > > prematurely.
> > > 
> > > How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12#n145
> > 
> > Sure! I will on v2.
> > 
> > This might be kind of obvious but, if I add the Fixes tag, do I have to
> > make the patch over that commit, over stable trees or leave it as is?
> 
> Hi Kurt,
> 
> You do it normally on top of pdx86 fixes branch. In this case because of 
> the on-going merge window, you'll have for-next patch to enter there 
> before your fix will get merged after -rc1.
> 
> Don't worry about stable at this point too much, other than try to have
> the fixes patches as early as possible in your series to avoid conflicts 
> with the other patches within your own patch series.

That's good to know, thank you very much :).

> 
> -- 
>  i.


