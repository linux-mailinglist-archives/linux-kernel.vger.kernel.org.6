Return-Path: <linux-kernel+bounces-263968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E9493DD52
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 06:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E01E284BA9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231801B80F;
	Sat, 27 Jul 2024 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HS642L71"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E015C3;
	Sat, 27 Jul 2024 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722056253; cv=none; b=Qe45pWkiK01p8Q/J2+tUqch+5mdVkKWlNAwMulVBNZPy8f4TJwzd9CPoC8f3hCH1KNZ+jKUERu6S1BnEsYVccLaNYyid2jbfWXy3+DZ8X+FHv5lgL3QJ9toSzpr8ziwn4WysBW8n2pMN4tdtQzWi2eUCjbdAmsOby84eOcVJ6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722056253; c=relaxed/simple;
	bh=0C4P/1dWeeUrRZ1L5tcWLfqzwHqb9jvhV2GQ3DVrl6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiBPhIZD3Ohfn5qPRtTiz+8uhlXch9YxfTlSkR3sR8heWuBSaUBF8nfEYC43xsKy/5myn53rVfMNGwyHwk7QvSUHA3NYL75xODkkslXrTqV7RMkE0394Ly1ob+hm2iFPqTeuEZnLVTPk3aqYRDeObfyEY+BAueuPOtv/tDLwUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HS642L71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC9CC32781;
	Sat, 27 Jul 2024 04:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722056252;
	bh=0C4P/1dWeeUrRZ1L5tcWLfqzwHqb9jvhV2GQ3DVrl6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HS642L71DJj1yjwJ7W030t6PNInH4W5nJpy0ZYihmAeHVp5rCKK9L8ikI3MU/ihLx
	 hi60ByXJ9+2nAZAa4KdlI5l1neiRg7qrpzk4owzvlTyvmojWGpuv5iCKTh6d7XnD31
	 ush9BsjTcdg4lJG1olnZ1sejDOl2+cBxT/PcqOKk=
Date: Sat, 27 Jul 2024 06:57:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	John Crispin <john@phrozen.org>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: mt7988 usb broken on 6.10
Message-ID: <2024072712-paralyze-overthrow-ea04@gregkh>
References: <trinity-c8e0af34-2704-476a-9454-bf5001256eb9-1722013999541@3c-app-gmx-bap12>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-c8e0af34-2704-476a-9454-bf5001256eb9-1722013999541@3c-app-gmx-bap12>

On Fri, Jul 26, 2024 at 07:13:19PM +0200, Frank Wunderlich wrote:
> Hi,
> 
> i've noticed that usb on mt7988 is broken in 6.10, was working on 6.9 (with some additional patches like
> for pinctrl and dts as this chipset is not completely supported by mainline yet).

Any chance you can use 'git bisect' to track down the offending commit?

thanks,

greg k-h

