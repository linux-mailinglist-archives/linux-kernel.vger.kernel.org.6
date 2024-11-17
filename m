Return-Path: <linux-kernel+bounces-412252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46339D060C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 22:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34090B21C59
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D8B1DD866;
	Sun, 17 Nov 2024 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="W7uUTpcG"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E984A3E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731877377; cv=none; b=QTk4l5/jXGV5hOI40/ri15U8ij78kamZba1cohP59+LDky1XAL6qkVO0lBYCBJeqagCqFL81U1RKHU/ZlqXtb+NixAT5MBvl7tGe6pDCialKz8nRW5RjFapKOktZ50NF1g7+fxLHQvq77IiBQubaCJcilKfEQ8yVME4txXcvgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731877377; c=relaxed/simple;
	bh=PRFaT1as5OxBAOyjiziv8bUZQYDtkLJAhsKW6psnoGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=musQDJLurjYBaMpfqFArlgK1vftGhfkq7Y9b4jBrYSyoOKGp1f71VQunZPHH3xi+6xu3CFhzQvKSLYnmCxufUVdLaXpOsMzHvkPJDte2DQdbz2oV1BhFhsOjv6v34dmPzhji26ShC4MtECJOCaPsiXIKrlMNMSyPddiW7jd3GyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=W7uUTpcG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460c316fc37so24843641cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 13:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731877374; x=1732482174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6wjrpq+6MswuiTE+2/ghtZhteEiq8qgWQWvFqee2GXo=;
        b=W7uUTpcGH/N6FD5qyR7303J5qU+Jdl6TVRMJRB7BKHTL+yPBooaADW8CI4RLCSOgln
         7vIbMroUbC1ImqQGJVdr/pn3QDzvuTInU38bme51fzV3F144zPgAhklwhvcHGlN4NHT/
         cr/19i/oH2Lq3HqcZGuoc6K8doCkB1c+tlQ/MDt2PsLOreR4qW9CzVHa7m3aCNDXaBl8
         pnIOdJqEbZkkfA/KQbO3NYi22KayNY+hB3jHAW6+9cxZ0RtctWCN4q9JdY1QoKwNunZJ
         GMxY46a/wGM6Tevsd/OsRNYuklR03aBo0UK2k7k/aMzq/6Fkq2giqwQHrs9u17RdKySe
         vBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731877374; x=1732482174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wjrpq+6MswuiTE+2/ghtZhteEiq8qgWQWvFqee2GXo=;
        b=MYend2OuorwyAqyOV3h4WwO0hViuhY/Z/MlNwTxy3B/j+6bPBLXM8jqPgodl0TG05J
         HOLlZI9mk5F/0rf97vPfeBFdGiBVaGEv1NlatyXsGXPUf8lF6Qd1jtnsgi9JA+IF7iVD
         Nr28romxdfIJ10jIvXrvfEClVNUleD6bfmn+/1FK26R+hyD6ksPBH1ZnF610qI7BYS3I
         MQ4rwTEmJcv9yaDIr7Urwu5xWXY1QYtTRpXPYqZMdSKUm43QPEMmTYjqyX/jRgUTdrIY
         fxKalar85gNwniPYwswM9axe3AbLfSiCAme4HyTuw5e7wEe1ePMxlqNioovbUJm4C2lu
         NPHA==
X-Forwarded-Encrypted: i=1; AJvYcCWxL1cDyk03h/yiSaZ0Qvj439CXW/VHC3TD2khl0f098cLt0t59CvAs3hJw5XLhu1t8pNeGLMRlf2iaHIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93F3hqQJedzhZ1hNnxpJbF9q92ZRnv1AP+qzOZ9UDWTymNsKw
	ImA1Atgn4lFaTgBpl5aC6s/Z4Kl01zqcLVZKMZfFAQwM3k6TcEzsYaani4Hs3A==
X-Google-Smtp-Source: AGHT+IEujOQD9HguVj3nlHAUK3YYh8UHHi5/lv2W0spWj0axGPSzGT5UihEI7OdVB25ic3mOyYKH7g==
X-Received: by 2002:a05:622a:56:b0:461:285:9d7c with SMTP id d75a77b69052e-46363e0af04mr128743021cf.12.1731877374463;
        Sun, 17 Nov 2024 13:02:54 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::24f4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9c64d4sm48211421cf.13.2024.11.17.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:02:53 -0800 (PST)
Date: Sun, 17 Nov 2024 16:02:49 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Markus Rechberger <linuxusb.ml@sundtek.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Highly critical bug in XHCI Controller
Message-ID: <dff9f24a-4aa2-45aa-920f-20876cf4ccbf@rowland.harvard.edu>
References: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>
 <dd4239c7b0538e1cd2f2a85307c73299117d5f0e.camel@sundtek.de>
 <50f730ae-4918-4dac-88ec-b3632bee67e7@rowland.harvard.edu>
 <35c051354414ae9ef6e6b32b1a15a5dedf471176.camel@sundtek.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35c051354414ae9ef6e6b32b1a15a5dedf471176.camel@sundtek.de>

On Sun, Nov 17, 2024 at 11:47:52PM +0800, Markus Rechberger wrote:
> On Sun, 2024-11-17 at 10:18 -0500, Alan Stern wrote:
> > On Sun, Nov 17, 2024 at 08:44:16PM +0800, Markus Rechberger wrote:
> > > Basically the issue comes from hub_port_connect.
> > > 
> > > drivers/usb/core/hub.c
> > > 
> > > hub_port_init returns -71 -EPROTO and jumps to loop
> > > https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L5450
> > > 
> > > I'd question if usb_ep0_reinit is really required in loop which is
> > > running following functions:

> This should only go down there in case an error happened earlier no?

Of course, since -EPROTO indicates there was an error.

> In case the hardware signed up correctly it should not even enter that
> code.
> 
> My experience is just - reconnect the device in case an error happened

You can't reconnect some devices; they are permanently attached.  There 
are other reasons why reconnecting might not be practical.

> those
> workarounds did not work properly for the device I deal with (but yes
> that's
> why I'm asking - maybe someone else has different hardware with
> different
> experience).

I doubt we will hear from these people, because they will not realize 
that anything was wrong.

In any case, it is generally recognized that the type of errors leading 
to -EPROTO (bad CRC or no response, for instance) can be temporary or 
intermittent.  Retrying is an appropriate strategy.

> > > As a second issue I found in usb_reset_and_verify device 
> > > https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L6131
> > > 
> > >         ret = hub_port_init(parent_hub, udev, port1, i,
> > > &descriptor);
> > >         if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV) {
> > >             break;
> > >         }
> > > 
> > > hub_port_init can also return -71 / -EPROTO, the cases should be
> > > very
> > > rare when usb_reset_and_verify_device is triggered and that
> > > happens.
> > 
> > If that happens, the loop which this code sits inside will simply 
> > perform another iteration.  That's what  it's supposed to do, not an 
> > issue at all.
> > 
> 
> It doesn't cause any issue yes but it's not correct either.

Why not?  What's wrong with it?

> -EPROTO will be returned if I disconnect or short the device here. So
> initially someone
> thought he should check for -ENODEV/-ENOTCONN (which should also
> indicate that the device is gone), so -EPROTO should also be checked in
> that case.
> Otherwise just remove all those error checks.

-EPROTO does not necessarily indicate the device is gone; it indicates 
there was a problem communicating with the device.  The problem might be 
caused by a disconnection, or it might be caused by temporary 
electromagnetic interference (for example), or by something else.

Alan Stern

