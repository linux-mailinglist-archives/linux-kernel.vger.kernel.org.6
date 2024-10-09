Return-Path: <linux-kernel+bounces-357781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148DC9975F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449471C21242
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E911E105F;
	Wed,  9 Oct 2024 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XiUKxv4Q"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2A1A265B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503388; cv=none; b=o7j5UUq9M8XunI+bMw4Sa3RRguehP+Y4UgS7wcVcZLFVoTFFXctCP5uTRrGulu+zTuQ6ED9/Hnc6LMmouObru49o2y/SQOiyPYmoQ/Sp/NH7+Uq2cNGUoUtGgvySdBaXRI8SRjiyvw3t01YoERI4A+o+tX8VeQEqnpxPY/UpSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503388; c=relaxed/simple;
	bh=B/cYCgvVyZ2EH5fC0WMa8Rs4RO5DAdkT4QHo08J5Fuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUz5gNLEUsCFcMmT7SB1lpccH5LIcd/CrHtdIltDdq/Y16uSuAu0b7P/WdRRjDbDvoci6uC5Rlg628GwgTx2vdp/bcc8M7T/Ob04DDExnlagEWAL5oq+8ibgwpO7P4t67DxykUjLe2RZrvwtm82o61NTHKkuvuNR2HWIiyVFsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XiUKxv4Q; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso1495971fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728503383; x=1729108183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/L06Ja6eCp8GbRUC/+PsWSnm/5SpwuznlchqKiwSEc=;
        b=XiUKxv4QNCJP5vG54OOeFH/4f2xVZEXTxjZQxYzQxWJszTMkkaaJpxLo4qPSZPoL+E
         IFTuAGP2g2lheM7dm66R04c9op66WHp4+HFZ8KRZQwieqTd1RWedOuVjgYX8ZKpiVUh0
         BGHEeO995dDtGirRBsQogK3RC3F9gzNAv/NLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728503383; x=1729108183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/L06Ja6eCp8GbRUC/+PsWSnm/5SpwuznlchqKiwSEc=;
        b=UWp1gzfgEEjNffOQrYJAdX40nqOqnciXAtMMUpUDpl6NHDw4vU3mX0vuZTYkYd7Pfs
         vPBaJ4I7t3vJ38vfnonuqiD9NT0iGXomXnfxTtkiW3eq4xCXIe1mXeRyvU6fHAfd4WwG
         +e2jicONzQA6MI3r3Z8oOb4SKI65k05Vki7PX1iCKM/e2zsrivoaVBF3iIqOEcJQHiUz
         ldS8IGkiYJfwrNBEj/5nADlxJX4eVxII/keHZPc7MMVe1umPWAAn81AW0rNUeUwxQUqh
         PybKX7o2B3HDRclS96kLQ+TA8HwMgsZyUKA0KAUoxmlmKEfzOuNb1xwQeMblnkfkiIk0
         EE3w==
X-Forwarded-Encrypted: i=1; AJvYcCWnZILOoE/r6e8QasRnJCRZedw4DKRGVCV+G6SOfuUmcZ2BADWdaNLInjHTqWsm7io6FoM+eewnGDK8QTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ztUqgWz76rm75WU2wZHhPyLLV/MoTsn5W1bHBY6Z3u4cQESD
	Hr1pV6RgLpApLhqqCiEqmPx7UqH+GGH6RJcEWSAPvGLLacE3r5b4inkEwwlMJA2TRf1UteBU12M
	vMVCCXQ==
X-Google-Smtp-Source: AGHT+IHGygDlDuCkHr0hcnNz3iMN33ozVuIFDYzJsGonUppN2zwXbV78jzDM+cSi2eVVULG2+BLjbQ==
X-Received: by 2002:a2e:e01:0:b0:2f7:4e8c:9bfa with SMTP id 38308e7fff4ca-2fb187ce906mr20042231fa.33.1728503382590;
        Wed, 09 Oct 2024 12:49:42 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93353af24sm277882a12.71.2024.10.09.12.49.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 12:49:42 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a83562f9be9so23878066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:49:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8x37D27bLZAgq94C1/la3FgN/ajB1RjOmGrGJb5pI8HjSaAVjkwfTCkOTySNF5LFjZrrFMmROFnGCK3k=@vger.kernel.org
X-Received: by 2002:a17:907:9493:b0:a86:7ba9:b061 with SMTP id
 a640c23a62f3a-a998d34d21dmr306848466b.64.1728503380729; Wed, 09 Oct 2024
 12:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuwaasSf0ZzcYHiN@hpe.com>
In-Reply-To: <ZuwaasSf0ZzcYHiN@hpe.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Oct 2024 12:49:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVb6ahr=-YpiVqvhCKj+GHME_J0cRi6tn21TPwV7B9SQ@mail.gmail.com>
Message-ID: <CAHk-=whVb6ahr=-YpiVqvhCKj+GHME_J0cRi6tn21TPwV7B9SQ@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: Don't disable preemption in GRU driver
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 06:16, Dimitri Sivanich <sivanich@hpe.com> wrote:
>
> Disabling preemption in the GRU driver is unnecessary, and clashes with
> sleeping locks in several code paths.  Remove preempt_disable and
> preempt_enable from the GRU driver.

I've applied this directly, since it didn't come in through any of the
normal channels, and I don't see it pending anywhere in linux-next
either.

I doubt it matters much in practice, but at least it should make
smatch happier about this driver, and clearly the preemption disabling
was always wrong.

              Linus

