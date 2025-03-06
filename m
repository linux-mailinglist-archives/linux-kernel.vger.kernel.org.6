Return-Path: <linux-kernel+bounces-549957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9514A55901
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA2B3B2EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB127700A;
	Thu,  6 Mar 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Njr0imto"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EB27602D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297398; cv=none; b=lAgGadJAyW1j4EqgzUpHb2hVK4yo7sK6nxLrXszkcakL6tTfGY1Zw0R4VnxDZU7nQnoiQ4eU8NbURWg4spV/6a6Dn/kt81etpvozfNHl04Cesgcfzu2oK49IwvF7zVErGKNaOvCHfDO0I0Bu0L62I4xgvzQe8c5sNi85uCHzkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297398; c=relaxed/simple;
	bh=SNFuNCfIgcF5/PptKRJ7JhAvv9sk7R7PiUdz8a1KQGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVNI1zZUUgTgwg3i9e4+lkTrB7d6LhOVMFnsTyDfDqvadGDrSIJPqWFTz0UTZHBsYPBC4kvhQvdEoahkBd/JFP/Dy2aL8+2e+662/P6vcYFk+Q84XL/RADzxjyMS98e61UEvUPCBl4Nw9iivg0dq6Q9w3Gdpbk79Rzz4DFQ0wEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Njr0imto; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4750a85ce4eso10609421cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 13:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741297395; x=1741902195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oyv98J/VYPy+XUbKLqkeEBWOqmDRWz3461BxBi5DFCU=;
        b=Njr0imtoJOUjnvbUL0e1CSQDd6qGyevwMpHbE4eVRW6i6Z/NM/O0654wyHiGdtv2O/
         8sjQFDVG2TfSY5THuNaM5NnO0DoTjzWWC+wHuTRGkeYYQw3F/Tc0YXoCVgqJzVALtmrF
         PyG2c75sLcULwaBZyeM46TAY6Ffdm5yoY1Q3rk4D0TBw8Xv5fBpRWGeMai0bH7qzdFQ/
         4JzX5ZcmqtqTgNIlzugtnQ+b4khj1T82lrbZM9DlD1eVFWV7wNRrsKQC3W8943438m8B
         IJ4dZjUoe5/6rI2dUjyDupDdf3o6ObvgRWaFSHy6z/k9HiRDSgcb73dFG0Q5DcTa9bjw
         kGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297395; x=1741902195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyv98J/VYPy+XUbKLqkeEBWOqmDRWz3461BxBi5DFCU=;
        b=WnTv8FusVdUdDvdXBpVW+ObPjlCUV0jYMgh281OEK0QK6N92ZAdBpU5H+bHgk7qV04
         RCZOfk747elMyT4FrGmGhgjYQZtbYgcYZeUotE+g+W2xY8MigiDioQicwTzdfc7ZYvZI
         xvlN5CafvhkLHW5kRQZyk4962q6Jq3GCTYgWh7gV5KvqLNgIhL1dPDseIL8xrbldSiIl
         Hv4/pyY3xxxEfR+uMP4VhZi+GiHVJapT/eweBsyCrYjY579oh6WXOPV+Oni8+rkX8gYo
         oz6KQHHnGWJTDmAKbAqXwBn+A81Wv4/iyjB0hvOjxBWuQUqe+qTPA/PdoKa/35LYjQz+
         vizA==
X-Forwarded-Encrypted: i=1; AJvYcCVfRfD+sXPafHac0LJLm3FGuib1k7Doiz4CqOSFwmWhkXnubjqWkbeji57G4FWSCe1RWRm/5Q9xuLBsGYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRJiTM1YaioQ6PsPHqXfSZzSpwHQrfb9Uul0ve2jqJe08dse6
	VSRvTLR9+DCrBKd3hjXzezxEXhG364coE1si7GkLQf7BF4u+gp/dn97Cth/GLw==
X-Gm-Gg: ASbGncvUAh59N7KoKnzl++D0qZjEPXEUDjumPXzSWAFA0REJWNX+87q1PysC9Se5sge
	nkU3zGSXss0Hn0JQeJ1Mp7Qr/mlKG68J1bFoFfBrB1eU0PQhpFX4Eoauj3cV8D7jnyqyBGDHF/o
	zjGIDboy1jiRi5KRdNvhpJK0lOFxFOkzfU7R4R4hyBjgCgygGfsE4vNlcrhxzfztxbKnW8VH09S
	EJJphJQvzyI1B6KOcFX7tZFV6PepEdGeFAfVWbKBsG5Iprq+8SPO9ZVkpHDnOvXASj8a8kx6vEg
	Bn/sq4jnI2YhRkd9sFU3Lqumql/NXywGAJzfk7O3RF/Quw==
X-Google-Smtp-Source: AGHT+IFnAgDNioiavSEVVuQAtbRWHZD2jSHEVT25d3GoKqWLqtEkZCF1Iwjtf2+iqzJNvvEeQHrmnw==
X-Received: by 2002:ac8:5852:0:b0:475:819:27ec with SMTP id d75a77b69052e-47618b38b3dmr11877871cf.50.1741297395363;
        Thu, 06 Mar 2025 13:43:15 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::3ca7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d9ad29asm12223241cf.46.2025.03.06.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:43:14 -0800 (PST)
Date: Thu, 6 Mar 2025 16:43:12 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Colin Evans <colin.evans.parkstone@gmail.com>
Cc: eichest@gmail.com, francesco.dolcini@toradex.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org,
	stefan.eichenberger@toradex.com
Subject: Re: [PATCH v1] usb: core: fix pipe creation for get_bMaxPacketSize0
Message-ID: <04cb3076-6e34-432f-9400-0df84c054e5c@rowland.harvard.edu>
References: <Z6HxHXrmeEuTzE-c@eichest-laptop>
 <857c8982-f09f-4788-b547-1face254946d@gmail.com>
 <1005263f-0a07-4dae-b74f-28e6ae3952bf@rowland.harvard.edu>
 <cf6c9693-49ae-4511-8f16-30168567f877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf6c9693-49ae-4511-8f16-30168567f877@gmail.com>

On Thu, Mar 06, 2025 at 09:06:23PM +0000, Colin Evans wrote:
> > Please try collecting a usbmon trace for bus 2 showing the problem.
> > Ideally the trace should show what happens from system boot-up, but
> > there's no way to do that.  Instead, you can do this (the first command
> > below disables the bus, the second starts the usbmon trace, and the
> > third re-enables the bus):
> > 
> > 	echo 0 >/sys/bus/usb/devices/usb2/bConfigurationValue
> > 	cat /sys/kernel/debug/usb/usbmon/2u >usbmon.txt &
> > 	echo 1 >/sys/bus/usb/devices/usb2/bConfigurationValue
> > 
> > Then after enough time has passed for the errors to show up, kill the
> > "cat" process and post the resulting trace file.  (Note: If your
> > keyboard is attached to bus 2, you won't be able to use it to issue the
> > second and third commands.  You could use a network login, or put the
> > commands into a shell file and run them that way.)
> > 
> > In fact, you should do this twice: The second time, run it on machine 2
> > with the powered hub plugged in to suppress the errors.
> > 
> > Alan Stern
> 
> Happy to try this, but as it stands there is no such file, or file-like
> thing, on my machine-
> 
> # ls /sys/kernel/debug/usb/usbmon/2u
> ls: cannot access '/sys/kernel/debug/usb/usbmon/2u': No such file or
> directory
> 
> # find /sys/kernel/debug/usb -name "2u"
> #
> 
> # ls /sys/kernel/debug/usb
> devices  ehci  ohci  uhci  uvcvideo  xhci
> 
> 
> It seems something is missing?

Ah -- you have to load the usbmon module first:

	modprobe usbmon

Some distributions do this for you automatically.

Alan Stern

