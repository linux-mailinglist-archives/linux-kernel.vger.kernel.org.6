Return-Path: <linux-kernel+bounces-288275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF69D953838
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03911C22105
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA70C1B9B54;
	Thu, 15 Aug 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceyzQjwe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B371B8E9F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739285; cv=none; b=sUoBYO3gT0+H5E2WJgt9Bei2BHk1frgiQghWKRn3OQq4mxNmNNtg1I0YI8jaM/rNmLJy18162IIZAkY3HRuknEGnppYjlc9RQ1Ls+4AsevpgibRp5IZRD8ySgLEEkD4OtDmGnGA5rAh3DOfr3H25wcE97Y1AkWUF3puue4Cx/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739285; c=relaxed/simple;
	bh=4GV2JZf0HaAOTym5eMdB4gSNgiVQQ7jXwuqGk+Eru2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWCJZdZDTIw6gES+lmMX6Nj7E/qJdZSrMIxTurdfgGt11GR9HtsAdpNR1JSIGjDC9EWYowj7Y5VkMjhkrX7D6MAbo8VIRMN8Ty8y3lBMqXrAkPvLP/m0EYqBcLI88VgaJPI28cF7xxn+eB8QgO/RWA+dObKDuRpWqYBegvwFD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceyzQjwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5215C4AF17;
	Thu, 15 Aug 2024 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723739285;
	bh=4GV2JZf0HaAOTym5eMdB4gSNgiVQQ7jXwuqGk+Eru2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceyzQjwehFmD5WDfNhTqj7qmjqpE2F3PlACjd3/tkja2BEf0N0neA1pzJCuEaqIV2
	 Dz341/zzUH62BOfR4ilzuCjxtcqP0p/icM8M5+6F4MVd9COHK4LEEE9B3u4eKg5cUH
	 c37zGTHs179qSUTyvK8avUhKvhlImuXoc17ciPNmhGTjPV0qNGBNhYDaa81ewQ97NY
	 VNmOaSKqqybEfcCIhHG0ey/0CG981GXNDoCBwcHFzgwUy/HQL024DlunVfL/0TjZ/s
	 U3C0yYMKoPHW2Axcj8vGvXKv/Qz7FFYTtm/G2ZcgjHdW3wtTQgqktK5s0UMVfjFPxS
	 7H0ctdWLMt9CA==
From: Kees Cook <kees@kernel.org>
To: akpm@linux-foundation.org,
	davidgow@google.com,
	Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	erhard_f@mailbox.org
Subject: Re: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
Date: Thu, 15 Aug 2024 09:28:02 -0700
Message-Id: <172373928009.559695.8528767427266408069.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
References: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 01:04:31 +0100, Ivan Orlov wrote:
> The 'device_name' array doesn't exist out of the
> 'overflow_allocation_test' function scope. However, it is being used as
> a driver name when calling 'kunit_driver_create' from
> 'kunit_device_register'. It produces the kernel panic with KASAN
> enabled.
> 
> Since this variable is used in one place only, remove it and pass the
> device name into kunit_device_register directly as an ascii string.
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] kunit/overflow: Fix UB in overflow_allocation_test
      https://git.kernel.org/kees/c/92e9bac18124

Take care,

-- 
Kees Cook


