Return-Path: <linux-kernel+bounces-254673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A59933623
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34794284770
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BFFE57E;
	Wed, 17 Jul 2024 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f8yPgeit"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C436FC7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721192297; cv=none; b=BLYREma3cydtP0rOaKk57nnv0o3QESXorhUE+2yvXfS3LTFyERor+nRcIypYcCQJWdYajb0MPDc2uwd5H6QvNG13SJNE/1IBT5XAuOD/OU+C6ZyPsL9NArk7To2ttnERG31B4S5zJ5kTBnesk9dbl9Lnf62y7WHmzbEabWRchwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721192297; c=relaxed/simple;
	bh=vABRMnRmbUscNHZGwHRUTWrzrPZYmjEVucxlkyKGsgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Azbf0rdu5DEOAZpUSnhsdb4skk806a8G1eTnoVERPXBU5KJGaj7z3Uz7vqP4xB5o41LdXdq6Scl9rNRSh8cqteHpVHazTzVEV84kIfyrRcPBwyOZOzT9BH8QYbUYjBAIKUaBKP2yytT04Uf/Pp3Fvc6wIyzWfKORzgW+9YqClJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f8yPgeit; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so1559905a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721192293; x=1721797093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=f8yPgeit0trPzf158mBqmJrixK99hTAkVQWEJBF7IGRUhObT2moHckMFsWDXHW06qi
         pDj0PhhQGv/QgPVG86oQOs3G7msAs52ca66pnqSDSFcieSy0841w3J/H4vO4t9ZH6Upr
         /iwTO1Z07JhObsbU1W2dhBgmKuuWHrb6Et6q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721192293; x=1721797093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=CX/CiC1FVRHNbvtP5Lwxvz3uvZX4e9h4l/Ku2QPkABZzsORe4qBIifujqW1cfNBK0T
         Zb4sQxunItLLVIztN3pol38ItfGRYwg1eU8ZtL41kKHkcgg9AtpcegwZeFbnkQqNQvZw
         AROn6h886+1wxz80ACDTuZEu5U33A8FLEVz/vRDTKBb0OLPiEbKTkLcq0W/O+V1LJxY1
         Zh5tvKW3Eo5nQ26YawukDMjI84q5wcg+JUDH4wPqoCDcM1g+njTgOZH3bdL168dqeHkS
         Zewm1bg303PAZHk0HfWCgbHuj+vxtpntyfDv6J0jx9bgR2lMePxsTWLZ1kTjSdCnFkUy
         9axw==
X-Forwarded-Encrypted: i=1; AJvYcCXTd5zW7/HI4S71xI2r38O8vIr7NkVFQjC5hEXUHKearBQ5lyFu9heKt1B59M1IhaqGE0veuAeaMgQdKCwA5UtfGZ/+1Nac7EVJDKZK
X-Gm-Message-State: AOJu0Yzq1+4sZIUeP6gyBE+2PfZo0YgkHA/0Tj1DRNbxwx6XZEiwPy+T
	elfgVOBl8NxPPIQXUrXKPeitS/5irp3LA2e4SRRb+vp66TgQ7bXH6/3mG788dc9e5NaDqxZHFtY
	XxSH8XQ==
X-Google-Smtp-Source: AGHT+IH1uVcxY44278mQ1GTdECGY70RpdtjQ5432+l+7r1Qm1TvMmCtKVUqbbBuIjpS84Po46/yraA==
X-Received: by 2002:a17:906:ccda:b0:a77:c080:11fa with SMTP id a640c23a62f3a-a7a01337711mr32339666b.48.1721192293412;
        Tue, 16 Jul 2024 21:58:13 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff8a9sm400932466b.163.2024.07.16.21.58.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58bac81f40bso7700756a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzQt5VV7W5+qaLZfbpv/eSmZ64hi6NHy86UMCGxoY94o5xkiQODP2re5+V7BTC2YN/bDSxI9zqtGMhrcGtJD5Lbr0Rg1Wyrqkv4cGj
X-Received: by 2002:a05:6402:5244:b0:57d:4d7:4c06 with SMTP id
 4fb4d7f45d1cf-5a05b7ee599mr504374a12.13.1721192292251; Tue, 16 Jul 2024
 21:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com> <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
In-Reply-To: <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 21:57:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I don't see those either (this is an x86 defconfig example):

Note, it really might be just 'allmodconfig'. We've had things that
depend on config entries in the past, eg the whole
CONFIG_HEADERS_INSTALL etc could affect things.

And yes, I build everything in the source tree, so $(obj) is $(src). I
find the whole "separate object tree" model incomprehensible, and
think it's a result of people using CVS or something like that where
having multiple source trees is hard.

              Linus

