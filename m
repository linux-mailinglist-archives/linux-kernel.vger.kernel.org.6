Return-Path: <linux-kernel+bounces-525008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A06A3E9C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A4419C0CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316373A8CB;
	Fri, 21 Feb 2025 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBo32tUd"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071478F3A;
	Fri, 21 Feb 2025 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100640; cv=none; b=Hm9o7YQU97dL8ZPkcc2XWRiU2YaSr+Qg8FwjHGX3NKM475Csmvj5Tr1ipENZ/56HuMp39HxIJZeBegEsnOHmO27QzuQ2UlwDvkdnf+0oXRyWcw820N1gMgbzo6/7QIJKJraDm6hEoxHYsXcMTOIMJhw9AAEgNRHeh7EVN5rIja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100640; c=relaxed/simple;
	bh=eNDF3KzeU9FTB0eW035Ua9FeFcYDtA1ElcYayck/FgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnP8PDFyDNGXWaCMZvE34WnHi3qKJIxVkhZtKqHnXUQTOpUAwnj3D11kqbFiUzkZcgpg1Qlk+3FeqeyYDYz7pscayf0OTVe5RPkAZygg7JzDZDOf8oMMTF1ZgJlt4VLsQKlhA0d4sAR+OQ4kAFyFoK7C7HZPkW9KONL2UyL9sbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBo32tUd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec111762bso358372566b.2;
        Thu, 20 Feb 2025 17:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740100637; x=1740705437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNYf8gvUKIK6z2omU7NjF3p1iZczAqWaT1UYqslXvvQ=;
        b=eBo32tUdE/p5LsmalM6G0neyT6lwJ0tAVfcYcR6/bMwg1a66ldDJ3nWC/K6Lh9IymY
         M6oB8H9coLFszZfKkBk+R5BFW1a+IvQ9+gLIWG3Cf9nbHWWQUDK9eXCNRl/y2J21OZ5t
         ZlV56hCHbAeUMFEe70WCbe3w61Y0amS2r/98IhCBYWDZulf8mLxq+tsIHOz0KeRCpNwc
         vhfl8UKoEQWtQmNTehmgq/lXLoN02ZScYPl71a6Op9lEk0Z9a1k2NwcHWsqMqYrbcnaf
         QS8BSZVFKsGRgpssrEtIqLLno0Usi2sgrAir1/2i4jUy5CZgD84Y/fxVnR8QqERoBExo
         nABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100637; x=1740705437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNYf8gvUKIK6z2omU7NjF3p1iZczAqWaT1UYqslXvvQ=;
        b=lj8qCe96/eh616ZwTrzEwqrtNAkJShS1bngx00YpLjqMgMnUsSPKHTokh3uDQEDXkS
         kEEF5z8i/OnpNLxpn8xVxO/THS7Wckvu0oBtwdplObgxT5zV8TQ/SBf0MMSu7W2+GNCN
         2EmaPCNRLwAdZFidyOtVkv8w5MfV1E3wNaSiiUwiq80mPe+y2BfTA2LMYGIHJInKHqsd
         Po9RbEtmU/MnvRbbV8QRsH9F6CjW7sberV6IzGJbsTYBRnNYp0QBswBz3rxGDT7lRdwc
         3tU831IT0A8Ix3nbOcgIzyHMifUGrQh41et7XE3F85ZgDlUAiOH7ryRgYc2mYyGIJ9n6
         21oA==
X-Forwarded-Encrypted: i=1; AJvYcCV9rCE9u/e56hFFe1vPo0h2MTiostIRkObdKKKC+dtHd8rHiXCdQicd6xvHI1njvW4fumCffH5P8GXX@vger.kernel.org, AJvYcCWYYZd1ZdYZF7VrhuT48DmVc2P6/Obopv5iCALAm+6FXIe3H+2dYg6HH/7QdmxJbe35/8bQ22UuSKi7ImE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBXqsQO30nDCnbLtovGePK1bd77hYOHIlqp1mf9gcOYpLgPeu
	0ZWkkZr+mRS78tw3q02cfPH3kInHOdnv8TZv5WOZEna5VrS0CCLO+E90YQ==
X-Gm-Gg: ASbGncuDm3KbG6NWsje5LePSGfiCeeAt11acpwGDXVgBgdC7cCwtFtshiatAITvflSL
	Cy4VLw3itQZ1sUiCH3/Dg3RN39efr8Cc2btSSEwGfjLiAwHUefg4cwAaTBnT2c9ytTZ6Jv0STYE
	BzP3K0L0etO/6h6ZG3ym/Nm9oEO1eWr8fPIkHY6XeLQwsWHSrNGWolbqCKVKSysT2qnLNdzPp6Y
	qsdZZe+G392x0hbVCjOfS2kz1g98YNF0KupwCxh3E+4JmaRquJiRhGWn5hf6m62IaGMyu9X5LPm
	Gg7XLecnQsq8S4hx5ineoQEORo20mX7+
X-Google-Smtp-Source: AGHT+IFjBI2eeNQdYSu40Bn0PtNyNd8RBK+113npY8OkqddVeS1rr/8D6XY5mZU/TA2EeL2+RORNdQ==
X-Received: by 2002:a17:907:948c:b0:abb:fcbb:ab20 with SMTP id a640c23a62f3a-abc09aa96bfmr156838066b.22.1740100636861;
        Thu, 20 Feb 2025 17:17:16 -0800 (PST)
Received: from foxbook (adtt173.neoplus.adsl.tpnet.pl. [79.185.231.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb989d89edsm894200066b.81.2025.02.20.17.17.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Feb 2025 17:17:16 -0800 (PST)
Date: Fri, 21 Feb 2025 02:17:12 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Niklas Neronin
 <niklas.neronin@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] usb: xhci: Skip only one TD on Ring
 Underrun/Overrun
Message-ID: <20250221021712.48c07fe0@foxbook>
In-Reply-To: <7bb25848-c80e-4ba8-8790-8628951806b3@linux.intel.com>
References: <20250210083718.2dd337c3@foxbook>
	<20250210084220.3e5414e9@foxbook>
	<7bb25848-c80e-4ba8-8790-8628951806b3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 17:41:39 +0200, Mathias Nyman wrote:
> On 10.2.2025 9.42, Michal Pecio wrote:
> > +				if (ring_xrun_event) {
> > +					/*
> > +					 * If we are here, we are on xHCI 1.0 host with no idea how
> > +					 * many TDs were missed and where the xrun occurred. Don't
> > +					 * skip more TDs, they may have been queued after the xrun.
> > +					 */
> > +					xhci_dbg(xhci, "Skipped one TD for slot %u ep %u",
> > +							slot_id, ep_index);
> > +					break;  
> 
> This would be the same as return 0; right?
> 
> Whole series looks good, I'll add it

I hope you haven't sent it out yet because I found two minor issues.


Firstly,
[PATCH 3/5] usb: xhci: Fix isochronous Ring Underrun/Overrun event handling

increases the number of xrun events that we handle but doesn't suppress
the "Event TRB for slot %u ep %u with no TDs queued\n" warning, so the
warning started to show up sometimes for no good reason. The fix is to
add ring_xrun_event to the list of exception for this warning.


Secondly,
[PATCH 5/5] usb: xhci: Skip only one TD on Ring Underrun/Overrun

can be improved to clear the skip flag if skipped TD was the only one.
This eliminates any confusion and risk of skipping bugs in the future.
The change is a matter of moving that code to a different branch.

I also changed 'break' to 'return 0' because it gets hard to follow at
this level of indentation.


I'll send a v2 of those two patches. Sorry for any inconvenience.

Michal

