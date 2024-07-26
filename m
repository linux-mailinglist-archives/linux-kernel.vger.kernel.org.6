Return-Path: <linux-kernel+bounces-262800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA4693CCDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD566281766
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958CC2261D;
	Fri, 26 Jul 2024 03:10:12 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BB442F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963412; cv=none; b=QvLpMVrPOUHyOLF0pG94iZZATR2dfdvY+e6wJ30KxkSy9zC9wFHGHEItmQSbyI0o2O4gjydcEVYLHym5H5dj2MaDM3lCeHCddRbL+EXGBsOnFMAjwM3ZVZz6/ik8fRVWsG8rlyQGL+R1sgu8iee44nDG17dLz9YR9aLgsxjRmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963412; c=relaxed/simple;
	bh=HcGe5MJGH/5nrBPoD2goDolcSdmiiYUC88mls8ZpcJc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RsOfcUB1NyOZkGBCEPxdIctzVFQc/nuQLYTn06+Hnid2dA0Lq8WIlCuLAt0EksPnU0J+I0t5sf5qAWF404HxjtZvBLqYvYC7COgJzqOP3GqOt4LuHzTTBo9DDYp2N33vJUuH6DMrf5YOA6sYsfiVG4l5+yJmIAv3u0YwV+IMdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81ad0e64ff4so113772439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721963410; x=1722568210;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+a1OruDD4UQp+lhS2oGooDufFdUOzZSf+EYWL06wo8A=;
        b=Bw2pT6tUTKRCiuJZz/sPj0pfsS3mz9NJcmqRnFha4srQQ7HBPUyqa0wzLVXY8CtTa/
         ApbOemIOkqDphmcesf9VfwuE2wYwE/Gv9OF8UMra3Z+zifNtzpcDJAmyxDWhPar7yQtV
         UoKFfFmvN8jWR8hspWFt0g8LYPJK6yx6UX87Ia/CNvCivP1bF+tclGdXWuUEpUwVH4h6
         ZLHEiO/3JmXtvN0A+Hb2cr+8AEypepPvKrtt0dwVm+y1IPJ99irp9fP9gOTBDY8h7Avb
         EZI4k4KG7IQPFT/+sW8cqAKK7RC7uCdq8nwCeCVDkFYXdA3L/8+UTngmSgZ/381Gpk9O
         nr2g==
X-Gm-Message-State: AOJu0YxzhdKJ1xplILWm/oLaiGEUFksrG81cvlqII5bBmxfpciG+4Owc
	Nk+KmlSyk6FQ1UXpzb3O7Ds/s6LGDR7k/wWGOgQ6TwfuaJqe2bNg1eFd1ZnqBcpbcKqcH66BbFQ
	BXKx1tiJxPjEExQ9gCEf9s877i25LR46/IQdQ9AXL/i6xbHKFPxWGCXU=
X-Google-Smtp-Source: AGHT+IGJSO2Jij9j+HOrh6d4VdYbscyy9ttta8hzdobTtFlZtMvmPs3sc4EYQjx3FRW4lzFH7Ir7sC44LYV4EZ/PAVS/8oob98bM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:628c:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4c2a1206df1mr151177173.4.1721963409956; Thu, 25 Jul 2024
 20:10:09 -0700 (PDT)
Date: Thu, 25 Jul 2024 20:10:09 -0700
In-Reply-To: <000000000000391c1d061e1656a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005df2a4061e1dd9a1@google.com>
Subject: Re: [syzbot] Re: [syzbot] [wireless?] [usb?] KASAN: use-after-free
 Read in rtw_load_firmware_cb
From: syzbot <syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [wireless?] [usb?] KASAN: use-after-free Read in rtw_load_firmware_cb
Author: lizhi.xu@windriver.com

if firmware doesn't exist, don't run cb

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 933069701c1b

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index da8ca01d011c..ce2e996be3d9 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1159,12 +1159,14 @@ static void request_firmware_work_func(struct work_struct *work)
 {
 	struct firmware_work *fw_work;
 	const struct firmware *fw;
+	int ret;
 
 	fw_work = container_of(work, struct firmware_work, work);
 
-	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
+	ret = _request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
 			  fw_work->opt_flags);
-	fw_work->cont(fw, fw_work->context);
+	if (ret != -ENOENT)
+		fw_work->cont(fw, fw_work->context);
 	put_device(fw_work->device); /* taken in request_firmware_nowait() */
 
 	module_put(fw_work->module);

