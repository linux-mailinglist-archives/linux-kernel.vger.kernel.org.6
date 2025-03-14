Return-Path: <linux-kernel+bounces-560697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E08CA60861
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAED23B7465
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA614884C;
	Fri, 14 Mar 2025 05:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fbqzcAyL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19334545;
	Fri, 14 Mar 2025 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931015; cv=none; b=TDE8VTJ8BXtTj/DQWg831QD4/OdiT+5wpGYw2PaS8clP6y1tqzlKq6zK5yv8j4cjpwC/gzwGcTIvRtHQUOwXNd6yWefLND4KpQ3dfWRrzNdxmpC1pNFqGFCvxcPjjJpm5+LSDPCtfgbHAfeTBOuq1nsbmdqAt77ey94k/gpJ2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931015; c=relaxed/simple;
	bh=gzQzQ73NM6gMLoXE5LQJHQP2du/JGGSbbGpwxGkYx8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K95qkvAN2qNjIvNrHT9RjD4Ts8+Cqw7q04YOKOaE7rkpnelkC0AkTfYTg+/jYiBiB2+RMjX+W99PVGlvtZEul4lqm7FyjD9vIsmS7dVEoG3A14Ep599szPBt4bMqGYdqHQTgCsXlzyeSH5VeZ45J6rlDQyiE1AheBphENICK2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fbqzcAyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C70C4CEE3;
	Fri, 14 Mar 2025 05:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741931015;
	bh=gzQzQ73NM6gMLoXE5LQJHQP2du/JGGSbbGpwxGkYx8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbqzcAyLzlegzEamR3KcgjAnoGeYWGB47pX48Ma/2JeYW3V/oSKKLSbH/wCldSbaf
	 nLzbAhi/oVTxxHgRzS1vwa4+1EdGxJcr5IN9hyPQHMdiVV1QtWevdX9zGNdwaOFIBE
	 XCHrPb+/HgFqekElsUTg7KvhoZpEodPaVE7iK74Y=
Date: Fri, 14 Mar 2025 06:43:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: daixin_tkzc <daixin_tkzc@163.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	matthew dharm <mdharm-usb@one-eyed-alien.net>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: Re:[PATCH] usb: storage: Fix `us->iobuf` size for BOT
 transmission to prevent memory overflow
Message-ID: <2025031403-posing-drew-d297@gregkh>
References: <20250311084111.322351-1-daixin_tkzc@163.com>
 <2b6c4aa7.b165.1958f6b7a3a.Coremail.daixin_tkzc@163.com>
 <814316b6-013b-4735-995d-b6c0c616c71b@rowland.harvard.edu>
 <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>

On Fri, Mar 14, 2025 at 10:28:41AM +0800, daixin_tkzc wrote:
> I'm sorry for not making my point clear. 

<snip>

Sorry, please do not send html email to the mailing lists.  It causes
your emails to be rejected.

Also please do not top-post.

thanks,

greg k-h

