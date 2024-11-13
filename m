Return-Path: <linux-kernel+bounces-407311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD039C6BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F225EB2593C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9781F80C5;
	Wed, 13 Nov 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKceI0rb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847921F80B2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490900; cv=none; b=iEGR9hY6NsMnjypzDnH/kIwBdzXHeN43FU1Vh0Yu/bo9XWnaMaDuYU/XFWP+0QqZFr9TucMtZe6lylAFQTuZi0SjwYXNnnkFtAYedM8FQSV5s1n8mEFN9J7qZhnRhLribKfZSFgKiSM2wwuYpeG55zMa5inQwujMT4NmKj1nV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490900; c=relaxed/simple;
	bh=mWORNrvMu+2nkHTeDt9zqX1bQavHll1/ZqxiMzfxAEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avNSBHP9bo1VF3eHWhB1JRKy6n1uq2rp4Uq30fnMHG0uW59jTvhWJKl8W/uJAbk2w0jFHTTa4XkbbTWkU8r9QxHP4CfCz7WtMtXRO2gUU1c8jt4eG5MpQSvC8+aUybJQ0VvBS0GPb+73wpoUjcyTjT4wGzfYKekeicASgW0RfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKceI0rb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731490897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YL5g8uaJLXVNVsk28lhyUE5R+bbRfdqWI4k5okbTmts=;
	b=MKceI0rb9UWL8yEWS3ezHgRV0HBAQTVfMaSmIv4vXYBK+yiOk7BTZrtRXHrvMYhacFFYWG
	iAOtRfcPoc2W9QLk59+DnUPpQdmSNtpEh3zTcs/kRp0PEzMAvHDcvoCLEvjTQ7ova5z8no
	6k2oi08FAfuZGDxpEtAHkn+ij9OFAtQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-utjiYG_HO2GQLgJGHuoBhg-1; Wed, 13 Nov 2024 04:41:35 -0500
X-MC-Unique: utjiYG_HO2GQLgJGHuoBhg-1
X-Mimecast-MFC-AGG-ID: utjiYG_HO2GQLgJGHuoBhg
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8564f707b27so2120311241.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731490895; x=1732095695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YL5g8uaJLXVNVsk28lhyUE5R+bbRfdqWI4k5okbTmts=;
        b=ZiHNcI5ebVynIgwommPkPljSCOIKZ3cRyPiBxypCwMZ+g2lk7HrfgakroIK1n65NfM
         c73BCwwrV5KTvoX8PoFEnNU5hWoBk3kS6UWBbaUU2aH7sgOUcukNDySM70CKTNKiyD0+
         OP8uoGUUdzhZCg0u9DowRyDBuI301eCXFQv8bQkKChUdeVEc+gIOzDWgcjl1p6y/YlLl
         sByJqtyb8ju6swbyOLV0qyqwfttwT2o+se7TRTegZGRYCyqbnysP5+vK0Cz/c+daWihs
         ou4ck8rvWOue4Kuk3WddptRhUldkI2pyi0KdV4VciuBl+G6p5R+jp4AwwIDiBLINL1Or
         cpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9A77lZ6ytXjbWNqaqo6PustxXCOKsV7DxssE/xtmZkELMoXRclUvjPJOvNTFFBHpQIPyiD9nUxOOw6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0kphj/WESIUR2HTcOt5qoLdDy6kU7E9FboDDJb0mxFiuxXtl
	VBT9qc3IfZpctd7bOnNpIbNaU+SoNH6vzF62Pmc/5xPFkqRS4gcvUqwH1QKLo6I6yqXhoHKTNNm
	K4DOi+XCiMcAvbj+wntTlLgGZZlaOnapNfkCo/WJNMN0VAkmYE6eal7npbhjrmCESNcjzZTNAEc
	6AEE7QoOp/t8cq42IVl5BAzgNccCUK4ngI1QA6
X-Received: by 2002:a05:6102:4a9:b0:4ad:4895:ce1f with SMTP id ada2fe7eead31-4ad4895d3f0mr1376604137.17.1731490895270;
        Wed, 13 Nov 2024 01:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmtPg8F+hYG3+YJL00GFGvfj0vnU1ejxbK+vnoIcAzfsluoAugZllq4BSeDyoNJ5JixsLlnN2VAhxGwOo/DzM=
X-Received: by 2002:a05:6102:4a9:b0:4ad:4895:ce1f with SMTP id
 ada2fe7eead31-4ad4895d3f0mr1376591137.17.1731490894919; Wed, 13 Nov 2024
 01:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67336557.050a0220.a0661.041e.GAE@google.com>
In-Reply-To: <67336557.050a0220.a0661.041e.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 13 Nov 2024 17:41:24 +0800
Message-ID: <CAFj5m9+GAv4JPX=ABgwUo7RSSZ4zNsBKpiJOfuxmmwg+GDP3wA@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
To: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 10:30=E2=80=AFPM syzbot
<syzbot+867b0179d31db9955876@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16b520c058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D75175323f2078=
363
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D867b0179d31db99=
55876
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11b520c0580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/dis=
k-929beafb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinu=
x-929beafb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/b=
zImage-929beafb.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7589a4f702=
0b/mount_2.gz

...

> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git
next-20241111


