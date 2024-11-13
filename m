Return-Path: <linux-kernel+bounces-408174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 926049C7BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897D6B2F815
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499D2038D5;
	Wed, 13 Nov 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRse9eip"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4B167D83
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523236; cv=none; b=E0H1ChVKBh8u5f4ACzsCDuxFnf1hJGqeYmCgSkkcUZmx32Cai+X7mgERLQFcv06kRbc5NNsDtWPAi+qqyUJhjC7rbqWfwDCNMSCzS7HzWvMpByzD16ZTSNKdiAuGr+X/b0eJzhCn3EyqNRni1xYB5yzw33X/H2WLW8LDy5O1GLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523236; c=relaxed/simple;
	bh=0IhfgvbUE1b0rqbeuty/d2sa4owmpif+IBjtytGdNa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCWosgAkjkWRtXnic6aDwchNNN5mL1TJq/Z7aJq6HjiAh8qUGKiUCfkF75ovXmiP7sFQwBrTAr5I/ycyGEKX8WvdwpY5fk3HkTOijsPjAJ/99fJglZ0Iimq7V6KLYHvTL58HdXv72FKGERf0TSs6jcvKymuDJWqEPoMTounIyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRse9eip; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9aa8895facso1329308466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731523233; x=1732128033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IhfgvbUE1b0rqbeuty/d2sa4owmpif+IBjtytGdNa8=;
        b=RRse9eipGnGZhWbqzUXIvAVOp7wIlPkG8tw8cP7kJCQFqjmv0FyoSisiptq15cNfQD
         M85SuUOKQY5ZdMOfSnvWxh5Oav6juwA//DM+x25jWg+muv0QtNiQIXfPYP6CnFm0rx4w
         Ccqfs9+jMRhxAS4hVBmrH9vhpGhhS+9ol1XV8+42604A+ud4YsA2LOFpSNGUvnoMMSoh
         x/EB3wBfNirA9/Aoonjyx30551WJZ3NDrRF3xaudYQ/ncxFYOiGZES8wsmqUtWVpzKgN
         nd4pRQStB3bMQ9oOd/O4h98cURHdSHK0yKDyTyGxfXofAC+X4i0uTHt/8TROItJnRmf4
         Kdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523233; x=1732128033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IhfgvbUE1b0rqbeuty/d2sa4owmpif+IBjtytGdNa8=;
        b=eW2VVX+LWTf9F090E2gAU9joFBrxJGIOg8ANEgNiTpCmWwhoJccIVGnr6R1XCMhI7F
         iRklq3adFsmve8suVJAc4AYhkfonRj9+qABYcTN4LyXqxGH2d6qp69jYr6xe/csaf6Bq
         DGK8tgX6J6VxJtvkhN7zRn8W1EVXjCBcoDzy21TffFirb5QqRnhGkxPCTvG9ampjCsrc
         G1aY9+zzzdTIEGrnblWDpXssJSFHPiujEz5LVUd/VCSAP3n2137OxS3nXZfwFxdVAyWt
         otYe4uA65D0Q9kglt8+4aRDFHMo0BMrBQgTxzOC/rkeBZ6Ui8m5fsEriVkMbeCI812GW
         yrDw==
X-Gm-Message-State: AOJu0YxyvI4ynWTPg/kBrOzXABTkDz/rs8c3mbaAwGJsgRal7Qs1hmBJ
	5l0EuDqcMoap8KFx0mAVLSqTm3vt+A+lJUSdrklebVoLnF2fT6B9U8Y9/7xMVe2gYrjfbshJQmE
	IYrrJUBof7+wL5EEpSxn9QJFzxk7nxH7rI4L3
X-Google-Smtp-Source: AGHT+IF5wjOJaBPEZ4nz56CrqKN7iUic7DwNHhdRnoDYCM9sCmx+P0GttaB1YJaUrHtYzGBCXPKk9iwPx36odrX1SxA=
X-Received: by 2002:a17:907:7b88:b0:a9e:441c:f74d with SMTP id
 a640c23a62f3a-a9eefee456bmr1941100066b.16.1731523232630; Wed, 13 Nov 2024
 10:40:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112232253.3379178-1-dionnaglaze@google.com>
 <20241112232253.3379178-4-dionnaglaze@google.com> <6734119c1c9a7_10bb729471@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6734119c1c9a7_10bb729471@dwillia2-xfh.jf.intel.com.notmuch>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Wed, 13 Nov 2024 10:40:20 -0800
Message-ID: <CAAH4kHYJ5769aMNqu23KhEqatV2Ks58zmkP1ynhDh_uvEb8mtQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] firmware_loader: Move module refcounts to allow unloading
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, linux-coco@lists.linux.dev, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Michael Roth <michael.roth@amd.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Russ Weight <russell.h.weight@intel.com>, Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:40=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>...
> However, I think the fix is simply to remove all module reference taking
> by the firmware_loader core. It is the consumer's responsibility to call
> firmware_upload_unregister() in its module removal path and that should
> flush any and all future usage of the passed in ops structure.

That would suggest the addition of the refcounting in v1 to fix a test
means the test_firmware is wrong?
https://lore.kernel.org/all/20220421212204.36052-5-russell.h.weight@intel.c=
om/

Adding Kees in case he knows better.

--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

