Return-Path: <linux-kernel+bounces-569575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1725A6A4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93CA1891780
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13642206B2;
	Thu, 20 Mar 2025 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXWsyC+U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B821D5A4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469529; cv=none; b=Il0jkN6DlCFQOaFQV9+js9PoyuyOP3+SMnhBeCdjCMN7nRPXHfHZv+aJzT8y8FKt5jCpWG9GloP8lyxU4QyqkEVDsmyhWhBU8UT8ylms9DpvVHty4KBK4FN003ltmQTKyezwk3vWOxJplktqU0KzqhseaJ4L9LFMqEHRz/Zffcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469529; c=relaxed/simple;
	bh=0FdnkXQluRsPObUmbyXPh2pDGWDzoaM0MsbjAFVybsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTDPrX1SltyxsMjNcwVdlJaCZ88fp5tgu8bzft2uDblRjakoMg3V3k9CAaSsQr7vn4sFQUHd/z3doOjynIFfG8uChZYPYJoBoeeqduSpr7I/RVfbG5+5WAhdb2TmmpZzdLo49nsI6imtk2kzYoVxbDqMN3D0LQiNHzmfc56yg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXWsyC+U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742469526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlhLlOmKjiRqXZDEYP/oB3y/fV4BzL5SuKNYZXi0IDU=;
	b=TXWsyC+U6MgnInm6MHnQiWKWJvccecnf6CouN4Td4m9Dap1jEHcCR4EZYm4XC/QnmP4ObK
	91e59QnjdoGSqeY3LUpTlijawq7HY8sGdIq9LvC/QFV+j0D7q3OK5QRNlgtYQhMVUVP/tG
	X/iv41dZYzi1ZBurkvCKrvLG1dL0Xak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-ptMKqMROMTmF5JGQdpmadA-1; Thu, 20 Mar 2025 07:18:44 -0400
X-MC-Unique: ptMKqMROMTmF5JGQdpmadA-1
X-Mimecast-MFC-AGG-ID: ptMKqMROMTmF5JGQdpmadA_1742469524
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391425471ddso408408f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469524; x=1743074324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlhLlOmKjiRqXZDEYP/oB3y/fV4BzL5SuKNYZXi0IDU=;
        b=j4CLXaxXbqk60JkD6wG1IpLB3n2XLqC2fvWcjHduzCPBVAqJEGMkHqFbabEgLdsrXT
         LnDa+wpLkktc37Bq6whpWUDjazY/aTNdbBgSQGpl6JnOotFP6yxha4npYxD2F/L2iTvW
         AkWPN8hrO71H8qsoEU5/w5CMal4ZGVu96tDsIwn4YVs/Fpq7KYBpS93CDPj4qsE3vORM
         uc8kRpnnYqCaXlLeJUprD0kiVLZep7mZZGLodEj1mmrrYOKbiLUlDeMR7dIiCNOwSocq
         LzYT33QI92GnekLgAY5ETdRe1lERpMfXSSzboEDna/r+QpqyDcrM6gwKcf0AOhBAszT8
         K3dA==
X-Forwarded-Encrypted: i=1; AJvYcCWlPpiG24+UuzEENVSSTw0QYZWGxWvSbfgNSZNTclV2Y6zDmZTy59ArO9dXxQBtaWXGK9KtM6RfiXl7Lz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/L8SE8IuHB2BZ5Ci2RBTk+WVawyA3GQuFblUU9Mi50v0K2ilO
	Uf20cBkL+WotWIYtuYtZM/hkpXeUAbtiGSXz1Uo8lLn177/X6J1sn8D97HW4KEfsW7qtO2ARZ3+
	IJMC1iQ93qRg/7d9d1+8GfyzjxcSYir1Uom4Haot+avJeYtMqSxDdl5Ar+EPa2Q==
X-Gm-Gg: ASbGncvzhbCBx9PMukJcUb3/5pMwAtpP9mfZnnKGCG8IXX+GHItKkvWh/qCL7DIdEUf
	6QtC4LY171I4wHaVkl0bSZlcsqQG4jSR1XPIFOPtb7UXiygxE6UoUWR0mgJynATz9usnaJd00vg
	QLYtA4306DtZAasGJmyIrcJdv/pDGnXaH2rebgQ6MVsnEqd8SL5oqcJWyUkwoNZdgDSenjmaao1
	H7aWdyUINGWNZKD9PIuIIM4mc7enwyaYD/jJaqk6rq0uy3RnpSTdPP4WkPB0SDCAWRtnRxd38Jx
	cplXC/eIcnydZZP41mWOwGvlgubbHcaCvhDVgJ9B8v8MUxl7ZqwtujwuICx8X3jd
X-Received: by 2002:a05:6000:4107:b0:391:255a:748b with SMTP id ffacd0b85a97d-39973afaef3mr7410049f8f.39.1742469523531;
        Thu, 20 Mar 2025 04:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI5mpKp1YJg5aoVvk5ggv41pOHlIt28ldIzkOLJLMe/dkF2SkzzL//q6jSa4e5CHMy+shCrg==
X-Received: by 2002:a05:6000:4107:b0:391:255a:748b with SMTP id ffacd0b85a97d-39973afaef3mr7409991f8f.39.1742469522991;
        Thu, 20 Mar 2025 04:18:42 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318acfsm23916885f8f.70.2025.03.20.04.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:18:42 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:18:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>, 
	linux-coco@lists.linux.dev, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <imld77cuc6e4kyd5an5oeerfseit3l4enrbpazne2ybo34srik@ejqwayyod2mv>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-4-sgarzare@redhat.com>
 <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com>
 <Z9gm9iWhk5Zs2NvI@kernel.org>
 <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>
 <1262fa5b-0822-b8d4-26c5-426ffa4e0265@amd.com>
 <qne5fm44dhkbnwc6ldgff76ljt7ecd3cvtf3b3lhos56yyx2ez@qbcv45zbxlhp>
 <20250319234422.GG126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250319234422.GG126678@ziepe.ca>

On Wed, Mar 19, 2025 at 08:44:22PM -0300, Jason Gunthorpe wrote:
>On Tue, Mar 18, 2025 at 05:18:53PM +0100, Stefano Garzarella wrote:
>
>> I see, thanks for the clarification!
>> I saw that with devm_get_free_pages() I can easily allocate a
>> resource-managed page, so I'll do that in v4.
>
>As a general note you should just use kmalloc these days, even for
>PAGE_SIZE. It is efficient and OK.

Thanks for sharing!

I think I'll stay with devm_get_free_pages() just because if it's
page aligned (with kmalloc I'm not sure if I have a way to ensure it), 
it can be a bitter faster for SVSM to map/unmap it on every command.

>
>Having a struct that is PAGE_SIZE+1 is not efficient and will waste
>a page of memory. That should be avoided ..

Got it, I will definitely split the buffer allocation from the priv.

Thanks,
Stefano


