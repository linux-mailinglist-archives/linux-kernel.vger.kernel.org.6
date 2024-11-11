Return-Path: <linux-kernel+bounces-404868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6359C4960
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB249B22202
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C91BD032;
	Mon, 11 Nov 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkRD84Ud"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C58468;
	Mon, 11 Nov 2024 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365916; cv=none; b=jmebbjqBui+/RyLIPEfRu21x6xhItYqnFeGvHtDRqBg2h+4jgbUTbw0dYjmmsAGTHe3eUMsHdotEYrrrs0ttf+jTmsfu4FTDpx2Wht9Z26ZLDrgZFw2+UprkLCpWK5crNduSpXaLePM6Em0qo9t8KlhMS645AoZDzK+/znG1kQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365916; c=relaxed/simple;
	bh=QBxO2beGb702TUptZzPVEp3r/vThbAYJ4Humv9sdi/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmEyMOchdvjTgD1eD+z0zqnUb23SCZ/FfomsYamaom4kgqd3lpN658+gdCYLY5p2QejKZKqbSV/FrbdZ6xN7QYywTEuzZ+k69pPdWcSBnonPCeICii+QbkqZEJ8JbIHnaGhaoCVx9FfNuFvxrza1HIXAfF6I9BwarCpyDT+B2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkRD84Ud; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85054107836so1811738241.3;
        Mon, 11 Nov 2024 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731365913; x=1731970713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsifnW581PltcYhZ2uCG2F+RlDUiyCr2zolEtVcEoyc=;
        b=TkRD84UdU0ZpyD/x8quqw0HGkUjavxhwzp5JfKHC6c9WCeAG/wlM/vQj9czWq69rfy
         2JhZ4+c5NvePTVAS+NBrEN4MDeBI8Y8KN4xzlH828fC4AbNpruciq0be5QLdywr9eddk
         v3++aKq6rv5FZ+clPNxNmB6y7oSLdQYTb5ozG91DyOs+aRLZUCi171Bus6Jq/vIJy3Vz
         mjO1l1Bi+4YQ7/EV9wV9GVtIA3s4pLYrnUeIX9l7IerQdRA14kllh1yLg7Ba0UdcoR8U
         f3tfZ6PEUvkk9uXJLpwnrGCrqoZdbebE5f7FGK0OvtrYjpwq/CE17QjVsm/7BlztMj1O
         /Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731365913; x=1731970713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsifnW581PltcYhZ2uCG2F+RlDUiyCr2zolEtVcEoyc=;
        b=kOD004x9NASi2mQFaXijfM4zyiQSnek3Tz7mdacVL5yXPuYQgKsHT6U7xdVpt8XiEB
         3tColHlsQ1UCVM6kS5hqIpy5a3ysvtS6yT7eNU5zGArxN4npUz4qFGpxOg2ifDzCkEKj
         pHfUSh/QsrayWE7FSwg5ZhiiV1mi35R0v71bC3qW8p9swY8UAIul7lmyLlda9wVYyF1S
         7sUzgasq+mNEaoASNYDyKUFE9xlHkmxUBlFIntGynTiChOUZ4hRH7n4m5Ynu5RnebEqm
         EicPsHgQnJSbM2gd3QeBWLC5ZeNxUe6gD0fu238QH53rPCNphCjF29KYtyfrL9bqohoL
         AtYw==
X-Forwarded-Encrypted: i=1; AJvYcCUa8zjSywTIS/cnkCeaT1zgfLzW3bVhnBdZUANcqbNkX+arx6vUvTJanc/V/EhDc/mT4rssXJM7KzwbP4SN1CQ=@vger.kernel.org, AJvYcCW0gGR4Uh37oflJhfiCNsYSwJh8b2g4B6AZayYZPnSuVEsSxkpSOJr5VL1qTmbxFCtSkZ6eVs5DnZcBUTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaE/LO2I+60wiE8utgbmyMrMJPQ29WJBe50vRvuaPo8hczhFrl
	JZL2KEvmsfJCFlHb6SMHuTYV6zuXI7oqg7NSDmvnRyeLDoOHJuRVPEpQvjnrX+50dXlV9gbVmjY
	aGoh0EcxT1QZNIDtQNnrR3YPiRNM=
X-Google-Smtp-Source: AGHT+IEWRoi6tBvIXIEAjCCEv9bkVAcC3LAGFzr1vnQaJGYyNdNQOe6AwRKFYXd6fAfHpioMGj8lz6HF3NUuhu9k0jg=
X-Received: by 2002:a05:6102:38c7:b0:4a3:ac2b:bfff with SMTP id
 ada2fe7eead31-4aae16623d6mr12871748137.22.1731365913427; Mon, 11 Nov 2024
 14:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111112615.179133-1-alistair@alistair23.me>
 <x6OyXuGQi1xeknAX_pjcl17BOpxRM6OGtLWGhGOH4LUgghJaP29a4ebzCT21QdfxBb88PwZCc2U7zizrTTSzVg==@protonmail.internalid>
 <20241111112615.179133-2-alistair@alistair23.me> <878qtqt1n4.fsf@kernel.org>
In-Reply-To: <878qtqt1n4.fsf@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 12 Nov 2024 08:58:07 +1000
Message-ID: <CAKmqyKNjjELzVbWgBHaHr8N1XnOJHk-U6RfLyb-FbTJ7h9jPoA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] rust: bindings: Support some inline static functions
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alistair Francis <alistair@alistair23.me>, linux-kernel@vger.kernel.org, 
	boqun.feng@gmail.com, me@kloenk.dev, benno.lossin@proton.me, 
	tmgross@umich.edu, aliceryhl@google.com, gary@garyguo.net, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, alex.gaynor@gmail.com, 
	alistair.francis@wdc.com, bjorn3_gh@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:07=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> "Alistair Francis" <alistair@alistair23.me> writes:
>
> <cut>
>
> > diff --git a/rust/exports.c b/rust/exports.c
> > index 587f0e776aba..288958d2ebea 100644
> > --- a/rust/exports.c
> > +++ b/rust/exports.c
> > @@ -18,6 +18,7 @@
> >  #include "exports_core_generated.h"
> >  #include "exports_helpers_generated.h"
> >  #include "exports_bindings_generated.h"
> > +#include "exports_bindings_static_generated.h"
>
> Generating `exports_bindings_static_generated.h` depends on `exports.o`,
> which depends on `exports.c`. Does this not create chicken-egg kind of
> problem?

It is a bit confusing as there are a few levels of autogeneration, but
Make happily handles it.

`exports.c` depends on `exports_bindings_static_generated.h`

But `exports_bindings_static_generated.h` depends on `extern.o`
(extern not exports).

`extern.o` then depends on `extern.c`

`extern.c` then depends on `bindings_generated_static.rs`, which is
generated by bindgen.

So there isn't a chick-egg problem and this happily builds from a clean tre=
e.

Alistair

>
> Best regards,
> Andreas Hindborg
>
>

