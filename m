Return-Path: <linux-kernel+bounces-276719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 780A4949782
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D9C1C2172D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3B57441A;
	Tue,  6 Aug 2024 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FZgMQMHr"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3723728DD1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968655; cv=none; b=qaON84+vFWx/W3+HXs5KGTe93Mj26QBQ3+As5Yc1Z7ZDV3bX7el2sTMZJlul9aWME8yjbTT04WD7cq1/7QtkQvXS89GTBUmxneZa1fQMIkhNq4hIozjznie8EQu3q1jdaUhBqPjylbPHTVtbFWZTsPpxPtpOJWKteVLrXOK28K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968655; c=relaxed/simple;
	bh=mpPk+W+/bgbK0+Zg4dRFegm2U1Hd3eaHZBUvxVi8n9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzBs4UbfTo5UNTOFxL4s0cM/udojAXj6wc6F6OzZgXKdhBj2EbKzDxDlulBVvxDT1+OTywKdqN6gZPVgnCzlDw43RAn2fOsNzdq3DUNFp2Iwmou8GqalGhtmBkRa2gv6y93dgyL42WJewCfN1fh3extm7OcyHNvbnmiOwlZTGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FZgMQMHr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so1431194a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722968651; x=1723573451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EEdau5PPt6eBF1calzkDuUJZ4BqB2RS7tbhd1Ievheg=;
        b=FZgMQMHruW9GdJU207UgBnK71P3oWD1+mE1Oygtk7+LRmr5A0tAYSWqudZiz/1m0JW
         i3a44hRgaCdUrhbkbHGt267njkAXDkzca+bPZ87YUkgB5NYxeyEqVYkRibeQse6S/Sia
         TV2IlUNk7KZ+FP5K1QO6GmeEOZlUPOQj0bVDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722968651; x=1723573451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEdau5PPt6eBF1calzkDuUJZ4BqB2RS7tbhd1Ievheg=;
        b=XHstZVY4RRD7MDqmP0jObEVIZ99f15B9bTj7089Zg3D8D5YDESgX3L6f2GHvxXZfxQ
         iUJv5XXumQ6wsIpqL8yXeNfFx6ntd3WwnIyULWnd5CD9Ut+PL+jy2cvC+tRkrJOhYFMd
         wMXa0aNTaT0KsA59amKhNV/VbEqlXiI+jSlnY/t4pmque9lt2gV3qDgPtexSJgw/AX/4
         +UzXVqPIlrsEtm8zKcTSOX9HcclmWahEe4z770JP894Tv3GU6aDuY/C+1KvgdnX5ADcV
         T+5SVr7mZy6bbuGtf/GR3jZhOI8TJ/DCqczde0c40JAj4QaI+5WaHp4SvbhmIjRc5H9u
         AN4A==
X-Forwarded-Encrypted: i=1; AJvYcCUkRPRlocfq0gU44v50GCe07xqhix4UkNw3NUTX54zQtGIC2ShDaH9iIyaYLl8xbFUAE+nvpx2g+0VYGAkrggSB5AJ+GG3Y5xMc829u
X-Gm-Message-State: AOJu0YzEhvOV7WIejuvVGmA4XaVTvaN11lv4lPWvF66Li8nizGl9UQPv
	jjG3Mmjsady+0kplDo9UJ79eAv29X8oPtebtp27qKPcdNFx0HB3gtybQUUe+nsvq7m/sNzlWLGn
	uQrnNGQ==
X-Google-Smtp-Source: AGHT+IHOZYdskt2Fv8Yv4+/fZ3HxM7dH2TBwZychZCgKQzFJLcv4IRLpDwztEainXNdkEbeKzFpEbg==
X-Received: by 2002:a17:907:7f15:b0:a7a:a3f7:389d with SMTP id a640c23a62f3a-a7dc4fae89emr1012105766b.31.1722968651083;
        Tue, 06 Aug 2024 11:24:11 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0b761sm565252066b.55.2024.08.06.11.24.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 11:24:10 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso1093226a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:24:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUE9iYnLAvRo0emantxTWA0kZAFsLDnV4x34YqoVBmDNRXh8mtmvglgIsN2IfbsOmqc4LFrkiwaA1uHjA05ahdUxLikN6rvWNsKo0rT
X-Received: by 2002:a05:6402:331:b0:58d:81ac:ea90 with SMTP id
 4fb4d7f45d1cf-5b7f57f6551mr9769482a12.38.1722968649989; Tue, 06 Aug 2024
 11:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org> <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <f63c6789-b01a-4d76-b7c9-74c04867bc13@roeck-us.net>
 <CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com>
 <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com> <3a706169-9fce-48a0-b808-37f347a65a25@roeck-us.net>
In-Reply-To: <3a706169-9fce-48a0-b808-37f347a65a25@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 11:23:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoTU9F1-qGW8ad7a1ZCMm5K_QZ9pX-chCxgU8uN0+2LQ@mail.gmail.com>
Message-ID: <CAHk-=whoTU9F1-qGW8ad7a1ZCMm5K_QZ9pX-chCxgU8uN0+2LQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Guenter Roeck <linux@roeck-us.net>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 11:13, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/6/24 10:49, Linus Torvalds wrote:
> > [ Adding s390 people, this is strange ]
>
> Did I get lost somewhere ? I am seeing this with parisc (64 bit), not s390.

Duh. Sorry for the noise. I don't know why I thought this was s390.

The parisc __ffs() is also using some grotty inline asm, but I don't
see how the compiler could make a mess of it.

                Linus

