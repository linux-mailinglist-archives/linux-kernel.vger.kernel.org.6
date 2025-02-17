Return-Path: <linux-kernel+bounces-517709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997F3A384AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE323B76FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63CC21C9F0;
	Mon, 17 Feb 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezSxNpYi"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46921ADB7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798679; cv=none; b=frDydW8wM82l89ssYFLMrt47uOcVyj6OnviMVolW57EzyBzHM+o17SwqtZMZTIeYcXHG+2dzzPHiPaUdoI8GUClAf74c1myj9UacT5ia9d8RYTOHgw/oUbLQFEXmMBAcOALA6/naMiON26BDl4duwwI3ATuE+cmU+oEik5QmpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798679; c=relaxed/simple;
	bh=lL8lXu7MvZnCLK6gLLAQcAfsvfo6fwcjkoNO6YE4k3E=;
	h=Message-ID:Date:MIME-Version:To:Subject:From:Content-Type; b=KmJyLo+dHm3d7m+DjmAxkqrkAJraq/AmgejPw8c7uEOBI5voHeCp+3F4FlWvnALFKMDE0j3jf7d/ArQonIMRodjKNAF6CMtgadWshJfY6oMpcHhgIS8YwHxDkBwvpglx3nDscxNpoLnKLQQVvo8jgvnqVesQVQwsuAI/PcgGOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezSxNpYi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f768e9be1aso43286807b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739798676; x=1740403476; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9UDxOMqPg15gSOK7rUm5UQP+79Q5az5rgNjpHqZZAM=;
        b=ezSxNpYiDIjUOe1ynCfn0CyyyslIXug2dfogaIurF+SovkxwH9ptrugxpF7n8GXVsS
         hQAet+BrFMFulfseKDHmeVVzTeM7aXF7Fa6QS91h/ateROhnOU4Mzdt1bVb/Mlac+kgH
         2/Mdv3QXUVNUDo2adLQz4vyqFrVEHaeW45h1VlxB70iMeovqGx/qPD1HjrHAFDgaSB6/
         YC8ZDgPRHLCm2zkfrVzbYFvdGzh4huRYX8oUWFUOydSdI4O+IElcQctegO+oPjAJ7N/d
         9yeDtkt/O4UIbV2ko/2WWAwtM6eMN9Jg1VQFDgWb4ITpt74sRRNgfl9wBAnaUme4/+I1
         2Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798676; x=1740403476;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P9UDxOMqPg15gSOK7rUm5UQP+79Q5az5rgNjpHqZZAM=;
        b=whYJkASwU6/HhuzmOskrD35LmSk7nsuFYWbnYJaTO94qA9aI0nUa6+AynleWjzFAVK
         RduF4tlI/jYUwImSOFaC5xZITFvRL9y/VdqFIqG3et3ZbDjgvw9qfEHuWl/fE0HWhNod
         De9bDiXnlyFW559K5BfeuLlpq/BT4BvIvrRyap1weUsnYANC6zM8iSwAzPxf8JaD/HHY
         /zjolCN12zOj8fdyEcnN6b04q142frMHRXSAkYktvdZJw66onYsy1bG7o9HPhnaijY8N
         tbC6cgfLLkmYJG04CeugqRKAVnWx90Is5ataW8xe7UktHuHdONpm4bhlGB/9xrs+d6u2
         5pAw==
X-Forwarded-Encrypted: i=1; AJvYcCW1SvI0E6AJsQOaayAP8n2ORzZB68EGLEvEgRSl633PwjU9YLxOxlirFc9cQY7tnoh2ro/kbl7hw7Jv0kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqCnce+O2ZbE+sjg4jNJMaTmXdIBKrPtF4CQDHGPVpYTU+jgj
	NZcF8j2NBFpADi/cKkvJRUfeqrr8RuhFKxdOQmbDvJVFWNTGM++t
X-Gm-Gg: ASbGncsnyfhyv+SvLkb25AYBpIAOJflhl0SZlvpuj/9wFRD+VZtdjdZHvq4ES5GahB2
	RIuUlTzu4QQdJKEmEkcHaZJ9lY3UBmm+WnMe76vI57zRB2Ol8vYvMgmJ6EM0IiGVDz36dfQBx6q
	j5hKdov6HbNvublZ3x7fwbHcMjTLNqQWLIWJtrkNpo+lQdFv9OpakLO6/GvlTdwwrk3XIvGiyg2
	ZPvqZ16ceCikwheyPmJa7A970s3CHOobcKFYB2zeqTwTu3rmxXx/92Hm9Zd5baqwx11A2FEpgYF
	937QTiPrw/xXSE0zgdMeeye/ap5nuv4hImeGWSY19w==
X-Google-Smtp-Source: AGHT+IF/RJ1kUREAalimaVm5FY124IyhsJBxFWPD95K5398MGwlE4Z37QEyheWCUJexj/KJROctS9w==
X-Received: by 2002:a05:690c:688f:b0:6f9:4b81:3dc7 with SMTP id 00721157ae682-6fb58a1d762mr69387017b3.1.1739798676364;
        Mon, 17 Feb 2025 05:24:36 -0800 (PST)
Received: from ?IPV6:2600:1702:2480:14d0::48? ([2600:1702:2480:14d0::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb361cabfbsm20749817b3.113.2025.02.17.05.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 05:24:35 -0800 (PST)
Message-ID: <71ea150b-9ea0-3e49-6195-ebbe761bacb1@gmail.com>
Date: Mon, 17 Feb 2025 08:24:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 "christopherericlentocha@gmail.com" <christopherericlentocha@gmail.com>
Subject: [PATCH] Fix two Acer FA100 SSDs from interfering in one PC
Content-Language: en-US
From: Christopher Lentocha <christopherericlentocha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


In order for two Acer FA100 SSDs to work in one PC (in the case of myself,
a Lenovo Legion T5 28IMB05), and not show one drive and not the other,
and sometimes mix up what drive shows up (randomly), these two lines of
code need to be added, and then both of the SSDs will show up and not
conflict when booting off of one of them. If you boot up your computer with
both SSDs installed without this patch, you may also randomly get into a
kernel panic (if the initrd is not set up) or stuck in the initrd "/init"
process, it is set up, however, if you do apply this patch, there should
not be problems with booting or seeing both contents of the drive. Tested
with the btrfs filesystem with a RAID configuration of having the root
drive '/' combined to make two 256GB Acer FA100 SSDs become 512GB in total
storage.

Kernel Logs with patch applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: Ignoring bogus Namespace Identifiers
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme0: Ignoring bogus Namespace Identifiers
nvme0n1: p1 p2
...
```

Kernel Logs with patch not applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: globally duplicate IDs for nsid 1
nvme nvme1: VID:DID 1dbe:5216 model:Acer SSD FA100 256GB firmware:1.Z.J.2X
nvme0n1: p1 p2
...
```

Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
---
  drivers/nvme/host/pci.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9197a5b17..950289405 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3706,6 +3706,8 @@ static const struct pci_device_id nvme_id_table[] = {
  		.driver_data = NVME_QUIRK_BOGUS_NID, },
  	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
  		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
  	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
  		.driver_data = NVME_QUIRK_BOGUS_NID, },
  	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
-- 
2.38.1


