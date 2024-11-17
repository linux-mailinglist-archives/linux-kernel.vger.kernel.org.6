Return-Path: <linux-kernel+bounces-412051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4479E9D02F7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94361F23213
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099CD156C63;
	Sun, 17 Nov 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="jOi3bQco"
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27AA80C02
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731840396; cv=none; b=HuUZ2lwA/bJU6a1Db8YdzQYzsPaMxrbnzwMwRB8IvTupmD3ms3Ovqk/dGij3NuX17jKlbzlpv36LDmQZoytp1gujv7fUBosXyQDs4umOcJ5jkxQc16gmB2UOzVTsd1lV2LLYBMSHKYsl2HSId+s6Q2NJR2i/GwpM3bkoJQE4mQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731840396; c=relaxed/simple;
	bh=zkVKK31V3XTcG/ZCZgUnMlJH8UoGyg+LKu7dmVTrdaY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=b4Sk/KdoIavrMLrGQHYnP2alLUblXihiuqXxyWEv77qK+hKrRhPcDNJUogjn9wl14ZD+xFQwFo1MQmSeJUORAjBJ4qi650BX2ZDb6NTzPGvVT4qsgbG+YoUHGqpsmJwZAIERKVXniDFUuA8DcLVDhe8BiTLuXNN/iKwL7Gsl3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=jOi3bQco; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 8C5722621F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 10:46:25 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id CE1D53E8D2;
	Sun, 17 Nov 2024 11:46:17 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id C666A40085;
	Sun, 17 Nov 2024 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1731840376; bh=zkVKK31V3XTcG/ZCZgUnMlJH8UoGyg+LKu7dmVTrdaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jOi3bQcoMLMnsJOdvOOyGBxYSaa4sGGNRr7FpwJVmsYzjdBwR3uhdGBTsxtrrvQUR
	 nVqNYBzLKdcvvWcQ2wYLWjCoOh9cq4sAFcYzgnLBYj64Abl38lxuRzBBA/fIK0FFGM
	 +4vQmewgdEy3IsnlwYf2U7GkysIEZi+KSfCx8kUc=
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id B9BB34293A;
	Sun, 17 Nov 2024 10:46:15 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 Nov 2024 18:46:15 +0800
From: Mingcong Bai <jeffbai@aosc.io>
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter
 <sima@ffwll.ch>, Alex Deucher <alexdeucher@gmail.com>, dri-devel
 <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Kexy
 Biscuit <kexybiscuit@aosc.io>
Subject: Re: [git pull] drm amdgpu regression fix for 6.12-rc8
In-Reply-To: <CAPM=9twfZ5B1NqByVsvHO38MGQ+ZfTEz6xmtZXQarHvKgg3gLA@mail.gmail.com>
References: <CAPM=9twfZ5B1NqByVsvHO38MGQ+ZfTEz6xmtZXQarHvKgg3gLA@mail.gmail.com>
Message-ID: <c6d0e119afaf76abad93dd846fd6ad27@aosc.io>
X-Sender: jeffbai@aosc.io
Organization: Anthon Open Source Community
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.98 / 10.00];
	BAYES_HAM(-0.88)[85.80%];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,ffwll.ch,gmail.com,lists.freedesktop.org,vger.kernel.org,aosc.io];
	TO_DN_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C666A40085

Hi Dave and Alex,

在 2024-11-17 06:17，Dave Airlie 写道：
> Hi Linus,
> 
> Alex sent on a last minute revert for a regression found with swsmu
> patch for final,

I saw this patch earlier from the stable list and was a little confused 
as to what the regression was (what exact hardware 
configurations/workloads one may observe this issue in?):

https://lore.kernel.org/stable/CADnq5_MPEwVGmnMBz_xzO4ZCBM0kgqP=rzwK+L5VPjwpnRj9+A@mail.gmail.com/

Since Alex commented that "End users care" about this regression on the 
stable list, I would really love to know what kind of regression we are 
looking at (and as distro maintainers, what we should be looking out 
for).

Alex, would you care to elaborate?

Best Regards,
Mingcong Bai

> 
> Regards,
> Dave.
> 
> drm-fixes-2024-11-17:
> drm/amdgpu regression fix for 6.12-rc8
> 
> amdgpu:
> - revert patch to fix swsmu regression
> The following changes since commit 
> 21c1c6c7d732c2f6f4c5ffc77e103aa3ae8bff1d:
> 
>   Merge tag 'drm-xe-fixes-2024-11-14' of
> https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
> (2024-11-16 04:31:54 +1000)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/drm/kernel.git 
> tags/drm-fixes-2024-11-17
> 
> for you to fetch changes up to 
> f48ab0a39f12fd83fae13bf81152531565cd5e75:
> 
>   Merge tag 'amd-drm-fixes-6.12-2024-11-16' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2024-11-17
> 08:12:48 +1000)
> 
> ----------------------------------------------------------------
> drm/amdgpu regression fix for 6.12-rc8
> 
> amdgpu:
> - revert patch to fix swsmu regression
> 
> ----------------------------------------------------------------
> Alex Deucher (1):
>       Revert "drm/amd/pm: correct the workload setting"
> 
> Dave Airlie (1):
>       Merge tag 'amd-drm-fixes-6.12-2024-11-16' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
> 
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 49 
> +++++++---------------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  4 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  5 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  5 +--
>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  5 +--
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  4 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |  4 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 20 +++------
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  5 +--
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  9 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  8 ----
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |  2 -
>  12 files changed, 36 insertions(+), 84 deletions(-)

