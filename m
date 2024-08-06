Return-Path: <linux-kernel+bounces-276954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE48B949A55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938C2281F99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069B16BE12;
	Tue,  6 Aug 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PCiKPTjs"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EC165EFB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980529; cv=none; b=bdmjcR55L3WeifzSSzfyInWtJrR6SMt/1mzMqx++j7kM5BGte6YYHPhSR1/9nMZb2aVElGNxudgvr+kpfKZI4MtTKXtCJ/pAZCWsu0lb6pnA3QK2xS46GPFqQPO8Ic0gwawIlLCUyI7glAvNaqTjh/ObSFnEOw5Fu9gktkFOohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980529; c=relaxed/simple;
	bh=x8hKmdFcte6xbbtuts8TBe6YP7YbVl8gWjIJO8pyOj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOw0D5s8vFtOLBmygv8+Bit7MUaqwPb91ZQLY3OrsPcavDWbPF4iUmfsW5NSaXabNXDpP6a8OJ4tCc7ab0o3qW2+pntWnBRX3SefUMURfsfQGKDIOuXIAWgkxfTcjO2ETeJ0v37wqcYJGTST8ChDtUc9ysZxPQBFOAedKgZoH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PCiKPTjs; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfef5980a69so1230737276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722980527; x=1723585327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVQjWLqB66fYKaCIrflqq5caeB5n/0ckO14NfIS6Aq8=;
        b=PCiKPTjsZpvcb4ySqZ3WZwaSsHzVZr4SKOQw13qkCwYoxLMqcnBrgIjFLg4iZ/ZTZ0
         X9lnBRTUJoxKxKxHhJAsYhWlDvbcGq6mtagSDqlHNnxVgcry7hQT94xaGHaBCBa6R+5v
         K4LyJ3orgUyW/HBAKNeCj4fVMQXZ6SEDJPvnzwgZUnzwEs+7hF6XvEd/KAlwo+orAAwh
         pTtNjmJg9TD7Bucm25R9jZwMVlcJUTqDL3LljhsFdWLnTLc+GVbpU8Aceme2l1cIOdIC
         OaBLTqqYOEEWwe6RhZblyYpwbvPkL/pKqGX7SKMMCJva/6AOH56BScL8p8BySRHcqNKf
         tRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980527; x=1723585327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVQjWLqB66fYKaCIrflqq5caeB5n/0ckO14NfIS6Aq8=;
        b=WXOkjFBT/yk5thqQMG538Ij1iPBPIveplZI5wrnPun6re00Qxo+W3NMrVImcY2pFVQ
         R6UKQ2kW/jCS+Jgpc0iMvmDXnQgg70Flyx+DvgNAi8eUalOdu6d2HSsra6CVs7y0xmz7
         Bac7/hK27CrJQBSjdF5cEoX+4AHIrWHBuXD9u+j486Ay1ljmfMlcaOMbgYiNmb/ngxK5
         4uEY3FDF/YP5fW0Jiwh90NHcfPCSCGaDO9ihDpqwBx8pRr9kc0R7Ughxb0++7w9zxr68
         GyJLY4l6LOD1G3/qQwlqEiu42sugo6cKDBONZNNAXlGWNT0w+U8cDJFBgXB1weEphiSp
         vSSg==
X-Forwarded-Encrypted: i=1; AJvYcCW+F/iSNgATktlnXpCuePUpidU22J35gEAyTYkn9qpAz5z1ErwJVxHsTTBoNvFU6byVMMqohgOwhoLD7EvwWOtbxxR4E+RF3KRA4sY9
X-Gm-Message-State: AOJu0Yyb4t3ilPfxd5F+EpgRzti7L7aFASyztVWAhIDX+V8KWfK8xrwG
	yN8fKwyu5UCdsce+x5w1vb3EuOfad9H3GY7QGG49Gz63MQFDpox2YLFgSCKyVIw+slnEsdWRt+y
	zltzxueEbC1EhZql43qj83bNSyPQ5nnmQ7Z+Q
X-Google-Smtp-Source: AGHT+IG+9/7VWBB5PpVWhvYYIPTea6qwNkSlWTZZreNcQMevNf7WKGF/Eat7QmV8VkqbA7ptWhDvWwvxB53ZqfhsRWY=
X-Received: by 2002:a05:6902:110c:b0:e0b:edef:3e10 with SMTP id
 3f1490d57ef6-e0bedef410fmr12694184276.55.1722980526979; Tue, 06 Aug 2024
 14:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com> <20240806022002.GA1570554@thelio-3990X>
In-Reply-To: <20240806022002.GA1570554@thelio-3990X>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 17:41:56 -0400
Message-ID: <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Nathan Chancellor <nathan@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 10:20=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
> On Tue, Aug 06, 2024 at 01:29:37AM +0200, KP Singh wrote:
> > On Mon, Aug 5, 2024 at 9:58=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> > > >
> > > > With LSMs using static calls, early_lsm_init needs to wait for setu=
p_arch
> > > > for architecture specific functionality which includes jump tables =
and
> > > > static calls to be initialized.
> > > >
> > > > This only affects "early LSMs" i.e. only lockdown when
> > > > CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.
> > > >
> > > > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with sta=
tic calls")
> > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > > ---
> > > >  init/main.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Considering the problems we've had, I'd like to hear more about how
> ...
> > I guess it would not harm Boris, Nathan and others to look at it as
> > well and see if it breaks any of their tests.
>
> For what it's worth, I have not noticed any issues in my -next testing
> with this patch applied but I only build architectures that build with
> LLVM due to the nature of my work. If exposure to more architectures is
> desirable, perhaps Guenter Roeck would not mind testing it with his
> matrix?

Thanks Nathan.

I think the additional testing would be great, KP can you please work
with Guenter to set this up?

--=20
paul-moore.com

