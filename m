Return-Path: <linux-kernel+bounces-523426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B68A3D6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45D67A5DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DA21F152D;
	Thu, 20 Feb 2025 10:26:51 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17F1F1508
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047211; cv=none; b=Aja2bNpmnz7h+butXAuTGftGFIdDYr75N1E98AH/tIcUhi8C1bbmJxuK3wKvISRN96nrNp1ucDbIBUGbZ9fRQIKb9qSF/PCbqt2U3+AyxmI3TSQyufLIM3qYcKVWP0MhzYTibptpkCPKdRrIavFSw1ITKC3J4JneC79lv9mLaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047211; c=relaxed/simple;
	bh=7hCRk/ZZGsREb/zcnks6gWvtIsasTKNvtsrHkWuFWBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKllzTNwz442Dpp/bdiIBiaEIEaUzpn7y6+ciFnqngNuj+xdW+Iolr4PxvV3XW7opLBrVtn9YonD7+h6ck1Ya2d46fEkt+yoKLpBn5OqF/MfW0B80y66nYb1s5pXbSPihfH/kGtY2jMDbaQfsCPoNrOdMG/zGB3K0H8hUUoE2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-521b1b8cdb6so226323e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047208; x=1740652008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXlZkLtFbkOA04y6wqiHk28O5YC4J8t4Yh5yJXv6QnM=;
        b=o5jCKtwJG3voOYQRHHmgamyWZui/4U6bs1TWgwNKuMPXNqP5bettepvIjUQ0ZIxkVu
         p/Dj+9E9pb8g7mPv7Sqi8dga3by0XmGsq7ylBkCu78KS7WZx7kS5IAUpdekzg+RUME5s
         ZoOlwwTomwnhXvn7shy1fFIbsKQWZe3Z+h2urIr82PDnQtPFsOxZd/H2iaMXYgZlXrIW
         EHvkqOI2rYv0PgU8NcNojTy9/wvmSW5UKS8JK4M5DtTdnfKdht5bqc7OuZjifXgLe5d1
         CbzL6d4SF6ELpGBT3X144cv1KX+yn8LEyIEXW+5Vb2MkA6YaLW+SiIFVjJHPSHatLvjv
         sYig==
X-Forwarded-Encrypted: i=1; AJvYcCWxXJETAmgL6TgMni3KvyGvTt+8I7ELvVg6ESKvUp6Xoysgl3umTfwX5b3efmpWl9xTpSlNqJJkRjiMoQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WG+EwE5c/MF6eQFtG24TkGhMaYutMhmRcEI1dBz1taNR1vtK
	7bG9z8y5sw0Y+mUuwiHWoRM8hxDFFdb+sHnvqEzj5X2jnJV9CKivsBqxthUS
X-Gm-Gg: ASbGnctkr4znvB4tbx3jvr/0/GUyYcQSDQnKZe6N2p4nkfOs7OvpjRIQSA+KWqPwoIf
	HGMPgLRq3j+LWhOjQCU0nMnpJeiOcArQl6yy4n37CewdT9WKmK74xXVSY5aG/0kWJe7im8tmI8i
	81nKe3wdCW6gmUM+ZvEfEFmNPx+YHyoaRlVG6/ao2L6w1Dih1JqombRm15oNnDKtDj4ioeWxYlh
	rqNXzRGdUPBc2ZFKVn7WYsyNzAPe3VY2uJeDncN8vJQUJIwf+DNqYVJSHLPOSvuD3vm8HYSl00D
	7eM0Oc2lFpRW57mp3t0mHhv+Ss+eqtCE2Bezqp83eqvKLiJR+ayp6JNoMg==
X-Google-Smtp-Source: AGHT+IHPxXlvw5bX24+a8/K1vdHKSMuH7mTcYC9RKSTgh0UPlee0TCJkCBpXlxJCe/lHPW/653SE9Q==
X-Received: by 2002:a05:6122:658b:b0:520:420a:a07a with SMTP id 71dfb90a1353d-5209dde2362mr10433627e0c.8.1740047207980;
        Thu, 20 Feb 2025 02:26:47 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520b9a3aca3sm2123041e0c.20.2025.02.20.02.26.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:26:47 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-521b1b8cdb6so226319e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoGWuM30yUocuVe3JEJK125mmbTZiAwBYcS9uSeATprQmx/4U2SroSJFsjRzFlg2vbM1TpELBsoHU+EgI=@vger.kernel.org
X-Received: by 2002:a05:6122:3d10:b0:51f:4154:c1b2 with SMTP id
 71dfb90a1353d-5209da3cd8fmr11832934e0c.2.1740047207465; Thu, 20 Feb 2025
 02:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff5b7c88eea8b126ed76029fb57254f29542aa22.1739976486.git.geert+renesas@glider.be>
 <a88b0a48-f7a0-4791-8ea7-a1e599c3313a@arm.com>
In-Reply-To: <a88b0a48-f7a0-4791-8ea7-a1e599c3313a@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Feb 2025 11:26:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUv=47vMmN1UXzFuPotjLJbHPewmz4Uozm+3DuiFasjFw@mail.gmail.com>
X-Gm-Features: AWEUYZnwJCxfhi79EJYpNxgj3_us2bimwf87oFgKJ_SuMD0k5ozIi-i-wp2ym30
Message-ID: <CAMuHMdUv=47vMmN1UXzFuPotjLJbHPewmz4Uozm+3DuiFasjFw@mail.gmail.com>
Subject: Re: [PATCH] iommu: Spelling s/KConfig/Kconfig/
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Wed, 19 Feb 2025 at 16:16, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2025-02-19 2:48 pm, Geert Uytterhoeven wrote:
> > Fix two misspellings of "Kconfig".
>
> Honestly after 6 years and no obvious complaints I'd be inclined to just
> drop those two paragraphs referring to v4.x kernel behaviour, or indeed
> maybe make a move on the aforementioned removal of the whole thing....
>
> Otherwise, frankly when the same thing is referred to 4 different ways
> in the space of 6 sentences - "this Kconfig", "this config", "this
> option", "This Kconfig option", "this config" - I would argue that
> capitalisation is not the biggest issue with this text ;)

Note that now commit 0d2cdc35e805eb50 ("io_uring: Rename KConfig to
Kconfig") is in next-20250220, these are the only misspellings of
Kconfig in the whole tree. Let's hope they don't spread by copy-'n-paste
;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

