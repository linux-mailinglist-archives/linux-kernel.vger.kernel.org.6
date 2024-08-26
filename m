Return-Path: <linux-kernel+bounces-300640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA81695E671
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE561C20A43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2E2B66C;
	Mon, 26 Aug 2024 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mXdr6Rlm"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329E23C9;
	Mon, 26 Aug 2024 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724636925; cv=none; b=GxBdIHEYttr5QdyMzvsbeSaNfrq9mRL+TdKYyWXwgXP+Xd1Ck1UEBUHichiXS4Ooa9LZO8itawEizgAopKuxpYEDqdETZe30Rlx0b9Z23nD51Nx7jr49I9sJXKAmzCM4SCzvpQTANN5+759t727BnSdo0J3sgInDRjbYohRUTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724636925; c=relaxed/simple;
	bh=IFpIjq7M4Q8HeW5xUDg2Mnv7OtXsD56oTLv+w/F+s04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6HTE0yQAfT2s49PRL1T/zVV1j1qABJ8Tlaz2nkFnmPBmyodEo5yHrlY7x2FS/KOHHn6aTpYr9x4DlghxvX2kz55y8MJAIo0RJKEL5+y/0vHEShh9h2bWFf1uJuWWPsc1IY01/JFcw/I0jCw7ANDSYWUqTJI7ImBexC0Qeykb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mXdr6Rlm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iv6ZEUuPPqeOj8zp4uUVvcR1G/kNOJR6TPjSTE0A0Eg=; b=mX
	dr6RlmAgSezIxhXPY1aayBO0uRGpArjLeF6sACQPASjHPD8v4kQLI3PbIlXtOJ3fSBSAwgDAtApa/
	0yHr8iHZI/XuKlK65/scrLyh4ksw8AUNjt8kwIqQBquFqJfoQbxl5pxZgTee+j6mP2LB3lKEF5cht
	2NPQFr6ggugHuw4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siOqK-005fFg-NM; Mon, 26 Aug 2024 03:48:28 +0200
Date: Mon, 26 Aug 2024 03:48:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Carlos Bilbao <cbilbao@digitalocean.com>
Cc: eli@mellanox.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	eperezma@redhat.com, sashal@kernel.org, yuehaibing@huawei.com,
	steven.sistare@oracle.com
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
Message-ID: <d9695755-c0e6-4bbd-af5a-9fc78fac4512@lunn.ch>
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>

On Fri, Aug 23, 2024 at 11:54:13AM -0500, Carlos Bilbao wrote:
> Hello,
> 
> I'm debugging my vDPA setup, and when using ioctl to retrieve the
> configuration, I noticed that it's running in half duplex mode:
> 
> Configuration data (24 bytes):
>   MAC address: (Mac address)
>   Status: 0x0001
>   Max virtqueue pairs: 8
>   MTU: 1500
>   Speed: 0 Mb
>   Duplex: Half Duplex

If the speed is 0, does duplex even matter?

	Andrew

