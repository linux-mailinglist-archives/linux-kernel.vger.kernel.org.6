Return-Path: <linux-kernel+bounces-398374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4AF9BF07B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0801C235EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AC120127C;
	Wed,  6 Nov 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9dSy6QW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65F18BBBB;
	Wed,  6 Nov 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903830; cv=none; b=K9edOeFB20LKq48Mk9Ma+1YBAv8kBikdShjTOnGZGXPGNnjp5dYlXB4HrJkysReS6u0QmPhd4BK5F9ljYzCbjUI1OVbkKFe1Y1zFTnkB7vNnZh4lDxfMjm46qbSd9TQ/O0daYHuYisJ3gQbFKnVHLDew6qynGX3OFHyMOh/TBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903830; c=relaxed/simple;
	bh=+62y1ygdQsHlOvD9m8t+HDA1/rH9a4CtssEBamH87cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWfLOE+JeKmlTp2cgtZNeM197/fewAjXHDwg1whuTt4akje75PaFivSvgEDYoVq+NjqZDhXr1H/YZDLufOEJZmNUQOTd9CcdUnrAIrd5rOGEjEF3zXkaglvsh/NY6y+JAX7wcmhkp+LHenM45FPbuuY0IxiKfEQQ4g8XlR7rbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9dSy6QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F47C4CEC6;
	Wed,  6 Nov 2024 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730903829;
	bh=+62y1ygdQsHlOvD9m8t+HDA1/rH9a4CtssEBamH87cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9dSy6QW4g7WoJYraGZsEAzmgAmN8y5rzr5no0l2PYpEEzDF+LfP8j0W3E1Pa0R3S
	 E487HCtaEreE1d8opvtZ6D7tsCgRqWS3clR2CMAoE55cLggQAW4G7UEm4ncqol2UYi
	 0vbFFRwrs6iv1BqZyN++HuH0nHTqYcbPu62njpCzk/V87MpPQqT2HqaGQhsN+oBDnq
	 cJw48h7nlIf2VV5FePW8aiURj7jBCFVAt9TM5vBv3HMHGtqO3r6HELsTVsOruDwzEc
	 mBNdFqfMhXI3H+KsEwWHsjbc8ZXuInrC6i7ApzzG1vG3d19rozTTtTSz7mCC4fPgDm
	 fPYTjMeDNEadQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t8h9i-000000005iC-1PjM;
	Wed, 06 Nov 2024 15:37:11 +0100
Date: Wed, 6 Nov 2024 15:37:10 +0100
From: Johan Hovold <johan@kernel.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] fdti_sio: Fix atomicity violation in get_serial_info()
Message-ID: <Zyt_FvLvANrAA5ly@hovoldconsulting.com>
References: <20241106101809.17632-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106101809.17632-1-chenqiuji666@gmail.com>

On Wed, Nov 06, 2024 at 06:18:09PM +0800, Qiu-ji Chen wrote:
> Our static checker found a bug where set_serial_info() uses a mutex, but 
> get_serial_info() does not. Fortunately, the impact of this is relatively 
> minor. It doesn't cause a crash or any other serious issues. However, if a 
> race condition occurs between set_serial_info() and get_serial_info(), 
> there is a chance that the data returned by get_serial_info() will be 
> meaningless.

Perhaps "inconsistent" is a better word here.

> Similar issues have been submitted or confirmed: 
> https://lore.kernel.org/all/20241002125845.785464707@linuxfoundation.org/ 
> https://lore.kernel.org/all/20241106095819.15194-1-chenqiuji666@gmail.com/

This should go under the --- line so that it's not included in the git
logs.

> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> Fixes: 3ae36bed3a93 ("fdti_sio: switch to ->[sg]et_serial()")

And please use the expected patch prefix:

	USB: serial: ftdi_sio: ...

Johan

