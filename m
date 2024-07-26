Return-Path: <linux-kernel+bounces-263680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA593D939
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110E61F21AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4F5588E;
	Fri, 26 Jul 2024 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGisHuu5"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23538DEE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023059; cv=none; b=vA2kSMkDSkWSqqbdViMkHoQ3xtTi2ndx7xkA45THv2sLg7lWq2p6XD4gtB4V9qmPEYVzJNJJAQyBJC1GvrUYtEmXZAm8z4zvKP+58Xmo2mTfA2TJ7gxAV/ZkFxpIUBZBOp+Pwzv8zTnTwKV5bY6RF7lOgM42/j6c4P0T+81I4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023059; c=relaxed/simple;
	bh=8swnkLiBNcztCSO4MMxPWA+XMpwgcLhCjDGuiWLHTXU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mHW783T+qBSYcM3PyGzi8A7v6oR515H61XcJxEgF7fziEKfTpvwdSzJ32nPVUaOuANht5Vs/iNi04ZZipwlc/s2Xgd0MPc31YQrsRyyKiE20HUaQ2lj8sBPR3TNhnxV/FvKB1Mz5pRCjRffUWxkXLQVkrVobgQ8glnV5fdkbYjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGisHuu5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f01993090so2430471e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023055; x=1722627855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wEDejDdubAMVUv9e4jAvDuvtopjmi+ZYzxLqxsniCA=;
        b=EGisHuu5PFboNETB88C6oqgFYpZaPOGmcGG0ZzOiwCEyFCGI/yQw7F8U1jNcF4lKiT
         1wryNqprwUbbXoYUDdiPOBv5n2e9MfONSFspBVNbhwBokv2tFOUvEF/4rfQ3GRi62vEt
         h1Sm66+YOwWQaKXgDAS3n32VwvLdoxXV9K4bp1kORxqn2J1ekGzSImeSUiTEv9NzjyKC
         i1WkXtn7saYZG5+aeW5wgd/eCtGkdzSUiU61DLFhTOUC3AN87gHeej5BzfPfBTJI99np
         bdTj5CkVRNMNUBAnOjn+kGCoDjfXQIxTFRWhDakzZYQ48AEraifbke8TQZ7zdqfIOPMk
         wagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023055; x=1722627855;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wEDejDdubAMVUv9e4jAvDuvtopjmi+ZYzxLqxsniCA=;
        b=kcw6cIqxw7YMhSE5LXDk5ng7RnHxEmECdPwsWZR5aBHn4ChPPZN7YMCcx4NkLRoyqi
         GLwGiqBGSy3xohhN0znASZRePauVmvB5N9C1DkcuWD0ekZt58QIfsTwT9jNXSyWF1byq
         HkGCMeuDSMyZRDAPE3H8EfveaJaQh4IuRJhUDV3/zcBm3kuHlyfvx2bF5f/kXAoEC/Ub
         /IcvwSyt/87C+u5bcaK4CtJ6VlglZDlLpV0paLle2CX54KiMvYyC9ytle1jBX2nOz6zr
         JHNMJ//cs26namaviJQolxBQLiljoNfvR2L6ri0zz7MWOm9W3SsmU2YwuMw73mTo9bII
         0zdg==
X-Forwarded-Encrypted: i=1; AJvYcCXfwOx8UGv9cCThmWY27Q02fYMx71J8kMKjw1MEZT0QKXndTL0A5pMAWKBHHNuwf+3p98OuYAZ5XvtkfV5QfhSe8BwbBkw7FoEhPOZG
X-Gm-Message-State: AOJu0YyXx19Gw5NSrhzmhcAwZVQU3o2Gzy1+iCXx+2/SgfYNYE3aK5Qc
	S113pO5aw7lb8IQYtGsAGeUEVC6XQj4vHc2rGJsz4bKdRxaVM6yxIOyTz7VGVlGLHVFsUW0CBgw
	v7FZXluWoD5MANJOGSxwjfZjAWKolNRRIk2U=
X-Google-Smtp-Source: AGHT+IFd2Jp1I9ELGYX3bQIv9MlMweJcLu3FbVDNB9ZNdOKcY0gTE3cCgnMZZeQOMS/tXE5b1HUrWv/twgiq5OAFDVU=
X-Received: by 2002:ac2:5ded:0:b0:52e:be50:9c66 with SMTP id
 2adb3069b0e04-5309b2c5b4fmr509847e87.53.1722023055175; Fri, 26 Jul 2024
 12:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 26 Jul 2024 21:43:38 +0200
Message-ID: <CA+icZUVA-5qh+trkS+tiAUbcxMXt2cUeimTAhbjPubVM2qqpPg@mail.gmail.com>
Subject: arm64: allow installing compressed image by default
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008018a3061e2bbc69"

--0000000000008018a3061e2bbc69
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

COMPRESSED_INSTALL sounds not very meaningful.

What about ... ?

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ae527d1d409f..d9f771c788d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2337,8 +2337,8 @@ config EFI
         allow the kernel to be booted as an EFI application. This
         is only useful on systems that have UEFI firmware.

-config COMPRESSED_INSTALL
-       bool "Install compressed image by default"
+config KERNEL_IMAGE_COMPRESSED_INSTALL
+       bool "Install compressed kernel image by default"
       help
         This makes the regular "make install" install the compressed
         image we built, not the legacy uncompressed one.
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f6bc3da1ef11..1d9b4978eb98 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -182,7 +182,7 @@ $(BOOT_TARGETS): vmlinux
Image.%: Image
       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@

-ifeq ($(CONFIG_COMPRESSED_INSTALL),y)
+ifeq ($(CONFIG_KERNEL_IMAGE_COMPRESSED_INSTALL),y)
 DEFAULT_KBUILD_IMAGE = $(KBUILD_IMAGE)
else
 DEFAULT_KBUILD_IMAGE = $(boot)/Image
@@ -235,8 +235,8 @@ define archhelp
  echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
  echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
  echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)'
-  echo  '  install       - Install kernel (compressed if
COMPRESSED_INSTALL set)'
-  echo  '  zinstall      - Install compressed kernel'
+  echo  '  install       - Install kernel image (compressed if
KERNEL_IMAGE_COMPRESSED_INSTALL is set)'
+  echo  '  zinstall      - Install compressed kernel image'
  echo  '                  Install using (your) ~/bin/installkernel or'
  echo  '                  (distribution) /sbin/installkernel or'
  echo  '                  install to $$(INSTALL_PATH) and run lilo

I would have renamed KBUILD_IMAGE to KERNEL_IMAGE but other archs use the first.

Thanks.

Best regards,
-Sedat-

P.S.: Attached as patch in the case when GMail will truncate above snippet.

--0000000000008018a3061e2bbc69
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-arm64-Rename-to-KERNEL_IMAGE_COMPRESSED_INSTALL-kcon.patch"
Content-Disposition: attachment; 
	filename="0001-arm64-Rename-to-KERNEL_IMAGE_COMPRESSED_INSTALL-kcon.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lz33zhtk0>
X-Attachment-Id: f_lz33zhtk0

RnJvbSA2ZGU5NjU3M2Y5MDkzNDU3NDRkNjNlM2E1ZjU5NDBhNzgyNDFiMmFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBGcmksIDI2IEp1bCAyMDI0IDIxOjM3OjAwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gYXJt
NjQ6IFJlbmFtZSB0byBLRVJORUxfSU1BR0VfQ09NUFJFU1NFRF9JTlNUQUxMIGtjb25maWcgZm9y
CiBjb21wcmVzc2VkIGtlcm5lbCBpbWFnZQoKVGhlIENPTVBSRVNTRURfSU5TVEFMTCBkb2VzIG5v
dCBzb3VuZCB2ZXJ5IG1lYW5pbmdmdWwuCgpSZW5hbWUgZnJvbSBDT01QUkVTU0VEX0lOU1RBTEwg
a2NvbmZpZyB0byBLRVJORUxfSU1BR0VfQ09NUFJFU1NFRF9JTlNUQUxMLgoKRml4ZXM6IGNvbW1p
dCA0YzdiZTU3ZjIgKCJhcm02NDogYWxsb3cgaW5zdGFsbGluZyBjb21wcmVzc2VkIGltYWdlIGJ5
IGRlZmF1bHQiKQpDYzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4K
QWNrZWQtYnk6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IExp
bnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KU2lnbmVkLW9mZi1i
eTogU2VkYXQgRGlsZWsgPHNlZGF0LmRpbGVrQGdtYWlsLmNvbT4KLS0tCiBhcmNoL2FybTY0L0tj
b25maWcgIHwgNCArKy0tCiBhcmNoL2FybTY0L01ha2VmaWxlIHwgNiArKystLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvS2NvbmZpZyBiL2FyY2gvYXJtNjQvS2NvbmZpZwppbmRleCBhZTUyN2QxZDQwOWYu
LmQ5Zjc3MWM3ODhkNyAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9LY29uZmlnCisrKyBiL2FyY2gv
YXJtNjQvS2NvbmZpZwpAQCAtMjMzNyw4ICsyMzM3LDggQEAgY29uZmlnIEVGSQogCSAgYWxsb3cg
dGhlIGtlcm5lbCB0byBiZSBib290ZWQgYXMgYW4gRUZJIGFwcGxpY2F0aW9uLiBUaGlzCiAJICBp
cyBvbmx5IHVzZWZ1bCBvbiBzeXN0ZW1zIHRoYXQgaGF2ZSBVRUZJIGZpcm13YXJlLgogCi1jb25m
aWcgQ09NUFJFU1NFRF9JTlNUQUxMCi0JYm9vbCAiSW5zdGFsbCBjb21wcmVzc2VkIGltYWdlIGJ5
IGRlZmF1bHQiCitjb25maWcgS0VSTkVMX0lNQUdFX0NPTVBSRVNTRURfSU5TVEFMTAorCWJvb2wg
Ikluc3RhbGwgY29tcHJlc3NlZCBrZXJuZWwgaW1hZ2UgYnkgZGVmYXVsdCIKIAloZWxwCiAJICBU
aGlzIG1ha2VzIHRoZSByZWd1bGFyICJtYWtlIGluc3RhbGwiIGluc3RhbGwgdGhlIGNvbXByZXNz
ZWQKIAkgIGltYWdlIHdlIGJ1aWx0LCBub3QgdGhlIGxlZ2FjeSB1bmNvbXByZXNzZWQgb25lLgpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9NYWtlZmlsZSBiL2FyY2gvYXJtNjQvTWFrZWZpbGUKaW5k
ZXggZjZiYzNkYTFlZjExLi4xZDliNDk3OGViOTggMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvTWFr
ZWZpbGUKKysrIGIvYXJjaC9hcm02NC9NYWtlZmlsZQpAQCAtMTgyLDcgKzE4Miw3IEBAICQoQk9P
VF9UQVJHRVRTKTogdm1saW51eAogSW1hZ2UuJTogSW1hZ2UKIAkkKFEpJChNQUtFKSAkKGJ1aWxk
KT0kKGJvb3QpICQoYm9vdCkvJEAKIAotaWZlcSAoJChDT05GSUdfQ09NUFJFU1NFRF9JTlNUQUxM
KSx5KQoraWZlcSAoJChDT05GSUdfS0VSTkVMX0lNQUdFX0NPTVBSRVNTRURfSU5TVEFMTCkseSkK
ICBERUZBVUxUX0tCVUlMRF9JTUFHRSA9ICQoS0JVSUxEX0lNQUdFKQogZWxzZQogIERFRkFVTFRf
S0JVSUxEX0lNQUdFID0gJChib290KS9JbWFnZQpAQCAtMjM1LDggKzIzNSw4IEBAIGRlZmluZSBh
cmNoaGVscAogICBlY2hvICAnKiBJbWFnZS5neiAgICAgIC0gQ29tcHJlc3NlZCBrZXJuZWwgaW1h
Z2UgKGFyY2gvJChBUkNIKS9ib290L0ltYWdlLmd6KScKICAgZWNobyAgJyAgSW1hZ2UgICAgICAg
ICAtIFVuY29tcHJlc3NlZCBrZXJuZWwgaW1hZ2UgKGFyY2gvJChBUkNIKS9ib290L0ltYWdlKScK
ICAgZWNobyAgJyAgaW1hZ2UuZml0ICAgICAtIEZsYXQgSW1hZ2UgVHJlZSAoYXJjaC8kKEFSQ0gp
L2Jvb3QvaW1hZ2UuZml0KScKLSAgZWNobyAgJyAgaW5zdGFsbCAgICAgICAtIEluc3RhbGwga2Vy
bmVsIChjb21wcmVzc2VkIGlmIENPTVBSRVNTRURfSU5TVEFMTCBzZXQpJwotICBlY2hvICAnICB6
aW5zdGFsbCAgICAgIC0gSW5zdGFsbCBjb21wcmVzc2VkIGtlcm5lbCcKKyAgZWNobyAgJyAgaW5z
dGFsbCAgICAgICAtIEluc3RhbGwga2VybmVsIGltYWdlIChjb21wcmVzc2VkIGlmIEtFUk5FTF9J
TUFHRV9DT01QUkVTU0VEX0lOU1RBTEwgaXMgc2V0KScKKyAgZWNobyAgJyAgemluc3RhbGwgICAg
ICAtIEluc3RhbGwgY29tcHJlc3NlZCBrZXJuZWwgaW1hZ2UnCiAgIGVjaG8gICcgICAgICAgICAg
ICAgICAgICBJbnN0YWxsIHVzaW5nICh5b3VyKSB+L2Jpbi9pbnN0YWxsa2VybmVsIG9yJwogICBl
Y2hvICAnICAgICAgICAgICAgICAgICAgKGRpc3RyaWJ1dGlvbikgL3NiaW4vaW5zdGFsbGtlcm5l
bCBvcicKICAgZWNobyAgJyAgICAgICAgICAgICAgICAgIGluc3RhbGwgdG8gJCQoSU5TVEFMTF9Q
QVRIKSBhbmQgcnVuIGxpbG8nCi0tIAoyLjQ1LjIKCg==
--0000000000008018a3061e2bbc69--

