Return-Path: <linux-kernel+bounces-398367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C679E9BF05F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9831F2145C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1D1F9EB5;
	Wed,  6 Nov 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzfAdHFt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C41CC14B;
	Wed,  6 Nov 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903450; cv=none; b=ul/vNk4PHHiRk9uHTbiRP8ewAAWwnqGq6UZ1Tl6kiWuH7TdvqIY/13snBllrh528gkHXcW0luHdpv529uoydH5k/0AZk9UIRRgmqmp+1QCGwunrIiCpvkmqaHBUH49J3drLe1+U/7MtfCAx1Ugj2/cHgkWMkPqGwBktoGk+cRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903450; c=relaxed/simple;
	bh=n6K8US+dgiUl2jqiZqxsPy7aq61LHMhzpmauz2R5f2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg85DAnkaH42CCJfA0IPZUXy5Fr57J4mF8a8iqiHJYdYydadnfeNzDT1kyxPIidrzraIZee+ZSjgEzZ/vcZ1MeE3WMIW9NfUdWuVjLXm5cEi6IkFZFPSczJP5Nb1TcwkcC0tFw3QOW5HGnHXxpopR67hkC1opgJC6QBWmoZvjTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzfAdHFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1BCC4CECC;
	Wed,  6 Nov 2024 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730903450;
	bh=n6K8US+dgiUl2jqiZqxsPy7aq61LHMhzpmauz2R5f2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzfAdHFtZTdTeCXeIadJi25bnASD9CtX5EjaA6tB4FMLAf0qfIpIfeCt9mXOUBpFh
	 C+VSWGCjtNvV6+chSSjbjh/NkavmIdgE8IABQ8Ifbn5XzAaFrCli8p57Ho52H9ZlzM
	 kbNaSeIloz/O1J2xWzcvsQKznus9bjZwb42vFmlMJoOTYg5RK5ipeQHtvdAgfo9eyw
	 WP3riFy1BBL4rXSZcNfGXWnsVwG9Nv43210iZb0d9LsifxEdVkilX64hrkce0k6gR2
	 yzrH5Q5iW+9gMwLdFgINWKxjELEQr8X9fXqgbZN9nU28OtkMmreT1bvaUQi1/rDk9a
	 EvZ29xZ6Q1+bg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t8h3Z-000000005cC-29Ym;
	Wed, 06 Nov 2024 15:30:50 +0100
Date: Wed, 6 Nov 2024 15:30:49 +0100
From: Johan Hovold <johan@kernel.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dtwlin@gmail.com, elder@kernel.org, gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH v2] greybus/uart: Fix atomicity violation in
 get_serial_info()
Message-ID: <Zyt9mf-6hNYWyNhJ@hovoldconsulting.com>
References: <20241106095819.15194-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106095819.15194-1-chenqiuji666@gmail.com>

On Wed, Nov 06, 2024 at 05:58:19PM +0800, Qiu-ji Chen wrote:
> Our static checker found a bug where set_serial_info() uses a mutex, but 
> get_serial_info() does not. Fortunately, the impact of this is relatively 
> minor. It doesn't cause a crash or any other serious issues. However, if a 
> race condition occurs between set_serial_info() and get_serial_info(), 
> there is a chance that the data returned by get_serial_info() will be 
> meaningless.
> 
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")
> ---
> V2:
> Modified the patch description to make it more concise and easier to understand.
> Changed the fix code to ensure the logic is correct.
> Thanks to Johan Hovold and Dan Carpenter for helpful suggestion.

Much better, thanks.

But please try to use the same patch prefix as previous patches for the
driver you're modifying (e.g. by looking at git log --oneline for the
driver in question).

In this case it should have been:

	staging: greybus: uart: fix ...

so that it's clear where this patch should be applied.

Care to fix that up in a v3?

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

