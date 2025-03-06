Return-Path: <linux-kernel+bounces-548608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257CCA546EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AF81896576
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3520ADC7;
	Thu,  6 Mar 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfzJjKLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814202080F0;
	Thu,  6 Mar 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254759; cv=none; b=oI881fNh6fdOz/XPJ0ldPcOOfMCYvOuok1q1L7puHOTnEzRtH7MaozAeCtxq6sGR/PFYIOqVSPqDlpfPVFycCkJq0A7pNYnH7cDtEs+raBZ/2BaXHVNTlqsgsH6sTeBPAqIXVjDwb1TuWT9OdjOPo0GaPSOEQv4iOdw96HJTxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254759; c=relaxed/simple;
	bh=CZq3ZIiiIO3KJSoi7XFRrR4N3fgTxVqRNIbNeAnLObc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1CF+8VawLxZGHfU8Bnkzw4nNqxaZIaPNq9daqEJ1Lmgk7pn7WKOD3RU+snWEkNIOE40+bbQZyFL0XWsoe2YbNnKGgeumLCPvUrriW/AliLaCvu06B78XEudpGx0UEOwHiP+Y9rE91kSdoemIlT2+KxWDYtRbPOcydk6jdMHSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfzJjKLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DC7C4CEE0;
	Thu,  6 Mar 2025 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741254759;
	bh=CZq3ZIiiIO3KJSoi7XFRrR4N3fgTxVqRNIbNeAnLObc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfzJjKLpUauOHQOSsJPWkR26g54iwnljlL1k2F/GKOt1/m3Xt8VrHV1fn3X/7G4WB
	 xdDZONBCBW3ugY2hHDhcsqx7FeesKCzCXmt1uWd2nFpl0hoSWfbRCJvyvwnSHjP3ok
	 xdBjEwMW5TQAamykSD9VflIJpEaPUrKqOut3FVeAKMcrJs4D/N09A4B7Ga+P3cpiug
	 guV+gOLrO5iCwFUNosFZVgufn2R0Mtp5lkvqnezpMxEDVdn7bc61AQ4/u5BhFpHBrn
	 9pda319Lov7cV6fk6eaiFH+yrtqBbC1i29sg3CAIs4tqETOEOPy6wDQZfAsr3a4X1d
	 iEsphS7+PiJdw==
From: Christian Brauner <brauner@kernel.org>
To: David Disseldorp <ddiss@suse.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] initramfs_test: Fix NULL vs IS_ERR() bug in initramfs_test_data()
Date: Thu,  6 Mar 2025 10:52:26 +0100
Message-ID: <20250306-steganografie-gummihammer-4de754136e69@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <a4ed49c0-e92f-4fa6-b1b2-32749f551724@stanley.mountain>
References: <a4ed49c0-e92f-4fa6-b1b2-32749f551724@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=brauner@kernel.org; h=from:subject:message-id; bh=CZq3ZIiiIO3KJSoi7XFRrR4N3fgTxVqRNIbNeAnLObc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfLEiy8z816/OCggUJOoZnHovssrs/9dyJntkyaveer 9pgHTrvZUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEhO8x/A8XepGa68np55Ax kYt3dta8OwLlTHb7tqleXMvQ4qgmIcnIMHFmxJqt7S9E8xcEZ5i3dPkcFJz+5lWiLeeclq8cJ79 1cQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Mar 2025 12:48:40 +0300, Dan Carpenter wrote:
> The filp_open() function returns error pointers.  It never returns
> NULL pointers.  Update the check to match.
> 
> 

Folded the fix. Thanks!

---

Applied to the vfs-6.15.initramfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.initramfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.initramfs

[1/1] initramfs_test: Fix NULL vs IS_ERR() bug in initramfs_test_data()
      (no commit info)

