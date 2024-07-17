Return-Path: <linux-kernel+bounces-255584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB5B93427D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E7CB21C36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0663183083;
	Wed, 17 Jul 2024 18:58:36 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F01822CD;
	Wed, 17 Jul 2024 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242716; cv=none; b=K/KAzd4x/r5cZhgI6SKEYw6s+ThZjsg8At9+pd+8q3mGevrMMWQJ1Aeb1YCHAMtp7zOQi5KZQPhdYD/uF6n5P7AvLjjPCI8sL45EEDhDJP7M/SsHcjXxKDA7vYE1rHLrWCJw2ivRvki8MRRqliDs2J4IsBJZsUa7G+bKHcSWK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242716; c=relaxed/simple;
	bh=Eb5E0pYKJE9+uwiSuxE809tvfnZmZGYmfsvdHhErOzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA4IVF0BKIk2dl68diBek7yIYCVpGw+bj2PhxOhh5UXfi1u4xOlGAY8N/vOPFFpqX3WX1V9tyvXdI6CDx+HSofTo9bbEh8Uzl6ShuY2W93LTJAZ5KmH3E7NsmK/F9AmbgWB2vavw4rvoYQWBxddK1NOkvZTzYnTXpzDMkXXkHWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4ADF92800B6CC;
	Wed, 17 Jul 2024 20:58:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3589931D14; Wed, 17 Jul 2024 20:58:30 +0200 (CEST)
Date: Wed, 17 Jul 2024 20:58:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ard Biesheuvel <ardb+git@google.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Kerem Karabay <kekrby@gmail.com>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Message-ID: <ZpgUVjjj3naBGtfO@wunner.de>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>

On Wed, Jul 17, 2024 at 04:35:15PM +0000, Aditya Garg wrote:
> For the Macs having a single GPU, in case a person uses an eGPU,
> they still need this apple-set-os quirk for hybrid graphics.

I don't quite follow.  You mean the integrated graphics are
disabled by EFI firmware if an eGPU is attached?

This sounds like a bug on Apple's part:  The panel can be switched
between integrated graphics and discrete graphics, but an external
display can't be switched between eGPU and iGPU.  Is the person
affected using the latest EFI firmware update from Apple?

We need more information before we can devise a way to solve the
issue:

- Exact model name
  (I'd be surprised if this affected pre-Haswell models)
- Full dmesg output with command line option "dump_apple_properties"
  (EFI drivers provide various properties for Thunderbolt-attached
  devices and graphics cards, those could be queried to recognize
  the situation causing the issue)
- Full lspci output with and without eGPU attached

Perhaps you can open a bug at bugzilla.kernel.org and attach the
files there.

Thanks,

Lukas

