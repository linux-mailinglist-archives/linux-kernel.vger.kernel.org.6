Return-Path: <linux-kernel+bounces-378929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ADF9AD759
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29581283EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B41F80B8;
	Wed, 23 Oct 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THGSSq8a"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D613B7BE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721288; cv=none; b=AknUHv9Ag/JOjP1cpOKZG4HGcy7p1iacWqtRU43m15RG2edyRbedJKTZZAtJsMR07B0hQNWXBgpe7XlCViVUjXTSXLe7Ad10MjgxvVR2Aw445Q1re8TmzSo/poRYsJ2Iygqiy+2fbl0eeCXAcg44jVYDNfWkw07x/9zcDem8h94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721288; c=relaxed/simple;
	bh=y0WJDZ1HtCaT7Hi+H6DYeUDfXtKJ6DC0fA53zvaP+C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmoSNBA45VZ6vOyA3TaBWWbUFYsINHxDsWd1AFYHZeKgXC9wBJNjxBT+SLhrrG3HtyCRySffDjTWONfSbbvsEwO2+oKwNUFJOCMWPh2sJntzRy8v7SpuPsu8awy1kQ3arUx+HGhyfwtI5svg747cQwQ4JlCIj3j5CAPM8hym2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THGSSq8a; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a628b68a7so27854766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729721284; x=1730326084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehJFlAUkRRJDg6CJFfXp34ZS+KX5A1k6GWbEa15wGL8=;
        b=THGSSq8alhAKD42nq2KmW4uJ+PQ/P7xA9oRLWfNqn7wnQWYRT4NB3dTHdYtHoNP6/z
         n143vCHN8/FplRFuw96+h9ti8LOaG+F1F3T+725wdIStWKLw6eIC3CwUFlyW6VRIM7wP
         kS1zBhV9AQUHDDeFQgrn1WsSkZRQRzZYkrqcxCna8DXejMLj9DVpSQujR7ahc2XjZ74B
         af98p92NEP7yyXIPPD+o/nkwxPl6+jGXIfXavQ/IC0zJX44/cOZWG/f/Rc4baBdL1dPp
         27/RxDNr40XPR4lO/XmU6yf0fM2frEdDg5fJ4VQmfDH55FmvxSMp/hZSTnBXM0sJuEk1
         nqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729721284; x=1730326084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehJFlAUkRRJDg6CJFfXp34ZS+KX5A1k6GWbEa15wGL8=;
        b=l9s62Oliyax0TDgMkIDn5LeT8KCCCKQKbCbWJfJVE95TGk6tsQcdRp2vZDf26scy/i
         aJxSmnKByOcCo5dHicJjlt6FKG18JHKMYQMOXs9uUwf9n4YCgCCKrqNvWLrEmzA0rYYl
         cLF9zOpHUvcMUzex6QLBSTxfrHqjC9DD0XappaXw0glPi0h43eu3Jbc28UHAFSCVxY9n
         HXRd0VaOxFm0gfP+XjJNv3kGCn4thqWRb61w7DjoCu/SZzqIgiusfRbUHfwuKN9ZlMQX
         JZDe82iqFI68wdGEEmJp12MNwIXq0ozIHkGDKKxxnJ0xFFj3aTmgNl8S0TAYxdaGO49B
         pbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlMyAILo7QpD3GZtHtez9XsmArbK+Wsfw82sStW11Pg7UHI+WOF7gg5OJdwhKCULf1LrnpOsmbuQCckjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzneAmooObpD7ts7RFUndkvV6t6qteFCQpbZzxkyjI+RPwTGRg
	tqPryH28ZAn5vArEGOUQNXjaSD4bF9Rxa9vURgKqy29roV4lIJ6j
X-Google-Smtp-Source: AGHT+IEEm2PEGEJZtXMwCSIva2QSF1F6o5EbG5ApaOqvZaa8t3T43HIFKqWV4sqBwhl7V539NroGyQ==
X-Received: by 2002:a17:907:746:b0:a9a:1f38:e736 with SMTP id a640c23a62f3a-a9abf8aca08mr352854666b.31.1729721284312;
        Wed, 23 Oct 2024 15:08:04 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9157243fsm524507266b.165.2024.10.23.15.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 15:08:03 -0700 (PDT)
Message-ID: <4fba013b-6cce-d81c-dccf-994f56548629@gmail.com>
Date: Thu, 24 Oct 2024 00:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: RFC, untested: handing of MSR immediates and MSRs on Xen
To: "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <7a4de623-ecda-4369-a7ae-0c43ef328177@zytor.com>
 <83b67fa6-fbe0-4a38-891c-b0b49d5cc5f9@zytor.com>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <83b67fa6-fbe0-4a38-891c-b0b49d5cc5f9@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23. 10. 24 23:34, H. Peter Anvin wrote:
> And I of course forgot the include the actual code.

> 			ALTERNATIVE_2("ds wrmsr",
> 				      "wrmsrns",
> 				      X86_FEATURE_WRMSRNS,
> 				      "call %P[xen]",
> 				      X86_FEATURE_XENPV)

Please use %c asm operand modifier instead of %P. Please see comment in 
arch/x86/include/asm/alternative.h for the reason:

--q--
  * Use the %c operand modifier which is the generic way to print a bare
  * constant expression with all syntax-specific punctuation omitted. %P
  * is the x86-specific variant which can handle constants too, for
  * historical reasons, but it should be used primarily for PIC
  * references: i.e., if used for a function, it would add the PLT
  * suffix.
--/q--

Uros.

