Return-Path: <linux-kernel+bounces-404925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255DD9C4A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB421F222B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715A5695;
	Tue, 12 Nov 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FOl33i5A"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A194A02;
	Tue, 12 Nov 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370203; cv=none; b=ke8ih3G0nOrSNz7gBcJliGjA1rva9v4cloKaT5baySNtSO4/zFQK57MLGbJuZBbmMgnLpmNtZv39roTIjcyXxzE/CS+5NE8jMBauctXEo0NixLEW8RTW98rj7emfUvUrDtnVgxO3YJjacZdQ14wYKdQtH9oHBFhD0Lpx7QETH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370203; c=relaxed/simple;
	bh=xl6DIroffs/s8SGonn2or/IMxO7QdNwIkPQb7bfS4GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I56YmRlKNM4JdUobYM3kVnPjtdcR/rHhKN5x5R85fyfumEdbcHIQiHk71gtrROtB7ZTbg+59KY7i9k3J81j8rREauF8R7t+FuHddTeNG92wqmZbYXjaHDlCKzXt2coDGj58GR74xeYG6i8p5BqGVgi+iRyZz+y47sbNSNcgeaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FOl33i5A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bWFsc8p4mLEB2MsGFXn2adZDroP0crxGSJj952nDsxM=; b=FOl33i5A6z2Bva7wdZHfGSsBEY
	nQaJ7xMux/r+sL9cZqTvKFrEQQ4ecB5EfnQ4kqmRC1u6cpJ2h15/Vt0xomG3LLu8bDkDl5BVTlijL
	J1qOiLxMJYOsqvq0s1tS6D+FSgOxvD251O7L1pKnKB0ixUn2T8d8CP+OludQ3qVrDxrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAeTW-00Cwht-P1; Tue, 12 Nov 2024 01:09:42 +0100
Date: Tue, 12 Nov 2024 01:09:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
	jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] eth: fbnic: Add PCIe hardware statistics
Message-ID: <d55bf54b-87c0-460f-b06c-b1941f473922@lunn.ch>
References: <20241111195715.1619855-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111195715.1619855-1-sanman.p211993@gmail.com>

> @@ -145,6 +147,8 @@ struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev)
> 
>  	fbd->mac_addr_boundary = FBNIC_RPC_TCAM_MACDA_DEFAULT_BOUNDARY;
> 
> +	fbnic_dbg_fbd_init(fbd);
> +
>  	return fbd;
>  }

I thought it was odd that you create debugfs files in
fbnic_devlink_alloc(). But when you look at that function, it is
actually badly named, it is a collection of random initialisation, of
which devlink is just one.

I would suggest you call fbnic_dbg_fbd_init() in probe, like any
normal driver would.

	Andrew

