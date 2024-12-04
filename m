Return-Path: <linux-kernel+bounces-430396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE909E305C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6092D282EE8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832E84A1A;
	Wed,  4 Dec 2024 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEq+fYpp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D310F7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733271924; cv=none; b=PVcXfVV1RCbYWqp7ocC+QVZap9TSaUGLYt4bJfAWpuj9Wg9wbig/sL1PFSlhzbFNNh0QDSGhR98snUwn6Z23owfgbhRNZoBPVKUVyhfZzEhPm8RJDFw1DWuWl8Ugvx/k0LOpVv6jDlrTFuK2yjlnoYdgcUq1IQ4BCPXbISDfs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733271924; c=relaxed/simple;
	bh=Lo4binRsBPqUS9D7ps9nWAoRIkP/rPdP6eMaYI/rZXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cv3cgBcTdoY5J3V2ZGjOpx+AqA256/9Hef1vUD2oLqoO4G5gy50zaJntbuY1IAQktXrGLSvrSZagwfK6dZCDLHGhjH1q3LORNkSUNZdogsudiI0kR71dZDn5w+4Sk9eIy35Bc3gQsNw27ij06vlNaX+Q7D4fqC+tfe/INn9cmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEq+fYpp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733271922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CwFWi8FnvUArl8TpMTnNDME1h0hBhCfwwVFx5ADtG4=;
	b=VEq+fYppt2nN+jYLX2lOVVcbfrSsxQFT74oZQVBBIswZ/pnVdNiQGMbief5rKIqr1qaucr
	6jalJQNzZdwej1GYzG6Ooy8yf/Yfh09k6a4Fr+AVw0ZGnOLm4KLa5vvIitM8tM0P3PCN5G
	GUKCX9LfhLDNtLOG1dlLcHdTUFysFk8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-PAL432vhM2a6HZv4RxD70Q-1; Tue, 03 Dec 2024 19:25:21 -0500
X-MC-Unique: PAL432vhM2a6HZv4RxD70Q-1
X-Mimecast-MFC-AGG-ID: PAL432vhM2a6HZv4RxD70Q
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8858be197so73249326d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 16:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733271920; x=1733876720;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4CwFWi8FnvUArl8TpMTnNDME1h0hBhCfwwVFx5ADtG4=;
        b=s+d6EziQ0jjkwrhFpeszVtmOCop97Z5Gu9BoEKaZy9meL5mclYi6f+zVkciHue1vV7
         1lx4jw32XuW0TMiKQOl5+MrImnUim835jjWPIZ69QYLntaNs7YkDgFZ2yAkEy3g57f7J
         zDxDGvTh4zeDfClBVBBlTU9BugnUHeV+QVqeIYgC2rI0iDM0DJJy6AOC0Chp8ix70YXu
         hAKxlgxAQ1SJyCX3PnV1CKZIMGqSZdgQEAMMMgFUk6EDQ4gw4p0YubBgt4Di3yok881A
         NowsB9+S44EH/XOHx4Du7MNsJyyOzHpDpOLdSqFv6yK2JmO0T42yCA9mKPSWD19ZgKQB
         I5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUsjtDw7z0AHE1Yx5M+XIT+V7TBjTwksUza71cx7sii09v/5RK36Mj8nO+ewa27irVQ4E2KBYeheoRDASg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzkdoeJ3x5BS2LOR7aoqi1j0FR0lBO0Gzw9jZNTHAXrgdtejP
	RFdyQOVMvpLvCkkS9S26Ji4W7sUG3mCRqrHW2JEQZYd2jIJU+sL9OA4NvilKoLFWhRQkPN56Pgu
	IcqzSI7ohX6YKvTbZKYYqu9EmRD7a8rLAUqedFBbd9KzfUy5mhFI91Rizgb2JaQ==
X-Gm-Gg: ASbGncuvY5DlUXNT9PpGKAYLj+n7raHQq0bWs55tkZcyePfytgN55nnFSh3i1leTkUv
	kxa0VecaNNFR3d/wjy1Z18eHkOwm/XUFRUfGDJGEgHXrD+kfWL0a/Wqy3Wkmx6D7j+eP5GgZNiV
	cAHxb/elVLVWIZBx8lVmz5l6GGumGCt4y6A0dvf/cS66dvHz90zYzthJZqf5lVL1b0KrCR5tlFa
	950+lBRQSV2dnUivATrzt8fh3uJLvtHI8xDCojoHPzkDJis4A==
X-Received: by 2002:ad4:5c88:0:b0:6d8:9002:bdd4 with SMTP id 6a1803df08f44-6d8b73c3e99mr89495636d6.28.1733271920449;
        Tue, 03 Dec 2024 16:25:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoezrTh1LfZQDXek3/OWCukqKJgO2GNowhr0mwrxAz8KSLIusKbWlk8PbDDhkEiuliYGIwDw==
X-Received: by 2002:ad4:5c88:0:b0:6d8:9002:bdd4 with SMTP id 6a1803df08f44-6d8b73c3e99mr89495216d6.28.1733271920141;
        Tue, 03 Dec 2024 16:25:20 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d89ef77c12sm37422936d6.81.2024.12.03.16.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 16:25:19 -0800 (PST)
Message-ID: <5bc32310f882c45d8713e324dd30cc1ca41ed20a.camel@redhat.com>
Subject: Re: [PATCH] net: mana: Fix memory leak in mana_gd_setup_irqs
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Simon Horman <horms@kernel.org>, Michael Kelley <mhklinux@outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Yury Norov <yury.norov@gmail.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Eric Dumazet <edumazet@google.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Long Li
 <longli@microsoft.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Leon Romanovsky <leon@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Souradeep
 Chakrabarti <schakrabarti@linux.microsoft.com>, Dexuan Cui
 <decui@microsoft.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 03 Dec 2024 19:25:17 -0500
In-Reply-To: <20241203162107.GF9361@kernel.org>
References: <20241128194300.87605-1-mlevitsk@redhat.com>
	 <SN6PR02MB4157DBBACA455AC00A24EA08D4292@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <20241203162107.GF9361@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-12-03 at 16:21 +0000, Simon Horman wrote:
> On Thu, Nov 28, 2024 at 09:49:35PM +0000, Michael Kelley wrote:
> > From: Maxim Levitsky <mlevitsk@redhat.com> Sent: Thursday, November 28, 2024 11:43 AM
> > > Commit 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
> > > added memory allocation in mana_gd_setup_irqs of 'irqs' but the code
> > > doesn't free this temporary array in the success path.
> > > 
> > > This was caught by kmemleak.
> > > 
> > > Fixes: 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  drivers/net/ethernet/microsoft/mana/gdma_main.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > index e97af7ac2bb2..aba188f9f10f 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > @@ -1375,6 +1375,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > >  	gc->max_num_msix = nvec;
> > >  	gc->num_msix_usable = nvec;
> > >  	cpus_read_unlock();
> > > +	kfree(irqs);
> > >  	return 0;
> > > 
> > >  free_irq:
> > 
> > FWIW, there's a related error path leak. If the kcalloc() to populate
> > gc->irq_contexts fails, the irqs array is not freed. Probably could
> > extend this patch to fix that leak as well.
> 
> Yes, as that problem also appears to be introduced by the cited commit
> I agree it would be good to fix them both in one patch.
> 
I'll send a v2 tomorrow. Thanks for the review!

Best regards,
	Maxim Levitsky


