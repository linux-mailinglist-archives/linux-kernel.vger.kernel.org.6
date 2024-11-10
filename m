Return-Path: <linux-kernel+bounces-403390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929679C34FD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591BA2816CD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F10715852F;
	Sun, 10 Nov 2024 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JgbQSWJX"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF89450EE
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731276544; cv=none; b=jq/evL6KZJP6/+soqvwAfewZtwppe4GXMeGj/3Z1T2tQvMD++IC/2JJeDJPgCxDCQ0YqSdur+/24w8m9Q5wovUCisEpHDOv6RUSJKv8wJ9SimudDeFrH5HU78Hd+4i9qiVEuzuHOATVMWwkJ5QfG15OEwENS21kTP5LQG/qr9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731276544; c=relaxed/simple;
	bh=0MQpXldGbOUiOX0Q59t4XbUm1yl5q3vOpFkNG4YlEq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9wXkKLP90MU793fhao2AA1ONf30eAIHiiqIm2Ko7figWfHGOOQBGznvvIcMHSefAPS9x6GbYdvtLmunCLVCbjlgUhrDtjtc/78O6vg5QgTFP7eGvEXLi1vTwMQuButilKvUNCPYUF1mkA2wGYe+vzt0isKahuLsPweSp8OROf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JgbQSWJX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ed49edd41so703698166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 14:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731276540; x=1731881340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldAepWh5Q6dryoEoVJkGu/LkFMWpEkN9IhbtZ9HDemA=;
        b=JgbQSWJXOSjii5aQEsVr+n+d4r5voyggZHcD+1hqPx7wTqm9xytzoG9XKn1ABipkQ6
         gBYq9mzPOeDhGTndjGaTVs4IGnUuilwF73mdpw48rLUaWj4fx1OswGPFeOsqSM3wRBOw
         e6bPJCchLy+7ElZqSzVhOiwDEy6h0tr+IMZe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731276540; x=1731881340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldAepWh5Q6dryoEoVJkGu/LkFMWpEkN9IhbtZ9HDemA=;
        b=CrnGlhSIFZXrIzk0GLHha6qEs3rpAQTTyA+yZJBitm0YCpxgZdXj6Z1upAl0VK4ZUE
         I2BwMx6XOoN/FRzPDLrHe24D7HV7mzDS6Pc02htZJUc2feRcD4JZOAtK/RfbmhTNcmq0
         w0u2EcS0hyw0OEw9w1/SK3tyiCu1GdiZLUIfLGsLQy5PPBNqFVjZX31MlUB79KjdXwnh
         jYYdTIkbScE8j8oHNnm4bqNHB9+C8aBVisEaM95y70vxfd8bEPvjcdZ+nyXjGYf4nXDK
         q5GlImEQn7fV9mgheSAiXq/HZenMIRyrsYOp8m2IBJWFKqtqcEDiBVaqkO5xRpPU4cyQ
         yB/A==
X-Forwarded-Encrypted: i=1; AJvYcCW/mBMCES7uH8mqg3Z4QLyt3w8Sv+fUK4M7kff3IQEhxsPBt67tyEc6+8Wiys1ksBbpGOTDEIR3GHNw3E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DawJBcEqLDzKZC6dPTy2h7xz5Vh9yEkKsvqJ0ieVNMnQSu3d
	lZlLQ4xIE5zBVfGWK7efGJUPgoKL2E5JQgaRGRBYy3SpCbLFkYw3d9lsHQWH5mVfShOaMNULCE1
	laQc=
X-Google-Smtp-Source: AGHT+IEIYPVkJXNMTgFpFi2J01cguZLs8QJx3WuUz0ntuKfmWc31bOBxEeciM6Zi4vK6t30bOb5NAw==
X-Received: by 2002:a17:907:844:b0:a9a:a96a:e280 with SMTP id a640c23a62f3a-a9eeff0ea22mr1050894466b.20.1731276540501;
        Sun, 10 Nov 2024 14:09:00 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2f3cdsm525776166b.185.2024.11.10.14.08.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 14:08:59 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso675374166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 14:08:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVW5AIRFwa4NsIaBJ0j49n8pLK0Ua4bimSVD4gnoVPYCVlhHjwPIMnEBcehnckUE8t0WLi/WBOzFIVwg3M=@vger.kernel.org
X-Received: by 2002:a17:907:1c11:b0:a9e:82d2:3168 with SMTP id
 a640c23a62f3a-a9eefff1525mr946225066b.46.1731276539301; Sun, 10 Nov 2024
 14:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f875d790e335792eca5b925d0c2c559c4e7fa299.1729859474.git.trond.myklebust@hammerspace.com>
 <ZzDphC-x1XEFlDvD@kernel.org>
In-Reply-To: <ZzDphC-x1XEFlDvD@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Nov 2024 14:08:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+h=Pqby5RBnOfrPH2TikXK6S_bsX8-9Usp0LjJKnHxA@mail.gmail.com>
Message-ID: <CAHk-=wi+h=Pqby5RBnOfrPH2TikXK6S_bsX8-9Usp0LjJKnHxA@mail.gmail.com>
Subject: Re: [PATCH RESEND] filemap: Fix bounds checking in filemap_read()
To: Mike Snitzer <snitzer@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, trondmy@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Nov 2024 at 09:12, Mike Snitzer <snitzer@kernel.org> wrote:
>
> This mm fix is still needed for 6.12.

Thanks for pointing it out. I've applied it directly,

            Linus

