Return-Path: <linux-kernel+bounces-413521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D4A9D1A91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFFC281459
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC31E6DDE;
	Mon, 18 Nov 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqQ4Enoj"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE11C07DE;
	Mon, 18 Nov 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965045; cv=none; b=qg6KgJyIM5jJ5Wtl+Qf93IxqOxskpTmDxbXy4I66jTVvJ6b+a+GrUeKjigPRXg7xCQvEjk7te7vtI5IqLEtxqRnaOcUbjP/IHEMmv3bCB0HiG1t+uydTMDc5KgrnkexjLhfRXDLPz7hcLGMXXs6BKuE1HT/jDEMXWSxnt8Qarpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965045; c=relaxed/simple;
	bh=c9UhAjUBlkxv9mlymFO0Ge+Bp5TE8IQsom42POhP/8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=bR7iPArt/IhH5ipq+Q6r9jQAGYEkn7dwOdWkNy0QVh7s+I6DbYSvE4rTrNqgKYNGdgyDHkN7EY9pP7av8Yfk91R++5GUrF9yAHRacYQpmGqcCq1CdjYpaWu1oBCqf8SLU3aPvr4vzRXDC2wR5Ljb8CDWhVmVuJEd9XBj0mbA75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqQ4Enoj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fb49c64aso3344422e87.0;
        Mon, 18 Nov 2024 13:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731965041; x=1732569841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=du7rn+xd73aBEFKmEKLpUk9SFO0TFC/LlPx37xg2nPM=;
        b=fqQ4EnojbPh9eTkZiaTSuog+S1E2IiHN4K433AtA6mK+M5PY7WUebq3vpi1+BKttAR
         xC8X8xdCd6CWDhCZVhDj8wPTA4QDWd2Q0Kb+lTupV7x9ksEg6wysNF3KkJInJKmpuDIb
         qnk9V+PyUWPXnsdggZYxbEOe8menWM9swSsFUIRWR0uRBsCUytvHfGhrb1OczC9qMg7f
         FZnTwQeKzkil+INpwg6lFm+qN9lGMEXxlX3WoQQMUh3FnXxUkeQBmuzfLhQenCKZYeuX
         gpUqt8BfbI1dfa5mOQwsYtetTEb8NYWiD2F8AMpTqVRRdFTGhKWUShax9rMRaZJ4sqgS
         Peqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965041; x=1732569841;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du7rn+xd73aBEFKmEKLpUk9SFO0TFC/LlPx37xg2nPM=;
        b=ird04b+5E4aTdHSDVUM9ftHNUhD2NIpLS3hLkiYUMLhuR+E+ctM/ua8C5HIqJlXT80
         LQ1RvhPBGFrJ7qR5cVq4r/0fqU5ORmz2+WcdI3gDyHMe95vD4IzxtLd8Q9EybECrVDpR
         eUvlOKsrj3g+J2eyl+nfRHTWFYgqNWnD8DEHmEEwkOK/idXcCdzgNrkzWQhLQqWS5/fl
         UMZj+0yH/5+J+DaZ0hM4KgRpYmVrLbgVMGL8QC5FoEv5or9YtzMyioomZ4QLPayRa172
         pUEigVcJwLbfS8C59bTRx5wqvL0znCV6YXBYpCOrpsiiNdFCiCfVd8C9eYJNr/hgnCCl
         Ba8w==
X-Forwarded-Encrypted: i=1; AJvYcCUvDMV3cvTG/tyOXgk1iHTXum/kqWFxT+xsQZHSjQhSZ3FxzFxlRs9cjmgVfqyaccVFqGhMYFnllSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWg7PFSyvwgrym03cNOzt6xXruSD/fSabg9ME9JrZCQuNDxLJ
	mbAwcDrgM27dEtwejN5kpzxthK3kvNIoz2Xbcm+CYKmX660JwgEO
X-Google-Smtp-Source: AGHT+IG1m/2Bl2HtT20tIO/hOr+2WAW27qY11aZSIxhG9F72VHsMZMT0o8huZvd+PKFiULX3DtPpJw==
X-Received: by 2002:a05:6512:1155:b0:53d:a998:51b5 with SMTP id 2adb3069b0e04-53dab29f183mr8244205e87.20.1731965041094;
        Mon, 18 Nov 2024 13:24:01 -0800 (PST)
Received: from foxbook (bhf154.neoplus.adsl.tpnet.pl. [83.28.95.154])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd47b595sm69326e87.250.2024.11.18.13.23.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Nov 2024 13:24:00 -0800 (PST)
Date: Mon, 18 Nov 2024 22:23:55 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: linuxusb.ml@sundtek.de
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stern@rowland.harvard.edu
Subject: Re: Highly critical bug in XHCI Controller
Message-ID: <20241118222355.482cf783@foxbook>
In-Reply-To: <f34636ebeda843de9329ac0aa4ec51c6627a0e5c.camel@sundtek.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> In my experience with USB anything that is a 'temporary' failure can
> be considered as 'permanent' failure and I've really seen a lot over
> the last 1 1/2 decades.
> However issues are mostly related to immature controllers / missing
> quirks for some controllers.
> Our devices in the field since 2008 usually pump around 100-300mbit
> through the USB 2 link,
> streaming  devices which usually run for a long period of time (up to
> months / years).
> 'retrying' something on a link where something has gone wrong for sure
> never worked properly for me, it would have continued with another
> followup issue at some point.

You may have simply seen hardware going dead or buggy drivers failing
to recover from recoverable errors.

Random bit errors really happen and (excepting isochronous endpoints)
can be recovered from. But if you get -EPROTO on a bulk endpoint, for
example, it means the endpoint halted and should be reset. Few Linux
drivers seem to bother with such things.

I even think xHCI's handling of halted endpoints and usb_clear_halt()
is broken, but it looks like fixing it would break all the buggy class
drivers on the other hand, which are currently "sort of functional".

> Anyway can you give a particular example where this 'retrying'
> mechanism and reloading the endpoint size solves or solved a problem?

It seems to happen when you insert the plug slowly or at an angle, and
contact is briefly lost while the device is being initialized.

The first three lines below come from hub_port_init(), which looks like
it is being called by hub_port_connect() in a loop.

[81169.840924] usb 5-1: new full-speed USB device number 61 using ohci-pci
[81170.387927] usb 5-1: device not accepting address 61, error -62
[81170.742931] usb 5-1: new full-speed USB device number 62 using ohci-pci
[81170.901914] usb 5-1: New USB device found, idVendor=067b, idProduct=2303, bcdDevice= 3.00
[81170.901919] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[81170.901921] usb 5-1: Product: USB-Serial Controller
[81170.901922] usb 5-1: Manufacturer: Prolific Technology Inc.

Another example which could trigger retries is a device which includes
a permanent "presence detect" resistor (such as PL2303, coincidentally)
but takes a long time to initialize itself and start responding.

Regards,
Michal

