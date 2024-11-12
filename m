Return-Path: <linux-kernel+bounces-406165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC019C5BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC211F21767
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D88200B80;
	Tue, 12 Nov 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="O+q0NhC5"
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2C2003D5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424532; cv=none; b=sofJGuTI6DSK8hnbwr83w5zb3YuuWCDVOwDPBBiWMVFl0IK/TBVnBrISxtEWkDA2ldeOMyfDEU4vMdgrhYAyg9rMoJ5tS9QRDQ4DdFItbeXgErvLW8MKEmwVBWIUyQ7DF4WFlsgCpNyQ46RkiZvNfn6LEVnLzmgMT/s98oYHQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424532; c=relaxed/simple;
	bh=/SKsG+DPlDXd4H4lkEVlrdtGk0N07IDuhAp3EdF+6IA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YMWfgXt17uNcegGO/ZOxUqU1EA1hfbDSbwpm6/Rp5dskgZ5Jsu9Oxw50mG+Ur9GKwAg3SEwO79R9bytY/dplW5BIE3JMxHpvALn26PjRtBhCwtCAgzimAU0goyxui1Cb0P8V09slZ5EvqVqmWqa7+99vDIax6q0mxWgijCyip4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=O+q0NhC5; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731424530;
	bh=k2JOSRBRsqmpWpGJa5UvRFiQHBKoGOzxBeKlHNvbkPw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=O+q0NhC53PoNX6YUtlhYinEDc0Oyj+v7IdcnpiGuXF82dFjmPlnRrRtpF8L8t0/UQ
	 pnLC01YIz0n7Mo4XL+3Dukmtf78jkknbH9s67QfmKAuHoy+3eBskPFrdSnB6P1mYKi
	 Shwx/6Xj0UzLOx0O/b4xDfdBLjmlmcBkP5Yd2mzhNOdIQMFlZuZ5zHyEN5sA3hDQf3
	 ovUC6VGIJip349cVriSYHvqmsDJuftQcCPoj1cSdImFlmE8AxAcLYNBAAPyfLWoPVy
	 l0YNAzs4F4fhVhu1sE5ZuMaa3MwljivUCAwW/booy8eEyXYTBxw4m2apTAJWhdUvOO
	 YlWU4mmjY5XTw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 913EB3A03E4;
	Tue, 12 Nov 2024 15:15:26 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/2] driver core: class: Fix bug and code improvements
 for class APIs
Date: Tue, 12 Nov 2024 23:15:11 +0800
Message-Id: <20241112-class_fix-v2-0-73d198d0a0d5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP9wM2cC/03M0QrCIBTG8VcZ5zpDZbPZVe8RI5zTdqC0PCXF8
 N2zQdDl/+PjtwC5hI5g3yyQXEbCGGrITQN2NuHsGE61QXLZCsFbZi+G6OTxxbzYqXHSbjRSQv3
 fkqvzah2H2jPSI6b3SmfxXX9K96dkwTjrea+U11q3pjvcn2gx2K2NVxhKKR8VIvLopAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: xppyJXySun7Z1BkdHVzLW3M45YMtGZly
X-Proofpoint-GUID: xppyJXySun7Z1BkdHVzLW3M45YMtGZly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=545
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411120122
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to

- Fix an potential wild pointer dereference bug for API:
  class_dev_iter_next()

- Improve the following APIs:
  class_for_each_device()
  class_find_device()

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Remove both fix and stable tag for patch 1/3
- drop patch 3/3
- Link to v1: https://lore.kernel.org/r/20241105-class_fix-v1-0-80866f9994a5@quicinc.com

---
Zijun Hu (2):
      driver core: class: Fix wild pointer dereference in API class_dev_iter_next()
      driver core: class: Correct WARN() message in APIs class_(for_each|find)_device()

 drivers/base/class.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)
---
base-commit: 9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
change-id: 20241104-class_fix-f176bd9eba22

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


