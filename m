Return-Path: <linux-kernel+bounces-205006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9868FF614
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA931F2502C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C812AAE2;
	Thu,  6 Jun 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g9SwC3rq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCC6F06E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707136; cv=none; b=fysg9P0s7rCoRplfhSnbO7BKniC47/UdpqP5Q1UduH5jAmsErAhREFvvDI23x1dNM//UTrG6pNkRGUKXCe5kXWF3n/vboA88U61YisihXsBUlQ372ZyZUF4QmnZSRnf/ZzthXfukHRpChHi2VcjUZzlW5hmRi3pjb6GjbP6wBec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707136; c=relaxed/simple;
	bh=5kEsNwCt2ql6ZR2SAkgiWZeTmW+XVXqVDWe0gHRsY3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fbh0DkOTgXiGjFTfeJrqsDbAg4x1fOSJLUa5ruIwSfbIJb3FV+iKuuIMxDXPX+4j4l368HVIdeVFsTV2GeMXPSRv46aj+M82DM9crXciOX6llJIRQxBhVRGFsaOGa0OAHLqQ0qDoPn/E+WSuiY6+jRh5ensgNPym+/mZR3Z5bFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g9SwC3rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75291C2BD10;
	Thu,  6 Jun 2024 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717707135;
	bh=5kEsNwCt2ql6ZR2SAkgiWZeTmW+XVXqVDWe0gHRsY3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9SwC3rqwI+N3q7j1YJ/uQvAdqt6OKeUczyqk1ftAhxocDTqXZWT8hxGLVejbWeuS
	 JXlhdi/f3bWP4+jDDuWsuPmd6ztePICUtqqUjNaJiVB41La2SvkJup0c/KuWFo+DR6
	 FZJdI7IxGf8iA9ESj3cmd53q3jeIV+hRu6H/VUoQ=
Date: Thu, 6 Jun 2024 22:52:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Soumya Khasnis <soumya.khasnis@sony.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: Re: [PATCH v3] driver core: Add timeout for device shutdown
Message-ID: <2024060637-imposing-ahoy-b8bb@gregkh>
References: <20240606085003.GA118950@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085003.GA118950@sony.com>

On Thu, Jun 06, 2024 at 08:50:03AM +0000, Soumya Khasnis wrote:
> The device shutdown callbacks invoked during shutdown/reboot
> are prone to errors depending on the device state or mishandling
> by one or more driver. In order to prevent a device hang in such
> scenarios, we bail out after a timeout while dumping a meaningful
> call trace of the shutdown callback to kernel logs, which blocks
> the shutdown or reboot process.
> 
> Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
> Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
> ---
> Changes in v3:
>   -fix review comments

What ones?  In what way?  This really doesn't help, sorry.  Would you
like to see this type of response if you were to review other people's
code?

>   -updated commit message

In what way?

confused,

greg k-h

