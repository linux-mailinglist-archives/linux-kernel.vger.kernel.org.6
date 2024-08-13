Return-Path: <linux-kernel+bounces-285161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7706B9509FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332AB281725
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0044C1A0AFB;
	Tue, 13 Aug 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OHJR8UQ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6561FCF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565867; cv=none; b=Vg7OvJcME9YSduMbuKjIdgAl9nBCt2+UWSjZkrWL1DemRAQ9YbTDInNbt9iqU6RoNzioEfetj5UaP/9JqHG6kTMK52KI0oHt2WegPpDHFSqGYn6Z4NWc4X3TQKacKPf5IQHMDfTCYNLcilrVvKA78Vvgh9FzvXfe2NbZiI0KmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565867; c=relaxed/simple;
	bh=zcZC6qn8za8V0JtUSLeGbRUB7uG/pF8oxx4P8BGHpxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+xG7+czmomxVC1EwS6NRb6yZ3R6PtlUeN3s8OnpNL/jZZGn5KdwByRbDyGMRHRpFMl2DxliOnxqUcXTRvBClEfMiqR0COUAJNS3FsEvSULzE/SDGEuvL3Ff1u/U7BPn4ZkQjfwrf3tLCovIcYl7S7Bp4eB9mIPFE8vYllVAqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OHJR8UQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85109C4AF09;
	Tue, 13 Aug 2024 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723565867;
	bh=zcZC6qn8za8V0JtUSLeGbRUB7uG/pF8oxx4P8BGHpxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHJR8UQ1zxqqJRMO89irDBby2I5NF4hG5w5EkiivWgbXaLTtLiemb8KyaQdLUgJQE
	 zZN0oLMfZT3cha8fGsNaA4AUNfxuQftOGwWwmRIsAbeUuNrrHwuYnDaDCVa7/BhrJ9
	 t+ctQbHHQRUZp2keryJ/F761dkA4tlSaID7f6RRk=
Date: Tue, 13 Aug 2024 18:17:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2] driver core: Simplify driver API
 device_find_child_by_name() implementation
Message-ID: <2024081323-underfed-output-a1f6@gregkh>
References: <20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com>
 <2024081330-posting-tapestry-9372@gregkh>
 <20240813-mysterious-meerkat-of-gaiety-28dee9@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-mysterious-meerkat-of-gaiety-28dee9@lemur>

On Tue, Aug 13, 2024 at 11:50:53AM -0400, Konstantin Ryabitsev wrote:
> On Tue, Aug 13, 2024 at 11:41:50AM GMT, Greg Kroah-Hartman wrote:
> > > prerequisite-patch-id: f58374cebf0ada070fc0825736424dd177e49676
> > 
> > As those ids are not going to be in my tree (or anyone else's), how are
> > we supposed to apply this?
> 
> Greg, these are patch-ids, not commit ID's -- b4 will pull them in
> automatically from lore and apply on top of the base-commit specified before
> applying the series.

Ah, thanks to both for this response, didn't realize this, I thought it
was git ids.

greg k-h

