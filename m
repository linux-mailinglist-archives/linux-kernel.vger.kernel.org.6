Return-Path: <linux-kernel+bounces-201826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F908FC405
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9FCB275B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC20518C324;
	Wed,  5 Jun 2024 06:58:58 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7719046C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570738; cv=none; b=QaFF8J3sg+vV5wVsmfBycBlrZng6aCHR5yln7TGX7cdBLSpdtqooiVjT7wtU/WlzWB8FNFYU938wLcC7oHp1l4n4GBMYCL9ZIVUzK+VDmV6Dy/C3E/kLHOJDQtfK5n5c4rumqS16Is0nn+jdFlEJuqFXYWUQSEc4qKHi2LTF7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570738; c=relaxed/simple;
	bh=oJSk6PuyDTM5qpVEaRx1V/kUasZD+tYwArpVu5eS0Hc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=unFMFtYKFv1RIC36s8bnWyw1s/vmZRtxWPmi/Ea+fabJ2ZhCllfQVYJfBnRvJn9rmwtr2/QBb/e91PEnq/PkZLMun2uEQdROdln2HN2ngG+UzvzXNgK1jgM6uwPySpPN5JPXdDgv+rXVuHv9PvDfqiw/noqDDQlqSYEjx96cCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-374b30cd3bdso4377355ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 23:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717570736; x=1718175536;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJSk6PuyDTM5qpVEaRx1V/kUasZD+tYwArpVu5eS0Hc=;
        b=EO7T6pD50D68+tNuW+iv1PK3nuzXV+ljRpS3F8QC+4+JYGXORfzcjJiUTGcdWdLro3
         Z4H67ORhQoqpTUoWzlr85QDhNTT6fQj5EEMa2RftBO4U46gIzYSGeagJOUoe3yeVsl1o
         NgMEi9LqS+wi8pIbzLeo1UwiyY2Lzg/aAIeCfk1u/y6nd35oxbPfBfJPXkGkRmjvojTs
         vk595cfADoMcuTbHaPKFC9av3/+dn+SxbreklRHWaJquic72R8wfrFVNGzv4u3yXUTPm
         Hx+v+JMY6ZH1Qrx9l890bAV/7IwKdGCPX5VEMr/TpTKfBfw1pGPGJ8fVUqgwn/QW9gyS
         Umiw==
X-Forwarded-Encrypted: i=1; AJvYcCW2ERL5Aq+DTNB0uRWN4GZZ1swwlteCaWNhZvczUnxFLhWViRG3nWbrWvvig+AJqYNW1fcskq9XEOs7UY2gOAZ0T58EOSwA/F1DlYXZ
X-Gm-Message-State: AOJu0YzRbHHPTXJLIuissAekyhrSEl/RmqTIGhDvy6/W2KtMKiYclkDZ
	VKz6Yois1K2q9EAr3l0/nCQ4dbgAgtVZy401DuwKdXxnbJIdVn2269WFBCTuPPUe5zrVQ8Z7jxk
	djcfEX8a/p7OWLUi0a+yKKtCzipmsuOWoEsR8h4lp0I9bN9MGN+fqqJQ=
X-Google-Smtp-Source: AGHT+IFwjSAb9loIHj30nAWRPPGmnn6uu2a5395CVb5LHnU2KxCyhGSP9zofFXqqh1oiZz38PZPOKFsaRuM2i1VREShHio6AP4Kg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e6:b0:374:9af0:5f32 with SMTP id
 e9e14a558f8ab-374b1f4fe00mr986845ab.3.1717570736262; Tue, 04 Jun 2024
 23:58:56 -0700 (PDT)
Date: Tue, 04 Jun 2024 23:58:56 -0700
In-Reply-To: <PN2PR01MB48917942DEE60271318A19EEFCF92@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ca2b4061a1f1982@google.com>
Subject: Re: 000000000000fcfa6406141cc8ac@google.com
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test e377d803b65ee4130213b3c041fc25fdfec1bd90

want either no args or 2 args (repo, branch), got 1

>
>
> The information in this email is confidential and may be legally privileg=
ed. It is intended solely for the addressee and access to it by anyone else=
 is unauthorized. If you are not the intended recipient, any disclosure, co=
pying, distribution or any action taken or omitted to be taken based on it,=
 is strictly prohibited and may be unlawful.

