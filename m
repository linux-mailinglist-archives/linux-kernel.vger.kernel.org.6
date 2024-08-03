Return-Path: <linux-kernel+bounces-273329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431F946786
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 07:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E311C20C8F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CB13F01A;
	Sat,  3 Aug 2024 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b="RpFIvgg3";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jQMFBPtO"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14542A82
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 05:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722663251; cv=none; b=qBmaxlDjTkFrqIVXg8BmPM1VXvEXP8xc/Ly7DGdSBuSmkjtK9Rc6AsKnFjmjr3UNi8bgyDUdBY73knT42BHWUMp5KLe814lYe9BnTfA4Rc4ty6B2Jztzv6ahwGZYr/NcNVZ0MERM8JJ3f+Z3LtTaHWcGBw9z7JZF0doUs0do+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722663251; c=relaxed/simple;
	bh=EF6NEO5ohC294DVJau6zkSdXtr8oG5BVcmFPCUicuLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gF/goui7ScmU3fLY2clC7w/ZJYUw6e47WwaE25ujziI8EtAM3dUqUYWKlwvhUJOGzbdu1/U9bYPBoU/M63qLvpESDq5oQUblmwSFvVWFbvjDhsmD7ozjFE5t2bo++Q5gqAzmwf1g+ybJIYDClcXble5mIO1g+Rz/ADubecfaDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name; spf=pass smtp.mailfrom=spwhitton.name; dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b=RpFIvgg3; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jQMFBPtO; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spwhitton.name
DKIM-Signature: a=rsa-sha256; b=RpFIvgg3MrETYEC6o4HRMsx/LVlHrzozOsJWBfEyRNvwBg/p2LEL324+G1JdlPE6/rGCLkMMzSZqJrsz22ZIaPTItH6OWr7H3jWcR1951jKZ1J1deErFB/MTOhp9zN4M1XUKMxIdgGd7vjq7AXvofEphDtmtYdANBT6vIUUx46RWu4Uo+a8hF23JVwM/Abne469on8M9ZDTscsdToOp6zN0iD06qhfgyrI6pF9bq8ENc4isbroIeMyjNebc63FTsI0regbmijh6ZXdlh/09Uizqh/qntL5mgDICKrnhOy74/BZoCxTfawTmsCOYqcVVLPkFTkoADovlvu4q19wWxmQ==; s=purelymail2; d=spwhitton.name; v=1; bh=EF6NEO5ohC294DVJau6zkSdXtr8oG5BVcmFPCUicuLg=; h=Received:Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=jQMFBPtOk9WYTSq69gzV6jiwUoxZ54KNa59vycUW4FTrK69E2ZUigvBrrQr/VKoJ+NV4/RApaSAFCJCUQitPQJHtI8mAS3tJBPtnTE5n/SamLQWMdalauP8pYZUZ2iKwZP+0N/KQtNRuvf3H/8mqStyVwhFme04e/vMxnl33/CEp/4IhXLj9yRFNjdi4T5CmM+cxl6BEl4MMP2G2hudm8Fh1tWvq1F1XEDceGE1cI3EsbM0pRcNYFymNSH4FMWzzBFbs5+bnWr4BH73ns7437oXozhBP7y0Vlkl94ndVhiYnIIyJ+TQVaLu+y56PK6UTg/G6RRyWiDXpuKDtfWGYsg==; s=purelymail2; d=purelymail.com; v=1; bh=EF6NEO5ohC294DVJau6zkSdXtr8oG5BVcmFPCUicuLg=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 20115:3760:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -537863146;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 03 Aug 2024 05:33:47 +0000 (UTC)
Received: by melete.silentflame.com (Postfix, from userid 1000)
	id 2151D7E3E0E; Sat,  3 Aug 2024 14:33:43 +0900 (KST)
From: Sean Whitton <spwhitton@spwhitton.name>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  ~lkcamp/patches@lists.sr.ht,  helen.koike@collabora.com,  Hans de Goede
 <hdegoede@redhat.com>,  Mauro Carvalho Chehab <mchehab@kernel.org>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-media@vger.kernel.org,  linux-staging@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: atomisp: Add parentheses around macro
 definitions
In-Reply-To: <8d383b9d-d029-4706-91c5-9623fddf5df3@suswa.mountain> (Dan
	Carpenter's message of "Fri, 2 Aug 2024 23:28:43 -0500")
References: <20240730062348.46205-2-spwhitton@spwhitton.name>
	<2024073020-reload-vanquish-f937@gregkh>
	<87v80i475p.fsf@melete.silentflame.com>
	<8d383b9d-d029-4706-91c5-9623fddf5df3@suswa.mountain>
Date: Sat, 03 Aug 2024 13:33:43 +0800
Message-ID: <878qxe41c8.fsf@melete.silentflame.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

On Fri 02 Aug 2024 at 11:28pm -05, Dan Carpenter wrote:

> *You* need to figure out what the proper thing is.  Not us.  That's the
> difficult part of writing a patch.  Once you know what the correct thing
> is, then the rest is just typing.
>
> That business of defining STORAGE_CLASS_SP_C is weird.  Figure out the
> authors intention and find a better way to do it.
>
> Figure out why your code compiled as well because putting parentheses
> around (static inline) is a syntax error.

I asked follow-up questions because it seems like at least partially a
matter of style to say that the business of defining STORAGE_CLASS_SP_C
is weird.  Maybe there is a better approach than what is currently done,
but maybe there isn't.  Maybe the checkpatch warning should just be
suppressed (if that's something that can be done).  I would be grateful
for some additional pointers.

-- 
Sean Whitton

