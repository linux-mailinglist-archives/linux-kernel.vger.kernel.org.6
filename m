Return-Path: <linux-kernel+bounces-213932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03246907CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43CF1C202F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ED214A4C1;
	Thu, 13 Jun 2024 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IW0NQsVR"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4B14A4EA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307261; cv=none; b=Ngi8k0W+CIngraMlUndydeFAjvaHR3yKYqSaytPipSJZo5dM9o58K+nZ4vM1agNoBfBYlyL7jj2tthVdVU4FH5uvqZN2jVYVo7FMOErgQ+qXQbgsaOQh3+Vmsc/3Q5UGEK3K6gGhIleqXSkkYMQGYoUz+6Akq0DtIQsX9rKZUzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307261; c=relaxed/simple;
	bh=Lwk7smutNQj9Ma2l6ms8QeeuTagK4tf2FFnHtSPVUfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHEbEowI2RaHP8oLOhuqXQgY03cV7EdKXNXBJZixy+D/M/TBCi/HhAOhk1ZOSDDzrg6zGwYaFUFEQdcRXZSEjfp/8PuiEYXJaTQm0VonTQaEnNb/kkjBtFWd2QVzgI5jqebbtZTRJELywZHJWQEizeYlQWfqvQtCiY1UnNTJCl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IW0NQsVR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso2041051a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718307257; x=1718912057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZg0hrY0cl/sTszXcVnYwhyU3X3/PKHb3J+JILn3ksY=;
        b=IW0NQsVRX3Wf9NS48HWHJMiflIPZgwaLXPZm7Y8ivxdlBbR05Up0IQLkY7k58de6gJ
         faCCH/nASJG30RZcVoA+/4ErLh9YWlP4QCOQYpPqKGngTlKn00lBqRQcTseQI2OJeoQS
         Wanz8ICQM0pUsi/ikf+HpMgUVUa8P9LNjuXnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718307257; x=1718912057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZg0hrY0cl/sTszXcVnYwhyU3X3/PKHb3J+JILn3ksY=;
        b=ZwmZFEGivwgimLjLmGDRonIvoX+SRHEfC/1eiTRs7BnWgG3r3Fk582UnJ0XsiCnokO
         ERWOLoxSoVx6iXsP5p4gvMRd3QHtBn0Bf//WViZLCSxk6jJhwKIH/fRbAE/qmV/lasCs
         BDMMEnW0o8YHHtLUvn2raO3A7NH/rnWL2rIDoCKRVWFs5bU2QlKq/nNgxHdbOQ3VCxwP
         gbwlw2f0siuT+5VcwNWwnZVSDpDTqJe4f3LiAwyX4UzDJh6JABKAzZJmzCgYFVYXIL36
         McPnj+QKov/r9NBYPBrl/irQVJ3pEEbe0ScrmxfXmwUpT8m9fIl8krBKf4Y3IqBhhiwx
         D+oA==
X-Forwarded-Encrypted: i=1; AJvYcCX8WHREnnucpeEvHtU54lPHfM+3y/c+k7/ukx6Ud3K3cjm2i0QJAtBWFvM3iaC9bg4FWRpgAOEbcqbPRMSgg7cx1dICWMm0DK63LxJW
X-Gm-Message-State: AOJu0YwkjDjKC6Nm+HULZI11aSA7t4xKQpU5ivaIQEpYZNXqEKJvSqPJ
	PfQGYhmiYxPtw/utc774u9QFO4LldglF3vCEQD2doJKPrcsNYK6gEkPBhI+fVjXWdx4EgICN/wv
	o7ExpqA==
X-Google-Smtp-Source: AGHT+IFM3hJiUS1fJT6N/yGjn6oBIqxqgZ2tZSBwAeZ08NUOg12nkffoHLM5JajXkfljajTzO8v6Og==
X-Received: by 2002:a17:906:b7da:b0:a6f:4b5b:4ba7 with SMTP id a640c23a62f3a-a6f60de2641mr44359366b.67.1718307257410;
        Thu, 13 Jun 2024 12:34:17 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42ddfsm103139766b.171.2024.06.13.12.34.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 12:34:16 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a62ef52e837so195614966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:34:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1xlyHmOYhsbZFejKJGq+M67HoaUj4JCJWTgzmMvvrJHHeoB2o5PYN5mWSVMJA25jJebundGSW1PEaiA41FkLBiVAPVv/OvzGX66vi
X-Received: by 2002:a17:906:f105:b0:a6f:586b:6c2 with SMTP id
 a640c23a62f3a-a6f60dc4faemr43433766b.60.1718307256510; Thu, 13 Jun 2024
 12:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner> <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
 <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
 <CAGudoHGdWQYH8pRu1B5NLRa_6EKPR6hm5vOf+fyjvUzm1po8VQ@mail.gmail.com> <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
In-Reply-To: <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 12:33:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtoqTSCcAvV-X-KPqoDWxS4vxmWpuKLB+Vv8=FtUd5vA@mail.gmail.com>
Message-ID: <CAHk-=whtoqTSCcAvV-X-KPqoDWxS4vxmWpuKLB+Vv8=FtUd5vA@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 11:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I didn't *think* anything in the dentry struct should care about
> debugging, but clearly that sequence number thing did.

Looking at the 32-bit build, it looks like out current 'struct dentry'
is 136 bytes in size, not 128.

Looks like DNAME_INLINE_LEN should be reduced to 36 on 32-bit.

And moving d_lockref to after d_fsdata works there too.

Not that anybody really cares, but let's make sure it's actually
properly done when this is changed. Christian?

              Linus

