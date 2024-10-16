Return-Path: <linux-kernel+bounces-367519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6B49A0354
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD5C1C28143
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32E51C878E;
	Wed, 16 Oct 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+snVq26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18373189F3F;
	Wed, 16 Oct 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065484; cv=none; b=R4FRpQcsqBMFPlfiwP/do2gt98EtnFu4Ab3/dcgyfXvvkS2ZjLJN1fU4gBwiYxn3t0HVfdwr+/BZROeVY4x/L6CWAdSWn2RaU2LUDGKOCKqErq0h5cVQg9+Ai0o6ldd8oN9bapBfHu5qN7PVQQnPBt9XxsYTmiQMp9yAsKQDjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065484; c=relaxed/simple;
	bh=1D2jsBeYDEAhVuG4OQw+QbvOsFJzQL4YBaU7YvW1GHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzLpyuM708TgIvZKLzDRhcwlHMNOH+Mcc7/7YbzaBK0IudiPZ65cPnfthQWOzItHq7MmM//ig5VV6yuz/Ny0eXdfUKZhxy9me0bNDb4jiKFMMILpkZrjNz4ExIjkxAcd3six0QW4kPuvpdCkGoxzlBIbhNOHFsZYhpBA2ODtdNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+snVq26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24899C4CEC5;
	Wed, 16 Oct 2024 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729065483;
	bh=1D2jsBeYDEAhVuG4OQw+QbvOsFJzQL4YBaU7YvW1GHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+snVq26ARb2XZCxOsH86Xwnsj6YuDX95yNLxpfOyQNlBh2/bTDq25uhnj07JGqMo
	 aHgy/AsZPsQmWtDA4goZJrcoGTnCi4NeCgrAfrGnOmJLZ5R542l2P8hXxtXO6ayqZd
	 12ovVnD+LxA4CRzOYYpcOivG763NrSWDiHbZvNy8=
Date: Wed, 16 Oct 2024 09:58:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v3 0/2] staging: staging: vchiq_arm: Two memory leak fixes
Message-ID: <2024101622-upgrade-grape-33c2@gregkh>
References: <20241014100624.104987-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014100624.104987-1-umang.jain@ideasonboard.com>

On Mon, Oct 14, 2024 at 03:36:22PM +0530, Umang Jain wrote:
> Two memory leaks were identified and this series addresses those leaks.
> 
> Changes in v3:
> - Add Fixes tag to 1/2 as well.
>   (Suggestion by Dan Carpenter)
> 
> changes in v2:
> - Split patches into two
> 
> v1:
> - https://lore.kernel.org/linux-staging/b176520b-5578-40b0-9d68-b1051810c5bb@gmx.net/T/#t
> 
> Umang Jain (2):
>   staging: vchiq_arm: Utilise devm_kzalloc() for allocation
>   staging: vchiq_arm: Utilize devm_kzalloc() for allocation

You have two commits with almost identical commit messages (one with a
spelling mistake.)  Please fix this up to have them be unique not in a
way with a misspelling :)

thanks,

greg k-h

