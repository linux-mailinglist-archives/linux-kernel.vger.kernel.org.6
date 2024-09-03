Return-Path: <linux-kernel+bounces-312212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D199693A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8804281368
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FAF1CFEBD;
	Tue,  3 Sep 2024 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SHqzcIrW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE91CF2B6;
	Tue,  3 Sep 2024 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725344779; cv=none; b=DkX6k/GafhrPfJof9hWbpYVAYJXSgv+0z6Q68v+xbUTpSUwBckp/RyIxCmMgSHbtS+bhkW0l5lxHyKR1to0cJBm3oKwPnpKrHZVQy+cGXutCEvot+aSi6uzsnLQy59zmjNFKwi+YnqeiCG//AWMVfTQziZJ4kuUFPKitRNuY7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725344779; c=relaxed/simple;
	bh=OYU3Vv6X2dt4TiWTT+E0OJJb2KwBvcbab8wH1wtnTCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttc6fx4Dcg+2yHlfaXTJO+XaUVFNQFYqDdADAWXwxPPKI+meF6ej0Gv5ZxQejXN8yiR8qy13mzDhtF7BSGhml5tIgb1QjawL+SCF1RiQytI1hWVP7t46yDXwTOk7z6vKIPBIqOMkIMpNF/KCbKIk8RJ/kA9ZgC8NE08pTgsNzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SHqzcIrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47743C4CEC5;
	Tue,  3 Sep 2024 06:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725344778;
	bh=OYU3Vv6X2dt4TiWTT+E0OJJb2KwBvcbab8wH1wtnTCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHqzcIrW5mVA7UsW1aaBMG87uqeuRXYiezlyvOYE2XSRq9atXsjGG9HRiO2m+iYPJ
	 aJ3UIkbHrSl6b/FYdG1FQgQIozFV1095NcqlH9N78pcgAMVu9Gpj+cue9YG161ME2W
	 S6g9i/h3L2sluvXS1CKr2Gizc+AyNCW/TSbHhkTw=
Date: Tue, 3 Sep 2024 08:26:15 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Prashanth K <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v9] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Message-ID: <2024090338-nutlike-oxymoron-90f0@gregkh>
References: <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Thu, Aug 29, 2024 at 11:54:39AM +0000, 胡连勤 wrote:
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Considering that in some extreme cases, when the unbind operation
> is being executed, gserial_disconnect has already cleared gser->ioport,
> triggering a gadget reconfiguration at this time and gs_read_complete
> gets called afterwards, which results in accessing null pointer,
> add a null pointer check to prevent this situation.
> 
> Added a static spinlock to prevent gser->ioport from becoming
> null after the newly added check.

In looking at this further, shouldn't we just be moving around where we
call usb_ep_disable() in gserial_disconnect()?

Can't we shut down the endpoints _BEFORE_ we set the port structures to
NULL?  After the endpoints are stopped, then we know that there is no
outstanding i/o possible and then we can clean up properly?

Not to say that your change doesn't fix the race condition here, but
cleaning up things in the proper order might be the better way as then
there can not be any race conditions at all?

Have you tried that?

thanks,

greg k-h

