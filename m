Return-Path: <linux-kernel+bounces-239584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F8B9262CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2EF4B251FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE25817B509;
	Wed,  3 Jul 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sps+pOmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14E1DA318;
	Wed,  3 Jul 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015530; cv=none; b=pEgPRP0oAgUKiX4GsyuurTdEQa4VrJdf1oeyGLsAsUaWp3oL8REKLm/LO+OPlLk4Eh0CuEJzKFwrdoHepdbhIltPfbbqZ1ck5YDBa1N7QfMzHUckKzDw7sVPU3o6txnCxw4U9UYMABZZRE1wDVeFS2aILL4M6X3aPxCv3CH9NPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015530; c=relaxed/simple;
	bh=SBuiLlAm8KdKJg4F9Y0YoQ0A1QaiAy6w/Qr73jLhApo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAmguks613ZzGAXaAILmvHxo2/fO3NbJf613IjJA31mKjkeubtqfhimgxYsSNUhTaGhdrvtLiiUcp2WmEQpKbsGOE0TKUnENurIDX0c/7ZrHT2NM/6nnFfFEGluKtm1aiLUqPb/RZLDfvQ7dmAn/azcYKMIgPSnmDMjEYZfaelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sps+pOmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD7AC2BD10;
	Wed,  3 Jul 2024 14:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720015529;
	bh=SBuiLlAm8KdKJg4F9Y0YoQ0A1QaiAy6w/Qr73jLhApo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sps+pOmGOcLZTVV9gSreDYf32GXk4Sa3XE8agNk7MvVkVWlhHYVJAkc5E0yJnbttA
	 9NCCGPfPfIFZXp3rBmgBxXEjVim7Ke4nDtWYF8gz7DidP8S03BIpuILdH9e8p8QH5P
	 h6Eb7Cs6LoF/il5mumcvp/t9iqQ52jxIrxJa1AfU=
Date: Wed, 3 Jul 2024 16:05:19 +0200
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
Message-ID: <2024070310-iodine-synopsis-4fd9@gregkh>
References: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org>
 <2024062717-foster-document-eb2f@gregkh>
 <CAA8EJprAshnt3YchBv0ssi4Vet9b6oMcf3z8nuRkoZVYNBq64w@mail.gmail.com>
 <CAA8EJpqCJ8_wOO7yLYA85KYtbLO6hvS-yb7DA6kJ2sH4QH43QA@mail.gmail.com>
 <2024062825-balancing-resigned-e383@gregkh>
 <CAA8EJprsJLMTnd9epLR4Uc02Vg2veW1mpqFxxL=rHU9DtJ8UqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprsJLMTnd9epLR4Uc02Vg2veW1mpqFxxL=rHU9DtJ8UqQ@mail.gmail.com>

On Fri, Jun 28, 2024 at 05:25:17PM +0300, Dmitry Baryshkov wrote:
> On Fri, 28 Jun 2024 at 17:24, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 27, 2024 at 06:08:07PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, 27 Jun 2024 at 17:57, Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Thu, 27 Jun 2024 at 17:54, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Jun 27, 2024 at 05:44:39PM +0300, Dmitry Baryshkov wrote:
> > > > > > The interface between UCSI and the glue driver is very low-level. It
> > > > > > allows reading the UCSI data from any offset (but in reality the UCSI
> > > > > > driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
> > > > > > is to be done by the glue driver (which already resulted in several
> > > > > > similar-but-slightly different implementations). It leaves no place to
> > > > > > optimize the write-read-read sequence for the command execution (which
> > > > > > might be beneficial for some of the drivers), etc.
> > > > > >
> > > > > > The patchseries attempts to restructure the UCSI glue driver interface
> > > > > > in order to provide sensible operations instead of a low-level read /
> > > > > > write calls.
> > > > > >
> > > > > > If this approach is found to be acceptable, I plan to further rework the
> > > > > > command interface, moving reading CCI and MESSAGE_IN to the common
> > > > > > control code, which should simplify driver's implementation and remove
> > > > > > necessity to split quirks between sync_control and read_message_in e.g.
> > > > > > as implemented in the ucsi_ccg.c.
> > > > > >
> > > > > > Note, the series was tested only on the ucsi_glink platforms. Further
> > > > > > testing is appreciated.
> > > > > >
> > > > > > Depends: [1], [2]
> > > > > >
> > > > > > [1] https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
> > > > > >
> > > > > > [2] https://lore.kernel.org/linux-usb/20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org/
> > > > > >
> > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > ---
> > > > > > Changes in v4:
> > > > > > - Rebased on top of Greg's tree to resolve conflicts.
> > > > >
> > > > > Nope, still got conflicts, are you sure you updated properly?  Patch 1
> > > > > applied, but #2 did not.
> > > >
> > > > I feel stupid enough now. I rebased on top of usb-next instead of
> > > > usb-testing. Let me spam it once again
> > >
> > > Hmm, I see what happened. I had a next+usb-next. Simple usb-next
> > > doesn't contain changes from 9e3caa9dd51b ("usb: typec: ucsi_acpi: Add
> > > LG Gram quirk") which this patch also modifies. I can rebase it on top
> > > of your tree, but then we will have build issues once usb-linus and
> > > usb-next get merged together.
> >
> > Ah, you need/want stuff from both branches, right?  Then just wait until
> > next week when my -linus branch will be in Linus's tree and then I will
> > merge that into the -next branch.
> 
> Ack. Maybe I'll post another iteration based on the discussion on the
> mailing list.

Now queued up, thanks.

greg k-h

