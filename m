Return-Path: <linux-kernel+bounces-208222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD86902288
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4100F282CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596882495;
	Mon, 10 Jun 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="madmk6Ja"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5E081ACB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025428; cv=none; b=krnFxgjXnzlovdLF4Dx0M5B9CoV5D/Y0x/5sEqlmcVmF6+7EIWq5zW+OR49v+YFNbj+B97h2aMLpfqvTUsU5IBrb9if/4L5Cn3JPp4+SVRjvxb+TseChIgg+a9pi7uVfrkJA0dlpaopEUw+YGSU9vjhdPtWo6eYUo86h1Q1XpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025428; c=relaxed/simple;
	bh=a7dg3y0W6avthEww5Mmpq0u4tDaqju7NdXJSWIvJ3wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HJTLYgOZ2zRD8HJMfvvXOtNxEafm3YGZDF3Pf/gd1QqweVrZjm1bK6d22OtGnG8f06wIGAZhuQTKvyZfTZvp4HD2h2Kg9CAykbL9BUDLudch2170E4CA7g+ZqyJt3ytWbQ1Riqp0ZyKYdquRJqF0/CAA4D4iMawNqlCOvlqAqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=madmk6Ja; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=a7dg3
	y0W6avthEww5Mmpq0u4tDaqju7NdXJSWIvJ3wM=; b=madmk6JacmTKr/RbUIke7
	vB3einYAlczWZNgPXxK4TG8Ds58Loi6qmYLnVVYWJhWK0hS7jrwBKIXqmXo4k+st
	Cy6wNbhi5dOqo/DbpHus8/ob54EKyu8PeB/vCTgd5A6ntLAdo2bVrpXouA/fKklM
	hLm/xagIG8RQLAIUNh17F4=
Received: from localhost.localdomain (unknown [111.35.186.64])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wDXXyaG_GZmSM4MDQ--.44664S4;
	Mon, 10 Jun 2024 21:15:58 +0800 (CST)
From: David Wang <00107082@163.com>
To: jsnitsel@redhat.com,
	joro@8bytes.org,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com
Cc: baolu.lu@linux.intel.com,
	jroedel@suse.de,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	sivanich@hpe.com
Subject: Re: [Regression] 6.10-rc1: Fail to resurrect from suspend.
Date: Mon, 10 Jun 2024 21:15:50 +0800
Message-Id: <20240610131550.53651-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <31f16e4e.afe2.18fc9d5dad0.Coremail.00107082@163.com>
References: <31f16e4e.afe2.18fc9d5dad0.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXXyaG_GZmSM4MDQ--.44664S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOq2MUUUUU
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQD5qmVOAw8UlAABsc

Hi,

This still happens with 6.10-rc3...
I think this is a serious problem for AMD users who used to `suspend`...


David


