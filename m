Return-Path: <linux-kernel+bounces-561559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4912A61378
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF553B2300
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D720012A;
	Fri, 14 Mar 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="f/eV2XIG"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0F1FF614
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961813; cv=none; b=XqhZgI5Cf9wO2EI3qQSxA0z8IWzvfTj0kQI9aMpbEbgnjkWx/iwbHG1SpzHyqd8qN2EsZjWT5Ro0YDIZ3ADlKyzf2TvHQk7jzciriOm72DnllfZJ5BB3Sv8ra/SSE0YK9FOSLUS3am9+nkOhc/A7Iqshk1QD2QE77/jzWrerLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961813; c=relaxed/simple;
	bh=Geb6bW6WUD3PYCqxJsRFOgeXPWjv0jdxnoSzjmLv07o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbnnEz1lqxE61FurPVOJJi56VCNKmHTXoJ4OuzwBFtAQsyBFzL8uZNPKNI0nfyXQ0j/VS1w+BcJqRJD05e71kSiQpUPXhGlGSYpVprLmt3alkRhM/kRrAZywExn7S6Ehh7Ks2YxgAFcichz5MKdJIYCQiRVfVbJse7gDIuBuYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=f/eV2XIG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c08f9d0ef3so123110085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741961811; x=1742566611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8W7ZUxgohAw+y/XsscWbOpAfNMeQZF+P7nEeEyn86w=;
        b=f/eV2XIGE0CO/Bk7HFxcUVvzEEh5RVUt4Gf9jWXBeJb8CSgzO7LTzXhaHM/S+ANvjB
         0sxVz42xlgr2ZPc/S3ombatSsTXOpFlWwFW7mdiAw6UGhw1dwO94kLSaUfKXrUcp5SUd
         xKLZR525NFuvufE1Ktl+Ah7eM599c1sIHPXBwx4V7t8MpHeEQUJ3UzZ3Nk3BIQMXQJ2S
         5zskRp7GIVKFk7iVr+IlV2x87mYdYGpMBQuI5G5oIu7pv/e4FzDWeLA1Zs4FgyMrVk/3
         QQfesEbfVXCfqOJO1Ip87RfwD4M//Q4ASAv4Ajtm45j1H8b5Lk0lIkltp2HHQjl256TY
         tupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961811; x=1742566611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8W7ZUxgohAw+y/XsscWbOpAfNMeQZF+P7nEeEyn86w=;
        b=Nc4mugeo5NQsiyORLQL/rqOnDyxGIkyb6MNQEF8Qrbkf4EoaewqpKDl4OL0l/se63B
         x+QUFTocYgXg6nZSUdR9EjDMJ3PL4MSwFt8IbxwScvZExHT6eQLgVG+lbKIOqNdXF3jI
         a7rK43xseIpIJ1FTp+Ze/WIseJ117L/6w8G/r9f0kSSABQUujio2+sfQlS7cgIqPa40Z
         P+0p/WXFKA8aIuJlp/UtwsX7Af91kSi1+tI27BnXzBmLfHX4ZQS1GgJaJ+enjjOFyTez
         zI3nfeny4v3VhO+y9oxNhzxi+nU3mE4U4B+raQcUxnGeT1s7aKuPgvL/982uQeLadIEx
         61YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKfUIrQzF1Q+ShBLhcCQlhxfPjjV9GfWAdHVoMMVT8tSnrydHM/MbPC2Q4t4qWyMd9jWohjQk/dcCy+FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+2T3miMoVYgt3WHO68sLPixMA4fyB0m5ihp3E/IKUkpFAxvo
	E+n+Hi1sLRJR782VL/DU5nfrrjI5vx8dzOSys1wzNMWZQ9mkzqyG6BUTpA0QXg==
X-Gm-Gg: ASbGncu+723PIPhpRz4iSdhLdKohYoWbyKoippyH3AOilDnPvApys3Pl049YcLoDjmb
	i1O2KC5jrdvZopHvP8KZ6yBN/4Qr7akJHnCM03ko+pWkEAewUoMsSShxSdJ2TM0KRKgQnC5eR7i
	EiFBCJ/tufRpXa/FHpVee5g+r8SnGuxZAnPDwfT9FssmKKy3Y0yu2U0pEP1q7x8j34gWi+6p94i
	P5fiAahdmeFOxGa9ysoB5nZhtYAqLkwmsh5y0RtoLq2rZWXkYrDWkVJ4M4XPtXmsQt8w3VmOvMW
	a0xU1LVjLrGRGLb/avhxGGiGhaTrdr892OmVp7VvgXC5b1LBo62gP70QSJNn8ZHW2nQHGyJ8SQ=
	=
X-Google-Smtp-Source: AGHT+IEtOrNOpN8ywDqilJgGQwMTggMzkecD4ZQIquaFuyxZ6BMKQdV7ISqLEH9mWawDv3AW0LIxGQ==
X-Received: by 2002:a05:620a:1915:b0:7c5:5286:4369 with SMTP id af79cd13be357-7c57c7c2175mr289543085a.28.1741961810643;
        Fri, 14 Mar 2025 07:16:50 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d8a3acsm255828885a.109.2025.03.14.07.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:16:50 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:16:48 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: daixin_tkzc <daixin_tkzc@163.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	matthew dharm <mdharm-usb@one-eyed-alien.net>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [usb-storage] Re:Re:[PATCH] usb: storage: Fix `us->iobuf` size
 for BOT transmission to prevent memory overflow
Message-ID: <516c8f89-45f2-4d3f-b1e7-29aecfc8cd3c@rowland.harvard.edu>
References: <20250311084111.322351-1-daixin_tkzc@163.com>
 <2b6c4aa7.b165.1958f6b7a3a.Coremail.daixin_tkzc@163.com>
 <814316b6-013b-4735-995d-b6c0c616c71b@rowland.harvard.edu>
 <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>

On Fri, Mar 14, 2025 at 10:28:41AM +0800, daixin_tkzc wrote:
> I'm sorry for not making my point clear. 
> 
> DWC_otg driver can handle packet babble in the data phase properly. It provides interrupt function, dwc2_hc_babble_intr, It mainly does two things:
> 
> 1) Delete the URB request from the endpoint linked list maintained by the USB host controller, mark the URB transfer result as OVERFLOW error, and delete the remaining URB requests in the data phase of the BOT transfer.
> 
> 2) Halt the currently used channel and indicate that the reason for the channel halt is Babble Error.
> 
> When the urb complete (babble error occurs), the sg_complete function of urb(s) will notify the mass storage driver that the data phase of the BOT transfer is over. The rest is done by the mass storage driver, such us:
> 
> 1) Get CSW for device status, interpret CSW, return USB_STOR_TRANSPORT_ERROR.
> 
> 2) Handle Errors(here is USB_STOR_TRANSPORT_ERROR).
> 
> 3) Initiate port reset.
> 
> 4) Notify the SCSI layer implements a retransmission mechanism.
> 
> How us->iobuf overflow could occur?
> 
> For 1), the USB device does not know that a Babble Error has occurred at this time (DWC_otg knows what happened), It actually continuously returns 512 bytes data through DMA write to CSW address (As can be seen in the waveform in the appendix document before). The DWC_otg controller driver cannot control how much data the device returns(13 or 512 bytes).

But the DWC_otg controller _can_ control how much data gets written to 
the URB's transfer buffer.

>  However, the USB storage driver pre-allocates a default buffer size of 64 bytes for CBW/CSW.

Furthermore, the CSW URB has a transfer_length of 13.  So the DWC_otg 
controller will ensure that no more than 13 bytes are written to the 
buffer, even if the device sends 512 bytes.  Right?

Alan Stern

> For 3), the device does not realize that a babble error has occurred until the port reset is successfully completed (by interface usb_stor_port_reset). Then device will enter the enumeration process. It looks like things are heading in the right direction.
> 
> For 4), as for the urb that has a babble error, SCSI will execute a retransmission mechanism.
> 
> thanks,
> 
> Dai xin
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2025-03-13 22:36:32, "Alan Stern" <stern@rowland.harvard.edu> wrote:
> >On Thu, Mar 13, 2025 at 08:12:20PM +0800, daixin_tkzc wrote:
> >> Thank you for reviewing my patch.
> >> 
> >> 
> >> I'm sorry I just responded individually.
> >> 
> >> 
> >> Of course, when the USB device and host are transmitting normally, us->iobuf size is 64, which is enough for CBW/CSW and there will be no problem. 
> >> Howerver, we encountered a problem in the FPGA verification environment, that is, the DWC otg controller detected a Babble Error, and we believe that the processing flow of the device driver will cause the risk of us->iobuf overflow. 
> >> 
> >> 
> >> Regarding USB Babble Error, the DWC_otg_programming manual describes it as follows:
> >> |
> >> 
> >> 3.8.1 Handling Babble Conditions
> >> 
> >> DWC_otg handles two cases of babble: packet babble and port babble. Packet babble occurs if the device sends more data than the maximum packet size for the channel. Port babble occurs if the controller continues to receive data from the device at EOF2 (the end of frame 2, which is very close to SOF).
> >> 
> >> When DWC_otg detects a packet babble, it stops writing data into the Rx buffer and waits for the end of packet (EOP). When it detects an EOP, it flushes already-written data in the Rx buffer and generates a Babble interrupt to the application
> >> 
> >> |
> >
> >What is your point?
> >
> >Are you claiming that the DWC_otg driver doesn't handle packet babble 
> >properly?  If that is true then you need to fix the DWC_otg driver, not 
> >change the usb-storage driver.
> >
> >You have not done a good job of explaining how us->iobuf overflow could 
> >occur.
> >
> >Alan Stern
> 
> -- 
> You received this message because you are subscribed to the Google Groups "USB Mass Storage on Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to usb-storage+unsubscribe@lists.one-eyed-alien.net.
> To view this discussion visit https://groups.google.com/a/lists.one-eyed-alien.net/d/msgid/usb-storage/1681f087.2727.195927b7ccb.Coremail.daixin_tkzc%40163.com.

