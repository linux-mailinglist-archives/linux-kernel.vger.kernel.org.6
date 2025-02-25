Return-Path: <linux-kernel+bounces-532537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E906A44F06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDCE17D36D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523A520E711;
	Tue, 25 Feb 2025 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1ccYdnQ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22A18DB1B;
	Tue, 25 Feb 2025 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519492; cv=none; b=GVG4h74alpC/G/toPRCErye8HPpVp/DNbVw+rA3LzRVlmVRCdoTBUtr5At8GfAXSx8tGHWWYsDe6ffgEec0L+RRkbPgzo1xdtMRqfyF5kQbpQOKJal0m8jE42FhT6LXBw7MegsCmUWT0r7zD0L7bKPLYUn+HmpfG1GrN/oBqcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519492; c=relaxed/simple;
	bh=aE8YFaAaS3yuOPewtHTX+TYTLUQYvdlxC6/LkkaX3Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfZR625+7yT0XZwyOUV/hyRzMVyEaSQTqpMj/z74Fo1Kq81b+O+MIhqNP7jbPmrmEFkHFvsrBY3jyUbSjrlRfLKlkR+/IxcdQyqhqlbtx0/8pHMQS1jo/P7JaGl15iI4nb3C8/Lsh9QltN4xX4ZigeAF4pqUnc498/OgnWkxAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1ccYdnQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f70170005so3750286f8f.3;
        Tue, 25 Feb 2025 13:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740519489; x=1741124289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aE8YFaAaS3yuOPewtHTX+TYTLUQYvdlxC6/LkkaX3Es=;
        b=f1ccYdnQUjL43TyiK+SwEm5bOf+QzFJvHhpwLVH441Gey2sgXkTWSg9G3O866te/Gd
         rGUv1/Spns30AYWShKoqqtMUdgCK1iXEW3iIMY2qCaynru/Bg1trMK4EmxR+q5/BdwQ4
         Ri1dX6sPu+LX3yGVlj4d55PJ79830HmrnW5ukX7XubCHcwXRxc4rlocziCKbJv6e+olA
         2WRQMZ666K1OmkIzl5EwoDIPSsqldkn/PWNmYYlCZYN8fsU/V4QB7tY4W9/uoR40n+2/
         yg1JuPqim5NVzonQKS7s0Sq8bhBvIYWqVcghpGzGQViN8otAU1IDEJmsMYkJQFNRAObQ
         99zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740519489; x=1741124289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE8YFaAaS3yuOPewtHTX+TYTLUQYvdlxC6/LkkaX3Es=;
        b=ZT3f+1R7psYocLuWZKNTL0cLavlo4lS2jy/3NRx1fW2cvfZwNj52z3iFCuxldEutxD
         5EdwHVUmCzUfjbZO3cxD1vuvGeHFyIdaxdS76zpdQYpd2Ecv5LpCmoO/wN9OHLMNTKKQ
         JHlGhzCR2J1Me4U4YFd42YmvigQwSkm8uPVxtIzGCTa5dAF3yu418qoppgEe86cXEZrH
         KUkx2kl/JazbTx2YicCfkm4hOnXCQCCzZiTy/yn6ksoKXwvWQGeZ8pOQiMnTuROD+YqF
         w2yyrEp0+sAqaW1tZcAi9Hg0nvvZwWrzxYergt+WnW/vfaHygqmVYxrGh//lfIDv5JCb
         BwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVGYcVNKlresQwAyY83qHJ9vSI4M9Ge/SMMjZDuuCUyqN1dVJToaetTQ21KKmewB0LyZy5kCxr+SU=@vger.kernel.org, AJvYcCXJ05JPCXFadCThlDlBXkdZZhR8nBMA1oH4cg+SPoZE6ayll1PWrdA4M7xHZvfij6yKIHE+rieCLzmKtx8v@vger.kernel.org
X-Gm-Message-State: AOJu0Ywph+XnmbW5nIJffxyjReap6py7QBg0/NuMDJzyY2STp7U4pF1t
	uAETzL+Kck3yjEI04wE4BncZRLDhrXlXJ/7sAmsCM8dkspxLDZHr0/UB52P6dOa/1l/dab8+zcy
	CR+CwmL30/mhu5A3456R6nJqvR/w=
X-Gm-Gg: ASbGncsazwEI7V1blwjP3RLmRddbrwKi8YNydL7186eQMjZJ1OXVAvnGhY7sRDhN5Wn
	aVDShz29hJL9nDtMkddUZeqdSymCRgc2VNVPTuBeTLgdjVagPfDFC4E4kqyeKEVmTy272tJ228c
	J1WSxUR39K
X-Google-Smtp-Source: AGHT+IGzBmIP4aWCt5zFr/sHd8kjuZRvXKRM0LrcV6ko0BFjnKWL3knShVuZ19Ay8ztNZBUEIkHfc1Iw5Vfb6Xxj3AE=
X-Received: by 2002:a05:6000:c2:b0:38f:2401:a6a6 with SMTP id
 ffacd0b85a97d-390d4f3cb3cmr437434f8f.12.1740519489416; Tue, 25 Feb 2025
 13:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
 <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
 <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com> <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
In-Reply-To: <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 25 Feb 2025 22:37:58 +0100
X-Gm-Features: AWEUYZnS8GVd3ERRXhXkc6hjvKnRC5lEIY-bHuz7PF3TjilwVr_-TxB6baR4YG8
Message-ID: <CA+fCnZfb_cF1gbASZsi6Th_zDwXqu4KMtRUDxbsyfnyCfyUGfQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, mark.rutland@arm.com, 
	broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, rppt@kernel.org, 
	kaleshsingh@google.com, richard.weiyang@gmail.com, luto@kernel.org, 
	glider@google.com, pankaj.gupta@amd.com, pawan.kumar.gupta@linux.intel.com, 
	kuan-ying.lee@canonical.com, tony.luck@intel.com, tj@kernel.org, 
	jgross@suse.com, dvyukov@google.com, baohua@kernel.org, 
	samuel.holland@sifive.com, dennis@kernel.org, akpm@linux-foundation.org, 
	thomas.weissschuh@linutronix.de, surenb@google.com, kbingham@kernel.org, 
	ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, xin@zytor.com, 
	rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, cl@linux.com, 
	jhubbard@nvidia.com, hpa@zytor.com, scott@os.amperecomputing.com, 
	david@redhat.com, jan.kiszka@siemens.com, vincenzo.frascino@arm.com, 
	corbet@lwn.net, maz@kernel.org, mingo@redhat.com, arnd@arndb.de, 
	ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 6:21=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> >> I wanted to have the shadow memory boundries aligned properly, to not =
waste page
> >> table entries, so the memory map is more straight forward. This patch =
helps with
> >> that, I don't think it would have worked without it.
> >
> >Ok, I see - let's add this info into the commit message then.
>
> Sure, but if you like the 0xffeffc0000000000 offset I'll just drop this p=
art.

Sure, assuming it works, I like this address :) But to be fair, I like
any fixed address better than using a runtime const, just to avoid the
complexity.

