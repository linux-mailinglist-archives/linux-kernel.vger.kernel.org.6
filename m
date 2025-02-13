Return-Path: <linux-kernel+bounces-513511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E53A34AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109997A1A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86776241672;
	Thu, 13 Feb 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQW3qyr7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823020127E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465371; cv=none; b=tz+fEc4zVnN013dSaear0xhBIgv8/jX60d2p1DBLXCzKJIT6fbb02X4COQe9PdoJ3SqJWcgRutpeth8t42mWaJSpUSazJ0e57ZcnUqAW1zbuG+uCIuJZmsoav+tgHIgWHo/GgYGJ5urIGCTNFwR0xc9QxO6edY0qSJlDsFqbtUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465371; c=relaxed/simple;
	bh=KhITdyDaNtei02ALi6a/ySu7LOaIDy16MNYOP2B0vSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/QpuT56sZA9gjYUYZydw4kbP6/B1me1+hrktpIoR2+4BEW+YXt1lxpeLRGKhv/T3Skqbl07+0Ku0i7epvUDDUaH3W48YEDRWMz00SjQhB9X1cN51inKgDVgyh/dCmtyuBc4oqLGbt4grcI7JM0/WhvUbmbtU7oECVcp1Wd7Y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQW3qyr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB0C4CEE4;
	Thu, 13 Feb 2025 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465371;
	bh=KhITdyDaNtei02ALi6a/ySu7LOaIDy16MNYOP2B0vSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQW3qyr7XTYxm2pyupAD6Tn5pDmsWJboLEcQeK6PEd3bgbGjgc/Pblqr7AQxgnpXS
	 PMnZwtmiMt9ZVqc0gvN2LeQt3k8ewIymIxIwUlwS7c4mMyk4B4EkZCQ7n1I/7bEK1V
	 zcyUFWg44QW+CywMFqmCFXTyonU9r+7Vgkwv0dhTdg9shLgo4qqrQXyFyW/Gnh3/60
	 O5Q5XTahPHBhxiZEyNpwVlh2X1In864L8MH/1JogiHW9Sr2+Y6ZlUfJHNHIKrzl+eT
	 x9xYAQ3LOO1TXar4U5JJYx9MpBqoWJrO027S0CQInu56OnocMXf64ebMcGxG6g6v4f
	 HPy5dFZqbgKQg==
From: Christian Brauner <brauner@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] kcmp: improve performance adding an unlikely hint to task comparisons
Date: Thu, 13 Feb 2025 17:49:12 +0100
Message-ID: <20250213-ablauf-rammen-ede462c247f6@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213163916.709392-1-colin.i.king@gmail.com>
References: <20250213163916.709392-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=brauner@kernel.org; h=from:subject:message-id; bh=KhITdyDaNtei02ALi6a/ySu7LOaIDy16MNYOP2B0vSY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSvU5rGs+Lahjc8v11TttTX8p3JDrsy03GLx3lGhvM7y p2/Tdtn2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARpi6G/9XvpjY9ZePL6Hnd 8NhDpPjMtAJtGa4TS8I565+HPo5Z+57hn475ieqNfZ1/orVnzvv7LG+Zg2vf31ebexIViioZZaU DuAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 16:39:16 +0000, Colin Ian King wrote:
> Adding an unlikely() hint on task comparisons on an unlikely error
> return path improves run-time performance of the kcmp system call.
> 
> Benchmarking on an i9-12900 shows an improvement of ~5.5% on kcmp().
> Results based on running 20 tests with turbo disabled (to reduce
> clock freq turbo changes), with 10 second run per test and comparing
> the number of kcmp calls per second. The % Standard deviation of 20
> tests was ~0.25%, results are reliable.
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] kcmp: improve performance adding an unlikely hint to task comparisons
      https://git.kernel.org/vfs/vfs/c/a25b006052a7

