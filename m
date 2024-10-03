Return-Path: <linux-kernel+bounces-348476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9DD98E826
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967D9281E8B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA30171CD;
	Thu,  3 Oct 2024 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ADZt65f1"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B3101DE
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727919154; cv=none; b=Q3wYxoboxblQKNkKlFLFTQM9oo4GmWI4zT6WZM+m+n15h6kNx1ZkVKw6V80GPVn4VW/f2MK/rPgTtjTi5Q7QJQecBG8nb/+uTdSx8eOiJGb7zMUobKulxEaIgZQerPcZlRgGz9Qoap7i+InsXWQvGO5KeW59VfRL00gIXWJOIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727919154; c=relaxed/simple;
	bh=1UwXK1FoaoO9CGRgZEvqR8WstJfC7qHQR30H1C7tXkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLqFZ7Xxx7kGHR8R+SGb8OsQTsTf6x/u4O9k1FKjvkSaJLeF+vhhRUaS61uab3TpNcdnq9BsJonFD7FoIR0W/u50jTIfzpDqCxDOpOlulLKjKXx+G5AHC7+unZhVK77AYs/kCpXZ/YpPdM4kojuhfMhu92Rrn8djRF7B/20NqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ADZt65f1; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e21b4d7236so3643317b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727919150; x=1728523950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UwXK1FoaoO9CGRgZEvqR8WstJfC7qHQR30H1C7tXkc=;
        b=ADZt65f1hGq+tNtyGOcW9kxgTzR+Phj4M1bXyPyZA+yxv5yvW0aeuQZOmRONLhKcJY
         iqNN9lB3m2YziWn4myfdZLfb6KBc2ZGOnUldJr0dbpONSSD9aGyCZe+EXqqEdUz6V9bG
         0/2VNHF1tBJCzazDLpDOIkvyRmjD7qywIBCb17pWVa9jCEqduYBSJFUAT8Ayf6pl/KFm
         V9gGMMVu6zKzZbCxqpjPYUKEuyYZz9i3TKQrQSDDYCz6lIaeGwXH2QCIO/a8VHPIdO2i
         85jbIPrYuIT2Dk0RRC6kJ+YQWjLZJfC1/Ui82fuxwwNkrrGKecFgmIG9MOQe/BWmzXCG
         ZUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727919150; x=1728523950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UwXK1FoaoO9CGRgZEvqR8WstJfC7qHQR30H1C7tXkc=;
        b=dfau4baWvfagelnnzOaOAV81APeVId+bEtOmdh/ZprA88jZkqEiFoc3JZZm2CiCrsT
         sXXqn9wVp9Y3Vrp+wiLUNcIlg3ML+5RqhW+fVHwUL9xZM87xPVHAvpoWrJRnVPTFfXYc
         1/gYGjdg8GCNrY7D1yC0UL9Wmec5N4knQhk0bz0G+5b/eQin4GrSmmnJGHzJZgMIn5YU
         kusC2TlEKFW48re6O+iyWiMzg/uKclJEeLp5dx72H8bwKawqnMuJj4rlz3QHsqtB5wfj
         DzaHEBtfDM++sTESPsT7r090OAxlkfKELIx7do/Fv3Vf/0sHffOG/5uRUGWh6FD+NhOK
         DBeg==
X-Forwarded-Encrypted: i=1; AJvYcCVG9VnHyDjuXZ1W+jBauPGrxCrOJJM+q0V9XfgYw+bp87zcztLCEg5UqI6cXU39DF3pwko9FBxtNKqdgv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMlfyrhmLpmH4K1oHqq0zbU0bRoP+SnbSz6cUTlOby2wh0NbS
	lNHTtUeRfpMSU2pFZoJUEh76Ge8w/OTimuJhwbd/CIuS4ZyCr5jUjh1gnUh1aaEn8O7+IiFYDKM
	uYmy3sNLyJ4GvV4dJRDonA4rmPgd5zjhwrgXW
X-Google-Smtp-Source: AGHT+IETgnQD+Fykl9pMHACUWHaELEzbCGd7C2GoUuQae4g5nBX1YxBIfvZyaeMKpOabEmP4hEMEj+B8qq4LTRqQDE8=
X-Received: by 2002:a05:690c:660f:b0:6e2:12e5:35b4 with SMTP id
 00721157ae682-6e2a297bfd5mr57387637b3.0.1727919150409; Wed, 02 Oct 2024
 18:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f8846e.050a0220.aab67.000b.GAE@google.com> <66fcd082.050a0220.f28ec.04f1.GAE@google.com>
 <CAHQche_ieCFxXP-ricwnVMiwwikO8LojWomH9=5eCJEfTm8wVQ@mail.gmail.com>
In-Reply-To: <CAHQche_ieCFxXP-ricwnVMiwwikO8LojWomH9=5eCJEfTm8wVQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 21:32:19 -0400
Message-ID: <CAHC9VhSa-2Q5SPXJHfvyHCYXQEFPDQaYcRf82FVB2CH-PHxnFA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] possible deadlock in upgrade_mmap_lock_carefully
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: syzbot <syzbot+a6456f6334aa19425886@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 8:14=E2=80=AFAM Shu Han <ebpqwerty472123@gmail.com> =
wrote:
>
> It seems to be the same as [1].
> New LSM hook position for remap_file_pages + IMA =3D deadlock.
> The new LSM hook position is added for a bypass caused by
> no check in remap_file_pages + READ_IMPLIES_EXEC in do_mmap.

Thanks Shu Han, let's mark this as a dup and sort out a fix in the first re=
port.

#syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in
process_measurement (4)

> I suggest fix it by removing the check and moving READ_IMPLIES_EXEC
> out of do_mmap[2].
>
> Link: https://lore.kernel.org/lkml/20240928065620.7abadb2d8552f03d785c77c=
9@linux-foundation.org/
> [1]
> Link: https://lore.kernel.org/all/20240928180044.50-1-ebpqwerty472123@gma=
il.com/
> [2]

--=20
paul-moore.com

