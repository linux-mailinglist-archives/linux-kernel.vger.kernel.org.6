Return-Path: <linux-kernel+bounces-232520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA591AA37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18D91F21D14
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031E198A21;
	Thu, 27 Jun 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0rdix0PD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43B13A245;
	Thu, 27 Jun 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500567; cv=none; b=p+MZLO+9HtmKAPq9UFTnqULzXtrzVqexq7DNPDnyuq2zA0mn30jo65C+le5tPXxjrDAvngOh8FOfGWJde96b9opzIUPhZFsZRJTKwejCvNIy6QlGr0NSTBcJRReSDZpylImQmNkcHT6BPWhqO3/KLgvIYmHbfRrsEcLtH5uSfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500567; c=relaxed/simple;
	bh=nJI2HtmKICRsKHR8/Up41vVhzOP05K+y4EJ5tpnHE6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkwXPG19kQwIO1fec5gHynw7/Z6Q88HJ3dkk0Uqh0sWqUsmZrgaUTzL1aY3nRfaRHJTeO4kK1AeptV57fdRUqbUkZzwJe1nAWULGHCBOEXkXcOu7NYq3CNt/mUQFnjuIb0q6ny3/DdXxD0m7u9Ub5IzwdkkcACDCsHjWMqX/bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0rdix0PD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7345BC2BBFC;
	Thu, 27 Jun 2024 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719500566;
	bh=nJI2HtmKICRsKHR8/Up41vVhzOP05K+y4EJ5tpnHE6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0rdix0PD+Lba9nWZZg72rAThMW8k7ExC6rSxUdEOS2qXhW6EelEY/JmtjA+oeHScT
	 /HwWFCd/gyWR+fMKySnEECglSxA7pWJ6c0NavitzKDtqqngUDNsDwKMSD0OPkN/4Fg
	 EFvcTNnBXBDz0+8Kz+0V0MtFU411pCTnuerTaa04=
Date: Thu, 27 Jun 2024 17:02:43 +0200
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
Subject: Re: [PATCH v4 0/7] usb: typec: ucsi: rework glue driver interface
Message-ID: <2024062724-petty-twine-afd5@gregkh>
References: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org>
 <2024062717-foster-document-eb2f@gregkh>
 <CAA8EJprAshnt3YchBv0ssi4Vet9b6oMcf3z8nuRkoZVYNBq64w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprAshnt3YchBv0ssi4Vet9b6oMcf3z8nuRkoZVYNBq64w@mail.gmail.com>

On Thu, Jun 27, 2024 at 05:57:30PM +0300, Dmitry Baryshkov wrote:
> On Thu, 27 Jun 2024 at 17:54, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 27, 2024 at 05:44:39PM +0300, Dmitry Baryshkov wrote:
> > > The interface between UCSI and the glue driver is very low-level. It
> > > allows reading the UCSI data from any offset (but in reality the UCSI
> > > driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
> > > is to be done by the glue driver (which already resulted in several
> > > similar-but-slightly different implementations). It leaves no place to
> > > optimize the write-read-read sequence for the command execution (which
> > > might be beneficial for some of the drivers), etc.
> > >
> > > The patchseries attempts to restructure the UCSI glue driver interface
> > > in order to provide sensible operations instead of a low-level read /
> > > write calls.
> > >
> > > If this approach is found to be acceptable, I plan to further rework the
> > > command interface, moving reading CCI and MESSAGE_IN to the common
> > > control code, which should simplify driver's implementation and remove
> > > necessity to split quirks between sync_control and read_message_in e.g.
> > > as implemented in the ucsi_ccg.c.
> > >
> > > Note, the series was tested only on the ucsi_glink platforms. Further
> > > testing is appreciated.
> > >
> > > Depends: [1], [2]
> > >
> > > [1] https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
> > >
> > > [2] https://lore.kernel.org/linux-usb/20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org/
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > > Changes in v4:
> > > - Rebased on top of Greg's tree to resolve conflicts.
> >
> > Nope, still got conflicts, are you sure you updated properly?  Patch 1
> > applied, but #2 did not.
> 
> I feel stupid enough now. I rebased on top of usb-next instead of
> usb-testing. Let me spam it once again

Both branches should be identical right now, perhaps you missed when I
synced them up.

