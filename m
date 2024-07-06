Return-Path: <linux-kernel+bounces-243105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D709291B8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD22C1F22C0E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 08:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134CD446AF;
	Sat,  6 Jul 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reo41hZA"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98674436C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253081; cv=none; b=LNf8Spe9veWABTU2GsronHg8IEJaGkrZISjeyWkivDM/Kuyb6drIzpWDtoe5Yiood1S50j9aQ9FdV6on8iYREHtlsGL6OtAT91YnULPROm8m4hfYn+CdDpLMNf2xBGv2jjE+dmmNRnGZNBYLaQIdLS1HXPo2LMJj22UjkeZoV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253081; c=relaxed/simple;
	bh=rhmJZeWDic+FCTabnG/oaz68O0Gqg4lw1xPfCuC3/fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IId4jZaXU9xzJHGXjYvcj4hZV//3WymFuxOSQBSEavrXdjCXDqpFO1YN251ogyknHJ+YSmUUZbeJJIMAMYs7LNBtUXP4n/MiNNJSOeUdb9q8lg3hlyxolULkBStLjZJOwkUB8cT5y9xV9JrC5L0WcSONFGsaLvjSvvFkjmZ+uA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reo41hZA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447dabd9562so288211cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 01:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720253077; x=1720857877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6768WlmqKxOn5ChLWI/2ZkcRqyXrw8PotqUVkVIS8yY=;
        b=reo41hZAO72KSfHbIiWMuCY+90pzpS4aVgOkR2GMsENVLXWRn6BeCtW8U7OkYcUkgj
         rySjYVjvl1g0lLUt4OSaj9k5q9HbP6IuqPDZHgZY/Ha+UERSakAXf4lNNydVm/S8N5sA
         9Xt8HBPs45RntArG7qhLHOgkhM9lxQotEtP0KGYFu2N1Up2PqbySo5ZnP6ea9fD52f6K
         Wy5ItFXDI9yrI4/A7bzAwrzN6skkEBuoNPTc2hsy8r3N7GiEZIpeSl+N7XzVh017t9is
         0TNnJLKTMsPm6Z4vuSZfTrCDTmsMUBujhZvqdJL9xPA1nfs++LwAGOncZ2nqVglW8fzo
         jXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720253077; x=1720857877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6768WlmqKxOn5ChLWI/2ZkcRqyXrw8PotqUVkVIS8yY=;
        b=Ib7WDyFS8uvvolHER90rHyBxjSiRykiDj1wCfthXn6BdLH39OwFdQYKFE0dFRSluH5
         nyabSVCV5KmOnGw6OrCwcZT0AVZZajOmppxrqh7Kd7L6mV8UY8mIiMkECtD5p9Z4gH92
         Iwwqi+TICHAEb/+xnrFkvXOFmRpPO4OkJCZEzK6Ji3PY+mWRdAG2yLZu2rHWaf9BF4/0
         OVv9Q0+r8V5/YaYKS5zKmBZcjMosrf9fr8EEO6bDpDHvFnsPU6n1uA4DIC190Pq/DzxR
         iE0tLxV9q8iNZ+EQnVJf+NQgccCrD2e4QNNymgtJtkNiy9EuGVdGYrmCTC0mpu7CntSK
         HUVA==
X-Forwarded-Encrypted: i=1; AJvYcCUyGcbtFAVBGIcYc0ehs1Mn7/fMxKkWVEz7Pyj4yFU0bS/qVfmciIFKPKovRWhnRNtZiZORVlNS/M9LCjgH5nwUbZhU4lXEtSneqYDM
X-Gm-Message-State: AOJu0YzlN1Ky5K6W7oGGeLlhkFwwYPB4y86fbK+KPJfQYDr56ALN15Mi
	6xmHfWgOvHmoGBwOdRO3VKbVN8O4uCZqGfvgG2mrfhX76ID9Mti8gdX5XqkIywPGvBiBZYDILTO
	Bvl+5PBwkE8yLsLL6IKP1V8w0AL/JvlNn450XF81TXJfoS34qRHkZxTNteGHBA2vZgibCG+dUVO
	0Q0UUlnh9dOb93DRGaE3OYL5nrXA==
X-Google-Smtp-Source: AGHT+IFk6KCbaDsXl2afarYxBOGDDy2MP5xRWVqZtzvoHFwPnXGVZOKcYa+mrdDolqM61xnDbL+qAWuXcUO1eaRdBVI=
X-Received: by 2002:a05:622a:8098:b0:446:693e:4d63 with SMTP id
 d75a77b69052e-447c8fbb043mr5711591cf.16.1720253077363; Sat, 06 Jul 2024
 01:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706045454.215701-1-sboyd@kernel.org> <20240706045454.215701-6-sboyd@kernel.org>
In-Reply-To: <20240706045454.215701-6-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Sat, 6 Jul 2024 16:04:25 +0800
Message-ID: <CABVgOSk93mNY4diXppGWJZgWJhrHpGqECBXNROWkRCaZjFi2tw@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] platform: Add test managed platform_device/driver APIs
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <maxime@cerno.tech>
X-ccpol: medium
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a13ab9061c8fa11e"

--000000000000a13ab9061c8fa11e
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jul 2024 at 12:55, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Introduce KUnit resource wrappers around platform_driver_register(),
> platform_device_alloc(), and platform_device_add() so that test authors
> can register platform drivers/devices from their tests and have the
> drivers/devices automatically be unregistered when the test is done.
>
> This makes test setup code simpler when a platform driver or platform
> device is needed. Add a few test cases at the same time to make sure the
> APIs work as intended.
>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Hmm... this is failing under KASAN for me. I'll take a closer look
next week, but in case there's anything super-obvious, here's the
report:

> [15:54:33] BUG: KASAN: slab-use-after-free in kobject_put+0x224/0x280
> [15:54:33] Read of size 1 at addr ffff888002ca484c by task kunit_try_catch/226
> [15:54:33]
> [15:54:33] CPU: 0 PID: 226 Comm: kunit_try_catch Tainted: G      D          N 6.10.0-rc1-g21fbb4cfd3cc #25
> [15:54:33] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [15:54:33] Call Trace:
> [15:54:33]  <TASK>
> [15:54:33]  dump_stack_lvl+0x3f/0x50
> [15:54:33]  print_report+0xcd/0x620
> [15:54:33]  ? kobject_put+0x224/0x280
> [15:54:33]  kasan_report+0xde/0x110
> [15:54:33]  ? kobject_put+0x224/0x280
> [15:54:33]  kobject_put+0x224/0x280
> [15:54:33]  kunit_remove_resource+0x12c/0x1d0
> [15:54:33]  kunit_cleanup+0x8d/0x130
> [15:54:33]  ? __pfx_kunit_try_run_case_cleanup+0x10/0x10
> [15:54:33]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
> [15:54:33]  kunit_generic_run_threadfn_adapter+0x7b/0xe0
> [15:54:33]  kthread+0x289/0x360
> [15:54:33]  ? __pfx_kthread+0x10/0x10
> [15:54:33]  ret_from_fork+0x2f/0x70
> [15:54:33]  ? __pfx_kthread+0x10/0x10
> [15:54:33]  ret_from_fork_asm+0x19/0x30
> [15:54:33]  </TASK>
> [15:54:33]
> [15:54:33] Allocated by task 225:
> [15:54:33]  kasan_save_stack+0x33/0x60
> [15:54:33]  kasan_save_track+0x14/0x30
> [15:54:33]  __kasan_kmalloc+0x8f/0xa0
> [15:54:33]  platform_device_alloc+0x26/0x200
> [15:54:33]  kunit_platform_device_alloc_init+0x52/0xc0
> [15:54:33]  __kunit_add_resource+0x98/0x1e0
> [15:54:33]  kunit_platform_device_alloc+0xe7/0x170
> [15:54:33]  kunit_platform_device_add_test+0x91/0x560
> [15:54:33]  kunit_try_run_case+0x1ad/0x490
> [15:54:33]  kunit_generic_run_threadfn_adapter+0x7b/0xe0
> [15:54:33]  kthread+0x289/0x360
> [15:54:33]  ret_from_fork+0x2f/0x70
> [15:54:33]  ret_from_fork_asm+0x19/0x30
> [15:54:33]
> [15:54:33] Freed by task 226:
> [15:54:33]  kasan_save_stack+0x33/0x60
> [15:54:33]  kasan_save_track+0x14/0x30
> [15:54:33]  kasan_save_free_info+0x3b/0x60
> [15:54:33]  __kasan_slab_free+0x101/0x160
> [15:54:33]  kfree+0x94/0x190
> [15:54:33]  device_release+0x9a/0x210
> [15:54:33]  kobject_put+0x150/0x280
> [15:54:33]  kunit_remove_resource+0x12c/0x1d0
> [15:54:33]  kunit_cleanup+0x8d/0x130
> [15:54:33]  kunit_generic_run_threadfn_adapter+0x7b/0xe0
> [15:54:33]  kthread+0x289/0x360
> [15:54:33]  ret_from_fork+0x2f/0x70
> [15:54:33]  ret_from_fork_asm+0x19/0x30
> [15:54:33]
> [15:54:33] The buggy address belongs to the object at ffff888002ca4800
> [15:54:33]  which belongs to the cache kmalloc-1k of size 1024
> [15:54:33] The buggy address is located 76 bytes inside of
> [15:54:33]  freed 1024-byte region [ffff888002ca4800, ffff888002ca4c00)
> [15:54:33]
> [15:54:33] The buggy address belongs to the physical page:
> [15:54:33] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ca4
> [15:54:33] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [15:54:33] flags: 0x4000000000000040(head|zone=1)
> [15:54:33] page_type: 0xffffefff(slab)
> [15:54:33] raw: 4000000000000040 ffff888001041b00 dead000000000122 0000000000000000
> [15:54:33] raw: 0000000000000000 0000000080080008 00000001ffffefff 0000000000000000
> [15:54:33] head: 4000000000000040 ffff888001041b00 dead000000000122 0000000000000000
> [15:54:33] head: 0000000000000000 0000000080080008 00000001ffffefff 0000000000000000
> [15:54:33] head: 4000000000000002 ffffea00000b2901 ffffffffffffffff 0000000000000000
> [15:54:33] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
> [15:54:33] page dumped because: kasan: bad access detected
> [15:54:33]
> [15:54:33] Memory state around the buggy address:
> [15:54:33]  ffff888002ca4700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [15:54:33]  ffff888002ca4780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [15:54:33] >ffff888002ca4800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [15:54:33]                                               ^
> [15:54:33]  ffff888002ca4880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [15:54:33]  ffff888002ca4900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [15:54:33] ==================================================================
> [15:54:33] ------------[ cut here ]------------
> [15:54:33] refcount_t: underflow; use-after-free.
> [15:54:33] WARNING: CPU: 0 PID: 226 at lib/refcount.c:28 refcount_warn_saturate+0xf2/0x150
> [15:54:33] CPU: 0 PID: 226 Comm: kunit_try_catch Tainted: G    B D          N 6.10.0-rc1-g21fbb4cfd3cc #25
> [15:54:33] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [15:54:33] RIP: 0010:refcount_warn_saturate+0xf2/0x150
> [15:54:33] Code: 3b aa cb 00 01 e8 3e c1 b0 ff 0f 0b eb 91 80 3d 2a aa cb 00 00 75 88 48 c7 c7 40 f3 88 ad c6 05 1a aa cb 00 01 e8 1e c1 b0 ff <0f> 0b e9 6e ff ff ff 80 3d 0a aa cb 00 00 0f 85 61 ff ff ff 48 c7
> [15:54:33] RSP: 0018:ffff88800357fe58 EFLAGS: 00000286
> [15:54:33] RAX: 0000000000000000 RBX: ffff888002ca4848 RCX: 1ffffffff5b920d4
> [15:54:33] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffadc906a0
> [15:54:33] RBP: 0000000000000003 R08: 0000000000000000 R09: fffffbfff5b920d4
> [15:54:33] R10: 0000000000000003 R11: 0000000000000001 R12: ffff88800111fb28
> [15:54:33] R13: ffff88800111fb28 R14: ffff88800111fb28 R15: 0000000000000286
> [15:54:33] FS:  0000000000000000(0000) GS:ffffffffadc6f000(0000) knlGS:0000000000000000
> [15:54:33] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [15:54:33] CR2: dffffc0000000000 CR3: 000000000a25a000 CR4: 00000000000006f0
> [15:54:33] Call Trace:
> [15:54:33]  <TASK>
> [15:54:33]  ? __warn+0xb0/0x170
> [15:54:33]  ? refcount_warn_saturate+0xf2/0x150
> [15:54:33]  ? report_bug+0x298/0x350
> [15:54:33]  ? handle_bug+0x6d/0x90
> [15:54:33]  ? exc_invalid_op+0x17/0x40
> [15:54:33]  ? asm_exc_invalid_op+0x1a/0x20
> [15:54:33]  ? refcount_warn_saturate+0xf2/0x150
> [15:54:33]  ? refcount_warn_saturate+0xf2/0x150
> [15:54:33]  kunit_remove_resource+0x12c/0x1d0
> [15:54:33]  kunit_cleanup+0x8d/0x130
> [15:54:33]  ? __pfx_kunit_try_run_case_cleanup+0x10/0x10
> [15:54:33]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
> [15:54:33]  kunit_generic_run_threadfn_adapter+0x7b/0xe0
> [15:54:33]  kthread+0x289/0x360
> [15:54:33]  ? __pfx_kthread+0x10/0x10
> [15:54:33]  ret_from_fork+0x2f/0x70
> [15:54:33]  ? __pfx_kthread+0x10/0x10
> [15:54:33]  ret_from_fork_asm+0x19/0x30
> [15:54:33]  </TASK>
> [15:54:33] ---[ end trace 0000000000000000 ]---
> [15:54:33] [FAILED] kunit_platform_device_add_test

It repros here with:
./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add
CONFIG_KASAN=y --kconfig_add CONFIG_KASAN_VMALLOC=y
kunit_platform_driver

Seems to otherwise pass on all of my default configs/archs.

Cheers,
-- David

--000000000000a13ab9061c8fa11e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEILka1JbeM2Mf4vSSDr9UXvy4i9tS7HHhtQIvutSATvliMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcwNjA4MDQzN1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAgt9dq
OjVs0XuCkcPhux7Jk39YKUXa6QnEMiFfgA/LSl2NBfpS+5SKkcuP2fsInBvFTFf0hAo24jClwM8H
Wm1UIYxf6knOcVG7aIXS7eJ1ubb3jQMvkoDnkGVQri2O+b6/WDlEnCzAarnVDTGdx7JyLIy/FZhZ
hHYd36cJxup9PV3w6g+hNa2SsnEbBSSyLNV5wCtsrluUVxG+z0AeeVoN/mqjSv0kT8jLxnuI0dIP
4XmdSqwcUuqHwK5xhvzabOpJ3eAHS1m5Mv9iCP95ldQFfxhdpHeSqGkG8xkbOpGY5jC9q67rIsQm
XixEhiTsTOEFCTzJyxid500pVLP7L5GI
--000000000000a13ab9061c8fa11e--

