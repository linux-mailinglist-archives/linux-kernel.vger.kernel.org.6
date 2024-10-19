Return-Path: <linux-kernel+bounces-372913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354759A4F20
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F50A1F2704A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFD4188CB5;
	Sat, 19 Oct 2024 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RSxock2j"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0F2772A
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729352063; cv=none; b=j0mOWnIbdNVjH3qftAcpdrP+BHdskM2UZ8wMx9a3kqX3POZJwjDFdIiSYw//eMXOpUKUm/9hUy4jvUxxVwL6S1Op1PAvr6N1gdmv3jMD+ZfdJPzvtCAt4yHVenKrRf7HwIc465bNG5V7fDg9lMC/yEGO0+IQQG2VajQQ2a8W6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729352063; c=relaxed/simple;
	bh=2VEf0sZkKNyJqV8bPANqoeIKJLjrteDBJkPH+wW3P7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU13E4SA8Hi4rPLXSwbo4zh6ZLXfPCc+cY2q1lRprlfF3j2Ojg7dXAQd6fb0Ecu4dv0twNi1pwfN/VTpaStW9sNNu4ydtq2u+UaatuyAq3YAAT1wYvaoASPNQan5V03DeI6a5o6W6Dj8otObrcGrWeuranorw81jP2urTDYS9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RSxock2j; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2908e8d45eso2788919276.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729352059; x=1729956859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt9BnWbKgBvIPn8Egk93F8g/4UamVtbhqjDHYRc0VbU=;
        b=RSxock2j4eFSMhlPud2PzMLhYJac3rWyeEDfgpn6nEyOad4weShuW0oPInoz9hKbG8
         Ww7E5MQV80gkmZirtXUcT3sGyi4ZKtp275tH4BsfKCP0Laepk+0gV2WD25h77PzZ8Ck9
         Qb61d6X1prsbHCW6kW+Kuj5dxj5OA7Dl9h3HosI/w+TnOjM+mzsqsQapyJJZaF6mc4Ka
         fd48+oheIE9sLzbV5e0BiUExUP7Z0PLusAZbv8b6lLFLWYxjO/1IQ04uuoPvgTKjTijU
         Ld9RDoyrTGzzCyxH0fkWmrCIFrz1YWyuBfy66q1laX3QGf9P16At8QHYI36hm66E3Og4
         8+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729352059; x=1729956859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt9BnWbKgBvIPn8Egk93F8g/4UamVtbhqjDHYRc0VbU=;
        b=F7mtnEK8xYvHgHFiibzNeIZS+2n0bAaWKHiJhawwPRqdBeJ+dwdsq/PY9GMiD2XFL4
         0WqbPHyJh32HcQPkQT/BjkCFb/oPR4gArOraJWbOCL4ZQsiBOoKZID06Oh/P0d8om1BM
         NiVatgPmXyO8VdFBQzSBKp0L2/W62MmehBTU2AlZWk8piIbXfkyjQzSDsR8RncYg5dT3
         SKrpiLxl17TA/0UX7h7rI02ZA6gBAAiZThzsNAzmcAkTW+1/8u19KFkGiL4a/PMA0oy/
         +HLs2lEPjfqiPod+3C65ggTRH/V7AOXKUlALS1Yd12iPUtIaguRssHIX9Sdj8weo7G9L
         xoxg==
X-Forwarded-Encrypted: i=1; AJvYcCWGrbBAYNZNXnggqpbaUmklsvBknX/gcoMTWanTZCNUd0tz94xFHWhEL/Y48hvnNINNjrbhTLDt84oZmcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOh4cNoqzLxJ9/dagMPd7ZOr6EkiuO8bkP+Uv6NQ5Vj1R+C3Ug
	uR8rGBKSdNpGtGMrcAh6DqzWom6k3+blR81T0w5Z4CDWPk0gIrc7335pX1xN3uOzEfShHIVXl1W
	w3Jl/uheUAOvMU9NzVrWNKOFBwMuamo2X105W
X-Google-Smtp-Source: AGHT+IGtdGqzYcDLxnIpfjuAVP5vxoGEl/nSImRtgtKWi9QsQ/qNJR8p9BgodGD1xEymrlwrAaFBjtak2CSZfpvFhTo=
X-Received: by 2002:a05:690c:f91:b0:6de:c0e:20ef with SMTP id
 00721157ae682-6e5bfbdbe14mr53079707b3.7.1729352059439; Sat, 19 Oct 2024
 08:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Oct 2024 11:34:08 -0400
Message-ID: <CAHC9VhQP7gBa4AV-Hbh4Bq4fRU6toRmjccv52dGoU-s+MqsmfQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Split critical region in remap_file_pages() and
 invoke LSMs in between
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ebpqwerty472123@gmail.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 12:15=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
> remap_file_pages()") fixed a security issue, it added an LSM check when
> trying to remap file pages, so that LSMs have the opportunity to evaluate
> such action like for other memory operations such as mmap() and mprotect(=
).
>
> However, that commit called security_mmap_file() inside the mmap_lock loc=
k,
> while the other calls do it before taking the lock, after commit
> 8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").
>
> This caused lock inversion issue with IMA which was taking the mmap_lock
> and i_mutex lock in the opposite way when the remap_file_pages() system
> call was called.
>
> Solve the issue by splitting the critical region in remap_file_pages() in
> two regions: the first takes a read lock of mmap_lock, retrieves the VMA
> and the file descriptor associated, and calculates the 'prot' and 'flags'
> variables; the second takes a write lock on mmap_lock, checks that the VM=
A
> flags and the VMA file descriptor are the same as the ones obtained in th=
e
> first critical region (otherwise the system call fails), and calls
> do_mmap().
>
> In between, after releasing the read lock and before taking the write loc=
k,
> call security_mmap_file(), and solve the lock inversion issue.
>
> Cc: stable@vger.kernel.org # v6.12-rcx
> Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap=
_file_pages()")
> Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.4=
6d20.0036.GAE@google.com/
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Tested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 17 deletions(-)

Thanks for working on this Roberto, Kirill, and everyone else who had
a hand in reviewing and testing.

Reviewed-by: Paul Moore <paul@paul-moore.com>

Andrew, I see you're pulling this into the MM/hotfixes-unstable
branch, do you also plan to send this up to Linus soon/next-week?  If
so, great, if not let me know and I can send it up via the LSM tree.

We need to get clarity around Roberto's sign-off, but I think that is
more of an administrative mistake rather than an intentional omission
:)

--=20
paul-moore.com

