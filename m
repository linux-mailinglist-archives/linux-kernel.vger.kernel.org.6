Return-Path: <linux-kernel+bounces-561524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3995AA61307
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F715462B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE841FFC63;
	Fri, 14 Mar 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="lOsXBqWe"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC011FF7B5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960203; cv=none; b=f09rTF9S7POWPFF72aJkDVNXIdtV8flgIzXl1eIsqsoizNegxZyjWx6W7VC65FHsUF78f+NJzXI0pWD1pCk/NxVQ61SIFWcaNIHrgWvzGP7ZPHMoD3aPGq0BmhwXbCb83ykDOZdXBrLsqbsPGlq3MnEdTFS3MyVvtmIExkqQPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960203; c=relaxed/simple;
	bh=0um3iODhdtSJSPx10NBW3eU/Ie7n0p9Y448asvFzY7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KVBDF5qaAi3yRU/58SJkJdXvrxwKBaRL+5gP1kBH70Tn9TqelP+ZowBmYnh+TmMaMtTvYXeySMkns8/zVym+GRSxoWueTwt+xLlyt/SpDNGb9cw8OhzQ2JE7Wv+SlHNZe4RIIPrSh0Kye3qxQ4VX+UF5uY6Mo6kRYNkb2Nby8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=lOsXBqWe; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741960199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/5knLVWhNBfFd9leGBuomV+x3A+6TFi+unjjwXKU9A=;
	b=lOsXBqWeOxXWT0gOrCN3WOhGLcXDVZdCKgBO8Q1mGUvv40abQIWsL7ssDOv6qdWGheoAG9
	ezTredyQIJiwhlwKbxo51HTlHrdI5wW7lz5f6ccBvlsEBS6wOV4upPfOI0lDCKwD3qLrlv
	4iqOEr36zm0gf+YxEeruohTXmvW36Gmrug5lB/8m5uut7hkEWL9s/YfYNpfVhdtHhmhHrG
	SpNj/CcSrvhHCRUd+M7IPWRTVjsXFixjl62cP1UrvQIpN7mOFelLDws0e1hGJ9AC7oWEbM
	NppZ5wfWU00hKS7BKQ333bAqfizMSk+dNjWYANtOqQ1QEl+adFwoeyEOcYscgg==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Sven Peter <sven@svenpeter.dev>
In-Reply-To: <20250310-apple-twiddled-modifiers-v4-1-1ccac9544808@rosenzweig.io>
References: <20250310-apple-twiddled-modifiers-v4-1-1ccac9544808@rosenzweig.io>
Subject: Re: [PATCH v4] drm: add modifiers for Apple GPU layouts
Message-Id: <174196019716.15076.15894537454426268004.b4-ty@rosenzweig.io>
Date: Fri, 14 Mar 2025 09:49:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On Mon, 10 Mar 2025 15:28:02 -0400, Alyssa Rosenzweig wrote:
> Apple GPUs support non-linear "GPU-tiled" image layouts. Add modifiers
> for these layouts. Mesa requires these modifiers to share non-linear
> buffers across processes, but no other userspace or kernel support is
> required/expected.
> 
> These layouts are notably not used for interchange across hardware
> blocks (e.g. with the display controller). There are other layouts for
> that but we don't support them either in userspace or kernelspace yet
> (even downstream), so we don't add modifiers here.
> 
> [...]

Applied, thanks!

[1/1] drm: add modifiers for Apple GPU layouts
      commit: c8619f5402cbcccfe58151b53421029852473e4c

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


