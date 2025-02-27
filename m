Return-Path: <linux-kernel+bounces-537190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4136A48906
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400B4188B403
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556325F790;
	Thu, 27 Feb 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBJL3SU6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC28BEC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684642; cv=none; b=f6URN2CSx31OWeHd6gN2JzjiBP0ADKLl5866bCfWJN5WRDXdZUTxutvktpQvfhLgqbmqPA3GWFft4wPEJlLeoOuVQS645IFo8Xgu1Nd90Wi9ufklhyapQMeqrCV0+5nYDYKn1MhIS0u0cL0VEfepBxBkI+uGkyFKsJpLI4BNh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684642; c=relaxed/simple;
	bh=8UOZQyyIStF2th0oM905lNc0OKLXsfylKuIzCLeIfU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBJqLarDQO56RLcrzShKPw29nAv/x9x6JPjnnosvhY9UI94G4kfVZXOthwvRWqUWT5ZdH6A7BPZYxiR9k6clCrJuHJFSilGTmSJO6qe+sGvNfCoI506Ux90ZzYQoYlJ+ldIpLMM4o6THpELjWNiRngw1C76RGkFAcp0joQZiHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gBJL3SU6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54843052b67so1327e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740684639; x=1741289439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxUdrSt37LrgTdQsNrS2fDoFyqBqPlpse33rB5xti5s=;
        b=gBJL3SU6EPy/XL3WEPIGdcrX7VzrJgUbKCXs0CiPFMhox61RDM9mDXGklzDcdaj+fB
         IILCltgESrwJH4b0QXmbXETjE7PagbwlzbtJ69s3Z4Du6wx2jr9tkXnQR5DiBLv2ftyB
         cQDuX+hJ2hkFxYF67pGGq39Tc9x1qP892liLABMCAq7hgSf26tdqjNwGKpOVMPsEjQUh
         9iM3PWmfPmgBX/WajJNyf8beYmQxsKDHkqV5qTClwyaqpTnaCByErBYpCeuOCd/yAZ/Q
         HHFzYssyC1V/fHvjqKK6au9JRkYb/VTcKj1UxIRb9qtG/wN749pLtr2NrjaSS+UbDXUm
         aRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684639; x=1741289439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxUdrSt37LrgTdQsNrS2fDoFyqBqPlpse33rB5xti5s=;
        b=IVXb+sJvBbNSWFywZ+FWC+cxH76EYtuPPRZWz0A65h6A9sjeXjcMiL2rqyzlOCQSX7
         4AKgBPf/eRgIR40q2mVSZK6xK+mmA+6QUBTJuvSOwqbz0Wv7Nm4ulHBYa/H3xzipWDps
         HpKpAwB9g2rTiATFmAtfPhiL3NK13l409clgyTPqa28fxxZR9UcxWZ29YifTUPI65pnv
         FJDK4o/Ya/i4K3eJHMoOgbJ/Ai24cc9buwJTfyMF522QWL5o4Eh4ASF2pE1Wg8A2QwJH
         YxJn/Ds/Kgt2ndmDO/56Wjsjd0ZtyJH4lmzNQffYfAED1+Q7xTjtvY9eGxWUcvCon29H
         PyuA==
X-Forwarded-Encrypted: i=1; AJvYcCUJxxKK1TUgfoMzliIRefW4JTbO6dMfs9ZsTQAdWIUz7QqM6Dh3n53vNLeMvHkPo5bijvZMdT+nFbkT8gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlN3d3yVYZyzvyrOv9v6ruiZobPgyX+DVU2eS8Kg/1aKneOtxU
	PzmefQC89aqeOT7fKFcqUDRJBQcpP9TZ9UGR7gnuPsaZaKg8vQjwk++4kDDu9Ptsgj9pmIJK1pO
	Xdun5nOvveQOLyejIdR9Pqxeg548c05H0ZrUM
X-Gm-Gg: ASbGncuNutF9fD+qM4g5Q8G8OjTazF8xDuWo6hvgo3IJh44J8T0CjJwXkKHvyBtx/+G
	6SmHmR+b/hTwsoESXDAnG1TTV1Y+UBLxSZDXmh+9/6KZR6AD/rekXe6TJjQ9hMhPDv5iK4DAm6f
	eQppvvaGDHqfXs4KN8a9XXHqZEviXW5nZgTlz8ZJzZ
X-Google-Smtp-Source: AGHT+IGeAWqnGUQpzKOe+zSYlqhnj7nPf3RxfEHYv8obi8+zQSmDCtjuRvMXctYHZHy0zrx21F7TOUJhLatVjAxZhyM=
X-Received: by 2002:a05:6512:e8c:b0:545:23b0:4247 with SMTP id
 2adb3069b0e04-5494d733e9emr31508e87.2.1740684638497; Thu, 27 Feb 2025
 11:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225004704.603652-3-vannapurve@google.com> <202502272346.iiQ6Dptt-lkp@intel.com>
In-Reply-To: <202502272346.iiQ6Dptt-lkp@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 27 Feb 2025 11:30:26 -0800
X-Gm-Features: AQ5f1JpO7zRYi6DzcSKnE4B4trMunnGetNndbYlpp3x9XD6ERrRXOsIOqVyyKTY
Message-ID: <CAGtprH_+GAVd1UmeCvT-JHq3OCn_3aTqwyjTRWNtLpoJPPfLPQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
To: kernel test robot <lkp@intel.com>
Cc: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com, seanjc@google.com, 
	kai.huang@intel.com, chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, 
	afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 8:25=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Vishal,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on tip/master linus/master v6.14-rc4 next-20250227=
]
> [cannot apply to tip/x86/tdx tip/auto-latest]
> ...
> All errors (new ones prefixed by >>):
>
>    In file included from arch/x86/kernel/process.c:6:
>    In file included from include/linux/mm.h:2224:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> arch/x86/kernel/process.c:937:32: error: use of undeclared identifier =
'tdx_halt'; did you mean 'tdx_init'?
>      937 |                 static_call_update(x86_idle, tdx_halt);
>          |                                              ^~~~~~~~
>          |                                              tdx_init

Will fix this in the next version.

