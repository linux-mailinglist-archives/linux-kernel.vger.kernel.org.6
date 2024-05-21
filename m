Return-Path: <linux-kernel+bounces-185367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A98CB40A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443551C23693
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D614900F;
	Tue, 21 May 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4fAsBm9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B801494A3
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318471; cv=none; b=LiKHwv0ZWBideOEkUOQD+VvB5FBt+eKYEwwqoDWTVOYFncy17ou+FvnAu1XC+VigXxtK2Xo3n18jg9EYUGaMGwn2anIZoBVwv4ATk5hTf7tvuVs9AEQ4WQ4+7KB+AIMmd9kMEoE1NPCrkbLV8YbCNM5DWH54U59I11pubYka3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318471; c=relaxed/simple;
	bh=GEIFYDMiDqOUlJzRZA4PbPz2WefgTR7JG6gCJS0qa6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E70894qIBk6xNGFq+jJySkERBgQ9QlRTnoe6XiE0EzEd3wKmR5GaPeO0V7KxowQPVOR+FCqiLBR8rqYzuuc/mPy5o67YqACVEh6+qHAmy5GmPGN3MRHiQByLAG9mNN6xn/HKkUkwweGuDdDCsUJgS+AzuVkIkeJc1ndjh7UP27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4fAsBm9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716318468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dn6PdnAbKqai8Gq9rN/hTUE4RYD+AurcNGUDXgp58xI=;
	b=S4fAsBm9q07Wf+FjH5zpxbwXqG7YLZP1SA4bf0FDWgBgT/pZM3sAIXnez7aU7NbzH8DXnm
	H/lOebPgkLIHO73Nj7M8bG2dOT9PuC7ecN7PJWuR21KnGLMO+UxxM4W7eByphz88ovnl0H
	iH3IDMbwuBFhblPS5KaejV3/KqsOp4g=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-UN85KU8cOYetU_YqxymkGA-1; Tue, 21 May 2024 15:07:47 -0400
X-MC-Unique: UN85KU8cOYetU_YqxymkGA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-61be4601434so260356517b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318467; x=1716923267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn6PdnAbKqai8Gq9rN/hTUE4RYD+AurcNGUDXgp58xI=;
        b=a8JS3ld/WSkQdzdTq0bfTd+YG1+jP9Rnk5z/hDsFDseRZrZUMCL1Vs71sQOd9L8jeQ
         nVJTlauKldrAD9UvpVnQCPfhK+indlQR1vBxYW477FRXpOaa6j2WbmZ2M1P+FugGlqWO
         VLR7OlSq0XqCjQjXyk3LdsYSSyM9vHqryQ+Fy63QYitR93q0fV5vRYmmJxZsGafZhmAp
         VdbgGBD2T9kM/vsXKx75XmtF/zJFZ3/ftqOUgNzeehC32+tlX4zfNZo57J2qquzIO/WX
         U7B5XfJlxZIyQnoGEoOKFnrs7KFojyY1JvqtXpwUzzY+7AFaXbUoUjILrZVeBJIXqfFM
         NjQg==
X-Forwarded-Encrypted: i=1; AJvYcCW+voXGJSVG1FCbUcf6RDi26zrZQakmawsGMFU4jOakbB3bkIon+BTlW0mV6Juf9Az0MupdNswbvSyaz0AKXvozJ/EI1gMcK5190NA/
X-Gm-Message-State: AOJu0Yxcm0hF2Rma4leEO+d0bXm3lfdKHX7Pt1Zlk8PmeerkYaFIMZ6b
	DnKdR1Jtx10orfUvGxB/maubL6vHtg0T2kgLeP5SpbKi7syo41rx0iGv+jB4KxSBP3T0EaEULVI
	KIdYPI3HLgEN51ZpRmKM29RKX3md+MybiCGU+Pcl0jlBZ0bFv7Sb/LMDgekK2H4yKZHfbx8FWTc
	4V7zrEH20jFKK+NB8SBelwFlwq6BzpqGHv9t0qFAOevcXK5GY=
X-Received: by 2002:a0d:cb10:0:b0:618:8b98:f274 with SMTP id 00721157ae682-627e487d5a9mr29867b3.45.1716318466756;
        Tue, 21 May 2024 12:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFEv9vVF6nAIe4l5L7JOuOtvqZQrAkg9X0a9fBNuuXzySGrjmaEwIibjaYLGmZjTWPpRC4gxdQ6irvQ3pR+nY=
X-Received: by 2002:a0d:cb10:0:b0:618:8b98:f274 with SMTP id
 00721157ae682-627e487d5a9mr29747b3.45.1716318466428; Tue, 21 May 2024
 12:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410021833.work.750-kees@kernel.org> <20240410023155.2100422-3-keescook@chromium.org>
In-Reply-To: <20240410023155.2100422-3-keescook@chromium.org>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 21 May 2024 15:07:35 -0400
Message-ID: <CAGtn9rmJ2C=THWn351fH7s=PXTvOwag9P4_ecQx2_=cFCjs4Qg@mail.gmail.com>
Subject: Re: [PATCH 3/5] scsi: mpt3sas: Avoid possible run-time warning with
 long manufacturer strings
To: Kees Cook <keescook@chromium.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Justin Stitt <justinstitt@google.com>, 
	Sathya Prakash <sathya.prakash@broadcom.com>, 
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, MPT-FusionLinux.pdl@broadcom.com, 
	linux-scsi@vger.kernel.org, Charles Bertsch <cbertsch@cox.net>, 
	Bart Van Assche <bvanassche@acm.org>, Andy Shevchenko <andy@kernel.org>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Nilesh Javali <njavali@marvell.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Himanshu Madhani <himanshu.madhani@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, 
	GR-QLogic-Storage-Upstream@marvell.com, Marco Patalano <mpatalan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 10:32=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> The prior strscpy() replacement of strncpy() here expected the
> manufacture_reply strings to be NUL-terminated, but it is possible
> they are not, as the code pattern here shows, e.g., edev->vendor_id
> being exactly 1 character larger than manufacture_reply->vendor_id,
> and the replaced strncpy() was copying only up to the size of the
> source character array. Replace this with memtostr(), which is the
> unambiguous way to convert a maybe not-NUL-terminated character array
> into a NUL-terminated string.
>
> Fixes: b7e9712a02e8 ("scsi: mpt3sas: Replace deprecated strncpy() with st=
rscpy()")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: MPT-FusionLinux.pdl@broadcom.com
> Cc: linux-scsi@vger.kernel.org
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c      |  2 +-
>  drivers/scsi/mpt3sas/mpt3sas_transport.c | 14 +++++---------
>  2 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/m=
pt3sas_base.c
> index 258647fc6bdd..1320e06727df 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -4774,7 +4774,7 @@ _base_display_ioc_capabilities(struct MPT3SAS_ADAPT=
ER *ioc)
>         char desc[17] =3D {0};
>         u32 iounit_pg1_flags;
>
> -       strscpy(desc, ioc->manu_pg0.ChipName, sizeof(desc));
> +       memtostr(desc, ioc->manu_pg0.ChipName);
>         ioc_info(ioc, "%s: FWVersion(%02d.%02d.%02d.%02d), ChipRevision(0=
x%02x)\n",
>                  desc,
>                  (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3=
sas/mpt3sas_transport.c
> index 76f9a9177198..d84413b77d84 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> @@ -458,17 +458,13 @@ _transport_expander_report_manufacture(struct MPT3S=
AS_ADAPTER *ioc,
>                         goto out;
>
>                 manufacture_reply =3D data_out + sizeof(struct rep_manu_r=
equest);
> -               strscpy(edev->vendor_id, manufacture_reply->vendor_id,
> -                       sizeof(edev->vendor_id));
> -               strscpy(edev->product_id, manufacture_reply->product_id,
> -                       sizeof(edev->product_id));
> -               strscpy(edev->product_rev, manufacture_reply->product_rev=
,
> -                       sizeof(edev->product_rev));
> +               memtostr(edev->vendor_id, manufacture_reply->vendor_id);
> +               memtostr(edev->product_id, manufacture_reply->product_id)=
;
> +               memtostr(edev->product_rev, manufacture_reply->product_re=
v);
>                 edev->level =3D manufacture_reply->sas_format & 1;
>                 if (edev->level) {
> -                       strscpy(edev->component_vendor_id,
> -                               manufacture_reply->component_vendor_id,
> -                               sizeof(edev->component_vendor_id));
> +                       memtostr(edev->component_vendor_id,
> +                                manufacture_reply->component_vendor_id);
>                         tmp =3D (u8 *)&manufacture_reply->component_id;
>                         edev->component_id =3D tmp[0] << 8 | tmp[1];
>                         edev->component_revision_id =3D
> --
> 2.34.1
>
>

Tested-by: Marco Patalano <mpatalan@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com

This fixes the following warning & subsequent panic seen on one of our
test machines:

[    4.986905] ------------[ cut here ]------------
[    4.991545] strnlen: detected buffer overflow: 9 byte read of buffer siz=
e 8
[    4.998528] WARNING: CPU: 2 PID: 13 at lib/string_helpers.c:1029
__fortify_report+0x3f/0x50
[    5.006889] Modules linked in: qla2xxx(+) bnxt_en mpt3sas(+)
nvme_fc ahci crct10dif_pclmul libahci nvme_fabrics crc32_pclmul
crc32c_intel nvme_core libata t10_pi raid_class ghash_clmulni_intel
tg3 scsi_transport_fc scsi_transport_sas dimlib wmi dm_mirror
dm_region_hash dm_log dm_mod
[    5.031912] CPU: 2 PID: 13 Comm: kworker/u128:1 Not tainted 6.9.0+ #1
[    5.038352] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.21.2 02/19/2024
[    5.038355] Workqueue: fw_event_mpt3sas0 _firmware_event_work [mpt3sas]
[    5.052557] RIP: 0010:__fortify_report+0x3f/0x50
[    5.052560] Code: c1 83 e7 01 48 c7 c1 5c 4d 08 b9 48 c7 c7 80 c1
01 b9 48 8b 34 c5 80 cc af b8 48 c7 c0 66 4d 08 b9 48 0f 45 c8 e8 01
a8 a8 ff <0f> 0b c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
90 90
[    5.075926] RSP: 0018:ffffb972c02c7bb0 EFLAGS: 00010286
[    5.075928] RAX: 0000000000000000 RBX: ffff915503b12100 RCX: 00000000000=
00000
[    5.088284] RDX: ffff91586faaee40 RSI: ffff91586faa0bc0 RDI: ffff91586fa=
a0bc0
[    5.095418] RBP: ffff915503f11c08 R08: 0000000000000000 R09: ffffb972c02=
c7a60
[    5.102549] R10: ffffb972c02c7a58 R11: ffffffffb95deba8 R12: ffff9155126=
ef010
[    5.102551] R13: ffff9155086ecb50 R14: ffff9155126ef000 R15: ffff9155086=
ec848
[    5.102552] FS:  0000000000000000(0000) GS:ffff91586fa80000(0000)
knlGS:0000000000000000
[    5.116816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.120583] ata15.00: Security Log not supported
[    5.120723] ata15.00: Security Log not supported
[    5.130645] CR2: 00007f48a3d47a50 CR3: 00000003b2e20006 CR4: 00000000007=
706f0
[    5.130647] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    5.139880] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    5.139882] PKRU: 55555554
[    5.139883] Call Trace:
[    5.154146]  <TASK>
[    5.163991]  ? __warn+0x7f/0x120
[    5.168549]  ? __fortify_report+0x3f/0x50
[    5.175791]  ? report_bug+0x18a/0x1a0
[    5.179479]  ? handle_bug+0x3c/0x70
[    5.182994]  ? exc_invalid_op+0x14/0x70
[    5.182997]  ? asm_exc_invalid_op+0x16/0x20
[    5.191021]  ? __fortify_report+0x3f/0x50
[    5.195033]  __fortify_panic+0x9/0x10
[    5.198699]
_transport_expander_report_manufacture.isra.0+0x5f0/0x620 [mpt3sas]
[    5.206145]  mpt3sas_transport_port_add+0x5df/0x7a0 [mpt3sas]
[    5.211931]  _scsih_expander_add+0x28a/0x650 [mpt3sas]
[    5.217112]  ? _scsih_sas_host_refresh+0x2aa/0x510 [mpt3sas]
[    5.222799]  _scsih_sas_topology_change_event.isra.0+0x213/0x440 [mpt3sa=
s]
[    5.229714]  _mpt3sas_fw_work+0x6ab/0xb50 [mpt3sas]
[    5.234636]  ? pick_next_task+0x9e2/0xae0
[    5.238649]  ? finish_task_switch.isra.0+0x97/0x290
[    5.243555]  ? move_linked_works+0x70/0xa0
[    5.247661]  process_one_work+0x184/0x3b0
[    5.251673]  worker_thread+0x2f9/0x410
[    5.251677]  ? __pfx_worker_thread+0x10/0x10
[    5.251679]  kthread+0xcc/0x100
[    5.259713]  ? __pfx_kthread+0x10/0x10
[    5.259715]  ret_from_fork+0x2d/0x50
[    5.270190]  ? __pfx_kthread+0x10/0x10
[    5.273944]  ret_from_fork_asm+0x1a/0x30
[    5.277872]  </TASK>
[    5.280062] ---[ end trace 0000000000000000 ]---


