Return-Path: <linux-kernel+bounces-335966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EFF97ED42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1081C2139E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4F19CC3F;
	Mon, 23 Sep 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2SzMWsMf"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E619C56B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102265; cv=none; b=pB3yAGW4TzY+q84oU5mTqmJ5JV9/SohJJYn0E3MLZIl06kFnPd05u5Cf6tUaKQt6tDCLkOcgrTRCUFCkalOzarrg5wS2ijZMmAUvQoxrapqzPnDUJ/lUKqnTCuKaBaaSjjT/9iYDSudWQ3DHR3qOx3ALz8aAAR/sDWeH2npTT4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102265; c=relaxed/simple;
	bh=5q4bkQZz0QbFeCOrZjNmq4/pkxAmVL8jtqt9aIsJQnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M966ChvUzNmWNmROxXcod+d5XqMwXnvdvdmqfcsbVAqPIdntJSfon53xjAiDXoNVogRYX8m93hYBNbps+wMXlqV+yHwNkZ+7UnWDgaW/N9/usxks1vdFubJY9v+AhcO8WQZwy+oJe5EMtZBIr63HpOhgeWSvOfJhA16hpEVSoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2SzMWsMf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so2985490a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727102263; x=1727707063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q4bkQZz0QbFeCOrZjNmq4/pkxAmVL8jtqt9aIsJQnE=;
        b=2SzMWsMfN5D7Y/np4xeJu38ASmOaKhZ1hOInPpxU5Yg5N//QKIxFgYwQ0j/j8jYFa4
         5kVhlA/wVCxe2nGyz8jciBlf5B9wuqA/n4ISbFp4Q0vGY2FwH0PXCjg45FfREwdQctdl
         aXggO60R3/5RJfKN9c5RD32S1elV2pqlHunr4n5/bcmsb8yiXHzRXJL3c6S0o6IgQnLK
         Y3+SIYMZGqZwpWs7LsKd2Eq2aqSdg1ywjzPctJ3eZghiwbzXbCgsWB4BRyV1ixyCzjKt
         m6mEw58HyPu2ADWOieWSnF96SchOnKEYcNwZL8oIsyOYCTaeUlgcWDqTULOOEJfun+SX
         Murg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727102263; x=1727707063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q4bkQZz0QbFeCOrZjNmq4/pkxAmVL8jtqt9aIsJQnE=;
        b=mPVcL1PijuVNp+SPFdx8cjO8E8QmmGqhaafdLyO7DaPyk8Mljo4FNVEPsnqlLBNkoY
         910GzYUEUvmlgQQwvXOiiPHrFCL7cjNIHw4sJVeFo7IYLdQU4+2G8YlPQamCbXoTmjVg
         NV8cZdi9leeQuyw62rft1902BqdTHgyRXtoGSlz/4o3gmpCej+DTMkLu+RSWS00vRVem
         v9+1PxW+kyACJVUKQHZXPinf3pfAZOZM/v8MmeERw6tPlR/FHzbmAJbp02QeWHV1Ze5K
         FbgYAaOLkP7Gg96eFABxWFbX1w2quiOaYU9szz2BF2+xbieUcTdNcqQ3rJUmKprTNkZd
         Gwkw==
X-Forwarded-Encrypted: i=1; AJvYcCWQfCT2PDSWawaSxqV7uguuqnkn98trpIR4lgNPCwOmNdgnr0QddE4w/hGQPi+Ys0ik5d1ZxEDxwnbb9aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytwYisKczS366h67eGLUFAv369Wgta5R8EIpvINRuA68hwLmko
	eYr0T2+2WtQasZT2NpGGq9PxsHwQBXi/zI6Ug5jJ4+KIluJvq/cjMxTI+Hq0qY1gAHSJEuCxqUj
	h20nsLvvYsT1g/huSxxkcx7P9scs/tTqqXjb9
X-Google-Smtp-Source: AGHT+IGWwQZQsy5Guu3o98POq+AGr1eJj9tMkp9fHC9z6xm75qjki3shHEORiT/wrhcmlxMuWLEkk/zNRep8v4JHyiE=
X-Received: by 2002:a05:6a20:c996:b0:1c0:e9dd:1197 with SMTP id
 adf61e73a8af0-1d30a948939mr12714448637.22.1727102263138; Mon, 23 Sep 2024
 07:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
 <20240921105609.1025-1-hdanton@sina.com> <CABBYNZLqXfAc7_YO+goAf7fnAsmJ+j9V0cjmPMX4+MhoDhzOCA@mail.gmail.com>
In-Reply-To: <CABBYNZLqXfAc7_YO+goAf7fnAsmJ+j9V0cjmPMX4+MhoDhzOCA@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 23 Sep 2024 16:37:28 +0200
Message-ID: <CANp29Y7bbvUckx7c+Bke28p5AzNCw7kYfXr87DsAD2DtUm99Xw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>, 
	syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:33=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hillf,
>
> On Sat, Sep 21, 2024 at 6:56=E2=80=AFAM Hillf Danton <hdanton@sina.com> w=
rote:
> >
> > On Tue, Sep 10, 2024 at 4:56=E2=80=AFPM Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:
> > >
> > > Maybe something like the following would be a better approach:
> > >
> > > https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e
> >
> > If your idea is not bad, boy, feel free to win Tested-by from syzbot wi=
th it.
>
> Is there a way to quickly check a patch with syzbot?

You can send a `#syz test` command in a reply to syzbot and attach the
patch-to-test to the email message.

See https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-=
patches

--=20
Aleksandr

>
> --
> Luiz Augusto von Dentz
>

