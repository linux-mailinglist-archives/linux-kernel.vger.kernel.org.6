Return-Path: <linux-kernel+bounces-227352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F852914FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438541F22F22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8532917334B;
	Mon, 24 Jun 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UTb8ohZS"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941E3EA72
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239310; cv=none; b=lyZIis4Jr1MhPQkbmZIADhfP0mxI46NxIKi3BtARZnuStNt4m+Vp8oYqeEEvJp12/sKOO7M3qSo44OCl8KVSjc0Hg5Lckxnhluu/VGvtJ9xCd2z9VFGXKupizcBls8KFJC8N6jgJzRFRkB3gkT2TJKnRsPzTbscOvrKKyv+54Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239310; c=relaxed/simple;
	bh=j3yW/z96FF8SUpUP6V7AyzKgmGiSp2jEP9gctQ8qesY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlN+xpDLHeSdJyJ0rBLJHmDjbHEOr6iEyfxTgztdwvfkfHdylSBq9ZLLmVVYEAPfLU1PFDkW/JXXzPcFIADZdB3A5UWaYHF3ClxalORLFCnbp4y0HSBDb/8TLJRykZdgdlfsvjOyZlxW/uAWXn7BrnJagcim1rrbblklA1Lcel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UTb8ohZS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so5061974e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719239307; x=1719844107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7su3gRoP2LrGxszjFo9Cz/0CPHsqkmxZ3xjVUAFtNYk=;
        b=UTb8ohZS/zYsBJMffvQDmSe6gBG1qxZeX2MI+KXLCuH1SiHpON1oRkMP//uQkW+3AE
         XZIkvAPwDxRjHorly+/rxVSETwMgHY6hyoAY5buiCs3jn6KefCIZwI6Y25N6ySjyMp39
         0F7+0S8ot0KpDtKDxScKNOzYJbrRt5YEHZzEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719239307; x=1719844107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7su3gRoP2LrGxszjFo9Cz/0CPHsqkmxZ3xjVUAFtNYk=;
        b=pn3EsH7sFakXPk+iw68piQiZHrPSPphx9l2t0NKaxollHp5L6jbkQJrquPpE5wtvDK
         cbKAxqHf3nG5nhKjlnjVoRbqBDaOCdjHmyZ3RLxd/gDrJS4qakCn/vUOCQGpLEDVmIbI
         QrLxi4xQkhy5H8InGEpXAb8q3StKtG1aeKZrZQmvakrJvsYPr3JDtYkVRlXTPbeaczfb
         rh3gAFJC/ApuLn4ZK2ADGV29yAXDwHe+2j3aR/yIXRC93qVp74taSIlH5q1z8YaavMj1
         1L9jEp/+5Nq9TjI4KhfYKIc9CRnP2hTybqaeBsva2lEceMLNPEguEShY5dYipxdvAU0P
         EPzg==
X-Gm-Message-State: AOJu0Yz2eWDvQmzCQGNxqkHbMZ6L/jlH07NDX2BNbaJZBVTW3T2JVzq6
	Ge7uFXfP+p1yHj8zh1RN5ohAo0Dz++SGrArgSGjF/GnIyeB1+LBlWGV/WZbjeTebh5SNxElIZNf
	zqqtvkw==
X-Google-Smtp-Source: AGHT+IHxZbuOUYGXaA+nY2BlrnHvpO5Qk0rxCzIkc3hgkrkBag6FHSbfLIUOIzSj6H5hpPKLj8S1pA==
X-Received: by 2002:ac2:46c4:0:b0:52c:e312:249c with SMTP id 2adb3069b0e04-52ce3122574mr2738693e87.7.1719239307200;
        Mon, 24 Jun 2024 07:28:27 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd644104esm985962e87.246.2024.06.24.07.28.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 07:28:26 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so5061944e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:28:26 -0700 (PDT)
X-Received: by 2002:ac2:4c38:0:b0:52c:d834:4f2d with SMTP id
 2adb3069b0e04-52ce1834fd8mr2761302e87.18.1719239306227; Mon, 24 Jun 2024
 07:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZniqQuGkosZYqIYE@google.com>
In-Reply-To: <ZniqQuGkosZYqIYE@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Jun 2024 10:28:09 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj730guvRzh4wo16Cq8tq1D1tyD8ub4CiBxV4Bk0Kq_-g@mail.gmail.com>
Message-ID: <CAHk-=wj730guvRzh4wo16Cq8tq1D1tyD8ub4CiBxV4Bk0Kq_-g@mail.gmail.com>
Subject: Re: [git pull] Input updates for v6.10-rc5
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 19:05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> Please pull from:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.10-rc5
>
> to receive updates for the input subsystem. You will get:

Nope. I get something entirely different. I think you tagged the wrong state.

              Linus

