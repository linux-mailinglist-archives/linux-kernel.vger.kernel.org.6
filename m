Return-Path: <linux-kernel+bounces-301654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA095F3A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2807BB21BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077B8189B9B;
	Mon, 26 Aug 2024 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPBan3rk"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87317D35B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681794; cv=none; b=qs0qc2P13h+/3sefNPj0Ngg2qG4m5FmWs6oznyo4BKrPEfuCH1Lx+vYwoDOdshmwbO1SYRs5Rg0c/mhVaAL6fHa0yp7pCpntI3BRWID8LSeVBt7NfDBcA6QmR71pPVZ6gcBnavsGrrI1TejD/yEfpKTEvouI0zljYcmwmibBBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681794; c=relaxed/simple;
	bh=v1Xe3susNIUP6eTSfkqJrSP1V8+XilN7nn1ic9qhbf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFWYUkqHHq0aRtDcJ1c0hNBd10frPKlP12V8bCCPjZ+MV6DvQWMtS7toZTPFvGlP4NmlGobWCG4+VfFNYo4P3nGlDAAl/YntSOPmQ7oxBXJ+FdCidh82d3IXtyJ18mVpA2fTlSHvmRQ5sXnJ6dar8ByZfFoNlzOVq7UWmSZrbRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPBan3rk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a81bd549eso319822066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724681791; x=1725286591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1Xe3susNIUP6eTSfkqJrSP1V8+XilN7nn1ic9qhbf4=;
        b=iPBan3rkVGcAedYb88rylUcF+hhpvwTiuzpsDb7YFHmWeCGHeaaVfwaZr0O3gUt2fX
         R+GkWSOCEVfbx+N0qeB2ndD+6P3ToZHhRWj0hl+eXbSV3n3G3QncaoNbSZinvawtYk8K
         QGZ0pm/ak3h7ECxtRwKFiRYuWJzDE3ZF/CxVXXlqyDokTr+/v1RV0X/fYhsTPVpy2rx5
         ufQ6UhdWs1460U5ujMTjJaKLJLJoYNyAT8SUUQBhSbwJd1RoqZzssCL1Rb91yCP7oZkf
         GUpemHMqK297ZovYTme4g5wTtEGXXPqieh1AkZNoPMrZI44WGQu0JXJliS1l9aw62eMN
         8Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681791; x=1725286591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1Xe3susNIUP6eTSfkqJrSP1V8+XilN7nn1ic9qhbf4=;
        b=hr+MnoNmEajzRGyjV04rc41kMeex+BCl1Pf2cjJKJ9iCDBrNW/2xBQG2jCR+lw8TPT
         eqqPeNvsjXwe4ChL/1l2f/0m0r+TjD16rZBO7Z+B1RRwPXEjywa/zbdMT0i+VD9u+9sJ
         AJfcmIHlo3bQkzwZI7ifCAG3DFLYklScm2LamwmjXzjj29FAJ5ECFw2r8zmWvfXkkX7t
         pYFDsUmM/HOPTf/VrnB5AL5aln5Njbndmb7si3I5fNni3FuYxSrpJABJGrxl/7PMalsN
         isTornH0lO2o4ecqQfZ9CuhC7XnHUXXE8lEX7bmC79ywCvGibhuaCQ/1l+izSEGBVprX
         xz7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/Klie2RM/PpG8MbsZupKpU2pjWWAfRSaQDtLUIbEdjtxTsImJhp99Rqcq51gRCoaS2nESJr5Gv4bZqtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEgHzFw0HzDZAMUWAiq8brT3KmPUvluimEMdOFg/dnzftT4l5
	5lALF1m8l3kgsz8JtRrpG+x4E8Sx9CZKkLt+ivToy5m3m2W3p9TCFmG0CFa+ggjA4EI15r0RCqO
	MAF1g8DJvuKBbTa09HQgThl20Oe3ecv8BspsC
X-Google-Smtp-Source: AGHT+IHc1AVF/HZHw0p/eGvidrZmazV7XPNxl3Yz5fKQoiTUfqWqxNNdSA3m8Ngw+wN2jEEGvwjeklKa00kNbFG6d8w=
X-Received: by 2002:a17:907:8688:b0:a86:7af3:8299 with SMTP id
 a640c23a62f3a-a86a519896amr687802866b.25.1724681790338; Mon, 26 Aug 2024
 07:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHOo4gJRxYjEmQmCv7HRq4yB-AX_0f=ojLmU8PWrmjEhkO+srg@mail.gmail.com>
In-Reply-To: <CAHOo4gJRxYjEmQmCv7HRq4yB-AX_0f=ojLmU8PWrmjEhkO+srg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 16:16:19 +0200
Message-ID: <CANn89iK6rq0XWO5-R5CzA5YAv2ygaTA==EVh+O74VHGDBNqUoA@mail.gmail.com>
Subject: Re: INFO: task hung in unregister_nexthop_notifier
To: Hui Guo <guohui.study@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 4:13=E2=80=AFPM Hui Guo <guohui.study@gmail.com> wr=
ote:
>
> Hi Kernel Maintainers,
> Our tool found the following kernel bug INFO: task hung in
> unregister_nexthop_notifier on:
> HEAD Commit: 6e4436539ae182dc86d57d13849862bcafaa4709 Merge tag
> 'hid-for-linus-2024081901' of
> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
> console output:
> https://github.com/androidAppGuard/KernelBugs/blob/main/6e4436539ae182dc8=
6d57d13849862bcafaa4709/6548016d46a859fa33565086216fc61c6696a59e/log0
> kernel config: https://github.com/androidAppGuard/KernelBugs/blob/main/6b=
0f8db921abf0520081d779876d3a41069dab95/.config
> repro log: https://github.com/androidAppGuard/KernelBugs/blob/main/6e4436=
539ae182dc86d57d13849862bcafaa4709/6548016d46a859fa33565086216fc61c6696a59e=
/repro0
> syz repro: no
> C reproducer: no
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Please let me know if there is anything I can help.
>
> Best,
> HuiGuo

I would ask you to stop sending these reports, we already have syzbot
with a more complete infrastructure.

