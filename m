Return-Path: <linux-kernel+bounces-169994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F968BD057
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E28D287F5A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1513C69F;
	Mon,  6 May 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EXx4/WGx"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082B1DA22
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005855; cv=none; b=n30OJYg9eZU5IE2W8a8DFl1uYAzBwI9woEySyfIQq3y17EmKxbE7DIG+Zml3Ga1Exx7MlQUGiJ0r7N7Nszn7aIDAo0MwROgJRsDxuqEOXU5pGT+2Wb9lgS10gp5GGpWQivn3mhuJ5eNAGVql0hJ47BYUIfjpP0a9GxQKR7OId1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005855; c=relaxed/simple;
	bh=74avidpj6lHrcnz5DWt9tVaHKTbGh3voPFwrs+2HjNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5i4OCv4KCYwcP7Rpx/AOHissvpJFAe5YWl+jwa2KxaktCeTUZ4v+ZN9UftJgUJHXBXgd8uUWx4YzTOb1/cD9uFThb8xzUVooZ39ng/xpkz3nWovM6AZeMz/B5TyGCk0qUOX9WyHhQv02nUTMtucAj9mHqlWhjbK+cVMxug7zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EXx4/WGx; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=74avi
	dpj6lHrcnz5DWt9tVaHKTbGh3voPFwrs+2HjNg=; b=EXx4/WGxoek2QHnlkBoTc
	jRTT0OXc0BvIlIVVgO4dT8CHDkcMpwiNeUaEzYExIs9yWALPn7/aDuzvWZ9Y6hRX
	HDS/r3IY8rE8LFipmebk2F6XSCDnHIVRI1EC0jT7tkmEtYmi8SpI+gNRCAxHLuHh
	Q9yvqf/kUyr/KaAeMjbyu4=
Received: from localhost.localdomain (unknown [111.35.187.227])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDXL_Fr6ThmQiFiBA--.17029S4;
	Mon, 06 May 2024 22:30:09 +0800 (CST)
From: David Wang <00107082@163.com>
To: 00107082@163.com
Cc: airlied@gmail.com,
	airlied@redhat.com,
	daniel@ffwll.ch,
	dreaming.about.electric.sheep@gmail.com,
	dri-devel@lists.freedesktop.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	regressions@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	virtualization@lists.linux.dev
Subject: Re: [Regression] 6.9.0: WARNING: workqueue: WQ_MEM_RECLAIM ttm:ttm_bo_delayed_delete [ttm] is flushing !WQ_MEM_RECLAIM events:qxl_gc_work [qxl]
Date: Mon,  6 May 2024 22:30:03 +0800
Message-Id: <20240506143003.4855-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430061337.764633-1-00107082@163.com>
References: <20240430061337.764633-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXL_Fr6ThmQiFiBA--.17029S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUngAwUUUUU
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEBPWqmVODy8hSgAAsf

The kernel warning still shows up in 6.9.0-rc7.

(I think 4 high load processes on a 2-Core VM could easily trigger the kernel warning.)

Thanks
David


