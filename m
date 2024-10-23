Return-Path: <linux-kernel+bounces-377349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505869ABDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60B3B2377E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66122140E2E;
	Wed, 23 Oct 2024 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yUyag7Hi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561D39ACC;
	Wed, 23 Oct 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660130; cv=none; b=kT9JawcbrxT/xmTgYkdYrf/WZEZh1cIZui10BmLT1IBrxunt++Sj6YqyomvozIDCDuRAEhUQSURV65jbjRrFTj1pubXtaFah0dJv2eLCcF4MTOJnKM7xO9qSfDDSxZDw7dgHD7yNW4K+kRZ/oMfuTWUc7LlcRmbdjOH3Rg4mB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660130; c=relaxed/simple;
	bh=VlvjQ5pm6dXxL9Fy5LEyuCp7Ox6YWVM3nZDTbgO5YjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml3M7kKxY+GbOXu5dHTpf9PALc5heJBEBOhgGZ4jSATFxfidhJOie5WOWQYJVPlPQlVlWEoHTlQHidvB2vhIo6FnF2Ou5Cx38DOGco4MMFze8TDeMeCsWHiAZyasCIFp6hAXxLueBhk60hZvHrpfrlx1jT7wRdxqCPd87bXrEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yUyag7Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB2C4CEC6;
	Wed, 23 Oct 2024 05:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729660130;
	bh=VlvjQ5pm6dXxL9Fy5LEyuCp7Ox6YWVM3nZDTbgO5YjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yUyag7HiNVutWY0dgeJ1jW8HPJCPMsG9vwgUTkHWdb15pAlfmRVHzwzrQIQ8fHGpa
	 pua75cCVU7neQfYof7+oxzB96hHPuqM2sBCogNV3nRHMuzwvdpbv6kN1tFPgDDQtA2
	 OJQUluivlF/wJawAzGkIcKP7S6Rsey4T8T7fQjz0=
Date: Wed, 23 Oct 2024 07:08:47 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Yanik Fuchs <Yanik.fuchs@mbv.ch>
Cc: "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	"rdbabiera@google.com" <rdbabiera@google.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: tcpci: Add FAULT_ALERT handling
Message-ID: <2024102343-onset-entangled-1047@gregkh>
References: <GVAP278MB0662D8077733604B9B103187974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GVAP278MB0662D8077733604B9B103187974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>

On Tue, Oct 22, 2024 at 05:06:46PM +0000, Yanik Fuchs wrote:
> Good Evening
> 
> This is my first Pull request for the Linux Kernel, I hope, I have formatted it correctly.
> The info about the Patch should be clear from the message I added, I hope.
> 
> 
> Freundliche Grüsse
> 
> Best regards
> 
> 
> Yanik Fuchs
> [cid:239faadc-5aa5-4417-b69c-5afc0ce01589]<https://www.mbv.ch/en/>
> MBV AG
> Microbiology and Bioanalytic
> Industriestrasse 9, CH-8712 Stäfa
> [cid:a21e1738-fbcb-44ca-b6ba-611f60800d18]<https://www.linkedin.com/company/25071130/>  [cid:9c47fbef-89db-4406-89ee-a2b4487eeaf2] <https://www.youtube.com/channel/UC3vLuuteeanNc1wX9OTARDQ>     Legal disclaimer<https://www.mbv.ch/en/about-us/imprint/>
> 
> [cid:bc59151f-ea88-4e9b-ac75-03cfb28b780f]<https://www.mbv.ch/en/about-mbv/events/>
> 
> >From 133cda1dff7e87f999506164533bbb1cfaf8fe7e Mon Sep 17 00:00:00 2001
> From: yfu <yanikfuchs@me.com>
> Date: Tue, 22 Oct 2024 18:27:49 +0200
> Subject: [PATCH] usb: typec: tcpci: Add FAULT_ALERT handling
>  message
> 
> I encountered an issue, where I was not able to communicate with other
> i2c devices, if ptn5110 was initiated while it was seeing Vbus.
> 
> i2c analysis did show, that ALERT_FAULT pin is asserted and
> reasserts on try to acknowledge it, because there is still an asserted
> pin in FAULT_STATUS. This results in Alert GPIO being always low.
> 
> With this Commit, I add a function to the IRQ handler, which acknowledges
> all asserted Pins in FAULT_STATUS register. With this patch, ALERT_STATUS can be acknowledged without issues.
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index ed32583829be..eb885aa4171c 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -714,6 +714,13 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>     irq_ret = status & tcpci->alert_mask;
> 
>  process_status:
> +   /*
> +   * some chips asert fault alert, even if it is masked.
> +   * The FAULT_STATUS is read and
> +   */
> +   if (status & TCPC_ALERT_FAULT)
> +       regmap_read(tcpci->regmap, TCPC_FAULT_STATUS, &raw);
> +       regmap_write(tcpci->regmap, TCPC_FAULT_STATUS, raw);
>     /*
>      * Clear alert status for everything except RX_STATUS, which shouldn't
>      * be cleared until we have successfully retrieved message.
> --
> 2.34.1
> 
> 
> 



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

- Your patch was sent in html email format, making it impossible to
  apply and automatically rejected by the mailing lists.

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

