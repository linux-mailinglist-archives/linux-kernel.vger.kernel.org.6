Return-Path: <linux-kernel+bounces-426388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD059DF276
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9BBB217C6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861831A76C8;
	Sat, 30 Nov 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BypsfC8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5443AA1;
	Sat, 30 Nov 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989950; cv=none; b=mn+XbDzh3qpGT4VLQiM33t6iPojOvNlh4RKXqJ0XTUo9Q0YALRu761th9aCvOo/jkx+tCHPacAnp2FRzEcw/QzKd1nLiEbwyj3XsigdTJQ95jM61gg7pubJObYM5fFpRtLBeSkSp+ivLYcvTqerEcsnurYX4csnAqSEdcL6A/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989950; c=relaxed/simple;
	bh=Q1Sw22tbMXQQl6XnZs/j5wZ1G6acARdACw70BcfQ8dY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=os2t4ltIHcEmZB+wbfaAdId94k/sVabe9WhdxdQ179yMn0RXVrb5GGRYjKjGmrK0U9a70iv0Mbrw5vW6UOi8UBnccxWIiq7m89lk7UTjizrIu4uYb0FOMkmsdTFdZfI+Lw6O1YNYutyuqnfYwhd2mTLKC7JsCCX8Ua7nc4vTg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BypsfC8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37237C4CECC;
	Sat, 30 Nov 2024 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732989949;
	bh=Q1Sw22tbMXQQl6XnZs/j5wZ1G6acARdACw70BcfQ8dY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BypsfC8DIMjfzUoDssT98GTM1EfavZHV3C94ycFs6jNzRcbUYGcPd2fMw9n0aK+vb
	 MbSH+RSVHUG5O3vD44Zwyojywr0opSQRcsdjvmDzkskkyw3kkQAxf4woT9hByGXhlA
	 gMsdjnHxxzgOWm0RyJlYyzIVlu3qlN+soQdpk+0OIB0G8jwWeSAHCOQKPGxmzP7TZi
	 5C8qm72oOFS/sRnVNaaytSzPSbkd9j+OH5OfMSd9jY76/gMq5et2Gv5vKGcnqBgl5w
	 RYzNIZej0Axs85rXICaqHpUOOR9Qk6nsc0GsiPhKcd7nvvl2aCR1ezh542DCfOPWYS
	 LnnqG12fP6pEA==
Date: Sat, 30 Nov 2024 18:05:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iio: accel: kx022a: Use cleanup.h helpers
Message-ID: <20241130180541.5737b368@jic23-huawei>
In-Reply-To: <4785f841ad5f131356ba78b4f3c76f676d86a2e8.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
	<4785f841ad5f131356ba78b4f3c76f676d86a2e8.1732783834.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 11:01:48 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> A few functions in KX022A need to use mutex for protecting the
> enabling/disabling of the measurement while configurations are being
> made. Some of the functions can be slightly simplified by using the
> __cleanup based scoped mutexes, which allows dropping the goto based
> unlocking at error path.
> 
> Simplify error paths using guard(mutex).
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied this patch to the testing branch of iio.git.
I'll rebase on rc1 in a couple of days before pushing out as togreg.

Thanks,

Jonathan

