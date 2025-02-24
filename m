Return-Path: <linux-kernel+bounces-530040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCA4A42E07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C3B175A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ACC245026;
	Mon, 24 Feb 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhyZvxnD"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D953BE;
	Mon, 24 Feb 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429471; cv=none; b=XS7T7FlPUeLXr92PH/rI7TDb9fU48uUSMYR3X/+J0/Hvc5hBGSuzCVg6jX+QE4qXzJejvNE0SrYqVttwfq83R/U9I0ph/1Z7ZrL0ZwCqXkIoX0p63nBeaS2r47ugm77vJxS7v4m/afCGKJIbCAsDbQF8DeEIIEOG6xr0uU6tD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429471; c=relaxed/simple;
	bh=CSaM3CTsdB8VvBBuF2udjUi2OuNHmqw4SUCPz7jaLFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN2dSfvbcaSHCGzBPhcI+1Iic9PNC/lzlh7f4ABGQ8feSovI1DTP6GoDfyWTHH8TvLgVT0LjjasTlrxHp3fS4sWBRXNSjMx0YeHKxH962NZxuxc2xXvTNqwJxJYD9T/zOPcBY1Br1Id2I7BmqcVWHwvu95alM6DFi4mU3T/SkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhyZvxnD; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0ba9825e9so308897085a.0;
        Mon, 24 Feb 2025 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740429468; x=1741034268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvTahac7VoN8UIfPPDTOy2XoASsmvBZhy0HRy4LhMqE=;
        b=jhyZvxnDQ55KXT1t9s4U+7Uw/2ITujjH/izFFV16moE4khHikdCgPL/gniFWExu730
         WNGaXT03BkALh2KX9rRij+tf6z7nSnZg7K6m2vW1CMuF+6ZYA6Ad1cyTGWoT/POf67jP
         C91b7/XNBMFJYaGRdQ/gw7/zg7LS/JbTrzNo5QbJo+vhysdnU16QRA9D8gJsNx+iHxJW
         WnQnuqsJ8BrNeWaTTj2fYTfbMiu1Reg6Egb8xxWOQHO7OyOfwpadDx0eJq5sZfeYDkDU
         lV0kUYUC3HV5wUG2+RrFWFEvIOWTjEg5xoT4f++QLs7at49JI9kwxDdBEVxGEuSiwPIZ
         B2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740429468; x=1741034268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvTahac7VoN8UIfPPDTOy2XoASsmvBZhy0HRy4LhMqE=;
        b=xGQYnLhJV2Asay9Fx7PKm8b/D7lE2lEIS4Pnh12GyGYMaylTyxU6/I1uB8rP+TFPjd
         ReqgTZe4IP95LPzMyKUNCqGJWf5l0cvpuh60f/gdVKd/HHaLy1klTtP0xmH0iQOg4NLD
         4OviCn53ICst3R1vberpUTiw6P7pAQFg8izz/aUXId/PeUAVMCY2ZtQB/fy2Lo4UKnxo
         kJPf1OumueQFTyD5k6UTL6i5G+SZ4oQwa6sr//qb/2TivxnBHslh8EqMKv3uN9NSl92Y
         4LUxy4COPNBU4f0X9nnd8H9FSb3OiASTml+G0J9vr4AbF94JjQZqCxql/fUxg+hEEHAk
         taxA==
X-Forwarded-Encrypted: i=1; AJvYcCUFck4hvIBdtY3O9CLLKhIqkj+yTC5bYuJrzLexHhWcdS4PJN2zMZsgawH80cU40uq2sjdAui5fP6k5B0LnPWg=@vger.kernel.org, AJvYcCX1pUUgxxsGYWxfxIRVwenI/OV98u/DV7aZHqJC6Y9SpIkypUO9Ou2KpuJAxl24XStY16x6qPN6n7FpjRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMUqGqwdjhCjBnv0Yr/1p8hBlwsn8STurHUyrDqitvOYuQeLK
	gGez3fWAZmNsnzO4G4VeajDKUe8yHKIVWgxt8fcWhWcy+PQW531h
X-Gm-Gg: ASbGncvTYjmmE19MvjYpNkR3ovmj4GhPxt8mPVoJblsWHocIgvRlNzxMg4aygepb44D
	JZ8lESVCoxowGbJRFNpXgrbkZpCUckW5b87GIsRoJ5jOxBlSTE+KLexg4EKyh7PzVSaTDu5KS4m
	QX45tdh3ASGHUdqhhIwIZgQeQwiBiiHUCErxwCj8LC16/XguP5qOYJsPAP0Nwb2iHcux4wPvb55
	zzWpgFz7vzkBpJ433pY7MlQbPvGZm8yc40d18IsKO8Gy9Tsexfho8Eq3KsA5gh39mujDH3iB+6e
	XLu2Jd4OMFsBhr2IBhf2NOGS6sgR4yzZ6tL7TdYeI4BU+nktRhmYuQhDehWYKLn+l/oQyc35H3J
	QELwcK7APQlJyPxC+
X-Google-Smtp-Source: AGHT+IFT4gDG2ylFYDoxJMqAedimzIeqWHVtIBuyFpPAl0k5SuiVG6BEh2+gKDUkXECGw8juLszw+g==
X-Received: by 2002:a05:620a:170f:b0:7c0:a5f4:4df with SMTP id af79cd13be357-7c0cef12528mr1893154985a.34.1740429468409;
        Mon, 24 Feb 2025 12:37:48 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c329852sm16364385a.72.2025.02.24.12.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:37:48 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9E1EF1200068;
	Mon, 24 Feb 2025 15:37:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Feb 2025 15:37:47 -0500
X-ME-Sender: <xms:m9i8Z3htkq1szULmKOCJ93b3ZDcZqF5GQYWy3ist86cWawfG9AyCwg>
    <xme:m9i8Z0CISLhmKQZwUJoNh5An7DQbWTzOxWW__l3ngPsdTmDO9zC8tI-fRBATHF7wO
    cwPFvt62hCGWM6I7A>
X-ME-Received: <xmr:m9i8Z3Hbq7NL8kTiKhzQmPEfo_tcPPwW_yXp6yW3Jvoj17jO84rclhBNWU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgvlhhiphgvrdgtohhnthhrvghrrghsse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprh
    gtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhhprges
    iiihthhorhdrtghomhdprhgtphhtthhopehkshhumhhmihhtsehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhish
    esghhmrghilhdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:m9i8Z0RhY3borjabk8JHmynQuNN9pOs47w3GYNM0zdqMjWzgx3cjQw>
    <xmx:m9i8Z0xGp5A9H-SE-jJX5OYR8HBG_lFTiI-LIBct7WSS8aMDWkznHw>
    <xmx:m9i8Z67SVxfeJlSqQCo90n5QFPATcX0yuhcXqX2at_2Lxus7QFGH2Q>
    <xmx:m9i8Z5yZsmZuS4_xuOcWgjQrM9QfxuKohipBko2pSxzAcnzIwfajBg>
    <xmx:m9i8Z0hcjhwwU-R2TUr3LvYVUDj1M_dYx0ehe_xwlVxVTUwXBqkPvWiz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 15:37:47 -0500 (EST)
Date: Mon, 24 Feb 2025 12:37:08 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: gregkh@linuxfoundation.org, airlied@gmail.com, hch@infradead.org,
	hpa@zytor.com, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Rust kernel policy
Message-ID: <Z7zYdEM5TkT2LNN1@boqun-archlinux>
References: <2025021954-flaccid-pucker-f7d9@gregkh>
 <20250221051909.37478-1-felipe.contreras@gmail.com>
 <Z7gQ3kSeCf7gY1i9@Mac.home>
 <CAMP44s1Ai5qMU4yV+Rwz4cY869ZA=cxBcTf2wuaUY1oyLKUNCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMP44s1Ai5qMU4yV+Rwz4cY869ZA=cxBcTf2wuaUY1oyLKUNCg@mail.gmail.com>

On Thu, Feb 20, 2025 at 11:59:10PM -0600, Felipe Contreras wrote:
> Boqun Feng wrote:
> >
> > On Thu, Feb 20, 2025 at 11:19:09PM -0600, Felipe Contreras wrote:
> > > Greg KH wrote:
> > > > But for new code / drivers, writing them in rust where these types of
> > > > bugs just can't happen (or happen much much less) is a win for all of
> > > > us, why wouldn't we do this?
> > >
> > > *If* they can be written in Rust in the first place. You are skipping that
> > > very important precondition.
> >
> > Hmm.. there are multiple old/new drivers (not a complete list) already
> > in Rust:
> 
> That is a black swan fallacy. Just because you've seen 4 white swans
> that doesn't mean all swans are white.
> 
> > , so is there still a question that drivers can be written in Rust?
> 
> I didn't say no driver can be written Rust, I questioned whether *all*
> drivers can be written in Rust.
> 

Huh? Your previous reply is:

"*If* they can be written in Rust in the first place. You are skipping
that very important precondition."

how does that imply you questioned whether *all* drivers can be written
in Rust.

Care to explain your logic?

Regards,
Boqun

> People are operating under that assumption, but it isn't necessarily true.
> 
> -- 
> Felipe Contreras

