Return-Path: <linux-kernel+bounces-268665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C494278A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA12B2454C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC8D1A4F16;
	Wed, 31 Jul 2024 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wujbfw0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2B1A4B4E;
	Wed, 31 Jul 2024 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409734; cv=none; b=drPnK2NO9ClzXCM4v4+X8jo0EfW4p7kLxt5TfqELOQTg3lxKV0ZuteVadEXp62Brj/ynuu6QTWRxoOcBqyf2uXufo+SqVRg0dLmxokRLaPMq5aVyU4hR5WkScTr3b2kq7buo9jS5FoO0H6JsrcB8AJ1WoD8QCiGejnVsQxXb//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409734; c=relaxed/simple;
	bh=2MX7GHrNYF5W+EsUv+5JVXvYh4j11z3ERZSW2hX9cw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeonUwFeGQiwN+isjdf9/IL5bChNxfhkuVWSbygbj5haEpACZtrd4j4jernpXtejq55Zil0AEy5SvLMJH1I3Ex7rAEHXZhW1T9f4SnKRbjDiqSdWXBUbOjld3Sde6cgWaWeKadmxAqSmnzjZNX++ZNwh29uyPkLQyxq0drPuLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wujbfw0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EA4C4AF0B;
	Wed, 31 Jul 2024 07:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722409733;
	bh=2MX7GHrNYF5W+EsUv+5JVXvYh4j11z3ERZSW2hX9cw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wujbfw0/9Pm9LtY5beVc3KzuOQ3Doql+C7juuV+tlR92dGsiP1j0S2CrDVubXXJ7Q
	 YG86+R62JN7f5UTnyIXE0gAvLUxNYZyttv+ITnbBAzN3al3iD4QUXcSDQyqZa3BZno
	 JdPkynZgf1v2IHrj2RXpqpTgOMwdhTcNhQZlz0gXkG53aVWC9itfYPxc7dOmsgLork
	 ZMDrhAIvbxi0G6eJoEiRbQH3aQD4DNFgV79ae/VW2+eAmAkxSloeGuKai8LpfkS+Um
	 uEFM24CKSiRiSEVFLjLTJwmZXmYbJ1M/oLMfBbC3yBsFVzNkg8C8B0PzydbXvJLv0/
	 MJFpFOmHZgTyw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sZ3SJ-00000000474-3ukw;
	Wed, 31 Jul 2024 09:09:03 +0200
Date: Wed, 31 Jul 2024 09:09:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] USB: store owner from modules with
 usb_serial_register_drivers()
Message-ID: <ZqnjD9cLJ6WlwAMq@hovoldconsulting.com>
References: <20240503-module-owner-usb-serial-v2-0-7887769dbeff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-module-owner-usb-serial-v2-0-7887769dbeff@linaro.org>

On Fri, May 03, 2024 at 12:10:51PM +0200, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Squash .owner removalr patches into one (Johan)
> - Drop owner from f81534 driver
> - kerneldoc "module/owner" -> module (Johan)
> - Fix amba->usb copypasta
> - Link to v1: https://lore.kernel.org/r/20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org
> 
> Description
> ===========
> Modules registering driver with usb_serial_register_drivers() might
> forget to set .owner field.
> 
> Solve the problem by moving this task away from the drivers to the core
> USB code, just like we did for platform_driver in commit
> 9447057eaff8 ("platform_device: use a macro instead of
> platform_driver_register").

> Krzysztof Kozlowski (2):
>       USB: serial: store owner from modules with usb_serial_register_drivers()
>       USB: serial: drop driver owner initialization

Sorry about the delay. Now applied.

Johan

