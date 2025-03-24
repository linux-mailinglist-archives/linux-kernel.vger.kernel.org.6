Return-Path: <linux-kernel+bounces-574260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A0A6E2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C4C1674CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6E266F0E;
	Mon, 24 Mar 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X8Ew83Sz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513731FCFDC;
	Mon, 24 Mar 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842516; cv=none; b=JECVcrIfBkjJyr8Y1uHWcgjzLXa2yNFtbMs3RP+2/p4SMjT2XZiz/JQ0oE+Vi/Ge90gheC/2CqUxe0JSEycR6ISxUoXRh7ZUz+gBE3kpsX7M4nqWirn4UkJeBKJzaESQK2IfcozLVtHUtECdWaEGymBiNrUOi/kgOdu8eZpY4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842516; c=relaxed/simple;
	bh=Ido+D1vupMFkhDySXzExWK8AhohAHt+Te3ilKUpIInE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzaLG6FSOFQJe22aEtDD3QuLVLxqQ3iLM6lmEP4GWiT2KXh9WIQj7K4YbqdK8KTGC/KxQIEHV8pk1S6bNaash1+TbVbbcTlfZyH34PWqkILqvFxY/TmDT7MTT9ApRd0sm+5WLg6bnsgVOl4WmjNrLjQFbKIl0rmORZlAXApmaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8Ew83Sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F8FC4CEDD;
	Mon, 24 Mar 2025 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742842513;
	bh=Ido+D1vupMFkhDySXzExWK8AhohAHt+Te3ilKUpIInE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8Ew83SzTy6Pa6bSYj9kcDsjYRakrjcom15VTWxV8r66bBIWwOKegoki9xu1yTSuk
	 /lpkpkwuwlChLMMHuMvRITZBfdCHO1nzg8UyLHxBOahZgE9o8YwyLmxNlC1o6tHUw9
	 EfUKPwj2rUVD8iVkr2hu8p2PgB6uXTo9vG2nD0yU=
Date: Mon, 24 Mar 2025 11:53:51 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Cengiz Can <cengiz.can@canonical.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org,
	dutyrok@altlinux.org,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <2025032404-important-average-9346@gregkh>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
 <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>

On Mon, Mar 24, 2025 at 09:43:18PM +0300, Cengiz Can wrote:
> In the meantime, can we get this fix applied?

Please work with the filesystem maintainers to do so.

thanks,

greg k-h

