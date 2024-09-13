Return-Path: <linux-kernel+bounces-328342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BFB97823E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86F71F26483
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719EC1DB559;
	Fri, 13 Sep 2024 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MpiCBDvX"
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621C2E419
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236366; cv=none; b=RspHEoH5QA/YKwDqXgQqeIMCxRu37z+CNrTC4IT+V7sNkhjryyB6YnDAxf4/8FeH0sZtVAP4THmV9R5qjEGE/QRcT19T7/ZZqD5z2cE7qRwOXcwriyyxVE+5gRnQuvgsodEdYFSBj5ywO+qdHf8bg9Mxmx6cocy9byGyBFXznLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236366; c=relaxed/simple;
	bh=8IfXxd5C0CAeXKIkfZAQxJGYyptP8S5ILxf2PeIDRI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XyCka3PkSwK/r99+qn9LpUYTYvBNZ9AylLom2bBx6Emt4bXWcPIOjYNJrV0hWmFpWbgWDaMoi/jWj1QfpHa9iXLA0IId8GHp2dpHENnpPXtJeP0LYpo+h3jl2GzSJtPreFJfZhImPSFmnXUNSVztAtyBQ8J8W2RVHIsWdmEQklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MpiCBDvX; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726236362;
	bh=ZYfUUZ141zHxiPPsqf0nTB169UUiFKPgVdLj8pY3QEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=MpiCBDvXTNoItlfEhoRLK3R2NWzIQptDnQyKQx90p2nztr/k5FFlc0qOkvlyvxiMA
	 SZ/TA1mZ2qrJqH3IaK6NfQ4Of/ATOQMqrZPYjjfn/3UPHYEBFcUMjWkMyW5D+OYi+2
	 keQ8bCrFsAyNzk9Nz/uwLIToaJGpKrsjUnwAnTUwcacqYZv21O+6HXbtnlSdLJLI0H
	 pDtukZAbaDlD5HKTSYQxPQJnPCc5FehzulPtdmc+crxmVV2h8DWgqsz8g6dVdp4P0v
	 a2W5SJmY983O95QQ4iTWsQwNi9qhP6nJ/EDq602IkGML45FRiGKSDvBqMVkkqo3CVw
	 iZ71ZnH7YRg3w==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 519DAC8048C;
	Fri, 13 Sep 2024 14:05:57 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 13 Sep 2024 22:05:38 +0800
Subject: [PATCH v3] driver core: Explicitly initialize struct member
 @data.have_async in __device_attach()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-fix_have_async-v3-1-793707cfc0d1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALFG5GYC/33MQQ6CMBCF4auQrq1hOm0FV97DGFJKlVlYsNVGQ
 ri7hZ0LXf6Ted/MogvkIjsWMwsuUaTB58BdwWxv/M1x6nIzUQpZVgL5ld5Nb5JrTJy85WgAlYa
 qq6FleTQGlz828HzJ3VN8DmHa/ATr9SeVgAOXaFDJVmuQ7enxIkve7u1wZyuWxH9AZMB1UGKtx
 AG1+gaWZfkAsoYw3e8AAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: hzoEQMOsQd7s2kI0rYjA4eGjx2g_gZj2
X-Proofpoint-ORIG-GUID: hzoEQMOsQd7s2kI0rYjA4eGjx2g_gZj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=874 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409130098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

__device_attach() defines struct device_attach_data @data as auto
variable and needs to use both @data.want_async and @data.have_async
but it explicitly initializes the former and leaves compiler implicitly
initialize the later, that does not have an elegant look, solved by
explicitly initializing the later member as well that also makes @data
have full initialization.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
IMO, this change still has a little bit of value as explained below:

- Looks at below similar commit:
Commit: 8f45f5071ad2 ("gpu: host1x: Explicitly initialize host1x_info structures")

- This change's initialization way is obvious better than

struct device_attach_data data = {
	.dev = dev,
	.check_async = allow_async,
};

which is better than current

struct device_attach_data data = {
	.dev = dev,
	.check_async = allow_async,
	.want_async = false,
};
---
Changes in v3:
- Correct commit message.
- Link to v2: https://lore.kernel.org/r/20240823-fix_have_async-v2-1-ed1039527365@quicinc.com

Changes in v2:
- Remove both fix and stable tag
- Correct both title and commit messages
- Link to v1: https://lore.kernel.org/r/20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com
---
 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a7cc7ff0923b..9e8596773e7f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1021,6 +1021,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			.dev = dev,
 			.check_async = allow_async,
 			.want_async = false,
+			.have_async = false,
 		};
 
 		if (dev->parent)

---
base-commit: efb0b309fa0d8a92f9b303d292944cda08349eed
change-id: 20240823-fix_have_async-3a135618d91b

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


