Return-Path: <linux-kernel+bounces-263969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED3993DD55
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1551F23F61
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D108E1946F;
	Sat, 27 Jul 2024 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yr49EIWs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7C197;
	Sat, 27 Jul 2024 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722056699; cv=none; b=sZTOqXJ7GKAXcNlUlf9UgwwsspKFC3J23fbZZqj41BlyBKSbTYbhaorrXtvMRJeE8tOLV+t7wThTcEGRylMSDRdbqQq4kX3dBzE8ve4QMeK0mEv3LoHyQaGP0zseQU41LQ+K8DvO6fNTyjlDbcnPMNw8PTI2Y0bkIk4ONtC8JI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722056699; c=relaxed/simple;
	bh=d3EAV1/TM9SnhNcMMAH4vATidAVtaY+EPOTi1Q9H7tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8PUie9UG1hFPSt0O7UTjI7aFleAE50LXssDg6mwGXRStHz5bp7qxYbdU8KNubO4WVyFl4hkJhFq323MiUU0fpL0hbR8HKas3iIuEQ8i38K3eYEHLIX3afv76j8cu0wKwOGdV8rCLH7RUZUXED2eZLaHiqn/sFqkhAyNuS75J0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yr49EIWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE41C32781;
	Sat, 27 Jul 2024 05:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722056698;
	bh=d3EAV1/TM9SnhNcMMAH4vATidAVtaY+EPOTi1Q9H7tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yr49EIWsRWyXo+xM34nDRxokURKLAcK2GsIGjbhiSLeeFOnhAkdAypIw0qMa1+hZN
	 BTKDpO2XUfN89+iYFCtqzibzh/6tkyiAoMggzAjexk0RsLeMRszcdk7XQOpJq9sGni
	 F/d7Sz6xVV8/ToZqJo7kc7K17qCS2anQEu1fb/LI=
Date: Sat, 27 Jul 2024 07:04:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] usb: typec: fsa4480: Check if the chip is really there
Message-ID: <2024072734-scenic-unwilling-71ea@gregkh>
References: <20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org>
 <2024072615-hassle-enclose-673f@gregkh>
 <30b6e9eb-a6f5-4238-93fe-4d8a19b31590@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b6e9eb-a6f5-4238-93fe-4d8a19b31590@kernel.org>

On Fri, Jul 26, 2024 at 03:52:22PM +0200, Konrad Dybcio wrote:
> 
> 
> On 26.07.2024 3:12 PM, Greg Kroah-Hartman wrote:
> > On Fri, Jul 26, 2024 at 01:43:30PM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>
> >> Currently, the driver will happily register the switch/mux devices, and
> >> so long as the i2c master doesn't complain, the user would never know
> >> there's something wrong.
> >>
> >> Add a device id check (based on [1]) and return -ENODEV if the read
> >> fails or returns nonsense.
> >>
> >> Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
> >> the ID mentioned in the datasheet does indeed show up:
> >>  fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)
> >>
> >> [1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf
> >>
> >> Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> > You can't sign off on a patch twice, that makes no sense, sorry.
> 
> I'm losing access to the @linaro.org email and want to preserve the
> authorship there (as this patch was developed during work hours).
> 
> Then, the author's email doesn't match the sender's email, so I'm
> expected to sign off with the sender's one.
> 
> Should I assume that the maintainer trusts me to be the same person?

Yes I do :)

