Return-Path: <linux-kernel+bounces-181486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA08C7CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3831C1C20E50
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307A156F36;
	Thu, 16 May 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TaacrotE"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46570156F29
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885706; cv=none; b=Lk68FrJ5HZq3CFn/r9sPWlqrztfdGzkHHxjviXXqpw3pNn1hp5efnQTF6ENAVRzdtEw/90bbDv+CXmBVl/nb5T1aTNmn943Uv8nr/JIsk/9iRq1eQ45S9/+d5NRkdCT0WdjoPcxZQKBZKGGJMtQMC2aIJGnKGq1pvFYubBuRKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885706; c=relaxed/simple;
	bh=cn+rbKU4Nj4tQx9dF4d/u1kehcthPaTDE6iwoDSE9v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4cuuZE1nQ+VicuV8vOVxqSMXeHF7vKpJ3LRSl8ijFtwGa+aI03Wg117EaTPUs28dWGpZGHOgTFh8oIV8ZOC8Y3dDTZOlTYIXh3joD3nZYhQCOQ39cNNjgoNKROvtLZ9xcOKGE11gpqYsOraw8fJmiqQB0zAyhcr4Ei4nslAklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TaacrotE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f472d550cbso523120b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715885703; x=1716490503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLvVPaGthcsDeYUgK994Dv4j8E5kvcQxmFSF+94OK3U=;
        b=TaacrotE3yRI2+W1PfJbx76HN2QVcQn1ZSQgnd+TV0/v6LMASLZ02GHbeFlOsMGW5V
         /gYhFcWsXOrqPQSBoN7tt59QmZ0pFfI4jJ9DOBuDdBJW12227KcqAv9fg9jmtwJpDick
         ftLD+Eyhbb+P6eROO593YJlnLhDJfqoXCFwzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885703; x=1716490503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLvVPaGthcsDeYUgK994Dv4j8E5kvcQxmFSF+94OK3U=;
        b=OaQ482zX647P3NO8dRfpdKV13QWk3xaH+5pu4Z0LEVpfebfz2vL4yhTXLBts5F2Obx
         UtAk4yw3MsppBWnRxiK8sodEteP3N5qseUAP3Nslh0Zx1Spvi5a79/GynzezzzVfzSH6
         jcWFmha0ac/yNhPKk4IxlFXY3yLJgdg5pT6kVNSc5rzWyaVTvIk084r+4lJxlobgEoIs
         pM5MJLy4miNhzR3ibwypvaG+HuQvoibywilsFajJHY4WODntSuSJVziYGcDLJO4ILL4k
         fQ69fpIb4MhZ6I/LTZhg0LAtrBDDHn+AU6YhpSKHexdKDmT++Z3iRw+kIAqjgbz/PQIz
         nlMg==
X-Forwarded-Encrypted: i=1; AJvYcCW5mqzp3KXd6b2udSf8mLlnoDUO5X2K2TB2yi8Fstmol4NRh5ymFeWVxjNoh91M7LgfcDHtyCZGTt2jNcGi0dol9dDhzeEoGc3752bu
X-Gm-Message-State: AOJu0YzTvEQ935HimhVFYej3x8tRfxwBWF3DgZjc6h1Vm8r2Sojp53bh
	PMpWHDgbM7Tc2jYvCn0NXl2R/tz7MwyGmw4tUfVsP+6schMK1P8jngWnbDS2fA==
X-Google-Smtp-Source: AGHT+IEpt9Uv771YwNLuJA9hxBAARhf3uGQBrVyf9F01Epq/h6k/cCwGA6ef+W8TDQy63/KEqTvc+w==
X-Received: by 2002:a05:6a00:1916:b0:6ea:9252:435 with SMTP id d2e1a72fcca58-6f4e038539cmr30136708b3a.30.1715885703535;
        Thu, 16 May 2024 11:55:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b060f9sm13399031b3a.182.2024.05.16.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 11:55:02 -0700 (PDT)
Date: Thu, 16 May 2024 11:55:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ben Chaney <bchaney@akamai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/efistub: Omit physical KASLR when memory
 reservations exist
Message-ID: <202405161154.01864575AD@keescook>
References: <20240516090541.4164270-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516090541.4164270-2-ardb+git@google.com>

On Thu, May 16, 2024 at 11:05:42AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The legacy decompressor has elaborate logic to ensure that the
> randomized physical placement of the decompressed kernel image does not
> conflict with any memory reservations, including ones specified on the
> command line using mem=, memmap=, efi_fake_mem= or hugepages=, which are
> taken into account by the kernel proper at a later stage.
> 
> When booting in EFI mode, it is the firmware's job to ensure that the
> chosen range does not conflict with any memory reservations that it
> knows about, and this is trivially achieved by using the firmware's
> memory allocation APIs.
> 
> That leaves reservations specified on the command line, though, which
> the firmware knows nothing about, as these regions have no other special
> significance to the platform. Since commit
> 
>   a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
> 
> these reservations are not taken into account when randomizing the
> physical placement, which may result in conflicts where the memory
> cannot be reserved by the kernel proper because its own executable image
> resides there.
> 
> To avoid having to duplicate or reuse the existing complicated logic,
> disable physical KASLR entirely when such overrides are specified. These
> are mostly diagnostic tools or niche features, and physical KASLR (as
> opposed to virtual KASLR, which is much more important as it affects the
> memory addresses observed by code executing in the kernel) is something
> we can live without.
> 
> Closes: https://lkml.kernel.org/r/FA5F6719-8824-4B04-803E-82990E65E627%40akamai.com
> Reported-by: Ben Chaney <bchaney@akamai.com>
> Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
> Cc: <stable@vger.kernel.org> # v6.1+
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Yup, all good by me:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

