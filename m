Return-Path: <linux-kernel+bounces-284329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B212E94FFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D5D282C70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09713B791;
	Tue, 13 Aug 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kp9/Clgt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48E4D8DA;
	Tue, 13 Aug 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538094; cv=none; b=MQLxpzCD3BIl7MZUcviFO3RfHYZdNPPGjhDT8Kd4ilKom/GtYDdTmU4Ph1jF3K4IHIpGuFzgmsoX3r41a+MtWFIE48+kHGJSgXCsDE9AWpgWz3IalMSQthGITBIUjhMXUNMluMUPfmdq9Mp3npy1sT8XKxk6Dtdr3b4VCiEnDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538094; c=relaxed/simple;
	bh=F2ez4MWPV74i5399D6eGZ2gkkUWIljQQtxoa0iFrZNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5WnMzitjA8cx47b3bVgGRa0PTZi71Us8Zmf+RlEDgvXRXNbAiwpShXVVloYsEln78uvTU6n1UKXpC9ZcrH5PCG5cgX/jkQzzOvzN+ACBpFdAwaXvCtWxyaDoJ/YV1OdC3fdFprlhV+M6077phs785emCjtfsnaiM1fLNbvuhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kp9/Clgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D22C4AF10;
	Tue, 13 Aug 2024 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723538093;
	bh=F2ez4MWPV74i5399D6eGZ2gkkUWIljQQtxoa0iFrZNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kp9/ClgtJfrRdWXXg6YxB7jdL+KdKHZmQ7IB7FJ6nD0Mbgxp0k+IJ6QFOSEYDbj7p
	 xIzCLtQq72nGKdxPMEH8fnwf/Q7aNG0lQPReJmKD2KkhojsmnFNZOIGsVFzCyK7mBt
	 NNIMvowZUJupc60zYeLn6ysrtEHRh+NUexMjjsD8=
Date: Tue, 13 Aug 2024 10:34:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: crwulff@gmail.com
Cc: linux-usb@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Perr Zhang <perr@usb7.net>, Pavel Hofman <pavel.hofman@ivitera.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: f_uac1: Change volume name and remove
 alt names
Message-ID: <2024081335-wrist-earpiece-a738@gregkh>
References: <20240804002912.3293177-2-crwulff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804002912.3293177-2-crwulff@gmail.com>

On Sat, Aug 03, 2024 at 08:29:13PM -0400, crwulff@gmail.com wrote:
> From: Chris Wulff <crwulff@gmail.com>
> 
> This changes the UAPI to align with disussion of alt settings work.
> 
> fu_name is renamed to fu_vol_name, and alt settings mode names
> are removed for now in favor of future work where they will be
> settable in subdirectories for each alt mode.
> 
> discussion thread for api changes for alt mode settings:
> https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@ivitera.com/T/

What is now going to break due to this change?  What userspace tools use
the old names that need to be changed?

Are you _SURE_ that you can rename external files like this and
everything will keep on working?

thanks,

greg k-h

