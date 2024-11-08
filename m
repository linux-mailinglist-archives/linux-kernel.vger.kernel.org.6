Return-Path: <linux-kernel+bounces-401844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21009C2011
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DADB23752
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB011F584B;
	Fri,  8 Nov 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFDuU3qv"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E21F4FCA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078589; cv=none; b=Z087tSDzCfhIJRDfm/riv35/QEx/F5qVhpq/zGJDTw1HWNIDNxa4ZKaSmF/n/0HpD/pVVsTSeHZigzANKpGFA31ZGMF2w8kUeEOJBdmPga0/b23Ju0y8LwPf+3BnmVDAosM0S3JOrgE3c/r9CR5ptU3aoK+KCb75Fr/eoRwyuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078589; c=relaxed/simple;
	bh=WWobBNbc8std43mAl9oOLK3yZADy11XppbfYg3UJpIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHyJPbkauLC38OlER2FTnGbfhY3y/GBJTx2AjfXQ/GRcr1KJBCW0XqwToNVwm/61WACFoefh0Ibx1UBJNsyfeJCYEZ/XghsIO0HDMziDuZGr7bAxqZMkMZu6DpqLbJj17iPWUv30upm8k1ETtDqs/dBSuEf4ydkqhqtaiA3Nc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFDuU3qv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d518f9abcso1482767f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731078586; x=1731683386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0Y20ZGw6VIkAHfF/nG04r8GFP8QBth8w2wpI9SxI1g=;
        b=vFDuU3qvD+q7vk9zQ7+gVZU6LE202DSbPdIn6cJrGjbajhfhVBMo6WnHpSti4cWB+e
         yAfV3a6gpQT65Qzjqc5rqvZkfeWKTMDlnado/adiZ40iSegDPgnHE/wE2tqFl3AXzeUM
         A0AnOUWXjaX6TKoi7H10Cjli5wCaQCe2A0fkbvCtL90brho8R3/w590ftIXenUBHO0bN
         IqMigU03MPJn0H3ZjhxMJWvEPf+n7VcXJfHowYeg3PN1Z8C8QhK33Y3Q5FtALDXFSACP
         +wqEOAiTyJpjWR7Tw7rLOZxxOoRt1qB3Fg4L3dYEkjEwQ4yu21RS/GRjv/eJu6gMYoAc
         WlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731078586; x=1731683386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0Y20ZGw6VIkAHfF/nG04r8GFP8QBth8w2wpI9SxI1g=;
        b=WBwHic4+SCnnyR+URgjPKO3RzKT0mOqB2jK/NVPlNmsYFjzp8IkFpU/Vcg24ICqTO4
         YTbCg/dsrgZdq4GnSk0ZaBJtDc/RWvFwijl1RRMQqlJk59AKiN49I31qRwpVctrdTjKt
         DFE3vkWAqb/SYxpFyCf90t5Sq2UzuO6wwE6OqoaeX+sS2kas3gilywv5TY3vpmJyfcw2
         b7sdhPRxPNwdvEJNeXdIC7lM1WQmbGOfb6NW8TXzOFXr3nFJVofE5/rtBenWEl5MRgb8
         jIB+I53Ys5uDV75LVz3oiITp+HKT8xD21IZ7j0mSjVAqAS6YsKyK10+aKX5cnnm4cT1A
         duBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoDZHAroRQ2wzLI5A7V3xErQmNhDqUdYKokBpnGbMCsauRX7JicBlBGZIbgRnmrnskd7uQY7GK5tC6HkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3x8YrAnvMVg8+/sBRocjjPi4dL6/pytZBKF3yfikazHTe1kI6
	EW+PXtfB/F3IrCofSpDO4E0x60zpjGzLrLvhEeMhQvGl7g212HTxUFdi4GnSIN0i8GJ76X5tswe
	pTCWycXBDRMetXm4bAdwHAcYlMwOaUCzOK7ko
X-Google-Smtp-Source: AGHT+IES+Hl8iF3LurHv10XvOQKy83Hjruto3wN9CubJIV2SIrvfaeT7wZWaUKilQZrRm2QltGwV9qkY2kNeLnuOTHI=
X-Received: by 2002:a05:6000:709:b0:37c:ccad:733a with SMTP id
 ffacd0b85a97d-381f1891ca4mr2638151f8f.59.1731078585970; Fri, 08 Nov 2024
 07:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108152149.28459a72@canb.auug.org.au> <20241108095933.72400ee1@gandalf.local.home>
In-Reply-To: <20241108095933.72400ee1@gandalf.local.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 8 Nov 2024 16:09:33 +0100
Message-ID: <CAH5fLgj6zSDH6Oe3oqfE7F+NQSgSLxh8x7X3ewrrDAdOHOh0YA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the ftrace tree
To: Steven Rostedt <rostedt@goodmis.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 3:59=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 8 Nov 2024 15:21:49 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > Hi all,
> >
> > After merging the ftrace tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > ERROR: modpost: missing MODULE_LICENSE() in samples/rust/rust_print_eve=
nts.o
> > ERROR: modpost: "__tracepoint_rust_sample_loaded" [samples/rust/rust_pr=
int.ko] undefined!
> > ERROR: modpost: "rust_do_trace_rust_sample_loaded" [samples/rust/rust_p=
rint.ko] undefined!
> >
> > Caused by commit
> >
> >   91d39024e1b0 ("rust: samples: add tracepoint to Rust sample")
>
> Alice,
>
> Can you send a patch to fix this?

I'm working on it as we speak, but I haven't figured out how to
reproduce the problem yet. Using allmodconfig builds fine for me. Any
ideas?

Stephen, is there any more information you can share about this? What
versions of rustc, bindgen, and clang are you using?

Alice

