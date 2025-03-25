Return-Path: <linux-kernel+bounces-576270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B287A70D17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC623BB539
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8F926A086;
	Tue, 25 Mar 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hillion.co.uk header.i=@hillion.co.uk header.b="MGfyqOAL"
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB511253F26
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942529; cv=none; b=m+3AW4oXkwzZFgdlnNVlbP1ocvn++Wd05URbDUMdY+8TfDKP3VFSsPk+J2TLvx/a4vqrfv4PxXFCm9ELv5b1oeqOXxuOZhtXmAzFFLZVRnp46vutXl3tDXQqNtRIWJhgzc/MRH6bPguoSCaAZzNuscSP69wYtMxRuAwx1zpjABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942529; c=relaxed/simple;
	bh=1LBR/IDWIWS3cwq7yKyuPYx0sXuspXLHx+BB8p3oaKg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WSu7UEx6FxKXRvBBtF8BOc+lxXPHHUgZ+UZNDPgAt8tgu/TDxm+HTQJ9vFqMvHymASQ9Q5wK4zm4mNWKikPZvK5LpftqLqRUA+GX1CeDC5nkw7ITHh3fbwWydgBAUCsd7i9wQ3cZAQhXFXmo/3xRTh8mRV+VF1T/gmnES96r+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillion.co.uk; spf=pass smtp.mailfrom=hillion.co.uk; dkim=pass (2048-bit key) header.d=hillion.co.uk header.i=@hillion.co.uk header.b=MGfyqOAL; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillion.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hillion.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hillion.co.uk;
	s=protonmail; t=1742942518; x=1743201718;
	bh=SDrS+ZVUp6wtvYkZuH9NkoUBkBsA3gw1s5Hb+PmUof4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=MGfyqOALvDQfbNnbxRtfG2ipRjSrKknMZxMEndMFzDCwTWj/mW8j3sCatGpuriWdf
	 G5x4BPJc0Mx7Xdi7h3I+7K+leS9pyzCT+r0Bd5EYTTnBWgi1nCZsqycZAyBZ8P9ONc
	 +uv441xdPsvdgMFXr5IB5wzKd8sTHF5gH2UMdZuVHzECwKqkiBGtkdtMDV8PNJfbjZ
	 BQqjveTcMgY5My98sDUG78CyKsGXI+zFeOpNJa1hAuQ3Zr2j5WFehngPXtWPtuLE9D
	 Dzr7hH4NT1gki4IBOLKaQ4i6IkKKy8AYUqTMuXwPxRhplybIII2QMlIxT0wxRlSoBW
	 PM07D9c07Bz2g==
Date: Tue, 25 Mar 2025 22:41:52 +0000
To: tj@kernel.org
From: Jake Hillion <jake@hillion.co.uk>
Cc: arighi@nvidia.com, changwoo@igalia.com, sched-ext@meta.com, linux-kernel@vger.kernel.org, Jake Hillion <jake@hillion.co.uk>
Subject: [PATCH] sched_ext: create_dsq: Return -EEXIST on duplicate request
Message-ID: <20250325224041.14088-1-jake@hillion.co.uk>
Feedback-ID: 23289047:user:proton
X-Pm-Message-ID: 19dbcbc22f71017d77059ec8d389276518face95
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

create_dsq and therefore the scx_bpf_create_dsq kfunc currently silently
ignore duplicate entries. As a sched_ext scheduler is creating each DSQ
for a different purpose this is surprising behaviour.

Replace rhashtable_insert_fast which ignores duplicates with
rhashtable_lookup_insert_fast that reports duplicates (though doesn't
return their value). The rest of the code is structured correctly and
this now returns -EEXIST.

Tested by adding an extra scx_bpf_create_dsq to scx_simple. Previously
this was ignored, now init fails with a -17 code. Also ran scx_lavd
which continued to work well.

Signed-off-by: Jake Hillion <jake@hillion.co.uk>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 21575d39c376..b47be2729ece 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4171,8 +4171,8 @@ static struct scx_dispatch_q *create_dsq(u64 dsq_id, =
int node)
=20
 =09init_dsq(dsq, dsq_id);
=20
-=09ret =3D rhashtable_insert_fast(&dsq_hash, &dsq->hash_node,
-=09=09=09=09     dsq_hash_params);
+=09ret =3D rhashtable_lookup_insert_fast(&dsq_hash, &dsq->hash_node,
+=09=09=09=09=09    dsq_hash_params);
 =09if (ret) {
 =09=09kfree(dsq);
 =09=09return ERR_PTR(ret);
--=20
2.47.2



