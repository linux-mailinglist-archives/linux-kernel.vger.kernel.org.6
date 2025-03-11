Return-Path: <linux-kernel+bounces-555849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D10A5BD65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DBE3ABD39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2793023AE8B;
	Tue, 11 Mar 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utqnP/xQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339423AE64
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687939; cv=none; b=E5JxHFcLNEmkip20FPoNy+h8lGzOQu5B+urc/hOJ/p7XWTwSDbF0ofgm9vG9oVZ+YBB9p+1bYE3kszAQlu9yYvuOdz5EneAg164zMd8ktg5hbbWpmf5S9ou8X52XFhiyu0SnsKVqZd55/ZCBgWTW1xH63dyAmLefqY8wb4K2Zgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687939; c=relaxed/simple;
	bh=Tc4yT/fkA+4P7tfX7RUfHYar8v78W+3VZGN+UEnur9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ofhr/z52VpK/eHdvFNizwyoozS5fF6YrH2HSPKSTDl65tJOVHX0tgrRoELrz5agtwjtBPayNFVD4/Rshjnv+yiUSO9BdiLf9SMEWKEBt4EXkAR+FzVgcK/C0Es0FGW5haVXXIMYb+ahNK6UoiTtE/g+YrlTGFwr2RC6llNgvZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utqnP/xQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE3BC4CEF1;
	Tue, 11 Mar 2025 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687939;
	bh=Tc4yT/fkA+4P7tfX7RUfHYar8v78W+3VZGN+UEnur9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=utqnP/xQ9/lTpgV87K3De8tlqcSbG4rOAGdbLOA5S2d7WvnDQEwvCv07cOS1p1q/3
	 T7098XIQW3LlAE9Gn+xBfqZq6bE4FfKX+IwEQEchkAfKRMjCffgUwOL8abfjDqAzK7
	 XRM9ZQib+1Bdyg+EBfDbhkezqoiL2Gdh/sYFkH/dP8jy6tBuGvUYk7tGNcMwVRy/mu
	 j8iLzRS2042yAUKXBa0S9cb7VIo7TCLCP/tImbqv9VYQaw/UF3o9tfXQ3SIqQTlEih
	 APEnKr23xvn3wXNnsjJd4Bxs0mR6z59TfHegcU3JaTmamo+3mByl/QK6V2PCr4xt8a
	 1nYNT4HVaaUWA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:41 +0100
Subject: [PATCH v2 15/15] nvmet-fc: put ref when assoc->del_work is already
 scheduled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-15-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 50cfa02bf8cd1bc39ee8ca3f0b260c5a8733a9df..a948e0856502686294e42826669fd9bd71121c62 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1089,7 +1089,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool

-- 
2.48.1


