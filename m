Return-Path: <linux-kernel+bounces-168532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A0F8BB9B7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECFC283305
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 07:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6EFBF0;
	Sat,  4 May 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gADPExCn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4234C79;
	Sat,  4 May 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807503; cv=none; b=knPmQ6msnO8tWQrNQgGcJRF8gA8/ieys39Pxrq8N1f+J7Ic05xXd3j8ES7PYdFQ3i666li/V/SIkZ9VUW9ZOTPAotKrOi9fyiOkjU1c9d40GCjGs3LdsvyZJuU3FqzbsR3QyhkfaQhL6x9ir8dK/V4YQ8yrrBXFiD3pVBH22ywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807503; c=relaxed/simple;
	bh=WdmDyNf2NKYNL8b8araxldj2J5xKr2CLnPlzbU7nol0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCppYHe/ARV68Gu1tcgejto64CkXb7XcSr5RAauBE2TJ18FTryj4TMPptV+FI3nkcx/MWvYJou9TQYku++1m+/jO6DsPYBsUGQFuq0FVWbzBnqJdJCp+l9oFURbvQB24oOgce5KzD7V75cU1I/cJJqaiShwemd6ljclmda3RhPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gADPExCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA647C072AA;
	Sat,  4 May 2024 07:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714807502;
	bh=WdmDyNf2NKYNL8b8araxldj2J5xKr2CLnPlzbU7nol0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gADPExCnuVuNsa1mA67lj19b0lFVc6LhsdF4qHJciHwcSoqcksUeVPBvEEbuMlVuu
	 GkN3u7MmS3g2wrsX0dJGkTZtnptuK/ru56gNLJTR8eLSWKFYUinTxEhXMDLYr+Kedx
	 O+HDqymWhn3kgO/ZOMR/t2n7yHbidUflf6PazjdM=
Date: Sat, 4 May 2024 09:24:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Benson Leung <bleung@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [v3 1/4] usb: typec: ucsi: Fix null pointer dereference in trace
Message-ID: <2024050451-stonewall-mouse-4a31@gregkh>
References: <20240503003920.1482447-2-jthies@google.com>
 <96d63b0b-3258-4bf6-b75a-06eb4f4253bb@web.de>
 <CAMFSARdhyWAFWr6qjsabPN6k=sK9LLxOaoSNkVLyTKNE=drSpg@mail.gmail.com>
 <265db78b-1d69-4b12-a370-2589d8987833@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265db78b-1d69-4b12-a370-2589d8987833@web.de>

On Sat, May 04, 2024 at 07:12:49AM +0200, Markus Elfring wrote:
> > I don't think it is necessary to mention changes to the commit message
> > in the section below the commit message.
> 
> Did you notice that other contributors occasionally share hints about
> adjustments for parts of commit messages?
> Will further information presentation become better supported?

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

