Return-Path: <linux-kernel+bounces-373440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288C39A56AB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCB01F2184D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3B19596F;
	Sun, 20 Oct 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PvIbsbBj"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E881A269
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729456337; cv=none; b=bFG4L+t0V9nf3LUcKZM42SKYyn23NXOzuhtfDqlyOaEoTLDDuqDBPimBVMUKJY75RZU9mnZqaewf1Dp6Uoi4ralpIg15SFR6pIwDM89BV9QkhMSCtfSM8NL5uBN/bLm95ppOzkkZSZmohAYlaNTtzaLA9wVzai1dKNjriWhLIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729456337; c=relaxed/simple;
	bh=5KsaVPwSNkqnf2P7EKz+CUfRfxa0d6AyaHKLgaaVY+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BV3tT3ES6VDmkXvR/qfdLBSimdolgIZoo+zCIuiceIr1md89LDPMd4tyBUcncMNexBbYGomBN8omQtJsuoimNTZ9Yo3L+0k2SETts1iBt7EJcfJ8mv29d7UXfuKYLxlZQIYC2iXIrWYOzCcXHteBegq3SDUb4rAfs4nSZcGYY70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PvIbsbBj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so424222066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729456333; x=1730061133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5lvT2MXCIdvwUG35lAosjgIyGiktDbNjMaRiV7eIfm8=;
        b=PvIbsbBjGuoKA8DaOekzUEBsPKs9EP2R0LKZGObOTaIKUOiTbla18mF798aUIVx2R5
         RKaWjV9El7lGAcevZ6fpUCyilUmAGtfPhLhU1PeQKzbQO4Oynd9AkQ2RXoN//It9Mp1Y
         OwPdZGb+9kabJYheJg5mv7NZooMa0A60ixMLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729456333; x=1730061133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lvT2MXCIdvwUG35lAosjgIyGiktDbNjMaRiV7eIfm8=;
        b=H/71Szy1g8I6CMAD6TiVVYzYnK8jhfiNf03M4jDo9gEw6639UaH3e/QnZfQsp9v7xo
         ACAEb+qzdCFDkzujAiXkN13DbJrqEgOMMl2y++UEBDNziYlr1fyfMH0wl1ChZQIS1uo1
         zpuabUBMQ0STssJSTiyhDRGQlSlySLJzYvJkYpipCt3AwIMCiwaFFr3NOpdi27zk91/k
         h7uhwxf7mmrIfa8E+d29rS7H/UNW0tyrY7YlfxtcuzPBb8NX5tjF7h+8HHYIMqyyKL6i
         X5VNyzcT+PzOI1bjHFcyu4WvmJYivK7VQGQ+l1oHbDbTG2cspx+bs44EWS/YvvZqRtY9
         LciA==
X-Forwarded-Encrypted: i=1; AJvYcCXx65KdhVE0EjRFOYXMVg41WofQnFD8pYo5PjMUuniWDyTvY5ICdMUMXAq3CslYN0+7t8GtZ1f2DuNNMpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3mCyh9o/ZYdHl3BQYN3jkmO8Qd/p51ytocWH/aiB4bupQPSN
	LiHinJEBgd7pvIhBsERtXfqvqqcQinUlqrX54SwmgJGpAooax5eMJ6+gSfDsYBT0RKTe8y8aILg
	KJCQmSw==
X-Google-Smtp-Source: AGHT+IGvAy8K5pxHa3Wr/jespjiSiLemCS4TH0dlyNg89k4MtsPZk8pxD5bgw0XF4Zsy5ZzXta8FbA==
X-Received: by 2002:a17:907:97c1:b0:a9a:3dc0:8911 with SMTP id a640c23a62f3a-a9a69a7621amr887273866b.16.1729456333151;
        Sun, 20 Oct 2024 13:32:13 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edff8sm122731066b.59.2024.10.20.13.32.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 13:32:12 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso606499266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:32:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxRhM3Tq9QWcFMnFrYQ5R6yNEY+o3Op+DVjd5Wh8PFGN+e1nZJfCcoFROdIeFOZprMlMGFFXzscyLw9oE=@vger.kernel.org
X-Received: by 2002:a17:907:728c:b0:a9a:6855:1820 with SMTP id
 a640c23a62f3a-a9a69a7616cmr1110187966b.15.1729456332287; Sun, 20 Oct 2024
 13:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ade4f305fc36868f@google.com> <671547f4.050a0220.1e4b4d.0049.GAE@google.com>
In-Reply-To: <671547f4.050a0220.1e4b4d.0049.GAE@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Oct 2024 13:31:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0HM6Cj24+2mQBU-LmhR2-GBmtA=y80DhKwETsKxnrAQ@mail.gmail.com>
Message-ID: <CAHk-=wj0HM6Cj24+2mQBU-LmhR2-GBmtA=y80DhKwETsKxnrAQ@mail.gmail.com>
Subject: Re: [syzbot] [usb] kernel BUG in __page_table_check_zero
To: syzbot <syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

#syz fix: mm: avoid leaving partial pfn mappings around in error case

Because even if I wasn't aware of the syzbot report, it does look like
a match for what the commit was meant to fix (and may have been the
source of Jann's report).

             Linus

On Sun, 20 Oct 2024 at 11:12, syzbot
<syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com> wrote:
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: mm: avoid leaving partial pfn mappings around in error case

