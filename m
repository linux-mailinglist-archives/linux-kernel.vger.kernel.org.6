Return-Path: <linux-kernel+bounces-211110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A0904D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3952284126
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DA16C852;
	Wed, 12 Jun 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Le9OGLXM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78C16C6A6;
	Wed, 12 Jun 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178958; cv=none; b=fdgv5aPkGfsTpiKuKqP7+UAvGVWXgmat1x3tGwwMglv+knyIylNvJcLNUer8higtgAEun/JthvCtLvw4/IwvhhEFilBpw1LvcQo28AdfHfhXgORCyadh5P3/0VggNwK6FKcGryAMiWv6XdUv3m04yQi9jo5srW7ZVHUiVL46wOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178958; c=relaxed/simple;
	bh=koUDz8yA59VHgrhxVw5Aln7jrfRO3G+aq01PNrLX2lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCrgbKBYxTq0tB/KW5t2UD12O79uOVmQnoQkETO9QonqLkFT3jWNHxX3Nc0o3TsEcQwQ+TLJwpCsUrFN6FPz4ut7x5DsvddxPEp4bA7+u1ftcFxv4cGNLrMmCiOI7qzYfOkfRKU7hsxUe1JSj3mvagbrn2u71YSyUq/l1ebwFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Le9OGLXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B683FC32786;
	Wed, 12 Jun 2024 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718178958;
	bh=koUDz8yA59VHgrhxVw5Aln7jrfRO3G+aq01PNrLX2lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Le9OGLXMvuvzQFHzOiOvnUyvsXffCBlGg8MW0TR5QvfJDX5JK1Xq2tUG5ZMUzqla8
	 oFmjArUNsZ9g7y21IZb0W9RnM46wQIJhDXwgqT2prUBzoTPgJvaGj629GJaSySwcpg
	 UG+uRJ7AbxeZZwMlTZ+r2cBfedOlUHAHFTDGcqv0=
Date: Wed, 12 Jun 2024 09:55:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Reka Norman <rekanorman@chromium.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] xhci: Apply XHCI_RESET_TO_DEFAULT quirk to TGL
Message-ID: <2024061241-powdery-pastrami-65ad@gregkh>
References: <20240612044759.3193928-1-rekanorman@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612044759.3193928-1-rekanorman@chromium.org>

On Wed, Jun 12, 2024 at 02:47:38PM +1000, Reka Norman wrote:
> TGL systems have the same issue as ADL, where a large boot firmware
> delay is seen if USB ports are left in U3 at shutdown. So apply the
> XHCI_RESET_TO_DEFAULT quirk to TGL as well.
> 
> The issue it fixes is a ~20s boot time delay when booting from S5. It
> affects TGL devices, and TGL support was added starting from v5.3.
> 
> Signed-off-by: Reka Norman <rekanorman@chromium.org>
> ---

Shouldn't this also have a cc: stable line on it?

thanks,

greg k-h

