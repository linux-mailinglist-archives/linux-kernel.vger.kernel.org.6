Return-Path: <linux-kernel+bounces-554367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD2A596DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A641889BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67622B59D;
	Mon, 10 Mar 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGfbJCB3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC1422B59C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615195; cv=none; b=uyMQ/BfD6CZR07l1q5RtrRIwt0/rMqu2ajrxTNPZhysnPKKxb3gCq+vuVec/teWzAr24poHZGI5CuLoimG1Ap+B1/CUedmH6GVRxDEX9IPTLH+TqzEPVExa01kNby9/bnGerXipmOC5/whGCqbAH2yUoJCHdIjsjPA7XVLo5ZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615195; c=relaxed/simple;
	bh=5yRa8msLShePncZ4iDaj+ETPUsYjrQ57wsSamBBpqFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsS7YgPslaJekkD1ZbgAS6fYa4Ddon5ptGxwgcj1JbdQPpwbAU0Lp6hkzTUYG1ImWX0rEPEmkccDUYN90R9JNVAH84kRn2ofa8tZnIn9AT8/6SiBARpjYfDkTyBj0kHUtbYUFCnIyow3Qs+oXUzzCQNMgWM3fUGtpDJyEWBHlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGfbJCB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741615193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifLyZAwaMIQnJH8LV9Yf25LDs5jy6kdU3M/pInj3w4g=;
	b=CGfbJCB3h74hfYh9wvbwHoAqsZ4D5zYvleITVtJeT+Fl1BKy0jj/NMtsYdyeoO20obKDqZ
	JKhhgZrZzqa60YeqCuqhrOCPox2zJdobkp+HLaw5ewmWT8XvHqfWUFQ+dIVCyWoK8DqSqh
	kIvccIwUKI/qIJP0j1vsD3eCszoFazk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-xlGJMYJNN7-zGKOGyJxv3g-1; Mon, 10 Mar 2025 09:59:52 -0400
X-MC-Unique: xlGJMYJNN7-zGKOGyJxv3g-1
X-Mimecast-MFC-AGG-ID: xlGJMYJNN7-zGKOGyJxv3g_1741615191
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c747c72so17532815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615191; x=1742219991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifLyZAwaMIQnJH8LV9Yf25LDs5jy6kdU3M/pInj3w4g=;
        b=bjyyvKG1G6NHxhkiekGH1MuTveDQSF5MWv64ByzvFeZlGSLOX9BaDeo8bSX8QhE2yL
         +bpkNrfSAdRSI8zLJ8oBzdbBHNiwFwOgqdgE9b6hoK8YmF/1yBJHn9Iy8geNrYoZvg5F
         yXs2rJWQsePF7BEULCxCG8r8jskbLp2SQcajRkFYc8lDgMjyszEVkkVbkYaQv2IUnJlw
         PgP4Oiif6MK6EUdbQgYVz/EyzMWeuuO8yZ/FVJi7IGGjsbZccuYBwTrzxHVB59kw0sOR
         dDqkyAEP/RRPXi+rNvmnbWYSTC3itf9/X6trUnLQo9skmnB4jwXuzGF+vkin36xReT0n
         Yptg==
X-Forwarded-Encrypted: i=1; AJvYcCVcPYlA0Rv4reJZylvRyv1OOYV5NyOf0uaP5Cp2u8uBWK3vRnZtOMJOISJ59+m/2SMemzEXD7uNu/5gsug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLvWky7OUIyLVTLYo5bdOMCBk05Gm338shG3yzDDgvtnEreCqj
	dveVUcVxO28dtDqCLtUTzOwJePLVhw6UB/ptJd/jIMulkgJWw8Xr5tw19Eg6XHGGjCtHseG5am/
	j9SJeTfTidNw2YPV3ejRblTO7CpcLLLCdEDyoL5HPQrPZe9Py6CO5iszZ3NrQoQ==
X-Gm-Gg: ASbGncvHg8tpO/wZ/AaDav9AkmMImRO9o3/JIzYL+tZACvSaJssrWYjGKkpa2bHN7I8
	NJ1UzsFBlg6RekKZwnhS0JZx65bQIG7WuFp4baN4oW3cJDon12MIg5tqTAuISlte38Gxso2ic+v
	dF1FAvfqQ4s7PNBi7SPUnLDdobU9wdGrFsVHRGHj2OsKc4hz/nQT0zVB2T25yxJCYlHubTHi4Au
	3KztGL+S9zNZIk+7zxiaYg1US/+YgmzaXZnxEyK5GY1v+lqBgFYNM8JGSDHtgDzyjQayV9XAAV8
	fud+TNztD1Tk/2ylA5Itbj8KpdmjsbnJC81+UMUKzU87P6bNiM28lFLIT/bsV5jX
X-Received: by 2002:a05:600c:19cd:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43cf1b81b78mr36929285e9.30.1741615190717;
        Mon, 10 Mar 2025 06:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFmVHuNChMNNNrFWHjGJdn1345A9IsanbdgH+oWygKlCfwy44eSx0LLGJRthRLUF/igUx+qA==
X-Received: by 2002:a05:600c:19cd:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43cf1b81b78mr36928725e9.30.1741615190121;
        Mon, 10 Mar 2025 06:59:50 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceeb5995esm64570735e9.16.2025.03.10.06.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:59:49 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:59:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 2/6] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <6yzzspawrp6lg3m242bcdl5egpdvt6je2kc3cuznnnze7iypc7@4uaonepi7myq>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-3-sgarzare@redhat.com>
 <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>
 <mjftygohmhgs6daqvgkh2jbfuqjquchcaovcjtnzyhilnt5ww5@l3fr7phqh2ps>
 <3dd645f2-476a-d0d5-c8c1-c87307f2d756@amd.com>
 <20250310135133.GIZ87uZZNhNSkmxvg1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250310135133.GIZ87uZZNhNSkmxvg1@fat_crate.local>

On Mon, Mar 10, 2025 at 02:51:33PM +0100, Borislav Petkov wrote:
>On Mon, Mar 10, 2025 at 08:27:37AM -0500, Tom Lendacky wrote:
>> I don't think anything needs to be checked or printed.
>
>Yes.

Ack, I removed the check and the print.

@Boris I also removed `ret` to continue the slimming, so the end
result should be this:

bool snp_svsm_vtpm_probe(void)
{
	struct svsm_call call = {};

	/* The vTPM device is available only if a SVSM is present */
	if (!snp_vmpl)
		return false;

	call.caa = svsm_get_caa();
	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);

	if (svsm_perform_call_protocol(&call))
		return false;

	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
}

Quite nice, thanks for the review!
Stefano


