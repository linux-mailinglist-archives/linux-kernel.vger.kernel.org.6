Return-Path: <linux-kernel+bounces-254932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 476B793396C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8657B2178B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043C3A1DC;
	Wed, 17 Jul 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Uzr2onGF"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3F39FC6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206410; cv=none; b=bKQHGExQ+u7uYuUmtKodE5bG6/m4T5qtKwv/sSLyX0/7hgp+EPPe3J3ydy9eI6imi/zMw269LYKwmqtTEitg20/3v8TxgEzrjPZy1z4pz8Atuf5TQoltRl5jGfoK7BXEKZrjBiG9wrXJCkkKvo2KWWmHIWKCDCY1Mz74HSWuGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206410; c=relaxed/simple;
	bh=ZWOzlpbmDRzKuGuOH13Bd9aje04IV4lzdvaGxhPSIOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2iKWgidvtSF0BS6u7TimnRbeTRMOuBZG350/yLVlI3qOgQF5Fce7Am5Btw3/cw0IHwwBtuVTd9o44H/kBxB9l/EupdozSeTBjeH9KIh44cZMpf4omk58KT6eUyXOm46geZY4v9zcGThs7vcNc1NHiXduij0Max2PKHtokbqolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Uzr2onGF; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rBEVD
	ovthwvQb1NOFB+eJt5hBj4thTdO2ff3jP2AVFA=; b=Uzr2onGFcbEdb2YmNKsSZ
	RIbFs7DdPW5/ppuMFvduVt1B4A0pQunZTniHCJJArqRYzwfvsBaH37fUH/nkY3xr
	t+aFaaAixF2iV7WMH6f9WiWcwR5WwT/bShZ4t3Uikd292waUdnNMD2TplzSs6wiK
	ZnI6NIP7X2hIoJ8FlJ3nTU=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3v_RphpdmH80MDQ--.56246S2;
	Wed, 17 Jul 2024 16:52:57 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 1/2] nvmet-tcp: add unbound_wq support for nvmet-tcp 
Date: Wed, 17 Jul 2024 16:52:01 +0800
Message-Id: <20240717085202.104722-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <0c4c4365-2c2b-4985-bbb1-5d58bf332671@suse.de>
References: <0c4c4365-2c2b-4985-bbb1-5d58bf332671@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v_RphpdmH80MDQ--.56246S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUO5rcDUUUU
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEAwfKWXAl+MsjgAAsZ

> On 7/17/24 09:52, Ping Gan wrote:
>> To define a module parameter use_unbound_wq to enable unbound
>> workqueue to handle TCP's IO.
>> 
>> Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>
>
> Please use your real name 'Ping Gan' as the author name, not the mail
> alias.

Sorry, forgot to change, will do in next version.




