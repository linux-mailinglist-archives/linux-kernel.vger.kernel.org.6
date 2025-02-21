Return-Path: <linux-kernel+bounces-525255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC589A3ED22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A46C189DA2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79F35979;
	Fri, 21 Feb 2025 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCHsm1xb"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A4F1FBC83;
	Fri, 21 Feb 2025 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740121511; cv=none; b=ji7owNb1cp/ji1Lk51QVojjieqeFObUIwjT/E5K/oGAGFDGqvHoz4bAXN2jsr9nbtYFcbY6q+MfXktNlyZ//1NPe8Xa5UdnCJGBsYyWdo0vS7xnZDZUNLwWIlTbepg1KizcBleGlnihTVxoibCEfjh3OTRT+GAJ8N442mwZFfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740121511; c=relaxed/simple;
	bh=sl7zCBDomJhdG0gnHNMB5kkyU6PcHulXkuYhL3ng/6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fhr7CMiQYHKV5Bbdhr/27NzRWtidrTsax3l8C0Bk5yqrHASUIHW2EG6EOE5o4iWQiVTVTslWuOq0IcugJLD5wCMQkXy38ZR6RvBZyKbFNIDFDs+OKFyL0BikCrf/SCORJU9GUb+TL7vZDJXhjlfbY0qEyfceLnryNWQZNHCb5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCHsm1xb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaecf50578eso348240666b.2;
        Thu, 20 Feb 2025 23:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740121508; x=1740726308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sl7zCBDomJhdG0gnHNMB5kkyU6PcHulXkuYhL3ng/6w=;
        b=mCHsm1xbFl7o/vrdwxNupzDTxd6+DqrrpncWd7uEKldHQGXFO5zBFZ94sB2jR9hYD2
         CDBwbJi7q6oVikIt0A9EUXiLPlnF//mi5LM+b4by7BfHvqop8PlFx9nVb5M4ouxncNoa
         VIA4327WymWtBzNz4v9Fd8TGy2wbRzZSFrrQfaQh6OEJDDcpQOxdlInG867kqckHrhCn
         FCWEgHsOQQCGqHaSvCjPd2Er3MlRMuV+OHXyM6vSoWQO+7qDns3mvRhu9H0XP86GTYW2
         GQ1ZZ0Ah/sGeMWkFMQE8WfyvACfqVU1tgPnU+Niuxans/UoHywnvQmrkv5xE4NeNwPe2
         6jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740121508; x=1740726308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sl7zCBDomJhdG0gnHNMB5kkyU6PcHulXkuYhL3ng/6w=;
        b=Lsph4jlAUbUihyWOn+vII8steH8hVYA3SZHwW9h6gRxK5d9km5VsfzKMIlBCEZwRyy
         99vg3f+AK7DZXuNTsxKPbhF/gGKhZMNi2P+wh2KyWPiwIAbYooupLKCiLk/AfyNLEHJP
         vHWeQNRMQCAK/8GwztgHfm/+em7+AVIA89Yui+DRkvL07j7Gb2jbtZUo+z31QNZJMnpl
         wdNLKr4xAwOMI9HQB1NoX7JcjK520eqgLqEMJlye7ALmhmD7GtvcT9ndQIFnW//HJYq4
         zl8nrr1EnLE+p06K/XrTREKMfBleTya9Dg9EnoTp1FNWXjYo3G3bIyKPVBDAqn/XwgRx
         +K1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwes9sxJwZbSdXJ6E6+3qHhILUIEpwTeMc6YWxGZqgVR80KMcoo8kIDLQE/m5PuspiaTuMZwMYkErWp6NjNP0=@vger.kernel.org, AJvYcCX0lgwI2mY4V2rRgPnccsnDhxsEbH9R+i/WT+PF6sThhhl27gPwKk9c3ySqem3pJ4tckK7gCkec+1T9bUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwpbCtUGW52eeJ8mvtrZD3JTQqa9vduEu9gsTJOElBXBqwQTAm
	Fjrz3arwO+g8DnTWENPEoBXv/23RYTQh70z6VyKmvUAlNOlhCqtf9fsXSDAsluy2EsXnmLNj2lP
	4kS3zxRHc6SNfkEeSvlQb9yq56qk=
X-Gm-Gg: ASbGncvx8rpIqAJWmIU6GOBRHCKl8u7+qW8S1BNQ6pWZDF5NKFIYGSiPVOzZxzZ0PF6
	BviagxZJuFb/gAaavFVIesN07M4c5GYkxhj17j4pG7tV0O8UAiSyJD9HSpfpcvOBf/CKpYj+l0Z
	ymcv/CtA==
X-Google-Smtp-Source: AGHT+IHOQbo+TvMcu4+X/+LIeByPRKMQIlrYI0AV8qGp1AuzuqpbQz1twMeHfEV8p9x5EVqT5UvJoJGtCx8O1rMKfvg=
X-Received: by 2002:a17:907:1c28:b0:ab7:462f:647f with SMTP id
 a640c23a62f3a-abc0da36418mr148564466b.25.1740121507765; Thu, 20 Feb 2025
 23:05:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025021954-flaccid-pucker-f7d9@gregkh> <20250221051909.37478-1-felipe.contreras@gmail.com>
 <Z7gQ3kSeCf7gY1i9@Mac.home> <CAMP44s1Ai5qMU4yV+Rwz4cY869ZA=cxBcTf2wuaUY1oyLKUNCg@mail.gmail.com>
In-Reply-To: <CAMP44s1Ai5qMU4yV+Rwz4cY869ZA=cxBcTf2wuaUY1oyLKUNCg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 21 Feb 2025 17:04:55 +1000
X-Gm-Features: AWEUYZkbvphXlwFSnn15e6k57DAgnH-HQV5ZI0ER8aN1n4x5jMTuqqoaJo3XkBs
Message-ID: <CAPM=9ty9KWFE+AkHi5FDrb8=O5bzbVEroT2fx7jLG5JK6HZ+tg@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, gregkh@linuxfoundation.org, hch@infradead.org, 
	hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 15:59, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
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
> People are operating under that assumption, but it isn't necessarily true.

That doesn't make sense, like you could make a statement that not all
drivers could be written in C, but it would be trash, so why do you
think rust is different?

if you said 100% safe rust I'd agree, but that isn't the goal.

Dave.

