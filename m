Return-Path: <linux-kernel+bounces-335251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC997E31B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DB1C20EF9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93D4535D4;
	Sun, 22 Sep 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CMQoBKX0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6A2B9B4;
	Sun, 22 Sep 2024 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727035754; cv=none; b=cO/08PO3grtNzgbaWWEKVNo77xphZ0mFB4qbghfqLoXyq5aQBZ57G0cDeYybDyiHZndc6LgwxWZ8IQDN0LKRxutS8isDN0O/RDcGDRx77WTSVItQTMlW4MB5QQLQVpJB9nKr2HOFR3gzOF2LI27sGuqu5bePP5CQLuihJROHn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727035754; c=relaxed/simple;
	bh=SS3jauSDhrqRWDR9up5YQ3qpObbPBj/jW/EE6FvRPdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVvvjbKPlBfpPQpCmgdMj1SyYcPTHvXIBbY3ePppcBDk4jgPJaWwCLX2Ho/9nj3rey+8MdtFkGwkKo9/BgL41nHkM6ZBxdKC1f8X/UoCvFdhYAOdRTEPWn1dn6LnEbDLk2Z3DdqYorPdhO1rqA7RFTtluhj3cabOlxaW3KVUkyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CMQoBKX0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A1cuQtqLLbryb2DoQJX2kyo1+PieA+BcFdbNxEWCQ4w=; b=CMQoBKX0/Hj4yiC1+wm/59n/T8
	HsK2CuN9Gz76R4oz5grpx6e0AzMbIM1dBX6MA2dnl3VQvvfMH1H5nOZGmVtitEuePuSNHRaTOzOPk
	FowF9cbRYritPafvVDHA7IpJCRsFwLtOY4iOJCdxZpw36cGrmPJ5ok/F/LhSIOiNLuyw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ssSt8-0084to-Bp; Sun, 22 Sep 2024 22:08:58 +0200
Date: Sun, 22 Sep 2024 22:08:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: net/ethernet/broadcom: Add error pointer check
 in bcmsysport.c
Message-ID: <13fbb6c3-661f-477a-b33b-99303cd11622@lunn.ch>
References: <20240922181739.50056-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922181739.50056-1-kdipendra88@gmail.com>

On Sun, Sep 22, 2024 at 06:17:37PM +0000, Dipendra Khadka wrote:
> Smatch reported following:
> '''
> drivers/net/ethernet/broadcom/bcmsysport.c:2343 bcm_sysport_map_queues() error: 'dp' dereferencing possible ERR_PTR()
> drivers/net/ethernet/broadcom/bcmsysport.c:2395 bcm_sysport_unmap_queues() error: 'dp' dereferencing possible ERR_PTR()
> '''
> 
> Adding error pointer check before dereferencing 'dp'.

This driver is not in staging, so your subject is wrong.

Please take a look at:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

