Return-Path: <linux-kernel+bounces-348519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB6098E88C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE092879DF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31D17C9B;
	Thu,  3 Oct 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eh46K7xs"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB01FB4
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727923967; cv=none; b=MQ3fWixpII970i1ETADRcNoj5O9kHmYEXuvQNeE2RDRRn3yIOu4XXAdOjt7LsdGr7OlBObjoIF6vT2sqMWL+0YwnHp4MNMar1H4VNEezJe2t2sFqtcDLss1oTbh3f3HJiakuYSqdE67DXHHL/iJQT1/K4f45z15DF5JaTAzsBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727923967; c=relaxed/simple;
	bh=PLejGEruWkUfN7OLsrhAR/EJMSlI0sTag2Pl1SeDMsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnfaIjwKjAiUEoPY66f5wBpfY+oti90XBVMhrg9WYLK3ylbh3uAja9kw6pQcrJigm1EAtlS3k4HlyUw4VebpVgjKZlDhzBTXDjbUgqPJSxit3PstBJWfuwtvHfMQ9/1X6chvd5GKwcdRLDqkJ8WsOwHiQRgeqhWJj15CoyJuank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eh46K7xs; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25d6342837so398237276.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727923965; x=1728528765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLejGEruWkUfN7OLsrhAR/EJMSlI0sTag2Pl1SeDMsE=;
        b=eh46K7xs8VufipZXKQJ6sZ05LvCV7Z8uF0UYAr25KEC53Jj6jNRg4vPVpbCA4lQj82
         zdzs/ohaUGlZoop2t+2v5MsSYS2wuDwn4io1YGKGGJd9+RWX6AoFPXoWkk1yJ/0W/F2j
         blOSbjTJtZJcW3MFcRwXTRAIsGSGb0h8qafwcBbTbGzPZjshhjknB2AG8sPgG5taW2y7
         yr4zgktZNa1j51B3r4kbPNPqEnstb3uTlasqLR7Gy++Q7WuHu+U8Fv5wZkoAiEUs7eYE
         7xKzxG9N/hw3WSgYMjz39wrsiuyCEop3klssrECHmrx5tTCbkCOiB6fhEHwL1gh+bKYC
         VR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727923965; x=1728528765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLejGEruWkUfN7OLsrhAR/EJMSlI0sTag2Pl1SeDMsE=;
        b=SGVf6ZAmeVFSg+xZLzhbF87zlF3yibPKt8dYbj0nlYaZFJTA55fnNEqVHvpPGq46Ff
         ZGng4h3xYWzLJIFkngkMboVq7vESHXdhlo2KUz4haXEpIFMCHo+LHL34hn6yFuP6giM/
         fSPuDz8z0bubCx3KuTewfdFM+cZGZa1k5bPvRZRcpYPYdOdhhe3Iy1RpeSulVpUu9DOH
         YDyfbSjRjHm6Q+RdFPr3b8BseroTOz+mTdMOCKM5w9zl4KUfJL7RVmoRw5gugpM28LBH
         6Dl5NtbBu57dUCDCaYktnZR0sNGIUGnxYMU5CfY+TL8nSRhMeQn2ObmU77fgEDVs0rcz
         6Plw==
X-Forwarded-Encrypted: i=1; AJvYcCVIXprLFRtoi4sJzz+P454AruE2SpqWpw6jiG6v8Fq9NXaFfPj+BJO/iO2Pj5lOKSU0OJ4CQl88h3q112k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9rUnhWWlJcNCo05d6klNH2QnmG2It1T0SWUM21yBf2oRbBFWR
	9weieFfi3mvGZTkaRnz3S+05UXDLmaQ4uABrc3SsOql4F6a2dpXuqNIqERu2Q/WsmMKscoDBoGy
	GTub6xZZRrmuNSZ0XA2O/1LbS45NKOTlxbpIN
X-Google-Smtp-Source: AGHT+IEbVY1kbBy7Zvdg6LTdE8R8kX8+B6u0Br4EdVIQKNUv+ElQOZkculpkmZ6/3yWZbwNAEb/Oy3sfRqUQg6acQo0=
X-Received: by 2002:a05:6902:2012:b0:e25:e3a6:fcbe with SMTP id
 3f1490d57ef6-e263840f491mr4534934276.43.1727923964741; Wed, 02 Oct 2024
 19:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSa-2Q5SPXJHfvyHCYXQEFPDQaYcRf82FVB2CH-PHxnFA@mail.gmail.com>
 <66fdf42e.050a0220.28a3b.01f3.GAE@google.com>
In-Reply-To: <66fdf42e.050a0220.28a3b.01f3.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 22:52:34 -0400
Message-ID: <CAHC9VhQA3HxM9M0mf=-pWLcN9hVJXYuBstDV6xkU2FB1oAs3LQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] possible deadlock in upgrade_mmap_lock_carefully
To: syzbot <syzbot+a6456f6334aa19425886@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, ebpqwerty472123@gmail.com, hughd@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 9:32=E2=80=AFPM syzbot
<syzbot+a6456f6334aa19425886@syzkaller.appspotmail.com> wrote:
> > On Wed, Oct 2, 2024 at 8:14=E2=80=AFAM Shu Han <ebpqwerty472123@gmail.c=
om> wrote:
> >>
> >> It seems to be the same as [1].
> >> New LSM hook position for remap_file_pages + IMA =3D deadlock.
> >> The new LSM hook position is added for a bypass caused by
> >> no check in remap_file_pages + READ_IMPLIES_EXEC in do_mmap.
> >
> > Thanks Shu Han, let's mark this as a dup and sort out a fix in the firs=
t report.
> >
> > #syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in
>
> can't find the dup bug
>
> > process_measurement (4)

Stupid line wrapping, let's try again ...

#syz dup: possible deadlock in process_measurement (4)

> >> I suggest fix it by removing the check and moving READ_IMPLIES_EXEC
> >> out of do_mmap[2].
> >>
> >> Link: https://lore.kernel.org/lkml/20240928065620.7abadb2d8552f03d785c=
77c9@linux-foundation.org/
> >> [1]
> >> Link: https://lore.kernel.org/all/20240928180044.50-1-ebpqwerty472123@=
gmail.com/
> >> [2]

--=20
paul-moore.com

