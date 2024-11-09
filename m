Return-Path: <linux-kernel+bounces-403022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF2D9C2FAF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 23:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D4281FF2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AF4143759;
	Sat,  9 Nov 2024 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XmDOVBNX"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB8145B24
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189601; cv=none; b=DghIx5LAMSGf1l0INCZPtMr945PoH8nnRu9MUJrUkAbHay87eKGeaFkb3udMOK0YXGCs64ntVmPZqjbWGT30U1w2o/cIT7WIOOVPEG+SXOYWYxu+hoeSeKQRn9BM4cd8Mc76mevtje2qBrZ38Kp1ZaVU4S8le1gwjrxU9WVIT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189601; c=relaxed/simple;
	bh=SorAhy9ty86LD00viwQJqvRfEu8dv8sSy3YjFa1woIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EknZ+9xj6kfwBEGcqB/WLEqFqleEbcCM2gnZRC3AMEgE+GZIRnAJRnze+hkzMRZ0yLdBEpNeVbb7tVBUylA48IQjg5BjLxo4sbE44+XujkKmKnNurWNKaVpyo4Bl9dU5lpJ8W/On4ZijnnCHE8g2tTLr/0bYfeb2oURSy2IcEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XmDOVBNX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d495d217bso2966602f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 13:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731189597; x=1731794397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZMpIxu5tJ4g1sGmptF0V0nSmDcf4fOLJUmZLvsgvkM=;
        b=XmDOVBNXUNZdG5g3bBAkEAzwqhexBESTrnz82dZmApXGNpsULZLv6vTXlc5TjkCyY1
         Q4na2gZ5FSgT86aAjq3f3oskvJDPb3RSSa9lMKeWu0B66IfwKUeVf29sxVMViy3gRxFq
         K7hdPA7dNLqhmWCZnJgvdvlyJnVU5dcViNRcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731189597; x=1731794397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZMpIxu5tJ4g1sGmptF0V0nSmDcf4fOLJUmZLvsgvkM=;
        b=Y1OQORi3/RQzfcSUAmeCdD3L7bq81XWc8zTGbNjP/nSNh3AEdGr1M+pRp2P0ZmBSER
         Akw6nCDX9YbP4NIIqDcJfPGodPp5RiJKY0wcjAWJ/UUMM7qv97H1w0/il+4xVbQEE9Wp
         a6S5rz4PAIoiYOqsKjLfyDoyxtBuCjXqM2plDtqLTHmvE/3zXcMkW8T6wqFxjRhhGH/e
         5KwdT1jQZaaRYIs2a4K08aMlta7q6IQecl9Sq7I9XmC9+O4GzVV+8iPscp1VW5VD9Jfn
         0n5X43v5kSSXzbhu2SzDBD1JGDJKwuMa1oVuA0ThxEGEE6Jd1RXdlkXDAh6d+uTuhfIN
         oT3g==
X-Forwarded-Encrypted: i=1; AJvYcCX411zcgrikO0e5tL2RBLh4m4Mn6vDVsnWMu7+qk2Hj7m1DfHJKhR0VrvmQOBPyID1+uNODsd/DmXGsSD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/cVPLY4TBzDmlMDtIRBXw82XGMA8VClZchmcHPGZerWVJcuc
	paA1643Y1IT6sNLKkxr0swFnqqHHRj6PMdvB6b8cYPzUMjO8gPi98vGmljBoL+1sPWTfDiUOh0c
	km9c=
X-Google-Smtp-Source: AGHT+IEW6jg9yHvjoUclrD4F2sQ8Y7YhL8cYyXUrHx9NpwHyzTErjeUjHx0ALC1C+nG7SHv0K6OVuQ==
X-Received: by 2002:a5d:64e4:0:b0:37c:cfdc:19ba with SMTP id ffacd0b85a97d-381f1871f61mr8278648f8f.28.1731189596892;
        Sat, 09 Nov 2024 13:59:56 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a4f6sm404002766b.57.2024.11.09.13.59.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 13:59:56 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9ee097a478so212103766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 13:59:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1h2M6Ja9oHQgM6yzHsPPNhpDSydRuxU7XgbnYtyYBVldRdEeeqzNtr2wDrRA+COiWvRMtRz3RHBFOKTI=@vger.kernel.org
X-Received: by 2002:a05:6402:348f:b0:5ce:b733:2ac7 with SMTP id
 4fb4d7f45d1cf-5cf0a44667bmr7719738a12.29.1731189595811; Sat, 09 Nov 2024
 13:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109194158.422529-1-mic@digikod.net>
In-Reply-To: <20241109194158.422529-1-mic@digikod.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Nov 2024 13:59:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUy+ixmBnJuFzTMe4yvxH6fNqu5UG-K=EKZzCAXw8pVQ@mail.gmail.com>
Message-ID: <CAHk-=wiUy+ixmBnJuFzTMe4yvxH6fNqu5UG-K=EKZzCAXw8pVQ@mail.gmail.com>
Subject: Re: [GIT PULL] Landlock fix for v6.12-rc7
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Daniel Burgener <dburgener@linux.microsoft.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Nov 2024 at 11:42, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wro=
te:
>
> This PR fixes issues in the Landlock's sandboxer [...]

There were neither diffstats nor a shortlog in the pull request, so
honestly, it's not a pull request at all as far as I'm concerned.

       Linus

