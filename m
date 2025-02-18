Return-Path: <linux-kernel+bounces-520504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4BDA3AAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3988016A997
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021411C8622;
	Tue, 18 Feb 2025 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3BQl2zR"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62821BCA05;
	Tue, 18 Feb 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913750; cv=none; b=JCpXkay84tAqh3wW2IalEVew0/bqCaAp7RPFNJpx49KE7GJU/2ZTBUReY4hWxV1tCYs+tIDFu/dklBgqAMd9wj7TgYED7aKKnygInD6MzAHojrw4rtM5D12fKxLpeP3VAzi/lO4YMB3Xb/xiYOkT6FxBjwRQQs8bIFPSGc3Xa1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913750; c=relaxed/simple;
	bh=PhCJS9wXLp3599FRMT13jinVFW++LjWM4UggqGQB7xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQa2czdhYJXCvx2md1MMW0/zSV/tX5sQg7VlP9yDjAzjB9hPpWLw1tI7GuBydWr/BhbZJ6zqEG6IdGKi0hcLjAXGFigt+Gp5jAltCtBm8BUXo2QhucoSK+YXf4060uZYdxKHkwUArS/KiMafvdQR7OdG+JX15mIQuwWC3k6uQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3BQl2zR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471f2e1bea9so20507431cf.2;
        Tue, 18 Feb 2025 13:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739913748; x=1740518548; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mdXHnWlzCq6Ivvzkf4eBGgZZDJKGn23knokILDm8o3c=;
        b=X3BQl2zRIOzRFxalvVseLH6PDrghq9PdPUKHqqi68OA4UfQaADzTAQ1MSlSogtJ+IH
         ZsKg3sw7Zc4J26OyL7y6roRend2y0z/eyIC5JTk7sI+rgnATRvcmDLP8v4iI6rPNC6kX
         dzw0oe7hnzLvFqC1fkZRUWjViLwsUIvNGVAPtm5CrTsjYP14eQ3v4xw8mnhSwjGfyuw/
         18mAcZ/zbEdTUnSJnq0bzslPrK3Ti2YJ0zk6IBq+faeThzNl2nfishM1JoKaX2eCLriy
         un6t7bVr1axKnH4capaVRK4/agqxWsbaoU/Z8u5T0b8ZfnzfJLe2DI0MPbTquMRfBzsd
         h9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913748; x=1740518548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdXHnWlzCq6Ivvzkf4eBGgZZDJKGn23knokILDm8o3c=;
        b=ID/NU1RgRFlkVbCiUbpjyjx7dF4qyKtYwRFmDtFuLejpDAo1mg5X2F9Os5ek6fUjtk
         a8FzzIrr7dKNN2ifdYk2Lw6i8K/5/DWxIGlweJapCkOzr7ag0Dvi+AZfun/2rvY9YG8D
         oGIL4NhijMaiaQ/MwUaEQe2gItJIAsm2NIb16KwEVZ4ROKWPGpX5x+aVrksOwqhYUsyR
         hLANl9XEmVfJ9qFyLlqkYtYSDG/JN/bGc7lFcOpP6HDMmVi69GPhzF21uWum2LABx9Nw
         G6dNXXeDyM+sMqrxX9XU2Hewo1DDLvvK/52OuFAtey8Qn+NQ513iwWL7vAlTKcvH+6hv
         i8qw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1iUt2HejIzBxQaEXuOz94mDsZ1VByZ1ph453dZOuXvagbjREP82cjPczYC9n/RfFMt8WqUO2FRlBY1LWx7k=@vger.kernel.org, AJvYcCXeY5w0n760ZEoDFEMFDYSWQTXtRfAeWBdmJ38voOuW3D8X2SLgiIipgNd3oPWBXN1ZG+eDNLljYaFpcrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1A4RCRdXYq+MavYKKJhNjpcKRvW7uw5ZS7SxpoGKE+gMX/H+
	LTzI4nxC+qPo9J25cXjSQiJkZGLmnw3TnAIHTy9iRW3jt9Nvkudw
X-Gm-Gg: ASbGncvRdcXcOlbI7x/rpfh1euBJ6b7C1EgfchjpaFItbty9X2OmwGPK2ASR/2qpvIL
	Y2h6Sy3d4qnfNICdzsAD7KrSll4//RqY5LlxBZ6LPk7UuIAvgfsSiCH/nmUEoKiIF7VXqBeg8qw
	vIcYoDxGeSpr86E3veVUJvfm4bFTlPHxP9wHDBIfKHuPyQ6+MGcPkkIxfoOJLkhuRixzXxZU0zi
	IAtrPSEUbnDq4mth3CEf+e2juHl8CrCkin3VcsInwSoZk0RvKrGmlW5YCxv5eD3UsPcUjaZYyZ0
	ayQBdW32F3080/JB6PTsXMMjZ+s6AZ++RWFTCS2TLhXLLGJMzUtapE9z7VuuJAoSUZgu+eqNXat
	thKQBRg==
X-Google-Smtp-Source: AGHT+IG/CZ2zc9Q8yIVFvW5ZA3NO2BzO7cnxuhf1PWn/NSNNhTEdZqGlP/nCHUYXswX/Hk4Xcwl+ew==
X-Received: by 2002:a05:622a:1106:b0:471:cd16:8c73 with SMTP id d75a77b69052e-4720824fcb5mr20118221cf.22.1739913747526;
        Tue, 18 Feb 2025 13:22:27 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ef0a5943sm27817941cf.51.2025.02.18.13.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:22:27 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id A64CF1200079;
	Tue, 18 Feb 2025 16:22:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Feb 2025 16:22:26 -0500
X-ME-Sender: <xms:Evq0Z9d4iSZwGfnO_PZIkW7L5qjNlfdC_2GOzPDGSiKAJcyvp63_mw>
    <xme:Evq0Z7O5QwsQ3C-DevBCJxvubojvSKRfVGK6hcgLWnrRQ4Aq9vT9H6FHZsuIqiRpw
    MifwhqzV5Q_YJ5_vg>
X-ME-Received: <xmr:Evq0Z2g7EQexeGWgc8STD2FJpRf65mI2ezY0-NhqZmc1rvIxXgwncVO_-7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeelteekfeeuteduueeukefhtdetffefueef
    heejueegvdegueduudefveekueevudenucffohhmrghinheprhhushhtqdhfohhrqdhlih
    hnuhigrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepud
    dtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrghrkhhkoheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhsuhhmmhhitheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:Evq0Z28nebbzJhRWuvHTTKQOzFNvTaecrzKksK5g85hXeJh7CbU3UA>
    <xmx:Evq0Z5tIm2PdKOhwGDq2mZKe0WF54nERmkhwtA4XwoXtmp3uPBBrHw>
    <xmx:Evq0Z1HII8aClMmg62EOo57hLlZmacCGIND6iv7NH8FwnFncnlQfyQ>
    <xmx:Evq0ZwOift5JxoXBDAiXB0pdEAyFM5kX2CCpdX7ygkSZisH9ymx42w>
    <xmx:Evq0ZyN67n5Bi4YpIojOGzoj-HSJ-jsiVySIIT5jx27tiuqHNWEm8PfB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 16:22:26 -0500 (EST)
Date: Tue, 18 Feb 2025 13:22:05 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7T5_WGX_VXBby9k@boqun-archlinux>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
 <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
 <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
 <e63089e15c6f4d19e77d2920d576e0134d8b7aa7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e63089e15c6f4d19e77d2920d576e0134d8b7aa7.camel@kernel.org>

On Tue, Feb 18, 2025 at 08:08:42PM +0200, Jarkko Sakkinen wrote:
> On Tue, 2025-02-18 at 18:39 +0200, Jarkko Sakkinen wrote:
> > On Tue, 2025-02-18 at 18:35 +0200, Jarkko Sakkinen wrote:
> > > On Tue, 2025-02-18 at 08:08 -0800, Christoph Hellwig wrote:
> > > > On Sun, Feb 09, 2025 at 09:56:35PM +0100, Miguel Ojeda wrote:
> > > > > Hi all,
> > > > > 
> > > > > Given the discussions in the last days, I decided to publish
> > > > > this
> > > > > page
> > > > > with what our understanding is:
> > > > > 
> > > > >     https://rust-for-linux.com/rust-kernel-policy
> > > > > 
> > > > > I hope it helps to clarify things. I intend to keep it updated
> > > > > as
> > > > > needed.
> > > > 
> > > > I don't think having a web page in any form is useful.  If you
> > > > want
> > > > it
> > > > to be valid it has to be in the kernel tree and widely agreed on.
> > > 
> > > I'd emphasize here that MUST be in the kernel tree. Otherwise, it
> > > by
> > > the
> > > process can be safely ignored without a second thought.
> > > 
> > > Doing random pointless annoucements is LF thing, not korg thing ;-)
> > 
> > ... underlining that it would be also welcome take. But like that
> > the policy plain sucks tbh.
> 
> One take: Documentation/SubmittingRustPatches with things to take into
> consideration when submitting Rust patches.
> 

Hmm... anything particular makes Rust patches different that you want to
add in that document?

> "policy" is something is more appropriate word of choice to something
> like how to behave (e.g. CoC).
> 
> Here some pratical recipes on how to deal with Rust patches would bring
> the maximum amount of value.
> 
> E.g. here's one observation from DMA patches: there was no test payload.
> AFAIK that alone should lead into an automatic and non-opionated NAK. I
> know this because I thought "I'll help instead of debating and at least
> test the patches" only to realize that there is total zero callers.
> 

FWIW, usually Rust code has doc tests allowing you to run it with kunit,
see:

	https://docs.kernel.org/rust/testing.html	

, I took a look at the DMA patches, there is one doc test, but
unfortunately it's only a function definition, i.e. it won't run these
DMA bindings.

I agree that test payload should be provided, there must be something
mentioning this in Documentation/process/submitting-patches.rst already?

Regards,
Boqun

> Neither I could find a document which would explain to me why this is
> fine.
> 
> BR, Jarkko
> 

