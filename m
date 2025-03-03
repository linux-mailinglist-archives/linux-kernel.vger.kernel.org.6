Return-Path: <linux-kernel+bounces-542211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ECFA4C70C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3777E189692D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BB4215041;
	Mon,  3 Mar 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CslCQHQp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A721504A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018925; cv=none; b=BY9+ibWBhmCBuSUUK2HpO8vEMPf5PNRhOoMwExogpG6hDUICsvwt0FuvbJsdglrgX0LRvtd4fzcTTu51NhXEOQ8SsNu4jvEtavbO7ZVqmyyH8r6M/Xrcz/XOkxal7wZ4kUy6ZKB+2BSqZ3wivnw0moUKGKThMUFotQxDd2k5KGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018925; c=relaxed/simple;
	bh=LbJNoTrvq+2ziXPQ6cPoGKYMHLbQOYW28RIh2EZ+nAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8VdAgcnOJokn4N3/IqzBePaLSsxkDxpFd18gMACxwJjz5Z504k4vOulM0D6VWGNpRSzoKeJVsBYA41uKujSsgRglPRWzoyMpxHbWvKAAGhrIkXCakA8DpnKtHG0f3aURYalCbJjUXn9N9wudC91Y5lRud+3ZLGVwpVCRRNxv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CslCQHQp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741018922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaU2dnDpqgEzFLAHxVwOT4KJt49Y2FVgJePw+X7Ose8=;
	b=CslCQHQpcOQs0SlZbjolfPdadOx/9gF4mvb62R3R4AXOx+40G9CJURalQYX0mgVpcSL5+0
	uTGdadKR+OKj041NpR6+rytoKhJUV3vpQjcr2TBIXhg9BE7sAumyMlaDpVmn9MWAiemG+C
	zoWRNrm3yUpQJqJ48QQuHwexXbK+ufU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-iviJdMn_OrCk3-Hn5OXbPQ-1; Mon, 03 Mar 2025 11:21:56 -0500
X-MC-Unique: iviJdMn_OrCk3-Hn5OXbPQ-1
X-Mimecast-MFC-AGG-ID: iviJdMn_OrCk3-Hn5OXbPQ_1741018915
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390f11e6fdbso1353760f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018915; x=1741623715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaU2dnDpqgEzFLAHxVwOT4KJt49Y2FVgJePw+X7Ose8=;
        b=DJbbrYx8qydd5sYfrIRHGUPnlClRrFHxWI2EJvnFdiAbGhPa7YUkq0poHoCSXxzBWR
         IUd+FW7igg3hiJ2NtV32qabTgFKzon6pHQkBNl04g8PvFXmIEh/Uln+EtKYe/GP+vQd3
         7dmfM94csdaleOBLSTbWXDKnFuSf7Nce1WOKNPr7nQfd6wBTf4jc+CeEbjwc/n1SSxbl
         3QZ64dCnaYeV7v8dEMUaZHFndQEK5PKuwe81QiMTTEQVARvPju851RGfYMeDL75xeoVi
         AD5Uz8c0SN2Kp78oFmGjDdjdbOtRQgBEiy7x8tx2H7LxydUbe+sHadyPBVX6VmKnLa5r
         6bqw==
X-Forwarded-Encrypted: i=1; AJvYcCXUlHTNOUnK/zA3BVSQwSC5EhyVVuNuM3VNca3apQzU1x01D+4EaxJifbVrK4+CJ+RorVYNR7pptjmq24o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSYr1ippRZ4wiWbc1Bj0cLPVeZg5Lk5GfPYy8njYozcSZM0wi
	tzjTPelqn68p0f0UHnQATJ7U3qSlOLlNiooK28pLbxsA2US+hrJvKQW8qpUsSRprmDUPTEEOCzM
	nisJvrEx2OQ/5C6Qyz8CAw2WwjEYvN4pxeae4Z7QOkORwDwUNIsa+URNZz5Vw4w==
X-Gm-Gg: ASbGncuBtnFRxW/b9T74aMftwHHmSnp/UawOw02oJ/OCvIJ/8Pk+f8NDNnpLPHxC7M/
	NbzZZEM12hBKvM4AKocXXYyx9JQsslHrvkU6iAvTNWcllAxe+PyVnIS4OkZ34+hP+6rLwLG1qMs
	6HdgOSiRHzDwuW7YFYP5SNQswwp3nHybpeWAOTqklSykYXhAV8xuCPiY/BTTqlopbXmKF+yf4G2
	AMAapqdm9qWFl/IzmvWTwRZXAwj+HW/ML8FsnVZzZkzioz0PhDaZLSgqSNwQsLgf5Qm25Tol2Gd
	n4vlCr+IkTBdbU6I6WVet5H3G8Z4AHtWBRaloPUzTJXasAq4virGYvf84j1JLMY8
X-Received: by 2002:a05:6000:18ac:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-3910454634cmr5710022f8f.48.1741018915188;
        Mon, 03 Mar 2025 08:21:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6QrksmkiLyGLOBejTcc1pl1o5yPlizUYl4FhTdgmEYaBVAixN64pSnMJJOGRErw/KFrdszA==
X-Received: by 2002:a05:6000:18ac:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-3910454634cmr5709980f8f.48.1741018914747;
        Mon, 03 Mar 2025 08:21:54 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965f3sm14808634f8f.9.2025.03.03.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:21:54 -0800 (PST)
Date: Mon, 3 Mar 2025 17:21:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8Jmps6AF_geaHUw@kernel.org>

On Sat, Mar 01, 2025 at 03:45:10AM +0200, Jarkko Sakkinen wrote:
>On Fri, Feb 28, 2025 at 06:07:17PM +0100, Stefano Garzarella wrote:
>> +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
>> +			 size_t to_send);
>
>Please describe the meaning and purpose of to_send.

Sure, I'll add in the commit description.

Should I add documentation in the code as well?

The other callbacks don't have that, but if you think it's useful we can 
start with that, I mean something like this:

	/**
	 * send_recv() - send the command and receive the response on the same
	 * buffer in a single call.
	 *
	 * @chip: The TPM chip
	 * @buf: A buffer used to both send the command and receive the response
	 * @buf_len: The size of the buffer
	 * @to_send: Number of bytes in the buffer to send
	 *
	 * Return: number of received bytes on success, negative error code on
	 *         failure.
	 */
	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
			 size_t to_send);

Thanks,
Stefano


