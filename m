Return-Path: <linux-kernel+bounces-425274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CC69DBFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79767B21B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741AD157A5A;
	Fri, 29 Nov 2024 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLcqb/4J"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70261156F20
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732865123; cv=none; b=XrRFW3INDnFu3Xy8KgqJBPAKdTAbO3YTmq7dGnwx0i7iOwjhzVdNgOFW4KSVzCFwqpWofioriBeStSH/rhTHxdHOktR8XZy4QIeLwjqMGMye/KKO//59rzxxH+Sda2K+WcDI7VTA5R8gcCBMNwd6fBik4VBxUBapwu7wKRd53Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732865123; c=relaxed/simple;
	bh=DMKRKhr6+Yn0lq+Lqu+jB8XUqvQdWtjLtv3wMe9m3+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGq9JqOiN/DBk4Q3QKiZdP/kiuRR2cNUzPXvqOhN7N6smfgbPUq/KAd1qlgKdSiT4g4FtI9bIdukZ4RtxL9GGUShcYStdKADqxhPn8WcwIkSbElCZGCrEj4lk7/ZIegKkBibU9d3hgXekmBzM3CmdnQTbxV5a588GDuSud6/RNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLcqb/4J; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-843e3b49501so46269739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 23:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732865121; x=1733469921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMKRKhr6+Yn0lq+Lqu+jB8XUqvQdWtjLtv3wMe9m3+4=;
        b=LLcqb/4JMjI+ZVG+tgLpDw211p5+/3gGMsdCpa0XOvtOwUNHEF1WCuzHJf+aZqv7Uf
         SuVFenPjt9JWJXzXtX2kf532NKVq0GYisKwB304F1rHxbhW5jdTC0cK1lx3u9aTiy8i0
         +8RdFRbscwWlZ7ty12oFw791+1QKed+BjUh+u50hRexaVjSeJgRPHo23YUnTW9g5UmgZ
         +OEhXtuSMtlsXBptgQUCDDQImAF32AKksKtNJkJctA4rrn0vkkU5Gr14G6dkS7fjuGtM
         Wno0Pidd+ziI9JbL/9gCQiPAEktpZdPRweHSAOmidJLDf5KNaAcafzM9hbiO5gAI/puX
         jnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732865121; x=1733469921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMKRKhr6+Yn0lq+Lqu+jB8XUqvQdWtjLtv3wMe9m3+4=;
        b=TJYqqhFhG87czVz0yb+frW9sg73LGZFfsorZ8WPuTrieaSLz4A3QGqMeH0CdDw32pk
         BeSrl5jluK6KQcAgeEHyah48tuP1jmlkINMhXTHsYUIe6H4HzdSw8Pjsk3WvvHJrH46H
         OPBHyNP01djrVIk5606ox27iKsQI4Uz21oprIMVEL9rWSseA+9FlVBQ2a/FqdA8y4OGf
         t5gqjZk4gP9hgtXmTwJSkdMtZWUCLmnMg75BhEKZTBQ4/f+fncZtcrH83ADTzdiX0L1l
         vzqvzuv7AyjXpuE5j8TsjZAMMXQU4qQ/DEJb3+mpjV3wWM8xzkVq5gK8wlJD9iQZzc7I
         6o6w==
X-Gm-Message-State: AOJu0YzpEewX/IUmaeSoWlrguaEBOA3MALFRQr/+kOyX/8m59o/TuWLH
	/pfQZQvuBL6iH+QvcboLZhW5EICtNlZZwVlUwIb1vhq4yjRg9tmB0RpDbpbrukKtPWSgVhXI+4g
	pkeBqemd3Ze3ojz532l5BNzwOXABfHN1lXGs=
X-Gm-Gg: ASbGnct/UFnYans4hSUDVJUX6qn/Ye4w5YQzGKsAvpezz+PwTc30W+jSNU1PE923hEv
	p6U2c3pCycUmLHCiKw9/KBdUJ7pOxkV8woaMTt6zuDiKF0BHkJtOpA1THENo46+XiOA==
X-Google-Smtp-Source: AGHT+IHB4Ao+9tjqZHc13AUmssP8UuJH9YDbuuzpD9KXoT7DqZ0wNMzbNFX6WElZFMnFrIDhandZgl4JM8OEJhv5tqA=
X-Received: by 2002:a05:6602:27c4:b0:841:a73b:a978 with SMTP id
 ca18e2360f4ac-843ed034293mr1228105739f.7.1732865121461; Thu, 28 Nov 2024
 23:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
 <enqsr7otef2osf5kmxwlf56y2jegiggiusbzklqxmkd4puk3rq@tarta.nabijaczleweli.xyz>
In-Reply-To: <enqsr7otef2osf5kmxwlf56y2jegiggiusbzklqxmkd4puk3rq@tarta.nabijaczleweli.xyz>
From: Rui Ueyama <rui314@gmail.com>
Date: Fri, 29 Nov 2024 16:25:09 +0900
Message-ID: <CACKH++aCPZEwMwreYS7492qabmcj14NWbv9QE6Tp=WN09kE=1w@mail.gmail.com>
Subject: Re: Wislist for Linux from the mold linker's POV
To: =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 4:17=E2=80=AFPM =D0=BD=D0=B0=D0=B1 <nabijaczleweli@=
nabijaczleweli.xyz> wrote:
>
> Hi! one quick q to clarify, if you don't mind.
>
> On Thu, Nov 28, 2024 at 11:52:35AM +0900, Rui Ueyama wrote:
> > - exit(2) takes a few hundred milliseconds for a large process
> >
> > I believe this is because mold mmaps all input files and an output
> > file, and clearing/flushing memory-mapped data is fairly expensive.
> >
> > To avoid this overhead, mold currently forks a child process, lets the
> > child handle the actual linking task, and then, as soon as the child
> > closes the output file, the parent exits (which takes no time since
> > the parent is lightweight). Since the child is not an interactive
> > process, it can afford to take its time for exit. While this works, I
> > would prefer to avoid it if possible, as it is somewhat a hacky
> > workaround.
> Sooo am I reading it right that the output file is not valid when mold ex=
its,
> since you seem to be exiting /during/ exit->munmap->msync,
> while the contents of the file are undefined,
> so mold -o whatever && ./whatever is not valid
> (while mold -o whatever then ./whatever later is)?

No worries. The child mold process unmaps and closes an output file
before notifying the parent mold process of completion. Therefore, the
output file is guaranteed to be complete and valid when the parent
exits.

