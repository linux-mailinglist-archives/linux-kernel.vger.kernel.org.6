Return-Path: <linux-kernel+bounces-348477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFB798E825
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2658B1F24DD8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB41814F90;
	Thu,  3 Oct 2024 01:32:34 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908611185
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727919154; cv=none; b=UPn/Yd4F3DgJJk+8gcUaa4/j/DJfIEW8wAvSDc6Zk13MyCl+xUmNuGWgRoVkD1580tvUVeXC1u8qe3R04f+xxN/8dlnTgDJZPeJjzXXw1xXXoSUfsfO+4kQ0vhaAilmchEJcOuPjZ4GVCfsL4TdUf4DhifSHL+78Xy5R5AOxn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727919154; c=relaxed/simple;
	bh=bdfopPzbUgE+uGbefqmgycl4+ZsHX/bBI7R/rF/M5f4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=MqNbOmBfIPyH+29fWgKTI1J5hc3Be8FHqgiSFIYHSAq5MDmZ9IwotifBxvKi5Fok/lb0Wv57ssCizURSgCdeJZgXO6NegMecCeCoSKEC7TDefiGPa5YLUHtpmOCeECHoZDMZAb6PlFD4p/dLABZHYqiwV1EDQwpoUBOB+S4UNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a342620f50so3966215ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 18:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727919151; x=1728523951;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdfopPzbUgE+uGbefqmgycl4+ZsHX/bBI7R/rF/M5f4=;
        b=QHrZtWHbmAJ3kdSLufjSbFAaSXx1EB0wwuUobhWj4ihKSCRlbH6F8f/0dpoukUTEVY
         OC8RYd/3Y6ATD0eT/6gnSZJA9K8iD7/lQRysGK8HGDFP/dWLoKVczMCLUx2wzdTnk4GW
         b/S5AlPBuWbs86RSbuRfuqmsooXBxF0zzU1lc7UNnR+jhP6h1zcnjf2FK7cOQzjX+jcp
         c/RJ3xZp+0Y5GdiRAwqjv9uGj4f2+VdqOP4ujBSW1qO2Axwzdf/NBPebSpK9iXoalP0R
         VWUhSEPbHj7EacFr5wH6F5IJTyJymcuLHCK2FaexFcrQGae1Za5zaJH4rDtqMU6xVKmA
         7uHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwfvH0T4EvaTNOl0wnkH5SZ1iu3odavLcMCwsbuPMnQe2DFntxCvbILTyo8L7lZe4VZcntyYvqJNDL194=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtma8WHsPysPTn3Go+Giu9heDEVcKrKa2RD1B/H0iFFonBWnac
	voBkBrB52M8MBes6EO3NP1dDAXPxrhjXr/zR7H8mwOmku3xhs80pDGz4nVz7IfVP8p9Sk+2FxWr
	51Mj5o/C27tf7PtoouNdBklgN1OusYVP6TOXS5a8VPNq810bvvPY0ghE=
X-Google-Smtp-Source: AGHT+IEby/e4ph1vd9CJUNg1je9svkeaOPIrgnREOgawiRfLJ96dpmChz/DZOr5uepAjH/mK1/Sh6NlagTM4lA2MceUdpSgkHhcv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:3a0:a3f0:ff57 with SMTP id
 e9e14a558f8ab-3a36592acc9mr54903865ab.15.1727919150973; Wed, 02 Oct 2024
 18:32:30 -0700 (PDT)
Date: Wed, 02 Oct 2024 18:32:30 -0700
In-Reply-To: <CAHC9VhSa-2Q5SPXJHfvyHCYXQEFPDQaYcRf82FVB2CH-PHxnFA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fdf42e.050a0220.28a3b.01f3.GAE@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in upgrade_mmap_lock_carefully
From: syzbot <syzbot+a6456f6334aa19425886@syzkaller.appspotmail.com>
To: paul@paul-moore.com
Cc: akpm@linux-foundation.org, ebpqwerty472123@gmail.com, hughd@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Wed, Oct 2, 2024 at 8:14=E2=80=AFAM Shu Han <ebpqwerty472123@gmail.com=
> wrote:
>>
>> It seems to be the same as [1].
>> New LSM hook position for remap_file_pages + IMA =3D deadlock.
>> The new LSM hook position is added for a bypass caused by
>> no check in remap_file_pages + READ_IMPLIES_EXEC in do_mmap.
>
> Thanks Shu Han, let's mark this as a dup and sort out a fix in the first =
report.
>
> #syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in

can't find the dup bug

> process_measurement (4)
>
>> I suggest fix it by removing the check and moving READ_IMPLIES_EXEC
>> out of do_mmap[2].
>>
>> Link: https://lore.kernel.org/lkml/20240928065620.7abadb2d8552f03d785c77=
c9@linux-foundation.org/
>> [1]
>> Link: https://lore.kernel.org/all/20240928180044.50-1-ebpqwerty472123@gm=
ail.com/
>> [2]
>
> --=20
> paul-moore.com

