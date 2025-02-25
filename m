Return-Path: <linux-kernel+bounces-530337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00CA43234
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1727A4D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889202110E;
	Tue, 25 Feb 2025 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Smez98vI"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8141CAB3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445352; cv=none; b=KKJVj4MRktlWXzqNWQPuwgIKLQgNoyb8lInYWpw2DCn8iPDHoZHMxYbDQ61TGVsYZGKqzWeIxQh7OxZtc/ges9ND5MUBgmEH8hN7m7u0jpFRz7CAeJAjwObhaiDbu9EAj50SdYViJYWsNqnuB5ZTgIGhtdXSKuANOuc/GPjerjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445352; c=relaxed/simple;
	bh=Mo37nMWc2E1LwezPKSvhNG/2wTFA2DkyTJqWyZNejzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J8wkz/NCy6acsnP6d+j21yWcdrhN0c1mlSV1mKfhL5g9XofunO7T8Xl1VnzE2W4Iemr7OtpYHA53MlZxdPxAoHn6Io07mDfoWkiTpBcJIOCE8Ibp5FByqaoAOkBxKjUuc1Mw9e47ONzGHR/vEV4cjL5AN7hIbx3Nll/9jBL+gdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Smez98vI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22109f29c99so101261365ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740445350; x=1741050150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mo37nMWc2E1LwezPKSvhNG/2wTFA2DkyTJqWyZNejzM=;
        b=Smez98vIfHNaqKu5vWs3tag3Em1ZeKb97PTShsvQ4Yhb1i2baX+m0csBhkijgxsOWW
         GFVS+NRs4Rj52oDQ3Zlhao8CNvSnEZhUj0sLSFOaMUCSuh/1TxPEo8tnbycT6/r3DkAq
         TCBCjKn+K2xs3R/Hfp5LlBs6I7CNM1vBaiW2g/Lp0b3jmMHT9ZCjYsPM4aoOOuPOaRU7
         y/nh2vmZ3RK3jJL6fRCe2Ap+8JnVvDBeThmR7YelyE8bnhC6JLu0VG1E3ouyYHOEtRJh
         E1v3r8dLRi46GWT6/NIbfJEardemoy1FkRg2fYMUcNIjPGr+8avCNgxSJ3GXoT0Xkaby
         ndjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740445350; x=1741050150;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mo37nMWc2E1LwezPKSvhNG/2wTFA2DkyTJqWyZNejzM=;
        b=sPm6J/5FNBq67QtdMj10pnIQhSTaMsKTZwmQwXA5hGdkRFELnfyekcuASV8AGsQYJP
         RXuMUqs07PDXTtUMhubQte+EShkPuiT+Aevn7ufclL5gvKbN/kN168A3371S33eYQrT5
         LKT8dzhixiyffoNRmh1+nJxHYokdjKqLFOs05MjD8f4vLm8MXK7Q3LSW+fVKLCwTqbwO
         koI/rJd9gVDo6tZmFBeL0/ua7DdWvaMHeA88ES+oyzFH3Cu/IivZNwRfgBbLUr6cY+4h
         qWMmEPHPkPdjz5zaJ108YpeNir3GQ6K75WbTA2E8oMdG0cVpjzgLgLTTpRuMCspAQjSL
         95bw==
X-Forwarded-Encrypted: i=1; AJvYcCUEC0XKFT3unWOkSQ2ZR1vKLP57jPUvXEZ/bHsa2NzAk8xdPMoI470ZDAMjce8+inj64vA6Dll6aF9m+bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHajD1Ckrzj0RuJNBJqUq1dQvdELHMSYATuDEoOJ/csdRyQfMk
	L4G2huA1ypnDi7kVHRTgvGfyKcZMi5UpdQ5wVUYdmZT+aJVl80OrOTbv7NNyAKlGgGryi3U8KQ=
	=
X-Google-Smtp-Source: AGHT+IGtpAtsGCPjB2f5j0E5FgCN/59sQH7uEbks2l54K32niqYIQGBiUJC1+FY38Cpr/+RR4wt4Jz9Ubg==
X-Received: from pfbit4.prod.google.com ([2002:a05:6a00:4584:b0:732:770f:99fe])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:230b:b0:734:9cc:a6e4
 with SMTP id d2e1a72fcca58-734791ab6bfmr2328539b3a.21.1740445350440; Mon, 24
 Feb 2025 17:02:30 -0800 (PST)
Date: Tue, 25 Feb 2025 01:02:24 +0000
In-Reply-To: <20250210083017.280937-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210083017.280937-1-wnliu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225010228.223482-1-wnliu@google.com>
Subject: Re: [PATCH 0/8] unwind, arm64: add sframe unwinder for kernel
From: Weinan Liu <wnliu@google.com>
To: wnliu@google.com
Cc: indu.bhagat@oracle.com, irogers@google.com, joe.lawrence@redhat.com, 
	jpoimboe@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org, 
	live-patching@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, 
	puranjay@kernel.org, roman.gushchin@linux.dev, rostedt@goodmis.org, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:30=E2=80=AFAM Weinan Liu <wnliu@google.com> wrot=
e:
> I already have a WIP patch to add sframe support to the kernel module.
> However, it is not yet working. I had trouble unwinding frames for the
> kernel module using the current algorithm.
>
> Indu has likely identified the issue and will be addressing it from the
> toolchain side.
>
> https://sourceware.org/bugzilla/show_bug.cgi?id=3D32666


I have a working in progress patch that adds sframe support for kernel
module.
https://github.com/heuza/linux/tree/sframe_unwinder.rfc

According to the sframe table values I got during runtime testing, looks
like the offsets are not correct .

When unwind symbols init_module(0xffff80007b155048) from the kernel=20
module(livepatch-sample.ko), the start_address of the FDE entries in the
sframe table of the kernel modules appear incorrect.
For instance, the first FDE's start_addr is reported as -20564. Adding
this offset to the module's sframe section address (0xffff80007b15a040)
yields 0xffff80007b154fec, which is not within the livepatch-sample.ko
memory region(It should be larger than 0xffff80007b155000).

Here are the sframe table values of the livepatch-samples.ko that I print
by qemu + gdb.

```
$ /usr/bin/aarch64-linux-gnu-objdump -L --sframe=3D.sframe ./samples/livepa=
tch/livepatch-sample.ko
./samples/livepatch/livepatch-sample.ko: =C2=A0 =C2=A0 file format elf64-li=
ttleaarch64

Contents of the SFrame section .sframe:
=C2=A0 Header :

=C2=A0 =C2=A0 Version: SFRAME_VERSION_2
=C2=A0 =C2=A0 Flags: SFRAME_F_FDE_SORTED
=C2=A0 =C2=A0 Num FDEs: 3
=C2=A0 =C2=A0 Num FREs: 11

=C2=A0 Function Index :

=C2=A0 =C2=A0 func idx [0]: pc =3D 0x0, size =3D 12 bytes
=C2=A0 =C2=A0 STARTPC =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFA =C2=A0 =C2=A0 =C2=A0 =
FP =C2=A0 =C2=A0 =C2=A0 =C2=A0RA
=C2=A0 =C2=A0 0000000000000000 =C2=A0sp+0 =C2=A0 =C2=A0 =C2=A0u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u

=C2=A0 =C2=A0 func idx [1]: pc =3D 0x0, size =3D 44 bytes
=C2=A0 =C2=A0 STARTPC =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFA =C2=A0 =C2=A0 =C2=A0 =
FP =C2=A0 =C2=A0 =C2=A0 =C2=A0RA
=C2=A0 =C2=A0 0000000000000000 =C2=A0sp+0 =C2=A0 =C2=A0 =C2=A0u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u
=C2=A0 =C2=A0 000000000000000c =C2=A0sp+0 =C2=A0 =C2=A0 =C2=A0u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u[s]
=C2=A0 =C2=A0 0000000000000010 =C2=A0sp+16 =C2=A0 =C2=A0 c-16 =C2=A0 =C2=A0=
 =C2=A0c-8[s]
=C2=A0 =C2=A0 0000000000000024 =C2=A0sp+0 =C2=A0 =C2=A0 =C2=A0u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u[s]
=C2=A0 =C2=A0 0000000000000028 =C2=A0sp+0 =C2=A0 =C2=A0 =C2=A0u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u

=C2=A0 =C2=A0 func idx [2]: pc =3D 0x0, size =3D 56 bytes
=C2=A0 =C2=A0 STARTPC =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFA =C2=A0 =C2=A0 =C2=A0 =
FP =C2=A0 =C2=A0 =C2=A0 =C2=A0RA
=C2=A0 =C2=A0 0000000000000000 =C2=A0sp+0 =C2=A0 =C2=A0 =C2=A0u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u
=C2=A0 =C2=A0 000000000000000c =C2=A0sp+0 =C2=A0 =C2=A0 =C2=A0u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u[s]
=C2=A0 =C2=A0 0000000000000010 =C2=A0sp+16 =C2=A0 =C2=A0 c-16 =C2=A0 =C2=A0=
 =C2=A0c-8[s]
=C2=A0 =C2=A0 0000000000000030 =C2=A0sp+0 =C2=A0 =C2=A0 =C2=A0u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u[s]
=C2=A0 =C2=A0 0000000000000034 =C2=A0sp+0 =C2=A0 =C2=A0 =C2=A0u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u



(gdb) bt
#0 =C2=A0find_fde (tbl=3D0xffff80007b157708, pc=3D18446603338286190664) at =
kernel/sframe_lookup.c:75
#1 =C2=A00xffff80008031e260 in sframe_find_pc (pc=3D18446603338286190664, e=
ntry=3D0xffff800086f83800) at kernel/sframe_lookup.c:175
#2 =C2=A00xffff800080035a48 in unwind_next_frame_sframe (state=3D0xffff8000=
86f83828) at arch/arm64/kernel/stacktrace.c:270
#3 =C2=A0kunwind_next (state=3D0xffff800086f83828) at arch/arm64/kernel/sta=
cktrace.c:332
...

(gdb) lx-symbols
loading vmlinux
scanning for modules in /home/wnliu/kernel
loading @0xffff80007b155000: /home/wnliu/kernel/samples/livepatch/livepatch=
-sample.ko
loading @0xffff80007b14d000: /home/wnliu/kernel/fs/fat/vfat.ko
loading @0xffff80007b130000: /home/wnliu/kernel/fs/fat/fat.ko

(gdb) p/x *tbl->sfhdr_p
$5 =3D {preamble =3D {magic =3D 0xdee2, version =3D 0x2, flags =3D 0x1}, ab=
i_arch =3D 0x2, cfa_fixed_fp_offset =3D 0x0, cfa_fixed_ra_offset =3D 0x0, a=
uxhdr_len =3D 0x0, num_fdes =3D 0x3, num_fres =3D 0xb, fre_len =3D 0x25, fd=
es_off =3D 0x0, fres_off =3D 0x3c}

(gdb) p/x tbl->sfhdr_p
$6 =3D 0xffff80007b15a040

(gdb) p *tbl->fde_p
$7 =3D {start_addr =3D -20564, size =3D 12, fres_off =3D 0, fres_num =3D 1,=
 info =3D 0 '\000', rep_size =3D 0 '\000', padding =3D 0}

(gdb) p *(tbl->fde_p + 1)
$11 =3D {start_addr =3D -20552, size =3D 44, fres_off =3D 3, fres_num =3D 5=
, info =3D 0 '\000', rep_size =3D 0 '\000', padding =3D 0}

(gdb) p *(tbl->fde_p + 2)
$12 =3D {start_addr =3D -20508, size =3D 56, fres_off =3D 20, fres_num =3D =
5, info =3D 0 '\000', rep_size =3D 0 '\000', padding =3D 0}

/* -20564 + 0xffff80007b15a040 =3D 0xffff80007b154fec */
(gdb) info symbol 0xffff80007b154fec
No symbol matches 0xffff80007b154fec
```

