Return-Path: <linux-kernel+bounces-565899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8122A670BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4CB179F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AFF207A22;
	Tue, 18 Mar 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBZXLiP3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE662207A01
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292489; cv=none; b=jwibpFC201+J1ifzKtZnHT0qPlUTYuZCRcKGqh5WYKF3+fee9QmxRayaxLBRPxO48QE/LWU+oiTUwYDdluTIyA3zF8U9E45XEt4vIItSyJjokW6gtkO9EIG3ssSl6YaGw2MZIr/d0h62MzCwecL/Usj6FfVVm1Qv3k1hZ8vuZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292489; c=relaxed/simple;
	bh=D2uC7q/GfIgxv9SCiH9wXFsiCXWQ3GihsbEJk75avVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq/25g/ocp+PScBMp5AdEoiio8bveD6kJf/2nnuF/RiBw/T7q1dgq0/MHnhDl4Bhbp6x5cusZ0MCI8rDNSgYpQXecXqVFBjwtlzZUIC6Q2tRP0KBjNT/MVozU/LiPctgz55wvwgPR6octiLv9K38cGyFcOEq8wNO7709qMsVAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBZXLiP3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742292486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IEvuZKB25WkNV582zeCY6U1/wQrHODlGoWn807RLAj4=;
	b=RBZXLiP35AfiZsXQ55ZGeZl3/n+TFMtNsSJwL5TvmvLaeM1S39HerEtzIf3sDEaVZ7/Ktz
	zZSVQAuAXdeGsY8zG/ktIKmF2F5zGXxYbZZGLrvfGIT2Im7HNxAeUvoGQAYDIplAD8d8XQ
	X1Ee3CgTb89yBjGR2lpO+FuH3E4UZtw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-UiTOUCYFOsuf2q_suEGkNg-1; Tue, 18 Mar 2025 06:08:05 -0400
X-MC-Unique: UiTOUCYFOsuf2q_suEGkNg-1
X-Mimecast-MFC-AGG-ID: UiTOUCYFOsuf2q_suEGkNg_1742292484
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so19071075e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292484; x=1742897284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEvuZKB25WkNV582zeCY6U1/wQrHODlGoWn807RLAj4=;
        b=UQUFLrXIhyffBFCmWSuFwi1Gg15Fw5seNUL9hwC2x2SKklOkomNEbj2NpKr4VeGiYu
         epi5ABXza1BKNnM4E7zcsdVxN5Ax/KxpFP/9Vt1L47UDo5/SorLLPHPojvJIXQcnUCX/
         dTqKYvlc0qOaPWbQkQrPvf+7WYTViq6LyeeLiOhQpSFrPaj6EFlo2DhB1stLEomRwfzQ
         VL+ftgBtc+mSMcv8V8TMUU+YS0OPxoA6lnoJHvIB36ZAC2tqAex0ig08CdtDItgeW62/
         tPN4y30cykM7SBiABQuEc1Pzl28peuxZousCXPogKz0zCcWK+5EL9uNLxtHe5PKPqPWK
         ihAg==
X-Forwarded-Encrypted: i=1; AJvYcCVsxeygtnAnQWUoDpZUr2lBBqUSbar8LIxCPg1jCSJoR2vg31uu6TMQYvyQvJyll5QWF6P+T1omAu1xw6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVD+EH8b6Ye1CO4ifH+W04ojeR7udE4E1lpMxG7oFC2LdmQs0I
	bh+wWYBcozVfIbXuziFOkcq0UtAzB1ncxKOpy95V6CfG5htInpUWaTBdf2i5I+Nfd1kyETjGngO
	er3dCrViiOrrRr6PRTm9bogIA3gr9k0nnQORT7S1dCFB2krr0iO5+qUrfKrovNA==
X-Gm-Gg: ASbGncvgsUQo5f7FRhn8wv8nK8r0sn049zZ4mIb/R/CwBfbrJoUeOfAeBwbIVe4y5K/
	j74gPKLLQSLw2j9gdccH6unBT/Dqpz9exMeh9JYzQZi8qRbk4LNuhvYhJY596FzFpvzuhzSvznu
	F7ogyDyZIG76oQjupIKc9ziPGfzgg/hdjQTa/+q6znWuNvlJBMGNkJG809FECA4Sn3uqPqEsXOw
	C75JZ9Mdig6cOZ19tWP1JMS2VmyvrO738Co4yZ5Rc4Ej3CRq8k8vxBweE4BvAj6TUU/wGA/uOcY
	bMkA4vP/uvll95n+ARnsZ2FGmwUJmAWex7jWnnHHlNyXFgu9Lb9xV/Jx+BnFvo2y
X-Received: by 2002:a5d:6da4:0:b0:391:3fde:1da with SMTP id ffacd0b85a97d-3996b446894mr2484885f8f.16.1742292483850;
        Tue, 18 Mar 2025 03:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh3gn7eHXqYAXq/xhJqTxFL+gTLLmKxOf4FLaroBA677Z+26ult7+GExyxZ1z7z5eEbfIXIQ==
X-Received: by 2002:a5d:6da4:0:b0:391:3fde:1da with SMTP id ffacd0b85a97d-3996b446894mr2484848f8f.16.1742292483336;
        Tue, 18 Mar 2025 03:08:03 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e92sm17909112f8f.38.2025.03.18.03.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:08:02 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:07:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>, 
	linux-coco@lists.linux.dev, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
 <Z9glWp6U6vyEmKQa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9glWp6U6vyEmKQa@kernel.org>

On Mon, Mar 17, 2025 at 03:36:26PM +0200, Jarkko Sakkinen wrote:
>On Fri, Mar 14, 2025 at 10:27:07AM -0500, Tom Lendacky wrote:
>> On 3/11/25 04:42, Stefano Garzarella wrote:
>> > Add two new functions to probe and send commands to the SVSM vTPM.
>> > They leverage the two calls defined by the AMD SVSM specification [1]
>> > for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
>> >
>> > Expose these functions to be used by other modules such as a tpm
>> > driver.
>> >
>> > [1] "Secure VM Service Module for SEV-SNP Guests"
>> >     Publication # 58019 Revision: 1.00
>> >
>> > Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> > Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> > Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> One minor nit below, otherwise:
>>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks!

>>
>> > ---
>> > v3:
>> > - removed link to the spec because those URLs are unstable [Borislav]
>> > - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
>> >   in this one [Borislav]
>> > - slimmed down snp_svsm_vtpm_probe() [Borislav]
>> > - removed features check and any print related [Tom]
>> > ---
>> >  arch/x86/include/asm/sev.h |  7 +++++++
>> >  arch/x86/coco/sev/core.c   | 31 +++++++++++++++++++++++++++++++
>> >  2 files changed, 38 insertions(+)
>> >
>> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> > index ba7999f66abe..09471d058ce5 100644
>> > --- a/arch/x86/include/asm/sev.h
>> > +++ b/arch/x86/include/asm/sev.h
>> > @@ -384,6 +384,10 @@ struct svsm_call {
>> >  #define SVSM_ATTEST_SERVICES		0
>> >  #define SVSM_ATTEST_SINGLE_SERVICE	1
>> >
>> > +#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
>> > +#define SVSM_VTPM_QUERY			0
>> > +#define SVSM_VTPM_CMD			1
>> > +
>> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
>> >
>> >  extern u8 snp_vmpl;
>> > @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
>> >  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
>> >  			   struct snp_guest_request_ioctl *rio);
>> >
>> > +bool snp_svsm_vtpm_probe(void);
>> > +int snp_svsm_vtpm_send_command(u8 *buffer);
>> > +
>> >  void __init snp_secure_tsc_prepare(void);
>> >  void __init snp_secure_tsc_init(void);
>> >
>> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> > index 96c7bc698e6b..2166bdff88b7 100644
>> > --- a/arch/x86/coco/sev/core.c
>> > +++ b/arch/x86/coco/sev/core.c
>> > @@ -2628,6 +2628,37 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
>> >  	return ret;
>> >  }
>> >
>> > +bool snp_svsm_vtpm_probe(void)
>> > +{
>> > +	struct svsm_call call = {};
>> > +
>> > +	/* The vTPM device is available only if a SVSM is present */
>> > +	if (!snp_vmpl)
>> > +		return false;
>> > +
>> > +	call.caa = svsm_get_caa();
>> > +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
>> > +
>> > +	if (svsm_perform_call_protocol(&call))
>> > +		return false;
>> > +
>> > +	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
>> > +	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
>>
>> It's a bool function, so this could simplified to just:
>>
>> 	return call.rcx_out & BIT_ULL(8);

Sure.

>
>Or perhaps even just "call.rcx_out & 0x100". I don't think BIT_ULL()
>here brings much additional clarity or anything useful...

I can do that, I slightly prefer BIT_ULL() macro, but I don't have a 
strong opinion on my side.
@Borislav since you suggested it, WDYT?

Thanks,
Stefano


