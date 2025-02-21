Return-Path: <linux-kernel+bounces-526495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6FBA3FF78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2AD425A09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDF2528E8;
	Fri, 21 Feb 2025 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NZD2mU5+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F901F03F2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165169; cv=none; b=EvpTVXomHJidIPB+ZVWSh0jClgoX1Vo1FAHhM3aTeH4Pj0PfZkd8KHmVjHaa6ej5sUIVysayACjf9s3N05JUvbXZLQIHHLInMrYv+FYDLABkyisjM5R3G/QOUM83ow4oNmftoi12uYM3/QH13Q5Xfrv6XM0NzcBfKQCTTs2pJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165169; c=relaxed/simple;
	bh=ycAq18Hl2Osak2ytc9YhbxBtTZWY1af4b1+0AgXoSAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEhPQ2G2j8zxZifKrlye5TjQi/oQNGiNscnhEL7ppTKoMiqToKc1nu8xUMyJLJV8pqxcItqCdy1e0cZIv7NrvSzZHbHs2y3sUwMjqf10IWbQnoTJir93TpUQ8XYTWb7t7SYh73hEiHkf0rgOliKDlrSgjXa1EjTLEFTVLycTGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NZD2mU5+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbdf897503so584156466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740165166; x=1740769966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PpPO+UoqYur20fhUIihwHOS5iBey4AF8c1A/KbY6wDQ=;
        b=NZD2mU5+q7JF/1ShSpfFKy7uSRT74FFbfKKMZ7dFzqkRq3QztFuOpF5X95exHpcLs+
         KbgZE930RQaPd0mWi0LC7qyEA0KIqn/bua/OgG2v6oy67kT5IL5MVmfZ1jrzpjLBjqL5
         l4750jONwAKkF7ddHn4n78E4tRYAQiY74iNPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165166; x=1740769966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpPO+UoqYur20fhUIihwHOS5iBey4AF8c1A/KbY6wDQ=;
        b=UieSyUWx25Ojd3vYFZKuupTT1cHjNTl+QXLJ35ILTipTkpkLPo9mklkXlGS1/r6j4J
         bHDs5IKpyXdm4adOVcK1iwo2qWu8CeNDTJ9BubaQg5TU5FU5hMReq7UmTrVoC97qH4kk
         69NuU25RCEdqEdIIaOCeqkD+iQ1S+rqrCKAzGGd8ypOlHxoltv3zqkvHDTIY3G0TTyen
         6ok7WaGxAWwg/LDklvjUNt9Y31H95+J5dr15X9dODQmD6/e/JAsg6O9alAEuPFLpd8X7
         oY6D6QyIxh299inIzAr6o2eFo31fBNKWYuL+ctf+0J9H2EKoVCHkGX03IK2Ur4j3/H1j
         jtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+6qr8aBQn6Tos7+mGPVTPokz1ybFUPgNKXx0JLx7fIeK4+wOrTwZlRMgfHOMBCYD/BTCbRB2hlYzr58w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTIWOkB4cKwRK5BtiwrbOfxazygGlMKyy7cAHIP/jntN7u36wx
	+hGZTIz4bTWkmhLk1sHTHCRUWH9TwdgdeZmUS4PdxlQvMrCXLcubmaA0lnXEwjYujDb0c+vPnPY
	ETlk=
X-Gm-Gg: ASbGncuhkRBC9vnaLqnOzYu4aeSmv3imfbqM09XSfTvVopZ3iXmPg4XAGVvCTHjCh69
	M2i2baYSaNvDwuEASKbi/Sf1kx1ZsKV23txM+QxfWr4z5ILr26l+MYyK5r11rHQSOfCgGh4ciaG
	ouSX42KK209fiZhlpERfVOWPI3DqJ09GB06HFaW4KpDLJo2p04ubMXavDokbJ2NWWMUR84H2k+x
	zQHcXWSkwgC5lSbbNXfGKERcjsDyQ8fFWcyuYsKp+vI02wbf9sLTnYTRI6i5aOT8C6KGwb1OXJq
	M0kxwxesxmUXpBz48+JrWuAp6VTBls0XdbX6tqF4mLKR8lMlUofPNJlh5+57Vil/MN8vVetMmMZ
	a
X-Google-Smtp-Source: AGHT+IGtzl/wxZOIzzeoXCQQiF7kIuyYHsXIeux99NukRPRu7FUz/76ojXXadTzHS6aVH3JR5AZ0YQ==
X-Received: by 2002:a17:907:9989:b0:ab7:5983:13b5 with SMTP id a640c23a62f3a-abc0b036277mr386653166b.20.1740165165769;
        Fri, 21 Feb 2025 11:12:45 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb96922d1dsm1078589366b.50.2025.02.21.11.12.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:12:44 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso459073266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:12:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeAr2Sz5coUWJqO296fSTJlbhCkW9rSCHtxfeiDwZNxAMdpOgFbBhKd6vwi5NAoOPPWRhsjfQDwqIYWE4=@vger.kernel.org
X-Received: by 2002:a17:907:97d0:b0:abb:ec29:d40f with SMTP id
 a640c23a62f3a-abc0ae8ac7bmr518893266b.13.1740165164023; Fri, 21 Feb 2025
 11:12:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh> <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh> <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
 <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr> <20250221183437.1e2b5b94@pumpkin>
In-Reply-To: <20250221183437.1e2b5b94@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Feb 2025 11:12:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjF0wjD4ko7MgrZ1wBZ9QOrQd_AnyhDDUJQ1L5+i-o22A@mail.gmail.com>
X-Gm-Features: AWEUYZmM9QfL00hwgEM8sBRcCKHPzsXEZopO9LOxfzNGM8PLhnN7fh_mlPWpfF8
Message-ID: <CAHk-=wjF0wjD4ko7MgrZ1wBZ9QOrQd_AnyhDDUJQ1L5+i-o22A@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: David Laight <david.laight.linux@gmail.com>
Cc: Jan Engelhardt <ej@inai.de>, "H. Peter Anvin" <hpa@zytor.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 10:34, David Laight <david.laight.linux@gmail.com> wrote:
>
> As Linus said, most modern ABI pass short structures in one or two registers
> (or stack slots).
> But aggregate returns are always done by passing a hidden pointer argument.
>
> It is annoying that double-sized integers (u64 on 32bit and u128 on 64bit)
> are returned in a register pair - but similar sized structures have to be
> returned by value.

No, they really don't. At least not on x86 and arm64 with our ABI.
Two-register structures get returned in registers too.

Try something like this:

  struct a {
        unsigned long val1, val2;
  } function(void)
  { return (struct a) { 5, 100 }; }

and you'll see both gcc and clang generate

        movl $5, %eax
        movl $100, %edx
        retq

(and you'll similar code on other architectures).

But it really is just that the two-register case is special.
Immediately when it grows past that size then yes, it ends up being
returned through indirect memory.

               Linus

