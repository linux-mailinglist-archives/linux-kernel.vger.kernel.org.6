Return-Path: <linux-kernel+bounces-287781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B58E952C84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6F41C239F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351631D0DD2;
	Thu, 15 Aug 2024 10:07:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCE1B4C44
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716462; cv=none; b=pr8VFgmAyitEpLdlkfSyk9xFAMdqnUtgLCQ0kaKmci/dePVcj+waBHtgF9IWhGiVYONNlWzayoGMu5sG5xqTKpwM2cuHZNGN+O4bESMqJs38Ucux/jsFftWcF67ItzYlqboOFMu9gEYkzk6XfCOuyPlHRCKGASBAkNoGuYfIs7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716462; c=relaxed/simple;
	bh=FIts8/Ff/hUOY371dqkdNvZ+cRYnDZS738vVNq8ASmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLl/mDj1k5yFy4zto3gPAlYiVXtzG/+dm1QZ9SsmY9BUDQEvkaKvg8qE0aVaD5Wp2I2rkyAZFKuCmuZOa8p2SY2JohJISlCeHd9QY8+tg4376CQJ2U40sofrIw/Zjd6D/C7k09lpI3P65UQf/gwGFY2nQgUW0P0CUeu15SvGKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6034FC32786;
	Thu, 15 Aug 2024 10:07:39 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Shaoqin Huang <shahuang@redhat.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Fix KASAN random tag seed initialization
Date: Thu, 15 Aug 2024 11:07:36 +0100
Message-Id: <172371633726.361921.8377586123195957148.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814091005.969756-1-samuel.holland@sifive.com>
References: <20240814091005.969756-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Aug 2024 02:09:53 -0700, Samuel Holland wrote:
> Currently, kasan_init_sw_tags() is called before setup_per_cpu_areas(),
> so per_cpu(prng_state, cpu) accesses the same address regardless of the
> value of "cpu", and the same seed value gets copied to the percpu area
> for every CPU. Fix this by moving the call to smp_prepare_boot_cpu(),
> which is the first architecture hook after setup_per_cpu_areas().
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Fix KASAN random tag seed initialization
      https://git.kernel.org/arm64/c/f75c235565f9

-- 
Catalin


