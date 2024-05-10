Return-Path: <linux-kernel+bounces-175425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103518C1F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D83AB21AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFFA15F3FA;
	Fri, 10 May 2024 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cMoa0j8g"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D5131192
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328584; cv=none; b=bIlvzLd7C7NzvsvQlKB9nicpR7x+SzKN5e/CJz2vcGc62q2ejo2zIL4QpZXhGANzStRY5Nmt/m5+0N50zNVpWFtRRHULccBLci0rpYgPRi7bdJ8ArFW/Os2tQ/yiGYHkz8vFOcz3odwJEjgdOSFy6Z3IKJBib4a44X1fwVgmcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328584; c=relaxed/simple;
	bh=Q6AprIm+FPvsG5tK9fG9ayU03oaAZouIa8QaOGqizCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1PE/TXyZtz+cwCmYCtKEJu5cTbRyf3tvzcZ3z8a7sqBQG9byL/yHQtn67PCegbRygINGCq+gTKA1x54nWRSXujRHH1e98/3B4CbBjf3rwcXXFJYmtcvLVa7bLLf5T1v1z1utfZv6xMR+J2NXQanRncFsKf7eTPE7oevBo+2Ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cMoa0j8g; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ffff16400so2897047e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715328580; x=1715933380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOA3rf3iEwXBosJZswL8rY8kkufkCURmYw7VrB7WzZY=;
        b=cMoa0j8gyzAjZBGQzG5lQtX5hI302Kxxdtlq0rEhI3XtUVmITqJmLEWFFfk2bBlQ4g
         K0E84vCQo2pwuZ/tM8vbjz+lMOQcauIHc511Tm/zW20ZBgjiecZTVR0rBCoyPX5bEM0P
         2LsvKFsdibm+cKpMjfjFCbCqFptLIbG65tMCtmpMutHACTUqDOtwagm4aEONmXG9eRA6
         NZxzcvNNILYMI+osXfFW7fU01TiexDiE1BAVVMB3ASEa9PMWdb9iZax8t/W5P5q9xbnx
         IOFIu7QjaX/sGHTWDK5ytexPrOltx5ROnFJMsDh3XH7Oavee0HIQWrTqRMIqmrql/yI3
         JulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715328580; x=1715933380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOA3rf3iEwXBosJZswL8rY8kkufkCURmYw7VrB7WzZY=;
        b=nTr5GRvWS5BPdv5+QHD9hoDBgx504IjbH+zyx/zIS17McADIjpT2lAlwumy53Ys4aW
         AHyd1ox6sauG/En4hfp1ygF6zG8QRPbxs3aBYsTUnpMh6/IcPV3jDsiDRrASsikStuQT
         aSBqYnlKQAS0U5UelRGiHSfZcUmElJ9fI6R7zzezYXe4vdJgrXUt33lnKK6AKs6Kg9Au
         185CjxPR3avqPX9MLG78eAMo7QozAcI9otyKRyJjMP3U2NcUmWVBMQulNzStCNZwW/AN
         2jU9Rv+7SQlc7DTgudUd71sng3kOWSA6gOKZk3Z4uxlwJIf7B4w/8wnCMVHDSrhUd21T
         MFLA==
X-Forwarded-Encrypted: i=1; AJvYcCUsGNsFqikHcAqv0a1aMr047a4sF+PqAtorxBfZa/QUuvwrox3XLFkH70kBk33N6+RSqBXhXCM3ZpOvn+3wQ0WAUOi433y+ZZa2Dr1m
X-Gm-Message-State: AOJu0YwC6y5b++DtZvUsf13LvhrRIY/BbpEhkvpjqywoqtgPQfVAWWd0
	pps5i/GgF/4YyRkKPElFgO4CfgbZgqD0zA353A6Bw6OWikQiMR+Z8gycQjnvUIA=
X-Google-Smtp-Source: AGHT+IHtDaPtq3+zWdvt/+QCSVMqgZzNN1SJ3jMP1mQYF2RqhDLEuqTWeGEoaIonyooUIL8R+/1DAg==
X-Received: by 2002:a05:6512:3f20:b0:51d:4383:9e59 with SMTP id 2adb3069b0e04-5220f86c902mr1439410e87.0.1715328579679;
        Fri, 10 May 2024 01:09:39 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7dd4sm156394666b.139.2024.05.10.01.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 01:09:39 -0700 (PDT)
Message-ID: <817f6c43-101e-4e9c-9ab7-f99c960d3499@suse.com>
Date: Fri, 10 May 2024 10:09:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] xen: sync elfnote.h from xen tree
To: Jason Andryuk <jason.andryuk@amd.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20240410194850.39994-1-jason.andryuk@amd.com>
 <20240410194850.39994-2-jason.andryuk@amd.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240410194850.39994-2-jason.andryuk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.04.24 21:48, Jason Andryuk wrote:
> Sync Xen's elfnote.h header from xen.git to pull in the
> XEN_ELFNOTE_PHYS32_RELOC define.
> 
> xen commit dfc9fab00378 ("x86/PVH: Support relocatable dom0 kernels")
> 
> This is a copy except for the removal of the emacs editor config at the
> end of the file.
> 
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


