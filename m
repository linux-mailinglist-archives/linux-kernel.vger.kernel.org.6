Return-Path: <linux-kernel+bounces-237942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DCE9240DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CE61C22576
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31431BA07D;
	Tue,  2 Jul 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcYtzKMP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9806215B0FE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930570; cv=none; b=u3czWsPvhwnK2Huj/i8bAD/TwxUvZqd0a17H8nK44ox+w9oTSNv0tpaxhjdebY5YBYmCIP0nEl+vNfMxL7HeIVh6DprotXY81arTz944n/3EIbVtQ9R7fs+wyGXJbUccf9EUL1YGXREwPjxNKOzFXXZUJ9sHy+rDP+wbVQlV4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930570; c=relaxed/simple;
	bh=bQfHvnKbnsgaFe4SUybNa0fZ2yCvTSinDBnucZHdrI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+H57AHSNePAu7Qv1YmmbEZcC7PdczSqexx8BJ5Uu3W/HpOPYLw1R4YOyGw73qIE8Ouba4xITfSUHq89uPJ6Eye0RjpRsWjsFnCaY0U1GYuB9ddsoZM4vbdkqCtXD0oJRyHlkzyDziYkgbh1tdA2XKlu9liNUwLPMsj2VC2fzMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcYtzKMP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-424ad991cbbso33194975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719930567; x=1720535367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IAex0C8drdlkZxMli/n3mCvgYAdPAKLrdakmDvXPaI=;
        b=NcYtzKMPMeYQh7LRy/5x1k6w+hXDBxMhNYoQ1X9PHrIp8Khy+8ULFIqOJI6r62KQ61
         mkDiRB/59mFwzgxD/vwzC45sfqcg0ocILzABKuXgb1/lRizwy5hAOt9G0nR/KvNuvpBe
         9JueOdkURmaAEwWPLzmW1FbCVdbQ3hXiSv2n+6r3Vj6EgSoegHPMdtmDwHDnzj/D4iva
         fwmmVEGfqlOKuraYCnHADoFoPrOJwLi+3r+QIc42wyJq2FlY4nEPpj28Z5UUBtTIl5Le
         xu+/TVbv16ZuPU23DViqbax7ITqOpoTOLSDMiandQQOWrZq5KHnahqne1uobgmwkLS58
         utTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930567; x=1720535367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IAex0C8drdlkZxMli/n3mCvgYAdPAKLrdakmDvXPaI=;
        b=HiyRPpHegVj5+x2lbL9/fiSS5zVUXHpHZTDAt6PvJA0EH6b3TrQWwErBv2Ds7DVyJ0
         kD2P1RMRR1YK/7DgTvsw24X00U8kIY4Qik4apvILwtXJofR+TjJD5w3fdwUemqaiCFjk
         WyUSqJDnWEvidfgrJ5XN7HSP3JK2QvbnG6ptvm9kkoAvFwc4Qvqv4erLTqKzQHeX3xXz
         JtSSge92j8E90XW6AfOpdP+yq+UJd8TFtylSO8nOFChdCA3ETQ3oRM4OxXgWHR1iC7KF
         vpAzOC/hael4Xwfzbk+DbBRp2Ll3wl7oE+VAcC1QePCJgUMSE5GJ/6avkI+kZlgrgAaV
         fJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCVoPclMm1Y4FcaIE94CNzt/zHmQf2bA+N7wAbkq2bB1H4Pw1MPvgWlPlFF9r6Y6ongwnbaASP8hvre9QSB3KSWCLuOCto7kKwBy44Ir
X-Gm-Message-State: AOJu0YxTrb8UAwajvGAn8vaZMkFJYHKr7FJcp+pOEH4qa5i9IeLFX+7C
	KMoGMLO0c+NkkFnBeYf4vanQeZLB+l8fU4wEnRDMYavyxFLdCPAnGvdcEze38Xrubze8977oCij
	abBaTdvU7kmD8vvx3gZvPNyPM2lM=
X-Google-Smtp-Source: AGHT+IEf1j7xt3BYwx0h8b2w5dzVdvIqB5enG7GLe0qUmGWP7xbI5/ZfxjzaLp7HJMATYVWtVNCe6C859pT+NXSs/6E=
X-Received: by 2002:adf:e2cf:0:b0:362:dbc2:9486 with SMTP id
 ffacd0b85a97d-36775728c18mr5152575f8f.68.1719930566909; Tue, 02 Jul 2024
 07:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a8c856061ae85e20@google.com> <82cf2f25-fd3b-40a2-8d2b-a6385a585601@I-love.SAKURA.ne.jp>
 <daad75ac-9fd5-439a-b04b-235152bea222@I-love.SAKURA.ne.jp>
 <CA+fCnZdg=o3bA-kBM4UKEftiGfBffWXbqSapje8w25aKUk_4Nw@mail.gmail.com> <ec7411af-01ac-4ebd-99ad-98019ff355bf@I-love.SAKURA.ne.jp>
In-Reply-To: <ec7411af-01ac-4ebd-99ad-98019ff355bf@I-love.SAKURA.ne.jp>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 2 Jul 2024 16:29:15 +0200
Message-ID: <CA+fCnZfxCWZYX-7vJzMcwN4vKguuskk5rGYA2Ntotw=owOZ6Sg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs (2)
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 8:11=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Well, KASAN says "out-of-bounds". But the reported address
>
>   BUG: KASAN: stack-out-of-bounds in __show_regs+0x172/0x610
>   Read of size 8 at addr ffffc90003c4f798 by task kworker/u8:5/234
>
> is within the kernel stack memory mapping
>
>   The buggy address belongs to the virtual mapping at
>    [ffffc90003c48000, ffffc90003c51000) created by:
>    copy_process+0x5d1/0x3d7
>
> . Why is this "out-of-bounds" ? What boundary did KASAN compare with?
> Is this just a race of KASAN detecting a problem and KASAN reporting
> that problem? (But as I explained above, it is unlikely that the thread
> to be reported can die while processing report_rtnl_holders()...)

KASAN creates the bug title based on the memory state byte, it doesn't
compare any boundaries. So if the memory state got
corrupted/out-of-sync, the title can end up arbitrary. In this case,
the bad access likely touched a redzone between stack variables, so
KASAN reported out-of-bounds.

Since syzbot managed to find a reproducer for this bug, you can ask it
to run the reproducer with additional testing patches to check various
hypotheses [1]. Perhaps, you can write a magic value into task_struct
(or into pt_regs of the task?) in get_rtnl_holder() before saving the
task_struct reference, and then check that marker value in
report_rtnl_holders() before doing sched_show_task(). Depending of
whether the check succeeds, this will give additional information.

One other thing that comes to mind with regards to your patch: if the
task is still executing, the location of things on its stack might
change due to CONFIG_RANDOMIZE_KSTACK_OFFSET while you're printing the
task info. However, if the task is sleeping on a lock, this shouldn't
happen... But maybe a task can wake up during sched_show_task() and
start handling a new syscall? Just some guesses.

[1] https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-=
patches

