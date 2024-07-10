Return-Path: <linux-kernel+bounces-248017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA492D773
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E351C21114
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076D51953A2;
	Wed, 10 Jul 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXB3otto"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10F194C6B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632545; cv=none; b=uMSkaiNeehOqLeTgwFTctZ7H1Hyt2TFCJnvwSi1wvNpsS5V7rfuNBr2oJS1vZY0cyCF2n5cSRPdwwtABNesTl6+IoaM0CjMcfTeAlgXiEsKPHxYHsShGtNBeigcvwFtsiIV3Z4wGuL+1lVjxB7CLxyJjbd1ak1tzVx8IFD6zY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632545; c=relaxed/simple;
	bh=bdUpP11K5ORs9ozvh2sTRYZH4YVCxqTyV+M11vU2xbM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Is8eoHUTx+mE1DsQRzSrBSRF5YfIjhpkAvaKjexzjmzNPnQQPxNCsTDBCtRjLk57iT4L4BTYDSPCfsKBzmsY8NQqiR2JDKag8XV/hZ3KMD8g7g7SLs+BEZZJQkazbTqky51Q1YFKh+ZEWhB0RPRLnbaNEEdH8kEZFq36zI4KuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXB3otto; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367940c57ddso4316535f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720632541; x=1721237341; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8AmXmDZ9UKk1+/Op1aszku3ECYfba0yWQH9jueXqCs=;
        b=YXB3ottoQ3onPPpwTMV5PXwq1uRjISS+WPJZyMsW9I+tT8XQL1YNbN7bHIkUKVhTJf
         0YRvkv8n/J4hc5OjoqgTxdVLZeXdfsjBX2c4OBKI1aYGZJjWbO9hiVVn5gS3tw5aY+ee
         ANoYhLljgLBRyWJnTcSRJ34W0VL9kl7jHRkFvkkjLXS+6JFKSCu/vQEIXK2w0x4JyxeV
         gvA5Z+8RyxkZX6t3kF5WbSnU1/H1yMCevv4hMjW82s0JhJPI6+BjH5j48NbouS57Y+7N
         3F/1vgCtp3LjnHVRdhnxB1o3luczEzyzZC4X9jS8QQdZl1Q7kSG5/2hnpyF8tV57JEW9
         9g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720632541; x=1721237341;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W8AmXmDZ9UKk1+/Op1aszku3ECYfba0yWQH9jueXqCs=;
        b=m7E/HRZQRt0y5kymmEoc//6TpEMUSUYUoUx93ofrHcou4397g+7PsjCHKr6pYIMwaR
         0AAUv4HBXWOgjNdTf5a18FEEZ/fle7AQWJj0Kk+gFTsAM1S9MGftUlQ8kSURWJ7E7aB4
         XAmIjrHxO7mPc5monpA5GjkvB0K6lNCxVKSy2w0L06fvHjFDD3kYMFhgXTXo7EdBQQcL
         4hc4hv9TsimjXRzags0efpdvCq1NlCPYXOTkwkbn9KijgpfBKcObgYydWAnnPxlRqw1A
         +uRA6Dos/JlWLFCskXSTMs9xyUM01NJ6CeS2lNs1FIhU0hve2d7UV4doVCDxmO75egaP
         5e9w==
X-Gm-Message-State: AOJu0YyAZuWMqzT4pMpGRsdqyE0+hl2+ni5q8NVW1pC+nDpJChofl0HQ
	DnyETUJYLa9SIbO24a5r2JrfXzk3SpNkS5+p15WuYioDVFP4BLms3dFCow==
X-Google-Smtp-Source: AGHT+IGEugKesaHDyp/MX6Mr5mcQL14OSWfE3NQfaJnQuXUz5fJJ8TcZCYBCzzQXu06kgIHaHM+Gaw==
X-Received: by 2002:a5d:47c3:0:b0:362:52d8:6788 with SMTP id ffacd0b85a97d-367cea46642mr6130362f8f.2.1720632541052;
        Wed, 10 Jul 2024 10:29:01 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-148.xnet.hr. [88.207.43.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab753sm5767858f8f.107.2024.07.10.10.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 10:29:00 -0700 (PDT)
Message-ID: <e3cdee98-e2a0-4991-ae6c-4d8ee687a284@gmail.com>
Date: Wed, 10 Jul 2024 19:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: =?UTF-8?Q?=5BPROBLEM_linux-next=5D_=2E/include/linux/kern=5Flevels?=
 =?UTF-8?B?Lmg6NToyNTogZXJyb3I6IOKAmCVz4oCZIGRpcmVjdGl2ZSBhcmd1bWVudCBpcyBu?=
 =?UTF-8?Q?ull_=5B-Werror=3Dformat-overflow=3D=5D?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

On the linux-next vanilla next-20240709 tree, I have attempted the seed KCONFIG_SEED=0xEE7AB52F
which was known from before to trigger various errors in compile and build process.

Though this might seem as contributing to channel noise, Linux refuses to build this config,
treating warnings as errors, using this build line:

$ time nice make W=1 -k -j 36 |& tee ../err-next-20230709-01a.log; date

As I know that the Chief Penguin doesn't like warnings, but I am also aware that there are plenty
left, there seems to be more tedious work ahead to make the compilers happy.

The compiler output is:

./include/linux/kern_levels.h:5:25: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
./include/linux/printk.h:462:25: note: in definition of macro ‘printk_index_wrap’
  462 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                         ^~~~
drivers/mtd/devices/slram.c:52:25: note: in expansion of macro ‘printk’
   52 | #define T(fmt, args...) printk(KERN_DEBUG fmt, ## args)
      |                         ^~~~~~
./include/linux/kern_levels.h:15:25: note: in expansion of macro ‘KERN_SOH’
   15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
      |                         ^~~~~~~~
drivers/mtd/devices/slram.c:52:32: note: in expansion of macro ‘KERN_DEBUG’
   52 | #define T(fmt, args...) printk(KERN_DEBUG fmt, ## args)
      |                                ^~~~~~~~~~
drivers/mtd/devices/slram.c:304:17: note: in expansion of macro ‘T’
  304 |                 T("slram: devlength = %s\n", devlength);
      |                 ^
cc1: all warnings being treated as errors
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:244: drivers/mtd/devices/slram.o] Error 1
make[5]: Target 'drivers/mtd/devices/' not remade because of errors.
cc1: all warnings being treated as errors

The problem seems to originate from pre-git era < 2005-04-16 ^1da177e4c3f4 ("Linux-2.6.12-rc2").

----------------------------------------
drivers/mtd/devices/slram.c
----------------------------------------
   277	static int __init init_slram(void)
   278	{
   279		char *devname;
   280	
   281	#ifndef MODULE
   282		char *devstart;
   283		char *devlength;
   284	
   285		if (!map) {
   286			E("slram: not enough parameters.\n");
   287			return(-EINVAL);
   288		}
   289		while (map) {
   290			devname = devstart = devlength = NULL;
   291	
   292			if (!(devname = strsep(&map, ","))) {
   293				E("slram: No devicename specified.\n");
   294				break;
   295			}
   296			T("slram: devname = %s\n", devname);
   297			if ((!map) || (!(devstart = strsep(&map, ",")))) {
   298				E("slram: No devicestart specified.\n");
   299			}
   300			T("slram: devstart = %s\n", devstart);
 → 301			if ((!map) || (!(devlength = strsep(&map, ",")))) {
   302				E("slram: No devicelength / -end specified.\n");
   303			}
 → 304			T("slram: devlength = %s\n", devlength);
   305			if (parse_cmdline(devname, devstart, devlength) != 0) {
   306				return(-EINVAL);
   307			}
   308		}
   309	#else
   310		int count;
   311		int i;
   312	
   313		for (count = 0; count < SLRAM_MAX_DEVICES_PARAMS && map[count];
   314				count++) {
   315		}
   316	
   317		if ((count % 3 != 0) || (count == 0)) {
   318			E("slram: not enough parameters.\n");
   319			return(-EINVAL);
   320		}
   321		for (i = 0; i < (count / 3); i++) {
   322			devname = map[i * 3];
   323	
   324			if (parse_cmdline(devname, map[i * 3 + 1], map[i * 3 + 2])!=0) {
   325				return(-EINVAL);
   326			}
   327	
   328		}
   329	#endif /* !MODULE */
   330	
   331		return(0);
   332	}
----------------------------------------

NOTE, in line 301, in case of lazy evaluation, if (map == NULL, then (!(devlength = strsep(&map, ",")))
will not be evaluated, and devlength will not be assigned.

As a diff speaks more than a thousand words, here is the proposed fix:

----------------------------------><-----------------------------------------------
diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 28131a127d06..8297b366a066 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -296,10 +296,12 @@ static int __init init_slram(void)
                T("slram: devname = %s\n", devname);
                if ((!map) || (!(devstart = strsep(&map, ",")))) {
                        E("slram: No devicestart specified.\n");
+                       break;
                }
                T("slram: devstart = %s\n", devstart);
                if ((!map) || (!(devlength = strsep(&map, ",")))) {
                        E("slram: No devicelength / -end specified.\n");
+                       break;
                }
                T("slram: devlength = %s\n", devlength);
                if (parse_cmdline(devname, devstart, devlength) != 0) {
--

Hope this helps.

Best regards,
Mirsad Todorovac


