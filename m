Return-Path: <linux-kernel+bounces-560185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4780A5FF17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 095347A5C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738741EB9F4;
	Thu, 13 Mar 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FtaY+grk"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068EC15CD78
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889882; cv=none; b=iXu7m1nkzHOre2txIOIt22oJr/qi1wbOpRELoBjWK5aO2UR1pYAXoJqyBuKbi22MT1D2JCP4DHbQVUxMAHG2eB/PcfXoLpbxSHOnF19IjqUv+TIDciFuSX4wgm4sRnbydQ3XkRkqsNZyd0lU4NW+TwymaA03kZ83h7o+8p+jU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889882; c=relaxed/simple;
	bh=PdPtCwG/G4UNGh+IlI5MLCGpZY1iYAT2HF93sTGAIFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoN/wph8KibWn2ldELoOhI5nefzWaA/Z2n9vVG4LCL5tvqYW1hSvq/S3PHvUTT7BM6QjxcPHKoGOrr9qwQleKykWImzYBHcHuQQBFQrAsQZLPPVFZRxGNwP9sztLHJfADeVr5PF4kPLYRPeqZ9WuVIMWsM97psMWmjxwBk14qr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FtaY+grk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0155af484so166576685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741889880; x=1742494680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpgcW7UU29tzc2HSUMpC8m7j2QavoELN53utjERwIQo=;
        b=FtaY+grkloTu15b38qAtJ9PeC8z1Hl4fmL5wd+d3LI17idtMnsqqrmmuNWM4A7HO4M
         9sVpHcPYPKYls2PNbz1/gi9twkpFHylGIbp4fYwIJl2VkeJgqBbeliL5FnrtF2rdeZvs
         jyV7dgJB0farHAaW5Xns9cWE0XaynRCKm4B0yyfKGSnH+v/bu6S9vjiq/yJpFr+Ttjxe
         QnDzvcqxbi49vf8eXQAj/ZGvjYq2WZDx1zmYcNiEW+MqIQYjUyacmyyEvu41M4jxGi7i
         5gri7E8Eqyg6NyQkmN9woljqJbKRJ+jQErZHPm8byoylKf7eVcNwUj1AYIhVEamQ92NR
         DJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889880; x=1742494680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpgcW7UU29tzc2HSUMpC8m7j2QavoELN53utjERwIQo=;
        b=kvLcluapFHtA/SlCTB7U5LB+M2yuabXt24ByK1MB/Ecj0Iesq9MChAK3SUFjCTDdFj
         pSkyMmxgxwX7IbeZ6umDES/nV15HskKT1wTHZ1mCPNvQHC+buvMy8yYT9sMJzKI1xAdb
         aFWOCjUJArW8e+0e2qAdsSqIW93uQwAh23h/jYLQNH9uvpN6TT5eotH46CXWpqFZx2D8
         sBNLiPHZhDh9MpwDDI/y/ssE9ASGA8XPzi0703EPn1sX2yloXqQ+aqWKc+34xxdldhP8
         L2UgrzsabYD5KgERd2fulb131ARlsNn4hGAPprI+gnFZi9iD8NBD5r/kocMBZU6hrKan
         xN6g==
X-Forwarded-Encrypted: i=1; AJvYcCU8h5XLe/CY1CY7h2HsE89/efDo2JBseEslhCDVIlGcmaf1tlPdKYrKVW1ovZPNAksnhsItmohyEwugdaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRHTwkp4wEeoCkFPSfPxubuKmG/2saejZIiyJIeq7yNTBYiF8
	cLcUVs8YJjR+QcmdFX+C7Eg0c5Fttq/bYqzfTP3sWu5WREqX5R9hQhz3sjVwmvY=
X-Gm-Gg: ASbGncvmlgSTRmy/zFnzRO0W144UrF1mC8jzW8y8gVK+uyb3QjxR2TPzrLW9iexxLII
	T/nV8KQDBoi0HQbpeXQ3/rY5rRTB1Q4GQ+70DTkCJ8Ic02mjqs7AI2Ch2SCkdtQqtvNyw6OiAvP
	Qqt1vV5qSMXhb4Ju3Sba8iHbNOeRqapquSaeBSvCAVXAw2/vWn0jYXfbkGgjmo/Mmj6G/wjlti7
	Weri/iBW1gB9IrhNJLbwDuzfVzX0rS5D5n3vBl9h8jav0v6Ea6A+HRFv2I3n5bYjkmfYg/eWTCr
	IrdqQQzUVS9tXmcGRuwNTcyWw+YKAxG/DHa8gXh8atJNjWrx4MtcYUlQ59wLP0faK1bPca43Upe
	resDvq+8m1wsfinN9GUHGIrslyh8=
X-Google-Smtp-Source: AGHT+IFU07FAOug463Uwa+DOe07sChN0wwFnYBffXB/Iobm2IJ99vzyHde0TeD4Rsxvo8fielsuN7Q==
X-Received: by 2002:a05:620a:2606:b0:7c5:59a6:bad7 with SMTP id af79cd13be357-7c579ebc8afmr95372085a.17.1741889879813;
        Thu, 13 Mar 2025 11:17:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9be48sm127266785a.60.2025.03.13.11.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:17:59 -0700 (PDT)
Date: Thu, 13 Mar 2025 14:17:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0a: CFMWS and NUMA Flexiblity
Message-ID: <Z9MhVZmFVTPpuRe1@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F>
 <20250313172004.00002236@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313172004.00002236@huawei.com>

On Thu, Mar 13, 2025 at 05:20:04PM +0000, Jonathan Cameron wrote:
> Gregory Price <gourry@gourry.net> wrote:
> 
> > -------------------------------
> > One 2GB Device, Multiple CFMWS.
> > -------------------------------
> > Lets imagine we have one 2GB device attached to a host bridge.
> > 
> > In this example, the device hosts 2GB of persistent memory - but we
> > might want the flexibility to map capacity as volatile or persistent.
> 
> Fairly sure we block persistent in a volatile CFMWS in the kernel.
> Any bios actually does this?
> 
> You might have a variable partition device but I thought in kernel at
> least we decided that no one was building that crazy?
> 

This was an example I pulled from Dan's notes elsewhere (i think).

I was unaware that we blocked mapping persistent as volatile.  I was
working off the assumption that could be flexible mapped similar to...
er... older, non-cxl hardware... cough.

> Maybe a QoS split is a better example to motivate one range, two places?
> 

That probably makes sense? 

> > -------------------------------------------------------------
> > Two Devices On One Host Bridge - With and Without Interleave.
> > -------------------------------------------------------------
> > What if we wanted some capacity on each endpoint hosted on its own NUMA
> > node, and wanted to interleave a portion of each device capacity?
> 
> If anyone hits the lock on commit (i.e. annoying BIOS) the ordering
> checks on HPA kick in here and restrict flexibility a lot
> (assuming I understand them correctly that is)
> 
> This is a good illustration of why we should at some point revisit
> multiple NUMA nodes per CFMWS.  We have to burn SPA space just
> to get nodes.  From a spec point of view all that is needed here
> is a single CFMWS. 
>

Along with the above note, and as mentioned on discord, I think this
whole section naturally evolves into a library of "Sane configurations"
and "We promise nothing for `reasons`" configurations.

Maybe that turns into a kernel doc section that requires updating if
a platform disagrees / comes up with new sane configurations.  This is
certainly the most difficult area to lock down because we have no idea
who is going to `innovate` and how. 

~Gregory

