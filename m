Return-Path: <linux-kernel+bounces-548558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B8A5466C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F641722CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9D420969B;
	Thu,  6 Mar 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz7ytdXi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E72080EE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253736; cv=none; b=IYCEFqQ0fcNY2QJ+8URbJod9a34kyewFh0k8nn3LBjqln0AGMySKEvoRh+/qrxajZx3K5T0PzWXKSpDpwmCUG/so6OSc/hmDjss9tMgWgLKD5e/RQzvUBXyJsV8p7sHJ3Ze56M4NBQ/IBgVmK6BYEt6uAEgPmgSTXSahkqfP7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253736; c=relaxed/simple;
	bh=/d4p2yWQBobXtpMS3WnpxEEdU5v3Sg6/HXHs8sWNMpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTvUWI7eZhnskU/6MZ3k9Vda4AW6OFYWmrM7gYV4mMWczwlrnlOcu36Ye9EDdOpey9yg8uhAr9cnEUlSR1Lx195Mng14lE3rpMlLnnFIPd2ZAPcWgFe9PzGWelNV2EMeMjNnyhL3iWS2jiXJ5huvmnaw3Wfz8InVCdlZ0sROjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz7ytdXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B72C4CEE0;
	Thu,  6 Mar 2025 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741253735;
	bh=/d4p2yWQBobXtpMS3WnpxEEdU5v3Sg6/HXHs8sWNMpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cz7ytdXi3vPT4lfEBaa/pUZq/+QM7iAO6vuepo+PRU7Wlms5f/G54ncKOm2nvtH12
	 Pm7OwXZ7LfGwB30CnuTdPgFaBbKVy666mAco/ybImcMYuJMsZkgrYrzM6nK5AOFD2S
	 9Iv1zMPtkbB9FIHbFY7kixC7ZEiMmkwCgJfWcVOPK8F7a9jlFKGHX3vWFajIUDTXVi
	 Wbmx85nPOjV9gTxN/uyy0tvIBBeUuRBYp75EpqXFTCLDtbN0l4VCr6261svdHp936H
	 VUX+B8dupoRZ4LRp7t0mCfUH7IoSF1PpXUtiAcw50hld8pGcAQsKWlgl90lRLC7mQa
	 flcJwKBOxuEhw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Wei Liu <wei.liu@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pid: Do not set pid_max in new pid namespaces
Date: Thu,  6 Mar 2025 10:35:25 +0100
Message-ID: <20250306-immun-filmt-c2283120de42@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250305145849.55491-1-mkoutny@suse.com>
References: <20250305145849.55491-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=brauner@kernel.org; h=from:subject:message-id; bh=/d4p2yWQBobXtpMS3WnpxEEdU5v3Sg6/HXHs8sWNMpQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfzEl0e/Nq064f7SfvT2vet7puTXORu0XKEsN5RewV2 77M8bk0paOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi684x/NM9/zlmaVDOyVaH LbZbX0ulVdzQMfq82iWiXjR060k+9ccM/9RnN+63iTGd8/2RW3faGQ7vBQciXqau/31/B6/Ix56 8mYwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Mar 2025 15:58:49 +0100, Michal Koutný wrote:
> It is already difficult for users to troubleshoot which of multiple pid
> limits restricts their workload. The per-(hierarchical-)NS pid_max would
> contribute to the confusion.
> Also, the implementation copies the limit upon creation from
> parent, this pattern showed cumbersome with some attributes in legacy
> cgroup controllers -- it's subject to race condition between parent's
> limit modification and children creation and once copied it must be
> changed in the descendant.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] pid: Do not set pid_max in new pid namespaces
      https://git.kernel.org/vfs/vfs/c/d385c8bceb14

