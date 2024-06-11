Return-Path: <linux-kernel+bounces-209143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2690902DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786DE1F23981
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61A37494;
	Tue, 11 Jun 2024 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ytLnxIH"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CBAD49
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067858; cv=none; b=E8IUQGGz3Ycp+Pr3fs7srOnVphg+LlUcfnLBpvI8u43KWfGq0NLh/h9/IDdM5R4WmKJ/RZYRjwT9k9880m8Dwd31EoZqqHtQiAXFc+gpoqyWezPT6Ken8p6kZEowheMReYd6YbfBYOAYQQjWO4t/JrPhOe24aqW+0+IYvtJN1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067858; c=relaxed/simple;
	bh=D2+4ZRld+LsfdHH5oCEX/3EUmguv5mjwKhehKsHkJh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XeHiqxVq+SmKbGi48zLI5svzvup4iRdnRqJEVxJkpcksmhICldtVwUMlRnEx2MQN+lAoaBTqjcUPxzgYxvH3heYNmMNYoYDLLBqK5fRsCpT597bvJXJnXi7XvqLaKYmwy9oPb2PSK/Tyea8RTODYHnWtSHLM2CEADoIi/SzX+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ytLnxIH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7a6530373so9436050276.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718067856; x=1718672656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WaCxstfADOBw8wNVrRw4wVAYw0tVDjv3GN2v+YDuDTI=;
        b=0ytLnxIHF/N9Dw083KuxQSWGWrGYZF6Q1HkSP03Zx4zcWAIV1I55YrB2lpz4h+ovxa
         ftusB98vsVc+9LmHz2dhRzswiLJ6nMrH6X4OjM/K+aeQc98TYugYHsdOklpI5bGTfpeH
         BtXa9ayxihKXbi5FYQ2uVHyhAmdXNk9i23HDCvJzbzcMG/cNMJ0xWrEL/uFxJ2YL2rcF
         5/HjyJEDqjqIPIOSfWi0xz5iMWjkyDgnj2cel59lsRK/+gKDItQju2kvglvoavfBd4HC
         CGaiNhLMenWCE1ip43TlOCQIO9Ab274aAoa/OpFw0ldR0nFW80BhSKH51qzh+0i90C5N
         RHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718067856; x=1718672656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaCxstfADOBw8wNVrRw4wVAYw0tVDjv3GN2v+YDuDTI=;
        b=EYUc+HFxng01GZ4yBP2qIq/iDhrbj5HSmlmyjX9j9SUdKJR5sGOfcN+tSYMKbwJuYZ
         OCsRtdP0Vzl1ep+G+iPBxsjG/jkqE7A4zr9l++PBsXQiqCbcu9/VkKOWXc9RAI/QqPk7
         OFY/gYpMer5ozAqWe2Sc1rfZe8DjModFDRq6xMfDsqhy1n20c/XckjXpMeUBRaIzONiQ
         DojZA5QqSaIx0IM0TCfZK44sW1xHrzt1WKy8AOPwMaRIWnw/UyBK4OQX3V+neGSwpGty
         XyaW2mqfZ4CUlM4Vjwx5R6xHZ4yiAkUEb6NQpw/uPNA6rMHnuBZoLVtGo57/zSq5UquE
         8ToA==
X-Forwarded-Encrypted: i=1; AJvYcCW8mPltOhMeghSUJtjpQnjIHn0a+3EcVG6A5TRO9M+hzKn6XJ8fckEn7bQoPD6Iqx9RiFSjLl12s3QLnPAB4Unkf77G9fo1XbA5CL7f
X-Gm-Message-State: AOJu0YwYf112v/1B29j2MeQQ9ly6Li4p3Zcec8CnOiW8Tl15X8KQ2mQi
	/ezpNxLXmmPcWIBq+chKp0+w0unkmYIKad7trjx7XDg4pKgpHNpbwTCsfhxBqG4oqci26zP7Fn0
	d4g==
X-Google-Smtp-Source: AGHT+IGvBLWBjAlpWDo3F4MrMaWCiT5ovZHraTyxq1RuGeccOfGQ1Zsc/yTzZhOgVxEqKzdr0icpIDmQzrA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1547:b0:dfb:5bd:178a with SMTP id
 3f1490d57ef6-dfd9fc66fa9mr357303276.1.1718067855765; Mon, 10 Jun 2024
 18:04:15 -0700 (PDT)
Date: Mon, 10 Jun 2024 18:04:14 -0700
In-Reply-To: <20240509075423.156858-1-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509075423.156858-1-weijiang.yang@intel.com>
Message-ID: <ZmeijsBo4UluT-7M@google.com>
Subject: Re: [RFC PATCH 1/2] KVM: x86: Introduce KVM_{G,S}ET_ONE_REG uAPIs support
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, mlevitsk@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 09, 2024, Yang Weijiang wrote:
> @@ -5859,6 +5884,11 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  	}
>  }
>  
> +static int kvm_translate_synthetic_msr(u32 *index)
> +{
> +	return 0;

This needs to be -EINVAL.

> +}
> +
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>  			 unsigned int ioctl, unsigned long arg)
>  {

