Return-Path: <linux-kernel+bounces-181259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B08C79A4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DF11F22BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E514D452;
	Thu, 16 May 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1jWd0x/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD98F66
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874220; cv=none; b=kSd/jykUtzdSNVMfgfIeodsfmysjqukbH7b+vvgcItz58FbvhJBLl41ZSpeX7t+U9b4VcU57zzuT2YpueruqXwQPbxEgw8i88dy8PHluf8yeiCww3d1hbB1224xBx9rPvfxft+0fTrQK9n1LUe4YfKDbuo745T5S7hMw5xJ32Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874220; c=relaxed/simple;
	bh=IoDvkvHXw1HR8wRbwehqcSi7peKYNyi9CZ1OaH+EN9E=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AT7+jviQqpSd0Ut8Cf1n2q7sjZRMTWI538N6qKrjDHxk5pQqUUzaN1DUSmZqLx5k4DMcbYxz36iNwqHltindz31Ajvxillp0Z7ffNH6q04OHuhQoo3R+8yU43s+DN6v3GuFYBL1zoG7f21C0A1ivr7cQLlEOsmWF9HHHoZWNBYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1jWd0x/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715874218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+3Q2pNlPjK1FF8Uf4iS6y9B02F58xnA/27DRhKkfIs=;
	b=H1jWd0x/E7otnS3jZXQGQ3HI5HxPRb40XC4vPB5BaqOURpgIMAnhz2gCbCFLWl+mulxtUC
	zc3izgdyzSfi+QpNCe1WsR/Z7pkdZ1I7NylIXI7k7/0gOMNxI+B1wHTQdr1qsrEaAX4xrs
	6q51Whks/JhQ3CYmRXdQLzd680Q4GE0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-BGT-_8W_NO2PuVVVk5HRWA-1; Thu, 16 May 2024 11:43:36 -0400
X-MC-Unique: BGT-_8W_NO2PuVVVk5HRWA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c9992bad97so5394326b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874216; x=1716479016;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W+3Q2pNlPjK1FF8Uf4iS6y9B02F58xnA/27DRhKkfIs=;
        b=fiiwnpmxAOINtvdTSasJSgRMEV9h8XzcOtRObjKHAF1muiVr8TZ0YH8VLpH/z/4/os
         7Rk0d9nwHGKNV/3f47jbltMA9W0TS2BxtVA/TxfUEhxNiUfMfVpNMw+Sb+wpmx58em8q
         9a24V6TsJF40NBxQLpFqoOfD4TzUZl4aDB7A4AoJWyL+/UbaQnMn4dQqfTGwfYuE4wRd
         G60tggFIp/bXyVAfcQXtecSVgpWc1M6V/QDsbsotAaIcgyAWoC696UHcKB4FsMyrPeIv
         S8egjesLtOHTirclpnXr2tiBdY3C/qBITQTlwcP51Icn1SlLn8T4p490tfHmSVXOZks3
         J8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+D2dEUGctRLmXVdUl9U+S3Vzkcra/tM+1f1zCxNBNmHv5B6MnIdwWnQ97zM3Nlx2HzLAMV0DRpqBXSDYIXl/rpjpgMBlK26iLmIg8
X-Gm-Message-State: AOJu0Yw/eO9RW9mcZ0lHNFPci+Y2fef71LaR0b0mSEe+9ZHhEb+QiWO6
	v7kXr7/nt2Yyadac+THK52Gb6YOBNeQpxT3YHphfk43dYCFEh4FRf2mlJYwjbN8rTk83ZoVJoPX
	xzo2RE9aClONg6A6a1pf81S/C51lH1BGce5limv689fZ/LuLMvbQSbjVnkF31aw==
X-Received: by 2002:a05:6808:148f:b0:3c7:52da:2055 with SMTP id 5614622812f47-3c997035756mr27286627b6e.2.1715874215823;
        Thu, 16 May 2024 08:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOCCsTNyW+7WaF4mJb+63faC/dTk6Tdyxind5u+rzkVS12U49UBoYVqxzoUBzxfysS0QYUjw==
X-Received: by 2002:a05:6808:148f:b0:3c7:52da:2055 with SMTP id 5614622812f47-3c997035756mr27286598b6e.2.1715874215414;
        Thu, 16 May 2024 08:43:35 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:a03a:475d:8280:d9b7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e3c475eb3sm12545921cf.82.2024.05.16.08.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:43:35 -0700 (PDT)
Date: Fri, 17 May 2024 00:43:31 +0900 (JST)
Message-Id: <20240517.004331.1678192397138539146.syoshida@redhat.com>
To: ryasuoka@redhat.com
Cc: horms@kernel.org, krzk@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: Fix handling of zero-length payload
 packets in nci_rx_work()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <ZkXQ5h8fla1KhX6A@zeus>
References: <20240515151757.457353-1-ryasuoka@redhat.com>
	<20240516084348.GF179178@kernel.org>
	<ZkXQ5h8fla1KhX6A@zeus>
X-Mailer: Mew version 6.9 on Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Yasuoka-san,

On Thu, 16 May 2024 18:24:54 +0900, Ryosuke Yasuoka wrote:
> Thank you for your review and comment, Simon.
> 
> On Thu, May 16, 2024 at 09:43:48AM +0100, Simon Horman wrote:
>> Hi Yasuoka-san,
>> 
>> On Thu, May 16, 2024 at 12:17:07AM +0900, Ryosuke Yasuoka wrote:
>> > When nci_rx_work() receives a zero-length payload packet, it should
>> > discard the packet without exiting the loop. Instead, it should continue
>> > processing subsequent packets.
>> 
>> nit: I think it would be clearer to say:
>> 
>> ... it should not discard the packet and exit the loop. Instead, ...
> 
> Great. I'll update commit msg like this.
> 
>> > 
>> > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
>> > Closes: https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/
>> 
>> nit: I'm not sure this Closes link is adding much,
>>      there are more changes coming, right?
> 
> No. I just wanna show the URL link as a reference where this bug is
> found. This URL discuss a little bit different topic as you know.
> 
> In the following discussion [1], Jakub pointed out that changing
> continue statement to break is not related to the patch "Fix
> uninit-value in nci_rw_work". So I posted this new small patch before
> posting v5 patch for "Fix: uninit-value in nci_rw_work".
> 
> If Closes tag is not appropriate, I can remove this in this v2 patch.
> What do you think?

I think this patch, continuing the loop after freeing skb, came from
the following discussion:

https://lore.kernel.org/lkml/Zi-vGH1ROjiv1yJ2@zeus/

In such a case, you can use Link: tag with the above URL and mention
it in the change log like "As discussed [1], ...". But this patch
small and clear, so I think the current change log is enough to convey
the intent of the changes without external link.

You may find the following document helpful:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9#n115

Thanks,
Shigeru

> 
> [1] https://lore.kernel.org/all/20240510190613.72838bf0@kernel.org/
> 
>> > Reported-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> > ---
>> >  net/nfc/nci/core.c | 3 +--
>> >  1 file changed, 1 insertion(+), 2 deletions(-)
>> > 
>> > diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
>> > index b133dc55304c..f2ae8b0d81b9 100644
>> > --- a/net/nfc/nci/core.c
>> > +++ b/net/nfc/nci/core.c
>> > @@ -1518,8 +1518,7 @@ static void nci_rx_work(struct work_struct *work)
>> >  
>> >  		if (!nci_plen(skb->data)) {
>> >  			kfree_skb(skb);
>> > -			kcov_remote_stop();
>> > -			break;
>> > +			continue;
>> >  		}
>> >  
>> >  		/* Process frame */
>> > -- 
>> > 2.44.0
>> > 
>> > 
>> 
> 
> Thank you for your help.
> Ryosuke
> 
> 


