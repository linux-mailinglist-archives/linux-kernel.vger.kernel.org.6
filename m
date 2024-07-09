Return-Path: <linux-kernel+bounces-245463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE292B2D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39078B21052
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365EA15358A;
	Tue,  9 Jul 2024 08:57:36 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6D28DB3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515455; cv=none; b=cXJo7t3kJTWngP39SZA1s3afkZ5pAIVkXzAXoBH3Hoprzj/NrA8irJyX2jSsv+p8/ESvwZvVmxYgOkZr7gizcahp0GkPbQOGsh1Z4bBPAsw2AbyUBYNGRWA7MisowMaRD2YOAoIG9kOgDtjB+MfWoixrR9cREDOpREzZJ9PHbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515455; c=relaxed/simple;
	bh=R4piXfEWK3JDEK/xg1SLYIYqHUcFt3KcjgoMXNE0juw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n79cME/Wd6HF122grTsvzeJEU40fRrKjnzBsNupamX2uj1B0uCuM9AHc25iq0O/sivHxa6h/GK7fg5Tu1NHloIv5jcaUDYAb+k8EMLmg42X3en6cLQTflgSRNtcRpHm7JWVlY8htKZ0GLXFTgEUY5odfCG5ywttyWlWFvNMS1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4WJDsR2KYmzYmhTW;
	Tue,  9 Jul 2024 16:38:19 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Tue, 9 Jul
 2024 16:40:27 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Tue, 9 Jul
 2024 16:40:26 +0800
From: wangzijie <wangzijie1@honor.com>
To: <chao@kernel.org>
CC: <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <wangzijie1@honor.com>,
	<zhiguo.niu@unisoc.com>, <bintian.wang@honor.com>
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: reduce expensive checkpoint trigger frequency
Date: Tue, 9 Jul 2024 16:40:26 +0800
Message-ID: <20240709084026.3098260-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626014727.4095350-1-chao@kernel.org>
References: <20240626014727.4095350-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a011.hihonor.com
 (10.68.31.243)

Hi Chao,
I think that we should call f2fs_remove_ino_entry in f2fs_evict_inode to delete
ino_entry in CP_XATTR_DIR list.

