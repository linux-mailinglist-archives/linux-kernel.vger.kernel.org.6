Return-Path: <linux-kernel+bounces-236659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E3791E577
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6944DB230CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F8616D9D9;
	Mon,  1 Jul 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c1Co9JUr"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109E16D9BB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851755; cv=none; b=iNjF1sJfyfAlEBnqwJQCuueKsHgQJUY65/eMdU77LQzJZPG5mCekOdBw/EkN1oCguSUxuLCE5Xe4lHQwUQv+5GrzDYbSAMeU3x/tgpltiYZ+fdLfVWpkrE1nR3e7TAOWEoCja2SAxINER+x8MjZmBHaUCBXq2sEBE7PWTnZ9lLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851755; c=relaxed/simple;
	bh=YLGmbdUVgoClE4zgm/y2rPqET0D9fHrQj2RcTVt3beo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RALTIg11Ig1faTp17TMF+/f3Rzl6ATyPn7nJ5oeL9jDty9PKeW7MYMmfxWKnyKue2TnZqYNW53vF3yFYeQujXCbCojR/YzkpuqNaflGkq/i+Muz238AWILk3ANm5Ja8bfTlzv/+r8xv2NBCvW//8rsOvIC9Hy3bHLpghjoXKit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c1Co9JUr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a72477a60fbso381911666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719851751; x=1720456551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Obs6N/BH5UkcS/x22yz2VPLEj/fFFqodHfDKGoUVc5k=;
        b=c1Co9JUr+HB6MCmUUPKirkZ8BfbYQjSUuD0EEZgh18HcFSLrEL7cSJzKWPZlfRyzic
         IkeLSInNvZTSvecK+eTrGa87BDWQKdgBnOqaynPjJ1zK67PGaXFFLMXj7OWLDtqJCPkE
         lHdxKeZr+cYTLccWT0jotNxDly6DgR34x0HP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851751; x=1720456551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Obs6N/BH5UkcS/x22yz2VPLEj/fFFqodHfDKGoUVc5k=;
        b=ccJ4mt+jUdhQN4dvd0Srjhxmnt3Yj/IyKkf4gfRFsfa7OQ95lgSi2ULK14c1eOawl/
         meLMyOLnWGSmqcMSJ8oB1nnVXbtLnZi+8T9agRo+L6FWF1GYRW3XcJdLO64Us+FRVYmX
         iDNSkltFuQSNfj2WUBH+r3vhKg8g8G/E2uGAoNK49PyOflIdnBp5sZX4qyUgavk+QoQD
         /I0KLp0KFq7fd9d/6plkvZzloFwbGEwq8jz0Ruiiwb+nI0v0JgZtw5aa7Iwhze74FXW6
         jnaUIcZUzCZgQyY7jEuV5Jxjk3lUwRfujc/47dJMdaH4JTkHUWLe9xFEEkRGuUf/U0lE
         s9iw==
X-Forwarded-Encrypted: i=1; AJvYcCWccm3IaSSs0pwznwI5tRDq/8V3T4nHyQZoMqo0lmfV8WqUMVkKBFnU0BYs+nKH3dgZ/ZbgGop3zxoe/R6hFPKQLVxHAF6V3RBguMzx
X-Gm-Message-State: AOJu0YzI6PlTGNJWhRdBFjT8MCDidYr72eWurQodN/jpmXGeUnlaw1c2
	JFroOAfrPhvxNEF+NYBk2PMaYEAJj8iapBoz4whls87r38LFEGHY/VPid8L4aW3M6Cegycdh3F8
	QoYnJLg==
X-Google-Smtp-Source: AGHT+IFc1h7MrfuIlve8n3S2egYxlnVHjJuH8U5HE2qSUnnKxqcvCE63/lR5O18lkyjYvvAfjowfFQ==
X-Received: by 2002:a17:907:2d1f:b0:a6f:48b2:aac5 with SMTP id a640c23a62f3a-a751441f052mr483043966b.15.1719851751098;
        Mon, 01 Jul 2024 09:35:51 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72b4280d6bsm302145666b.206.2024.07.01.09.35.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 09:35:50 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a72477a60fbso381908566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:35:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFJPUSe7/KenxjmXqOpoDTOdgzfjl3iwAYCaiyqY64sRpTvhUnoUwgRmLG5y6YKUK2h0amcjrHSnxepBbcb5OvnQ1MoHEH/iF8l759
X-Received: by 2002:a17:907:724c:b0:a6f:5698:ab5b with SMTP id
 a640c23a62f3a-a751441edbcmr548618366b.8.1719851750079; Mon, 01 Jul 2024
 09:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D2EBML829ZJI.1XZZVLVGUXRBH@kernel.org>
In-Reply-To: <D2EBML829ZJI.1XZZVLVGUXRBH@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jul 2024 09:35:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYe22cLAF=LmZwRu3VOf80LO6XdsdYt3Lhb_TEJ0XnPA@mail.gmail.com>
Message-ID: <CAHk-=wjYe22cLAF=LmZwRu3VOf80LO6XdsdYt3Lhb_TEJ0XnPA@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 08:51, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Contains couple of bug fixes.

This - and your keys pull - say 6.11-rc1 (and say "next"), but don't
really look like the usual merge window stuff.

Just checking.

            Linus

