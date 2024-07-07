Return-Path: <linux-kernel+bounces-243426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE6692960D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3701F21995
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7B7EF;
	Sun,  7 Jul 2024 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReCrxwlU"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329B181
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720311037; cv=none; b=jFrMaXw4Ss7lQD4XmGtwRABdest5OWJIMmUnDfn8vHlkmD91dwJkCQUVsJBZBtKM/6+69tNgy9thwstxn7OK00xyLPEy6sg+Jh91a+uQvOolTqBit5qm2S+UqAXuzTX2737CSPR59kYdTizSH3SzRrg3ui4yD83xF5abq4Baltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720311037; c=relaxed/simple;
	bh=MVehUZlF6Vu/DFgojSa/tE2mpuA+8z5P9jTX3Y13ZvU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RkhvpguzHUJdqKGKQAXFmThzT5My9/EL1vEDr3e5B2GQ9tGdj7aZ1g08jdbPFA40Fb+uBHp8PNakkIXDa1WrbqbP378ClPRfs44tXeslVD9OfchTb9Chgmm+NtUyqfpOCq0R/7QP30upf5ijk0JSaMvUg+x6ciTW7v/iD+mw5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReCrxwlU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e9944764fso3141163e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 17:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720311034; x=1720915834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSQHzQJ3Axb1vJzMvaBtOco60Ni4GgW3nF1QDSr55jY=;
        b=ReCrxwlUy61brVzkmvINfl/1m8wtCbIbbDsyWuQ3oCtYS/rg3KIXoAFbRSN8voWtzh
         6ARhixBQ7Uners+AgY4mAagzYCfzDP9Q/61I3yTzfFmrgsJ++rDq/vP10H6bxif22FNJ
         pwlOrFLE0kY53dKQdo0mlAB7Wm1x9TuBRHrEAuO3epRUw4goLYVefuC2DxxOqjsLDfJq
         TXun+vvlpbOMIy55CcTkQw+tJ2Zq4YZZyuh6j5GPq8nfizlJEZXUt36PJpQDFM7lWH/g
         Trll8ba5l/8Dy0f4yyxvSX5uncNJW9b19eeTaWjldoDvF5fn9hXLCQ8RlZU85ZDKsGJs
         +1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720311034; x=1720915834;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QSQHzQJ3Axb1vJzMvaBtOco60Ni4GgW3nF1QDSr55jY=;
        b=jGPOk72Vl5qw4UxWYB1wtlIBFJvhRoIBfJ0upcQiCzKxrg38a63SKQiAZC7ZHlf33s
         5riXulU6LaiY+3FIfYvTgpgEiq3gYLYe4VN7rR9cQPDH1Gy58BV32+22IWb9/p4SvjjD
         BnchF/OWAFLYyWpEBK4aDffAa7oi/igJa8fFaMBcnm3sVTxtDS14UBmgojcjQoCAjlhC
         4gYJEhYL2P7x8KDsJ58WK11JFrN+h0ViTmDsGQrqM9uZELA+neIDi3NcPpBMC9mOmJkd
         vHOk0nnXOKiaPCFPUOuKP0zYnam+5Fwui1jmVOHvMt+07F/KCSulh0QlNN1a9QF7K9nX
         z4sg==
X-Forwarded-Encrypted: i=1; AJvYcCV4g5NmGhMaVmPlqmFhDo8Ez0xdU/SOGEGNwQBjJRl3eXC48hRuwfZN9h2quIT7Rb+eytNqNdRS0bD/Bk+xWIMOYt7jHDuCCRkN9KBS
X-Gm-Message-State: AOJu0Yx0A+hym71o+aVnvG2hHigdAndSEfrTvJzQqJwZhOjgFiNwImhd
	AqVUwCG5JCItKx373ReBCkvwtSyTDDHY3IGZgIQvinvBAhAKWKYt
X-Google-Smtp-Source: AGHT+IE4k7AyrHz/Dfv9N1ZosT3VQYZ2AufhQWaafj16Iqwsj5Y9kVe8oNgSVYlFxwpYqKDRU5ArBw==
X-Received: by 2002:ac2:598e:0:b0:52e:9c63:5fe8 with SMTP id 2adb3069b0e04-52ea06b77camr5191300e87.54.1720311033536;
        Sat, 06 Jul 2024 17:10:33 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-28.xnet.hr. [88.207.40.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77cf5c9fa3sm163597966b.4.2024.07.06.17.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 17:10:33 -0700 (PDT)
Message-ID: <47e0483d-6e3d-43a8-9273-25278a4a74b9@gmail.com>
Date: Sun, 7 Jul 2024 02:10:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PROBLEM linux-next]
To: linux-mtd@lists.infradead.org
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, all,

This is the result of testing randconfig with KCONFIG_SEED=0xEE7AB52F in next-20240703 vanilla tree on
Ubuntu 22.04 LTS. GCC used is GCC (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0.

The particular error is as follows:

In file included from ./include/asm-generic/bug.h:22,
                 from ./arch/x86/include/asm/bug.h:87,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/fortify-string.h:6,
                 from ./include/linux/string.h:374,
                 from ./arch/x86/include/asm/page_32.h:18,
                 from ./arch/x86/include/asm/page.h:14,
                 from ./arch/x86/include/asm/processor.h:20,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/mtd/mtdpart.c:10:
drivers/mtd/mtdpart.c: In function ‘parse_mtd_partitions’:
drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
  693 |                         pr_debug("%s: got parser %s\n", master->name,
      |                                  ^~~~~~~~~~~~~~~~~~~~~
./include/linux/printk.h:376:21: note: in definition of macro ‘pr_fmt’
  376 | #define pr_fmt(fmt) fmt
      |                     ^~~
./include/linux/dynamic_debug.h:248:9: note: in expansion of macro ‘__dynamic_func_call_cls’
  248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:250:9: note: in expansion of macro ‘_dynamic_func_call_cls’
  250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:269:9: note: in expansion of macro ‘_dynamic_func_call’
  269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:610:9: note: in expansion of macro ‘dynamic_pr_debug’
  610 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/mtd/mtdpart.c:693:25: note: in expansion of macro ‘pr_debug’
  693 |                         pr_debug("%s: got parser %s\n", master->name,
      |                         ^~~~~~~~
drivers/mtd/mtdpart.c:693:50: note: format string is defined here
  693 |                         pr_debug("%s: got parser %s\n", master->name,
      |                                                  ^~

Offending commit is 5b644aa012f67.

Offending code is here:

  668 int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
  669                          struct mtd_part_parser_data *data)
  670 {
  671         struct mtd_partitions pparts = { };
  672         struct mtd_part_parser *parser;
  673         int ret, err = 0;
  674 
  675         if (!types)
  676                 types = mtd_is_partition(master) ? default_subpartition_types :
  677                         default_mtd_part_types;
  678 
  679         for ( ; *types; types++) {
  680                 /*
  681                  * ofpart is a special type that means OF partitioning info
  682                  * should be used. It requires a bit different logic so it is
  683                  * handled in a separated function.
  684                  */
  685                 if (!strcmp(*types, "ofpart")) {
  686                         ret = mtd_part_of_parse(master, &pparts);
  687                 } else {
  688                         pr_debug("%s: parsing partitions %s\n", master->name,
  689                                  *types);
  690                         parser = mtd_part_parser_get(*types);
  691                         if (!parser && !request_module("%s", *types))
  692                                 parser = mtd_part_parser_get(*types);
→ 693                         pr_debug("%s: got parser %s\n", master->name,
→ 694                                 parser ? parser->name : NULL);
  695                         if (!parser)
  696                                 continue;
  697                         ret = mtd_part_do_parse(parser, master, &pparts, data);
  698                         if (ret <= 0)
  699                                 mtd_part_parser_put(parser);
  700                 }
  701                 /* Found partitions! */
  702                 if (ret > 0) {
  703                         err = add_mtd_partitions(master, pparts.parts,
  704                                                  pparts.nr_parts);
  705                         mtd_part_parser_cleanup(&pparts);
  706                         return err ? err : pparts.nr_parts;
  707                 }
  708                 /*
  709                  * Stash the first error we see; only report it if no parser
  710                  * succeeds
  711                  */
  712                 if (ret < 0 && !err)
  713                         err = ret;
  714         }
  715         return err;
  716 }

Proposed non-intrusive fix resolves the warning/error, but I could not test the code.
(I don't have the physical device.)

-----------------><------------------------------------------
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 6811a714349d..81665d67ed2d 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -691,7 +691,7 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
                        if (!parser && !request_module("%s", *types))
                                parser = mtd_part_parser_get(*types);
                        pr_debug("%s: got parser %s\n", master->name,
-                               parser ? parser->name : NULL);
+                               parser ? parser->name : "(null"));
                        if (!parser)
                                continue;
                        ret = mtd_part_do_parse(parser, master, &pparts, data);


Hope this helps.

Best regards,
Mirsad Todorovac

