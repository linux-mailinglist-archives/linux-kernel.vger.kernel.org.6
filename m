Return-Path: <linux-kernel+bounces-521590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C66DA3BFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A045E16FB44
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7127D1E51EE;
	Wed, 19 Feb 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="ivX5hMkR"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7E1E231E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970870; cv=none; b=PpqvyuzcWhQgB4kH+LoB6QU/EEkFCp3qqCx7AUk4olY+gVYGzOm+1c4JouGkGjRsj9vZuYeMNJ+7O9VOfKKo7CwR/X0RDXMauSz0rf/XXx6m8Hkg3ycnZLHlxaTY8HgFEqwv/Yk7krVXV5S/UBi9vUbiD2qAy7GpCcAtNFi2EpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970870; c=relaxed/simple;
	bh=aBfhyYh/1maY07Q3PbKHHzGC1Nn2vhQfeMDonwvAoC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rucOHBbAFkI/MwmhAn3k+eKSZzXNXaY7wMYfn2URRIfarIsee6Pav+ME6zIEKifXnnTzeQ/H5KFiTzOve90BibVdD+6T6S6Vv4qTlo8sBcY+jCX2RHdl9VB3Pumu5k3aMOenZ1SpoSP3dRQEDeOtN5/aaiERF1v7wCEcWUJeJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=ivX5hMkR; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 56BD2240029
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:14:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739970867; bh=aBfhyYh/1maY07Q3PbKHHzGC1Nn2vhQfeMDonwvAoC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=ivX5hMkRQiJpX7exH3lWbAu8F/Smqy5GXQuLoXf/d0vGZ/tX0gOg3fumXRcyFcPKL
	 7rlPrrdXDFpav5U7pUx7C4nUUAhkxPJ1/e86pm00K5saCeJVPrWBA6s1UdQaNP5rcG
	 kpATJA0RdRKdVOXhLt42KN5HhLGjf6MIUCblig1faF7TYv72+FX7oWCOBeKHGmyASa
	 sfE1TPUDzGNrVp5ledMQh0yesk/UJYAXCBHZKRySEeRfABJ4u38w2yOB+oHKp7g5PK
	 soepbQ2FT2TOQU3VyYdQsKEigyMarLz0CxuvD3LmAVdmqU3A9pkE2mFzjDgoiVCo6w
	 KAA+s7VBG5gPg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YycL90VBdz9rxK;
	Wed, 19 Feb 2025 14:14:25 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: tmgross@umich.edu,  andrew@lunn.ch,  hkallweit1@gmail.com,
  linux@armlinux.org.uk,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  netdev@vger.kernel.org,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: qt2025: Fix hardware revision check comment
In-Reply-To: <20250219.100200.440798533601878204.fujita.tomonori@gmail.com>
References: <20250218-qt2025-comment-fix-v1-1-743e87c0040c@posteo.net>
	<20250219.100200.440798533601878204.fujita.tomonori@gmail.com>
Date: Wed, 19 Feb 2025 13:14:16 +0000
Message-ID: <87zfiiyt3r.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> On Mon, 17 Feb 2025 23:53:50 +0000
> Charalampos Mitrodimas <charmitro@posteo.net> wrote:
>
>> Correct the hardware revision check comment in the QT2025 driver. The
>> revision value was documented as 0x3b instead of the correct 0xb3,
>> which matches the actual comparison logic in the code.
>> 
>> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>> ---
>>  drivers/net/phy/qt2025.rs | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
>> index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..7e754d5d71544c6d6b6a6d90416a5a130ba76108 100644
>> --- a/drivers/net/phy/qt2025.rs
>> +++ b/drivers/net/phy/qt2025.rs
>> @@ -41,7 +41,7 @@ impl Driver for PhyQT2025 {
>>  
>>      fn probe(dev: &mut phy::Device) -> Result<()> {
>>          // Check the hardware revision code.
>> -        // Only 0x3b works with this driver and firmware.
>> +        // Only 0xb3 works with this driver and firmware.
>>          let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
>>          if (hw_rev >> 8) != 0xb3 {
>>              return Err(code::ENODEV);
>
> Oops,
>
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Given that this patch is expected to be merged via netdev, you might
> need to resend with a proper subject:
>
> https://elixir.bootlin.com/linux/v6.13/source/Documentation/process/maintainer-netdev.rst

Hi Fujita,

Very helpful; didn't think to check the Networking subsystem workflow
docs.

Thanks,
C. Mitrodimas

>
> Thanks,

