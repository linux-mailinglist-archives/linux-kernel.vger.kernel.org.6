Return-Path: <linux-kernel+bounces-335832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6935097EB4C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE621C215D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5331990C0;
	Mon, 23 Sep 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bh0jCesr"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521DC195980
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093218; cv=none; b=SxPsA/f+wn1j/vqDQ2yYoWWnouLBxy6BUZH6ceDyiIqvku+qAIhjtOoX6QHove9XR1+FNPqCjp1FjVZx2V0y1ui6a/urdU3tLDPYMJ2Mx1mz4NE85S44VKnytckLylLKCwbAiuhcWYsJDHEN5UAGo6H4REmxvh/OUHoImG5bl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093218; c=relaxed/simple;
	bh=YAeR5fKqzAdmxG3IkrJdoKLvdw41gP6A2RdB9ykniPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8Hu65J+gRrCU/XutPz/OmxUT6KaJ0DpvzAjKNlr6yBsYwitLWlAtx5LdPWHNh5QgusDmafCgxCacmdT2JJUPekDawpStdyATnVwjmK5xsye7T9s7BkXZUPd4y+jHVJXjuYV3zG7ND9tD6j5IUuhsilMM6RdbXk08C42fhU5NUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bh0jCesr; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6d9f65f9e3eso34646657b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727093216; x=1727698016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4G8loeRDo9TRtRd7SA9YbFOUALYJsKGcKbHOv+tLWOo=;
        b=bh0jCesrjGnmKbE+vGYKwrUH20/bYp08lVuccTYGmHwl/Yj7DJeDosYOE7RwYX9bmV
         FAK5jtlldwVkdkSk70pmDcEKOp6YcE7phCGipq56o12Yvl9B4FgCt4BD61E+eucizuuo
         JcIXTZrNeoYmD6Q/CqM+O7gbfKidZYiIXyptT2siklyYWYRI7rIYNecyAnoXTN67feeK
         Y4X99tx4rZPyS4xz4hw3k0MzTVdBVxdqv31Brbo7BTEjsqrqhk3hj6G5YpaytTHaWMYI
         h9VLDS3HrCGR95Fq1vd3YYmt8Oxty/uEMl3NoZ/fYxqxiNubLoLSwD2EZp+NeAD7JJme
         CGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093216; x=1727698016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4G8loeRDo9TRtRd7SA9YbFOUALYJsKGcKbHOv+tLWOo=;
        b=wVnpk3q3BGLitPm4vgU0Q/sn/VwsSt64DiWX2Iw73A5OefcrMeXzQKTPonlm14GQYZ
         H6k9jEuM+ZU7gosPaX34fUH/CjkSLUcMFQ/7Q5Nipug6a2/Ol75jYWFHXwHZg1oedTiO
         Y5HODTvSHjtfr617lY8mKQGs8hz5mUFRjkWnNRwgbRwNSyCY9IIi0iH2nds48usBbar4
         cozaOScTjoJgBo4zOT8WKhQW3hH/B+IV6/6UyGYcqxiSvKvWY19xZ2RdvlPBuhUkcWmS
         x5RJck90+tklWHisZXzaJyQoc7IqiXOrhL8neTfIsg9OTKlW9bTzb7zU/Vlzuw/pqCiu
         HDeQ==
X-Gm-Message-State: AOJu0Yy8UTrX2aQljbFqUzUyZPuaHe0Jo3UsVBwgkPu0vZLsIn5rOVtV
	JFA1JFuj77Xw4v9IEZczCx8Fflt74gOgZQk1wzyYktDBhiqaF6kpOSwi09vosHfVJJ+3nlWyklz
	oMRIhz7DhGfddhJxSremMM4bGkC1JINhlRBH/
X-Google-Smtp-Source: AGHT+IEhDOTW5odGViE/hK9dwOoNFhXic92bf2OcMI2xHFgaFM3rGhXP9aORLEGJDnSmpB7LGGsXSPjFqSsycfj5UHc=
X-Received: by 2002:a05:690c:1d:b0:6be:92c7:a27e with SMTP id
 00721157ae682-6dfeeec5870mr79018447b3.28.1727093216319; Mon, 23 Sep 2024
 05:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
In-Reply-To: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 08:06:45 -0400
Message-ID: <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
Subject: Re: [syzbot] Monthly lsm report (Sep 2024)
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, 
	syzbot <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 5:02=E2=80=AFAM syzbot
<syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com> wrote:
>
> Hello lsm maintainers/developers,
>
> This is a 31-day syzbot report for the lsm subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/lsm
>
> During the period, 0 new issues were detected and 0 were fixed.
> In total, 4 issues are still open and 27 have been fixed so far.
>
> Some of the still happening issues:
>
> Ref Crashes Repro Title
> <1> 306     No    INFO: task hung in process_measurement (2)
>                   https://syzkaller.appspot.com/bug?extid=3D1de5a37cb85a2=
d536330

Mimi, Roberto,

Any chance this is this related in any way to this report:

https://lore.kernel.org/linux-security-module/CALAgD-4hkHVcCq2ycdwnA2hYDBMq=
ijLUOfZgvf1WfFpU-8+42w@mail.gmail.com/

Looking at the syzkaller dashboard for this issue, it looks like it
may have been present for some time, just difficult to reproduce
reliably (although it does appear to be occurring more often
recently).  Any ideas about a root cause?

> <2> 9       No    general protection fault in smack_inode_permission
>                   https://syzkaller.appspot.com/bug?extid=3D4ac565a7081cc=
43bb185

Casey?

> <3> 3       Yes   WARNING in current_check_refer_path
>                   https://syzkaller.appspot.com/bug?extid=3D34b68f8503914=
52207df

Based on the discussion over the summer I believe the consensus was
that this is a bcachefs/VFS bug, reassigning to bcachefs (or trying to
anyway).

https://lore.kernel.org/all/000000000000a65b35061cffca61@google.com/

--=20
paul-moore.com

