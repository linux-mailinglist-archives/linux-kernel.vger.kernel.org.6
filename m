Return-Path: <linux-kernel+bounces-561525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC778A6130B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BB9881FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690CE1FFC7F;
	Fri, 14 Mar 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="jxlr/ChD"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC91FFC41
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960210; cv=none; b=JQybv0rTHSswRVPe0rI7Ln/ZQ/85/WmKUE5DQwy+zd+nLQS8Aw6bVmmFVXwd0M4wL6rJXeyzlG2qPRMApKABnmLaCPCRoDUN1Jg8WWvGIQqFPEqy4mEQe2sXLywoADTiB3M+OYW92Ec5CMkWlVl/rWzhs++HTycysRtgF6Qe70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960210; c=relaxed/simple;
	bh=N27tQOxuW3SUk2tPx2DZBX/49OMRCP/DSgxSm/h7W1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QV9Jfi1dFr9rpBVwXIbbb77Aflgs0P37T0K5JNfdkjc0GWIKS06TnGvbtVbWCK/LklEFhZTnWB5xUzdir3AEKqfpswD4OJbGuJxnJtQOeMuSp7McKmtAN6ArNF6Z8wQQMf4AHHCDJ4Q0fExJrOHb8AV4YOQrmIu77I92Q+n0qmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=jxlr/ChD; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741960196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjqPfczUqBdTMrtHlSDdRiCcbc6NaYyR8NlMI1cTcwQ=;
	b=jxlr/ChDjPwqGapJiMF/He1YHfzKVUiMqMNv7H0p3M0UtfWCDRBd9cOEBhlPYSjyJFjV51
	ZlCc3XNzHLVVOnwIFLCNgnmV70zKjv6ebaA0iJJiWqTl345NSINQ1mwMdO6xj0ZPaV2bPL
	VtoKOG1CVteUhSfIk/qmGDgkq10X0meASCdkC2zwQifHio86wmXC6pjzFVkoogYcq/Q51m
	hmAMOQEJ9644ZkIipQz/eES66hDvLzk6rx/UMBbF2+IJ9yjDVbTd0GSBltj24OaY8Lfzrb
	i8u+aEGn0ESAUkfZlKsQawkaIUZt7GJA0GCsZNywA1u7IDGKexolbP2wnACD4Q==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Janne Grunau <j@jannau.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neal Gompa <neal@gompa.dev>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <14a845e8-54d0-45f8-b8b9-927609d92ede@stanley.mountain>
References: <14a845e8-54d0-45f8-b8b9-927609d92ede@stanley.mountain>
Subject: Re: [PATCH next] drm: adp: Fix NULL vs IS_ERR() check in
 adp_plane_new()
Message-Id: <174196019326.15076.17884484110903495475.b4-ty@rosenzweig.io>
Date: Fri, 14 Mar 2025 09:49:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On Fri, 07 Mar 2025 12:30:58 +0300, Dan Carpenter wrote:
> The __drmm_universal_plane_alloc() function doesn't return NULL, it
> returns error pointers.  Update the check to match.
> 
> 

Applied, thanks!

[1/1] drm: adp: Fix NULL vs IS_ERR() check in adp_plane_new()
      (no commit info)

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


