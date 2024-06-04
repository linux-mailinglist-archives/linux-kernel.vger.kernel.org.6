Return-Path: <linux-kernel+bounces-199967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430F88FA84B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CAA1C220D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B62312C47A;
	Tue,  4 Jun 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9a9pvqf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07DD6FD3;
	Tue,  4 Jun 2024 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717468256; cv=none; b=eL+m/EZEr5YuE7YPANqWh+TLYpzBjoPdT1HPMO0xUDgdNQsc7Ks7psUxH9hPIHQsxQvlhYVv0Ku3ikSVXQEwNNV+yVa8mYB3ogG5xmP5kGjJrfz21U2mgFXTrvo+C9UEQgPwdT2LstctlUD7YBx3ge3asJ79+99ts+O10Fd3wZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717468256; c=relaxed/simple;
	bh=To8fbG5O3C9YMOaBN3ki4SETwIhbdcKXVkxjt90NHYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIo1UcuR0UlOdk9L71fxeJUQbTdwSJN4yDruu5CBcVNaNCFqbEIvd6gfjrdUlzAK3H3b5KKP0T/W3aJBMLuDvSg+lo2h/hl8TtELDNeIS+gwgYjWkhrWnTnWto3ZNsSmAyUuWesPlcqxKUroG2puGq8K/Jy7+HbRfJzy0z0EJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9a9pvqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD6EC2BD10;
	Tue,  4 Jun 2024 02:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717468255;
	bh=To8fbG5O3C9YMOaBN3ki4SETwIhbdcKXVkxjt90NHYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9a9pvqfiNhkA/yXbTHAe18mKQqZDgmFunO9Hc3/jCu+nbWirZWD1u4vr2WkNoEu+
	 KUwHyKEwTdy57naVtnxRWNpffWbqVJID5z+2XpyxYXMaIT5u8x+HjB9r8fXTJcuiir
	 h2HcPlcRUFx/cdd2CQgTLJF4WCvwsa/wgtPjNWF9Ygsw9kuHl6lCZY1/zZKA7cYpK6
	 y5W9pXz5gEiPvo+Y51LqI/OlYusXspl6IyPXpe4Summx74JlNmRiEsuP2QqZz1j4dU
	 FpickXtUkU+bk0fbAJFCfRRAPVCLRd2LNjd7vEY01kfvGf5OcarrHM8TxfftCr5F+A
	 auUPs4iBllFiA==
Date: Tue, 4 Jun 2024 02:30:52 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Ben Walsh <ben@jubnut.com>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] platform/chrome: cros_ec_lpc: Add a new quirk for
 ACPI id
Message-ID: <Zl58XNl8fhJU24OV@google.com>
References: <20240603063834.5580-1-ben@jubnut.com>
 <20240603063834.5580-4-ben@jubnut.com>
 <Zl2NTbhk96dhTV2n@google.com>
 <c8d765bc-4e45-40b3-a33d-b4cc1bbd67bd@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d765bc-4e45-40b3-a33d-b4cc1bbd67bd@amd.com>

On Mon, Jun 03, 2024 at 11:00:22AM -0500, Mario Limonciello wrote:
> On 6/3/2024 04:30, Tzung-Bi Shih wrote:
> > On Mon, Jun 03, 2024 at 07:38:32AM +0100, Ben Walsh wrote:
> > > @@ -436,6 +463,8 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
> > >   	ec_lpc->mmio_memory_base = EC_LPC_ADDR_MEMMAP;
> > > +	adev = ACPI_COMPANION(dev);
> > > +
> > 
> > The change is irrelevant to the patch.
> 
> It looks relevant to me.  The companion needs to get set before the quirk
> overwrites it.

Please see code for CROS_EC_LPC_QUIRK_ACPI_ID in the patch, `adev` is going to
be overridden soon.  I don't see why the ACPI_COMPANION() needs to move here.

