Return-Path: <linux-kernel+bounces-249316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 560B092E9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB461F23149
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8415FCEB;
	Thu, 11 Jul 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ6nBu0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75715F40D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705771; cv=none; b=J02Hccn7k+4RHy1IWdCJFtiBX4HlCLuuhKHTMh4rYMNLxOdL9bv9X9FH/3Ue7cS5Ndj7sYow3nWStINya4hs3QMlsZvAVEEOsNny006g/Xgu8TiCRVTn7FpUq4oSAtPqWoMGH9Qkmw13jt6hfl6+o8dq718mqw4HoKtYHzSelH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705771; c=relaxed/simple;
	bh=81S5KcgENsWZs22Mkf32vSoMGhT4YlUQsyv3AXIX+XQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ce9VjHmuR6AjZz3qe4rSFuqP5IuTLpuZRlDmWxoHQvmwhZTw18nXMWB+M+ag6sSNS8saZxKGY59YwIBz1+J4RH6YIKXdbKxXbrII4oMBqf6Fy9KBSwMWqpMv0EAo1zvoIW/La9P6TFVr0FWg5qheSMSFPjrqt7LS5j+MInYjzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ6nBu0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99796C4AF0C;
	Thu, 11 Jul 2024 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720705770;
	bh=81S5KcgENsWZs22Mkf32vSoMGhT4YlUQsyv3AXIX+XQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VZ6nBu0pvtT13GZtf/ofPyWOV6HsDTRrbC5EXuNqan5kuJtJIXHeel+MPXmHo0ac9
	 BuHPOaKCYa1eU5FOoO/xCFBxeMwNNObWyWpQqGfuHwMVxGNUlOOVhETNo5PeqvxXwv
	 I82v3aKisXUE08BaL0zxgmE66WOoo1aHQ3yj7qJoyq2g7IL3fiCa8foICNxydYwnZJ
	 kWd+Nn7nWuiXbhQnJ3jbS6pKO2yONOsvU/YoSSzmoWBUlZc3yhDZ0nAC0V2ecgMY9l
	 YruXP3nhYTHP4qqmul5wQhVAkVFgUyVAHgTb8r8rfqAtg9geJGTggKUmknPPTp5BIb
	 qnQmuKRkfrD5w==
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240711055352.3411807-1-linux@roeck-us.net>
References: <20240711055352.3411807-1-linux@roeck-us.net>
Subject: Re: [PATCH] regmap: kunit: Add test cases for
 regmap_multi_reg_(read,write}()
Message-Id: <172070576932.33675.15532798097685737806.b4-ty@kernel.org>
Date: Thu, 11 Jul 2024 14:49:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 10 Jul 2024 22:53:52 -0700, Guenter Roeck wrote:
> Add test cases for regmap_multi_reg_read() and regmap_multi_reg_write().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: Add test cases for regmap_multi_reg_(read,write}()
      commit: c2bb8198fee88a428513f8d023c627ecd13aa694

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


