Return-Path: <linux-kernel+bounces-351811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9007299165B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C2E1C22158
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309413DDDD;
	Sat,  5 Oct 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NymxkTjd"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4AF9FE
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127316; cv=none; b=niyg08AG2JI4yo1DQFoh7t22X//eMNYDP0PXKu7sAUBs8puB/qDGIpwDVZhCU9HtaUVv8T4TCEdTXTJD+n5owGtKv5Q6eGZOi7TJOh+NM2hd6PAhAMVf0f4sjxgPbF35iFXB6GyKDt3PMH++EEnE/VtRk7mqPM1h4lbzGpZPsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127316; c=relaxed/simple;
	bh=RwOppEs9pChEeqy3ECnE8LIpbPdL87Kk8otfqZ4bRz8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=EBmb/jQL5giloLj2DKcLj/n2fDB31iZ0y9G0Qf3BnPZjvzoQzw3uaJ+Qq2IqU3GqQOysFbQJRT7zWLokTpU8NiHxDDsri4lIsfdwxSdYsGcqGNun87UQC19K4vhDf5R4vvLbbRlSh9b1QoY/Bty8GZ0Q1yB8Xyyz/0SYI/S9UvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NymxkTjd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cc84c12c2so1576821f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728127313; x=1728732113; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sUxzih5dkiEWBkMrM77iQA4M8O9bWU3kN2b6VHPMjbM=;
        b=NymxkTjd+9oZEBaab3eqAJ+Qx7O2eHRjUHKB5aPtZR4Ft9zvptM5ORHQw5qF9Br7kE
         5TJ1vFiBYfHax1erHzvesnW++UfmiX4eWvTsn9zkd267LHnKZv7LbnRdXzjQLQL7bKNb
         FU5LVX07OS0TXcEwcb8+1SePAEF4UQOc3HBCB3dVadmZnK8SyZ9v6fGBFRGpztpv3MUj
         aGS99VSxklqsMqldApIteyGzGB+us3yxbMJhGOXi6yt8Y3bizi11BUT9SXwmzdX/UK3O
         f+pCUOzhe0GLvKVWsVNXt4CQtNwb1D3RZ04BHaw8dN04eIO79/8DJujBRk/sSrbRRMzG
         4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728127313; x=1728732113;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUxzih5dkiEWBkMrM77iQA4M8O9bWU3kN2b6VHPMjbM=;
        b=P2ei4VwzKGyFmAfGOj6dhL7p3DyaTR5jhzzG8cdU6AsYMAIcQ+ms6sKnWkgDs+5vVQ
         mzSg/WZi4vSBZuneJCx0SNM3w1ou6y18T7yvXNCYPlpTxYOfD+RXXxhVp/h0iToIhR90
         fKVHjWK1apZkNmbjGK9n8lkcfPsKEo3ja6xGB3PXwKvxKA6KCctXFKRwUwX4KXLvqyqU
         dsZfBFb3dXZ2Pot8zugMJHK25Ogi69sg6+JRJZGV8eNldoI/ZKEx3j013Bus3zhUhyPY
         248//5wdnwUvHjP35iFBKVfcM1PyLzqwt7FgdknwsfjPXnljSUGzJQH/TR8PN8C2LMKy
         Rblw==
X-Gm-Message-State: AOJu0Yzbn+2rEm9u/9RRnXIVGb5PSDzl0GCzCYv2ZnSaXsEjAu39f9fp
	XeqiGCNnbAKO6qFB1ULixEpTSWv6eWIDk2L6n7JSsqo7kTK2/jaH
X-Google-Smtp-Source: AGHT+IGRnpzpSNu7HIIVf+veHOn8vKU3np0ZaOluSRP2iT5WLfY9kN4UeM2JJ7zxLTqMkCIlQQJ9KA==
X-Received: by 2002:a5d:4d4e:0:b0:371:8f19:bff5 with SMTP id ffacd0b85a97d-37d0e6f2e3amr3396702f8f.3.1728127312787;
        Sat, 05 Oct 2024 04:21:52 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:758d:3770:c0e8:c4b8? ([2a02:168:6806:0:758d:3770:c0e8:c4b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f194sm1589735f8f.7.2024.10.05.04.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 04:21:52 -0700 (PDT)
Message-ID: <ef7c7a96a73161e0f5061503242a8d3eddef121f.camel@gmail.com>
Subject: [REGRESSION] alg: ahash: Several tests fail during boot on Turris
 Omnia
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 05 Oct 2024 13:21:51 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

with mainline kernel v6.12-rc1 I noticed a regression on my Turris Omnia (M=
arvell Armada 385), during my regular boot testing.
Several crypto self-tests now report "test failed (wrong result)":
	mv-hmac-sha256
	mv-hmac-md5
	mv-hmac-sh1
For reference, v6.11.0 is completely ok.

To be a bit more precise: Not all selftests reliably fail during all boots,=
 but during most boots I get at least a single failure.

I was able to bisect this, and the culprit is:

	commit 37da5d0ffa ("crypto: api - Do not wait for tests during registratio=
n")

If I counted correctly, 3 of 4 boots reported self-test errors with that co=
mmit, and
0 of 3 boots reported self-test errors with its parent.

Example boot log with self-test errors (relevant parts only):

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.11.0-rc1+ (...) (arm-linux-gnueabihf-gcc (De=
bian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP Sat =
Oct  5 11:58:34 CEST 2024
[    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=3D10c=
5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] OF: fdt: Machine model: Turris Omnia
...
[    0.274868] marvell-cesa f1090000.crypto: CESA device successfully regis=
tered
...
[    0.330736] alg: ahash: mv-hmac-sha256 test failed (wrong result) on tes=
t vector 1, cfg=3D"init+update+final aligned buffer"
[    0.332541] alg: ahash: mv-hmac-md5 test failed (wrong result) on test v=
ector 1, cfg=3D"init+update+final aligned buffer"
[    0.341851] alg: self-tests for hmac(sha256) using mv-hmac-sha256 failed=
 (rc=3D-22)
[    0.352648] alg: self-tests for hmac(md5) using mv-hmac-md5 failed (rc=
=3D-22)
[    0.352653] ------------[ cut here ]------------
[    0.352656] ------------[ cut here ]------------
[    0.352656] WARNING: CPU: 0 PID: 73 at crypto/testmgr.c:5908 alg_test+0x=
5e4/0x60c
[    0.352659] WARNING: CPU: 1 PID: 71 at crypto/testmgr.c:5908 alg_test+0x=
5e4/0x60c
[    0.352669] alg: self-tests for hmac(sha256) using mv-hmac-sha256 failed=
 (rc=3D-22)
[    0.352670] alg: self-tests for hmac(md5) using mv-hmac-md5 failed (rc=
=3D-22)
[    0.352673] Modules linked in:
[    0.352673] Modules linked in:
[    0.352680] CPU: 1 UID: 0 PID: 71 Comm: cryptomgr_test Not tainted 6.11.=
0-rc1+ #1
[    0.352688] Hardware name: Marvell Armada 380/385 (Device Tree)
[    0.352691] Call trace:=20
[    0.352697]  unwind_backtrace from show_stack+0x10/0x14
[    0.352717]  show_stack from dump_stack_lvl+0x50/0x64
[    0.352731]  dump_stack_lvl from __warn+0x94/0xc0
[    0.352742]  __warn from warn_slowpath_fmt+0x110/0x16c
[    0.352757]  warn_slowpath_fmt from alg_test+0x5e4/0x60c
[    0.352768]  alg_test from cryptomgr_test+0x18/0x38
[    0.352777]  cryptomgr_test from kthread+0xdc/0xf8
[    0.352788]  kthread from ret_from_fork+0x14/0x28
[    0.352797] Exception stack(0xf0fb5fb0 to 0xf0fb5ff8)
[    0.352803] 5fa0:                                     00000000 00000000 =
00000000 00000000
[    0.352809] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.352814] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.352818] ---[ end trace 0000000000000000 ]---
[    0.352819] CPU: 0 UID: 0 PID: 73 Comm: cryptomgr_test Not tainted 6.11.=
0-rc1+ #1
[    0.352828] Tainted: [W]=3DWARN
[    0.352831] Hardware name: Marvell Armada 380/385 (Device Tree)
[    0.352834] Call trace:=20
[    0.352837]  unwind_backtrace from show_stack+0x10/0x14
[    0.352853]  show_stack from dump_stack_lvl+0x50/0x64
[    0.352866]  dump_stack_lvl from __warn+0x94/0xc0
[    0.352877]  __warn from warn_slowpath_fmt+0x110/0x16c
[    0.352891]  warn_slowpath_fmt from alg_test+0x5e4/0x60c
[    0.352902]  alg_test from cryptomgr_test+0x18/0x38
[    0.352910]  cryptomgr_test from kthread+0xdc/0xf8
[    0.352920]  kthread from ret_from_fork+0x14/0x28
[    0.352929] Exception stack(0xf0f11fb0 to 0xf0f11ff8)
[    0.352934] 1fa0:                                     00000000 00000000 =
00000000 00000000
[    0.352940] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.352946] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.352953] ---[ end trace 0000000000000000 ]---
[    0.353088] alg: ahash: mv-hmac-sha1 test failed (wrong result) on test =
vector 0, cfg=3D"init+update+final aligned buffer"
[    0.354325] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marv=
ell 88E6176, revision 1
[    0.364023] alg: self-tests for hmac(sha1) using mv-hmac-sha1 failed (rc=
=3D-22)
[    0.364029] ------------[ cut here ]------------
[    0.364032] WARNING: CPU: 1 PID: 72 at crypto/testmgr.c:5908 alg_test+0x=
5e4/0x60c
[    0.364043] alg: self-tests for hmac(sha1) using mv-hmac-sha1 failed (rc=
=3D-22)
[    0.364046] Modules linked in:
[    0.364054] CPU: 1 UID: 0 PID: 72 Comm: cryptomgr_test Tainted: G       =
 W          6.11.0-rc1+ #1
[    0.364062] Tainted: [W]=3DWARN
[    0.364065] Hardware name: Marvell Armada 380/385 (Device Tree)
[    0.364068] Call trace:=20
[    0.364072]  unwind_backtrace from show_stack+0x10/0x14
[    0.364089]  show_stack from dump_stack_lvl+0x50/0x64
[    0.364102]  dump_stack_lvl from __warn+0x94/0xc0
[    0.364114]  __warn from warn_slowpath_fmt+0x110/0x16c
[    0.364127]  warn_slowpath_fmt from alg_test+0x5e4/0x60c
[    0.364139]  alg_test from cryptomgr_test+0x18/0x38
[    0.364147]  cryptomgr_test from kthread+0xdc/0xf8
[    0.364157]  kthread from ret_from_fork+0x14/0x28
[    0.364166] Exception stack(0xf0ef9fb0 to 0xf0ef9ff8)
[    0.364172] 9fa0:                                     00000000 00000000 =
00000000 00000000
[    0.364177] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.364183] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.364187] ---[ end trace 0000000000000000 ]---

Best regards, Klaus

#regzbot introduced: 37da5d0ffa7b61f79156fbbd3369f17b9a1638bd

