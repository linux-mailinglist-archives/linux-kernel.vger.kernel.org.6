Return-Path: <linux-kernel+bounces-177828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29058C4512
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6F71C21B33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBED1553A3;
	Mon, 13 May 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FNZ1pN5h"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C81155382
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617666; cv=none; b=hk1xXQE1Gcd8EF5+xpCwugyZUH6JTfWaq6G/vFmsf/F1IUWzMTidUxtJR9ihAR4yjuWcrJhFLx/poDI1kxMtjQqXkE5HKV1ucBUZqKB/3tODrwMoyfJeGZWUNpXCZZ2vZj79z8aEKZVgNZWbUiN0qHOrkxYyiBp7gdQXlCSBXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617666; c=relaxed/simple;
	bh=indKPqo7wgjPODxZ3n6dtvDts7VXZJSCW/Fui71Wi8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQvhbY4XERf/6yGmhJJc4Sh49GNGTHedxudq23vKHsi71Hyx10olW/ClN6JfJIqiLjSHQ0JH86u5IoWwtXtiKLEQ/tb2MZUtlyWj9wNYHR7/Jb0Kr/T1o46tKzGeKpVfENsV7ifit/r6PxVi24dsiBK7vD0keX8uBiblXgVW9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FNZ1pN5h; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a934ad50so1082456966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715617662; x=1716222462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AW+bcvxmWZZxt4c3Dh0r2wINUf+borweQyDfSngaYos=;
        b=FNZ1pN5hNtC7xzOiicOPSaFeez0mu9wjN1ksyFhRVxok5UaO3DYJ2n7/5fsUqKHxHE
         CTr7LpRdjBTJXII+YDLyeHzxYOla8U6oP0Cd7f98aGfT2wp37Ieep0E4evp2MDGjGlmX
         PEJND0QbpR9xQlPvs763oesM2bbAQRAKZ2jIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617662; x=1716222462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AW+bcvxmWZZxt4c3Dh0r2wINUf+borweQyDfSngaYos=;
        b=SUl/ykSPR4kLJoMuBACISCOK4BL76/1sjyAwqGIZvGosN1iJpIw3yta4zOhmKLmMtx
         igJ2nHv5H6RE4c2DIzSecBMFfu+WQn5tJMyR9k2cS8hUXuMAiXj/j7quHZzj8t9UKgAk
         pdW48ZKAZKIRwlaohOglGcbH7y1jaPwG/3yXiQWmG1wjxCOunYAIngSwfdGtX+x+Ixff
         m25uz/HLtc/0zAsPGjIP4sc1VxKe4z1cH9tUNHcPh2ONZjdsJvgUVIH8EftVlqPw9r3e
         czNXBkqqu0qmIsFQjhwRGkVlpQ3s9uL4SmReT+oqnTS+oS6laadzyyNmXSCvjjnn89gy
         JQYQ==
X-Gm-Message-State: AOJu0Yxauep1JRs7ben07Jo7FsIQPKz8+79KHAdBWoXtrldni2afnFo9
	dRd78t7/5nJOUqL/IFcwjMANySLf+A+KpdALz9I3PPLsE5ijDUhQuTsM+3p94s2tfOm/FK/f1fX
	eTbU=
X-Google-Smtp-Source: AGHT+IFYYDVvZCKiztxZ60rBmR6N/IZ2AG36u/vzrI65rCDMBRqsoQEUsFrCsA0nomhtvd50E2H0oQ==
X-Received: by 2002:a17:906:b286:b0:a59:afba:d0a4 with SMTP id a640c23a62f3a-a5a2d57a74bmr602098666b.23.1715617662202;
        Mon, 13 May 2024 09:27:42 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d92sm621835266b.98.2024.05.13.09.27.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:27:41 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a934ad50so1082447366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:27:41 -0700 (PDT)
X-Received: by 2002:a17:906:f88c:b0:a59:c52b:9938 with SMTP id
 a640c23a62f3a-a5a2d6653bamr696929366b.55.1715617661402; Mon, 13 May 2024
 09:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com> <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
In-Reply-To: <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:27:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ_fCwC5iGri1KOEwdV90H-myv1gSfjHfCwt82ZXaCWQ@mail.gmail.com>
Message-ID: <CAHk-=wgZ_fCwC5iGri1KOEwdV90H-myv1gSfjHfCwt82ZXaCWQ@mail.gmail.com>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-alpha@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 14:20, Arnd Bergmann <arnd@arndb.de> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-alpha

Well, despite the discussion about timing of this, I have pulled this.
I still have a fond spot for alpha, even if it has the worst memory
ordering ever devised, but the lack of byte operations was an
inexcusable "we can deal with that in the compiler" senior moment in
the design. So good riddance.

            Linus

