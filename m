Return-Path: <linux-kernel+bounces-252954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EBC931A88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABD91F2261E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF798763E7;
	Mon, 15 Jul 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nO91fFva"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A851C687
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069655; cv=none; b=QfzQcjc6WtCiWudJUiRKO1Lj0I5IMnKTAqejv+xweA/NLDPNb6KV14towh1ZOtVKUMMgrlRS1nLGIH+JXZ8fzVlhN23baOLXyDWmFqpVhDofpz+LgWdJ9v+vYVMm03EA2QNJ2ZHZmY7PvFUE9lQp1H7QBEnqMQOeYcBR3yNtI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069655; c=relaxed/simple;
	bh=x7K9WmffnsoocnAYmMUcSmMdv//kjNrchqx15DlCGsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZ+wUEWU2wKdhOiJjrw+MF66pJlU/gaaWvEIk8yP2M1AziEUWlrGxlKMFPEQuoN5IYXM9bE0sp/0mhU7vzT69AWeqquz4QSyO3BOhhGMLHmIC2WO75d6U6uXzggwH26Vx2UBnQwnNxTNEc7ThM60cGa0Zakhp0TJSJby5JRy3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nO91fFva; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc312a36f9so34875ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721069653; x=1721674453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7K9WmffnsoocnAYmMUcSmMdv//kjNrchqx15DlCGsw=;
        b=nO91fFvakVwOoreYPYmshC6Loa6fGC3AZldqVAXec3OEobuZGVRtFOz4jzb0Zddsrk
         wbctwsjoz6TrG65YMo+0ZYeEBrfVre+rdS93HJrDmy4euNNAYFZYH+MRBmL5sJe5Y8Rp
         27mdhXdhK78VqQJxCNL7oMwVaNceFou3rrIdxV97TVjLPMkr7+XOvquBvh7/NOOay07k
         ErTzgnqgC7lxIFj9eBkqgLP8TweB5P7BFDpHS0cglUfUkJV1npF8VgqYtailgmfJiYLv
         gvdu5RMG7ToFxv6nxNKw3jHauxpLcVgXpEfFZDpNSLd/OmTNgAcqxUIxo83KvKHdb61k
         TKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721069653; x=1721674453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7K9WmffnsoocnAYmMUcSmMdv//kjNrchqx15DlCGsw=;
        b=vukBqCZx2+dIZrANKfeh4UxnNsHXs/MsAaodce9gV/XAdu2Co9Ha1yEt2AGajFXgQa
         U+kecitEFNO6nKsauhSV7UX80yGKD7mnPTH5hSEAGygJ+URFg/q+Az8/n+8PBJDgptRy
         /pRBIpKH6K3pQRC6Mk4a1lXHuUrQFZyRsT0BfTQ1OWly24t/8w2VKvwabOAFTpNEq2jO
         Qjha0EXaRSrLB/lAaveckXA/eXmg6bfDFDWKTwUGOG1060ofEKPyT0g2rSrvIM691sHI
         SvIlqnAeFcdKX37kUi8N5dx++JNGbZgBd7CF6aP3IHy8t+ihU5lDL3kSB4/22Vq91B+m
         qVGw==
X-Forwarded-Encrypted: i=1; AJvYcCUH3COaKRj9jpxExE1/FjkThtpWpCr2opWokz55f7NrTlFCSqqfny0KWkADA58/gmKuDNgp/brkHP1bPgLipi+A7gaz04Sof+qTkMdd
X-Gm-Message-State: AOJu0Yyxb/CASWzVxXHRdktcz+8tNzg9jRZt5a3aVEqw6LpwHKCCgVnZ
	Qq7MMo64caU0DVT9nra/9+CIXIQ+aPe8NOqMjcJAW4/PefvaYfaac207T10TssxT3wcRKY5/PBE
	iT9Lu3ahpmzpbd9xi8gSSxi1enZ0Omw2QEMA4
X-Google-Smtp-Source: AGHT+IHdXl0gIzk+FfvAunF99BLrAefPFSM3Vv+rGhx1OBGRoBiPzTJ727s5npnkAi9T5hKY5R+bKCct6IInzP2GQmY=
X-Received: by 2002:a17:903:24f:b0:1e4:3a10:5944 with SMTP id
 d9443c01a7336-1fc3c774ca5mr424545ad.14.1721069652789; Mon, 15 Jul 2024
 11:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007b55ab061d494ced@google.com> <16aa56bd-b71f-417a-9a82-a2d0876571f2@redhat.com>
In-Reply-To: <16aa56bd-b71f-417a-9a82-a2d0876571f2@redhat.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 15 Jul 2024 20:54:01 +0200
Message-ID: <CANp29Y7vkA+GvS0c0EPk0=f_V0Ci25_4+ok+dRkqGqR3pBXt9g@mail.gmail.com>
Subject: Re: [syzbot] WARNING in unmap_page_range (3)
To: syzbot <syzbot+e145145f0c83d4deb8fa@syzkaller.appspotmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz fix: mm/memory: fix missing pte marker for !page on pte zaps

On Mon, Jul 15, 2024 at 6:06=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.07.24 15:35, syzbot wrote:
> > This bug is marked as fixed by commit:
> > mm/memory: Fix missing pte marker for !page on pte zaps
> >
> > But I can't find it in the tested trees[1] for more than 90 days.
> > Is it a correct commit? Please update it by replying:
> >
> > #syz fix: exact-commit-title
>
> Should be long fixed
>
> #syz fix: f8572367eaff6739e3bc238ba93b86cd7881c0ff
>
> --
> Cheers,
>
> David / dhildenb
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/16aa56bd-b71f-417a-9a82-a2d0876571f2%40redhat.com.

