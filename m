Return-Path: <linux-kernel+bounces-514550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E8BA3585E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C0E3ABC55
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7487C2222D1;
	Fri, 14 Feb 2025 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3qppVII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D382222B1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520138; cv=none; b=joaS9rPO8hRzjLKnwA08Hbb2ukmFBjpr9lwZbPdpvxgtB4PuPOUTlXBkyQOSZCuOmM5Af+S34PDG9cIYOt01DEW+Y4EOJuodLejEyGJPVQWiePw9DxhzTLACg17bGTiOBTlFCAORBtVUfKFpMASclp+O4wzEeALdLWhYlutI/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520138; c=relaxed/simple;
	bh=l3XZQZvQkDfNzwgQzMulETJqMg/v4VRdfWXQoC2LOHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4+2g4ObuOoK9DmQmn2CDJ0sSavU0hUK1/6S+l4HC+dZdTU3EuM1F1TPlSp5a8VZcd94pCJ3IPVYYdiYICMqWZdUahFy2IzOw9ghI5mr3+xvPTKZDMOFKwV2cSorjxAF29jmBkO1u2Tx6+Zbh3c03uBjLtCWdlmqHgiB5yecc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3qppVII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADABC4CED1;
	Fri, 14 Feb 2025 08:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520138;
	bh=l3XZQZvQkDfNzwgQzMulETJqMg/v4VRdfWXQoC2LOHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L3qppVIIP+ahp81b49lSkbjwy5K9C9UyhosWNcaQGiw5qDh0X5p2nCkZgbLAlRQKH
	 uDxu94M/yWiz6+aknLYC/MtsVSIXcO7nKCs/wIJE+35tzGmnXHCYw/sP0+tQkVtMAS
	 qGWCd/sl7yZp1SWoBLIPpbSr2JBrjGBh8gnhgJvOxMxXh99Lq/TQFVsYkdrlVYUnyB
	 Mwoh1FvSrXtyWWz9gbZeQivvVY2UkVmKHTQCBzhmtuSJG7Or1fxWBLZU9d8RIFMdqo
	 eqdFzFoNAsKXpHxI50pCkfUp6ykDG7D/pEkHFfOdOIzx0C1daijmWCABA6QuUvU9Eb
	 5lgOuqx0DEAjQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 14 Feb 2025 09:02:03 +0100
Subject: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
In-Reply-To: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The fabric transports and also the PCI transport are not entering the
LIVE state from NEW or RESETTING. This makes the state machine more
restrictive and allows to catch not supported state transitions, e.g.
directly switching from RESETTING to LIVE.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 818d4e49aab51c388af9a48bf9d466fea9cef51b..f028913e2e622ee348e88879c6e6b7e8f8a1cc82 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -564,8 +564,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;

-- 
2.48.1


