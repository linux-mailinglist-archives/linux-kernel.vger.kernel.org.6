Return-Path: <linux-kernel+bounces-175253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031EC8C1D11
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771CBB20C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6866149DF0;
	Fri, 10 May 2024 03:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT3hSPVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03396149C51;
	Fri, 10 May 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312159; cv=none; b=DYx9jioGZL2VvIU1Fw5VubwEe3w3gA8tjyM4n6iC4Hn5vZbmjk4Ui/p1Fwy2kUNk04X3s+zZCsMdx7yQXVSONYZqFnpa2FPINWuWUJEp+x0P+pWGRrj3Es4pu9OpHvyKTINkoT6RG1gcfI3JVt7rdHbyclIG6qo1byWXCbpcK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312159; c=relaxed/simple;
	bh=sN0U/LdBaquLs+NEyynzcCHXuCbNgCo7vj4mzB4lDMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wjz5G536nhOgXTuKgdBCxpUf5tzdHbXl6T3u0BGtGTv1B2VDSHHDbao206vEZiBhTtga8RNx9/Q6fgo3O8OZiSV4yMKoAuBATXDERYFmyavxdu1XJ4qDWMc2x9yLdjOwiPAr37pWg44WeeJOO8nMdETR7WZCtMtKenli7oyRtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT3hSPVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247EFC2BD10;
	Fri, 10 May 2024 03:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715312158;
	bh=sN0U/LdBaquLs+NEyynzcCHXuCbNgCo7vj4mzB4lDMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mT3hSPVgD8mHH6/CQNCiaLfuIzsjsqQwlzH1e2J4Y4BWopi4kvBUthHN5n7a364oX
	 Y5/ZQVAUou/AMBLnWXueexvY5G4daoBgkoPMquJdy8qYMaIcaziH8VJOAhayd+Hb6W
	 WayzsxeyzGwTthNGxvQBBRlsbmwYONn3j9tLRhoATzn0g4GASdCeS4yVMedxg0zjJm
	 F0MdMgk3Hn+9xJiB0Xi/czWpzjs/2aiE8fQ1PLslBAuT8gztbavy/PXgoNVrAcsVX2
	 sy+GpR41OlNHMXLzAixLbEh1rOt3kCs5CfySbSVB5+jU58b4jzASInstvym8pbVPTb
	 jwNZCC5JBmisg==
Date: Thu, 9 May 2024 20:35:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v4 00/10] Introduce RVU representors
Message-ID: <20240509203557.61841c70@kernel.org>
In-Reply-To: <20240507163921.29683-1-gakula@marvell.com>
References: <20240507163921.29683-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 22:09:11 +0530 Geetha sowjanya wrote:
> ~# devlink port
> pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcivf controller 0 pfnum 1 vfnum 0 external false splittable false
> pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
> pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
> pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false

There are only VFs on the device? How does one install egress rules
towards uplink?

