Return-Path: <linux-kernel+bounces-172620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54A48BF459
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709A91F252A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC49944E;
	Wed,  8 May 2024 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EJQIVfmk"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2B8F55
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134100; cv=none; b=nS5tY3xoqMfYEfHr3r+9kPjQvCp4thXKKrlF1ILErO9Mf/zRCRH5H6YDEGVGFcBF4YY1QqJ1FmsoRbb/ov1tmQ2QnrTrVofkgdJAnDj4ig8m1jTxPpXjOFEZT5NDIMIAItlkPrjbaVG/xm49DPbSr8U2W8jCRQjMaGXYtjR73KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134100; c=relaxed/simple;
	bh=agy9+JvSsjkh/8vuiZScDKeMv5BxMXimZr+iwOD9br0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WBtxiEpyu1JuI7ZYqhjNOKlEgTv8/ZPy/EgznJl5MapHAOcVcm3PvWv07BrQf9wkNUIQfrOblpUVcFBy+WiqbnNwO/LInv/OIrVDdB/zrvn3z+BvQ5kRfLwem1K8yolpdTZN3W4GV/7mFDiAK0K2sC4tkWvNfPF7Je8mqHygMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EJQIVfmk; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2df83058d48so46044061fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 19:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715134096; x=1715738896; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RA5zO8osT581yFAhgKqZ9U4T2nN2QEoLCxUvIOmSqY=;
        b=EJQIVfmkZsTCAm8E4kDj+88nxmhpGc9rK1sBXSVsOl6SW6BYmrRX0vn/GPjGjr2vqJ
         l4OTyYrsKlM3svY0njbmWpBrU2wb/mAKTQreuq0/sK2tBOcruo65AVRaboQHh6ocamqN
         pK/boy0bupvFzAw3dWHz61fKvqeGQOMBeUexPChWm93uhXZWL0K16XvEav6jl8dTm1Nh
         z3YpC+vR/bKjm4qMRPbccfkeeZIh5RNa45Kl5e5bGDaBi5Rco2yXE9II4i4apG6/j5HH
         BdaNEMduq/0k4jtQANF7XZ1O4YA59iNsEz1bdJuXkycbwAJPT4WiBBpEez0vJMk1LAQc
         nVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715134096; x=1715738896;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RA5zO8osT581yFAhgKqZ9U4T2nN2QEoLCxUvIOmSqY=;
        b=TJ6e/aDSdSsaKfow6NlzEvuDbKoom2BlM3eccOJxEwO5xz5EkQNT4Jumy/peD8FQhw
         kO3ShRNsR+BE8XJgPXulmTMGzYfkefeEJETNhckjaHSpQuTLiNSjZe1UZCH+znBQ9WDQ
         Y0u+Eo0sGllImWKvvt5wy/yyODjxhiMqBEWw2WkWflCRRYB1HZu2olIp1Dm/ACzg5fHe
         TQIN80V4ioRGTrwErJmkH+N+WA3JRXhQU3i6/mMampzPAt2nnDM4M3MiwIdTwixxt7bn
         M1xSoM1YRcE63swJ2Kgmu0aK1Wcqq1cnRUvuum/otMxw4J3ydwisF+NadpUvYMwsp9+f
         ovhA==
X-Forwarded-Encrypted: i=1; AJvYcCXeXfYgDld5qfmX40gIccOu/IEqdMek3+KU6KRH4R2YL0J4b63i96WIiDhMK93wzP+M+XrvAo47jkxqXxdccaHMC3DLRHzpil55ExxL
X-Gm-Message-State: AOJu0YziooWTU5g2L9XAwjOHWx94vWZ7/8HK392pmfswo3BNOKYFkVm1
	M9f3I6xoSlrnRHquGEyTlK5YkPBIJ9JWkq5bS2GFLht55Pghih1QbmquutK7DY4=
X-Google-Smtp-Source: AGHT+IHuCKZWRSvYmBLsmIQIFIzj2KISU/Cxy4Z6gTC0a2VO73blSIRNmYX8gZSP0hZGHx3nlXGojg==
X-Received: by 2002:a2e:9cc2:0:b0:2d6:f69d:c74c with SMTP id 38308e7fff4ca-2e4476afb1dmr7263991fa.38.1715134095969;
        Tue, 07 May 2024 19:08:15 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.60])
        by smtp.gmail.com with ESMTPSA id d13-20020aa7868d000000b006f49c07f9dasm530017pfo.21.2024.05.07.19.08.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2024 19:08:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v3 1/1] bcachefs: Move BCACHEFS_STATFS_MAGIC value to UAPI
 magic.h
From: Glass Su <glass.su@suse.com>
In-Reply-To: <20240507153757.150891-1-pvorel@suse.cz>
Date: Wed, 8 May 2024 10:08:01 +0800
Cc: linux-bcachefs@vger.kernel.org,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Su Yue <l@damenly.org>,
 Brian Foster <bfoster@redhat.com>,
 Coly Li <colyli@suse.de>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D9FCB08-480D-4CA0-82E2-284B1F2BF8FD@suse.com>
References: <20240507153757.150891-1-pvorel@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On May 7, 2024, at 23:37, Petr Vorel <pvorel@suse.cz> wrote:
>=20
> Move BCACHEFS_STATFS_MAGIC value to UAPI <linux/magic.h> under
> BCACHEFS_SUPER_MAGIC definition (use common approach for name) and =
reuse the
> definition in bcachefs_format.h BCACHEFS_STATFS_MAGIC.
>=20
> There are other bcachefs magic definitions: BCACHE_MAGIC, BCHFS_MAGIC,
> which use UUID_INIT() and are used only in libbcachefs. Therefore move
> only BCACHEFS_STATFS_MAGIC value, which can be used outside of
> libbcachefs for f_type field in struct statfs in statfs() or =
fstatfs().
>=20
> Suggested-by: Su Yue <l@damenly.org>

Would you kindly amend it to Su Yue <glass.su@suse.com> or
Kent can help if the patch is going to be applied.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v2->v3:
> * Align tab with other entries.
>=20
> Changes v1->v2 (all suggested by Brian Foster - thanks!):
> * rename constant to BCACHEFS_SUPER_MAGIC,
> * keep BCACHEFS_STATFS_MAGIC in bcachefs_format.h, just include
> <uapi/linux/magic.h> and use BCACHEFS_SUPER_MAGIC definition,
> * move the constant to the first chunk.
>=20
> Kind regards,
> Petr
>=20
> fs/bcachefs/bcachefs_format.h | 3 ++-
> include/uapi/linux/magic.h    | 1 +
> 2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/bcachefs/bcachefs_format.h =
b/fs/bcachefs/bcachefs_format.h
> index f7fbfccd2b1e..3b831415409b 100644
> --- a/fs/bcachefs/bcachefs_format.h
> +++ b/fs/bcachefs/bcachefs_format.h
> @@ -76,6 +76,7 @@
> #include <asm/byteorder.h>
> #include <linux/kernel.h>
> #include <linux/uuid.h>
> +#include <uapi/linux/magic.h>
> #include "vstructs.h"
>=20
> #ifdef __KERNEL__
> @@ -1275,7 +1276,7 @@ enum bch_compression_opts {
> UUID_INIT(0xc68573f6, 0x66ce, 0x90a9, \
>  0xd9, 0x6a, 0x60, 0xcf, 0x80, 0x3d, 0xf7, 0xef)
>=20
> -#define BCACHEFS_STATFS_MAGIC 0xca451a4e
> +#define BCACHEFS_STATFS_MAGIC BCACHEFS_SUPER_MAGIC
>=20
> #define JSET_MAGIC __cpu_to_le64(0x245235c1a3625032ULL)
> #define BSET_MAGIC __cpu_to_le64(0x90135c78b99e07f5ULL)
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 1b40a968ba91..bb575f3ab45e 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -37,6 +37,7 @@
> #define HOSTFS_SUPER_MAGIC 0x00c0ffee
> #define OVERLAYFS_SUPER_MAGIC 0x794c7630
> #define FUSE_SUPER_MAGIC 0x65735546
> +#define BCACHEFS_SUPER_MAGIC 0xca451a4e

IIUC, due to some historical reasons bcachefs used to switched
ondisk sb magic from BCACHE_MAGIC to BCHFS_MAGIC.
Other major fses uses  *_SUPER_MAGIC both for ondisk=20
sb magic, kstatfs::f_type and super_block::s_magic.
However, for bcacehfs there are three magic numbers.

Anyway, it looks good to me so far:
Reviewed-by: Su Yue <glass.su@suse.com>=20

=E2=80=94=20
Su

> #define MINIX_SUPER_MAGIC 0x137F /* minix v1 fs, 14 char names */
> #define MINIX_SUPER_MAGIC2 0x138F /* minix v1 fs, 30 char names */
> --=20
> 2.43.0
>=20
>=20


