Return-Path: <linux-kernel+bounces-175539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7DA8C210B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7AE281F83
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8D165FA2;
	Fri, 10 May 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jQIrxaMv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CC161337;
	Fri, 10 May 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333751; cv=none; b=hRxmw+Q7/6E3YKArpxBkmnkO4CUt4HjBhMvATtUoGt98l/bv849uiQmpidc6/k4vg5l05KDafnaCfQ2bKpmdlJ27i/rYhJcJtoYmakNuecvE4gjnbHCxt/4SCxCiF0+DFeuYj9SD2Z0ChZ4RkhDtSB+EdsG4XLjiTMq0pRjk4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333751; c=relaxed/simple;
	bh=L+6AgakNTXIcMOAJNNHC8vZGom0I8qf1DFO1PdW1RqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud/odVuIrOLgUVF80sHK6TvwdoT4gyHGYUVNo7ckaYIyFlhTatpov8iBmeaED/WrPjF/2g1+FsdgQaXiJPpDtkqeCmn514Tcjqt/aYvM2RQoT/hVq82fccAcuzuYmGTZayONvwEFhGSLDWYk/DVyfTCAoZIfmjVYjQyyxml+FkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQIrxaMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47028C113CC;
	Fri, 10 May 2024 09:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715333751;
	bh=L+6AgakNTXIcMOAJNNHC8vZGom0I8qf1DFO1PdW1RqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQIrxaMvMNcE0mSk6GpsIZ4aLjAtwbO52oQwGpRc3PfWva83FZbLpEM/etkFQaHv+
	 9ZLYOpWvq8ryVathOVjUmMNQg8MyxUz93yDc5NmHdibWqrdecT7v82cBDpiC38H3vw
	 gwoxH/azf4xsPMFsZVQ8blDxdT8SXARG3h+olSg4=
Date: Fri, 10 May 2024 10:35:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org,
	pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] usb: typec: ucsi: Fix null pointer dereference in
 trace
Message-ID: <2024051010-hungrily-scholar-7d23@gregkh>
References: <20240503003920.1482447-1-jthies@google.com>
 <20240503003920.1482447-2-jthies@google.com>
 <Zjiq4PrL2ju8FOUz@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjiq4PrL2ju8FOUz@kuha.fi.intel.com>

On Mon, May 06, 2024 at 01:03:12PM +0300, Heikki Krogerus wrote:
> On Fri, May 03, 2024 at 12:39:17AM +0000, Jameson Thies wrote:
> > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > 
> > ucsi_register_altmode checks IS_ERR on returned pointer and treats
> > NULL as valid. When CONFIG_TYPEC_DP_ALTMODE is not enabled
> > ucsi_register_displayport returns NULL which causese a NULL pointer
> > dereference in trace. Rather than return NULL, call
> > typec_port_register_altmode to register DisplayPort alternate mode
> > as a non-controllable mode when CONFIG_TYPEC_DP_ALTMODE is not enabled.
> > 
> > Reviewed-by: Jameson Thies <jthies@google.com>
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> You delivered the patch, so you should have used SoB instead of
> Reviewed-by tag:
> https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Not "should", that would be "must". I can't take it like this, sorry.

greg k-h

