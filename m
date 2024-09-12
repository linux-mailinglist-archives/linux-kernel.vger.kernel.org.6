Return-Path: <linux-kernel+bounces-327019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54910976FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9168B24393
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACD1BF7FC;
	Thu, 12 Sep 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyJ9+rTU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57923187340
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163955; cv=none; b=RLCAKr/GrsSyxF9RsKyT/gmutAxcq9tsi2tNL8o8z6+qe94itrvBYdE9IV5qpZaVS9lRa6dBI7Cb1DbViQAEsrKBdii1yaZDMoZQzFPN58R9U0XHSraMB7z7tStXeYi/seAISVGpBsABTKMd7h6SfxQlq+OURugv9pR7pO82PoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163955; c=relaxed/simple;
	bh=x7Slkk4UTVEhNOG7KY9whc2LQASGeUJWYs/+SpGCYuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/t9KrOX6ae3nffxI7Nz0yaRxRXmZlsyIjnrpORZ7GPRNTe8H84gmbm0RyxfuqsRzr147y2DYx4aKeScMXz9zrZ/RHvqBRoVxBAwubiDNBkJoSoLeIiKwMANlhdr8t+ijrQfWSShEDeNgjYppvbeJ2FxNghtjlATYy8iwI5n7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyJ9+rTU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726163953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q99gZYa7eGcgFNqfCTuKT2bHaiWalO32/+jaTz1Ui94=;
	b=MyJ9+rTU8Cv6RBYWCZNqmoF3itBJZIaqSIFhU9HvcXlnpoWTka/AzfU5XicwBylRZc5L2F
	lcW2y7dsJk0xSrYcCPlOqFsIXieRUtqf/uHpnwa1qkvT1WCQMS0M8+5cyFur13W0pqIcOY
	FuK95JXOCUfVrP2Ps2Rs0JFc/pyzsLs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-0X-FSQkUO5-ZsVZWo6eeAg-1; Thu, 12 Sep 2024 13:59:12 -0400
X-MC-Unique: 0X-FSQkUO5-ZsVZWo6eeAg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a99d13f086so11425385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726163951; x=1726768751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q99gZYa7eGcgFNqfCTuKT2bHaiWalO32/+jaTz1Ui94=;
        b=KpR/6hAdZwOg75TNSNkCbTyR096ynSzy5uZPz7nnpYpEtXAYEzxCAceKD5QfSflLAi
         pJdwLSgvNDgebjolBFN8k4FNHoD0m9adH1iNeC70zcfe9XqVCl1jBL5NJG0oqCe8igWY
         ycKjRqA/xh2MD++MeuA85V1VkZY10B5yApRgNM3f7UsIte4Sf4uLTmEOy10Vpwlo6uS1
         6qcLuZLy+mP7aRl5v43bwq42SMQjk4Ap+/18iSq7b6DxWWAVpxTwlpq3wfyxEdELEsNY
         A7bzR/TCuFpHB9Y3IeV02flxoyaWfjyLAaTm4rTUcrk2Rz8iHZ/tt+ncfpAZn/5wBhE5
         Rk/g==
X-Forwarded-Encrypted: i=1; AJvYcCXDHfAyVPPDNNFaYeqMd/RU4dxpcp4UmMgJaqAVFu0pjPHR+I2ooDa5gQz5OE5qjI/7AeNqH6L/HyajGO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5AgwIyyD/3NzIiQxijgD1p2VTIdK09iMj7f3yLwmKzSbGAk4N
	5Gen5waaIDVE72g+lvkxsrXetqpvAa+jYSit4mV4lGH7IrVskzL7rXPlSPqCaCYNuv+3rbaPUT+
	l/dO4m4eFWMbX34vymKlNs617UMC4VOIIMlhcdAQiIxP7z+1iwt2FF/jLwMUdcQ==
X-Received: by 2002:a05:620a:170f:b0:7a9:b2dc:99a6 with SMTP id af79cd13be357-7ab30d18060mr12254285a.24.1726163951659;
        Thu, 12 Sep 2024 10:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuEm6eD0gm/9ouhc+EilxD/EAFO2XKFNasZ+lNN/4rvlaq3VMrgwZ0blUByTUSVbvCH/3FUA==
X-Received: by 2002:a05:620a:170f:b0:7a9:b2dc:99a6 with SMTP id af79cd13be357-7ab30d18060mr12251685a.24.1726163951220;
        Thu, 12 Sep 2024 10:59:11 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e61afbsm55554371cf.18.2024.09.12.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:59:10 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:59:08 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 1/1] pm:cpupower: Add error warning when SWIG is not
 installed
Message-ID: <ZuMr7DcmFqdkp9kx@rhfedora>
References: <20240906130010.93773-1-jwyatt@redhat.com>
 <29d23b0c-02ca-4087-b96b-c24767f64323@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d23b0c-02ca-4087-b96b-c24767f64323@linuxfoundation.org>

On Fri, Sep 06, 2024 at 11:02:35AM -0600, Shuah Khan wrote:
> On 9/6/24 07:00, John B. Wyatt IV wrote:
> > Add error message to better explain to the user when SWIG and
> > python-config is missing from the path. Makefile was cleaned up
> > and unneeded elements were removed.
> > 
> 
> > Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> > Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> 
> Thank you. You don't need 1/1 in the prefix for single patches.
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupowe
> for Linux 6.12-rc1

You are welcome and thank you for the guidance on improving my make skills.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


