Return-Path: <linux-kernel+bounces-344039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0698A34B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3ACD1F241F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C61E19005E;
	Mon, 30 Sep 2024 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9+ONkiv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B744D18E351;
	Mon, 30 Sep 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699995; cv=none; b=hO3zG9zx8gplrhz5E6t2hZjh+IoYlBVuf6grIRxKnhXGTyoxsBH1jaoquGzksWYQtnnn4Or8XIJqBHPHFLv5A/DNnjshykIJGJqoqnoaDz0FcG55ShuVECKXKR21GDi7az4GhBmSEYqyCoOT9ql9lDacaCXW+7toxBd/+knfl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699995; c=relaxed/simple;
	bh=kAVtAOO6pbXEe0U9LbI4ZPQxLHXljXirrFbrLGE2m5k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o3N4YSPUfEzyhD+KyZDwtxaiB1YxTZZzQz25GqmL3w+PCpBnkVgnJar/Zf9TuIaNJqt039FdybV2c6PJrO8pjSRVgpDfwwWlBhud25A+Tl6lEd3/D1c29MaZvW/wwR11ovcPFBKFDiNcBuAtnatA55HrRPQ4zibYa6sHMFMOnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9+ONkiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DCEC4CEC7;
	Mon, 30 Sep 2024 12:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727699995;
	bh=kAVtAOO6pbXEe0U9LbI4ZPQxLHXljXirrFbrLGE2m5k=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=P9+ONkivtD4dtqN54aIMYRcRA9Xf15l641k5jcXr3M2qGlqAOVtG0e7WFssGMFBwk
	 GUXRgBcM3WGTHDZos1HTRPeiIA/KCdAGz7aN3Je6T/p76IsUUHx7zIgporr5hf+NVL
	 6LvaCQYTDX/Y4CK4peCGyaqAfKSyioBSsxhTCsStUZuHtY9cXbYhVCsFkewpVdGKf5
	 j/SlFljXYLYK+g3fNgQGcRIpJ/y9IWuIiVySatEvK81oEZfUDREDC3phBvoB97PgRt
	 AR68ol9VjydHDuijK9o4IFFmU6mXIUvdSKffsif4XPTXrJ6DnVjMpsXuW9Gi6hwKyK
	 LJqKmhChCj/HA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
 deller@gmx.de, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240822062546.3490076-1-ruanjinjie@huawei.com>
References: <20240822062546.3490076-1-ruanjinjie@huawei.com>
Subject: Re: (subset) [PATCH -next] backlight: 88pm860x_bl: Simplify with
 scoped for each OF child loop
Message-Id: <172769999349.449795.6539745050608375081.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 13:39:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 22 Aug 2024 14:25:46 +0800, Jinjie Ruan wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> 

Applied, thanks!

[1/1] backlight: 88pm860x_bl: Simplify with scoped for each OF child loop
      commit: 3db60398b4c10425dd32c076280af7f334431064

--
Lee Jones [李琼斯]


