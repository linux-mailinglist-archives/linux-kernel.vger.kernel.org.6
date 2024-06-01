Return-Path: <linux-kernel+bounces-197936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41068D70F4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15A51C20C4F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBCD152E1D;
	Sat,  1 Jun 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="1thZxSr5"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88EA823CE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717256204; cv=none; b=UCbTaP3eRXy/WQ2OTJVuWRfZcwgPviYybiBSXhKowyrk46+6QT7DFDBeihjgZbHxfBA11/Py7b/k+MYhLMHiBX8HXG9938oAawbw0kmvWTMO57oD6yrTYzuERbWDMAb8gwF9n1VAcOsl8LHKS1fMsR3tiFEuVNR+KD91FbmGf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717256204; c=relaxed/simple;
	bh=UJzyeKAYQUkDfPXuX4Gh0F75hNL3c58hA/E5ST/iYXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f0ET2i4GPt2mUkhqetEYF5MQBNnhNmRZY4vL4v7qABJsVVoEuyO2W4LXChitHGLMrLXCuZD8iuu3tL5x1JwU/VIyG3FlMnau9vH/KxN5mXUuqS02UQQcLp9rrB+C23qkai+ETIKJ7aNqXML1gPweXkS3/QZ6wVFhyJneJT801dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=1thZxSr5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a3bbc0209so1881110a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717256201; x=1717861001; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RG4mdKV7OIkDQVn0D+lJqcvduyeFLy88y+yPCt8VgJg=;
        b=1thZxSr5IbtFVSx14kleRZ/1r8lV5cawht7W9essypjlqjyWIaoqPCPquV7aDTtBuF
         JB2EZE6USz7N4E9G/NQ5rsvngXwKpVjoHn7lQ+cU38zTmS5e6bUOMFRWXvI33JnIPGHp
         fh/PHTCm63S13mbAEfgWUfVngBopb61zkoDs52TZJjMlxfU1lDCD8ZBHhAvIv04k0UwI
         +QR4YpwxiuSlgvqzwHZIWtXHCLpMOXWBdG8m0lZKLH+SzCOFTmsC4r2Tkops1vR9ZdzW
         zteAW8TZSFFZwDIhrZcRSSEmVBNmG+VeTW85FmkBDaytjSQbX4LtHdfRK+9JdemMwX/8
         zwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717256201; x=1717861001;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RG4mdKV7OIkDQVn0D+lJqcvduyeFLy88y+yPCt8VgJg=;
        b=kINaVw4E2zcfQnE88Cryvm4O5ACVDQwjFWm8oaNujsUMzUS8xYt49uHL44bWxTkv4M
         e6cvvuHPQhGZ6fyrBGiYVfzkzjjRS5dXiAtwMiRhsDEVtpjNwdJRg3RR7i3/aXTY9hBc
         cQrikNQStpccdEAH/mnkjdyiEhAP6aedlua6bEpFVHrdqCR2bKtYYuEKpBMzTfnhCCpV
         mlGEhz76M9WPhS8ha/tEUzZdFhQkuYeAk7NbYSBQjhdgCQTp89Hp7JgqdyFd+dacX7h6
         L8Gi3LWa8O/BNmrGZP7+jLiJXv5VF/JbnC6orwKkDQQKjmlKdyaFd60xX+RLCh687OYE
         QsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5d4GQ9gF54PXJ5LWaZ58QNaq6EmrFMQmrq3OXMke4wcq+MmZNLTomvaFlEuHza022cwKBPKZMt5KBWpcCaaz+LEL1xAUQNwxNEtpC
X-Gm-Message-State: AOJu0YyUN1uRIHyA/xVjQB5Tj9QTJivmyJkmipOUcitkkEHlL5rlONTE
	f6zK8d9BZuY/zd8/6JOcNRAuoeD31syci4NBO+3Vs/xkBSxhsHT+eJFJVhCqSRw=
X-Google-Smtp-Source: AGHT+IHlPfHm7R5+PsnhAdZL8Bjz73GnNc+xErZ2ejagpR66zS69NtSW4diw3pf6CusB73or4F1ZUg==
X-Received: by 2002:a05:6402:2313:b0:578:f472:d9d5 with SMTP id 4fb4d7f45d1cf-57a364ac87dmr3114186a12.37.1717256200889;
        Sat, 01 Jun 2024 08:36:40 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d4b6sm2348973a12.74.2024.06.01.08.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:36:40 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Damien
 Le Moal <dlemoal@kernel.org>,  Bart Van Assche <bvanassche@acm.org>,
  Hannes Reinecke <hare@suse.de>,  Ming Lei <ming.lei@redhat.com>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Greg KH <gregkh@linuxfoundation.org>,
  Matthew Wilcox <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <benno.lossin@proton.me>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  Niklas
 Cassel <Niklas.Cassel@wdc.com>,  Philipp Stanner <pstanner@redhat.com>,
  Conor Dooley <conor@kernel.org>,  Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>,  Matias =?utf-8?Q?Bj=C3=B8rling?=
 <m@bjorling.me>,  open list
 <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [PATCH v4 2/3] rust: block: add rnull, Rust null_blk
 implementation
In-Reply-To: <ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com> (Keith Busch's
	message of "Sat, 1 Jun 2024 08:24:29 -0600")
References: <20240601134005.621714-1-nmi@metaspace.dk>
	<20240601134005.621714-3-nmi@metaspace.dk>
	<ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
Date: Sat, 01 Jun 2024 17:36:20 +0200
Message-ID: <875xusoetn.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Keith Busch <kbusch@kernel.org> writes:

> On Sat, Jun 01, 2024 at 03:40:04PM +0200, Andreas Hindborg wrote:
>> +impl kernel::Module for NullBlkModule {
>> +    fn init(_module: &'static ThisModule) -> Result<Self> {
>> +        pr_info!("Rust null_blk loaded\n");
>> +        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
>> +
>> +        let disk = {
>> +            let block_size: u16 = 4096;
>> +            if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
>> +                return Err(kernel::error::code::EINVAL);
>> +            }
>
> You've set block_size to the literal 4096, then validate its value
> immediately after? Am I missing some way this could ever be invalid?

Good catch. It is because I have a patch in the outbound queue that allows setting
the block size via a module parameter. The module parameter patch is not
upstream yet. Once I have that up, I will send the patch with the block
size config.

Do you think it is OK to have this redundancy? It would only be for a
few cycles.

Best regards,
Andreas

