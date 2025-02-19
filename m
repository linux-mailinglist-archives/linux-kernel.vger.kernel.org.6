Return-Path: <linux-kernel+bounces-522089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64636A3C5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B007177C37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4393121422B;
	Wed, 19 Feb 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPo9C13g"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553941DF25E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985054; cv=none; b=eicz4BktrRgYd9eIBDgGxlZYAtgg45FEHe6gnw3/OUDejjQ1+e86bXdGNUJDFhgw+j9jgxrQcBVOYsdDGJM9qHseJQHAVvRsQthbZiGnFtleLt/Z60+2EAqmt9jfA1uNIBuuxhnMAZRke+Ne75Vk587FyWze55krEBVmMly4q5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985054; c=relaxed/simple;
	bh=A9SVroBVZKdJKV7Sm3Iz9qfLk3V4QQaCU3wwaG+a1bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kb+I7Bh0xvt+jpvi3bBDYMAkD5PAOl5nrqg5Je19e8b8HJdQZGlLBcPXEfmOXpAYE6Ck6FDGTs3GBOFV7qJrNAqp8KE/F77ibSHJLmWKDuu02j/FcIN7sxYL08qQcQ3/oCluKAvHKDoTqz1wphmdRTKu2/0ynDH5yUc0zULIMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPo9C13g; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fcc940bb14so18033a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739985052; x=1740589852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO/JREwfLPhGFs+lXpFct3A6gt+bq2saWFNYBOZXon4=;
        b=HPo9C13grZlkk8WZhBXZXjWwIM8XdFiXkP+K5U/EPAVnos8A5elYuLcllBwU2a1xcz
         EhPPcg/NRURF+M3F8RkxKV85vDdr9R5JtE9LsFWXa1/Y+/cRdY4NzX2ugaBuCCJNidXo
         miM6pu6MObDgB44DjYbwBNbn5bmsfa/1mv04aBVo7MF83jsn53L12fsa4Cez3FGbwqvQ
         pbLT10sXH8j3VfhyjypyybgnSmsX6jLwbeW3TVvE4Dj5JZSVr38yXaTKHF2/i26uSr0l
         iMPKheJet5ztQikaZOTYBi0GQA7GQ7PNb+otjlBW8tyZHrji9xOkkMbjlKyPO4HDvdDJ
         O33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739985052; x=1740589852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BO/JREwfLPhGFs+lXpFct3A6gt+bq2saWFNYBOZXon4=;
        b=H2x9x7V4eVFG3T/STZ8O9uXaNFR3jrfpPOR47yjBq2SRAsrZrUA6R8UpHqyZwjFOTN
         gtPyxSpM95FMwVRK4K+h/hvWIyuIF9N3AUc8J5mQbIROHIxCfki6p2EDsU/aoEhJxr6p
         g8zYY2YbLlPq9GTbYNDoGz+pReVDD5VU4vZavwC+3/JNQMurtfTEWMpQkHq4eG3g7APs
         SqjpqxclyDiD5mLhhWG7fBNo0P8Ip8fbgnrzPq2RHtzW2CYmbVlmVNK/h0tcXiTECpfn
         xbpJSRMARNBJXWtY7jyXejB1OXIl7MQ4r1XhjabIg0x0SscJfC20RpgzHQMuXCvO+HUe
         exFA==
X-Forwarded-Encrypted: i=1; AJvYcCVSVc6eb5xJVV8gmmIVLE6P/MxvOkF1jZPrb1+NFRkTWSZgjpIyVpYIB4r6XTQiZxSzF+fr05ehMdh6lVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNY4ryK2gnOtSwLfJgi5743IzKZVYPMf+Vdw0Mm4tSjnsPlaxy
	qSBj123vl4YLG/Cu+gUZCIjMHLh6BDdyS8OiNQGYANEFhh2Lu6khv6UVLL9dmfeMXtaNM4eVzI7
	E1+OgImXkOF1oWiHDJjjraRmto7Y=
X-Gm-Gg: ASbGncs7g11VLNlG4HPlMasGmZN/mnL3o9cHpkmctyax9WsnF0mUyBa4VY4zctdGuwZ
	uHcrIQI7qwWQ2IHXU/vIJjm8mRl31+v8bRzcDqABFYaXPG54FX0pIqg0ophikIcY0cBsI8QlFeN
	hmHWuMUyTsfuruTdiL6TLWnwuRgI0Exg==
X-Google-Smtp-Source: AGHT+IFe/oTfY0X5/lo2gWknRepOi06/rCNUPYrTRXXN6GQ2c1vkJplxeF+wgaowlpxEyT+tqI8m70nX8GSHPgHDRCo=
X-Received: by 2002:a17:90a:fa0a:b0:2fa:1f1b:3db9 with SMTP id
 98e67ed59e1d1-2fc41045393mr23468139a91.26.1739985052542; Wed, 19 Feb 2025
 09:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219114759.20110-2-thorsten.blum@linux.dev>
In-Reply-To: <20250219114759.20110-2-thorsten.blum@linux.dev>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 19 Feb 2025 09:10:38 -0800
X-Gm-Features: AWEUYZnR82iEHGbt9m4cHYSuZC6RPB7dhsyYUmQzpLHP3kMfOpKmjgh1snM1iz4
Message-ID: <CAMo8BfKfSPtr4kj+M8WRJazcZvXT0o-FJVt0ouKrY+hufGLHvQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: ptrace: Remove zero-length alignment array
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Oleg Nesterov <oleg@redhat.com>, Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:50=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Use a compiler attribute to align the areg field to 16 bytes instead of
> using a zero-length alignment array.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/xtensa/include/asm/ptrace.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Thanks. Applied to my xtensa tree.

-- Max

