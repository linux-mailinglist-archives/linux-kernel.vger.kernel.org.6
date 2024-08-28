Return-Path: <linux-kernel+bounces-305146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E638962A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601981C24032
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBDE18C91A;
	Wed, 28 Aug 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mn+PEqI7"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E53188CC8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855305; cv=none; b=HfbDCzwdlsgKEXfuuhOFvnAMlvDruZ/Nq+C2YeCdXbZHhAyxgtSpqAyY0i75dm+2IEk5OUAhc1NbGUenkigNKhIq1Ol/NuYacxgEMM98ajyQOH+R91rjGQiWtlE/ald0xP8KhOTMTtFVjUXMXTfWo1FsQornlsyKphpI44x/f6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855305; c=relaxed/simple;
	bh=IqCHzZOe2MefKqf1QB3jOGgwTrRJJ43Amw8xlR1fSCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLL6k4AZ0tJEiGi4tvXSlgEsd/1rWS+p3cyiXB/AbvkHW31YqjojwoISx3TlhTtXCVujS947MrGBfAuM/CIMzsUiIpiHqUFJM6xJ6w+kkd8LjWFvN1tE5qugFKR+Cg50KaK7W37tNgmOREDLioCtqw1ctdKAtmluM2NyOWTE+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mn+PEqI7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371b098e699so5562238f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724855301; x=1725460101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wi8HafCTKyKeL7eno3kK3ziDMFF0EjcyEtRLeesAbgc=;
        b=Mn+PEqI74NFjE3cJJi4GoQkDPZBDiNeQFNIV/Usp4ycbZEi7YUQrZwYSyOWKJkYQtE
         5X2RSQAfHMyFUGq47iy8GpFEUsszlKF4LwRIbtLFsvTb7s5Fkgva+CcxcVinKy08qATZ
         ZBin8IAdWWmLB083NOkDBrgRyICsX65LYcQTWM9tCDHihKNMDxNJB773MrXYfUhnttN4
         Nz3wxXHBD4QjBgi2A4/lNaNA44e9boonawSxyI5WqQe/5qL53BTOG9UpWdsOZa9t+XFR
         2BXSZxrkTZ7u3n76ImiNSp6J8JtJwgCVLtUbZGY8VFesFCo7D3mqoxa7FtRl97awy/oI
         kfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724855301; x=1725460101;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi8HafCTKyKeL7eno3kK3ziDMFF0EjcyEtRLeesAbgc=;
        b=K20bAk+2tqbcHhr8vAyC9XMKKndv3dsVJT4hnBGdMa9jyoQHeUWPwAHxB1cnMakX/k
         dJ//6vkVGpwrxOed3ymQEYAxa0Vau1eJ+O/WVWOARt7fIh+ivoPReGfwnYAWqG9NWanZ
         EfZXkfwxyGS4VVGxQc1qbu29P0DFb8GSuZiDJzgWpYQfm0OeJIEDw8MiRoD5LahQMzA1
         U8mq4tNJYRdyiOsnyC8T7jJ3yTrocgxluOTmzkUGRqzW65ofwlSSZh1AB3WAHPLgepqr
         zhRJDzomZCNfcguxf1VRI34hWusTilBxz4WZbE9qkmDkE1MoBvGSGFUppOLuPlckhgID
         k7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS7dmQidIsuC0i7jhYbOyzb4NgNeb6+UYXK10/wF9XSJWl7sC/Xw6sRtharx+Awcc2ualM6u+N+FpYCcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2KIP2ck+ShXU6VugIarOAa7r1uMpMS2ZB3qYXdOYgysOavea
	sVTkQPU0q3HbxW6LnECLbNHfAsSZvBFIEgVYbY72DP+/dVp2ZhQft64DInurgCw=
X-Google-Smtp-Source: AGHT+IEu7+LqB/pIxxiTDjSXFhGZ5Uc89Xd+FMOCVfwIMBD9B6VLwoTWWqYC4EhfY9FURWCBWOpHMw==
X-Received: by 2002:adf:f001:0:b0:371:7c68:7cd7 with SMTP id ffacd0b85a97d-373118e33d2mr12898139f8f.56.1724855300934;
        Wed, 28 Aug 2024 07:28:20 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-46.ip.btc-net.bg. [212.5.158.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e548624asm250836966b.42.2024.08.28.07.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:28:20 -0700 (PDT)
Message-ID: <015695ef-d05e-4efc-8bba-03d4251db80c@suse.com>
Date: Wed, 28 Aug 2024 17:28:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 1/4] x86/tdx: Introduce wrappers to read and write TD
 metadata
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Kai Huang <kai.huang@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 stable@vger.kernel.org
References: <20240828093505.2359947-1-kirill.shutemov@linux.intel.com>
 <20240828093505.2359947-2-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240828093505.2359947-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.08.24 г. 12:35 ч., Kirill A. Shutemov wrote:
> The TDG_VM_WR TDCALL is used to ask the TDX module to change some
> TD-specific VM configuration. There is currently only one user in the
> kernel of this TDCALL leaf.  More will be added shortly.
> 
> Refactor to make way for more users of TDG_VM_WR who will need to modify
> other TD configuration values.
> 
> Add a wrapper for the TDG_VM_RD TDCALL that requests TD-specific
> metadata from the TDX module. There are currently no users for
> TDG_VM_RD. Mark it as __maybe_unused until the first user appears.
> 
> This is preparation for enumeration and enabling optional TD features.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

