Return-Path: <linux-kernel+bounces-405514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D729C524D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1611F22848
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F5320DD49;
	Tue, 12 Nov 2024 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DN8+v89X"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9B20C01B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404750; cv=none; b=ttF9p7NZ/E5t0/K2kEY0WZSRSL3s6p1f8Vg1+YZRcrJkhrgiPOTp27uFg/o1+15F6rY69GC/w18hqI1bTPyf95FTKzxTZjBD8KgfLVGQ/e71r+vf9dPB/2hviOBkCrIfoZ8l5Q5RB9CBM4QNOEdn2Ps/OS7fNah7wv7K1dY+xZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404750; c=relaxed/simple;
	bh=09KHNAp9aGbScESfnY/4XR2GtwNc3MLVJEmM1GwtUsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLjHVjr6hFzfvN8JcLsn7OVElzMaW5Gc5TC3JAzWKYMoCBAcY/iIMcs7TS1di1dRrlz6DkoV2NCNAg1V2uaQ6OqlMZRheGF90/vUfNFkggT4LOexQZ8Wj8j2zbrX8zU+j6vZ5FLc8ZrJVU6tkYUH71hRGg8XXqkhheAHztmLEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DN8+v89X; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d58a51fa5so16311f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731404747; x=1732009547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux99EXTFhc2LTeBRNUSr8JorPEvhAiRmSDxU9fdyTbA=;
        b=DN8+v89XfnNrp62wlea+wEbafaG212Gv9s6zpPIuFO+xCSI/MduVhvvq0h3XcwH03/
         AFoNohjRwoQZsvOipxYLTZptA+TkSMZmvgF5OdM7DWDjb844YIt8/3NxGp5jFUvpxjOF
         ERpSht8BUm6ZbeRpF5Ys8MlT/Brmgo24ygi7lN2KeJlU+F37CQUa7VyJaWUHvHQO2wb+
         blmFPnVIXuz94uQ6EV+5IPjgueOpA1h3URXL89wGmYd3WXihwFOkMlCyJ18Uzts9D1YK
         ROST5syDrgKxh6mmfg10QKyBt0Y9DIOtOCc7z+lplshIbDqId0LoR8p/qYyM/WHu2cQ3
         Dhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404747; x=1732009547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux99EXTFhc2LTeBRNUSr8JorPEvhAiRmSDxU9fdyTbA=;
        b=VZCyvM8AkvIq02ClN1+cuCuvKkxx94BcWiXbrjBfyl3YLtYu3WIlF5tUfL2ABgHdam
         oRBWSks85rqlf7kjtQ5tEJxAgSOwyMZp9+nsq9J/dtptsdN1ktEUh8Xlw33uj23lP8at
         GmH/XZJlaqgoejyZcU4SHg12BBhNQG4FTMgsyK47CIHHla+ezZME08hA79XDYZFJLikP
         8s+sG7I17ZGD9ad4JidW+/2eF+XJ55z/kKSVCjJTyoJu5Judbd7oobOf6lZSJEqnHQch
         y7z5KsyqkAPRvBbPyhR+CTy332mB17kUVyynnSUFvN13DUkz9S8GNiF0IVs8Ba4q+DmA
         Kc9A==
X-Forwarded-Encrypted: i=1; AJvYcCWVdMk4pAE4EpdClYEwVf88Ite1Zp3XiWQJi1PqCMYFOhOuWInT0Z1cxnqA8nxjNhwMog0fUe2OUjRCsGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hd7slWv+nQGeptdz83Chj3VG7uO9b4EkhvmVAMdhhIbFPTzz
	EsB/yt9lobnlfxYSvw0wc59VXObxoKB7CySC+jzChCDCWCU2Q3dqF22zniOCWlg=
X-Google-Smtp-Source: AGHT+IE/c0J/jTJUjiiSC6K/TBObSdXmRsTIjAJq4ymWFVMBIE5d/rZl+zr7BxDWcRQLISX8yjB3JA==
X-Received: by 2002:a05:6000:1844:b0:37d:468c:1f38 with SMTP id ffacd0b85a97d-381f1854233mr5002237f8f.12.1731404746903;
        Tue, 12 Nov 2024 01:45:46 -0800 (PST)
Received: from mordecai.tesarici.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9719easm15302568f8f.9.2024.11.12.01.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:45:46 -0800 (PST)
Date: Tue, 12 Nov 2024 10:45:44 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241112104544.574dd733@mordecai.tesarici.cz>
In-Reply-To: <046ce0ae-b4d5-4dbd-ad9d-eb8de1bba1b8@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
	<20241111131442.51738a30@mordecai.tesarici.cz>
	<046ce0ae-b4d5-4dbd-ad9d-eb8de1bba1b8@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 12:25:35 +0000
Ryan Roberts <ryan.roberts@arm.com> wrote:

> Hi Petr,
> 
> On 11/11/2024 12:14, Petr Tesarik wrote:
> > Hi Ryan,
> > 
> > On Thu, 17 Oct 2024 13:32:43 +0100
> > Ryan Roberts <ryan.roberts@arm.com> wrote:
>[...]
> > Third, a few micro-benchmarks saw a significant regression.
> > 
> > Most notably, getenv and getenvT2 tests from libMicro were 18% and 20%
> > slower with variable page size. I don't know why, but I'm looking into
> > it. The system() library call was also about 18% slower, but that might
> > be related.  
> 
> OK, ouch. I think there are some things we can try to optimize the
> implementation further. But I'll wait for your analysis before digging myself.

This turned out to be a false positive. The way this microbenchmark was
invoked did not get enough samples, so it was mostly dependent on
whether caches were hot or cold, and the timing on this specific system
with the specific sequence of bencnmarks in the suite happens to favour
my baseline kernel.

After increasing the batch count, I'm getting pretty much the same
performance for 6.11 vanilla and patched kernels:

                        prc thr   usecs/call      samples   errors cnt/samp 
getenv (baseline)         1   1      0.14975           99        0   100000 
getenv (patched)          1   1      0.14981           92        0   100000 

> You probably also saw the conversation with Catalin about the cost vs benefit of
> this series. Performance regressions will all need to be considered in the cost
> column, of course. So understanding the root cause and trying to reduce the
> regression as much as possible will increase chances of getting it accepted
> upstream.

Yes. Now that the biggest number is off the table, I'm going to:

 - look into the dup() slowdown
 - verify whether VMA split/merge operations are indeed slower

Petr T

