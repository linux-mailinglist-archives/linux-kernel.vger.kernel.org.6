Return-Path: <linux-kernel+bounces-523140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90929A3D297
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAAC3B6C60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FC61E3DF7;
	Thu, 20 Feb 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bd+Da69k"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4953FD4;
	Thu, 20 Feb 2025 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037671; cv=none; b=OXbZiIA9APU5/pNAxaYg0awtZt8u9mSW1hc9B5wbUa3FgNIock+q9aQCuV1jPoZIM69DAwuNdeultjVgwGjyN0imKV7EvW9g6+orpD8a/9dOP4Yub7HnITsjOoGQgwobw/GAncabpz8/S3nAde32aMgdB3tyTEwYP6XTqamlZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037671; c=relaxed/simple;
	bh=Zgt/U1cvabUnX93OXZk0Fq0VFi6sYuEjoK8M9eDjZmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SwDEe/K/Ad/eunzjkKTsaxM5IaOruEwrxWxvxkvtug6mOKeVKe5A7AXuZMbea+xd7vIPWEP+EaImjuo5J9EUAjEnG/OTRuyYE5dIM2oeWFUzY/cct7PDhCQBeqUIiqgAOeRcF5usA2ITjU5oed7UcU88wPrwpFto2BkYpCbupLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bd+Da69k; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Rkcx24TA4MdGm3cT8T
	BpfbzjtZE4POuH/u4Yyc3aCQ8=; b=bd+Da69kgC9q2YkEPC5cLrEmqxLTUAVogn
	zuUJwHQ22jIXV8T8NcY1Nmb6/JOKU/fKXyAlYMNpCGGOFBD0+rgllByGrjv86zib
	S/L2c3n776Nbw+NfqIvjNOEKl4iRpTgY5KzHauc+QH6slVX9Zes3mA4rWCxxBk/Y
	JKrwwaD4Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wB3rvns3bZnkUJpNg--.12450S2;
	Thu, 20 Feb 2025 15:46:53 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	corbet@lwn.net,
	jdelvare@suse.com,
	krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	wenliang202407@163.com
Subject: Re: [PATCH v4 0/2] hwmon:(ina238)Add support for SQ52206
Date: Thu, 20 Feb 2025 02:46:32 -0500
Message-Id: <20250220074632.5003-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c7c3d35a-e8a5-40ee-9b47-c22d87fa7f71@roeck-us.net>
References: <c7c3d35a-e8a5-40ee-9b47-c22d87fa7f71@roeck-us.net>
X-CM-TRANSID:_____wB3rvns3bZnkUJpNg--.12450S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFy8ZF1xuF18Jw1kuw47CFg_yoW5Ww43pa
	93GF4rCryDGr17XrZ3Kw47ZryYkas5JF18Wr13Xw1rua4Uu3WxWrW29w1Y93Wqqr9avFsY
	yFySqFnxKF1UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUKYL9UUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiJRr502e2189yaQAAsH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

At 2025-01-25 13:01:36, "Guenter Roeck" <linux@roeck-us.net> wrote:
>On 1/24/25 19:02, Wenliang Yan wrote:
>> Add support for Silergy i2c power monitor SQ52206 to the ina238
>> driver as those two are similar.
>> 
>> Signed-off-by: Wenliang Yan <wenliang202407@163.com>
>> ---
>> 
>> Add new chip SQ52206, the datasheet depends on
>> https://us1.silergy.com/cloud/index/uniqid/676b659b4a503
>> The password is fx6NEe.
>> 
>> Changes in v4:
>> - addressed various review comments.
>> - Link to v3: https://lore.kernel.org/linux-hwmon/20250117082017.688212-1-wenliang202407@163.com/
>> 
>
>Your "change logs" are equivalent to "made changes" and completely pointless.
>As consequence, I'll only handle your patches if and when I have nothing else
>to review since I'll have to figure out myself what you changed and if you
>implemented the feedback. I don't really hve time for that, so please do not
>expect that I'll apply this series anytime soon.
>
>Guenter

Sorry to bother you. I'm not sure if the description of the "change log" in
the email I replied to you on January 25th was still too brief
(https://lore.kernel.org/linux-hwmon/20250125064432.1242713-1-
wenliang202407@163.com/). 
Therefore, I have added more content again, hoping it will be helpful to you.
At the same time, if you think any part needs adjustment, I will cooperate
actively. Looking forward to your reply.

There are two main changes in the V4 version:

1) add 'Acked-by: Krzysztof Kozlowski' information to PATCH 1.

2) formatting adjustments have been made to ina2xx.c in PATCH2 with
Christophe JAILLET's comments.(https://lore.kernel.org/linux-hwmon/
5f4095b0-8105-4001-81ac-e4f7053e45ae@wanadoo.fr/)

Including:

1.Change 'sprintf()' in the 'energy1_input_show()' to 'sysfs_emit()'.

2.Move up the "enum ina238_ids chip" line in the 'ina238_probe()'
to keep RCT style

3.Remove the last comma when describing 'ina238_of_match[]' to keep the
format consistent with the 'i2c_device_id ina238_id[]' structure

4.Change the '5bytes' in the description to '5 bytes'

Thanks,
Wenliang Yan

>> Changes in v3:
>> - addressed various review comments.
>> - Link to v2: https://lore.kernel.org/linux-hwmon/20250113035023.365697-1-wenliang202407@163.com/
>> 
>> Changes in v2:
>> - Explain why sq52206 compatibility has been added to ina2xx.yaml.
>> - addressed various review comments
>> - Link to v1: https://lore.kernel.org/linux-hwmon/20241224063559.391061-1-wenliang202407@163.com/
>> 
>> Wenliang Yan (2):
>>    dt-bindings:Add SQ52206 to ina2xx devicetree bindings
>>    hwmon:(ina238)Add support for SQ52206
>> 
>>   .../devicetree/bindings/hwmon/ti,ina2xx.yaml  |   4 +
>>   Documentation/hwmon/ina238.rst                |  15 ++
>>   drivers/hwmon/ina238.c                        | 209 +++++++++++++++---
>>   3 files changed, 195 insertions(+), 33 deletions(-)
>> 



