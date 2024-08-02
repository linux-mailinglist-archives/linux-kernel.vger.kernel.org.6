Return-Path: <linux-kernel+bounces-272326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB5945A4C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EFE285D47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57F1C378A;
	Fri,  2 Aug 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l45suVfN"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF21BF30D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588786; cv=none; b=Qjk6Jcp7u8YMj0XDZm3MocSxjwoBRiUDhKo1y8kzutGuk4b9NK6A49pPLcVaM1d+IVcMzKw5G/8P9FbldYYVS28bjSW0sST9do/6z93HkEqq3xuQbNzhCfwKXGtKSYXCmQHQVef4Vn7I1fOHSW+tb0aFTGciPlk8rAmiynwAj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588786; c=relaxed/simple;
	bh=V53uaujRLZfpyTBRkBpMFNLVeGCunbTVciwODkRZgo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSNumyd7InAA2B2uYHqFKDxn7YvKPsQuEFM9uldMBJFtvLokcL/WWEiv4Nl0oO9ScvS42zPDTLBrJ03ScK7GAv/dE1o+rVtPeMJIYW8yZTvs29jp4FV9B59MRlzauqirvB+NMDDIDUTRntwulMLUwrZLlWdCQMuLR3I3N8I1s5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l45suVfN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so4499936a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722588783; x=1723193583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XFkRTNOAvo/6n1TkCxI0Nq/GhsBWYAifvh3B1avP60=;
        b=l45suVfN8YQmMNmyuV1W2g9zEGDmIP39gm9rjVI8SG1PEd5+EkH4JS72Rr+YR+C+p3
         rmpU/XXQ3BZkM7InzecwMVa6FB7PzOv9ZRpemeui4MWSzvqKR9znjmChdsy+oSV0WSUT
         8ZClQISwt+ps4oMMQZ/ClSh1J0NVugkedEqbilE6HSZyGb7ZnqM0t3oUpLSogVHM78oO
         2KV5KcSjn0SgEvhmdhduXwR9YKuic20sqRZPfkFNmPjSeN6G2mpZwK4Ia4VtuUxL2Tw1
         gIIm/3uz0fsCUsSV1Z8PKkWPC5uKlQwcMU955yzAGjX/PkSMZX0Gtusr/pGWD2LMWz1d
         MtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722588783; x=1723193583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XFkRTNOAvo/6n1TkCxI0Nq/GhsBWYAifvh3B1avP60=;
        b=FFCkM5QcmG6LzwOR05Ni2XSR+lIp4jhPK+7ip+85KjKoEKWnRCoZIH02uGtViK3ica
         nAVgIQ9kABaoOr80IHzSnot0Lv7yjHxzNmLe+3gWRkT6SnGBkykDgo/lGhEbD6lYZNJW
         BTU6UBJSG92XFxsxTazAG8qe7dGP10ZihTOTes27Tz0ayBFNyXlCRJSmeGd7tK240+mC
         DDtsR1puL5ZTQLkDIQale0j1QHo9fpuITKARsoTxqSrj1Fgoa1hJE1BFmJc1gZaSji/K
         /kErc6Pu8t8M1CDd2mubfRQEXqcKBAfEy4G7ZWZeKKFn12yoMOhi3J8we8to+K88Z1FR
         uFJA==
X-Forwarded-Encrypted: i=1; AJvYcCU8jgpjrH9IKbyObEhKiiah4atQW5CAsB8uFg4uuTCWFeq1pscFy0VmG/KDL2tDwdmRfDzC/iEMeFTV9oBO6mFxqKYmiRqcgvvo0Qe0
X-Gm-Message-State: AOJu0YxHsSfEoYF3BXwFzUyAueEQHOR0zh7aQYSsAppCGyjCHIth0uQT
	YKuex4Rxhkd4MkfYmhUiDbRzUS4jiv7jMo9Qqm3L5LL2l4CGHa8=
X-Google-Smtp-Source: AGHT+IFJwhpUx7VoS206VbLfNRc/AmbO26vvXS6AcphopWKlowMmiS2F7rsx3JjoggcT9/JHDYDaLg==
X-Received: by 2002:a05:6402:22d7:b0:5b8:34a9:7fe0 with SMTP id 4fb4d7f45d1cf-5b834a98116mr1232930a12.6.1722588782707;
        Fri, 02 Aug 2024 01:53:02 -0700 (PDT)
Received: from p183 ([46.53.254.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839610c77sm833557a12.9.2024.08.02.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:53:02 -0700 (PDT)
Date: Fri, 2 Aug 2024 11:53:00 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] xen, pvh: fix unbootable VMs by inlining memset in
 xen_prepare_pvh
Message-ID: <3fe4502f-020e-46de-976a-b32a76de478a@p183>
References: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>

If this memset() is not inlined than PVH early boot code can call
into KASAN-instrumented memset() which results in unbootable VMs.

Ubuntu's 22.04.4 LTS gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
doesn't inline this memset but inlines __builtin_memset.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/platform/pvh/enlighten.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 8c2d4b8de25d..c2f6e202217c 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -133,7 +133,8 @@ void __init xen_prepare_pvh(void)
 		BUG();
 	}
 
-	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
+	/* This can compile to "call memset" and memset() can be instrumented. */
+	__builtin_memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
 
 	hypervisor_specific_init(xen_guest);
 

