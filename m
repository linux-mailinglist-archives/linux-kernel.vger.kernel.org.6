Return-Path: <linux-kernel+bounces-444725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4929F0B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87781886D11
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED541DEFF1;
	Fri, 13 Dec 2024 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb0fMbi9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01DA1C3C11
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090543; cv=none; b=hq/YT/tT4wt4cyj6YX+LgbHZNFB76VzN05gMbm5Jmn+tkxBKGKzFgfwbGgVIG1KjPzMBY+GNhTHfqUxzt/gKc4pH0fbsbLaoS0haa5qFr7AYoGV1lYgv/bbt3SrR+Hcdo39vnQEZwhoym+5hpqm1KIc1NdQbhHqrO7vSxgc4sh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090543; c=relaxed/simple;
	bh=QGT2SF2RrviqaJQfbCFot02KwB9XhZnwgAtpBU5l9lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7v91nKoDn/utZrYimx9djnG22G05tWdERdnWZBBMQSmaBg2vdjRIZZEbYz8zBUB9EP9onft0YDhyHZWApJMmud6fPyP03JEPz47OfVBE80N7LweIx7CypxBPbAiCJFYIsiJc+fll2TtbG7WddofhLx30TxIqi67YnvDjfyqry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb0fMbi9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734090540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pp0PgMN56ieGrHNFi7i6KMaUXuRE1vzehzF7+bFcb8=;
	b=eb0fMbi9csmZfFfgPdJx+nxNirr1mG1/M3KNyn+pooCoxN1B1UAjZ+CMFF5n7+Ug51GDej
	ZgbQ2yvjb+69Tf+lPASDUi49dDcxuwtj3Ib85NDuozXVp6szWwB/JxSyEV+T+gFFc7ym4s
	qEu8tXybX3sjFKadNQIpDMgYSy+rL1E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-snoktqyoPc2kBngGKok8jw-1; Fri, 13 Dec 2024 06:48:59 -0500
X-MC-Unique: snoktqyoPc2kBngGKok8jw-1
X-Mimecast-MFC-AGG-ID: snoktqyoPc2kBngGKok8jw
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d87efed6c4so27397126d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090539; x=1734695339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Pp0PgMN56ieGrHNFi7i6KMaUXuRE1vzehzF7+bFcb8=;
        b=MI5IH8VlvfuyKiqlsjgY0Rlu9bmZSis6ezKC3kac9a4erkYrFa0nf2e58YU/ZnEM1s
         JXdfEmEHdeH80G5hZqDvGpkxAJVBEXk2dTGRmrlqciYe+A/XG65SRFuNYItGL1qvQzt7
         hRS9OALDAC187764ElzNuu8+efsM8NOi7lls5fs2x4NVXUSLBXMC8u9hSZbWQsdbdonw
         0gefgYdzSKrzCgvQhfM65+chJQGVRVxFUDkDGrN69AOQqW23+QwQC1MCM6O3C0VJsUnx
         JQw2WkXgaga5x5vFnpVnh3xV2+IM1STwwBHAthMYj9OikibhthLcEpuzmtSW7G3/9jeo
         M0vw==
X-Forwarded-Encrypted: i=1; AJvYcCWKG5gpt2HmfWxdkLXW/lLaFdtq8lMjSMfodm4HcEbwzsysCT3nXLv9GY8IeBTd9vX1hcwVsjU8V3hOVMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjDgNN5+e3BJYeot2WaNOrjTUTA8Jn537CMIrgjQIuQ2W5+qi
	9vsfjJ3d/amfQyqqpohcbSuqKu3Ouegxnzy+KzY2rGScRd+U64ryG8blkAMXfXs43k2pgCKGvft
	z/+dslPUvWHCG7auESbDr0ROwNineZLAKU8/pnOqItAObtXcTJ47Ck3COai5EHg==
X-Gm-Gg: ASbGncs2EsaBXVAJmEYwGShwqHiNc5bEnfwbQKFwRxf1YLP5aZ0sud7x/C8OQ6eidio
	iirDcvDu2BoWd5RoqMxx7kKFyDN8J4TnXXikL/qZ9lf4xPwYEWImtzPn28JqEdeV5GVrN4M96bc
	NpHSHtCK6bfI+Hw6OP2goBmITXB2cS1VWbYO/Bt4jBdsLTJ0hg936yXpjp/AOoPYdUlF60VwJHy
	ZYRX6nsMNOP9vg4rqVyRb9AWdTyuC44k0SkjQnIvtnRnxzn0IpotvZyaiJQsA85I1/eQo+L7mKp
	uYfcu13x9SjkqMOLtH42e1U0CGPO/D0j
X-Received: by 2002:a05:6214:2622:b0:6d8:a5dc:866e with SMTP id 6a1803df08f44-6dc96998c54mr41274686d6.47.1734090539034;
        Fri, 13 Dec 2024 03:48:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVe9Bmg971vhiBdlReKshUrR7Ut9jwZGEsYOm0pIixkfuL80sk4rWNQhEv9/FV31WsOy9c9w==
X-Received: by 2002:a05:6214:2622:b0:6d8:a5dc:866e with SMTP id 6a1803df08f44-6dc96998c54mr41274186d6.47.1734090538603;
        Fri, 13 Dec 2024 03:48:58 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da673441sm90963686d6.1.2024.12.13.03.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:48:58 -0800 (PST)
Date: Fri, 13 Dec 2024 12:48:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-integrity@vger.kernel.org, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <4valfkw7wtx3fpdv2qbymzggcu7mp4mhkd65j5q7zncs2dzorc@jjjevuwfchgl>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <f8c6c1e0-a42d-6fa6-a10e-925592d7992f@amd.com>
 <9083d4cd50649ea1971e31445c554f44e8d12bf9.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9083d4cd50649ea1971e31445c554f44e8d12bf9.camel@HansenPartnership.com>

On Wed, Dec 11, 2024 at 12:02:49PM -0500, James Bottomley wrote:
>On Wed, 2024-12-11 at 10:30 -0600, Tom Lendacky wrote:
>> On 12/10/24 08:34, Stefano Garzarella wrote:
>[...]
>> > +static bool is_svsm_vtpm_send_command_supported(void)
>> > +{
>> > +       struct svsm_call call = {};
>> > +       u64 send_cmd_mask = 0;
>> > +       u64 platform_cmds;
>> > +       u64 features;
>> > +       int ret;
>> > +
>> > +       call.caa = svsm_get_caa();
>> > +       call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
>> > +
>> > +       ret = svsm_perform_call_protocol(&call);
>> > +
>> > +       if (ret != SVSM_SUCCESS)
>> > +               return false;
>> > +
>> > +       features = call.rdx_out;
>> > +       platform_cmds = call.rcx_out;
>> > +
>> > +       /* No feature supported, it must be zero */
>> > +       if (features)
>> > +               return false;
>>
>> I think this check should be removed. The SVSM currently returns all
>> zeroes for the features to allow for future support. If a new feature
>> is added in the future, this then allows a driver that supports that
>> feature to operate with a version of an SVSM that doesn't have that
>> feature implemented. It also allows a version of the driver that
>> doesn't know about that feature to work with an SVSM that has that
>> feature.
>>
>> A feature added to the vTPM shouldn't alter the behavior of something
>> that isn't using or understands that feature.
>
>I actually don't think this matters, because I can't see any reason to
>use the SVSM features flag for the vTPM.  The reason is that the TPM
>itself contains a versioned feature mechanism that external programs
>already use, so there's no real need to duplicate it.
>
>That said, I'm happy with either keeping or removing this.

If we remove the check, should we print some warning if `feature` is not 
0 or just ignore it?

Thanks,
Stefano


