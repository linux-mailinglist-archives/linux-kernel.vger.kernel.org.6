Return-Path: <linux-kernel+bounces-196556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB828D5DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BA0B29DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4C679B87;
	Fri, 31 May 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSMZtypF"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3501757F2
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146772; cv=none; b=WOzojkFQrFK1L69CIUMLDB1n7Qhdx47BoLg6cF+iz2qaBb+AFpXr96DubJHSonDL8VUQhoe+MyqV13ZnVZE3ynhoCs2Jw0zQrG7V6aznqJwFEylgPmQVMgvDjfAVjxKUwYB7OC6tzNY/jF3jk7dJ2tE9ffee+ENqXmi3NP+Fq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146772; c=relaxed/simple;
	bh=n043e5aPdAd/fC76DxpQ7PwPIwMDbOjKUBAKXlLMhrU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNVoUvrbq/T4DsS0jIeaL1CsZLc2mcPKlXmUfdA4mWYJPZqwrm0QGYW+CXKc4Ocdf4JEhtwA/BFvyg5catyrGVSIjXGJfngEimm88Pzkd67hsnXRep37SDBZqW4m9dEZovxyQEW7kfTnz/1JFKuExAWRvzOtuKdstl0VQy/Q82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSMZtypF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52965199234so1844847e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717146769; x=1717751569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6ZMuJgM1aDgO1ril1JnfzUqrJFWz+LSUP19WZBqGNc=;
        b=JSMZtypFX8bcEXy7oqy53GjdFQSBgG6TLNWACoHkAE6lgOuAHn6hepopac5End365X
         yEeo7TdyIn7BuJw6StFf+4gtHLHJAUsYHlpb//pj4Kp19GaYTFQcxtRkKoxT7x2CKdeE
         iEpS84cTBLELtQPyevCLfzHHZ1oj2NihFH5xm4ZYJI1dBVPPpygOM+KZe6QdAxDfhJBC
         S/5AEjdphE0dXCIZZZWR1rxVjlg2SlpN1MfRhxxxL7GLc04djvTaoSmxVrIFg+8kBcXB
         GqHX6DvMNVzjVmpa8pHgPDpHGmj3vaeoJr0ESBFHb5emyD0aTO+8V+Jl6DGgldLOh07u
         t6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717146769; x=1717751569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6ZMuJgM1aDgO1ril1JnfzUqrJFWz+LSUP19WZBqGNc=;
        b=lN2vyHgrFqzs5zNXmjJDbdt2fP+KuSuXNg7cly852T4h0F/yKgtFzIEN7I6zKPWaBm
         Ymy6aSGpGwEvu71OWeG786eUVjnNSzygrrwyKnNZeLV/p0b9V3CKz4enNvlDIr5+Kpla
         JK0bE0LlbedB8w/Qu3UfHRBTBqMpoBSskfHODPyHadodx2Bjry9rbL928roqdTNEWitC
         8JmeI23GVMYw1niHFmFTEZARkMIuiWewxpKdi0VvnFGHyzytBwG0plYF66WAqZIXQiEQ
         L7M609YzaH2VVGi7Nc1a7iOWXktkfl3IP8pczSQJkIr8io473yPHOykFd4myy+57btPd
         A1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUtgMfFdNIJqvhEa7hdTryQuo+1JY46eodAXfX+djOUsyilgy7Ho1RwmoyLA9f49yeeDLyM6i7cZLuIZJcQ4EJq6nVTlDFWQyV0odJN
X-Gm-Message-State: AOJu0Yx2hUkTCJiGNUgIhl2GiB6y/8wuyaFgrcAlK1n29mZX9Q5/4gh1
	eHwHDk0lxlnltew/w/hY2/m6IpcWciL1+L8tqDA8mt8Vj+JUQiex
X-Google-Smtp-Source: AGHT+IFU63l+mNBTUO22AXnMzH2w8LowDky00tObDxv/S9Yj6cn06SKwZt89GnylvhKlh4U8CcqWNw==
X-Received: by 2002:ac2:5a4c:0:b0:519:6a93:ed3a with SMTP id 2adb3069b0e04-52b89573bc9mr834468e87.23.1717146768652;
        Fri, 31 May 2024 02:12:48 -0700 (PDT)
Received: from localhost.localdomain (95.59.159.20.dynamic.telecom.kz. [95.59.159.20])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8724fsm261626e87.230.2024.05.31.02.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:12:48 -0700 (PDT)
From: Alexander Kuleshov <kuleshovmail@gmail.com>
X-Google-Original-From: Alexander Kuleshov <alex@localhost.localdomain>
Date: Fri, 31 May 2024 14:12:42 +0500
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com, rick.p.edgecombe@intel.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com, 
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com, 
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, 
	ardb@kernel.org, kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <eihdindv6akbn7oohmious6cany3ezjqflefd74wmkl2nllseu@izczd5vs6vj7>
X-Operating-System: Linux
X-Date: Fri May 31 01:22:55 PM +05 2024
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>

On 30.05.2024 23:36, Ashish Kalra wrote:
>From: Ashish Kalra <ashish.kalra@amd.com>
>+	 * but it is not neccasery for kexec, as there are no boot services in

A typo in necessary

