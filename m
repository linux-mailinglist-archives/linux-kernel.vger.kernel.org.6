Return-Path: <linux-kernel+bounces-267447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1394119A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0CF28388D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404219E7CF;
	Tue, 30 Jul 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6lYkDBz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584AD86AEE;
	Tue, 30 Jul 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341547; cv=none; b=G4SIQXmrVR5gg8XJIWFH/PTgIyRLWn9PS+CFa5QYdaQKK/5GFgP4c5s6zXiJ+SCdhIGrVn5llx224SIdOPQZH4AeWaXom8/OZ/4BH2SagvxiIeK7V/WeiYK8YCSgSEWBd++b7KS5aYLL3kHivQ0UPdWZF/kTl308dkyjRlR4ZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341547; c=relaxed/simple;
	bh=x/kA2azEY26yQi/r+70B97uEul/VAE7ubKYeBvgSo8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVUGoC9rByPUQ1UkQPh9FRiMJUnl6BkmkYFa1m735yr62AwPwNQ2aefHIJjXahi8WZ2LY0pwg/sWzNRH7r/ZB6pZxEjpz90rAego+sOeV9V6LZv7yaE+HdbKT+t2D055U4naqQ2QY7F170SHTxn/saE3q1f6YML9siBeoiuFZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6lYkDBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3657C32782;
	Tue, 30 Jul 2024 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722341546;
	bh=x/kA2azEY26yQi/r+70B97uEul/VAE7ubKYeBvgSo8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6lYkDBzvjM4BOfSrT+9Go3zRnjUrbFeaXh+cxKv1xIZ0cy8RoAxKZiRCyGkzZ9Jl
	 i/LGNQEJKjToDQqQW++kGBLUhEw43aZSvTiqjXYeCehPOFdwV/mmOb0FdXTwBZ24SO
	 DWRoDlPk3GNu224WvgFy01WMg/ma+y0MxXA6DKt3nHa+fx9DETigA1xfxJVhJaasl4
	 pYQfSEaCM0IZ6zZf8OnENW/y54CrbxxOAld+BH6RdNIeh91eeZAUpJdI48AovCuyn4
	 3zWkk07MKGJiXie0Yk5Jv4EyNXwk/WCt5s0iXRvni9xKfCnmoKgL3KLhJAWTwZqv2d
	 eXy7E0JVDZEVg==
Date: Tue, 30 Jul 2024 20:12:23 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Patryk Duda <patrykd@google.com>
Cc: Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	chromeos-krk-upstreaming@google.com
Subject: Re: [PATCH v3] platform/chrome: cros_ec_proto: Lock device when
 updating MKBP version
Message-ID: <ZqjYp-tnBUf6ealU@tzungbi-laptop>
References: <20240730104425.607083-1-patrykd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730104425.607083-1-patrykd@google.com>

On Tue, Jul 30, 2024 at 10:44:25AM +0000, Patryk Duda wrote:
> The cros_ec_get_host_command_version_mask() function requires that the
> caller must have ec_dev->lock mutex before calling it. This requirement
> was not met and as a result it was possible that two commands were sent
> to the device at the same time.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git chrome-platform-6.11

Thanks!

[1/1] platform/chrome: cros_ec_proto: Lock device when updating MKBP version
      commit: df615907f1bf907260af01ccb904d0e9304b5278

