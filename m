Return-Path: <linux-kernel+bounces-349159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E8598F1E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764761C210A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C61A0B1A;
	Thu,  3 Oct 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDtK/xN8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08B1A071E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967089; cv=none; b=gKasnNHvRG3Gv4bKe17uWLNNU2b7/xEHQcst/scUciCLQAu/wOe7QOT21zer21k55n7KljE/9nT5yuHT+8FF7XYJyWN5LMOiOAWSUDubpw+HekX3I8kcLVijAPcRLatIlvwubA6v8t06hHeRxO5zfHtdCXfS3as90qUXptu/4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967089; c=relaxed/simple;
	bh=O3gnn1+I/QRYYe7QgzmHETV9nHG9cTTicSxdXjNONmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSDoWruFUx/VVxH+lmQz1n/dL7Cyw4qB3437Pk6euYiWgnQNewryuz+yYKPvRi+e/XDZ+rJ8Ye01+51fWap/zoBGXNWKy5bALN4518O/MdyKokc+xAQakvTgVa4x1AHtIIfcA87r73g+Qrt7RW+yaQbNEkCtRbaB9OEwNHT4ius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDtK/xN8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727967087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFOC5ltxjnukHbOiTZnLdPhdjlEFGzr/Dkn5csRqcok=;
	b=FDtK/xN88MSfVgz0opIvRwHSeukVAdOnKoQUuLfITDSLunS1Nan4IHTkAS3ZMjqUVdSh5t
	o62CRvNYaG2UQ9qxWLOhhHnO3GcZaelHkUnGmM5teocnk19Nc+t6jERYt+FWxoBhWA5n8v
	zwaNrCFWTu1ZKYrk2J+Ua5t0ffV1G4o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-LzuzznzIM8aAOcKWiZvy0w-1; Thu, 03 Oct 2024 10:51:25 -0400
X-MC-Unique: LzuzznzIM8aAOcKWiZvy0w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so8897975e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967084; x=1728571884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFOC5ltxjnukHbOiTZnLdPhdjlEFGzr/Dkn5csRqcok=;
        b=pSeqRON/W3c6aNfJKMel8y4MR8ofjCa5X3tSouWgfUFPMSXX9JRpihvPjKd/bBCrJu
         bWixXDAC44dL3avHtZ7Y3r9URxhz32iaEcJjwY0znmVMbpMOC0/ZKJ/RKi7XB/uvquuT
         itB99I4gQGmMITIoQZbvfTrFumGGTWvVFckSqHWiw9itOZztwHsdu1TPw59wb2+N/UI/
         MZcBsd5hRR60VuVq8qRBLeUNyq+VkM7/r+5aWyRGItVAp0UB4o/1HUpwzmfb7+q2Pv0h
         14qP4xAOuB3RFBaCjj1djhb4T2TCs4235sQHcRT/Zdr99IvhUKmYvMBV0t0v4G3uwQQU
         QSwg==
X-Forwarded-Encrypted: i=1; AJvYcCUEi6VO8yLh3f/woXffY6Jh+5yErqamUJZP0iZ5gGlq4WFBCq4iuTq68I9cphPRCVpiw4sRX1Rr+BIjDQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYOb62Kx/jGjKIZu2Ad8nkITbu+Mr9b+F23CCa8N9o0UbJkijb
	/zqwDz3eyVy8HxrYNryvkEAmA08vR+mohuEZb4aYT6v3svbKtt+TjRUVmr2L1htzG38I8QD3vE+
	Fq2G9vlNmMZkOfLf3OTN+Ts90GQSwzSa91IuNYE+l2yJR4HcLSRIDCeZ+JPFoHg==
X-Received: by 2002:a05:600c:1c26:b0:42c:b77a:bd21 with SMTP id 5b1f17b1804b1-42f777f00e0mr60514245e9.28.1727967083964;
        Thu, 03 Oct 2024 07:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ6G3k/NxXaYRH9TBJ2crwndAkg4Z4yJNGSH7D8/wlS2L/LsF4ysezGdqf2xJL5nGToZ36Hg==
X-Received: by 2002:a05:600c:1c26:b0:42c:b77a:bd21 with SMTP id 5b1f17b1804b1-42f777f00e0mr60514045e9.28.1727967083570;
        Thu, 03 Oct 2024 07:51:23 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0216sm17413925e9.33.2024.10.03.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:51:23 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:51:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 07/21] acpi/ghes: rework the logic to handle HEST
 source ID
Message-ID: <20241003165122.542dd026@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241001135759.474452d8@foz.lan>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<0dd7081717b23b4c1536bc86abfa926388cf2139.1726293808.git.mchehab+huawei@kernel.org>
	<20240917135934.38579213@imammedo.users.ipa.redhat.com>
	<20241001135759.474452d8@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 13:57:59 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 17 Sep 2024 13:59:34 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Sat, 14 Sep 2024 08:13:28 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > The current logic is based on a lot of duct tape, with
> > > offsets calculated based on one define with the number of
> > > source IDs and an enum.
> > > 
> > > Rewrite the logic in a way that it would be more resilient
> > > of code changes, by moving the source ID count to an enum
> > > and make the offset calculus more explicit.
> > > 
> > > Such change was inspired on a patch from Jonathan Cameron
> > > splitting the logic to get the CPER address on a separate
> > > function, as this will be needed to support generic error
> > > injection.    
> > 
> > so this patch switches to using HEST to lookup error status block
> > by source id, though nothing in commit message mentions that.
> > Perhaps it's time to rewrite commit message to be more
> > specific/clear on what it's doing.  
> > 
> > now, I'd split this on several patches that should also take care of
> > wiring needed to preserve old lookup to keep migration with 9.1 machines
> > working:
[...]


> >  6. cleanup fwcfg based on x-has-hardware_errors_addr,
> >        i.e. for 'true':
> >           ask for write pointer to hardware_errors like it's done in current code
> >           and don't register hest_addr write pointer
> >        while for 'false'
> >           do opposite of above.  
> 
> This doesn't work. without the fw_cfg logic for both, QEMU/BIOS won't boot 
> and/or the hardware_errors won't work, causing ghes to do nothing.

we should look more into it,
only 1 of them hest_addr(9.2+) or hwerror_addr(9.1) is necessary
so if it breaks, it looks like a bug somewhere to me.

> 
[...]
> 
> 
> Thanks,
> Mauro
> 


