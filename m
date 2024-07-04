Return-Path: <linux-kernel+bounces-240852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05549273AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530871F276E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA41AB909;
	Thu,  4 Jul 2024 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bR+o6uEm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959571AAE30
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087671; cv=none; b=hkYdZGmkiSFkTTg0CPQw9KugsUi/Eij7bxBUfm8ny0w4el/JYbpK3FTfUNMPF/YULafjWMnWIdxoml0ZfSVtYccbfi4AGsUuqS3Epp2IHrFzYdAnObEmUfIUrtiIviOri8GFc0Zgz5MSz8Z/r2fndttVg9l0deuP8evCb8Bn8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087671; c=relaxed/simple;
	bh=vLLD9LStezIyvooTMxotMgJ/Ciiv2crq+kgdVIIA2RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0oSfliRn5NHqlzpxf4lP1o/Y6LAy6uL6G5xfZOloMNO0J2PwtUP2FpMrm6ZoWWVSND4sBHNM+1RkTLs9/PR+xtkxeXrMKhSyy/hsBXly+HxX0oK2/rOSoev/G90edK81DxNKzcO+zlrLivw77iESqbq4WbCugVAEPnpRvoVNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bR+o6uEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A23C3277B;
	Thu,  4 Jul 2024 10:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720087671;
	bh=vLLD9LStezIyvooTMxotMgJ/Ciiv2crq+kgdVIIA2RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bR+o6uEmRrRkzThDDecdaxhgBtbIQCXCH1pKCrKZnGpbZVQDpI/Y+asuzXoCPZ76x
	 qzS3IrUotT955BkJ1qZETwm+TM1gDSaI7qUQTPnlIfYFe3AwqIiKy7tDQKf1jUWU9a
	 w7j0UBPmMPjYFaa1kSIMfSAC6Fen3i69ad6yQYck=
Date: Thu, 4 Jul 2024 12:07:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: tuhaowen <tuhaowen@uniontech.com>
Cc: sudipm.mukherjee@gmail.com, alexander.deucher@amd.com,
	linux-kernel@vger.kernel.org, huangbibo@uniontech.com,
	wangyuli@uniontech.com
Subject: Re: [PATCH] dev/parport: fix the array out-of-bounds risk
Message-ID: <2024070413-obsessive-stack-7c62@gregkh>
References: <20240626021136.12282-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626021136.12282-1-tuhaowen@uniontech.com>

On Wed, Jun 26, 2024 at 10:11:36AM +0800, tuhaowen wrote:
> The array buffer size is 20 bytes.
> When executing code in a 64-bit CPU environment, up to 42 bytes of
> data will be written into this array
> (the size of "%lu\t%lu\n" is 20 + 1 + 20 + 1).
> 
> In fact, this line of code for 32-bit CPUs also has the risk of
> crossing the boundary, but it can exceed 2 bytes at most. With good
> luck, it is local variables that are damaged, and there are no serious
> consequences.

Usually because no one actually has this hardware anymore :)

Can you also properly test the buffer size when writing into it so that
even if the math is incorrect, it will not overflow?

thanks,

greg k-h

