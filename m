Return-Path: <linux-kernel+bounces-572308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C66BA6C8EF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2040C3AFDF4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A01F4618;
	Sat, 22 Mar 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkocB804"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3491F03F0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638137; cv=none; b=VNY0BhedV7n6QOqA2Q5gfTdbavWIrxnWzXsbm2ymfDgCnnxNjFANKUbEdX1cR9NlZ/izv0xD97HzvMZCbz1K/NRLzfd3kntwg6Px/550D38g2XkBSAsw5QDOFpo9IDkh0YeCsVb6JTdZLzJmoM7CxHalm91JGQyG9pPr9vDXjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638137; c=relaxed/simple;
	bh=NCPR077FKAC5MwREaEfvvvQ/11UcvKcxUf9q0stCgcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7lfp660WUfvqhIOP4WnQTDTDffeWg7BeX0sgKJktUIUL3eg6R/q6iCOgkifnupOl1vZ+SMkK6BWZxndgyLY1aSNY5RwVSaRH4b9Z8ehtK2kHUbiFWU04nGgwU+ifAmjbVVywcOZ9E4N36J/764QvIh8Ty/+G7Tu7Y946hbUq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkocB804; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913d45a148so2283795f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742638133; x=1743242933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJpr/pvMHK3FYU9qqOfhhd94i4g6sSMuiDO+7fqaR2w=;
        b=OkocB804qskMIi/fuNplvj+gX8gMPYO9LnJ8O9TZZLetsffYf2mZaStpzmjFYmg32O
         gYnJb33XDCJ/C2ABPOYSGk/iLhr7GBzeTzdWSk4aHNp147FxHNTzCRiIg7TyYECjiMSo
         2z6/M9YsnLFLFMJhqm4se7HLmAXVHuJbbHnnQjBgoSbY4sCdbMc1TN5X7/OJdPIakZXp
         gN1Fnc7G9TzM06R3gaub/h5Yrapvpzp4+IiTu/nbtMFHSlA4b2Q7ZsPesDXLgvCZcoQ3
         DWVYkesXJIvMhLDwV9JKO5YpuRY1CdC4QnguuWqpATLCEaCPjgkY8BSR9eFpEm22UTy7
         Ac6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742638133; x=1743242933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJpr/pvMHK3FYU9qqOfhhd94i4g6sSMuiDO+7fqaR2w=;
        b=euRy/c6wbVFw77cpi5Gsem9h8TJHkeYb7K99r+qTxZfQT/Khc31l5rSgiHaf7dKnpq
         a85MD6ZVyVgqYp9zjiljS8n/Q+LH7kNViKTMdfx0UmHDObsMqEQWBJkIQevAqVGC7kZ6
         kur41aFebSlJxRycKIMQxEg34e1fEmA9hxDNHY6xuIC/LESAflCYW5JhgswYZ/mWorR/
         a3wknlWpC974aJkk+fBV8RSaSmsv2a9M+oDVBu1otPOSUk5uutaYsZ0VGjX3D53rLsLa
         sKgEHSXzKx3zD6jnaTY1V/Sk8Chm8IIZc12e+lPhUrvy+DB0wVzWO1+1nN06v0YgTDDi
         zh/g==
X-Gm-Message-State: AOJu0Yzu+2h+9jEqZ6GwWamityzoAEgyaVPCF6LNozSVvb2QTC2Sk2st
	8d9p6o/wLERVCcPf/kWEIQ+23ni60BQTaPjdLem/u1tzihB0bGoL8Ir0GA==
X-Gm-Gg: ASbGncvZxTb0K0pYFpMpTe9lSadoKrZggDVSg/5i86wJF2GGpfi/7W38BJCzKFrPoyw
	CDhACScsoRfrMFe0janIp/Vt0NXxCyJRFIbLKr/tBkf8an2ZjS+fymqF52ASpqBPdrZRBdjC2yu
	WLadsklLGkp0Wm00oP3cxa8kFPglcjUV/uiJJ9SSPFYFP/BkuAC3uEoQu20+mr6erPDufKUUDs2
	DqVbQAdYjV7QnHKSjs/4LRb+CIIpx2817MkGiJ95G9AvzljvqjCP0WuOpmXa3Lhm7QGa+sytYbl
	wr56/Eykh0iMjV8t0Nd9daGxvtyLoVsd7d9SzX2MjmnfdIoZVIGVLvNMSS3TDdi3zdzbWlNX3ay
	bQ4pQO3Q=
X-Google-Smtp-Source: AGHT+IHPJkdln29RI+b8WTeD3CA8zpJFMPzl7tDjyIq3NTWjlZovhyz9CYWkGkhMo5vtY9NhU4qgNQ==
X-Received: by 2002:a5d:64af:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-3997f8f8321mr6326209f8f.1.1742638132743;
        Sat, 22 Mar 2025 03:08:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9955fbsm4721360f8f.5.2025.03.22.03.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 03:08:52 -0700 (PDT)
Date: Sat, 22 Mar 2025 10:08:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, David
 Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH next 0/3] iov: Optimise user copies
Message-ID: <20250322100851.39c9eb33@pumpkin>
In-Reply-To: <CAHk-=whs5oVkHMrNP=xkJP4Z4fObn=6Mz3fYp4wWMNQWtyjo9w@mail.gmail.com>
References: <20250321224557.3847-1-david.laight.linux@gmail.com>
	<CAHk-=whs5oVkHMrNP=xkJP4Z4fObn=6Mz3fYp4wWMNQWtyjo9w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 16:35:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 21 Mar 2025 at 15:46, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > The speculation barrier in access_ok() is expensive.
> >
> > The first patch removes the initial checks when reading the iovec[].
> > The checks are repeated before the actual copy.
> >
> > The second patch uses 'user address masking' if supported.
> >
> > The third removes a lot of code for single entry iovec[].  
> 
> Ack, except I'd really like to see numbers for things that claim to
> remove expensive stuff.

Testing readv() of /dev/zero or writev() of /dev/null probably show
most gain.

I did do some allmodconfig builds and got no change, but I might have the
lfence compiled out of access_ok().
In any case kernel builds are pretty much user space limited.

	David

> 
> But yeah, the patches look sane.
> 
>           Linus


