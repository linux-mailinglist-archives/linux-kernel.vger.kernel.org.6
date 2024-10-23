Return-Path: <linux-kernel+bounces-378771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3159AD54A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 025A4B221AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFC71A7275;
	Wed, 23 Oct 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aKP/WK56"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897A155C83
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713818; cv=none; b=ZEwv4BBQg7H5eaIveFlqxpiv0/BMWmMM59OlQFIAi3rQvDUpRNfoHT7dbF9YNO9IINayA6/lviUaQ3uHHEY0P6MtNDqOoGJ76tt25g18CRSXN1QED7SzyyUEu5taGaCDawKt70dxehdyHdLoaKcUopfhCaN+A7aOowyqXTkm0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713818; c=relaxed/simple;
	bh=VBDanb7OMdatnkzxy7Qs3RTeAVzimuhmctj9W6sDdok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCl8o0wt5jVI/gCRaX9bditJ4SvkN+xXwElU301c76zqwp6MNKQTCvVnAaqtD+7Hr4KewwOAxl9M1pK4hMJMdsYFhZjydkkfBNj/EowmejuYxeBFDEvKTT56Al/cPLYDClM2t9XjyzvLoRuNhTR8GZJefsn1MIChr2NA9pwuAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aKP/WK56; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729713814;
	bh=VBDanb7OMdatnkzxy7Qs3RTeAVzimuhmctj9W6sDdok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKP/WK56AJbx5HswfCMWgfA1YMZcWt0PEkVk7gzy0V8Dq10CJ3bfGeDPxfUjud6FP
	 DXdov4M3Vid47/YFEcSPwNd+LASh+qxIftx5ZWSbUz2+hIaL5zC1g4YX2fqvnylk2P
	 3OLy0TU+cYn1IS11ZOL4WPkcCOwN7ZQb63TkY+YtaNHGgdaxpXtUrOMI1hPkmZqbHb
	 FM+0xRyNkdByDP+Udac+6eDDk62RaqKKkX1+JCJvQ4HkuPHFVC54HbgF6mohZ7oE9u
	 c9unLo2+URL+70U8PWocVqrrfNfMU3Qt3a0472dxV8RXtRwO5InBZ0dJU0iyrYKuQC
	 UZ7OBosh/UCmQ==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AFA8117E3705;
	Wed, 23 Oct 2024 22:03:33 +0200 (CEST)
Date: Wed, 23 Oct 2024 16:03:30 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 0/2] driver core: Avoid false-positive errors for
 intentionally skipped links
Message-ID: <5302c079-864f-4eae-a0ad-406533a0e298@notapiano>
References: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>

On Tue, Oct 15, 2024 at 05:27:16PM -0400, Nícolas F. R. A. Prado wrote:
> This series gets rid of the false-positive errors printed when device
> links are intentionally skipped. Patch 1 commonizes the logic into a
> helper and patch 2 uses that to remove the error.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Added patch 1 introducing the device_link_is_useless() helper and used
>   that in patch 2
> - Link to v1: https://lore.kernel.org/r/20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com
> 
> ---
> Nícolas F. R. A. Prado (2):
>       driver core: Create device_link_is_useless() helper
>       driver core: Don't log intentional skip of device link creation as error

NACK. It turned out these were real issues, for which fixes have now been
sent: https://lore.kernel.org/all/20241023191339.1491282-1-saravanak@google.com
So let's keep the error log message around since it is useful to detect such
issues.

Thanks,
Nícolas

