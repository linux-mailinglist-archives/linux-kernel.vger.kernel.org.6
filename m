Return-Path: <linux-kernel+bounces-377247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D939ABBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C11C23285
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF2A84E1C;
	Wed, 23 Oct 2024 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwN5AnJJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469F75809
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729652168; cv=none; b=ASAuNct9D5B7HgVsv+UhH+ujD83giOuaF0zV6rF4G1a2ZCx2Xb4SMLCHURM5XWcmO5Vo0KC9pQ37hEoneiB1b+TYoBLSbeu28VcEQB1F+Lgw0rqgppZxQ69rCEvbG5nhVgSLib6wwaa3TDytYuq6VrgZfJQOGMyqhObiNUXpe54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729652168; c=relaxed/simple;
	bh=dF73x0M3UHjm8Rjn3N77JiStFAPmQHilNsJYjLN1iFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqAkAGLhgN5Vy+nd1uKPORaZp/d7rvC4xU+04Qtp7mx7wg+M6fQvmh3hi0nJBFAQsBfqghcANo1e23/Y39gfQId2bwdSQJHfKMyJBvJ25jeVWw43byceBGzOAIjGftavBeEWd8vamgd7igqc8vhCKr4y6BEUE4tuVK3m1yV9Bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwN5AnJJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729652164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHdknUCOThS1TrsG2FtImyl6O5CF9UtIeOhoBXg+sdg=;
	b=YwN5AnJJzh3KrTDJSpFB+h/aR9sRp9sFEMRHKUsaXuf1M6d1Mfka+vvsXRiNQNlxlkEs7I
	ic8ikWZ1giQDVBTnKJonPQgq/3rN9gzGJ3eehlwVdp5iOqr49i1lDtANYjaIstIidGwiuw
	7WjfFz5f0DS9CNeUO5jA2p+aJ5CgIw4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-T6EAIYoBM7yY0T_DDyyHOQ-1; Tue, 22 Oct 2024 22:56:01 -0400
X-MC-Unique: T6EAIYoBM7yY0T_DDyyHOQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e467c39a4so7502811b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729652160; x=1730256960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHdknUCOThS1TrsG2FtImyl6O5CF9UtIeOhoBXg+sdg=;
        b=P+Da7sg/Epv9y1Ws3U3JqM48GuMDpP+ZBL3uVpDn/URU3LQzSTalcmYV/jrzmM5GTG
         EhIuMTojyrqF3dC4T5lyU6Ddeg1sHVhBeeDgxRtP/wtcr6GUKisJmjwabrB3f9tpJ89l
         GISSojBuYfFlKS8XWlfQ2aKuTWlNbUe7f2U9qlX4Y7xh65yHrBYlFWnQwD81WaDAl0wQ
         kcNrxsGB+u8Ym5dJTj3YXl1SiYpVEvLJh1D/XrcY7ojoPP6AjuNbnfaB084ctqxLN/zb
         NjQlj8Vqrf49Jjka9cOUtXB0/JJ2SEspSr/cxVqZT1yGGWLi1e0uRjoCaEWEJLXW31q+
         rZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5cVxyBg+Gay6pj3+0iZn70fucviMa0x/V8aKUCuiZ1cD2k/a0q6vyLh7zRD7dK9YR7UOBDEkXoa2AI2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGY5nIh+HxJjygME7ZNdf9fK7CsLE9Byp4ZRme7zvmHUXngA/N
	wiuG/9FRumOi3E+rItdt8DHtdooFvvoBJ4ROO657OUg+swtNDX23krMzHnV9WskyFec1Vcg5Xtm
	J9Duo5gU2qo+UadXSVn0Q6aNsS2Y0lVamoAShj0dK1L3NiRpSUCbM31ZB64P5rfYEsB+N1LTm+I
	T09rcHFa7FCnYdz56vfah2JKxbvOBQMQ+bkHUh
X-Received: by 2002:a05:6a00:181d:b0:71e:6a57:7290 with SMTP id d2e1a72fcca58-7203087ab10mr1840289b3a.0.1729652160284;
        Tue, 22 Oct 2024 19:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErwKn9FZkff6V8dcZWG5EY8VQ1YWvgVMHUhTBOzUho24sSekvZoUxoVrEwVIcCjlMhNwi3Q9f/+sZkP1bGws8=
X-Received: by 2002:a05:6a00:181d:b0:71e:6a57:7290 with SMTP id
 d2e1a72fcca58-7203087ab10mr1840276b3a.0.1729652159867; Tue, 22 Oct 2024
 19:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ae358c06202ca726@google.com> <6717c537.050a0220.10f4f4.0146.GAE@google.com>
In-Reply-To: <6717c537.050a0220.10f4f4.0146.GAE@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Oct 2024 10:55:48 +0800
Message-ID: <CACGkMEsqhW-pHhx3+t1GKKrn0RoHioUofC-QT+7nCDNASWn-Lw@mail.gmail.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_setattr
To: syzbot <syzbot+d78497256d53041ee229@syzkaller.appspotmail.com>
Cc: eadavis@qq.com, elic@nvidia.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mst@redhat.com, ocfs2-devel@lists.linux.dev, ocfs2-devel@oss.oracle.com, 
	parav@nvidia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:31=E2=80=AFPM syzbot
<syzbot+d78497256d53041ee229@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit a3c06ae158dd6fa8336157c31d9234689d068d02
> Author: Parav Pandit <parav@nvidia.com>
> Date:   Tue Jan 5 10:32:03 2021 +0000
>
>     vdpa_sim_net: Add support for user supported devices

This commit seems to be ir-revelant as the changes are limited to
vDPA. It only shows the user vDPA mgmt devices which has nothing to do
with ocfs.

Thanks

>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17fc264058=
0000
> start commit:   d12937763990 Merge tag 'for-linus' of git://git.kernel.or=
g..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1402264058=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1002264058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D41330fd2db038=
93d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd78497256d53041=
ee229
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12d0dc87980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14e1943058000=
0
>
> Reported-by: syzbot+d78497256d53041ee229@syzkaller.appspotmail.com
> Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported device=
s")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>


