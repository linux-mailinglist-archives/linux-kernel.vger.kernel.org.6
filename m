Return-Path: <linux-kernel+bounces-177807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5FA8C44E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CFD1C21858
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49A155345;
	Mon, 13 May 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RTF7C4iV"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8C155331
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616694; cv=none; b=C/2RSj/kmfQfbWTktgznU/vg8d/hv9sXv70GfM9AM1jaM4D3gw31GpxWBNkyK5IEOMoQpKFcQ3HH+jLjZPm/FujPaYacvFJKN6XP1Qmeo5E8dQk0Upfj1TO6WZXyg0Cb6SslbUgk+iQhZrKpnMsy7Q+oWh3m9iUy1af0A43pUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616694; c=relaxed/simple;
	bh=GI/6S7nq8gw8+qZwiqmtwyvLl6eJUsnvpSoLxQ6/lf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJnXPcHjF3NL1zc97gs7y4toyLUYBZnOAhLWSrLxYINyhDLO6Q01a70GDe1WPpj7HZQV04tkvSljY7xYbplrkatUrRuuzweFWX2JdGXvZL6UMVSAtePau30GxC5wEdMk7bh+ouD50R7mr+b7EfAE3J7JDyH5WYT50VbXsAS9shU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RTF7C4iV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so375838066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715616691; x=1716221491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LiMZcNte14dcc4wpme0lWntkeka6doEu5gChNQCkLOo=;
        b=RTF7C4iV++vAIG54OnFTKIQd88tDDiImBV73AqsUNIpHuyXW48ywpAcMPac32YB1cs
         umUzF/e3b+4gYxeh1XXDU88EjmwuCavZy4yfmFrGhZywCbnkh/QSuk8kG6PD8sLRW/kK
         ioRBcgTCOFKsCp4GsuoFFcUeO08ALehRbvIyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715616691; x=1716221491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiMZcNte14dcc4wpme0lWntkeka6doEu5gChNQCkLOo=;
        b=d+5TUBQ5PXx7g8hMZPzrzaw3g+T0jf8zXpUVFEzkUIQu5SUHEbfrBsGIGI3zAEnvQw
         ketuvtcWqYm/SQsvOlzKKzAlbsChri5+RAdz4VARV4CIf/v2LFEsElTQAZFp5vgd6gJX
         fQ2YXz0F8cbW7dj345T7EH8fHCLcjnvaiKe4EkHNKr4TSOD/JIXmXlf5KFcXejc0EpF7
         idm0wRYCuGX+b6ihZwCrAwrxsKFq1QdjnGsmlJc505/3ueYEZKDCy54ghjzal2wcU5+k
         R8J8FXJsCW5WDh1J4Dvwz+Lun+DCuPAZryhfDYa5mxFrXPSV37eeQ4e2KTyal3AddExC
         FeiQ==
X-Gm-Message-State: AOJu0Yy4WQSbz/6S/xJzR0uFHapLAkQfssqdV77CePuP7qePqiMpVTz3
	m1zT1KP5izK3g/H8aRW+nGXsvgetPUOXE/bqqvAF43WY0Q9t1D3jIGfvNmAqrwDLfEdyhK4/1jX
	LAy4=
X-Google-Smtp-Source: AGHT+IEKfK/TiAMo20AwQ1qf99thKEa128/oK0FAOqRImc+3isNSicDV8Lkj5cfbA8xKzYB5NWBbsA==
X-Received: by 2002:a50:bacf:0:b0:571:bd88:e84b with SMTP id 4fb4d7f45d1cf-5734d5cec30mr6869496a12.18.1715616691251;
        Mon, 13 May 2024 09:11:31 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfcccsm6343620a12.40.2024.05.13.09.11.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:11:30 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so346988766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:11:30 -0700 (PDT)
X-Received: by 2002:a17:906:4a92:b0:a59:affe:b9c with SMTP id
 a640c23a62f3a-a5a2d53b0b0mr657860666b.9.1715616689856; Mon, 13 May 2024
 09:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
In-Reply-To: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:11:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh85pfJiHPPTZpknanYf6_JDEVDo=tmvtvy-XW+S7_Y8w@mail.gmail.com>
Message-ID: <CAHk-=wh85pfJiHPPTZpknanYf6_JDEVDo=tmvtvy-XW+S7_Y8w@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic cleanups for 6.10
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thorsten Blum <thorsten.blum@toblux.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 14:17, Arnd Bergmann <arnd@arndb.de> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-6.10

Hmm. That tag doesn't exist. The top commit you mention doesn't exist
under any other name either, so there isn't even a matching branch.

                   Linus

