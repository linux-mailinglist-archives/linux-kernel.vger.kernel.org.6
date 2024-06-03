Return-Path: <linux-kernel+bounces-199080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07788D81E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896C41F25C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36DF128363;
	Mon,  3 Jun 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="CzLaJWYv"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10C127B40
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416456; cv=none; b=RLdEfMs73d9hLKRqpdNAWfD5DdgRgp1IL+3j74vVpypILJ5DVe3/fychRX7X3ACsFl4ATU9bKrR1G9DwUK/n9nLRN1qKyotjr+7czbDmKYYuZazMDAQvSNhdd2VhRVQRMBJmv13LnWMQ8BHUjxZbWBsyCwHK6nEuP6HugZm+2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416456; c=relaxed/simple;
	bh=HKSuZku3Cjx589sVTPzEh7UJFBNrnrV54/ShUb7zzP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2VpbPHEtVNK3Up4imusAagX0CWGrGcZJKQ8I0GEVRVBXNcTVj44KYCY0A7QyR+AUEXiK2KrAm+SCDJ8mz0LOZXNHFVlk0EDAQfMWDAsC9g6pKx4UtenVvT4jyuPrzVcuEUGT7iZyU1sEDumvBWW3s5QiVFjqo+FHOhPBMj5Vkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=CzLaJWYv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b950aa47bso2039157e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717416453; x=1718021253; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qp9kpSxktdl3t5QptSg4ay9ut9mo2kwGjiti3usGOlc=;
        b=CzLaJWYvJIPMuYNShj9hqXtOdVkzbsqs6C2Mxa4kKnR8eR2SFnJA0wDZiHIyOcN9i0
         +MvxUWIXlxK6oML9+9l0cdOC3cSDMH/FS5pYmXcgfqO9Sq8f1P5gb9gTpc19AWtQaB5i
         AlwHgFVTzfowsyYWDeBz9cteMfj5PwI6+Q7UzXixT8X8nAchnR/kIVR6vLasCHiyBE7g
         ODwprmWc+pxiCSYHa9JAJuIRF5UoQqorefxHo65NIfGNiVdz+j1gl+XacbbzKN7qL0XR
         iALmTwuSmmX+ZNxFYpWRSTduASj9LVevRIxDm+FeZtQeNDLVl4Vh43IAU40lObwxsWv4
         yv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717416453; x=1718021253;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qp9kpSxktdl3t5QptSg4ay9ut9mo2kwGjiti3usGOlc=;
        b=q6vP1FkZlp1vW4GkkAsojM/X67DTL6UBmMJ0FJaGdBaHv0lL3hk1pmIINrQJKDTECe
         Iryz8MCl2/4Lom5LMmWjR6PJDHUKQ5UZXzI3xDnU7XfCiCvJG6L7ag+dIjHQ2F7GQV3a
         cIdrBD++shzaJgasQNGUAlLGkz7lZI/0UHsdMuYHXdg8moeEPS37I03D8CrmiU/yqedH
         Lii3KW91JXCVauV8y+mpdKKZt50Jc6K9vXsMt274H9piSmzQw0S+fA63+G1PTdR9CuVl
         QoS/nEUQlsBxcUEMeJHuqs3x+XF3yBt3gco9gpVEM/HzCjaAavxI6Hg32d8UNSwEXkiH
         hGwA==
X-Forwarded-Encrypted: i=1; AJvYcCXTjuQfqvxPSJUMcOu3eZ93Mv7CUz/RLSRIVBSCGPrej30Aflv/J7U2ZkVyhbj9LPqvoGkUMWCrxHD4Gt76eznkEAh7J6FmsXMsNgia
X-Gm-Message-State: AOJu0YwDwxG3+L94AXrz5w1OlWVIeQRC8a8Uwkob0Nvr4/YSI94gFEkr
	qSVdhXZT9a7pa+ZnGtj3gCnzVijytpiWmbY++F4mpXouf6IROF3xdC/ZetPHPmo=
X-Google-Smtp-Source: AGHT+IG95U4cvzKCqCJC//mHEC5cwihIOE7E6yEp2LTEdM2o+aM+R0L+4dCYqsxwbWfMmXDgcOyfsQ==
X-Received: by 2002:ac2:559a:0:b0:525:32aa:4449 with SMTP id 2adb3069b0e04-52b8958ba33mr5060953e87.5.1717416452482;
        Mon, 03 Jun 2024 05:07:32 -0700 (PDT)
Received: from localhost ([165.225.194.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e574748ffsm3619750f8f.87.2024.06.03.05.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:07:32 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,  Jens Axboe <axboe@kernel.dk>,
  Christoph Hellwig <hch@lst.de>,  Damien Le Moal <dlemoal@kernel.org>,
  Bart Van Assche <bvanassche@acm.org>,  Ming Lei <ming.lei@redhat.com>,
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
In-Reply-To: <0a47eebd-2aca-494d-814b-bc949b08630b@suse.de> (Hannes Reinecke's
	message of "Mon, 3 Jun 2024 11:05:19 +0200")
References: <20240601134005.621714-1-nmi@metaspace.dk>
	<20240601134005.621714-3-nmi@metaspace.dk>
	<ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
	<875xusoetn.fsf@metaspace.dk>
	<ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>
	<0a47eebd-2aca-494d-814b-bc949b08630b@suse.de>
Date: Mon, 03 Jun 2024 14:07:19 +0200
Message-ID: <877cf6mdqg.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hannes Reinecke <hare@suse.de> writes:

> On 6/1/24 18:01, Keith Busch wrote:
>> On Sat, Jun 01, 2024 at 05:36:20PM +0200, Andreas Hindborg wrote:
>>> Keith Busch <kbusch@kernel.org> writes:
>>>
>>>> On Sat, Jun 01, 2024 at 03:40:04PM +0200, Andreas Hindborg wrote:
>>>>> +impl kernel::Module for NullBlkModule {
>>>>> +    fn init(_module: &'static ThisModule) -> Result<Self> {
>>>>> +        pr_info!("Rust null_blk loaded\n");
>>>>> +        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
>>>>> +
>>>>> +        let disk = {
>>>>> +            let block_size: u16 = 4096;
>>>>> +            if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
>>>>> +                return Err(kernel::error::code::EINVAL);
>>>>> +            }
>>>>
>>>> You've set block_size to the literal 4096, then validate its value
>>>> immediately after? Am I missing some way this could ever be invalid?
>>>
>>> Good catch. It is because I have a patch in the outbound queue that allows setting
>>> the block size via a module parameter. The module parameter patch is not
>>> upstream yet. Once I have that up, I will send the patch with the block
>>> size config.
>>>
>>> Do you think it is OK to have this redundancy? It would only be for a
>>> few cycles.
>> It's fine, just wondering why it's there. But it also allows values like
>> 1536 and 3584, which are not valid block sizes, so I think you want the
>> check to be:
>> 	if !(512..=4096).contains(&block_size) || ((block_size & (block_size - 1))
>> != 0)
>> 
> Can't we overload .contains() to check only power-of-2 values?

I think `contains` just compiles down to a simple bounds check. We have
to do both the bounds check and the power-of-2 check either way.

BR Andreas


