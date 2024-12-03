Return-Path: <linux-kernel+bounces-429611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFFB9E1E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB53282F15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD991F12E3;
	Tue,  3 Dec 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dTDMv0Db"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027E1E4B0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234424; cv=none; b=Y8TiKH0NA58aBFSrO20Z4K48tPA+X3AXzvdIReiqwS9yUDkSfh/Eoe5yEp1ht61FEf1yl9oAyPKRobaIT37YMfviPwHf4f4p7b1TCDNVhHHWAYgEVHz+7v7lMSa2n/9kK1z2oGX1P23ZZ9qws9L4ywL0od9WH2v0CIF13c/Z0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234424; c=relaxed/simple;
	bh=iOWNxa0FbOCrwv5ucRi+SaoM3dSPL3rELemWPhXouTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBBl7sQCut/ajLt9HJKf8YHTWYbW45Z6gpRx/blwVJzt9omOGRNi7fvSVKLLzjFHkQoGJFqYdfpnwbSXRXnZ5Ot4QoTNkiqP/7yxoI/IqVnsfi6DLnufo0SqeHLTR3CweuVrpqnHPxU1jTVtcRwxpouRw0mNMou6ntPuYX69GaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dTDMv0Db; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d6e36de7so4774360f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733234420; x=1733839220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3ogWsoKVLGEepBB9n0gfB3e54+++vjJBGpvcY0eB2A=;
        b=dTDMv0DbUp3bdv3SogazRxBTLzJAjutKsPEejhA2ZEPiuLH9cUhWaM+6dwtwvppoxF
         r8TTE/+80Lj7FmTOcu7LHEyygEpAqragjNYJBCSIYPLkfBNhAT6bVIx/8JR8NqMYDN5N
         5FmdIULWfta0NeG7pyUpxYWVsfdpJptyO0tJopYqJx6k1Sailv1VVtDkt10TkPR/9Qfp
         sCBBCNiZwIPU9ak3Jxsl9Urh8wDSCH2WS8YZOqa6WG/qtekpXxIofc4Rh37F3is2NFWm
         FqIDiefizug60atYdJh0Rw8SyJj6sscS6DVc78c2W/6uvG+G1n77lmW9A/pEd9MSEh05
         5GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234420; x=1733839220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3ogWsoKVLGEepBB9n0gfB3e54+++vjJBGpvcY0eB2A=;
        b=do2BTAPuN968tx5yeQtcH4w5iHxMnH31eg2x/8y84vz2Uq3YDi6IHvvVo9buhk0v9c
         L4ODAh2FCzvmadwL5N0Ao9f9rE7eju9cruiYYABaq/cWnkM6Q4RA4DmF+OhOyFozOcdx
         aMGJjVLK4TcJlzYBvXrFSVTui2SS5OOclrKb84G87zdfLu7eXA/Zc8FJg3Ad9xXDfdYI
         1jzCRDEMn6FTc1j5MePNm1Ia8IoabH9a1iwW/5Jfs9WUezGJ+QCfK9p+JGiiI0bsTVg3
         CjoPkukofagBuNX0vI1oRq0a2UsLigi4TFXC9ZG6AtcpmYuCula6Wlsmkr3nwXZb8xFr
         Lbfw==
X-Forwarded-Encrypted: i=1; AJvYcCVjbRDsmtSokmjPxWmSA8xBtIDiaRSIKsRvekwphzJkSR7TQnNQQOumudrMW19SFlQwP9GcUo7ZMgjtEDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4rRXmx98D/iYL/WvmqJfDtGMd7zikbnYzuPoNpxLVmxarnfq
	zKdxgzVx81zi4nKSjhhZgZFCSp1LoKRIO8hwtvVWttv3HwF1VDJ+kt8doyiU9keNZLvJUzBqAiR
	e5lPWVqz4eGvCXHee1JApztiLknPxvU+OoNJKFXexcqe3RZqcWh9ung==
X-Gm-Gg: ASbGncvv9FvYupqaEdhc+EXrTi+AJxW+Oi0NQAo64rL5kl4FOb/1wEMo4Bo2KpWhDzN
	+a7mI9C+j1HNxcTUBy9JEllTOc19kNMWGwAa3bbmj0yXOZnXvd+4KEu5xW4OI
X-Google-Smtp-Source: AGHT+IHGs1wkYOjPfG6IkJlIa5Him6GjcmHqHXOYUHi3/uFgyDlfRxVXnTdrbUJka9yWUdOJC6wCZGhcBGYTlLj3iUo=
X-Received: by 2002:a5d:5f8b:0:b0:385:ef2f:9278 with SMTP id
 ffacd0b85a97d-385fd3cd993mr2977493f8f.2.1733234419785; Tue, 03 Dec 2024
 06:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com> <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
 <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com> <CAKPOu+_4z4NDG1CmqsBatJVF1rQXHvqHV6fUiHEcnBswa_u8BQ@mail.gmail.com>
In-Reply-To: <CAKPOu+_4z4NDG1CmqsBatJVF1rQXHvqHV6fUiHEcnBswa_u8BQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 3 Dec 2024 15:00:08 +0100
Message-ID: <CAKPOu+_ZGtCX48bntZQU=nGxqFPon+D_wDPiagtZPKmtYRfpgQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:30=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> __builtin_return_address(1) instantly crashes the kernel

I was able to capture the __builtin_return_address crash on a serial
console (this has nothing to do with the PSI memstall bug):

[16438.331677] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[16438.338693] #PF: supervisor read access in kernel mode
[16438.343866] #PF: error_code(0x0000) - not-present page
[16438.349038] PGD 0 P4D 0
[16438.351588] Oops: Oops: 0000 [#1] SMP PTI
[16438.355625] CPU: 18 UID: 2147486501 PID: 23486 Comm: less Not
tainted 6.11.10-cm4all4-hp+ #291
[16438.364297] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380
Gen10, BIOS U30 09/05/2019
[16438.372880] RIP: 0010:psi_memstall_enter+0x7f/0xa0
[16438.377708] Code: 89 df 80 8b 19 05 00 00 01 48 8b 45 08 48 89 83
c0 08 00 00 48 8b 45 00 48 8b 40 08 48 89 83 c8 08 00 00 48 8b 45 00
48 8b 00 <48> 8b 40 08 48 89 83 d0 08 00 00 e8 d1 fe ff ff 4c 89 e7 e8
29 28
[16438.396609] RSP: 0000:ffff9ee683bc7bd0 EFLAGS: 00010002
[16438.401869] RAX: 0000000000000000 RBX: ffff90c70c291740 RCX: 00000000000=
00001
[16438.409052] RDX: 000000000000000a RSI: 0000000000000000 RDI: ffff90c70c2=
91740
[16438.416234] RBP: ffff9ee683bc7be0 R08: 000000000007cec1 R09: 00000000000=
00007
[16438.423418] R10: ffff90c727d83678 R11: 0000000000000000 R12: ffff9124bd0=
ae000
[16438.430600] R13: 0000000000000014 R14: ffff9ee683bc7ce8 R15: 00000000000=
00000
[16438.437785] FS:  00007ff15f1f4740(0000) GS:ffff9124bd080000(0000)
knlGS:0000000000000000
[16438.445929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16438.451714] CR2: 0000000000000008 CR3: 000000010c54a002 CR4: 00000000007=
706f0
[16438.458896] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[16438.466079] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[16438.473263] PKRU: 55555554
[16438.475984] Call Trace:
[16438.478446]  <TASK>
[16438.480557]  ? __die+0x1f/0x60
[16438.483636]  ? page_fault_oops+0x15c/0x450
[16438.487761]  ? exc_page_fault+0x5e/0x100
[16438.491710]  ? asm_exc_page_fault+0x22/0x30
[16438.495923]  ? psi_memstall_enter+0x7f/0xa0
[16438.500135]  read_pages+0x205/0x220
[16438.503647]  ? free_unref_page+0x2c1/0x420
[16438.507771]  page_cache_ra_order+0x1d3/0x2b0
[16438.512069]  filemap_fault+0x548/0xba0
[16438.515845]  __do_fault+0x32/0x90
[16438.519182]  do_fault+0x2a1/0x4a0
[16438.522519]  __handle_mm_fault+0x337/0x1ca0
[16438.526730]  handle_mm_fault+0x128/0x260
[16438.530677]  do_user_addr_fault+0x1d8/0x5b0
[16438.534889]  exc_page_fault+0x5e/0x100
[16438.538663]  asm_exc_page_fault+0x22/0x30
[16438.542697] RIP: 0033:0x55ebb60829a0
[16438.546298] Code: Unable to access opcode bytes at 0x55ebb6082976.
[16438.552519] RSP: 002b:00007fffd2a03658 EFLAGS: 00010246
[16438.557779] RAX: 0000000000000016 RBX: 000055ebdb88b410 RCX: 000055ebdb8=
8b410
[16438.564963] RDX: 0000000000000ee4 RSI: 000055ec5b0b1e30 RDI: 000055ebdb8=
8b910
[16438.572147] RBP: 0000000000000010 R08: 00000000ffffffff R09: 00000000000=
00000
[16438.579331] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00046
[16438.586514] R13: 000055ebb6099e6c R14: 000055ebb6099c93 R15: 00007fffd2a=
03706
[16438.593697]  </TASK>
[16438.595895] Modules linked in:
[16438.598970] CR2: 0000000000000008
[16438.602307] ---[ end trace 0000000000000000 ]---

