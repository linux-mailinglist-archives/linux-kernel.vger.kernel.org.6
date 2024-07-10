Return-Path: <linux-kernel+bounces-248056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1201092D7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CA0B22164
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67C19581F;
	Wed, 10 Jul 2024 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWrpl1W9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA919539F;
	Wed, 10 Jul 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634152; cv=none; b=eq/8ceoqs/XB8y1OP2b2UWTJv4wGujkP64RGw7Mb97hNql8EMDZqwfK+90SUfLsfWENewTUDYbHQHzSPuo9/WiSvZXehOVXc+cIYkAMPbb5uuI5+yYZswiGXSZxU1i61YYwaGKfMdhQCEgZ155x49ktVxlFfN5vaC0MqpmcAxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634152; c=relaxed/simple;
	bh=yFzCAyCkK9jfPGFSXqPBYBosDVuU0rtRgivgRfBm0hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atgCNcuFnLq1ie1z/TRI+COQVhb0echiFC49cw84Ov+731EuaXTwt2mnhNkD4XhNdJ+eg8W95qtG2WqHKWKbUEsq4ffkP1PpDwWelFN+Zm2Wo3g/9nbtzBkIwYUxvKsrjexDFrQA5Na7Qg8KDyZMwqJgWCqpV1Az94n/weSwFJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWrpl1W9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E67EC32781;
	Wed, 10 Jul 2024 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720634151;
	bh=yFzCAyCkK9jfPGFSXqPBYBosDVuU0rtRgivgRfBm0hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWrpl1W9ZWv4TVbJm/2AGXtih2NeUVqvxP68CvsW5NW21dIuhUx7FgFFYGe0XT5Xy
	 cu81MowOrRgEJZafjxrwLGts516Z4k5x8R2IqVbGPiscWWf+6wKbjt1xGbv1KiDGUj
	 9v2x3mcPL1ku3dljJI1yUZVTMDYO5rw0nMb5VBAs=
Date: Wed, 10 Jul 2024 19:55:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.10-rc8
Message-ID: <2024071035-smooth-roping-ce9f@gregkh>
References: <Zo6y1Y8IkNDlgqBf@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6y1Y8IkNDlgqBf@hovoldconsulting.com>

On Wed, Jul 10, 2024 at 06:12:05PM +0200, Johan Hovold wrote:
> Hi Greg,
> 
> I noticed that you still have some fixes queued for 6.10-rc8/final so figured
> I'd send this now even if this addresses a really old bug. I've verified that
> the issue is real and have tested the fix here myself. Feel free to queue it up
> for 6.11-rc1 if you prefer.
> 
> Johan
> 
> 
> The following changes since commit 4298e400dbdbf259549d69c349e060652ad53611:
> 
>   USB: serial: option: add Telit generic core-dump composition (2024-06-27 12:04:33 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.10-rc8

I'll take  this for 6.10-final, thanks!

greg k-h

