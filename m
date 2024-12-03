Return-Path: <linux-kernel+bounces-429130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112779E17BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C355816703C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8751DFD9E;
	Tue,  3 Dec 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/Tlxvoa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E81DE882
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218465; cv=none; b=eLRWD2/ckrfgVES2FQgJrMH62EtS6qx9EZXFGq0bDrRsSfau+TnluoAVkfdPwQbDdop+U5jL14aMI4N1cj6aGLp6dtaUdwzbDyTlHzouT2gscuXD19guefLORudRXbDl6+WkMCLpUQ/oQIZ3tTWCALKJdjG3NAfZj9cIr0P+u08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218465; c=relaxed/simple;
	bh=tmYNp4m0pTcJcMNGtDbDEbeNdXv5xyGIZImT4smrZE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLtWtTl/XW6FpIAsstRO59BTNPgvg3oJJiIt4pzt4wXUIxROkTuqQiT+HzKk08agSbE14xQtWjbWo+X9/Y3YA7AwtRLmIkUYKZRk3q1kCjweDYfoo18ZxhVPEj3Kbh2VRCVKV+w0YTWQI75mcUZXjRpyFXOvi6vvfAzGSPyLbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/Tlxvoa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKuqay+zTpWkFnfMu6dqxG2vMVa9093BS55rnW6Saqw=;
	b=E/Tlxvoa23D/boA8BuoeVmowxyBhmK5R5iWjC8BGz6w6IGBsYvqpXIdFfvxZFa6Q34jY8c
	z+/2KrTJbsTHNgIFPBeIim8ChZe4E+y1Xa96nVhsR6QYgFlB6iyrBb1qpWNoSeL8375o8a
	Lj0JrZ42ThTemU+p5E4APH97jIlMStM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-0h9V2_ToMiq_8DZRsTfO_A-1; Tue, 03 Dec 2024 04:34:20 -0500
X-MC-Unique: 0h9V2_ToMiq_8DZRsTfO_A-1
X-Mimecast-MFC-AGG-ID: 0h9V2_ToMiq_8DZRsTfO_A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d6ee042eso3238612f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733218459; x=1733823259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKuqay+zTpWkFnfMu6dqxG2vMVa9093BS55rnW6Saqw=;
        b=Q2YtzfFfVCxBc2Y/NSMLCxefMDmB/Sm98gOXtpk8MLzj/wBuztiqZm6pX4Isu6WNTr
         qa3hFGNbQRJnC1YMOZH85pbgFUKFHmGiLhYxj1qLTNKgIqDgAgA4TEQ6ILXlp9wBSR+O
         rRrjYgv2T4T9ywtjW0gTE9vZ/R6u13UyX2vz+7DG95ptsKNlEQTpCdpL3pje1ymhwowG
         qS/yslbv+9ZEDHl8xsTdkWs0eTtbMJDk3P7MYAlxw51YapPPnGfpwHVsH60KiDqF+bVO
         KDZpXNzY0GG4ufeG2t4AEPBVklAhr3WPu7YnRieFmFaMe0PhtmgD/QHzT0vTm2hz5LqC
         f1vA==
X-Forwarded-Encrypted: i=1; AJvYcCUBpOA/R/e5Y3oA8Jt13KqikjShZuP3ncp+6pJ30M4faJKdHawlR5pJy3Z62GFlRMzgL+N62dAMC4M95Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/p6Jlpdgf4p0R2HjayDgZBJ6o+cBFPAHWXIAaJTY575+kZGY
	5x6cCV5LjwVYbdSRR7cWZsUp9estCm4c3WUrzhDFyRmQTTrmCjHGGYywagZGRf2TM4tIxrGIIN7
	tqvS3x7BLCjEV2s4iwUGR92osr4QPDJ+zLa1UjZuX+5P/17cyNn9C6y9WZoqvwA==
X-Gm-Gg: ASbGncsAcSFgFVcTc7uiJBH1V4YSh/FmbymskqzbZL4fgXh9atEB05NMPdPSPy06D5e
	08QwhykNQMkmmJzURNZM25uhNi6CSdl3LX+uHK4XBjEGOlQVW7JrG3J3WaRWFXRHVyBUF/EiRDI
	PcGiclfjVFDrG5HDzvnslOXtss6HCOlS7S3z8Zi5B+P7a3nhrCbNFk3bFPzop5arZ3piehfyHAs
	7z0lqRo9LGPe7gjT7FHH/1bFXKbcKQa6YWG40VRKNvkhaVG9SONemGvcUf7daPT/Valmw4zis3v
X-Received: by 2002:a05:6000:2aa:b0:385:e8b0:df11 with SMTP id ffacd0b85a97d-385fd423e36mr1584701f8f.37.1733218459610;
        Tue, 03 Dec 2024 01:34:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIihO2mrO5+F8zuPbwwSnltX/0Ql5nndhmeyAxDibZj2Her5rsTK1xCeAtYSz9YJ0tENnZ+A==
X-Received: by 2002:a05:6000:2aa:b0:385:e8b0:df11 with SMTP id ffacd0b85a97d-385fd423e36mr1584677f8f.37.1733218459289;
        Tue, 03 Dec 2024 01:34:19 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e04c6005sm11643968f8f.78.2024.12.03.01.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:34:18 -0800 (PST)
Message-ID: <3720d154-a838-48dd-bfd3-f0f1cd595f0b@redhat.com>
Date: Tue, 3 Dec 2024 10:34:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ptp: kvm: Return EOPNOTSUPP instead of ENODEV from
 kvm_arch_ptp_init()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241127-kvm_ptp-eopnotsuppp-v1-1-dfae48de972c@weissschuh.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241127-kvm_ptp-eopnotsuppp-v1-1-dfae48de972c@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/27/24 08:27, Thomas Weißschuh wrote:
> The caller ptp_kvm_init() expects EOPNOTSUPP in case KVMCLOCK is not
> available and not ENODEV.
> Adapt the returned error code to avoid spurious errors in the kernel log:
> 
> "fail to initialize ptp_kvm"
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

This looks like a fix worthy for the 'net' tree: please resubmit
selecting the approriate tree in the subj prefix and including a
suitable Fixes tag.

Thanks,

Paolo


