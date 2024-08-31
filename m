Return-Path: <linux-kernel+bounces-309783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1A496705F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46751C21E3A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E3016FF45;
	Sat, 31 Aug 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TLOsX17U"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16D13B5AE
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725093418; cv=none; b=n1u+sWM0T5Qxyu7W+TtnNaebSNqPnGh6JYLeRW2uxnVMbj0aKRUozs5TBeSD11cYewG+OlQak1CYb1+iPUWRFVbuJnFcG7cLYhHyK1l5Tti0LVRL0ERprmmxsEhV99nAAFUpyajqE8hg9BPio6FSi8s+rdalPkbdgztQn7KiXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725093418; c=relaxed/simple;
	bh=cl0Ox4KOziAzBMAA/oSEeqrN00rD+vC5icUHDP5gYtI=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=DrSIO8yTZQgrFs4lOHRh3ltD0RFh0r6KeLjMfoJTO6e4klKHwR/S8UDX5tiT8brkrTCQGH/d5HBcn0fbMj5c7noL2HwpgIy5LV9XlDPjqKb6yiAw+GVY58U1ltvaRmHp6+yFLx09L4PKZ97DbFaVs6HrdMnWGjaSGceEthmXkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TLOsX17U; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725093372;
	bh=cl0Ox4KOziAzBMAA/oSEeqrN00rD+vC5icUHDP5gYtI=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=TLOsX17UmpsitGdeeHdy7Gc4S4wcHbiJOmnvSESg011aO7M5CdDk1QTRVEcINXScQ
	 RsqR5FFDxoDn+GHQ0pz8wMVeYsquzdGG/eSGO8GqTyYax8BfH8slAguf8k8BAEA1u7
	 TT50r+9FqAqdLlc1NSmsinq/EKWDapMGyox99sCU=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-XMAILINFO: NyPaQtJYQgeoFqXPUdxfVHJcEgn/ytUp/itUvvfFPFKI39ezSC4k8QUu
	WFa51a6evSSSsFMYbJI8j11nvk7pUcOjEvbeUMO1MXUIeSYMHAA2NkkenuAzjQ8BEUJJ/Mx
	YbIp7vUTS5UWKEikK7Zc+pfk5Umss8LnhLBbaklEU5FlvzDNHrXq6qqVUNIML/q2OYEtcRx
	Tl/tCo/BZR0phfMjI/C3Pf0iBVKTnOatGgR/tZgsZlkxLfsg/bdxHHds6z2dlpufMudhfl/
	vXAfUDqbv89y9PWH2huGbCkJsGsi22BZmxuFPRzZ1soJXQHpLVItiNg8rwLgDC8/09MPLwC
	LNBShBHoROueXnyOWBWNW1q83TfibftdWE5kKpDZalO9gqny5oGiCc3cPVBAiiwXW15htKI
	z2UooWG1m0fXisCVoErZZcNQxSkreddyKlPRUFVmAVrDgwYPrjhhm/zmPUjhgWr/SPP92VW
	eMTzT4jfdUjsA+tPnuRsqriZPYopBGrVPmIVWzL+nwljdQ8gKhQufYggo89fion7HZectre
	cBjixpyDCyJ8+RbF/bhuqVpzroou94yFg3tkC2iCIxHx/lIlTOpZ1R0DWlSrUKu7G8Qry7I
	G5k2NAMRP0z1zX2c6mosMN+pBvr4odB3rI0cRhizdW3SpYrukjE9/ooIx0lfQE/CNrMglBo
	VNMZTYinAy7nLEe8EjjK0AaXRsjeYAFrwvPpn1zS8bt7JizZMoiT7/jTMdmZ22j/wpkmbFR
	F7hA9dF93a9ju578BliBdnAP81eusRt2ItdyS8sz3MWajgb/diNVLcl5YblZl0qAC0MKhwx
	i/qRKQKPr4USTm2IBQafR6E0ZMSsVXfMGEhWSBkr+OBzC0w1HnE35RT9WPfxzyaP35PSWrX
	dPg/dX1Z67LSOCLVrOUpmFdLzianv2RCQ8F/sD15a6ida9hof+QZH70hT4onT+G90zTUkW4
	CC6hE2nLKqrhMXEF3EAQdaXEz
X-QQ-FEAT: D4aqtcRDiqRprBrzF3WAKrTVkjK5ocIr1dSI9KzQHZY=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Ckn6AHmDYfq0V5APyRAFb4Pw+UYUu4pvz9Uro+fdP3k=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1725093360t637318
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?Y2hlbmh1YWNhaQ==?=" <chenhuacai@kernel.org>
Cc: "=?utf-8?B?V0FORyBYdWVydWk=?=" <kernel@xen0n.name>, "=?utf-8?B?bG9vbmdhcmNo?=" <loongarch@lists.linux.dev>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>
Subject: Re: [PATCH] Loongarch64: pci: fix memleak in pci_acpi_scan_root
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 31 Aug 2024 16:35:59 +0800
X-Priority: 3
Message-ID: <tencent_3A814C6056AE06E21CE86A92@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240831052157.13532-1-guanwentao@uniontech.com>
	<CAAhV-H7GptUdpKScV1AuZZm7w-F5oUXHRmaT9BFCZV4HuQExJg@mail.gmail.com>
	<tencent_3F6931DF7E765EB870FD970A@qq.com>
In-Reply-To: <tencent_3F6931DF7E765EB870FD970A@qq.com>
X-QQ-ReplyHash: 2900214901
X-BIZMAIL-ID: 6513285501017925691
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 31 Aug 2024 16:36:01 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

SGVsbG8gSHVhY2FpOg0KDQpJIGZvdW5kIGEgbWlzdGFrZSB0aGF0IG15IFBBVENIIGNvbW1p
dCBtc2cgbmVlZCBjaGFuZ2UgdG8gIkxvb25nYXJjaDogcGNpOiBmaXggbWVtbGVhayBpbiBw
Y2lfYWNwaV9zY2FuX3Jvb3QiDQpOZWVkIHRvIHNlbmQgcGF0Y2ggdjI/


