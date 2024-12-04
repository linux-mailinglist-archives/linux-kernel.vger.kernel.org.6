Return-Path: <linux-kernel+bounces-431543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7227F9E4013
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DAFB308FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271720C479;
	Wed,  4 Dec 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGRNeuBX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331320A5FC;
	Wed,  4 Dec 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327579; cv=none; b=IUhgeF6MMLAw64INKLxOro4k9vBvMDUdFb2DIUGOE/8eKnzKdqRvopgTgTbn3uZ/Z7VcMJZCcWrzBnAIH4zGNvOY6FURSAjMSX5BJlVuBBJmbYPg+WasKauX2a7xYR5nel339aDuMarsbe9dZV47W4z5wdOQNwQCUQezqmloEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327579; c=relaxed/simple;
	bh=rYzR5iA+832IYD8XZPdYk8GIWIBb77RihMzScqCDuaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvNmDsM6s7P7daFy0+ZKww1XOhBbBbLsX6pQ3cNY2hWvldFxL2WzXYVntcK8R5RaKAyth36ldhlhHwE+zZ+IZ1VleDeBchd/3mC5Vu8wUi5/mO7KjOUW2/rP9qlm4qPbFsdb8t8VK3aFzYZ+fBc7fIhTPqtyEBRfJ4zJIp9VXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGRNeuBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B39C4CECD;
	Wed,  4 Dec 2024 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733327578;
	bh=rYzR5iA+832IYD8XZPdYk8GIWIBb77RihMzScqCDuaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGRNeuBX1xoK7+XlzIIlDBekaNTlJWcaAna5prPVsOWmcxqdtUXoE2cZXLddb+QRI
	 cg7NSc2oePjWV6KyasUlxY3aA5YLc7Dqbqf2pg3k4hDL1HrMVEw5Y/kFL2Ue5/qe81
	 kQ7ijrev66JoVu2hDAll6K4Sg8OvxhDAg+/7dulI=
Date: Wed, 4 Dec 2024 16:52:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: philipp.g.hortmann@gmail.com, ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix broken code when cflag is used
Message-ID: <2024120426-shininess-scorpion-cc26@gregkh>
References: <20241125225308.8702-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125225308.8702-1-rodrigo.gobbi.7@gmail.com>

On Mon, Nov 25, 2024 at 07:45:04PM -0300, Rodrigo Gobbi wrote:
> When using an extra cflag, DBG_RX_SIGNAL_DISPLAY_RAW_DATA,
> hal_com.c file doesn't compile.
> 
> Fixes: ec57f8641fbc ("staging: rtl8723bs: Rework 'struct _ODM_Phy_Status_Info_' coding style.")
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> As noticed at [1], hal_com.c is not compiling with -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA due
> the changes at [2] (a few statements were not replaced with the new struct).
> A little discussion was made at [1] too about how useful this cflag was or if
> the code under the cflag should be deleted. I think there is no harm to keep those things 
> as is since we can easily fix the error and someone might be interested in using that
> to further debug the driver.

Let's just delete that flag entirely, no one builds in-kernel modules
with different cflags.  Please just remove the code completly.

thanks,

greg k-h

