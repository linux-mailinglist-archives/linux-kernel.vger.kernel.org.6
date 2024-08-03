Return-Path: <linux-kernel+bounces-273528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D377946A45
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38820281EBC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2E14F9DB;
	Sat,  3 Aug 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3S3ZJ+I"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550561EA73
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697908; cv=none; b=ErlQOY/qDr4OIQYPXY1+JxIVUmpAahgZlp7sF/ceZFNlqRX4dVfaJ5s2eSTyCBqFxF/SzjBT7YF/J8sph3XwE0bQmhWrJ2vD8AbVMfSfedy5J+y+8UJ8P+nETrSNZ9NcSLIstbH2OaDYQAfv2qTfXeJ1wfUPRbU842mEn9pAmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697908; c=relaxed/simple;
	bh=TD5p0UpAlZgZjqGGYGGHskVJVNzetmUKvAuFq0qNFLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KojPsNtxndo3jkXxn/6nfWSexVHDlEf8+QLvk83Aa0gBJSQl9i+WYZuz3PNvnrsDhI0rMPKcmiMgQ2rJ6AkvpitInf2QMqHB7ckQHqV8HvPl2Ash4qEW3XX/P4Qqhb1zG/SkH4YDndEIbe3sD0I/+6F7ywgAp4gZgudy3QtsHAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3S3ZJ+I; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f04c29588so14915436e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722697905; x=1723302705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IIRdmIyZahXOLCwdMsyEmaV+E/1pXlkbU2kWHPbdoFE=;
        b=n3S3ZJ+IScHnWz+c5ncTX996I36Rxg99QI26hEZ2w25TxaksTycGq2HpqAecDslFhF
         IH5+WEQvm60dL+d0llfh6aaQRPc/h9HVmrefq1sDV9yBHCxaArRNfz0AD/ZQKpMK9bFR
         YcuSs++erdZgPlsf0st0aIq47S2pKMHa1qQF6s+tXMYGyPzkuDZ1rcErM+B67Wrrya5r
         kvGO9nROOoCpRZRyi5TPt9am+YUO3eL+ysHu0VwjIcbzS1F9umA/D+YmV6BtOkNeH9V0
         OUHt2XEd6ixhdbjBcPI4LGWp9myj8zXIaUXISzW12f2YN2hMmAOknlGs5aSX40tEEKjU
         n+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722697905; x=1723302705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIRdmIyZahXOLCwdMsyEmaV+E/1pXlkbU2kWHPbdoFE=;
        b=ONAYl3djd+ZFfzxYFKZXpqwXEyhN95SrM4EsTvjL9pwzuXU08aT9nu9t0+j4Mfopze
         rpOVl3dvCsSinAZSr1dQRdUJ4R7dSCS73UaTAJyT+rf1Chs8yuXg5wlt9r360ZGV+EiG
         8b8IJVOCr1OEFWD/ca7aRoR02n1VpJlr+UOM6prQYG+Pdl/lrkC+vIwcWOThd7NirE44
         o4r7vecT6VnUHWTOtsrZS0c7Os61yyivMh+L8L+1XdvEKN91d+KYbmPsRCq5E1AYHM00
         yfH1oC1CVUle3Y2oCZCro1SdnyvKQS8UzhdVngMrd3o6ST9OzaABe5+OA99IOeZuifbH
         LSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIosPKECqPSo+Nj5ohboP6MacXV+/uEbZAvBeEKeZDAvO52IlfhfEnETp7Zow+elPU5YQYsbjinK2SH763irSV+Fs2o6LqcOscBEMY
X-Gm-Message-State: AOJu0Yx68NekB6KX4eFNWO8BT1G5MYzHOa/aU1y/Cs65YW1+7miwpV9I
	Ldp2Ri9FYY46sCJOXEuqLIyBr6jF3S4WXpBiGaS8eriLxt99Y/srIHNDr3OPPXTyaPPgL2NLGlk
	NWw==
X-Google-Smtp-Source: AGHT+IErJzElqSBk+MCrcqXa5hP5NyMDUvJDijFMOCBT7gp3eyLUio6Kgsdrt8DW1sGkx9pBBU+SDg==
X-Received: by 2002:a05:6512:1110:b0:52e:f99e:5dd1 with SMTP id 2adb3069b0e04-530bb4d7879mr4049412e87.47.1722697905161;
        Sat, 03 Aug 2024 08:11:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:521e:7b8e:2bc4:adde])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba0787bsm526036e87.7.2024.08.03.08.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 08:11:44 -0700 (PDT)
Date: Sat, 3 Aug 2024 17:11:40 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zq5IrJgjTJOW92gE@google.com>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqlDuIj_nMVXhYou@x1>

On Tue, Jul 30, 2024 at 04:49:12PM -0300, Arnaldo Carvalho de Melo wrote:
>> I'm testing this again, I thought Ian or Namhyung had made comments on
>> previous versions of this patchset, no?

Yes, and I believe they have been addressed.

> Unfortunately it clashed with recent patches in the capstone related
> codebase, IIRC Athira's for powerpc data-type profiling.
> 
> Please take a look at what is in tmp.perf-tools-next at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

I'll have a look and see if I can do a rebase.

/* Steinar */

