Return-Path: <linux-kernel+bounces-206046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9011900396
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630D3B25853
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD2198E87;
	Fri,  7 Jun 2024 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWBvJyDd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7B1990A7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763323; cv=none; b=SBi2DGg2XQ65/rk3crAFsPzDtDkrXdSiB7ouU1YYb+espKkU+yGuvVaFbVVdgFwsxyO3t5NbM3oiUVPKQFTyxgeEVuzjTOSNuAZArc1qfvYNhsXZlZjG5NYwDha57qVp528XN9F0CFSJ3pEy/fPo9qKQqurJ5RJTo8fysKdNbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763323; c=relaxed/simple;
	bh=MwVN8O06HSO/KA7ge+xMur7IGxhiQ1jj42Do/f1rh2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g57otZa1abedKK+ffBIDqul8TX7vm2rr+MUwb8VCqK2tOX8zm2fpMQ48T3kyuNuNrQ8Tgdykiz1TLtLFM0pMxbSNbYgRayhPhNdAOBINY3SYtgylkcNE2PHXSCG2BZnPF1MQkgr4ioUglr6SHZmCSaoa1Qu9CNxszZdF+pq7EcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWBvJyDd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/vT53TWEjy08/r3RbLeFfTwbW4PNcgFRM/VPKY6Npg=;
	b=UWBvJyDdXE22PDG4uYY8tc5R4Ix/3VFV/Kb0naYXyomDcWZi2QjpVAb658L9xqRCUWed5E
	PwdXt/TD4Z60B3hInxGyuh3J2bwa6TjYg4R5DRkuTzGTDtQrYVp3nVIoTt/HnDD+6WMbtP
	tKvWmqe3ZXNKLKviDivkFY9wShywfac=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271--K8hwcdgMNawMelTJXgkcA-1; Fri, 07 Jun 2024 08:28:39 -0400
X-MC-Unique: -K8hwcdgMNawMelTJXgkcA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6e53ddbbb1fso153953a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763318; x=1718368118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/vT53TWEjy08/r3RbLeFfTwbW4PNcgFRM/VPKY6Npg=;
        b=fA4UolW5mCuu0OUV3IbfZ7HIif5lIOmXYVegHz9sy3aOYSrEfB9h5jUlnCcqGXiy/8
         Jb74Ii1IjNz8E0me+4ksGRhPDyCXfCl1ej8qFSPDRWrBoaU4qW3d2LQ9n1RFDkJZrCJn
         iH2wRfg3sk+W2Thtl1RSEIuB2bk8rNUyxqnIh/m2N5HNXUKiUfh2VjG6B2vgS5trtCn0
         mdkXV6Tw2vxAyBY7oAKKcEIsMA47D7KZj7vSJYSu0LBHuWwlYyABV6n29l5sb7DEK9rC
         pzAYyMK1Hm7KUlK/ExUya+v3oA8krTmeRUqpTTc3U0yW+dnAb11FNbw2C6GEuQGKPRe6
         ax5w==
X-Forwarded-Encrypted: i=1; AJvYcCW2gNlSECfU8HsUIVntSEteJOJwM6Jxq2Kb/xhcbxMcS//cpz9iAEW8b0JdmdvJatp7ERH44OQvPXFtSLd+OYNczo1dVY7zQ0LGdKkZ
X-Gm-Message-State: AOJu0Yz0V16Kc5pCqoPqnT6CunMYVRUh5P8wIJY2EIuOC+Sqwit0ij7q
	eXGXSG14mcP7d//msmCHlw4wRarNZhCrPOgopY63tH9Y0bEfXQyDXk9dKPC6WGcOy4z7nMp4h7+
	sQUVCs3reNVC8dCUzf6mmN7u1H0N1jsQy/TjOnjUtemACJVAUdeVFHvRr2RtwDA==
X-Received: by 2002:a05:6a20:da84:b0:1a7:3b4a:3e8 with SMTP id adf61e73a8af0-1b2f968d8afmr2340416637.7.1717763318240;
        Fri, 07 Jun 2024 05:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjC0KOFCSMBj595ucryYMAtLDyWr19LmKIMSzmSM9/L23RH/k6EfQW7vDi8RBhmbxD4JUwqQ==
X-Received: by 2002:a05:6a20:da84:b0:1a7:3b4a:3e8 with SMTP id adf61e73a8af0-1b2f968d8afmr2340379637.7.1717763317629;
        Fri, 07 Jun 2024 05:28:37 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e42c0sm33015205ad.222.2024.06.07.05.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:37 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:37 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Message-ID: <7fucfvhq74bzdhzowvso7re3c6c3bhtqj5trxe5gl3p7cgzgym@xz7wdxw3wojr>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-6-coxu@redhat.com>
 <ZmLX15YJIhUG/XP3@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmLX15YJIhUG/XP3@MiWiFi-R3L-srv>

On Fri, Jun 07, 2024 at 05:50:15PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>......
>> +ssize_t __weak dm_crypt_keys_read(char *buf, size_t count, u64 *ppos)
>> +{
>> +	struct kvec kvec = { .iov_base = buf, .iov_len = count };
>> +	struct iov_iter iter;
>> +
>> +	iov_iter_kvec(&iter, READ, &kvec, 1, count);
>> +	return read_from_oldmem(&iter, count, ppos, false);
>Do we need create a x86 specific version to cope with the confidential
>computing thing, e.g sme/tdx?

Thanks for raising the concern! I'll test sme/tdx and will fix it in v6
if any issue is found.

-- 
Best regards,
Coiby


