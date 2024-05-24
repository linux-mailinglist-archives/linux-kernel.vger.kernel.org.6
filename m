Return-Path: <linux-kernel+bounces-188395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785718CE17F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3873728259F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB91128396;
	Fri, 24 May 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dP+TaCAX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B21208A1
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535553; cv=none; b=rAHOlbxv7122Cf0HNQPHMQFNSknqqjY6pRCP6+ISV0mehMUTu5iVHtbWB4PLF75DzR3ENrN4v8fMisZL3rsdJW0xAS4/7BeNHUyiLJTWE7L0sYCooE09C8cgbyxtEEwL4q5NneBrEnkmJpGbtYRraqVY53l2ewg8pJJTJWNl0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535553; c=relaxed/simple;
	bh=DrrjnXApjK+HxHK4YGZUVCcRJ9u8TFMUw+Sedw3rW20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPa/R3rRFS7Z2ylVDNnxpBFb1Xi/a0XBRlrw+AZGK1WzezZx4+7mjWvOn/ndwoiI/m6hw7dxCtomo50WTZPEYNWnz+IYHT26Lt+zVesZnvdJlVtcfNbKEuUeGMT34cjV6IcJnnz6vtTiowHNd7h86383noN/yC9Qu5WWnIfNepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dP+TaCAX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716535550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PzoNctDwu2m6AmJa5cOCmGwkuh/QFbymJSnZ7SGPShc=;
	b=dP+TaCAXYvkgKM4vntFC7f3Qzpxy/PvvE/sMppFZzzQraptPijRLjoi8YN0bKPHrI5bXyT
	Cp20/fEZpqtV1vdX2gY9+cRaMddQbmWc9YT6wI7blC0PO8kBDxtV8hSda2fp8R15e76I+3
	8agjuYei7Vpyvqxf2OAtuzC4pnh4vxE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-5lzUPSedPhG3FRcZpRpd4g-1; Fri, 24 May 2024 03:25:49 -0400
X-MC-Unique: 5lzUPSedPhG3FRcZpRpd4g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2bf5ba94169so792820a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716535548; x=1717140348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzoNctDwu2m6AmJa5cOCmGwkuh/QFbymJSnZ7SGPShc=;
        b=OghvGuPClEegolNH0d8nMvIzUrdJiWOY8PxMVSz4N393ShLiGXXASucSc3CMiZB5oi
         6PjfNJUZ00yCAf3C1d9mChOep4/SL+8DysXGwVxaP0FemptmuqQftSm02oaA75923OjJ
         lRCqMdUocY+Iy+A4kTFTtEbQ96tX4Imojc+xUjA1hPl1PDYsYItMO57JnE2MEZdSK5BF
         ORnm4CF9r6r06RmoGLPOT2aE/aorB8aVaPS+kLUQ3GXcL+0W2G8EJVYp/n1Yhcp7Rf8b
         ZixRFXtzvqSZthglWxCLFry/teO/kG56yJd0IXZiTPNEfKRivh/Ea3qYZz50xzmW5Hql
         +7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUV2US3W8r0YPdVKMarb3+pFyA1vmH7EzRrSY9GOdlvpqqihF6pjDMaoVTLynz8WmkzreZqzi27/ZjCK/Dhj6+95EtPI5CVshAPZjIt
X-Gm-Message-State: AOJu0YzrmmltFtdz5BzovVMFeQ4jQGoLNUvzve84uGcnfF0CNwV0BD6N
	Rv5hazy0FpECuDIsG2KGD2tbTF3l+Axgzareian5cMvozV++yDoqqFVh/52ekirhpr3TPlITYXf
	x7stOwWTFflLCFaJkp+M59KfhMcymIir3i7vrOfFR6jpZVXB/ysNrvlQMjOpMpQ==
X-Received: by 2002:a17:90b:3110:b0:2bd:d680:3c8a with SMTP id 98e67ed59e1d1-2bf5e139562mr1478934a91.5.1716535547504;
        Fri, 24 May 2024 00:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Oel1WZj5nAuJTGDSIq3qNp4/LOi5MgmRKqKyhKbREm4bXAiRorKX9Z+oY2dV58dic8Rx4w==
X-Received: by 2002:a17:90b:3110:b0:2bd:d680:3c8a with SMTP id 98e67ed59e1d1-2bf5e139562mr1478897a91.5.1716535546660;
        Fri, 24 May 2024 00:25:46 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdda14e538sm2655538a91.49.2024.05.24.00.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:25:45 -0700 (PDT)
Date: Fri, 24 May 2024 15:22:17 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <nfe3elcoihbt2g55upa3y5r3bfapngh6yudicyhjqcjczzgswo@cb6h4fl5vi6p>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-2-coxu@redhat.com>
 <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>
 <y5ogivx7qbdm6u37t5o6na4jewn6qofzrbibnsneoqlwns63y5@eg62cytuvwql>
 <ZkwRZxGw2dWStd1C@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZkwRZxGw2dWStd1C@MiWiFi-R3L-srv>

On Tue, May 21, 2024 at 11:13:43AM +0800, Baoquan He wrote:
>On 05/21/24 at 09:58am, Coiby Xu wrote:
>> On Mon, May 20, 2024 at 02:16:43PM +0800, Baoquan He wrote:
>> > On 04/25/24 at 06:04pm, Coiby Xu wrote:
>> > > Currently, kexec_buf is placed in order which means for the same
>> > > machine, the info in the kexec_buf is always located at the same
>> > > position each time the machine is booted. This may cause a risk for
>> > > sensitive information like LUKS volume key. Now struct kexec_buf has a
>> > > new field random which indicates it's supposed to be placed in a random
>> > > position.
>> >
>> > Do you want to randomize the key's position for both kdump and kexec
>> > rebooting? Assume you only want to do that for kdump. If so, we may need
>> > to make that more specific in code.
>>
>> Thanks for the suggestion! Currently, no one has requested this feature
>> for kexec reboot so yes, I only have kdump in mind. But kdump depends
>> on kexec thus I'm not sure how we can make it kdump specfic. Do you have
>> a further suggestion?
>
>I remember you said kexec reboot doesn't need the key passed from 1st
>kernel to 2nd kernel because the 2nd kernel will calculate one during
>boot.
>
>kbuf has the information, the similar handling has been in
>kernel/kexec_file.c:
>
>#ifdef CONFIG_CRASH_DUMP
>        if (kbuf->image->type == KEXEC_TYPE_CRASH)
>                ....;
>#endif

Thanks for the suggestion! I'll wrap related code inside
CONFIG_CRASH_DUMP.

>
>> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> > index 060835bb82d5..fc1e20d565d5 100644
>> > --- a/include/linux/kexec.h
>> > +++ b/include/linux/kexec.h
>> > @@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
>> >  * @buf_min:	The buffer can't be placed below this address.
>> >  * @buf_max:	The buffer can't be placed above this address.
>> >  * @top_down:	Allocate from top of memory.
>> > + * @random:	Place the buffer at a random position.
>>
>> How about a comment here saying this is currently only used by kdump.
>
>No, it's not good. Please don't do this, let code tell it.
>
>By the way, can you rebase this series on the latest v6.9 and resend? I
>rebase my code and can't apply your patchset.

Sure, v4 was sent.


-- 
Best regards,
Coiby


