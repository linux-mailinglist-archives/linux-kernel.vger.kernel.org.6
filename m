Return-Path: <linux-kernel+bounces-172433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D08BF22A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED36283A47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53596171E44;
	Tue,  7 May 2024 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6PdT6oQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600D1708BD;
	Tue,  7 May 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123524; cv=none; b=SRIyFSP0J27r4A201KfbAmISX+w/NBFm2jLTiTSoAas4uiW5FCvKrnyChAjbSeOz7gN+4x6G4zxmlPZA9aPfYwIYRKJm72p6cSI29hLTP8hGZ/uTdHrSLV4ULmCUbpUfQxj+nsZ6s7/N2RA1lJQrbf62x0W+8y/eCJUBF2VTMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123524; c=relaxed/simple;
	bh=y1rhdDOxe21+WMY9S2759/oEbYoQ9ExkWEChZFtqQuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJ992n0/RYNaRlMkNo6AliJ9lFrQFIc7snfBfqS3b6soCJEGmzxzc4xZ5/4Yic6ZATh+0MycXCwwUk4gg7AfjjQNO7PQ0HDOfzC0kba83iFy/H4/QwpX1bB8GBMnrYqoAPTv/2PLrly93vXY/duYLDEVBVBSzIYO5zffyzJfKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6PdT6oQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37377C4AF63;
	Tue,  7 May 2024 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123524;
	bh=y1rhdDOxe21+WMY9S2759/oEbYoQ9ExkWEChZFtqQuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6PdT6oQ662fuf4LrznIYHH32plfuvnu13SpQDJqtAV5wlFyVP+qnbnAdBuLngUQW
	 ntjIuuFlFE8VZcZlSVWTjAfaR1/Gn0GawA++Zi82Jw/evD2CijxpW+jMcpeCOs4Pz6
	 mcGVXim8gIqMgwxlRHvnw2hmTmI4Vpmd+h2IWDe2i+/x1owZfK1FHsfvhx9h75le5D
	 hrof7PoccwV1LS7s3q6grn3i672wDHqK+uCx9Z2UUPHUzyyGULOZU6cSFZ3KHSuglv
	 l5y9uQWKQ2AOEZr9YF0JZKQG0kU6Gf/qrrQoRuYLzR7aD1EfxVDWH3WjfLO4QCZ3xv
	 Ljebuq04lh4oQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 38/43] nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
Date: Tue,  7 May 2024 19:09:59 -0400
Message-ID: <20240507231033.393285-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 46b8f9f74f6d500871985e22eb19560b21f3bc81 ]

If the nvmet_auth_host_hash() function fails, the error code should
be returned to its callers.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4dcddcf95279b..1f7d492c4dc26 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -368,7 +368,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	kfree_sensitive(host_response);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
-- 
2.43.0


