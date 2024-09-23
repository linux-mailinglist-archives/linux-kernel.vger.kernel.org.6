Return-Path: <linux-kernel+bounces-335680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4409597E907
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F6A1C21233
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ACE194A54;
	Mon, 23 Sep 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pebnr0fE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F698479;
	Mon, 23 Sep 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084873; cv=none; b=ThLmv+qRlIWyq4F0XqQfnJH+Rcuq+b4PO2GsLtl8MvQcdswe53JIAbuuC0rNcVy0VJJEhtjUVa9gOAz3g6cmeJ1V4zNKn7u7JIgTY3YzRz+9grJzvCNxY28QcEKquDfOU0jA2jXGITaF0fBvFHWjOCoa7PaXDkFPjnpZL1mXYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084873; c=relaxed/simple;
	bh=Q0sYxTdsmz7JUuFyQZ2SNTd2GCfVd9QkMyyEy2ulBnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLXksNz+CbCy6jNoALM5eJEp3ndPJad8XuvjROcDNYNB7MD8d7EDi9v072ZhkY5vFii4dtQk4VoG6m12CO4eLY0OwfIbLKTz+rrbqOsYFwOsth357K4hoV/hAsfW+R+Bz8nmYTESQdX/EwB1kxD6E+sEDSLwLhjTDGrJrSLFvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pebnr0fE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735CEC4CEC4;
	Mon, 23 Sep 2024 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727084872;
	bh=Q0sYxTdsmz7JUuFyQZ2SNTd2GCfVd9QkMyyEy2ulBnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pebnr0fECe9qWuQVzHVy0p1cL38VMVMoyMnQyJQTe++FHhEyVU1oo2JsUsaIWWv0c
	 4OF/4vAd7ChLmYdmB/po3AuPddzJ4M8bAGvZfCcA6DFYZbmIze26KT5PkNJDKUf5/W
	 MYXVk0gtIwo9eYJMFCyOd1geRioW2oSr5sGKxYTM=
Date: Mon, 23 Sep 2024 11:47:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tipd: Fix dereferencing freed memory 'fw
 in core.c
Message-ID: <2024092334-waggle-pork-0f30@gregkh>
References: <20240923092625.2673-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923092625.2673-1-kdipendra88@gmail.com>

On Mon, Sep 23, 2024 at 09:26:24AM +0000, Dipendra Khadka wrote:
> Smatch reported dereferencing freed memory 'fw' in tps6598x_apply_patch().
> 
> Invoking relrease_firmware(fw) just after checking ret.
> 
> Fixes: 916b8e5fa73d ("usb: typec: tipd: add error log to provide firmware name and size")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

