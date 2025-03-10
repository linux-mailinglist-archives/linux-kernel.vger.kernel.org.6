Return-Path: <linux-kernel+bounces-554585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ECDA59A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A593A880C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD622DFE5;
	Mon, 10 Mar 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUzdea+k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2C22DFB0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621199; cv=none; b=uEYNmPmvzeCz6ioqso2HYn25toiDKYpyvGHStA11jS8OxoTDdGZsCSBT9fVnXqlwO9rv5hiWlynlS7N8UfNOWDvgxEP413nrXxYP4ps8xyJ4LydxMVqd6A1z2YASvH3YUzuR5zcml+WaQO7MzdFPU14grZlp5f8788NgYnv7szE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621199; c=relaxed/simple;
	bh=UgKyEekB99QTYNP4fJFy3O5FfG+351jcDbaPpf+tBa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMRFRjzscJxCiHVgppv2/OPLf0J6967fuO2dyiHI798b63zeAY4+dPrYbPXk/ow2KwX9OikrDhHflQdlIpjfNuneterdmpqBIpMdJYHYMMAjyfbVDjjCeVRf5LXVLJr2LZgB0b3+GTySvxdNYlZok5Ara9I3l279Son9hUwqlX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUzdea+k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741621196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UgKyEekB99QTYNP4fJFy3O5FfG+351jcDbaPpf+tBa0=;
	b=HUzdea+k2XvkE9S/Kpypm/eOYCJ3+o/33S7Sk3wcdOVXSeweApipfNCI2m/OlB1l5rq7FD
	0bVjBdB2WibxxgF8TMQQxuu0JQahx/5PD38qAmAO0TVbGNUyztUXH17YgNl8klUh9Uo0Li
	DuN9nn0h+lO5uew3aoji/z0yNvkIvgs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-AbeWwQj2N1-ut-WOrM7fEQ-1; Mon, 10 Mar 2025 11:39:55 -0400
X-MC-Unique: AbeWwQj2N1-ut-WOrM7fEQ-1
X-Mimecast-MFC-AGG-ID: AbeWwQj2N1-ut-WOrM7fEQ_1741621194
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5495a1c0be4so2503049e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741621193; x=1742225993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgKyEekB99QTYNP4fJFy3O5FfG+351jcDbaPpf+tBa0=;
        b=lF9Qw5lfELdzfVdkx1Ptk0IKl1RWFgCTJTfrwHk422btMWvq0g+KTqoXDNhjLTgwCE
         mxF+YD+IXnNuLpgyhBpLPZRprg/8+e9w3CBHF8doB69GCTqX01QLLDJBSuCMcJy9f86a
         kYogWoHO43FzWYLrpAK1J8vkk3Kmsz1z9mmEUWTJ1ZQNW3BA4SghTPgftwzvDHtL8SIA
         Hu13ym6MqCVxqFkxdcMeLPqMyWIVZZGtTX4gJZVWsOLp+VPiv9aW4q6M25MJVqt8cORX
         BSdnFehR+9G7dvZ0zMitIkEHxacduyoaGGgtsqwtyk4TLWeDUV6BUoQ4KwxuyExwcqQS
         Xs/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUro0YcwsLW3NFTB6IBebTMD3Cwk7/qYdlR86/kOzb1OGT/dM49lHHqMQCxNJOHwKLYFi6Drm0aSSVJggk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Oj7Oq1+jBKPI2JNramZsOOPoqrybA/DTPqm46nxbLh/VZHT5
	wplKqS5mON2hGCOwdpT2ddVumoiqLFuhWmWqY3MZIzgjv3oxcgOSM0tJqOwmr/KVsRrE4iNjkyS
	Z/o6qYBvNSvtXjm5zn5apuCMWh611C0qav9MQxvKPAxIeq7dgeZ7VUVs6keMNFYkmjRumQXPM8w
	oHkJm8xWJb/3Mi9gFnFiEevyIrPG3xJ7fVaXVk
X-Gm-Gg: ASbGncvfoJRRDXH+4grGiZSSj/1f+2tEiqsjyxnXA4f95QT/lqLjhISsDCxdHEzz5HB
	TD941KYlMKNguBUgiFW4MDz4aJdx/YYppZIeNUi7sjyo42vYAjmFrcyTJjnQCySqKzgn76xWD
X-Received: by 2002:a05:6512:1242:b0:549:905c:c3b9 with SMTP id 2adb3069b0e04-54990e27382mr4079654e87.9.1741621192633;
        Mon, 10 Mar 2025 08:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8r6MosJU6bCJ7fTaIje1/2x6BKstRJc7xapTbeccshOaGXSyueQIe9iWTKagYPOWCFUMq4FUPddHh5u9bO0s=
X-Received: by 2002:a05:6512:1242:b0:549:905c:c3b9 with SMTP id
 2adb3069b0e04-54990e27382mr4079607e87.9.1741621190775; Mon, 10 Mar 2025
 08:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309172215.21777-2-vdronov@redhat.com> <c21c89d29f006945b6be7624599809b36574530e.camel@intel.com>
 <Z86l9WiiP_4bFC8q@gmail.com> <d91942f7782fe1e1f1491de86d60bb14b2d5e781.camel@intel.com>
In-Reply-To: <d91942f7782fe1e1f1491de86d60bb14b2d5e781.camel@intel.com>
From: Vladis Dronov <vdronov@redhat.com>
Date: Mon, 10 Mar 2025 16:39:39 +0100
X-Gm-Features: AQ5f1JppX7aB_ARebLW62l8EsNs6FyfTqyQsbqGxChoyav7O61KfV8THxwKV9Zo
Message-ID: <CAMusb+RJh-xvuFkNJoeVY_28W5_GR0pn+=gw3hLzi4rhdAKaXg@mail.gmail.com>
Subject: Re: [PATCH -v3] x86/sgx: Warn explicitly if X86_FEATURE_SGX_LC is not enabled
To: "Huang, Kai" <kai.huang@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"jarkko@kernel.org" <jarkko@kernel.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, 
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi, Jarkko, Kai,

Thanks a ton for your suggestions and edits!

Hi, Ingo,

Thank you many tons for your help and attention to this small
patch and a TIP submission! I wasn't expecting such an...
immediate response to my small suggestion, honestly.

Best regards,
Vladis


