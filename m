Return-Path: <linux-kernel+bounces-570387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8AAA6AFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAAD48822C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A648920A5C4;
	Thu, 20 Mar 2025 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LOYGvOMi"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DB8F6E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505459; cv=none; b=cIVR/RrlBBdIW8YCBGL+YwCJKUGuyJxitAOydBGRVZYHfvKufgw07sbDnLrb9qifXiLSFhcygbqOZJq+7QiARawxOH8jIonW43uP9QspYVaeQ8QbQZE/YO/3Tq6myGcu+Mp7dwWz2Xo6kRKJ2JCwAtdZKYWr+ntnAv5hYi4eDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505459; c=relaxed/simple;
	bh=BzH/S4FqA82HJo+ciJuAPbxGd6hiA1rpZmdgxXUWuO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnTBVcVHNGBOultKSI20Ljh//DfFXZns8ZWfidikdrpb/vUnOgMfVZ+X6qWbTqcJc1p6BoWKUCDeR8JJnWYPOS0hjOC9AXSfp4/TbbjOFNbcS0feg4dW4G93siZ0nVnhexnV3I41PyGCaiua/TPWALUlDvw0LQ5uZmeQvppIuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LOYGvOMi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so205221966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742505455; x=1743110255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ocm4Iixnlvf/PhQHaxpMXyWMKgJoCTvlBlRAbJwnpc=;
        b=LOYGvOMiib2mEkRS8ayYWgeS3OVFSFSy2CImhDDC3rBW2DVG9oPe5XTWI/LscVkigB
         U9k2HHelvNBR5w7zPemPwHfnVBItan0Weshn/fph0WTRyT60ttFbWJo3xZLAtAwvaPs6
         I4oSOlnNNgJxOYzpwfu0/Yk6ZKqlgSwZXKEPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742505455; x=1743110255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ocm4Iixnlvf/PhQHaxpMXyWMKgJoCTvlBlRAbJwnpc=;
        b=N5t0fZUaqWycVFnkT1Ns57f5Vdfec88QtgF71T1I+hyKmxJiWhQI93b3xwcsk5v086
         jGnl2h/872A0ONFEXwAbM/+OQ34WV2F3EXJeKSUiiGMeJFmw28AFW+IEuw5gndMI9T6O
         yDsr7138Voy4/GoX04IqN3e/6yOvVi/81sXs6u/Bskk+LZpGy2ScdeeiD39kGS+qr4R8
         4g0j2n3RNDG6j/xqV5aueuZAejTGQ7dANIQKUTsxZU4lzdYivXoJrWhj7d4F5GLrbEIC
         n//BbohA/fqoUq0EcWAbREakrihWIX5PV5GWUvt0lBj0BJBh30WpAYuc8QHhfx2tZLI8
         g1fw==
X-Forwarded-Encrypted: i=1; AJvYcCVka94vqXaJDaG+nAghlI7tp1/WzqTTcnqUUq4wUlctJJnrVZX02PkpRmCCif+zAaaApi3UgTpg52z2ruY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYkjvdxvwgZC67TZccxk5wyDJRIqz2ILvjgPR0juvz2hqpf7t
	CSZTUNAntRElaNtu8fVokY0DGQCDA6fza816kbSSSXQDyZ3xoTA+fklx0AC4tHsZ3Jtw/3LRzVX
	yKDM=
X-Gm-Gg: ASbGncsLN00/l760l3DWleOPt45WVly4VeN8fh/EI3LEN7mZJKgzKzI81N0hl2TrLYv
	BnTeBIDv5kYqt035pKjjbtMNRAjBVIrMJ1e1jxuTQB9Nb18XOdHjqxklec4aF9fcvLDIBEPjEjf
	Pm+EZMTXEpE/d/GsW2HAfksc/Y16ZL7rtytoWeezCDOPtMvDNBMSC8+/JeGQSAOmT6618v4Gzh9
	kWiLzihljUIYPnCDYV4mGoz2X3DtH0iqxYrbAcVJkDDDhKd2uoDQtnGTnTPq3KRwlGV7p37oDRh
	65amDzdNOTINAtY0pCnhg8FFL+f74NqyNuBIxz8yZ9cJzFwOonbsKzUHgG15S2RydiEdxf+rBaJ
	xXg2gXToEuByLUyjmu5cokMNGA6th+w==
X-Google-Smtp-Source: AGHT+IEs19hEixbySqNUTWM5MZVSjyxRklffoc2DHNgEde9R9z95W26bInilCRYOHSF/1CdtUNw3wg==
X-Received: by 2002:a17:907:95a4:b0:aaf:103a:e6e3 with SMTP id a640c23a62f3a-ac3f26addbemr75468966b.43.1742505454926;
        Thu, 20 Mar 2025 14:17:34 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e532asm35917266b.56.2025.03.20.14.17.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 14:17:33 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2963dc379so220474266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:17:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvQTwN8ADiKAMOqduL1ZLguvikvK1TWibJj+82zS+HRqRO33UBCRC1l62urZfsr/pECpFBjoaVhGiinys=@vger.kernel.org
X-Received: by 2002:a17:907:2d0e:b0:abf:7636:3cab with SMTP id
 a640c23a62f3a-ac3f24fca13mr62083866b.29.1742505453491; Thu, 20 Mar 2025
 14:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320190514.1961144-1-mjguzik@gmail.com> <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
 <CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
In-Reply-To: <CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Mar 2025 14:17:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjo__Bj3JNw_7E8HhTDUF65LVOApvN0D2cofgotJoqpmg@mail.gmail.com>
X-Gm-Features: AQ5f1JqP7gG7Echr-TuoJlqUay7SS30vYXYq6MLQs0dyblkHABDG-F9h7nYMVl8
Message-ID: <CAHk-=wjo__Bj3JNw_7E8HhTDUF65LVOApvN0D2cofgotJoqpmg@mail.gmail.com>
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: x86@kernel.org, hkrzesin@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com, 
	atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 12:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I have a recollection that handling the tail after rep movsq with an
> overlapping store was suffering a penalty big enough to warrant a
> "normal" copy instead, avoiding the just written to area.

Ahh. Good point. The rep movsq might indeed end up having odd effects
with subsequent aliasing memory operations.

Consider myself convinced.

           Linus

