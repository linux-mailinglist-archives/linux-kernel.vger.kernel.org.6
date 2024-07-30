Return-Path: <linux-kernel+bounces-267988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D39F941F10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFAA1C231BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089DE18A6A2;
	Tue, 30 Jul 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEnz6Yl2"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DE1898F3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362189; cv=none; b=uXIIR4OJ8dnDVkGdOGMEyLYgBXW0DaUahyHHiqB+t4pQMtjsgHD0GxaRhK1m7yRDr1jnZchyQgjTqQCnSMO0NG7tfrr1uuaZT1BbZnX6vvJFJlUVCIv98fWIjiHRxN9Q3eUYFfOHrPH/Z6roHRATSjsYdsQZ8g0pXcgIm1LX8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362189; c=relaxed/simple;
	bh=clDX0AH3ie6CE5gZaYN6ZgnTNNR7wl4EUFnpUsuWZys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=osNh/zYYIkhrWxBXi7OXP/l31Iu1qikAM6KYGY4BtKGVwo7W6mf3ZLYQD0mtu4r7zWK8l7dtpwPG8GfK3kBt8qPrLqHnwBB4b5UkPe4hMa6Jk2S21wV1Zt9WhtxmbrgNPqANzI5KuD6I+8NZ4pqPuuJlr9/dPqWP6/wcy5/RUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hEnz6Yl2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-710415c77f8so1135096b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722362187; x=1722966987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5ReJS5eOTONFkIUkRNY9RePjsldHTBCrkbHRHcbRgw=;
        b=hEnz6Yl20dkdSgHJh0F+5SwajICOQ654X1a5qc2ehqpVrrhgpnvM3bfXt8GZnH1k2Z
         AoFH2XQ1L6mD38etj0yoU5OmuWsFIwvGn2Ogj6I6FQmzadOlEiXjCTgaYW+1s3dtyiM8
         Owqi8yH9qBuXT6MypwunPcij5l1yHSYt3B9XtVmlaKP8XdHQ6FRKhFH5Tiamt5WBEPzN
         cakf6wEEv/JVZozcLuRElVSrWkJBLXrMpzo01+nh/hjfSXWcKrDZi32wAyMRu20eAfOg
         TL0ufL6ZCR2LB4eC5lzzoUj1dpR2fVCnoEM17yFPYNWIRh9B4WLlL771njUSL7qhenKU
         xj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722362187; x=1722966987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5ReJS5eOTONFkIUkRNY9RePjsldHTBCrkbHRHcbRgw=;
        b=bMabHeNd8XxCwCkJJXJydYSC9TRLSFEFb4OcHJsYoyK8rKPylxTP4L19JlXioXi6lQ
         IL27B0z+tjQnuIGEDTbUATYj9D1nAsb6SrKR4fYoTLuF9jqLAqIt2icxZChMgy6JINdL
         vw35cp5DaKre6uCEd6WhuORL79sc2EV0kctofvMxxS3DbHiz5PJHADEhn9yHK8eMCxGb
         7d1rDHqW/TteuCdaGg/mySYKl7aMmuvZrsJoRDKCjhLWPK/HG/9auMXLz15F2D9q1QyB
         A0Wyp69wSx94BaD5oTe2+j5/WtvvQebDnhtlIJRlRdKMMGv21/3G6SVn5Y3jjZmsfRRj
         3rfg==
X-Forwarded-Encrypted: i=1; AJvYcCU/F15s0J78e+Sd1o9DQZgxC/2n2sJSbxJrLMJ0h+5ym85tVRoRWkzZev9muYDYYB+NP/QS4bTKsv+SjdZUnPpIhyid92/1kiA7JT8Q
X-Gm-Message-State: AOJu0YzZyBaCw2Ib6IGse+/WDcVsLOJ14c1sF9+Do3pfSfAWKphOaufe
	W4iQ8kVif9hCZPbHCf/5OUd9iCJQ1yx0MCWJjmOvnr4S6Qp/5K5FL6BVIQP0D6BcaOpXmv1NHaT
	VZQ==
X-Google-Smtp-Source: AGHT+IH02dj9QFhhIx2HroQS9I0Z6Bdlq6Qv1jCSUT6NHJQk9HXORWjNuBwTt/8b7GSNIi1JUbPLl4OME8g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:e314:0:b0:70e:9e1e:e6ed with SMTP id
 d2e1a72fcca58-70ecea216d6mr30142b3a.2.1722362187070; Tue, 30 Jul 2024
 10:56:27 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:56:25 -0700
In-Reply-To: <a56bc12f6c60107c935db31d7330d28980ac4d5a.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <D345627B0A699F37+20240730024931.1026933-1-wangyuli@uniontech.com> <a56bc12f6c60107c935db31d7330d28980ac4d5a.camel@intel.com>
Message-ID: <ZqkpSX8xfbny7L0e@google.com>
Subject: Re: [PATCH] x86/cpufeatures: SGX: Adjust the error message when BIOS
 does not support SGX
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"wangyuli@uniontech.com" <wangyuli@uniontech.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "xiangzelong@uniontech.com" <xiangzelong@uniontech.com>, 
	"baimingcong@uniontech.com" <baimingcong@uniontech.com>, 
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>, "guanwentao@uniontech.com" <guanwentao@uniontech.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>, "wubo@uniontech.com" <wubo@uniontech.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 30, 2024, Kai Huang wrote:
> On Tue, 2024-07-30 at 10:49 +0800, WangYuli wrote:
> > When SGX is not supported by the BIOS, we still output the error
> > 'SGX disabled by BIOS', which can be confusing since there might not be
> > an SGX-related option in the BIOS settings.
> 
> +linux-sgx list, Jarkko, Haitao.
> 
> This message is only printed when SGX is reported in CPUID but is not
> enabled in the FEAT_CTL MSR.  I can only recall this can happen when the
> BIOS actually provides an option for the user to turn on/off SGX, in
> which case the current message is correct.

FWIW, this could easily happen with a virtual machine, e.g. running an old QEMU
with `-cpu host`.


