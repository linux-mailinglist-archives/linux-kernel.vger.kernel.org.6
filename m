Return-Path: <linux-kernel+bounces-542209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B1CA4C707
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B714B3A89A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC75239597;
	Mon,  3 Mar 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CF58p78I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D82147FD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018870; cv=none; b=cOsWqcIfAk2RZqrJ75HOLStsnBeXibmAC0YoBskdu6L8sD1xyYOJbcmdiDeptzSB7IDAYhniLXwrO72ziQpUiwT6RmmR1VNPsKS10dae1nvWiIAQFYhdsRyo01pIP7m1bq/oapcL8mtL97N15qb6YMRSn9UWbO92JB2z75wG/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018870; c=relaxed/simple;
	bh=402wUqZufsOsa3QE1ks4oJmtnZKVbPJ2tFfnJxLD8J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtIl6RXF5WhFY1xcQ70NbWE5Gm3chqnfv+7Sc/KmDdVAT3lftHk/LujNaUYRa/RdXpCTxLCN95lOy/nzslvQ/SjV2KjYrij/Z345mGfsQxFMPOoCMV1z8JgKybfCG8jUEkYCzt96vkYrjVYFN1pnGnwdEPMXZZbHWzycGbG8RgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CF58p78I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741018868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kwE0kZnHaMHXEDQxouFsy+p0EMd7yWpEqSqhQfyrJvg=;
	b=CF58p78IzAV6Gq7e6N2MpEXp4ARBqCbjXuRbA19pfRpmFgzOcrhdjZFxIFXaPWHMWa5YPC
	MZfdcyxEtHo69RWcdA+XsrpZ0foVvDBOaQvZp/J40NE0lebnlcT9WJE0vc9amt/zLmq+03
	vNVv8Ss63ZrAjDaVrgia8HGnXX1qMuY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-iDJeG4nZPl-kuvjiUvklCw-1; Mon, 03 Mar 2025 11:20:51 -0500
X-MC-Unique: iDJeG4nZPl-kuvjiUvklCw-1
X-Mimecast-MFC-AGG-ID: iDJeG4nZPl-kuvjiUvklCw_1741018851
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390e50c1d00so3279967f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018850; x=1741623650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwE0kZnHaMHXEDQxouFsy+p0EMd7yWpEqSqhQfyrJvg=;
        b=B8481kshSdj/8FvcnTDijFVFo8eduQR5uf/L63zbGST8FUdP2q5R6FSlfo22zGD2ym
         Hf5UmUMb6bBnsFHs+wqvtlfqavenZl1NBVV0DA14iTL9vFGDiXGDoolFYBZSSoFNVkRp
         N7lBJIeSHlVJV4V9dk/32Dktq1p8An2NKpEhEEeQzbHMOEqxDm5B/LhF4RGbzwpZWK9A
         jvQcvtYOlfholcF7dkWMZJJt6SLwrvtgRB1uVcoG0FdoqZ0WHUWSzuIZ86JjVnS0ad8g
         TMYNI33qByyfE7tOs8qjarIsfiv4ISGaMBmKFiCrz4lAcQwNzA+KiP++ZSXXBxa5oZK3
         e5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8aGELlyt9xmYvDlRFH93MqACgsU4XeQgxEZxysiy6S9ndfr98+NpfK8MBHQg65wvmKYD24Lt/psinJQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzknsTeTVnDLrsS+CCL83u1w6FuHb2yMBBcpM2O2DjlljR8U1WS
	718bX3fWJUgg42B3052LZn/o1dFziOghgRI1gj8+WJbTRM1clJHljFgG4xj2hUdjH6UZQxWjgVA
	YDul2JkH2KhSOEVKnWxsiWT/XorZte7s1HIuRERB/T88csZgNvBGpAlXCaGyghA==
X-Gm-Gg: ASbGncuOL2euhGcKief/ag3fp10tcw1pY+gzdFhlqRCEkwask07Z2B8p2ogVxu0DkRT
	V22YGXx+N9nqkO5a1TA+aYK2yVP21nkwyHMG4wz8Li3E0Llgd00gPJ4mZduUNbP8vfjsK25tfsl
	hXgah6Dh2Frwa1uzpYZNfaVKBZyEa8cnz99m9+Xza7wbW8tp1CCxat6nto6h37Is4EJ3Wo8Wm2E
	dpBUBq83OBpA0oWVRdIpR7eRtOqaSs7WQrShpQ+BxoQlikXCvA2vbwI8e5F7dTpmXxs7xyoGaUX
	OfOfSbv+P/dY4GyzfQa2p31XSm3YuVGphillwYFaQzaCe4JKt2Wbn4ZA94PsgxFt
X-Received: by 2002:a05:6000:4021:b0:391:a74:d7d7 with SMTP id ffacd0b85a97d-3910a74d8e6mr4864359f8f.8.1741018850655;
        Mon, 03 Mar 2025 08:20:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJkGVDdAKM9Y8PmJ0U+nghUhjVOpFdN8aFO96nlwoN01M7SmNc/xMw3vIU8qZIs/W7CGHyJA==
X-Received: by 2002:a05:6000:4021:b0:391:a74:d7d7 with SMTP id ffacd0b85a97d-3910a74d8e6mr4864327f8f.8.1741018850234;
        Mon, 03 Mar 2025 08:20:50 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47960b6sm15276831f8f.17.2025.03.03.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:20:49 -0800 (PST)
Date: Mon, 3 Mar 2025 17:20:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 0/6] Enlightened vTPM support for SVSM on SEV-SNP
Message-ID: <w4zyf33sixofbqmz4mxyobihicrywjwvjbpmiipcqrlejjfwjd@t7ok7sjni3cn>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250301003009.GP5011@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250301003009.GP5011@ziepe.ca>

On Fri, Feb 28, 2025 at 08:30:09PM -0400, Jason Gunthorpe wrote:
>On Fri, Feb 28, 2025 at 06:07:14PM +0100, Stefano Garzarella wrote:
>> I put RFC back in because we haven't yet decided if this is the best
>> approach to support SVSM vTPM, but I really like to receive feedbacks
>> especially from the maintainer/reviewers of the TPM subsystem, to see if
>> this approach is acceptable.
>
>I didn't look in high detail, but the overall shape is what I was
>thinking about in our previous conversations. Very little TPM code is
>under arch/, we have a nice simplifying helper in the core code, and
>you have a tidy platform device to tie it all together.

Thank you so much for taking a look and confirming that I understood 
your suggestions correctly!

Stefano


