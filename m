Return-Path: <linux-kernel+bounces-397185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A8D9BD7C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8684F283F76
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247D1FF02E;
	Tue,  5 Nov 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVv3VNFL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344D1802AB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843112; cv=none; b=Zkv0AusM3f4KqvPf8HgWEWO5QN7BoN3KRiSZ/RABZum/YOgrdxRgdKRC4RMFRjuS+ZRMiIoV+cEF9HRF3ueNvi9pEcOa9otxL5suuGdDSx+X0R/Ml8BVzTjl1zjVTy9T25ATHlvcVB2n1I3hdVas2y3fjmSUOcH4fNpGA/K317I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843112; c=relaxed/simple;
	bh=+bQJylxKBxswmtoVmFauRWf0nxG2ry0iPzzVrbzUbpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nZZNzs15EV2Y6zdBDPVVrQ7ZkrJUTfBoFOuHCH8djyIKzRmFLG2e3VbKSDL2eE/8F+sYprTIfOBpFcIflfHDauVuJbetW2GcE7cVQVXKo0JOX79Y+/NB2S9iL5dxYTZeQdLGJHiV0Nfahk1i3ZRwd2z1H53mN5Zj41/Xigqqvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVv3VNFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB50C4CECF;
	Tue,  5 Nov 2024 21:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730843112;
	bh=+bQJylxKBxswmtoVmFauRWf0nxG2ry0iPzzVrbzUbpU=;
	h=Date:From:To:Cc:Subject:From;
	b=HVv3VNFLQRC7KvBDbauBsZ7BOP+GfQsGHGgToP+mx2GmHT0UFeNgZM45SGjdQeLP0
	 NmwPEhS8DMd50AQGrwIGr+roZkDE2kBpirPHQm7u6VyHlovJduIKjcT6p4Gday7tfO
	 7fpgLy3sK0qqS6iDwBu5KmjpNonI+06Fgc5Q6lG74a8V1oXTLR2atdkdkwKTBf1Dc7
	 MQPMx9UMX857lqqVaZMtYPYQ1ZUrrStOHTZ7ZVNkm8R/vHDFAiOp0MTofhVZrGkdgg
	 2tphsia1A9ctzNN3rGw6tnGxvPNhykm+fTGHQyS1RQ9tuxFxaOaSee+D8zLHmUK0wB
	 +e1Oca9bvxM3w==
Date: Tue, 5 Nov 2024 11:45:11 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@meta.comm, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: Update scx_show_state.py
 to match scx_ops_bypass_depth's new type
Message-ID: <ZyqR51ROd198Ulu5@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

0e7ffff1b811 ("scx: Fix raciness in scx_ops_bypass()") converted
scx_ops_bypass_depth from an atomic to an int. Update scx_show_state.py
accordingly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 0e7ffff1b811 ("scx: Fix raciness in scx_ops_bypass()")
---
Applying to sched_ext/for-6.12-fixes. Thanks.

 tools/sched_ext/scx_show_state.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/sched_ext/scx_show_state.py
+++ b/tools/sched_ext/scx_show_state.py
@@ -35,6 +35,6 @@ print(f'enabled       : {read_static_key
 print(f'switching_all : {read_int("scx_switching_all")}')
 print(f'switched_all  : {read_static_key("__scx_switched_all")}')
 print(f'enable_state  : {ops_state_str(enable_state)} ({enable_state})')
-print(f'bypass_depth  : {read_atomic("scx_ops_bypass_depth")}')
+print(f'bypass_depth  : {prog["scx_ops_bypass_depth"].value_()}')
 print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
 print(f'enable_seq    : {read_atomic("scx_enable_seq")}')

