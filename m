Return-Path: <linux-kernel+bounces-383126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F99B1795
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FC71F22265
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C031D416E;
	Sat, 26 Oct 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJJkX48s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911451D2715;
	Sat, 26 Oct 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943369; cv=none; b=pAJSiNWiS88E//sM/w6OSC0AS/XlvMcLgUH0FVHd4/JNcNeM4rA2IVXs6YLtIhKLdbcE6Sc9QWlmpcclsCbNqVRVenYypZm3KtGrEJjVR/15UgQywAXuictSWTEcU1YJfJVDma87MTfObdSVKyxiB5ZwiqXTCv06aIIGIUFkM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943369; c=relaxed/simple;
	bh=zhfHXolqQeemu1UCSxQeuPxbsv6uvPgF9dhlVwISxh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4MCl4IXxF0TinOK1L8Jo4pawFyh2yShUrmqVlil+6xf4e48djuuZSCvAPOrv30C3qXC8xYiApVUe77DxlDUJahiKmMDizzzxnJ2QBtCNu5llPvZ4Tac2fBvwXJaILb6/MyhUiUFsLALNGSKS4lxa9hvHVNtdWDnYy3/TjCzwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJJkX48s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D562C4CEC6;
	Sat, 26 Oct 2024 11:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729943367;
	bh=zhfHXolqQeemu1UCSxQeuPxbsv6uvPgF9dhlVwISxh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJJkX48sPEqjnCAz5UFFSDhGumXoZIFJ/5gA0DeuChQUDv/kFw2dONqw4dnm8xBZn
	 aLhfmUJD9CwTEofUADeVsVJF7YpGWJJOMqgEwNVhuwR6FugE7xbj2QqKWUqanYtjHv
	 5KXGKlAsxLJ0JVRmmNiODIxxAdeETuqhYel6tygZClDC6EiZlhIVKnKPsLUjE8/A/b
	 9B0Nv9qf+x+BDZvLRsmEu6ghncEwtj5IQYAWs3U/Ku8kg6RLJNGPO4FYlcTL/Ay86g
	 LmM1DRYidVhG2UQBieeJLakL0xU7npnTRFkKx8uEAVR96FQXkp6jaKzRi6trYh3omD
	 yOsYLe1vG1YZQ==
Date: Sat, 26 Oct 2024 12:48:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 19/24] iio: gyro: bmg160: Replace custom
 implementation of iio_get_acpi_device_name()
Message-ID: <20241026124848.25a19718@jic23-huawei>
In-Reply-To: <20241024191200.229894-20-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-20-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:08 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> IIO core (ACPI part) provides a generic helper that may be used in
> the driver. Replace custom implementation of iio_get_acpi_device_name().
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

