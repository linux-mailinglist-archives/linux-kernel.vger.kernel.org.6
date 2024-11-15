Return-Path: <linux-kernel+bounces-411170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF329CF413
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C42885AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF31E0E18;
	Fri, 15 Nov 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ+qLnG6"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5A2D05D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695874; cv=none; b=L0pBmUFQHTCJ44KkHX5U2dLEtghbpCOxOJc5dp4WWVv0AoUP0BdY2zAhibBL8bcVAnkaJ62s6ijpdKYpKcQG3M0dOogsky84Pe4R0JZwHIwI2Mn13CcpyTEwaBEukw6NOeNA7ilB24FMQDGbUACPwkSoH+Nz2UtJ2bCLp9XQlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695874; c=relaxed/simple;
	bh=a0HPD7rsTd4JTVqFNRDTli6sWFw6E9ipR8rTVZJcp6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmK9cPjaajKl+AGmiy1RHgKWE8V/cbAzgutJYwDNiGlGTPfuQdAsRQQjH4UBGcJjpIQk/M87Y35gneTpUao59fyLQsJikWwuQcj8NGBao80InN+0gu63RLgc4GbYCw2e8eGNHJh2Ylv5J9rhfWk2xbCb3EC9pcUouw+8lTDtZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ+qLnG6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7242f559a9fso2145281b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731695873; x=1732300673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WYFSVywj894w5q/JXzNWBigIyrs+7cqmIeU/W3OrWA=;
        b=BQ+qLnG6Vo4juDf12XM+IbvQKWIIhb3LTNT1+Isa5V8TpYRb2l9nfaN/T0Ryod8ghx
         2+IDXsUSv2u+wY32y1+MIhqmMiKuUjJKMwCwkN0gDegnPWLdUmKK7UTfH8K5LyCDuzxf
         FmKuGEMj37gG45hGBgukJFkI+xpKu1KXutBUdIbfki15E9sJPDwnA6OHDf6sxjEcpj9U
         d0IC79NnhMso7pOv3Sy2St+xqAs9Bpk8jzw3/+YDV6CfVxVMgCjOQ6noaFxzyNVU+xOM
         TQkEYYzGV6fvcb0L9doK2kMBzTg4X+UTdPrcRsMPFarYqMfO3TATUKaY1CNhCIOF7Hts
         tl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731695873; x=1732300673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WYFSVywj894w5q/JXzNWBigIyrs+7cqmIeU/W3OrWA=;
        b=JYPWQNqn4JNy0j/tRunYKnE+Cxq0rK4/LFlc5lIg+pBSuHL6hf9Otl1x5ixjq5+ng5
         tC+qYNcu3pWd+aZwyQKiApIlvtYABhlf6prtapQt+8JYQJFWdHhs0BT11/RvaLFoNQFs
         rEjlLgmTZqZ0BGvtKuQ8l1i9nSJhDXdMT8LwFaQ5B7cUS6mKvow15Mh+fWKDSw6dJtKC
         zarsua/moQVqqb0+8qfBbqTbtrSGcuP8QnbmMhQNI7lDKNtbZzh4Ndf/qv+1GwgdmEZo
         IPsHzvCSsJU+3d2x1cmNuMqJyZ63wISnihVkukLT7nQsFv+a3pwLgLwrSwz8019dUyL5
         PZrg==
X-Forwarded-Encrypted: i=1; AJvYcCWyKdmcdLvnaLn00/dxov4Pc+rvF5kR6OrgSIa4me6kSh+Jj9n1l7zENY6TWU7/VDoj12h1yhoSGww26Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoKR7Uwun+IIJxFVhkm0rcykDm74s4OcbFWqnn4YFend0N2Wc
	geywE/hmsmre/kOvWhV0cdSDjxsR4CxyarFGfdsNu47VsLQqd36l
X-Google-Smtp-Source: AGHT+IEwQ071gMmvnwbGKdJNR3gzXlvAFOJ/kNtsXgJ5otwTcUN0dbSVYANaQh7zPncQtlNt/fl3tg==
X-Received: by 2002:a05:6a00:4fc8:b0:71e:5e04:be9b with SMTP id d2e1a72fcca58-72476bb89b3mr3739572b3a.12.1731695872630;
        Fri, 15 Nov 2024 10:37:52 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e201fsm1678246b3a.151.2024.11.15.10.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 10:37:52 -0800 (PST)
Date: Fri, 15 Nov 2024 10:37:48 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, thomas.lendacky@amd.com,
	ardb@kernel.org, ashish.kalra@amd.com, tzimmermann@suse.de,
	bhelgaas@google.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Message-ID: <ZzeU_OXCAzMSOU1G@desktop>
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzcp75p3KTFRfW5O@gmail.com>

On Fri, Nov 15, 2024 at 12:01:03PM +0100, Ingo Molnar wrote:
> 
> * Ragavendra <ragavendra.bn@gmail.com> wrote:
> 
> > Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
> > it was not initialized.
> > 
> > Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> 
> This 'Fixes' tag looks bogus.
> 
> Thanks,
> 
> 	Ingo
Please feel free to suggest the valid tag as the file was renamed and I am not able to fetch the correct commit id.
git log --oneline arch/x86/coco/sev/shared.c
f50cd034d24d (HEAD -> 1594023) arch:x86:coco:sev: Initialize ctxt variable
2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc

--
Thanks,
Ragavendra

