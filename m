Return-Path: <linux-kernel+bounces-411693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C7E9CFE55
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 11:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B21B21A03
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF041957F4;
	Sat, 16 Nov 2024 10:51:00 +0000 (UTC)
Received: from cstnet.cn (smtp86.cstnet.cn [159.226.251.86])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543692F29
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731754259; cv=none; b=PSCN3yOJNQIfRICT69z0PZrX4F/FJYt7Ds8dkE3R9ZjaHkYcuoLHasLdk7pNQW/I6/WBKwq5VBjJAH6heCLmtOkzi2i7B7dtv/R4drH/lSPpubcSW55B3ipxKovOUGr+BQMdC0JpfPV3e5CVhYQ/2yocUaBupjVLolMr4onF9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731754259; c=relaxed/simple;
	bh=BuB53FTJREEHwAeWK8MHYXH1B2OOiVw/eqOaaaJJMWg=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=H8bShLRO5qilzsVvwxxfJqpakJUAJcqkTQCuusdlODnRMXaDlxX9tMl12QdcbE1qm7nFI3XiLZbc2h56Icd1egnbkH1VzQNRYXP2BJtEpJ4DpOi/dJQcUI8hUcBCIXK11VA1c6pmaPRAd7jLKYNS7Mrn5qvu2ev1to1tN9kP+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from zhangkai$iscas.ac.cn ( [175.164.144.183] ) by
 ajax-webmail-APP-16 (Coremail) ; Sat, 16 Nov 2024 18:42:58 +0800
 (GMT+08:00)
Date: Sat, 16 Nov 2024 18:42:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangkai@iscas.ac.cn
To: Walmsley <paul.walmsley@sifive.com>, Dabbelt <palmer@dabbelt.com>, 
	Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: fix memory leakage in
 process_accumulated_relocations
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <35cab46a.6d145.19334919ed0.Coremail.zhangkai@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:sQCowAC3vwczdzhn83MCAA--.31286W
X-CM-SenderInfo: x2kd0wxndlqxpvfd2hldfou0/1tbiBgsDBmc36Uv1MQABs-
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

V2hlbiBtb2R1bGUgcmVsb2NhdGlvbiBpcyBkb25lLCBwcm9jZXNzX2FjY3VtdWxhdGVkX3JlbG9j
YXRpb25zKCkKZnJlZXMgYWxsIGR5bmFtaWMgYWxsb2NhdGVkIG1lbW9yeS4gcmVsX2hlYWRfaXRl
ci0mZ3Q7cmVsX2VudHJ5IGlzCm1pc3NlZCB0byBmcmVlIHRoYXQga21lbWxlYWsgbWlnaHQgcmVw
b3J0OgoKdW5yZWZlcmVuY2VkIG9iamVjdCAweGZmZmZmZmQ4ODBjNWZjNDAgKHNpemUgMTYpOgog
IGNvbW0gImluc21vZCIsIHBpZCAxMTAxLCBqaWZmaWVzIDQyOTUwNDUxMzgKICBoZXggZHVtcCAo
Zmlyc3QgMTYgYnl0ZXMpOgogICAgZTAgYzAgZjUgODcgZDggZmYgZmYgZmYgNjAgYzUgZjUgODcg
ZDggZmYgZmYgZmYgIC4uLi4uLi4uYC4uLi4uLi4KICBiYWNrdHJhY2UgKGNyYyBkMmVjYjIwYyk6
CiAgICBbJmx0OzAwMDAwMDAwYjAxNjU1ZjYmZ3Q7XSBrbWFsbG9jX3RyYWNlX25vcHJvZisweDI2
OC8weDJmNgogICAgWyZsdDswMDAwMDAwMDZkYzAwNjdhJmd0O10gYWRkX3JlbG9jYXRpb25fdG9f
YWNjdW11bGF0ZS5jb25zdHByb3AuMCsweGYyLzB4MWFhCiAgICBbJmx0OzAwMDAwMDAwZTFiMjlh
MzYmZ3Q7XSBhcHBseV9yZWxvY2F0ZV9hZGQrMHgxM2MvMHgzNmUKICAgIFsmbHQ7MDAwMDAwMDA3
NTQzZjFmYiZndDtdIGxvYWRfbW9kdWxlKzB4NWM2LzB4ODNlCiAgICBbJmx0OzAwMDAwMDAwYWJj
ZTEyZTgmZ3Q7XSBpbml0X21vZHVsZV9mcm9tX2ZpbGUrMHg3NC8weGFhCiAgICBbJmx0OzAwMDAw
MDAwNDk0MTNlM2QmZ3Q7XSBpZGVtcG90ZW50X2luaXRfbW9kdWxlKzB4MTE2LzB4MjJlCiAgICBb
Jmx0OzAwMDAwMDAwZjliOThiODUmZ3Q7XSBfX3Jpc2N2X3N5c19maW5pdF9tb2R1bGUrMHg2Mi8w
eGFlCgpTaWduZWQtb2ZmLWJ5OiBLYWkgWmhhbmcgPHpoYW5na2FpQGlzY2FzLmFjLmNuPgotLS0K
IGFyY2gvcmlzY3Yva2VybmVsL21vZHVsZS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykKCmRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9tb2R1bGUuYyBiL2FyY2gv
cmlzY3Yva2VybmVsL21vZHVsZS5jCmluZGV4IDFjZDQ2MWYzZDg3Li5mOGMzYzRiNDdkYyAxMDA2
NDQKLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvbW9kdWxlLmMKKysrIGIvYXJjaC9yaXNjdi9rZXJu
ZWwvbW9kdWxlLmMKQEAgLTY0Myw2ICs2NDMsNyBAQCBwcm9jZXNzX2FjY3VtdWxhdGVkX3JlbG9j
YXRpb25zKHN0cnVjdCBtb2R1bGUgKm1lLAogICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAg
ICAgICAgICAgICAgICAgICAgIHJlbG9jX2hhbmRsZXJzW2N1cnJfdHlwZV0uYWNjdW11bGF0ZV9o
YW5kbGVyKAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lLCBsb2NhdGlvbiwgYnVm
ZmVyKTsKKyAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUocmVsX2hlYWRfaXRlci0mZ3Q7cmVs
X2VudHJ5KTsKICAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUocmVsX2hlYWRfaXRlcik7CiAg
ICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBrZnJlZShidWNrZXRfaXRlcik7Ci0tIAoy
LjM5LjUKCjwvemhhbmdrYWlAaXNjYXMuYWMuY24+

