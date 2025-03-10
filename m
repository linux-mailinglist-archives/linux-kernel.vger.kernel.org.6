Return-Path: <linux-kernel+bounces-554233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0DA59508
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370EC3B0493
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F3226193;
	Mon, 10 Mar 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmWv0FH/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04513CFB6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610772; cv=none; b=FykDr4BtDqa5uh9P0kp0uXqgwMh7WMHmSQXlpz+VPpsc7iqt5xVIRDGRaEKBmQN/ZnlvXYSrNGYawJunWDniMYHQIEdHYRKp5QdniWSd242Oh1cDge/I571C1AWm4F12iJJN52m9SBWfnhhvORRA2qP/+g8xrodVxO+fEfNyLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610772; c=relaxed/simple;
	bh=vt0MYtLg4CHXSq1p0g4tHdTFErTG4CCMI34AyagjJIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK5qtvPLYIrr9MbM40t9cobcAlMEaIUtM7gQNdr+L2gbGdHmHdFgCOtAsYdFtEY2FRxbnQvPz5R5k347crzq1Jmf08q/n5p4DS6l3M9vmC8INr0od65zO6XOaGedxtMGVMA7srezMEZIIt7LeJBlnXJK7VOvR+AsU/ir1CSyniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmWv0FH/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741610769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzGhRAwyfwCgJL7VddbE1vAnO5lIOU70lgIhAjbThjs=;
	b=XmWv0FH/lCLLnPEk3mdDfD+w3vjc8RX4s8Mv2tS4nInnayxZI0SAW2bDmME+RZq/d0hXbQ
	Dxt5YaMjgvqbDuIM5xTCvJ4rlzMk/MRHnuaAL7toK5YkowdN4hJp7yCrWZeyOvPREy6aij
	J8D84ER4SA9A+cJjwZPLf9VQbwS4sso=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-0-wlwEF1NviwQW9rFb981Q-1; Mon, 10 Mar 2025 08:46:08 -0400
X-MC-Unique: 0-wlwEF1NviwQW9rFb981Q-1
X-Mimecast-MFC-AGG-ID: 0-wlwEF1NviwQW9rFb981Q_1741610767
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so5298085e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610767; x=1742215567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzGhRAwyfwCgJL7VddbE1vAnO5lIOU70lgIhAjbThjs=;
        b=ByjRt1MtXbQ00MVQdjSU7tabc0URGK0WbPTmzmuTdOBgPwP1RUkzOhPHMuCLknPjHo
         TrO1WFBnjgeGh7G2rP0oC/qTmArrpGVkVK02+l3kUuKNBaMBVNH/Yt/I6huhQNFf1fW4
         lsl7LzRVyCYrdeJKxz5OitgBRCcbwAj4x+is2gV+A19whTuul3JHCzEGDA5aH4VcQt+u
         5IOHfdthhjk8xufc9Ikapf0QIaWL0QRklwjwcKl9SN34ghq4WFb8flkzX5AAQ59nZWYf
         IyNY0wiLAVKbHVpXLKHgdzbzetyWGljLaW3PCBQVQMqcSkL0LoLBGN1MRxhRuHYAnHuw
         Ayag==
X-Forwarded-Encrypted: i=1; AJvYcCUDC2OhEX24ESvPnx/5ukxWBbyeWTRWutaNZxE3Z1nXwYjxHnw2ZaDMBmhmC6CDmHAS6KPg7BucXjZB16I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2AeIWa0wN8jCF97dLmm/jeSsd5I8rT2FJNGPyGGd8mjrNFKK
	xz0yHQUHGx40GFs4Njsl0Xq/baWTR8LO1kktcm1IBxuk8PIggCYpGNhBO3JMQAcPR11IgYM/RLZ
	2XD0JSTA5TaBDszjyJ1t0qBjiKsCCeVfEbwL+pmxG+oVb4+wlHM/oH7BiVrjKhQ==
X-Gm-Gg: ASbGncvDC3ulf3/zcUx3yGTCrmyt8rX5VnJ/i81v2p/O5/Ess+5EDlQL1ke40xXUeoi
	BtLvAZ4dgMu1JZ0hNymi0Ih28uwCHIoTVjUPmIHxS2BhSPDoAjyCWS9r0yMbt6MBj3HlaprckNY
	L1dKMRpsak7mKp+Qup7+oH/tNGwpUxQ2ALdIglXdHmYk4c3pueUr610tFt56y80C1DKVeOY8Som
	XAIC0mbMa/3zypA9CHfUE7a2bLjtofcvLDG2MW3CAUSK2fBVglgMeSXICNaNfHt0AHxBRPE2Wvr
	WlosFTczkzhLH4RhLrf4F7qHpEGx5DPpJffTdIu/iR4uzBXkwrGGPDT/YYqgNNOr
X-Received: by 2002:a5d:59af:0:b0:390:de66:cc0c with SMTP id ffacd0b85a97d-39132de1bbcmr8834252f8f.46.1741610767024;
        Mon, 10 Mar 2025 05:46:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDnYXKSGJUcMOe6IcvYP1PSR5hWGIDfDeURgFJlzdqo6bEHikOCzADfs5ewDHrok29Sb+OHw==
X-Received: by 2002:a5d:59af:0:b0:390:de66:cc0c with SMTP id ffacd0b85a97d-39132de1bbcmr8834193f8f.46.1741610766492;
        Mon, 10 Mar 2025 05:46:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfa97399esm26211945e9.14.2025.03.10.05.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:46:05 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:46:00 +0100
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
Message-ID: <mjftygohmhgs6daqvgkh2jbfuqjquchcaovcjtnzyhilnt5ww5@l3fr7phqh2ps>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-3-sgarzare@redhat.com>
 <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>

On Mon, Mar 10, 2025 at 12:30:06PM +0100, Borislav Petkov wrote:
>On Fri, Feb 28, 2025 at 06:07:16PM +0100, Stefano Garzarella wrote:
>> +bool snp_svsm_vtpm_probe(void)
>> +{
>> +	struct svsm_call call = {};
>> +	u64 send_cmd_mask = 0;
>> +	u64 platform_cmds;
>> +	u64 features;
>> +	int ret;
>> +
>> +	/* The vTPM device is available only if we have a SVSM */
>
>s/if we have a SVSM/if an SVSM is present/
>
>> +	if (!snp_vmpl)
>> +		return false;
>> +
>> +	call.caa = svsm_get_caa();
>> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
>> +
>> +	ret = svsm_perform_call_protocol(&call);
>> +
>
>
>^ Superfluous newline.
>
>> +	if (ret != SVSM_SUCCESS)
>> +		return false;
>> +
>> +	features = call.rdx_out;
>> +	platform_cmds = call.rcx_out;
>> +
>> +	/* No feature supported, it should be zero */
>> +	if (features)
>> +		pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n",
>> +			features);
>
>So
>
>	return false;
>
>here?

In v1 we had that, but Tom Lendacky suggested to remove it:
https://lore.kernel.org/linux-integrity/4valfkw7wtx3fpdv2qbymzggcu7mp4mhkd65j5q7zncs2dzorc@jjjevuwfchgl/

IIUC the features are supposed to be additive, so Tom's point was to 
avoid that in the future SVSM will supports new features and this driver 
stops working, when it could, just without using the new features.

I added a warning just to be aware of new features, but I can remove it.

>
>> +
>> +	/* TPM_SEND_COMMAND - platform command 8 */
>> +	send_cmd_mask = 1 << 8;
>
>	BIT_ULL(8);
>
>> +
>> +	return (platform_cmds & send_cmd_mask) == send_cmd_mask;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
>> +
>> +int snp_svsm_vtpm_send_command(u8 *buffer)
>> +{
>> +	struct svsm_call call = {};
>> +
>> +	call.caa = svsm_get_caa();
>> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
>> +	call.rcx = __pa(buffer);
>> +
>> +	return svsm_perform_call_protocol(&call);
>> +}
>
>In any case, you can zap all those local vars, use comments instead and slim
>down the function, diff ontop:

Thanks for the diff, I'll apply it except, for now, the return in the 
feature check which is still not clear to me (I think I get Tom's point, 
but I would like confirmation from both of you).

Thanks,
Stefano

>
>diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>index 3902af4b1385..6d7e97c1f567 100644
>--- a/arch/x86/coco/sev/core.c
>+++ b/arch/x86/coco/sev/core.c
>@@ -2631,12 +2631,9 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
> bool snp_svsm_vtpm_probe(void)
> {
> 	struct svsm_call call = {};
>-	u64 send_cmd_mask = 0;
>-	u64 platform_cmds;
>-	u64 features;
> 	int ret;
>
>-	/* The vTPM device is available only if we have a SVSM */
>+	/* The vTPM device is available only if a SVSM is present */
> 	if (!snp_vmpl)
> 		return false;
>
>@@ -2644,22 +2641,17 @@ bool snp_svsm_vtpm_probe(void)
> 	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
>
> 	ret = svsm_perform_call_protocol(&call);
>-
> 	if (ret != SVSM_SUCCESS)
> 		return false;
>
>-	features = call.rdx_out;
>-	platform_cmds = call.rcx_out;
>-
> 	/* No feature supported, it should be zero */
>-	if (features)
>-		pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n",
>-			features);
>-
>-	/* TPM_SEND_COMMAND - platform command 8 */
>-	send_cmd_mask = 1 << 8;
>+	if (call.rdx_out) {
>+		pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n", call.rdx_out);
>+		return false;
>+	}
>
>-	return (platform_cmds & send_cmd_mask) == send_cmd_mask;
>+	/* Check platform commands is TPM_SEND_COMMAND - platform command 8 */
>+	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
> }
> EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
>
>
>-- 
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette
>


