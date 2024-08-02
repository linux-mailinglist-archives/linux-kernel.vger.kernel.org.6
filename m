Return-Path: <linux-kernel+bounces-272460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA8945C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5FD1C2152C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8B1DB453;
	Fri,  2 Aug 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReoJGTUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659C14B943;
	Fri,  2 Aug 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722595062; cv=none; b=gl3WakBVezI4WdsviiaOl5jKYdbUa0EMLIf0a0Q+1BOYeYtbyHMzWcW3WMjvQIUEG7YfFpr/Cv6ZJKei0gK9CBPjWHAN7wEFXQJ7eQLWvATh2mic0v6Zg5B4z+2Ik2SF8stSt/XaOf1b64bwuhm/Tb6lCrltjfyqCgtyHnJ0rJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722595062; c=relaxed/simple;
	bh=Rub6ETdVZ4JQhCTqX4fBuJ2wjAKj5H57kQ9DlkLWTNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyKnoEcrcfi49AgEH7fGxZQ4zSr0vdUabdnQeYCl9Vi1Y+R82wU8yxgm3jN+aB6xmppV4WBnGdPX5Ev4xdcBl+n/NI009dq0nkheQucJ8BbUF62CMVlCwAvkcVo/rAL4yq0+FB/+viytZzqNUrgPogqF9be3DTGiNqwJ9CWdzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReoJGTUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71555C32782;
	Fri,  2 Aug 2024 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722595061;
	bh=Rub6ETdVZ4JQhCTqX4fBuJ2wjAKj5H57kQ9DlkLWTNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReoJGTUmEphI4f5cFFlLcAnizuzbYo22tQ9nD14y1cJd45me3rxbyoQ0mICRzO8u+
	 WoAs1pIyqVUtBi4ToR3ZAIGYuKu9im28iuGntVRK5lTIKbeVFuPv2Ubf1eZpoHw3OM
	 stKI3LGD5lcw8X6dzE5fpCyICFxe/T/2Qv1kZpPmplDiakEm2CwcrGv3lyGfEFC0mw
	 IQnKMAdyOO1zDO+Lba6nAfvm8V/usA3Kplgab+CeZxeQnvk529Sxazm9TNRJP2CwY5
	 AN28+KIoMFtOkFk2kEdPzI6YPvwdNkA7K2ka400RaVoobXzh0nXliHmoTd/T5jtb7s
	 Z5PpYmjnkLelA==
From: Christian Brauner <brauner@kernel.org>
To: Wang Long <w@laoqinren.net>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tj@kernel.org,
	cl@linux.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] percpu-rwsem: remove the unused parameter 'read'
Date: Fri,  2 Aug 2024 12:37:23 +0200
Message-ID: <20240802-achtzehn-glitten-c520ce8ef628@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802091901.2546797-1-w@laoqinren.net>
References: <20240802091901.2546797-1-w@laoqinren.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=brauner@kernel.org; h=from:subject:message-id; bh=Rub6ETdVZ4JQhCTqX4fBuJ2wjAKj5H57kQ9DlkLWTNc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSt2fZOp3+l/NNUvRO7ikJcVf0dgqalLTpWwJB92nRhO MffmwtNOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTAG7yfob/fk4pM2xPL1UXlNZj Ouh41Ei5a9PVsyYRFgfyblw52PXnOyPD7PUzBNNuH5oSd+7dcntlq0kNpzrL/l23j/C9uVTP+5o 7FwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 02 Aug 2024 17:19:01 +0800, Wang Long wrote:
> In the function percpu_rwsem_release, the parameter `read`
> is unused, so remove it.
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

[1/1] percpu-rwsem: remove the unused parameter 'read'
      https://git.kernel.org/vfs/vfs/c/31eaea29457d

