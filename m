Return-Path: <linux-kernel+bounces-431058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C99E38B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD7CB267E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3811DEFF3;
	Wed,  4 Dec 2024 11:11:45 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB81B6D1B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310704; cv=none; b=tig3n8eJ02XWP0MXSOe3Lwu3ubb2G7InhLqCi7MblrLMrfINeopNZ0hup6sF4+oZXb3zGPwxXgwRxaC2G+D4zSGKP9873W5aOG6Vkfy7RaJiox+UqNG0/VgTj/SV79rYAsx3x4NKXgseae62HtuVQtP9E1yzqcEmT1/asejXh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310704; c=relaxed/simple;
	bh=n5LBtRGH3H2e/8iTkx//qGhF9kLk6nyYwlFkRbpEh1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnJsstoU1LO3QWt3Sd3LLeKpUG8YUVEB1g63qtJa7s2+1E6w2csEFiVv9FDv6kCurefchDl/sNyzChd7uHbA8LKn+AevCxGklQe/jIDzRECYHNnUOU/R3eX44Qh52ICeIL03nq0OY82vkw/uzXZDXO+qdEmF+bRf5n3PfJilOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-515e1d6b63bso32919e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310701; x=1733915501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPYnA7/9x57u1klscNZiVkfrCJk08FmaaTzofAiNVwY=;
        b=ga/ZCEh2558mBGZmZh9CveOpb6eImrpReKA86B5djwcUouC6f7ULljMUM/kt8M5Et0
         zgMVVEw/SAEl7NDgkZ2aqwEimxQYNp7tUnTkDHbPWhvGlBgkSdc2aJ1c67lAmWAWBXdB
         Ov4B8LO6KQruBFYYvXXjgWHSpSD+t2JnA6h56BLSkgKTp7QK0JlH7heGUoVgCqL7fveD
         smTTPEcevvwTTE0AhWhB6oTvM9sXPHMZ2IcT+a6N19ge56G8aV9BTcN/254ssxUzz9zU
         9XamgoQNybtKamRETgSt+h51RLoYuzr3om/kvEikh0TFvp0E2BBes8JBQTOBtAua/fGI
         ToAw==
X-Gm-Message-State: AOJu0YzTxNVqf7I8cMexQGLNhWn5rr2NXyJ+Op2iDqJbIx3nASZAbq+g
	jj80qf7sAwu8kWtO9fTHdK7cj3fssBYChreBIPpnsVs3PgswRpzh8piL0EN4
X-Gm-Gg: ASbGnctDAm80KgOGIi/XSnxMpQzyakKRZfXPf4Dq8Ze8/DRWkYWPmGK6Y+UQNtNttSZ
	itTXd9fL5QHEym6H9x+uMDPaNxOv1EbkEqq2NCsVfZjiSEyxYpIcMj7vs3zrXxjSiL1+YhfIIRQ
	q/NwEU7ESX+RDsj9c3QoBYgv7AjLOnNnTaacvRXCURc2LiaO1wxF3G9LtAgYpeKAp7Ts9TBUuL9
	3/8/pxzlM9qVc7Wc0eRqz3c/F1k6Suj7/gIMRzYAaTliN9NWn5O3AG+uC0C776J8LvwgElztKNk
	P0pWMsOdij3z
X-Google-Smtp-Source: AGHT+IEFdFFxjyjOrW3CsvBucVPuFlBTp655kHdqWtQUS3+K1f3TUZJ2Mxvp/Dx3RCI81+V9e4PaEA==
X-Received: by 2002:a05:6122:4382:b0:50c:55f4:b529 with SMTP id 71dfb90a1353d-515bf525a49mr8390706e0c.8.1733310701041;
        Wed, 04 Dec 2024 03:11:41 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-515c71f808dsm238283e0c.30.2024.12.04.03.11.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:11:40 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4adcd7e153bso1918742137.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:11:40 -0800 (PST)
X-Received: by 2002:a05:6102:c92:b0:4af:56c:1cb5 with SMTP id
 ada2fe7eead31-4af973adffdmr7265701137.19.1733310700528; Wed, 04 Dec 2024
 03:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whiWXVxhd0BATPPd6t36HJ49vApdJXZOYuAJtRA5pRi1g@mail.gmail.com>
In-Reply-To: <CAHk-=whiWXVxhd0BATPPd6t36HJ49vApdJXZOYuAJtRA5pRi1g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Dec 2024 12:11:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvSwaknDnU=t1Vq7rpNkpG85bEP_ZzyTRUF2Q7H3=Stg@mail.gmail.com>
Message-ID: <CAMuHMdUvSwaknDnU=t1Vq7rpNkpG85bEP_ZzyTRUF2Q7H3=Stg@mail.gmail.com>
Subject: No build regressions/improvements in v6.13-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

After 656 reports (the first one was for v2.6.36-rc2 on 2010-08-25),
there won't be any more reports, as the linux-next team had to shut
down the kisskb build service.

Thanks to the team for all the good work during all these years!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

