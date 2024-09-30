Return-Path: <linux-kernel+bounces-344629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EF598AC0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FEA28494B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984E198850;
	Mon, 30 Sep 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOC/QRdq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651FE192D82
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720859; cv=none; b=MkHT6E48Ewh4+wwIXpmzfK6pigoaiiGmRrWfq7m8n76xrO6linmYdKWsUdbu5wippAdaDaKR+TW40iaVNwpga5K3caDUuJbbrhhL0KwrigeG4v/C1k4TyVA10jeu4GdgyJtJP+3RDjAqw2zPcf6f+CvTfZ5ydHt116M4g8PvcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720859; c=relaxed/simple;
	bh=BmLGWGn8B8K6eUUho7FDLwcZfyJq7n3jumrcKTM0N3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onA/7+5kk/1+sFxhMrrwly6B1rvh8czTrEZD69ZB4FyTrU3jZDr+4+DgYyhISQzLe1GV2HoszCaEcVMcrgXAO8MXTEWIuRMRsO40XiXjZSvBGKeCOpJDWcksPf2SazNpP/zhcXOc8iG2WJUkIk45YFQkSYuNYZVrKGGiE8JCftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOC/QRdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E44C4CEC7;
	Mon, 30 Sep 2024 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727720859;
	bh=BmLGWGn8B8K6eUUho7FDLwcZfyJq7n3jumrcKTM0N3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WOC/QRdqU3bzIzboMu2Ve8Z7pzQMzOEkccPfF5hC8CZljoTlTm/kBjezQRKLJdipB
	 gqcIT5Q9fIn++L4CXqxojhy2b846tVg7Db+2Gi6oyP9UagyxTNjPTFjavasOCht/NU
	 7Q3OAwZj1RvV8fwMblTXhJrsp7970OsDvGDf3Gw8=
Date: Mon, 30 Sep 2024 20:27:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Jesse Zhang <Jesse.Zhang@amd.com>, Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: CVE-2024-46805: drm/amdgpu: fix the waring dereferencing hive
Message-ID: <2024093010-itunes-helper-82ef@gregkh>
References: <2024092709-CVE-2024-46805-b06a@gregkh>
 <fwxfulgwpt3f6hijwg6vh4ujrfq2lj3wvp4kq4sm2hbptmp6f7@7nybfmvb7ihr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fwxfulgwpt3f6hijwg6vh4ujrfq2lj3wvp4kq4sm2hbptmp6f7@7nybfmvb7ihr>

On Mon, Sep 30, 2024 at 08:17:16PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Fri, Sep 27, 2024 at 02:36:10PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > drm/amdgpu: fix the waring dereferencing hive
> > 
> > Check the amdgpu_hive_info *hive that maybe is NULL.
> 
> This "fix" introduces (or transforms) a CVE for panic_on_warn=1 users
> (if the NULL is reachable by unprivileged users).

That it does.

> The NULL ptr dereference thus needs a better fix (I checked in
> v6.12-rc1).

Please submit one for inclusion :)

thanks,

greg k-h

