Return-Path: <linux-kernel+bounces-369497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DD89A1E18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF772840E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF61D89F5;
	Thu, 17 Oct 2024 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRzONnbv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF615CB8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156793; cv=none; b=BPz4h8UTSmz5nHyxgs6o5JwZS2lQkwBZ6jVok7Q8dTmJcOctTDmAgmbk09+k3Tlwf5JeAtc9ZqUDAk6s+V+qi/c8uarXIjVWZuqWKmoyXPXI8R2fz9diAR8JK+42gSVl8FQojjPNSpn6o7IICk/JWjuKAHN+lMPRbEL5CY0lyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156793; c=relaxed/simple;
	bh=GGB/ZHFG6pNhtD+uxUThXO+Ck+et11g/w0P3Hx+odUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhFqwOvJ9ylfnZme3Qj7MMMbJhET/WiIiBTesImZfUB/jIUF5Nhurwk6NhOMwCGwqJlB9znEe8po2MDXJl4Ucta7K9JP97FqwHcnsBa2wEKFg02FJs6zZrgeXOIy/xgXEHZ7E/tlhFxMo/XIkM62yWaVkw+fYc9LMLyFBqFnQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRzONnbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A62C4CEC7;
	Thu, 17 Oct 2024 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729156792;
	bh=GGB/ZHFG6pNhtD+uxUThXO+Ck+et11g/w0P3Hx+odUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRzONnbvXQYpcimRAXwGPmjMb0SwhdcHL0amq/n+08uk7Xp+SHRWzOnb12/W3LT7o
	 W+k8qXMocqE6VwkN/9oZ5C3w9/H/kOYD+87TXNte4pgh6HKNRA4Ih7OKGolarbzbrz
	 TOXM9qy+3UbVSxHphOB/llnMzW1bd1zYaF3RgnRI4we9DG4NxybdU3Bwj85HBQumFB
	 72pCDv0jy8Y1CYcZAPdPLh+SZExqQYCEsiH5zKasPQQpRtYVRq+qRMrgl3poqvNbNm
	 miDXgNyDcS3KERHwZUk/wV0xdIJdcSvdgbYWB2PGD62Z6nE8uyL+sMyCArL6xTVsuC
	 8kRq3fVbbQ1ZA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] acl: Realign struct posix_acl to save 8 bytes
Date: Thu, 17 Oct 2024 11:19:45 +0200
Message-ID: <20241017-undenkbar-achten-9846c9f20a0a@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015202158.2376-1-thorsten.blum@linux.dev>
References: <20241015202158.2376-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=brauner@kernel.org; h=from:subject:message-id; bh=GGB/ZHFG6pNhtD+uxUThXO+Ck+et11g/w0P3Hx+odUo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQLXNt0jn3zgppmtezJz129JR/bVXp2ff/54WWpUeZNv XrTizOudJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEWZCR4Y1Neln7otvz5y0z 89LSDU+Z2eqg7WLvYJe9+v85lXsbnBn+V37V9oxdu6ziSsu2BYfF+Gc4JSveuCb61+ibSc5Pn7D pTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 22:21:54 +0200, Thorsten Blum wrote:
> Reduce posix_acl's struct size by 8 bytes by realigning its members.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] acl: Realign struct posix_acl to save 8 bytes
      https://git.kernel.org/vfs/vfs/c/8f0a7a2d7bc3

