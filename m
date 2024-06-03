Return-Path: <linux-kernel+bounces-199079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29E8D81E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C39286155
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0E9127E06;
	Mon,  3 Jun 2024 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="nTU70QEU"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8151272C4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416454; cv=none; b=G5wkRYw5QuxUYG+3yoWdkjLt6m+5gy/JYQOOJvfN4lMQcwt2lPbkvvm0tdYsuqefbl0xK4U9Yf8Jfn95o1O5ibed0FgzDDNsKB9PHb09AcuNR6OXkLXq6H8RdL9GsqloIlJhVKzKJCbu7e0LYu257Rfyusg9J0ArrNRHdkIkkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416454; c=relaxed/simple;
	bh=TB8VSntBE0Ss5wM4wicbPwjXWZHfn1704FZN+zL4DsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fG0J00/ECqSskYZFpMgREECtOxvuAwiLTbCGvepw0rxNQSUiz3l90rOd4NUr7+X+KiZMK9Pj1bM0L7dtOThtEDu8FipIW7K3swT9GjAM5WDI0o/BrPb+AiHTt2H1Hd4WTrRu81h/Nx7m38cRtQvt/gMf6tDT4fgVBGFZpBnvyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=nTU70QEU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4212f0444efso22497425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717416451; x=1718021251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yeQ7CDIW6189ZyaxtGLD/570sICh6jaYTVsWRbXXec=;
        b=nTU70QEUlk2zdFar4i7oXvIQ6fjH9OwZVZCzxzAkfCI3Ml/Q7qiP5r05xTh2QXztjR
         Ws4na4Zn9QvnMus497hZ+M9Pc20qX+wqmHbgt+04RoaWIg5ad2vmFmU5h4xvV/AuBgsb
         jKV7Q4s48BkmpHi8VGueG0is+s8Na/c5i2TPR7wgO0Z96CTVOcWhoEOllYSW648AuOPv
         GbfoMi00SgO+DMcGSB7+dR97QYg5f2qmAOGX+PHfb5pOrb2KGFG/7AHD4k6mlDSspvhP
         OJGxWpX82bhrFY9+saxl089LzMlIAUiPUMQ7huO7Zuip0/lfkoyNGPyl4dzova+TJQ2j
         zj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717416451; x=1718021251;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yeQ7CDIW6189ZyaxtGLD/570sICh6jaYTVsWRbXXec=;
        b=nayG2EOP/pmb4nzrXfvr1KeFVP/k/o35zJGc10hSWEcv1D83OvTyCTn1HsgeOa+NVq
         9osUOzof2ZEFljBhpgpGJxW85X/qHkaPzzYT+tA9xPOiIzkTjg8VTwKwxBz4gcZv4ITE
         4Uhgo8fzhxqM5QAOLzKIvI4GKvn3Afmn44dTBGOlsZo+cUF9GGDMo+Gxd5HhJY/pXy2x
         UkocO0aMdZaUJD/OUH84JV3GGKTddk+/9y+j+gd7RFC/bjfUv6uFUYjjlqxV07gdxy0h
         VdYaqo3jcx9AuLYOg9hlbo6oeAz6uQDZMdDwLawTYPgOJg54eYmOskB02uW38x8+9rKi
         I1Og==
X-Forwarded-Encrypted: i=1; AJvYcCVIZIj3IGyvRGee5ai3Y7ZDG531m6vFmnip2nJE3sCM7U6L9jscecKBG6FbVxiHGcmt3SdsV5tTj0mYvfK1qrjgmzmtmXtIvKpDCE7W
X-Gm-Message-State: AOJu0YwC1v4bHk5+Pn7P+QUQIJ1SshyHTGBpSGoSNBwqKBNMo4FUfFE4
	2Oxx/cBjpK12hMwBCxnf6sCLhe2iCw3mQoh51EmKoBAT2pgt8KttZZPNOVNUUZs=
X-Google-Smtp-Source: AGHT+IHRrt8E0vOepLzP9fOjqNLrwzjRMRHtLRiwGP0Im83sdAfyEtoFfO79EVxyHzzmioHETf/MBg==
X-Received: by 2002:a05:600c:4f48:b0:421:35f1:804f with SMTP id 5b1f17b1804b1-42135f1822cmr44023435e9.25.1717416451438;
        Mon, 03 Jun 2024 05:07:31 -0700 (PDT)
Received: from localhost ([165.225.194.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064bba6sm8572365f8f.104.2024.06.03.05.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:07:31 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Hannes Reinecke <hare@suse.de>,  Keith Busch <kbusch@kernel.org>,  Jens
 Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Damien Le Moal
 <dlemoal@kernel.org>,  Bart Van Assche <bvanassche@acm.org>,  Ming Lei
 <ming.lei@redhat.com>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Matthew Wilcox
 <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Chaitanya Kulkarni <chaitanyak@nvidia.com>,
  Luis Chamberlain <mcgrof@kernel.org>,  Yexuan Yang
 <1182282462@bupt.edu.cn>,  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado
 <sergio.collado@gmail.com>,  Joel Granados <j.granados@samsung.com>,
  "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,  Daniel Gomez
 <da.gomez@samsung.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,  Philipp
 Stanner <pstanner@redhat.com>,  Conor Dooley <conor@kernel.org>,  Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>,  Matias =?utf-8?Q?Bj=C3=B8rling?=
 <m@bjorling.me>,
  open list <linux-kernel@vger.kernel.org>,
  "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
  "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
  "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v4 2/3] rust: block: add rnull, Rust null_blk
 implementation
In-Reply-To: <CAH5fLgiSCTa=BCr2aGZBhsY2gvctE9OTFFA5CNiVR-YGbXhgxg@mail.gmail.com>
 (Alice
	Ryhl's message of "Mon, 3 Jun 2024 11:06:57 +0200")
References: <20240601134005.621714-1-nmi@metaspace.dk>
	<20240601134005.621714-3-nmi@metaspace.dk>
	<ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
	<875xusoetn.fsf@metaspace.dk>
	<ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>
	<0a47eebd-2aca-494d-814b-bc949b08630b@suse.de>
	<CAH5fLgiSCTa=BCr2aGZBhsY2gvctE9OTFFA5CNiVR-YGbXhgxg@mail.gmail.com>
Date: Mon, 03 Jun 2024 14:05:03 +0200
Message-ID: <87bk4imdu8.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Jun 3, 2024 at 11:05=E2=80=AFAM Hannes Reinecke <hare@suse.de> wr=
ote:
>>
>> On 6/1/24 18:01, Keith Busch wrote:
>> > On Sat, Jun 01, 2024 at 05:36:20PM +0200, Andreas Hindborg wrote:
>> >> Keith Busch <kbusch@kernel.org> writes:
>> >>
>> >>> On Sat, Jun 01, 2024 at 03:40:04PM +0200, Andreas Hindborg wrote:
>> >>>> +impl kernel::Module for NullBlkModule {
>> >>>> +    fn init(_module: &'static ThisModule) -> Result<Self> {
>> >>>> +        pr_info!("Rust null_blk loaded\n");
>> >>>> +        let tagset =3D Arc::pin_init(TagSet::try_new(1, 256, 1), f=
lags::GFP_KERNEL)?;
>> >>>> +
>> >>>> +        let disk =3D {
>> >>>> +            let block_size: u16 =3D 4096;
>> >>>> +            if block_size % 512 !=3D 0 || !(512..=3D4096).contains=
(&block_size) {
>> >>>> +                return Err(kernel::error::code::EINVAL);
>> >>>> +            }
>> >>>
>> >>> You've set block_size to the literal 4096, then validate its value
>> >>> immediately after? Am I missing some way this could ever be invalid?
>> >>
>> >> Good catch. It is because I have a patch in the outbound queue that a=
llows setting
>> >> the block size via a module parameter. The module parameter patch is =
not
>> >> upstream yet. Once I have that up, I will send the patch with the blo=
ck
>> >> size config.
>> >>
>> >> Do you think it is OK to have this redundancy? It would only be for a
>> >> few cycles.
>> >
>> > It's fine, just wondering why it's there. But it also allows values li=
ke
>> > 1536 and 3584, which are not valid block sizes, so I think you want the
>> > check to be:
>> >
>> >       if !(512..=3D4096).contains(&block_size) || ((block_size & (bloc=
k_size - 1)) !=3D 0)
>> >
>> Can't we overload .contains() to check only power-of-2 values?
>
> Rust integers have a method called is_power_of_two. If you need to
> assert that it's a power of two, you can use that.

Thanks Alice, that is much easier to read =F0=9F=91=8D

BR Andreas

