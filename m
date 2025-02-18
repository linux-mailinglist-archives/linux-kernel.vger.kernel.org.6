Return-Path: <linux-kernel+bounces-518789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBDFA3948F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B7D188976E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A122AE73;
	Tue, 18 Feb 2025 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lCxShyY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD31DE4C2;
	Tue, 18 Feb 2025 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866253; cv=none; b=cKa4kwbNAM8T5FVWia1N7IV7gK6OvNQuLRZSTysvsoNC0PY61YlygexZ7EijndksNiZCKyvPmGjhGZCSUTQ/+nN56OuY8Ev41W0U2VTfGLWfwNYN8Vkbcq3cNzyoJ/Qk1o3D/caitXMVAaSq/tX4fBhzbIBQ1QS7qf7SO3BE+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866253; c=relaxed/simple;
	bh=Xn8Eug54BTNvbhwm4r4GgmUNpr3mOGqeFSI54sBSM1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwFGq3mCV/4Fwtx0P0z/iDuyNYEEbbpeUQQIzuezRKFbgVOpyUv2iT+mFCjRgL6FSZQahh5EIAem2fepx+eOJCiBfOZ1Yr75k3aB+w05fVLTtT+dmv9SjPUuVlPERLnrwBmyFScIDcjRPOysbm2oJyosDoVwGaJj+/E8dQ/UnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lCxShyY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEF1C4CEE6;
	Tue, 18 Feb 2025 08:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739866252;
	bh=Xn8Eug54BTNvbhwm4r4GgmUNpr3mOGqeFSI54sBSM1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCxShyY2pLEegHlZumDdUNGHJ53Wd9tracfk+YVj7jwbYw/+1YfexHq3y1Q+2oIZw
	 gJkKy85+K/IWvWhud0dItMxD+nTJPqLMn84F73dMqfKCcZZ+OwNwRj0izL1CK7kFNA
	 DfjdtE66b3QYtnmB8bdKQclSRD53/RNX9UeF8RWU=
Date: Tue, 18 Feb 2025 09:10:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] usb: core: Don't use %pK through printk
Message-ID: <2025021822-plausible-poem-eb90@gregkh>
References: <20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de>
 <20250217-restricted-pointers-usb-v1-1-78da55158832@linutronix.de>
 <2025021733-strudel-curator-bfaf@gregkh>
 <20250217153444-4e1fd8ec-7f0e-4f40-8fc1-e323e4622284@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217153444-4e1fd8ec-7f0e-4f40-8fc1-e323e4622284@linutronix.de>

On Mon, Feb 17, 2025 at 03:50:54PM +0100, Thomas Weiﬂschuh wrote:
> On Mon, Feb 17, 2025 at 02:52:05PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 17, 2025 at 02:20:51PM +0100, Thomas Weiﬂschuh wrote:
> > > Restricted pointers ("%pK") are not meant to be used through printk().
> > > It can unintentionally expose security sensitive, raw pointer values.
> > > 
> > > Use regular pointer formatting instead.
> > > 
> > > Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > So really this is just a revert of 2f964780c03b ("USB: core: replace %p
> > with %pK"), right?
> 
> In this case, yes.

Great!  Mark it as such then please :)

> > Why not express it that way, and explain _why_ it's somehow now ok to
> > use %p when previously it wasn't?
> 
> The full background is in the email linked from the commit message.

That's not obvious at all when reviewing patches.  Please provide enough
information in the text itself to understand what is going on.  We
don't always have access to external links so we can't require them for
context.

> %p is more secure than %pK since
> commit ad67b74d2469 ("printk: hash addresses printed with %p").
> %pK was never intended to be used through printk() in the first place.

Great, say that then please.

> I'm doing the these changes for various subsystems using a common
> commit message. The changes are not reverts for all of them and
> digging out the specific history for each single line is a bunch
> of extra work.

Writing a good changelog is hard.  Trying to automate it like this is
going to be harder.  Just take the time to either do a revert (and
explain why), or do the change (and explain why).  Either way you have
to explain it properly, no shortcuts there.

> If you want more historical context, I'll resend the series, though.

As you are reverting a commit that was stated to be "for security", yes,
it better be redone, otherwise this is going to seem like a regression.

thanks,

greg k-h

