Return-Path: <linux-kernel+bounces-316478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF6896D021
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8921C23953
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6A192D79;
	Thu,  5 Sep 2024 07:11:19 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C5188A37
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520279; cv=none; b=Fnf8gbRSnZicldHBI6wlOxYJM+kov/H4/FJnUYMwwwEElPC5qfi/nWAATlX8l78BkLdCAor8jGtbMDU22ADMTlhZ/ss/oVTqKve6qVEj7RQ5qYIRryxhnZyh/VxnDtCGNBp6zkeqVJfPFwnZ2s2dHmfuYj8j+Hr6SfZ4C9cRfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520279; c=relaxed/simple;
	bh=XdIjWh2yXfdFFkyPhbaUBfOFbDw1PnS2KTvQrl/NHLs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tY0qSbkr7CPtow10bKppu96/naFWntA7gnxpdnsMJ+njOZz79dba8glTKUVYPKZAppWL0kfs4KXS5oJYStPrExJTc5w0bGTjzzoOAMjZ5N5+t5dX4sa7OEU+4GvGtUxSmQIBJnv9MQa5Y4zZV86JMMafdQRL1R8Ezc39fqbv/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a4f65fa5aso257923739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520277; x=1726125077;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Arp/GsO4dUaOx+Wy6/ccqHPT254qDuThY/EdNkUzFzs=;
        b=eZwgOQXlxB78bsKYnG/dbTfT1OKsAYE1/ogbzzikwhWIOP199bXiXF1phHoEjje6vl
         svNnYcVXu8kFBnBtMkjL3HUfBWvWVSGRkuvOP6fo1axDcMMuxP5HQpt3Bmf9i+AFTykQ
         fgDh5tEtU/Am1fNP31AmTa0aZQ8DL1J/KqPvf7YIaBlcFhGCa2paQWtpW6eVrXznb3Nn
         nJ/HeqX+UELdNAN/OfRTbL49wheGCmBY5d2Y2hG7YVdL3a0aMtxIvaM7JSZg4KJzxOu7
         H4tgFf0VHD7vqKaN6/8z23wJNrryVjlSe3P+/RyQI0VsuQBe8oNg0HuSfo6pd9Tpy3dr
         XupA==
X-Gm-Message-State: AOJu0Yy8FMeKZrm8VjTlUzSKCop0ylb6odGFhA89hidSSgK/qF2QlJ3i
	XtH5rxqHzFntIQChoq1VcrpuDyGU2LhXwluvXuD6LAk5ZqKRmAj/wU+fU/ECzaYnYDeYoMvPYG4
	P3Z6UkcJr0uUuoWPLfeRm9Aco741DOVY70hJ6/4u8CnGq7op1IZa5WTA=
X-Google-Smtp-Source: AGHT+IEjR8bIaGIIXDTx4RXjbQy06ITSm/J0MufrLq7XL9vEMEtcpU6WnnQW05nk76J2J582R+N3hgDUt+QCrGaOues+iv7rzjt7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2503:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4d06011d262mr186643173.3.1725520277004; Thu, 05 Sep 2024
 00:11:17 -0700 (PDT)
Date: Thu, 05 Sep 2024 00:11:16 -0700
In-Reply-To: <000000000000407108061e0ed264@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029fa5f062159ff74@google.com>
Subject: Re: [syzbot] Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
Author: lizhi.xu@windriver.com

Short write.
User input data maybe invalid, clear the data buf of the user data before copying from user.

#syz test

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index e9ddaa9b580d..b653bed40a13 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1586,6 +1586,7 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;
 	}
 
+	memset(&buffer[USBTMC_HEADER_SIZE], 0, transfersize);
 	if (copy_from_user(&buffer[USBTMC_HEADER_SIZE], buf, transfersize)) {
 		retval = -EFAULT;
 		up(&file_data->limit_write_sem);

