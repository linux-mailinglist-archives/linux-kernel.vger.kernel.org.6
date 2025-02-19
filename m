Return-Path: <linux-kernel+bounces-521578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72DA3BF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510D73AE694
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CD71E25EB;
	Wed, 19 Feb 2025 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="ip/TB7ID"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493C1E0DE6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970502; cv=none; b=t7hYmYOTIl5RPuHSdlltiLN1kVOxKybc14nyq2pdrqShTMPP1Xy4vyBM2lhIwmNvhFmaUorrQ66GyTevNhsjpBCvzJBJuWWgdV4jp8WbNpE4vg+M98YQI2ir2sjP/eN7MOs1sxTam6YA6eT3l856cKtQ5pK8peaMoMC9rMFLQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970502; c=relaxed/simple;
	bh=MUhvxhHnTvoE+duYjJ7YbfPA0nuYQDtOLydS3RR3bNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=di2Ua+RBCZqm2YCyYiB0qetgcuA+5fZjIr2B3NoqTf5tNgKhPd4XdAzFDozLBUvwvu3XGy6JjfwaO+m9DnQuIr/E0PxM8ZSzFsfuPVL3BagYyyaxYiEqSqtnT7ZiQJ1r0roJQg/R8C5dTSB+eQ4zbzZYA6F9Zdi3XslL4APBhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=ip/TB7ID; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DB479240103
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:08:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739970498; bh=MUhvxhHnTvoE+duYjJ7YbfPA0nuYQDtOLydS3RR3bNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=ip/TB7IDhMIQBrxv5ZON8tNAZXnoPpCv7swSA+9nyHr9JlsuQkJR0Oa/vvntc9oVx
	 sBGRthB9zPcW17zuXayNeZQZGS8UBdN3V1WuYMKBsMEK1thvF2L+EW2DCw7IqzgZbw
	 DTCTZRTQFonfQlrxL2QB1Lmb317ygzAtLvrcLynAh6/HpyGiTqwrq0PMAhuvBQetXP
	 iuyUnl15TN9jko8YbXw2N2YYV5VDjhQl+zyO1S3ZEDlkrWQxV5g0KynaKfp14+aYe4
	 f+kPDRX94qlyIGUvYzLqkR5HJUKmbsR9X+a+8mNndFx/+AqryeXOmP9OtjH1/FPwrD
	 e0QfjGqX80W4Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YycC36ZPlz9rxQ;
	Wed, 19 Feb 2025 14:08:15 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,  tmgross@umich.edu,
  hkallweit1@gmail.com,  linux@armlinux.org.uk,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  netdev@vger.kernel.org,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: qt2025: Fix hardware revision check comment
In-Reply-To: <c83a4d5f-3e98-4fec-a84a-669f04677774@lunn.ch>
References: <20250218-qt2025-comment-fix-v1-1-743e87c0040c@posteo.net>
	<20250219.100200.440798533601878204.fujita.tomonori@gmail.com>
	<c83a4d5f-3e98-4fec-a84a-669f04677774@lunn.ch>
Date: Wed, 19 Feb 2025 13:08:07 +0000
Message-ID: <87jz9m13rc.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Lunn <andrew@lunn.ch> writes:

> On Wed, Feb 19, 2025 at 10:02:00AM +0900, FUJITA Tomonori wrote:
>> On Mon, 17 Feb 2025 23:53:50 +0000
>> Charalampos Mitrodimas <charmitro@posteo.net> wrote:
>> 
>> > Correct the hardware revision check comment in the QT2025 driver. The
>> > revision value was documented as 0x3b instead of the correct 0xb3,
>> > which matches the actual comparison logic in the code.
>> > 
>> > Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>> > ---
>> >  drivers/net/phy/qt2025.rs | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
>> > index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..7e754d5d71544c6d6b6a6d90416a5a130ba76108 100644
>> > --- a/drivers/net/phy/qt2025.rs
>> > +++ b/drivers/net/phy/qt2025.rs
>> > @@ -41,7 +41,7 @@ impl Driver for PhyQT2025 {
>> >  
>> >      fn probe(dev: &mut phy::Device) -> Result<()> {
>> >          // Check the hardware revision code.
>> > -        // Only 0x3b works with this driver and firmware.
>> > +        // Only 0xb3 works with this driver and firmware.
>> >          let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
>> >          if (hw_rev >> 8) != 0xb3 {
>> >              return Err(code::ENODEV);
>> 
>> Oops,
>> 
>> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> 
>> Given that this patch is expected to be merged via netdev, you might
>> need to resend with a proper subject:
>> 
>> https://elixir.bootlin.com/linux/v6.13/source/Documentation/process/maintainer-netdev.rst
>
> Please also include a Fixes: tag.
>
> 	Andrew

Hi Andrew,

Included it, as the documentation states.

A v2 patch is up[1].

C. Mitrodimas

[1]: https://lore.kernel.org/rust-for-linux/20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net

