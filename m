Return-Path: <linux-kernel+bounces-288471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29CA953A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3DEB235BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150E5A7AA;
	Thu, 15 Aug 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Mpth+/mL"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953184205D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748508; cv=none; b=rnRQPipfAANrOToIVDT8+y7XC3xt73nWsxYurDQn5aBDuFtE/n8AYtsHIPAhvNGeLQyFv2BI+/RheHUSNd1VAdrOjNreSMHeIq1V0BDSGlPHR+6yqcXrd7cynf4WJL18GrRQWJXCMwnKajQ1GJ9YaS9DGRZoCTDkqU1Ir6Qpe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748508; c=relaxed/simple;
	bh=Ia56IaP2wCwdztFSxen90kn9phtOnuIPt4qP/ILHOxY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KQpX95yUnFuhGRBD7l9qrBONMEtJT09EG/ckLrowUPAo/o8nwXqywnfauntz4Uur60sa60mp4jQ/F6jTRL+hY6txTfDwNgetGGA961VXfjd10jC/5PykidJAt7uzKyVd6pzbTrmytbh4iXw4rfE0GmRCf14dDd2Sy7KmCmo7XmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=Mpth+/mL; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1e4c75488so76329085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1723748505; x=1724353305; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYoHgaX6Oh7hOJvjP6bYFuodoCT3Q3xdPz+YF6JrpLs=;
        b=Mpth+/mLeUrKJd363gmizhIkMCfuRkYlST56Eyac8PT6rSfGrJTeIlSpw8b3/riV8H
         e7pGdm/3UvdNWMMZ7cAdkLApEK3eyz4+dwjfdYNvODTojXQ9HKt35nBrlVuKGoSpoaWR
         x22uH/pxq9H8NCiUWgABh+xNs9SWq6W6hHuao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748505; x=1724353305;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYoHgaX6Oh7hOJvjP6bYFuodoCT3Q3xdPz+YF6JrpLs=;
        b=fN545avFcLgyq9ernCTtSe1UPqrWT4OP3k3clsQMUwbMhvgHbGPuRbZzqK5b9btQ3B
         Yn9kGtn8IZZT78xVw5/pvLsHRfivHfOQG4BMowMkpzVbsFQsSnnaV1PNXLX+jVwMeIHc
         W8i4AfAeuksiPoKKeeO+mi8CRp1nxhauYnWlQV5pYZ15vWNcuy0BgZ5YL7pX6qU77pwd
         IRQ2uW+BeKJPpUSY2V69gAbLVOXu/gIqC52ovn5mxi/MtEv067ARYuTSEY66PKTcTS3u
         1cUwuVgRZYgTYUeT+jJxw4vENA1R3nrUI1R250SQ15Qx9Usn06908ZeCg18jEYiJeLXv
         qokw==
X-Forwarded-Encrypted: i=1; AJvYcCWacs+0oYMqcg4OqO6T/5NKOArVECWAVn/ONk+gASIEEcUuwGgUPEknpa3mVTEZWRqUNUiPbwOx0IdoCe+WyPchAcGyYHwdixa2345Z
X-Gm-Message-State: AOJu0Yw3QcsG/tx4yI2vvi/bq/S5G4CDz4169yoSLAjQscRckRa8gmp7
	rT5GkQb/OWr4oivEq+QZhC92vEW1Gu3c+HhMbFNpasAC1Bc9At5C3nn7kwmgSA==
X-Google-Smtp-Source: AGHT+IEczJIMuzRH/O6ERN1btYguU3GnudkhPvvJqeqlDMQz09wFIySHt/aagHTo2ffLCUAepQ4Vpw==
X-Received: by 2002:a05:620a:4142:b0:7a1:c3e8:121 with SMTP id af79cd13be357-7a5069ec304mr80655785a.57.1723748505324;
        Thu, 15 Aug 2024 12:01:45 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff1073b4sm88597385a.104.2024.08.15.12.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 12:01:44 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 15 Aug 2024 15:01:42 -0400 (EDT)
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
    peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
    namhyung@kernel.org, mark.rutland@arm.com, 
    alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
    adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com, 
    x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
    Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
In-Reply-To: <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com>
Message-ID: <201991b2-d77a-c10f-d46d-ee9b34ba11e5@maine.edu>
References: <87sev7nom4.ffs@tglx> <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com> <87frr7nd28.ffs@tglx> <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com> <875xs2oh69.ffs@tglx> <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Aug 2024, Liang, Kan wrote:

> I also found a related discussion about 9 years ago.
> https://lore.kernel.org/lkml/alpine.DEB.2.11.1505181343090.32481@vincent-weaver-1.umelst.maine.edu/
> Vince tried the workaround but it seems not work.
> 
> So limiting the min period of the fixed counter 0 to 32 seems the only
> workaround for now.

I'm actually still lurking on this discussion.  My regular fuzzing machine 
is still a Haswell machine (the same one from 9 years ago) and it reliably 
hits this issue within hours.  I hadn't realized there was an official 
reproducer.

If a patch does come out of this I'll be glad to test it.

Vince Weaver
vincent.weaver@maine.edu

