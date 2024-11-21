Return-Path: <linux-kernel+bounces-417392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D289D5368
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB681F22EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7281BD9F3;
	Thu, 21 Nov 2024 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LHNJn3kg"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708C19D8BC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732217050; cv=none; b=MA+NXrRMu66RQBgJ3yRGqg+3ptxQB6RWNBsRDZ5PXBjedqyfKWa7PgfnjCWFwcA7UzCZpWJDFz4YBMOV+rTbPJZrpr5hDZQhBdUVvyyoUEHKAQ8SZYZaqDGvhHW3fh31wSU61roryMyYyYa+7pVWU9Xzoup/si0vrAgJ3xgczrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732217050; c=relaxed/simple;
	bh=Xg1fgeBbAsDK6Y/CLnzO4RgQDMB76MFCtSM/vCs4ERk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caVTOzBTzneMpft0jyrsTbDW5yWKFzjoGGHtQ1m+UPp7oz0026pOORlEE02U7pUuZVLoLUvpQuPqggQhkococ6BR4s8mfVDScxoBFuM/q2olC36uuwRKQzvA1Nkgf8E3Tq1JQRS4egi8cEA01YlCrKLWeYj5m0nKylq3t9950NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LHNJn3kg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfabc686c8so1614306a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732217046; x=1732821846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=39w/ZSjOangyNUJkD3wOqGR3yOOmw3l3G4u/GX0sCFI=;
        b=LHNJn3kgcvJrsyitGdvlbBHPjh6/X2ntSxXtmcB4WFF/NOOlaST7GgSyip7IbXj7qb
         uw4n+FjC0LsOaKVtwzSB5PE6wVNoUCdwwmTcUK9kUusy2QwBPqjz0PSbkdcwQuY3dckW
         aR06emiryWnSrny9Rb4PhoqNWmedH8v1hSixM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732217046; x=1732821846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39w/ZSjOangyNUJkD3wOqGR3yOOmw3l3G4u/GX0sCFI=;
        b=jLdqfq/VEUbgMtoWGtFPIvalijg4aXLyysDYvQHCdAYwoFZEs4zqahN6gp59ZeUPUo
         yBlwlExZGWUL5FboD0fu4Tbon0B9++Wycmiv0w59F1jwnsh+K0wL7usoV2cd7xVVKKOw
         7iRsustuFtogPHbcvsSVqh9kLRz52niQJ9ptNQ3aIRrl87LUYYOxxhhwejhgHPdo1hTq
         BxUvNEAYFkwsAyllAqV+SjAEKq9QdvOXyB8O7pMB6bNaFas+/MsUrDDaEaZMtRcVAUuq
         tMpFiiQ9zkN/Di81jm92FRGOh/Fl8SYTeZ9Bd2/lqVA7qi0zSSNYjV6MO8n/4tSomU+x
         4fJg==
X-Forwarded-Encrypted: i=1; AJvYcCWNWEz53NzhxIj7bpLfqnu577IW3QO7/BRjeiL1jeCaC60F8dEtBSiH7Ix+ILyZNWBD/NcE+3huwfXsEC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3qzcIqnWT4sVdQkeIRUiOgLEGkCchVHnb1lq4Hp9b2VLmEhg
	cyRPDJvUDnFLP3T+8gaxtrP2Mmjh9Vi0eW/uBQNpidtK4sz9E6Axvqb3BJz2azSvrFXivn6khcH
	IMGA=
X-Gm-Gg: ASbGncvPk/SL716JEE/3Bvc/yAJ3B6TWT1CxTGmNw9fkkjBxEfk8Oqxm7GYKAggXdOp
	jpBPCoPTMc08Qi8mNA9pNta9AfyiZnWq855HzeIqhEmYRjF5/1v3/EaaqvTpldeXCaRq3QhxAIc
	2S1BGEu+VW8DZKSk71SOjuArFEDhykomVzurTwsdYfGfeLF9tJllMOplJjIN2L6b/Qb89pMz++8
	fgj35LJYUOmLW3tHtFdUvg8I1nYtdUtK92/V/ZOiHmIXFN/Q8xj+h32AusO7c79cuZB/ax7QhOf
	EQyC03Wjv5lhpLHhnDio8PlF
X-Google-Smtp-Source: AGHT+IHJE1IsXyudoByz8PdkYv1j5c75N9e6qwY0QIEn7oAnMY94sKDQFNzaGJPQT5APhTNPLb9gwg==
X-Received: by 2002:a50:ee02:0:b0:5cd:5494:848a with SMTP id 4fb4d7f45d1cf-5cff4ce4d78mr5039406a12.33.1732217046384;
        Thu, 21 Nov 2024 11:24:06 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d41af02sm96756a12.87.2024.11.21.11.24.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 11:24:05 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so197815266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:24:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVc3AeZcmhd2cwj0c0O0hBGyYJ8fqHoJOymXHPLpMe0lffkpMTthNThpXkjm/Dl5KWVUQMZU3EMfdYzea4=@vger.kernel.org
X-Received: by 2002:a17:906:9d2:b0:a99:4261:e9f7 with SMTP id
 a640c23a62f3a-aa509d3bad2mr24129066b.39.1732217043149; Thu, 21 Nov 2024
 11:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org> <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl> <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
 <Zz91LyHzxxOLEma_@kawka3.in.waw.pl> <CAHk-=whv4q-RBXmc9G7NZ4GiATqE_ORU05f=9g00HkQXbV7vqw@mail.gmail.com>
 <202411211011.C2E3ABEAB@keescook>
In-Reply-To: <202411211011.C2E3ABEAB@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2024 11:23:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfX4dvvKo8PrPZj76Z2ULMMK2RvaF+O7QhLnwOSBYdhQ@mail.gmail.com>
Message-ID: <CAHk-=wgfX4dvvKo8PrPZj76Z2ULMMK2RvaF+O7QhLnwOSBYdhQ@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Nir Lichtman <nir@lichtman.org>, syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 10:50, Kees Cook <kees@kernel.org> wrote:
>
> The only flip side I can see is that "ps" etc, should just never use comm
> at all, and instead use argv[0] from cmdline

Gods people, what are you all on about?

THIS IS WHAT PS ALREADY DOES.

Stop this completely inane discussion. It's literally like you don't
even know what you are talking about.

For user space, comm[] is basically the fallback for when cmdline
fails for some reason (for example, /proc/*/cmdline will be empty for
kworkers, but there are other situations too)

The reason? comm[] has *always* been much too limited for 'ps' output. ALWAYS.

Yes, you can literally *force* ps to not do that (eg "ps -eo comm")
but if you do that, you get the very limited comm[] output that nobody
has ever wanted ps to give exactly because it's so limited.

People who want 'argv[0]' will typically want argv[1] etc too, because
argv[0] simply IS NOT SPECIAL.

And yes, 'top' will give comm[] output because it's so much faster.

I'm done with this discussion that apparently was brought on by people
not knowing what the hell they were doing.

                Linus

