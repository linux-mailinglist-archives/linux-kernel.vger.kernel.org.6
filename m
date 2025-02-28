Return-Path: <linux-kernel+bounces-537858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C16DEA491D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4713AFA44
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8B1C2DB4;
	Fri, 28 Feb 2025 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJHSYf4M"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95198748F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726241; cv=none; b=F8kfnokkSUDFG/GATghk+6TXs9UDWLLdL/lK6bkYVeAXr1DHsGZ2eTIkaaabSsALPprz3QqEjWCscbBFcoh90YqaKP/IQrwkfAp8BkJqQweFL7H910/O+RK5/BYLMip2tq+SFQHuAg7FPO6N4FHcy0jHTJiinjgSRPJDFiIa3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726241; c=relaxed/simple;
	bh=VvAs9MeLhFoyPPBc/VNv33vUrpIp6F37e8PJI/ksfAU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DjxPQPJdTCARFMPrUj7PIccT6hsAHVspEdWEIQnvHAWajKBe+svM4KV4KEH6Mg/ZZVgN5kHlru/HoJo8xInF+T2xja7D0LcGK4rPOzHuFxQlIkbXPIABOgq+7WKrL2SCfE6ji/CkyfAHeKBjGyzt/ChiAGOrNKkhRm7QJGVMofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJHSYf4M; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f6ae4846c7so16013927b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740726238; x=1741331038; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g0ZE5+iGc7Nv9s7z7+Qh70S8Ifs6GlOKtZ7ztqD4FfM=;
        b=FJHSYf4Md1PAv3EvjKPtRLch1UhHBGCqeAzrWVHhnAkGMTU3KXdAF1dnQf+804PRfb
         QAMO7oNdLWuwkFaamptQuixzHDDooezl7gZkNgvm8RSwt3jUDrg1l28pc8UWm7Fz11Kh
         5oPorbD00h0ryBOpvh6AfgGENqhvzVmulteYXYj+nkz/LEeSPT/YVS+2uCWNehX+hXs/
         jC0fYgQdqlj3Azux9IJgdNRFJ/MkKlTgzLvXNpguRNmUilkBQfwT5q0xWXBC3X5/Qfq7
         RUucXeHdcCJ1YaTT0LX8ME++iqAWWAIks2a75U+gJUEpqnhI1O1nZrNI3norvYJQ2ntG
         qfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740726238; x=1741331038;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0ZE5+iGc7Nv9s7z7+Qh70S8Ifs6GlOKtZ7ztqD4FfM=;
        b=R+//uarA7bKe3lR9tz0P0PgGKPWzuzpnxt9eV407QBpCLEA7bAJR3mESeggnsDizmS
         Nx4a5SpiV09eMxEDqmNe1mTmOsSgUDOIorx7P3m6a/kyKD1zP6ZAgGx9ayi1R+/XE+yp
         JYoVuQVrxMqXYeK1sfEuGahGFSBBjtzb4eHEjlnAAV4QLQHcNVFZwnCZuqtFkpwWz6Dm
         hmfoSTo3Fa1MLyBFrgQmOwsG2VfkZYqnpQP/+X4dYf/WRmmUtG7u6I7yrWmrtd5Mrp/+
         Ehi3lCCRHs/ona38YbGn4ey2Jw15W+1BqmIB6dUet+/e/L7AzHrDbP7Pc1Exh0o/2Bjn
         fBxQ==
X-Gm-Message-State: AOJu0YydXaUCbEo8i0r3d5WzJSNeHbpswvbojuioQVTX01LX8brQ9XqY
	udZq1frigYBec2QG10O4CUsy2TFpu9VkRok5j10gT2olXrlaAqw9XOvA5LFgadGCDBnBlLI3Fk1
	LzDQ04BFxu6yGKziTbcY8LiEQX5ZCQ9OO91qZPoQG
X-Gm-Gg: ASbGncuZQy8cqzOix6L0nZFsjggSuwZlIhqSaiYi0i/cQ+FhALqctq/VdHjNg2X/4X4
	5go+Bf6zCgZL0O/lHVUFkBAb5gAOLLlZ9Ne/FReoka2Qw29x60twXJLJjpkYVm9/73W0DIp/pcL
	Ef4ukn/w==
X-Google-Smtp-Source: AGHT+IEFIeyVuSSSHm/7M1bRVpr/NFtL5W/i4jHLSds4prGqAsEAxaRiR9JoGmFXJiNK9vM4UEkLbUL7eIVdECjkRcY=
X-Received: by 2002:a05:690c:7305:b0:6fd:4718:9be0 with SMTP id
 00721157ae682-6fd4a064f15mr31698607b3.12.1740726238162; Thu, 27 Feb 2025
 23:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 28 Feb 2025 15:03:21 +0800
X-Gm-Features: AQ5f1Jr8R1zVBxAlzKV3X-cFpGfCqhk0TdsLXjTBovq59Sh2jPzYK__GiQ-mR4g
Message-ID: <CAMe9rOqRRv-pW1GGV5YNA3O6FADLWzg5SzwyaJ-_7fJTB7dCsw@mail.gmail.com>
Subject: [PATCH] x86: Increase buffer size in insn_decoder_test.c to 4KB
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000146108062f2e6990"

--000000000000146108062f2e6990
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When building Linux kernel v6.13 on Fedora 41 with GCC 14.2.1, I got

  TEST    posttest
arch/x86/tools/insn_decoder_test: error: malformed line 3729972:
2_>:ffffffff81c91b00
make[2]: *** [arch/x86/tools/Makefile:26: posttest] Error 3

[hjl@gnu-zen4-1 linux-stable]$ cat 1.out
<__pfx__RNCINvNtNtNtCsbv2001LzuKJ_4core4iter8adapters3map12map_try_foldjNtC=
s7hQOShE0J6s_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFl=
owB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvM=
B12_B10_13from_segments0E0E0B12_>:ffffffff81c91b00
ffffffff81c91b00: 90                    nop
ffffffff81c91b01: 90                    nop
ffffffff81c91b02: 90                    nop
ffffffff81c91b03: 90                    nop
ffffffff81c91b04: 90                    nop
ffffffff81c91b05: 90                    nop
ffffffff81c91b06: 90                    nop
ffffffff81c91b07: 90                    nop
ffffffff81c91b08: 90                    nop
ffffffff81c91b09: 90                    nop
ffffffff81c91b0a: 90                    nop
ffffffff81c91b0b: 90                    nop
ffffffff81c91b0c: 90                    nop
ffffffff81c91b0d: 90                    nop
ffffffff81c91b0e: 90                    nop
ffffffff81c91b0f: 90                    nop
[hjl@gnu-zen4-1 linux-stable]$ arch/x86/tools/insn_decoder_test -y -v < 1.o=
ut
arch/x86/tools/insn_decoder_test: error: malformed line 1:
2_>:ffffffff81c91b00

This patch from Red Hat increasing buffer size in insn_decoder_test.c to
4KB fixed:

https://bugzilla.kernel.org/show_bug.cgi?id=3D219729

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 arch/x86/tools/insn_decoder_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/insn_decoder_test.c
b/arch/x86/tools/insn_decoder_test.c
index 472540aeabc2..366e07546344 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -106,7 +106,7 @@ static void parse_args(int argc, char **argv)
  }
 }

-#define BUFSIZE 256
+#define BUFSIZE 4096

 int main(int argc, char **argv)
 {
--=20
2.48.1

--=20
H.J.

--000000000000146108062f2e6990
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-x86-Increase-buffer-size-in-insn_decoder_test.c-to-4.patch"
Content-Disposition: attachment; 
	filename="0001-x86-Increase-buffer-size-in-insn_decoder_test.c-to-4.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m7offg0m0>
X-Attachment-Id: f_m7offg0m0

RnJvbSA2MDlkNzc5ZmZkOGY5NTE2MzkzNzg5ZGQzZGZkODM5N2FiNWI0NDlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IEZyaSwgMjggRmViIDIwMjUgMTQ6MjE6MDMgKzA4MDAKU3ViamVjdDogW1BBVENIXSB4ODY6IElu
Y3JlYXNlIGJ1ZmZlciBzaXplIGluIGluc25fZGVjb2Rlcl90ZXN0LmMgdG8gNEtCCgpXaGVuIGJ1
aWxkaW5nIExpbnV4IGtlcm5lbCB2Ni4xMyBvbiBGZWRvcmEgNDEgd2l0aCBHQ0MgMTQuMi4xLCBJ
IGdvdAoKICBURVNUICAgIHBvc3R0ZXN0CmFyY2gveDg2L3Rvb2xzL2luc25fZGVjb2Rlcl90ZXN0
OiBlcnJvcjogbWFsZm9ybWVkIGxpbmUgMzcyOTk3MjoKMl8+OmZmZmZmZmZmODFjOTFiMDAKbWFr
ZVsyXTogKioqIFthcmNoL3g4Ni90b29scy9NYWtlZmlsZToyNjogcG9zdHRlc3RdIEVycm9yIDMK
CltoamxAZ251LXplbjQtMSBsaW51eC1zdGFibGVdJCBjYXQgMS5vdXQKPF9fcGZ4X19STkNJTnZO
dE50TnRDc2J2MjAwMUx6dUtKXzRjb3JlNGl0ZXI4YWRhcHRlcnMzbWFwMTJtYXBfdHJ5X2ZvbGRq
TnRDczdoUU9TaEUwSjZzXzEyZHJtX3BhbmljX3FyN1ZlcnNpb251SU50TnROdEJhXzNvcHMxMmNv
bnRyb2xfZmxvdzExQ29udHJvbEZsb3dCMTBfRU5jQjEwXzBOQ0lOdk52TnROdE50QjhfNnRyYWl0
czhpdGVyYXRvcjhJdGVyYXRvcjRmaW5kNWNoZWNrQjEwX05DTnZNQjEyX0IxMF8xM2Zyb21fc2Vn
bWVudHMwRTBFMEIxMl8+OmZmZmZmZmZmODFjOTFiMDAKZmZmZmZmZmY4MWM5MWIwMDoJOTAgICAg
ICAgICAgICAgICAgICAgCW5vcApmZmZmZmZmZjgxYzkxYjAxOgk5MCAgICAgICAgICAgICAgICAg
ICAJbm9wCmZmZmZmZmZmODFjOTFiMDI6CTkwICAgICAgICAgICAgICAgICAgIAlub3AKZmZmZmZm
ZmY4MWM5MWIwMzoJOTAgICAgICAgICAgICAgICAgICAgCW5vcApmZmZmZmZmZjgxYzkxYjA0Ogk5
MCAgICAgICAgICAgICAgICAgICAJbm9wCmZmZmZmZmZmODFjOTFiMDU6CTkwICAgICAgICAgICAg
ICAgICAgIAlub3AKZmZmZmZmZmY4MWM5MWIwNjoJOTAgICAgICAgICAgICAgICAgICAgCW5vcApm
ZmZmZmZmZjgxYzkxYjA3Ogk5MCAgICAgICAgICAgICAgICAgICAJbm9wCmZmZmZmZmZmODFjOTFi
MDg6CTkwICAgICAgICAgICAgICAgICAgIAlub3AKZmZmZmZmZmY4MWM5MWIwOToJOTAgICAgICAg
ICAgICAgICAgICAgCW5vcApmZmZmZmZmZjgxYzkxYjBhOgk5MCAgICAgICAgICAgICAgICAgICAJ
bm9wCmZmZmZmZmZmODFjOTFiMGI6CTkwICAgICAgICAgICAgICAgICAgIAlub3AKZmZmZmZmZmY4
MWM5MWIwYzoJOTAgICAgICAgICAgICAgICAgICAgCW5vcApmZmZmZmZmZjgxYzkxYjBkOgk5MCAg
ICAgICAgICAgICAgICAgICAJbm9wCmZmZmZmZmZmODFjOTFiMGU6CTkwICAgICAgICAgICAgICAg
ICAgIAlub3AKZmZmZmZmZmY4MWM5MWIwZjoJOTAgICAgICAgICAgICAgICAgICAgCW5vcApbaGps
QGdudS16ZW40LTEgbGludXgtc3RhYmxlXSQgYXJjaC94ODYvdG9vbHMvaW5zbl9kZWNvZGVyX3Rl
c3QgLXkgLXYgPCAxLm91dAphcmNoL3g4Ni90b29scy9pbnNuX2RlY29kZXJfdGVzdDogZXJyb3I6
IG1hbGZvcm1lZCBsaW5lIDE6CjJfPjpmZmZmZmZmZjgxYzkxYjAwCgpUaGlzIHBhdGNoIGZyb20g
UmVkIEhhdCBpbmNyZWFzaW5nIGJ1ZmZlciBzaXplIGluIGluc25fZGVjb2Rlcl90ZXN0LmMgdG8K
NEtCIGZpeGVkOgoKaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0y
MTk3MjkKClNpZ25lZC1vZmYtYnk6IEguSi4gTHUgPGhqbC50b29sc0BnbWFpbC5jb20+Ci0tLQog
YXJjaC94ODYvdG9vbHMvaW5zbl9kZWNvZGVyX3Rlc3QuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L3Rv
b2xzL2luc25fZGVjb2Rlcl90ZXN0LmMgYi9hcmNoL3g4Ni90b29scy9pbnNuX2RlY29kZXJfdGVz
dC5jCmluZGV4IDQ3MjU0MGFlYWJjMi4uMzY2ZTA3NTQ2MzQ0IDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni90b29scy9pbnNuX2RlY29kZXJfdGVzdC5jCisrKyBiL2FyY2gveDg2L3Rvb2xzL2luc25fZGVj
b2Rlcl90ZXN0LmMKQEAgLTEwNiw3ICsxMDYsNyBAQCBzdGF0aWMgdm9pZCBwYXJzZV9hcmdzKGlu
dCBhcmdjLCBjaGFyICoqYXJndikKIAl9CiB9CiAKLSNkZWZpbmUgQlVGU0laRSAyNTYKKyNkZWZp
bmUgQlVGU0laRSA0MDk2CiAKIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIHsKLS0g
CjIuNDguMQoK
--000000000000146108062f2e6990--

