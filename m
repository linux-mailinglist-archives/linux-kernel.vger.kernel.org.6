Return-Path: <linux-kernel+bounces-340675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904B987682
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187111C2294A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E414BF8B;
	Thu, 26 Sep 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="B7Sgwx0N"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569D132139
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364508; cv=none; b=GK5wzVtUY0hPFqcgP8SFpejgMIeun5IVqyfr84JuWUwaYQFXoSIlqg6sX4gMxNzZv0gSu5u0S7FbuH93hHAWVFv/Eck0skbhQHkuc9JTmER9CwTDF9VuzM8ENdmLxEPGcTY+hByx98GKfjYa+Zx/9CRPS/y0Vh4kypYdgbNXiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364508; c=relaxed/simple;
	bh=hGj7hX36Yz6M3veE82IYXrpCynqOObaJaFlI9sts9SU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SKkPWRZPgazjWBILjyD1CGz7A5g4dCQPuNEiKxtOsxocZLs9lCx07vwY0L7BrJ7STxnBJo0bZLoER/sZcxbfafmQ0wBdroYmVLbjEvqbNpgc5aVOZAEimIb/9YrA2a9i5OIexbIy61XQeSVQZ16JZlNzgUFjzItn21W/i6t2p+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=B7Sgwx0N; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cd2cb5615so49277f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1727364505; x=1727969305; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujah04x8nIeo+ZJVnSmRgsAnsQNseuvKhLfM99ELf1g=;
        b=B7Sgwx0NK1+QC7WQylQTR23Mzt/N4LwBHWA9dj+6Lt8B91KSnHZQEDDwAW0Ik7x2m1
         U2aBh5EEQ2lajw/IjAyNKkAN8p1jKsGfWOfoiSm4tCN0Nk5Yx8n3tP+89RaPPgeqNjbw
         NQYRg7q9cY8Fx50uzlEiLBatSnIymoephx29NIT9aKni9c+O20NyX+EDsZUcov9Ja1J/
         dMRKbJdzkzU8K3+OZAHCHm41c9hSiKqMTCyLLVCAv8jvIuELZrVnrrie72dYTR7LkXoS
         7doQHHTIoQ40ee9FgzcfgZguHx/FSdsjRdJvDb2/66FK1bwMB7YV2WaHxh3lF+rHFPiJ
         y5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364505; x=1727969305;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujah04x8nIeo+ZJVnSmRgsAnsQNseuvKhLfM99ELf1g=;
        b=rugFWXIo6OS42jY17mAZlmsiGmc04d+GMrdHrvQ7n1E7IUK7m67fawVD2BhfAleZcr
         B7Hn757N1GTqcGZfdlIQnEFDmYca6zNJqlIwQ1x6/651++EgWwcrFbmJC4wNDDsT8uwf
         LWBZljYkFLf0OMT4UCrDUQiVVTz0JnLyC/N87jWIoKcc8EJeN7gzet0+02k/VJqbfZeX
         kqkQlYMymlGyMmmGNwBmH34lrRN5MyI+ObTvq9ZEakqlWQZS3pkGp+bPqZ4WAF80mlZ3
         B5Ynpo1MOfKp+73+rbql2rnmKsZQi3Vs78isX6wiXLu8EeeXQcRoTBe/ItExJH52D+D1
         z75g==
X-Forwarded-Encrypted: i=1; AJvYcCXME4RFfb8gEPzvi2jD/7ldjHuCWl2Hu5+fuP2k2a0I+iKxFz9ncEoQuMEgsh4seEmyuFhbTU9H4nXj3wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDq1jVgVLJ/nToX8RuKZqLY/2Y1HQk2iR9dNY8gEDgIyh/XoiC
	zV572ybvVqRo7FQhCjWNR7YbX9AIczT4+IjS7HmWugjm/9594mJYVsJ+v3vAzkk=
X-Google-Smtp-Source: AGHT+IGb54gpQXHIK5WVhFAxiWUX0pTAcoXPTPGYb+V9PZ+3h5CW50RH6c2Tm93VTkR/cI8wrS8tRg==
X-Received: by 2002:a05:6000:144a:b0:37c:d515:7674 with SMTP id ffacd0b85a97d-37cd51579cbmr187523f8f.6.1727364504649;
        Thu, 26 Sep 2024 08:28:24 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:82f:3680:12cb:d924])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5c26sm10125566b.80.2024.09.26.08.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2024 08:28:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in
 bch2_xattr_validate
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <ZvV6X5FPBBW7CO1f@archlinux>
Date: Thu, 26 Sep 2024 17:28:12 +0200
Cc: kent.overstreet@linux.dev,
 regressions@lists.linux.dev,
 linux-bcachefs@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E304FB2-799D-478F-889A-CDFC1A52DCD8@toblux.com>
References: <ZvV6X5FPBBW7CO1f@archlinux>
To: Jan Hendrik Farr <kernel@jfarr.cc>
X-Mailer: Apple Mail (2.3776.700.51)

Hi Jan,

On 26. Sep 2024, at 17:14, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>=20
> Hi Kent,
>=20
> found a strange regression in the patch set for 6.12.
>=20
> First bad commit is: 86e92eeeb23741a072fe7532db663250ff2e726a
> bcachefs: Annotate struct bch_xattr with __counted_by()
>=20
> When compiling with clang 18.1.8 (also with latest llvm main branch) =
and
> CONFIG_FORTIFY_SOURCE=3Dy my rootfs does not mount because there is an =
erroneous
> detection of a buffer overflow.
>=20
> The __counted_by attribute is supposed to be supported starting with =
gcc 15,
> not sure if it is implemented yet so I haven't tested with gcc trunk =
yet.
>=20
> Here's the relevant section of dmesg:
>=20
> [    6.248736] bcachefs (nvme1n1p2): starting version 1.12: =
rebalance_work_acct_fix
> [    6.248744] bcachefs (nvme1n1p2): recovering from clean shutdown, =
journal seq 1305969
> [    6.252374] ------------[ cut here ]------------
> [    6.252375] memchr: detected buffer overflow: 12 byte read of =
buffer size 0
> [    6.252379] WARNING: CPU: 18 PID: 511 at lib/string_helpers.c:1033 =
__fortify_report+0x45/0x50
> [    6.252383] Modules linked in: bcachefs lz4hc_compress lz4_compress =
hid_generic usbhid btrfs crct10dif_pclmul libcrc32c crc32_pclmul =
crc32c_generic polyval_clmulni crc32c_intel polyval_generic raid6_pq =
ghash_clmulni_intel xor sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel =
gf128mul nvme crypto_simd ccp xhci_pci cryptd sp5100_tco =
xhci_pci_renesas nvme_core nvme_auth video wmi ip6_tables ip_tables =
x_tables i2c_dev
> [    6.252404] CPU: 18 UID: 0 PID: 511 Comm: mount Not tainted =
6.11.0-10065-g6fa6588e5964 #98 d8e0beb515d91b387aa60970de7203f35ddd182c
> [    6.252406] Hardware name: Micro-Star International Co., Ltd. =
MS-7D78/PRO B650-P WIFI (MS-7D78), BIOS 1.C0 02/06/2024
> [    6.252407] RIP: 0010:__fortify_report+0x45/0x50
> [    6.252409] Code: 48 8b 34 c5 30 92 21 87 40 f6 c7 01 48 c7 c0 75 =
1b 0a 87 48 c7 c1 e1 93 07 87 48 0f 44 c8 48 c7 c7 ef 03 10 87 e8 0b c2 =
9b ff <0f> 0b e9 cf 5d 9e 00 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 =
90
> [    6.252410] RSP: 0018:ffffbb3d03aff350 EFLAGS: 00010246
> [    6.252412] RAX: 4ce590fb7c372800 RBX: ffff98d559a400e8 RCX: =
0000000000000027
> [    6.252413] RDX: 0000000000000002 RSI: 00000000ffffdfff RDI: =
ffff98e43db21a08
> [    6.252414] RBP: ffff98d559a400d0 R08: 0000000000001fff R09: =
ffff98e47ddcd000
> [    6.252415] R10: 0000000000005ffd R11: 0000000000000004 R12: =
ffff98d559a40000
> [    6.252416] R13: ffff98d54abf1320 R14: ffffbb3d03aff430 R15: =
0000000000000000
> [    6.252417] FS:  00007efc82117800(0000) GS:ffff98e43db00000(0000) =
knlGS:0000000000000000
> [    6.252418] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.252419] CR2: 000055d96658ea80 CR3: 000000010a12c000 CR4: =
0000000000f50ef0
> [    6.252420] PKRU: 55555554
> [    6.252421] Call Trace:
> [    6.252423]  <TASK>
> [    6.252425]  ? __warn+0xd5/0x1d0
> [    6.252427]  ? __fortify_report+0x45/0x50
> [    6.252429]  ? report_bug+0x144/0x1f0
> [    6.252431]  ? __fortify_report+0x45/0x50
> [    6.252433]  ? handle_bug+0x6a/0x90
> [    6.252435]  ? exc_invalid_op+0x1a/0x50
> [    6.252436]  ? asm_exc_invalid_op+0x1a/0x20
> [    6.252440]  ? __fortify_report+0x45/0x50
> [    6.252441]  __fortify_panic+0x9/0x10
> [    6.252443]  bch2_xattr_validate+0x13b/0x140 [bcachefs =
8361179bbfcc59e669df38aec976f02d7211a659]
> [    6.252463]  bch2_btree_node_read_done+0x125a/0x17a0 [bcachefs =
8361179bbfcc59e669df38aec976f02d7211a659]
> [    6.252482]  btree_node_read_work+0x202/0x4a0 [bcachefs =
8361179bbfcc59e669df38aec976f02d7211a659]
> [    6.252499]  bch2_btree_node_read+0xa8d/0xb20 [bcachefs =
8361179bbfcc59e669df38aec976f02d7211a659]
> [    6.252514]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.252515]  ? pcpu_alloc_noprof+0x741/0xb50
> [    6.252517]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.252519]  ? time_stats_update_one+0x75/0x1f0 [bcachefs =
8361179bbfcc59e669df38aec976f02d7211a659]
>=20
> ...
>=20
>=20
> The memchr in question is at:
> =
https://github.com/torvalds/linux/blob/11a299a7933e03c83818b431e6a1c53ad38=
7423d/fs/bcachefs/xattr.c#L99
>=20
> There is not actually a buffer overflow here, I checked with gdb that
> xattr.v->x_name does actually contain a string of the correct length =
and
> xattr.v->x_name_len contains the correct length and should be used to =
determine
> the length when memchr uses __struct_size for bounds-checking due to =
the
> __counted_by annotation.
>=20
> I'm at the point where I think this is probably a bug in clang. I have =
a patch
> that does fix (more like bandaid) the problem and adds some print =
statements:
>=20
> --
> diff --git a/fs/bcachefs/xattr.c b/fs/bcachefs/xattr.c
> index 56c8d3fe55a4..8d7e749b7dda 100644
> --- a/fs/bcachefs/xattr.c
> +++ b/fs/bcachefs/xattr.c
> @@ -74,6 +74,7 @@ int bch2_xattr_validate(struct bch_fs *c, struct =
bkey_s_c k,
>       enum bch_validate_flags flags)
> {
> struct bkey_s_c_xattr xattr =3D bkey_s_c_to_xattr(k);
> + const struct bch_xattr *v =3D (void *)k.v;
> unsigned val_u64s =3D xattr_val_u64s(xattr.v->x_name_len,
>   le16_to_cpu(xattr.v->x_val_len));
> int ret =3D 0;
> @@ -94,9 +95,12 @@ int bch2_xattr_validate(struct bch_fs *c, struct =
bkey_s_c k,
>=20
> bkey_fsck_err_on(!bch2_xattr_type_to_handler(xattr.v->x_type),
> c, xattr_invalid_type,
> - "invalid type (%u)", xattr.v->x_type);
> + "invalid type (%u)", v->x_type);
>=20
> - bkey_fsck_err_on(memchr(xattr.v->x_name, '\0', xattr.v->x_name_len),
> + pr_info("x_name_len: %d", v->x_name_len);
> + pr_info("__struct_size(x_name): %ld", __struct_size(v->x_name));
> + pr_info("__struct_size(x_name): %ld", =
__struct_size(xattr.v->x_name));
> + bkey_fsck_err_on(memchr(v->x_name, '\0', v->x_name_len),
> c, xattr_name_invalid_chars,
> "xattr name has invalid characters");
> fsck_err:
> --
>=20
>=20
> Making memchr access via a pointer created with
> const struct bch_xattr *v =3D (void *)k.v fixes it. =46rom the print =
statements I
> can see that __struct_size(xattr.v->x_name) incorrectly returns 0, =
while
> __struct_size(v->x_name) correctly returns 10 in this case (the value =
of
> x_name_len).
>=20
> The generated assembly illustrates what is going wrong. Below is an =
excerpt
> of the assembly clang generated for the bch2_xattr_validate function:
>=20
> mov r13d, ecx
> mov r15, rdi
> mov r14, rsi
> mov rdi, offset .L.str.3
> mov rsi, offset .L__func__.bch2_xattr_validate
> mov rbx, rdx
> mov edx, eax
> call _printk
> movzx edx, byte ptr [rbx + 1]
> mov rdi, offset .L.str.4
> mov rsi, offset .L__func__.bch2_xattr_validate
> call _printk
> movzx edx, bh
> mov rdi, offset .L.str.4
> mov rsi, offset .L__func__.bch2_xattr_validate
> call _printk
> lea rdi, [rbx + 4]
> mov r12, rbx
> movzx edx, byte ptr [rbx + 1]
> xor ebx, ebx
> xor esi, esi
> call memchr
>=20
> At the start of this rdx contains k.v (and is moved into rbx). The =
three calls
> to printk are the ones you can see in my patch. You can see that for =
the
> print that uses __struct_size(v->x_name) the compiler correctly uses
> movzx edx, byte ptr [rbx + 1]
> to load x_name_len into edx.
>=20
> For the printk call that uses __struct_size(xattr.v->x_name) however =
the
> compiler uses
> movzx edx, bh
> So it will print the high 8 bits of the lower 16 bits (second least
> significant byte) of the memory address of xattr.v->x_type. This is =
obviously
> completely wrong.
>=20
> It is then doing the correct call of memchr because this is using my =
patch.
> Without my patch it would be doing the same thing for the call to =
memchr where
> it uses the second least significant byte of the memory address of =
x_type as the
> length used for the bounds-check.
>=20
>=20
>=20
> The LLVM IR also shows the same problem:
>=20
> define internal zeroext i1 @xattr_cmp_key(ptr nocapture readnone %0, =
ptr %1, ptr nocapture noundef readonly %2) #0 align 16 {
>  [...]
>  %51 =3D ptrtoint ptr %2 to i64
>  %52 =3D lshr i64 %51, 8
>  %53 =3D and i64 %52, 255
>=20
> This is the IR for the incorrect behavior. It simply converts the =
pointer to an
> int, shifts right by 8 bits, then and with 0xFF. If it did a load (to =
i64)
> instead of ptrtoint this would actually work, as the second least =
significant
> bit of an i64 loaded from that memory address does contain the value =
of
> x_name_len. It's as if clang forgot to dereference a pointer here.
>=20
> Correct IR does this (for the other printk invocation):
>=20
> define internal zeroext i1 @xattr_cmp_key(ptr nocapture readnone %0, =
ptr %1, ptr nocapture noundef readonly %2) #0 align 16 {
>  [...]
>  %4 =3D getelementptr inbounds %struct.bch_xattr, ptr %1, i64 0, i32 1
>  %5 =3D load i8, ptr %4, align 8
>  [...]
>  %48 =3D load i8, ptr %5, align 4
>  %49 =3D zext i8 %48 to i64
>=20
> Best Regards
> Jan

I suspect it's the same Clang __bdos() "bug" as in [1] and [2].

[1] =
https://lore.kernel.org/linux-kernel/3D0816D1-0807-4D37-8D5F-3C55CA910FAA@=
linux.dev/
[2] https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/=

