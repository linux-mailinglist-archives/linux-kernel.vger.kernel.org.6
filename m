Return-Path: <linux-kernel+bounces-525060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF4A3EA4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB2B19C2981
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92A157A72;
	Fri, 21 Feb 2025 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYuxrHfW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2F8F6C;
	Fri, 21 Feb 2025 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102342; cv=none; b=LA757u4JbmJa+YDTMvK63xEqpTSsSxyw+/EQO5AM6As4TrpikOy2OkVCaHeBOlm84McAOBlEjoJbQLTKzYwZEK9d0tK/0s/VDafmLUPv16fA7+16c4YUNCyJ2wvjvjhfFBAM0j/qoR+NM6PGFAtK36nXVqf9dhGYP563eJzkt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102342; c=relaxed/simple;
	bh=Shwixl52NKIW02h6Auc03dYSVQg1oQVDqFGBadkMH3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhhNV8unGumA7MeFa/7bdIFGkhfEnxk2kiJMAH0gP1caOHePzzeOdgK60ojHg+hHZz2Ox6GByn12CM0vUQ8tEta/ltlX5r+S8ZleLSCiH9OuZA43xHxemFlo8tIkDzJgD/rsIyK1nKzxmjech3aVpg5rPpfBZheth0CqEPzlQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYuxrHfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FF6C4CED1;
	Fri, 21 Feb 2025 01:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740102342;
	bh=Shwixl52NKIW02h6Auc03dYSVQg1oQVDqFGBadkMH3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYuxrHfWJgebmXk9+MtN0jPfAzrMZgKSyBDjaawa4t6aVU04RXBCKu1WYLqDTsOWs
	 zF6CF+ky5NxlTUWPxasFzBhFPC4c6zK+9DN8EbE41bQkvwEc/6eTwaP3LZR6wYSVbR
	 UCnJEx0G8YmvVHVJwLnd+IPAOa4sFSLCI5bMnQPKtEvibVHlFQg6HqmgxCykTSenub
	 7+a5khTzfpj+67gvKkRCAdoptHLG9BxUj8hs6VFL+PDVjEAD7TuAFlJWFj6fx1/Npr
	 cJqBzgDuWCboXq3o/GrjpPSuOCfeIewpVeYk1trkoayclxVLO5PUw+VgaYcAPZLUxI
	 3ArY3S7HvCrDQ==
Date: Fri, 21 Feb 2025 01:45:38 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev, Jameson Thies <jthies@google.com>,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Add support for setting
 USB mode via sysfs
Message-ID: <Z7fawtSb8ELbCNDL@google.com>
References: <20250210130419.4110130-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210130419.4110130-1-akuchynski@chromium.org>

On Mon, Feb 10, 2025 at 01:04:19PM +0000, Andrei Kuchynski wrote:
> This patch implements USB mode setting via a sysfs interface in
> cros_ec_typec driver. User-space applications can now change the current
> USB mode by writing to "usb_mode" sysfs entry, replacing the previous
> ioctl-based method.
> The embedded controller (EC) currently supports only entering USB4 mode
> and exiting all modes (including altmodes). Both of these operations
> trigger Data Reset Message, even if no USB Mode is active.
> Additionally, the patch exposes the USB modes supported by the port via
> "usb_capability" sysfs attribute.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_ec_typec: Add support for setting USB mode via sysfs
      commit: 9fc83373f0ffb8834da48b1446a5c2fef9525bb1

Thanks!

