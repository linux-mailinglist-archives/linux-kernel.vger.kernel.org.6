Return-Path: <linux-kernel+bounces-532652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD0A4505D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239FE3AE713
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B381E21B9FD;
	Tue, 25 Feb 2025 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="K1vrbbA4"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17421B9C6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523076; cv=none; b=PUkvveGSFHvDUBRgfsuDAlPz0gMCtN8qkBps1wwSvpFLaYFvaWp3WM6ySqYguVaEnQvOjxQNLWJsgO8NPku4TapqJXRH4G8zNTPok5oJxPjlu+nTBfxjS3ikuAbjk1m6Tu47lFLUR9Ms3sD1HXuXQDMYwQOZYpXOq8EZ8JUMreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523076; c=relaxed/simple;
	bh=BogXE9uzwFPy580Hc+AtaZjDNH4/vFPQzai2+yXISIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blvGXxUVkFN8KcFVcialdMVunGNVTBXkmz0IJYWwpv91B2fI0ylgsFStzsnZY643C2UwSiN/42G8YGkpSr869DiOJ1D+r8joS6BnXAWjbeDDMp3EtqZVS89Vg+UV8JJr81GraXuQVZ+I+3LXIbO6azmel84haYTy9EONYllW950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=K1vrbbA4; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-472087177a5so77232421cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1740523073; x=1741127873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n4ofxXiAeBUmvDKjkXIUMtsheZQdXumF3WhU8fMVP8o=;
        b=K1vrbbA4uI6LcaHGJewaR8EkZYvsvfFfSKriZzIxGzUAaTMyVMsijcDVajROgtnrDJ
         plDTD72YoVpydaP5Rp4JodfWWo9scnaXNbpwGfG1Vwu6VhTE3/Wm1NFC6EVQ8obQraJk
         bJChD3lLl6WzbCo88f4t0CiD+6R8NVqy5O0KUkAj2hAMXxZF8ZzwCE3niOxZnGuFy7W8
         kz5gUp0m3Z5eZbuzosvUhKbCGwPX4G4VFjUPQlN7wdmvW2i3fbzsEQHaWTobsNVIbADm
         gN0juY5hIA+E/shGXPnFUI4UFgKo5wRqyIy3wsYFfRgVzhOC6IoEipmLLXiwvg2gBADd
         vh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523073; x=1741127873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4ofxXiAeBUmvDKjkXIUMtsheZQdXumF3WhU8fMVP8o=;
        b=hUW+MFrjAZCIB195JmxT8ijsqwBugmfP3HsYdjnj4rWe0ReSHRcAceEimByMHZOuGq
         7iawSZKrV2NVbjlpN0opT86hogW76LxsY18YHwoZP7emXg/rrFTZVn98Y9+NelPpxBrA
         wrWmWw3aptx0t644+bMHGqFKzgwjq5CMSPc+YbJaXONwjxdDcGSsc+Sm7sw7iTaq45pZ
         /+bgkcnfYlleRlfxnt0ij84aqmAYh37qNx4xMTFb1jn98JDSwMTpiEfMMp/bbMvAYc/j
         xJf1S1tmz2bms2r3q7hCR11FBJt8A+0x1B2j1g5q6/hZMqiTj6+HxQHvN6f59Xy7f3Wy
         Xbyw==
X-Forwarded-Encrypted: i=1; AJvYcCUXVZy0TOAERRjTxmVEAoQguFy8PMcYTz8N7DkFqtu6YuZ5S9kIQ7LYf3ZRTG+1h1qeb/BA2Qc19XLwObc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcF8396xY5Vi/A1uvAhlJMm/2USyH63/kKE1eMCEERNW3LgcR
	HGInLHIZLI8RV3Xuc31ccGXRbYZ3HnlwG5yXlVK3FVEpaJ7b3r6jQno+PZ9/kw==
X-Gm-Gg: ASbGncvFRpRXzJL9/N1GHkhLTIEvvIYV8v53lFnRWEKOLKoUOodnBJPRQqi1DDjW8BQ
	bxbqBHJfvQi1XGu1Tg8tqMgC5HXTe9Z07k5saMI1Ar789pqP2jekPgsjSTwsBzEfeGe19I5x0fv
	YWUrLRp7y+pPOfXCwh05n8IUV32Ga6SJ8U/vMyBbhK+Dv3qjB0PtGzJM6QNeldyEF0u7Zk8vXFJ
	QYr6nS7gcDmx83MdcDNoGDsDpnPNl4LLvWpaRsqWnXz7gnvtX9AqKcineRDsNDZ1qnV25hf0lxL
	o8qXH+OJochBN5TUQUUCWJHplh0=
X-Google-Smtp-Source: AGHT+IGZ7WZcLwjn8faa6TaB0x9SlVLEgp5QWhOqfgxU0rZgTCA8rtirEWjJCmVBU73IhmPdtD5SIQ==
X-Received: by 2002:a05:622a:14f:b0:472:1ee7:d2b with SMTP id d75a77b69052e-47377116e56mr67231801cf.4.1740523073483;
        Tue, 25 Feb 2025 14:37:53 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::2dc7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e071d2sm15695531cf.11.2025.02.25.14.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:37:52 -0800 (PST)
Date: Tue, 25 Feb 2025 17:37:49 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
Message-ID: <4db69da5-199d-4db4-b82b-165d8eb1679b@rowland.harvard.edu>
References: <2a8d65f4-6832-49c5-9d61-f8c0d0552ed4@aosc.io>
 <06c81c97-7e5f-412b-b6af-04368dd644c9@rowland.harvard.edu>
 <6838de5f-2984-4722-9ee5-c4c62d13911b@aosc.io>
 <6363c5ba-c576-42a8-8a09-31d55768618c@rowland.harvard.edu>
 <9f363d74-24ce-43fe-b0e3-7aef5000abb3@aosc.io>
 <425bf21b-8aa6-4de0-bbe4-c815b9df51a7@rowland.harvard.edu>
 <0ca08039-73fb-4c4b-ad10-15be8129d1b7@aosc.io>
 <5b4349c8-26ae-4c95-8e60-9cccbb1befe6@aosc.io>
 <6c9b295c-3199-4660-b162-188a9ab5a829@aosc.io>
 <c2b8f8af-db2b-4b64-9e45-83e2b0a3d919@aosc.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2b8f8af-db2b-4b64-9e45-83e2b0a3d919@aosc.io>

On Wed, Feb 26, 2025 at 01:41:14AM +0800, Mingcong Bai wrote:
> Hi Alan,
> 
> 在 2025/2/9 18:22, Mingcong Bai 写道:
> > Hi again,
> > 
> > Oops. I missed the dmesg.
> > 
> 
> <snip>
> 
> Gentle ping as it has been almost a month since our last correspondence. Can
> you please advise if you would need any further information and, since the
> fix is probably incorrect, if you have any suggestions as to how we could
> move forward with a better fix or platform-specific quirk?

I was waiting to see if your last email (Feb 9) to Huacai Chen got a 
reply, since you suggested the problem was Loongson-specific.

As for a platform-specific solution...  I wonder if it might not be 
better to fix this in userspace, by making Powertop (or whatever tool is 
responsible for managing wakeup settings) automatically enable root-hub 
wakeups on Loongson platforms.

Another possibility is to ask somebody at Intel if Loongson has some 
special way to handle UHCI wakeups that we don't currently support.  The 
driver does contain support for the USBRES_INTEL register (see 
uhci-hcd.h and uhci-pci.c).  Is this different for Loongson?

Alan Stern

