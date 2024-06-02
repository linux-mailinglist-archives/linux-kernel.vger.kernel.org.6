Return-Path: <linux-kernel+bounces-198180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A38D7497
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2EA281C23
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8CC2E651;
	Sun,  2 Jun 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="mrPD/MEG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA392C684
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717320487; cv=none; b=YvsW/qZkDX9pd5sTtjmCJycPK0KR2EBJm1Gg5b5SUZwJY1Dg91Kx2HaKgwBvq9mgQqwepCiobQEFQ3c1/qjV6riELFTmp+cAinMwqJ5f3C4pnvaaAgo54CNRVJi3GPDi8vOHJoaOLzyMZQGkEcasHFoaLiWLdafoU7u4yNQlr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717320487; c=relaxed/simple;
	bh=J6TIPS1GAf2SCnwgcDej5TyjCcgyhxhkgcJ3f/46rQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EZ+5wcNSLje0p2BQvZmtHUoGouI6qOOKDm5lXUKPlw0smLw+xeubPUcBOzVRloSP9UeaAOw07qbp3Bt+VVJ1GGYwk4U1EEdWacdbDsQJO0x3V4BNLJD6lAOnzUfvZZwRJUYDAI4x8sfFBoszURS6iSo3HGc2DTCIYT9FTxgkIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=mrPD/MEG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a683868f463so247338566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717320483; x=1717925283; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJwF3q+t+A1DpoaxsaOYNQPfvGAIw2IDRpun6/tsk/o=;
        b=mrPD/MEGRoyx2A9ueQ+jZ6rSYNqo5bJctavsrZ3W8CN7Hd4EIMyNmhDvDBf0KEBmfu
         IlGHXQHHYfLJy1INosOhOlifsqz8WOO3tOaB7KHpCZ/LaFXOsiAx9eroArEhdVpU9GPt
         DDsRgzQR7DXG7rYJ5QmWzVwdCPHYdb/R0bEU4jaswHhPKELa3mJ2m1oZw7de0/GeO12h
         8827Jn5TjM7NhnH/hfTzHufrAbWS+pMWdens59YHGwl+KAnG0xQ2cZLi9C/rVeNaJ0QT
         e128x20f7pmPaEg827F5MSkJBXBuC4saUtIOffBz+k7JUWNNu5ZWDdfISdDv5uLQbIKM
         kj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717320483; x=1717925283;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJwF3q+t+A1DpoaxsaOYNQPfvGAIw2IDRpun6/tsk/o=;
        b=LhUfUcdKXNv6EgfifLNy1Y2sgwCKUEMfBF8YA/I8kS0bhsp0b527IO21KOF2PgcBJ6
         IXbvStoJjKcl0PgUs4A7SjAzisApQHyGHxDxxfTdrvO4eQMzuPjMfWpk190QIdHdnsEM
         AvjDTcf3ok5gEGG5HHlDAqA8qs8xROnDPbFcM44ECJKJ4AdnwTQZ6+avhTQQNsjuWoH+
         6/jRR/TRCNhArkhBSl/0n21YMm8dQbJ0dJbQtdpNlFGnNhWNJcZS79MqJKdNU0ZMrV6a
         KRWiecerNcZFhSoArqFqFyqqXrun0XPVoCiy9b4+QQMLrLqxk+we2Lss+v2SNNfjVxwe
         uQOA==
X-Forwarded-Encrypted: i=1; AJvYcCVWU9BnxJD7+bmQXlygruGuPKbIZJ5Enm3UoIUcxTQyDMlILNkc8FbOVPhN8VlBvlwQnMg2Z7bmdHEh696ifUwFRgTfCw+8YVrGyMKV
X-Gm-Message-State: AOJu0Yz7px8lZbAr5rEgiNA5lTHsel/E0O55Xrdz09wJJctm/hIIagNZ
	Z8S2t59l11z53VccapIkmRLaN1hSX+VTAWNVYSEBtV4fg5bgTleMXCORt0CqfIQ=
X-Google-Smtp-Source: AGHT+IGFlfYHryGwagfRHunmriFz3Ud/gnVhIdpwenAZTGPR/AZRD0JBNNJ2v6tqbUTBYOKFrCwy/Q==
X-Received: by 2002:a17:907:9284:b0:a62:5ff6:c728 with SMTP id a640c23a62f3a-a6822157081mr494056866b.76.1717320482689;
        Sun, 02 Jun 2024 02:28:02 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68c162a69csm155894266b.187.2024.06.02.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 02:28:02 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>,  Jens Axboe <axboe@kernel.dk>,
  Christoph Hellwig <hch@lst.de>,  Damien Le Moal <dlemoal@kernel.org>,
  Bart Van Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  Ming Lei <ming.lei@redhat.com>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Miguel Ojeda <ojeda@kernel.org>,
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
In-Reply-To: <ZlvrwbQ1WJZQ6_KR@casper.infradead.org> (Matthew Wilcox's message
	of "Sun, 2 Jun 2024 04:49:21 +0100")
References: <20240601134005.621714-1-nmi@metaspace.dk>
	<20240601134005.621714-3-nmi@metaspace.dk>
	<ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
	<875xusoetn.fsf@metaspace.dk>
	<ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>
	<ZlvrwbQ1WJZQ6_KR@casper.infradead.org>
Date: Sun, 02 Jun 2024 11:27:55 +0200
Message-ID: <87sexvn17o.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Wilcox <willy@infradead.org> writes:

> On Sat, Jun 01, 2024 at 10:01:40AM -0600, Keith Busch wrote:
>> It's fine, just wondering why it's there. But it also allows values like
>> 1536 and 3584, which are not valid block sizes, so I think you want the
>> check to be:
>> 
>> 	if !(512..=4096).contains(&block_size) || ((block_size & (block_size - 1)) != 0)
>
> I'd drop the range check.  We're pretty close to landing the bs>PS
> patches, so just
>
> 	if block_size & block_size - 1 != 0
>
> should be enough of a validation.

Is it safe to do so already? Otherwise we just remove it when it is
safe, no biggie.

> Is it considered "good style" in
> Rust to omit the brackets here?

Yes, the compiler will complain if you add parenthesis here.

```rust
fn main() {
    if (true) {
        return;
    }
}
```

Building this will give you:

```text
warning: unnecessary parentheses around `if` condition
 --> src/main.rs:2:8
  |
2 |     if (true) {
  |        ^    ^
  |
  = note: `#[warn(unused_parens)]` on by default
help: remove these parentheses
  |
2 -     if (true) {
2 +     if true {
  |

warning: `playground` (bin "playground") generated 1 warning (run `cargo fix --bin "playground"` to apply 1 suggestion)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.64s
     Running `target/debug/playground`
```

If you omit the `{}` block after the `if` it is a syntax error.

Best regards,
Andreas

