Return-Path: <linux-kernel+bounces-232460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D791A921
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97CDB279E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C83B195FE6;
	Thu, 27 Jun 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUNNgeqm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8219306A;
	Thu, 27 Jun 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498228; cv=none; b=ijxgXaF2tL2tjY+O3ma4Yy1X1EGUt4cGnDfW7rWcTg7L70+01vO1WgR0y8U3WOyBB/9B2ReHGQj/eMAhS8IJU1GpYgHMJejKNLXnPd/k7XI6D5F0uYGVetd5xqZCvJ6QGEwGyFiaDZ/oXY3uk3zHX6i4fRv9P4K6iIcyeKzGeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498228; c=relaxed/simple;
	bh=hNSjLU6Q2DOaKZ/pmqxycisVgItFODKa0ss4BjbT01o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCTHQzkdaAA9iy0AFSzC4MJx2cBKo4tbrDyJxhMUxv3W+biWeumC9S5E3EbZXPl9oLt/yC9IMuNOHePnc1g2WrpM9lmsw7Vhj6T3mWe94Y1QHALF5ivGq3XWilRgPtvVPrfoAnm+L89qgokcGN6ustg6Do8jhwvNyg5gR+aA13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUNNgeqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D21C2BBFC;
	Thu, 27 Jun 2024 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719498228;
	bh=hNSjLU6Q2DOaKZ/pmqxycisVgItFODKa0ss4BjbT01o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUNNgeqmeuVOreC17XDwpSSbnAZhMQ92J1wR0SRfTHaW2EavuMNdkzZNoEGC0gE+x
	 xcEnlUC5fd5/rNuGehohsM5P2T2fxaI6sgj+CdVrCA2z6e2bBAdaoNfgY5q0dd+kE1
	 VBglty5ojzj8HMzbkDwKYdj/vMEOW0/b9z/FK6c4=
Date: Thu, 27 Jun 2024 16:23:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nikita Travkin <nikita@trvn.ru>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] usb: typec: ucsi: rework glue driver interface
Message-ID: <2024062723-unwed-sleeve-47b7@gregkh>
References: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>

On Tue, Jun 25, 2024 at 05:54:25PM +0300, Dmitry Baryshkov wrote:
> The interface between UCSI and the glue driver is very low-level. It
> allows reading the UCSI data from any offset (but in reality the UCSI
> driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
> is to be done by the glue driver (which already resulted in several
> similar-but-slightly different implementations). It leaves no place to
> optimize the write-read-read sequence for the command execution (which
> might be beneficial for some of the drivers), etc.
> 
> The patchseries attempts to restructure the UCSI glue driver interface
> in order to provide sensible operations instead of a low-level read /
> write calls.
> 
> If this approach is found to be acceptable, I plan to further rework the
> command interface, moving reading CCI and MESSAGE_IN to the common
> control code, which should simplify driver's implementation and remove
> necessity to split quirks between sync_control and read_message_in e.g.
> as implemented in the ucsi_ccg.c.
> 
> Note, the series was tested only on the ucsi_glink platforms. Further
> testing is appreciated.
> 
> Depends: [1], [2]
> 
> [1] https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
> 
> [2] https://lore.kernel.org/linux-usb/20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org/
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

This doesn't apply to my tree at all, can you rebase and add Heikki's
review and resend?

thanks,

greg k-h

