Return-Path: <linux-kernel+bounces-289072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65189541D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A09287EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E3413A26B;
	Fri, 16 Aug 2024 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EE+Fhk37"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BD12BEBB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790036; cv=none; b=tFJVF4Pd8eOfEdSOHsVosx0ba7eKGMB69wiXed0kHmdq6dvw8vkV9ukV0YHE6DqnaRDNsuWCgd/w5iFsNBj10QKtmajx2KNpwPYljgLTX+3HSZwlbu1rej5316LPrcwJ4y3ElQrAkMNUMRoGUcUVUCftoREDrIiOYp9rr4i7G1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790036; c=relaxed/simple;
	bh=JVc9UuR/SoVeEPYnQlOdpDRPgE2cHF1FrMFCR4A/rnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia1kW96auvmoad2A9XRRxKQzeKaPc6IYShQDH4Kfnzir+3B0x+/5sdgybI/7Sfs8wyrcX9x8VhODgotdjF0B36lFc4J7c16Eelb8oYHu3vMOoTozOqvdOEpHRpfCV7QDfvLNIcvqgYvvz4bnY06Ig62vsDrB4BjjFjz/eiO2VjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EE+Fhk37; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so10939265e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723790032; x=1724394832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru72ythl7RCMGJzB+CaFD1wc8SkQVegXHi4g22TOCfA=;
        b=EE+Fhk37fbNJZT7cJzDl2tMkW1j20v7fztzY/baxhMgnadHhFafagcLFTdM1bkOxP0
         5GuGqKqeOIHQtmCuTSqlQKdCKaltpahCgKM9tAU6vEYl3BJASTaewusD4ZfBsHJMltFu
         /PpvHRCmFj4aO6kG6Ng3AIWnZLge1jR6X+DvcEh+e1zhLy7pae++AmRMbx9/OlMjlCPT
         n2dm+6MnsFiftN1c4rX7pVvUQCKBfWbVKuz+HnHehj8z4d8i97WEA/5tFDohAeMWzWCA
         AygRB9yEu9OA7lfbo0pJAswyqme6QjQ2+VLTGrtsj1RPalrJfHAAaqiYDD8OIgeg8dJa
         hGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723790032; x=1724394832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ru72ythl7RCMGJzB+CaFD1wc8SkQVegXHi4g22TOCfA=;
        b=F3g2XwUEWJHfKnyDt9GRiPNJX8W5/PJ8AH15cgUi3NMXbk/WQ1jFo1LF+ARhrioPIY
         xlw/5y+URYbrR9haXyRhMdSLSMvGrZlxSLkS8TPQd+H6ryH/+aLPvdqpYCJIlfa9F/Xj
         S+5BG+5PYamvnEhEiNeUrYFcZSjtr6n1JZqHNE9tXFzZrvwhthEl6uU2zzilRHxImqu4
         JJNl+85p1Vh0R64759Zvbw8dKPd3YcAa3HAAogDvv+O5GQ1shpy/0twyRa3C8cHERqXq
         5UHe13eWIqxyTBw+FINzlMnUlxy7EiPQP5gMpziDeWJ13asydujMhJpy0iECMlyNBuKl
         2b+w==
X-Forwarded-Encrypted: i=1; AJvYcCXy1Gs9NzkIWkkLDiZ+nYpNs7VakVWC8maRKxO2J+z7ranTyzqxerZTom8eeFamE9E6AA2f20RClinulr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGPHbByiv5him6+j6eAp9NnL2qHolmpbed9+7VIOkRifdp//E
	AvK2Zme1+tT5Xy5GOYCQ6BmJ5wcuq8CAPol9+2l8JEiiuV1Vac7FhxyoFqXPj4I=
X-Google-Smtp-Source: AGHT+IHMr4FewiaDTQWL/NtTZPjZsJdIOHrGXpi4AtwWkG+BIijKhi2MlUkSB3mA+WUfVsgpu7V6Bw==
X-Received: by 2002:adf:ef46:0:b0:363:7bbf:efcc with SMTP id ffacd0b85a97d-371946d6b09mr1188194f8f.62.1723790031461;
        Thu, 15 Aug 2024 23:33:51 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a047sm2933367f8f.11.2024.08.15.23.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 23:33:51 -0700 (PDT)
Date: Fri, 16 Aug 2024 08:33:49 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Baoquan He <bhe@redhat.com>
Cc: Petr Tesarik <petr.tesarik@suse.com>, Eric Biederman
 <ebiederm@xmission.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Hari
 Bathini <hbathini@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>,
 "open list:KEXEC" <kexec@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <20240816083349.3fd6f1c1@mordecai.tesarici.cz>
In-Reply-To: <ZrFZM4W7S89VpfaG@MiWiFi-R3L-srv>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
	<ZrFZM4W7S89VpfaG@MiWiFi-R3L-srv>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 06:59:35 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 08/05/24 at 05:07pm, Petr Tesarik wrote:
> > From: Petr Tesarik <ptesarik@suse.com>
> > 
> > Fix the condition to exclude the elfcorehdr segment from the SHA digest
> > calculation.
> > 
> > The j iterator is an index into the output sha_regions[] array, not into
> > the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> > all subsequent segments are excluded. Besides, if the purgatory segment
> > precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> > the calculation.  
> 
> Indeed, good catch.
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Thank you, Baoquan.

Who should apply the fix now? How can it be merged into Linus tree?

Petr T

> > 
> > Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> > Cc: stable@kernel.org
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  kernel/kexec_file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 3d64290d24c9..3eedb8c226ad 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
> >  
> >  #ifdef CONFIG_CRASH_HOTPLUG
> >  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> > -		if (j == image->elfcorehdr_index)
> > +		if (i == image->elfcorehdr_index)
> >  			continue;
> >  #endif
> >  
> > -- 
> > 2.45.2
> >   
> 


