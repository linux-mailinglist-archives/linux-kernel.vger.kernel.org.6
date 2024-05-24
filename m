Return-Path: <linux-kernel+bounces-188978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49118CE93A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124F41C20A01
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D1439FDA;
	Fri, 24 May 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nthbiQOp"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17A381C6
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716572022; cv=none; b=Zm2ABsx4nCUCHHjg7oa07C9VfMWT8Mk9booqnS2mFtzAOtqva0E3bco8AVyoTNgDCgaH3ShwnEOVJ5cSBQtXOYyvU54USJn6VccV06QrO2ePuSOTSOm0ouiCc6eKegFSa0b2nCMYZRNJFRIDjmQNJJkJwHjhq4Bw2byLD4ea/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716572022; c=relaxed/simple;
	bh=jJcY+vQzlxik7/cT2niBTDxIgH0RjBJZeGIM/Z7JKrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6pepNzODN+QvCNwPmvfd4Kh/W1RlRS2xYhwFCYXRdUFa5XEYTROQyZWfAE+VQ/A0NwYuROhJ6T5vHffIXNRlQ/pyKCiHemVDiarlT7mAH3LTg2uCD5SQDKdDzCzCTrtkyVJNeWS0jRp2V4hlNLrnG0oyBo/Y7ILZjA8QrIdPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nthbiQOp; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3737b3c56d7so4571775ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716572019; x=1717176819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR+IKKz42LKq9lWpJcypoWgZXpelFVN2Adc6x9cCqQk=;
        b=nthbiQOp8YJGAD1RTNxJp2g6ww5abLRKB64O7L/KeyHuquwMEoriMqkU0e63Rt4s8+
         gF29yM9rFcyHCUs0w2Lor9U2aTWcstcQRvpRtYrOY7Df/GhnkHhIckyL7wZsSjy5Q3ax
         UNVqxwrMU3GOHt0P84hxoDHmQIg4kmSk7zdO6m7rrWLEW1t1cwFSah2z58J17ilwiLeC
         IUH9IsWJKWYv9XcTHA9nryP4kis5eXxNleS2low657uFSI16qr8IOO2Yib2as818r0Wf
         fQpr80GeHFZSL2znbg9pqibuXxWyQ9MfsyL4Shjxvme3hIgBTZtg/PTV9vBqaWZgfut/
         nfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716572019; x=1717176819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR+IKKz42LKq9lWpJcypoWgZXpelFVN2Adc6x9cCqQk=;
        b=YIT6bi1xkNbBdhBVreiDb9e7lRW8sYT6BlBmBFpvJy/PkCQdYPLOgVix7WCdUYa6pn
         dkgA1F41X/xDq5v4zDm8H3N35rmoEo5aUR813fjDAEeiWwR6pPPzuoEjX9wrxMJ2JiH8
         AGzEAnslWxgXGloMZHFlakJ92tX+rWZEc/ebKJmyOuGxf992sZnxdJlpBnPJFOWIyRvg
         RJnXrSMsSQFWrzyosNzs9ZnHhAiF/0iaHXaB/kjntd1mpOxQZ789z2kMvByj03RcCdh/
         M6e1MDihG1amOobxrshfj/trI9HgDRk1ucdQIE0lQ3tHHsnNu1BVT4jQcqGNZ7fJ4dCB
         VohQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvjKzVbTd77OHT1Otf9jo3qQVvrs11jgPf07/ghAfChQJ3CvonXAr5heFN0dxf/fgFEpBemqJkvxc7ikDXp7X1xI1yUAGi51CNE5CN
X-Gm-Message-State: AOJu0Yx2RMC5EqUzUq6en4J/GhLKFCkh5/q2eM3Q/aZ0+uccwQ7pTIRs
	IPTBw5Ag7gV08sprqqj8oTdyyysTXnGffy1J+vVPyQ5+X5EOvygiYvVXLszcQOy8eSJaqduee6F
	Hqo47NrQaDtQyhyF9SQgtShQ/+hY=
X-Google-Smtp-Source: AGHT+IEw/KbQqy6J9JHf1OwYD+7USGC1YdGlvQn0jqlKLuA+A2nNgR79n18oI3Z4hedpGoq0vmIPV1exDIuWIo4BMjQ=
X-Received: by 2002:a92:c249:0:b0:36b:26df:ccec with SMTP id
 e9e14a558f8ab-3737b3251b2mr32120885ab.16.1716572018648; Fri, 24 May 2024
 10:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkxN0yQ7Fb0X26hT@kernel.org> <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p5>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5> <Zk9UCsZdizqC1_36@kernel.org>
In-Reply-To: <Zk9UCsZdizqC1_36@kernel.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Fri, 24 May 2024 23:03:26 +0530
Message-ID: <CAOuPNLhN16FcYyAj7i2S9P7wJr+Z1LTDOOOkDZUwwq1_ZMiv3A@mail.gmail.com>
Subject: Re: (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
To: Mike Rapoport <rppt@kernel.org>
Cc: Jaewon Kim <jaewon31.kim@samsung.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>, "tkjos@google.com" <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 May 2024 at 20:06, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Tue, May 21, 2024 at 07:17:53PM +0900, Jaewon Kim wrote:
> > >On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
> > >> >--------- Original Message ---------
> > >> >Sender : =EA=B9=80=EC=9E=AC=EC=9B=90 <jaewon31.kim@samsung.com>Syst=
em Performance Lab.(MX)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90
> > >> >Date   : 2024-05-21 11:40 (GMT+9)
> > >> >Title  : [RESEND PATCH 00/10] memblock: introduce memsize showing r=
eserved memory
> > >> >?
> > >> >Some of memory regions can be reserved for a specific purpose. They=
 are
> > >> >usually defined through reserved-memory in device tree. If only siz=
e
> > >> >without address is specified in device tree, the address of the reg=
ion
> > >> >will be determined at boot time.
> > >> >
> > >> >We may find the address of the memory regions through booting log, =
but
> > >> >it does not show all. And it could be hard to catch the very beginn=
ing
> > >> >log. The memblock_dump_all shows all memblock status but it does no=
t
> > >> >show region name and its information is difficult to summarize.

Something similar, we have already proposed almost 10 years ago for membloc=
k.
That time I realised some of these reserved memory break-up becomes
useful and handy when we are gathering reserved memory stats on a
small embedded device where every bit of memory reserved is important
and being questioned.

You can get some information about Kernel reserved from dmesg | grep
-i Memory (including the kernel init, text, data) and the cma-reserved
as well. Here the cma-reserved was added by me.

You can also get these Kernel reserved size info from vmlinux.
size -t vmlinux

