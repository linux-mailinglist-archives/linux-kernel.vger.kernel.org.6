Return-Path: <linux-kernel+bounces-433055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FED9E5371
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F8D28105B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C11DDC10;
	Thu,  5 Dec 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TOSYn3gf"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3881718DF6E;
	Thu,  5 Dec 2024 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397075; cv=none; b=j3q1H6DJ4FTJfklZU/PazAT5+eMhXmXNtjr/4rpcVDeUGSe0fHZWdCaC4awBdcbjQWM/VRsw03gNcIhXBsZl+IeLgN2Cdalz3SKX/ZHr5CsutknSTc1J+DnoInn4ugZjn+6jUJS3IoMDZwB5bo5XtaYh4Eqisn9paWxMh4d4ZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397075; c=relaxed/simple;
	bh=ic2LZ+xZao0jYrIrVZa/aUUK2jeJmobySbxf5Ab41VU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZU2NEPcYFNwrRkTTLaVpyt3gX263vfhq2tePkw0IqEaXtRm/mzepZAwPEwe2llbO1Se5uUiv23PDfq4m45W3M7imZrYrZ/jf6W94fK8gnzoQc7P3Hz2TGYSKx9FLlHhxXl1yswk2IFhYziWpe3deKl52W3FFZeEc2S3MWKld4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TOSYn3gf; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ic2LZ
	+xZao0jYrIrVZa/aUUK2jeJmobySbxf5Ab41VU=; b=TOSYn3gfbEuVm9PsgRpak
	OLe/581/gLlbQzfPwLpGXebiwJ8Mm+DEt2ZQRzDgKz6RLXWwtkIGOKAMyRkikWFJ
	clCOOYhFqOejmKtOc8NCdWbXYjKHsWCPDzXDeXJ/gHbF6w+mDAJqHIBCxhWzKu3i
	Gcvnbcnt49s3H2746vANGo=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnd6UpilFnz0pQLw--.13066S4;
	Thu, 05 Dec 2024 19:10:34 +0800 (CST)
From: yaxin_wang <yaxin_wang_uestc@163.com>
To: yang.yang29@zte.com.cn
Cc: bsingharora@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	wang.yong12@zte.com.cn,
	wang.yaxin@zte.com.cn,
	fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn,
	tu.qiang35@zte.com.cn,
	qiu.yutan@zte.com.cn,
	zhang.yunkai@zte.com.cn,
	ye.xingchen@zte.com.cn,
	xu.xin16@zte.com.cn
Subject: Re: [PATCH linux next] delayacct: add delay max to record delay peak
Date: Thu,  5 Dec 2024 11:10:33 +0000
Message-Id: <20241205111033.3675568-1-yaxin_wang_uestc@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnd6UpilFnz0pQLw--.13066S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrtC7DUUUU
X-CM-SenderInfo: p1d0x0xbzd0wpbxh23rf6rljoofrz/1tbiLASsxGdRiZ0MXQAAsz

>> From: Wang Yaxin <wang.yaxin@zte.com.cn>
>> the 'delay max' can display delay peak since the system's startup
>
>What about also add 'delay min' ? This could help us get to know how
>large the difference is between min and max, provide clues for optimizing
>potential. This is also some benchmark tools do, like stream which print:
>precision of your system timer.

I also think that 'delay min' would be useful. I will submit a new patch
to implement the 'delay min' later.

Yaxin


