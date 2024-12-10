Return-Path: <linux-kernel+bounces-439941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198179EB685
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DB82834C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7145B1BDA97;
	Tue, 10 Dec 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oK4bkqyY"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702CF1AA1D2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848448; cv=none; b=N1s25QCzF+Z7hERhjIdPuZ2zZeZ7owR3mpL81vqiwQ/xLkaxrWRFYJXXyLpqB7jNIXSxN2YgSkqTtygFqr1EPYpcbaeceBADi0XwLt/C1sVn1S/VkrGn0KKqm+1sq+gEZzsr5RmyGL39eJEd14p+giZty2k1MdoUgoatOu1dmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848448; c=relaxed/simple;
	bh=sQnuwRWxUOnAEtZKfyXTWmf+zCpmwdFu1sUDT1TVN9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICMYZtmk+gI153rDD2CQdxWf/xWAraCFnDYrMz39dmAgwdV1M1sd3K+S7BxtrPUSyKj2NOyV2+ELtSPcx1e4rpQksogJHE52iaBnZDTAhjJTc3LEJtcGTwnVjF7ybn8gn6+js891xGAo/BBmagTLDbztN/BnuJDG/UXel14fYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oK4bkqyY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21634338cfdso35673545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733848447; x=1734453247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MM7mkfPX/z4yVilBxiJBcCR4eR91hwy3WY2ezGvB4AQ=;
        b=oK4bkqyYuWDw1fTocixksaNeP2BqJ0mjQRSRCe6bwXylBVlXbZbfFn7xNeIxkSMo0S
         oN2svEUItYgEjNsnGot1m/BblPZOsy2DzhPfamRRgqPyAKjzFzegQJXrM/ZHB8zBO1M7
         dcYL7ClVS132tmMz3kxnv9yUKz7c0hcmssFHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848447; x=1734453247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MM7mkfPX/z4yVilBxiJBcCR4eR91hwy3WY2ezGvB4AQ=;
        b=dZPVE8Vb7jPypLMui6aW2m5CNu3ZxXIjhit8Vm0pieAK/zhc7AWFNa5IPgwi0dBKLe
         z5KYzHgSihlzYPrX02j/uowroLrE/7l15O73QeYGQH9zvtThRPPKLO6tKUxREn8B0RyQ
         ESu1K6umw4H0PI7i8QqKRd1CEK/A3O/jIs5wovv7S4B1PklVw0F+sneI9q3LekDFC9F+
         Anh5JiAQneAZPGl4EQY+HXRi9SoFgoH+fGo363s9O/+8+QZFmIBDu4kSDuNqZ2mWB+nd
         Xfsz6UHXsocNmVAhnt+nuqkmOmF2/W8hhHHyQOaIZSemjnxz6gKaCVFQvnDTWFbdh+0S
         9FAA==
X-Forwarded-Encrypted: i=1; AJvYcCXKlcrJERm4GYEQp0RjY21AubuMsjNbto4wXyFbMDFnGnJ2r3+SaU0eAIueGQjnGHoHlDgRI6llY8K3RVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLadHYXqynVAknYPRwbFQIELGuSBz7FH4tTQS1S4vBiZ9NZsS
	CJgNiFhi3Bv0eJNJicMMqWsT6XgTMpSoE88DQhrKRPbseR15bCCsB2vMEXnDf3I=
X-Gm-Gg: ASbGncs9PTij0nk+LMf1iaZXqF8knBeFEeXtXZYO6BzuS6npX2C8T/0IyyLrQnZNZA+
	Oy/6SYtaAil0DV/9p1tIh/NBLgl4ezdYZWgaB7CNa0FhnqN/pzc8hAiEw9Tjo21rxZQY/buh2yD
	bj7EpeuyVe4WdUiz/7OxpYb8qlApaq5dR5VM7pyxoCVYOJq8CRFYy8SIKSlqjYMLYzGR8xzBBmH
	xZ4/mzzghrx3XvL4ssjwPUtVEI7eIVzDzKOjWI2u48CXBMrBqmVjR6Med4I+J2MDtz13f80+fk+
	riwWEnp2q4A04ILf2YIm
X-Google-Smtp-Source: AGHT+IHN9nygNnSTRx/qg058XotfWs2WH/nks8UlZLQYwvpdFiCk0KpSOEKf5NuVrm6lqzjl4PvC4Q==
X-Received: by 2002:a17:902:c948:b0:216:66d2:f190 with SMTP id d9443c01a7336-2166a0bc824mr71072565ad.55.1733848446802;
        Tue, 10 Dec 2024 08:34:06 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21628c448c4sm61023095ad.23.2024.12.10.08.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:34:06 -0800 (PST)
Date: Tue, 10 Dec 2024 08:34:03 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] tools: ynl: add main install target
Message-ID: <Z1hte2LnnPdC6DMm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jan Stancek <jstancek@redhat.com>, donald.hunter@gmail.com,
	kuba@kernel.org, stfomichev@gmail.com, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1733755068.git.jstancek@redhat.com>
 <59e64ba52e7fb7d15248419682433ec5a732650b.1733755068.git.jstancek@redhat.com>
 <Z1dhiJpyoXTlw5s9@LQ3V64L9R2>
 <CAASaF6wVb=c2mYJDqSdjbGD2hQ9CdbxmEKopVoT3Aniy+xRJ+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAASaF6wVb=c2mYJDqSdjbGD2hQ9CdbxmEKopVoT3Aniy+xRJ+g@mail.gmail.com>

On Tue, Dec 10, 2024 at 02:56:05PM +0100, Jan Stancek wrote:
> On Mon, Dec 9, 2024 at 10:30 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Mon, Dec 09, 2024 at 03:47:17PM +0100, Jan Stancek wrote:
> > > This will install C library, specs, rsts and pyynl. The initial
> > > structure is:
> > >
> > >       $ mkdir /tmp/myroot
> > >       $ make DESTDIR=/tmp/myroot install
> > >
> > >       /usr
> > >       /usr/lib64
> > >       /usr/lib64/libynl.a
> >
> > This is super useful thanks for doing this work. I could be missing
> > something, but it looks like the install target does not install the
> > generated C headers that user code can include at build time.
> >
> > Am I reading that right? Is that intentional? I was thinking that it
> > would be really useful to have the headers installed, too.
> 
> It's not intentional, just noone asked for it yet. We can add those.
> Would /usr/include/ynl/ work? Or do you/others have a different suggestion?

/usr/include/ynl sounds good to me, but happy to see if other folks
have suggestions.

Thanks for being open to adding this; it'll make developing user
apps with libynl much easier.

