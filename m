Return-Path: <linux-kernel+bounces-575849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B1A70804
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF20188A346
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DDC263F29;
	Tue, 25 Mar 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkVK9ilw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B105261399
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923260; cv=none; b=UJrJMS1cKY5Dzw2GJrP9PTJt8m6TrtSucgdc7ucFVebzftE7vkCmAJY6iChEfedDmRpE0tqq6FRpx3ijRa6j7Am3YTX5EvEtdESSPRKLOfq/P/5Ih0LqHg9QaGCzDS+ueshvdxw/HJvB9TDVbSLnUy32dh9SgZvig9YdJR9xNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923260; c=relaxed/simple;
	bh=XR1tVytbIphJs05val9V5bAdzBLdjUKyNgfVx4GEvDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJugO1/z4oHKCaZ6EJPuVomRalTIZKahu0YoP0K2euCCYYlfYT/uOuCZgWUEcTO82W9evz1JTVV9KfI3YDcnfJ6cqJufNFGaDDGfbXZfqrVbZG1MIyjkBpBbxUAqMawZYQ3HrEwJmSAuyDXpCufC+eWwFis4Nqt+tEux6hfhJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkVK9ilw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742923257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXrcQRGT+YymoQu8Nq/Sa3GMytku7iNudqsRUZDUqH8=;
	b=QkVK9ilwjvYPUKL43wE41y3eT+1BS5vgB/BfBOfOzyoiYeX7IwxhY+E5XrTZRo3UKJMT+J
	OA9JzJNnBBXUQRm6r1mdYLdCjuE6QH2dONsTAxEq1nNg5qFUrb1heGXhSIrt03BP/3oDYb
	gND2mFErtO14GYu/NGRqYT9pMDkVxJM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-jVq5rZxQOyKiK9XmMuHstw-1; Tue, 25 Mar 2025 13:20:55 -0400
X-MC-Unique: jVq5rZxQOyKiK9XmMuHstw-1
X-Mimecast-MFC-AGG-ID: jVq5rZxQOyKiK9XmMuHstw_1742923255
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so36968025e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742923254; x=1743528054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXrcQRGT+YymoQu8Nq/Sa3GMytku7iNudqsRUZDUqH8=;
        b=YnEXO7ACzzCMl1IlUVq9niZ8F03u9xJrDwZ1zUtKgbGkWMO9BMQrWfEPI3VCeL1Ab0
         QkGsfCEkOkO/ypIyD6eZYhvvOSkqhWo8tw70Pg00MS7fC9L38vooX8sUWHbIQv5JlTMi
         +xZhZzd9As7+f0Vwx7S3XRo+srIoGwC3h4IrPvVORCLnwK7JZC2/1krKhNhik2+MXDJp
         OjxGKysA4C8OeX2EwdhLgEKWSJZznWseC7iMNkvKfxC0YKRQNiUxreOIdkH/UhM1gzSF
         HLnDaZgRBXBRg5SJjx4KSLU3Rg+p7W73P8Kz8PYFEL+88lEM0cQYsG8BmhMYKRAPKVU0
         5G7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZfAxejIl//v0VFc+x9EoKnK6fbrGNisht6+ylMmYX3cD27CMnz38jsbMR9hq28JwUI1ncLHYaRiCj4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4l9S1k5ErI6jzAewgGdnqxlWjxz55MHS9Rk9FsaFdiCW0620
	Ix4ZwmVuJbV4d6htUKF7zb+AEoVIXfdaXT0JZMfYUIXxlSzvROl3QeD08PLLxJn2Wi7Z1UnBRd7
	7N3aPsjPcuirgUNcksiTREYcCOBtYLA3H1xRoGxtMDlGT79amQENTAFTLdw/XDg==
X-Gm-Gg: ASbGncvX/dWy+mKwWiYBJp6Dc8UW5DVGVOk/hRO9FWes5+EIVBYw4IeGflbficWaKYh
	LbT5XXZKk1NTLd7o58qH1uo0Ho2STsP9woOo21DL2BUXHnayZh80Y+RaX3PAf2sboPu8ZejLmg6
	vT5IflCy58vphJAVKCdK1UqhMP9iAMfgGeePh4iAOyFcg/+kCWcXCyWnSMzo4v7YIpnm/G3VjSZ
	W/SIE6O4hp+NOnfz89SP+beuWipr6Fxyo63xJc2uy/sFj6oAOZLPsSreL8JR3pKxu/TUIHo2SYB
	9Kk5458ThNspUImvF2PZC8xkTVkz9jfkSLQZ69ESqsHA0E+Ynhm4+s5DtmkU5IwB
X-Received: by 2002:a05:600c:5488:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-43d50a219a4mr183355945e9.23.1742923254501;
        Tue, 25 Mar 2025 10:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCb+zv6HS9bYecqfccexaC5TWzYCJ46ME9+z1Odod48/9DY0ZMeRbh9jp1LnT9G/G4XaXh8A==
X-Received: by 2002:a05:600c:5488:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-43d50a219a4mr183355615e9.23.1742923253915;
        Tue, 25 Mar 2025 10:20:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e96bsm159257455e9.25.2025.03.25.10.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:20:53 -0700 (PDT)
Date: Tue, 25 Mar 2025 18:20:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Joerg Roedel <jroedel@suse.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <dou3uniecwqapl7kmsxa2776v6pdy7c4zdvcrdky6wz62ohyao@u3vlgaao4sb7>
References: <20250324104653.138663-1-sgarzare@redhat.com>
 <20250324104653.138663-2-sgarzare@redhat.com>
 <CAAH4kHYuaQEkvftWuX+UmGDiAgV5i1uHx8=rjmhJ0Y=inQFw-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4kHYuaQEkvftWuX+UmGDiAgV5i1uHx8=rjmhJ0Y=inQFw-Q@mail.gmail.com>

On Tue, Mar 25, 2025 at 09:56:53AM -0700, Dionna Amalie Glaze wrote:
>On Mon, Mar 24, 2025 at 3:47 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Add two new functions to probe and send commands to the SVSM vTPM.
>> They leverage the two calls defined by the AMD SVSM specification [1]
>> for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
>>
>> Expose these functions to be used by other modules such as a tpm
>> driver.
>>
>> [1] "Secure VM Service Module for SEV-SNP Guests"
>>     Publication # 58019 Revision: 1.00
>>
>> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v4:
>> - added Tom's R-b
>> - added functions documentation [Jarkko]
>> - simplified TPM_SEND_COMMAND check [Tom/Jarkko]
>> v3:
>> - removed link to the spec because those URLs are unstable [Borislav]
>> - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
>>   in this one [Borislav]
>> - slimmed down snp_svsm_vtpm_probe() [Borislav]
>> - removed features check and any print related [Tom]
>> ---
>>  arch/x86/include/asm/sev.h |  7 +++++
>>  arch/x86/coco/sev/core.c   | 59 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 66 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index ba7999f66abe..09471d058ce5 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -384,6 +384,10 @@ struct svsm_call {
>>  #define SVSM_ATTEST_SERVICES           0
>>  #define SVSM_ATTEST_SINGLE_SERVICE     1
>>
>> +#define SVSM_VTPM_CALL(x)              ((2ULL << 32) | (x))
>> +#define SVSM_VTPM_QUERY                        0
>> +#define SVSM_VTPM_CMD                  1
>> +
>>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>>
>>  extern u8 snp_vmpl;
>> @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
>>  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
>>                            struct snp_guest_request_ioctl *rio);
>>
>> +bool snp_svsm_vtpm_probe(void);
>> +int snp_svsm_vtpm_send_command(u8 *buffer);
>> +
>
>These should be defined static inline with trivial definitions in the
>#else case, yes?

For now the only user of those is the tpm_svsm driver which is build 
only if CONFIG_AMD_MEM_ENCRYPT is defined, so there should be no 
problem, but you are right, better to follow the other functions and 
define the stubs

I'll fix in v5, good catch!

Thanks,
Stefano


