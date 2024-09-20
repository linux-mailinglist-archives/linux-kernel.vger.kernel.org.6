Return-Path: <linux-kernel+bounces-334315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47F97D5A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8C81C21B79
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F09F14D44F;
	Fri, 20 Sep 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU22EkQC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BA14EC44
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836287; cv=none; b=Amu+DtPL1Ff0IWW/LLUfYkSO9l1YeTd5NQmgbhpORvbc0h2hyI+yz+HEtdzZajDGwDXFBWfZSCu2kaPc0yj4sMah6TOjMN0TEpZZpW2SdFWH3sSv2xq8R+J5Ng5Gre8u1drzvnYGKhX421jwaJOoO8Qm2BH9SPKXGL2yHjSckOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836287; c=relaxed/simple;
	bh=1BxVcLr9T5akCUa67eGdALCWg8upJ7NHQmVMbvnzQt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob2t9uFWzEctJExBc7hKEYZl3/EpNE1oA1fXb3eu5X5N3sOSDNOGTr24NJSaVql8dsFllCP13ef7oRBr8VSQPUQRA6N204CUeVh9JJoN2MlMXpCcdkRjXMYoeVC8wF1NmL896I88LkxyFlBtd33KYKcB2DTRPQa8Fi8C8yJtpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LU22EkQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726836284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34v2s0941spqI0sqw1O35lewMWE79s3/bYHocZBIF2o=;
	b=LU22EkQC4MXtJ4adSU/oFLxxVTdTiWDlrEmdAt26fZXiqNxF/8FUVzxcf+Bc6e6CRAuEis
	k7PhErYalpmd81NwN/L695HOSXp0vAAEGTXaqme9lLwk52uI6lOVTU9+GOQCFf5EBqrU4Q
	9t/7Fer/nagkW8bZB/gbIE5lXYAfw9E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-GgTMYQMMPqm4UzHmhTvPkg-1; Fri, 20 Sep 2024 08:44:43 -0400
X-MC-Unique: GgTMYQMMPqm4UzHmhTvPkg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a9a653c6cdso487868385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836283; x=1727441083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34v2s0941spqI0sqw1O35lewMWE79s3/bYHocZBIF2o=;
        b=m6TlTpVgCNrkW3ckthKy3lF30B7cDex53iztPyMVWrZtVXhWRtDGKPZEC0flZ2tZB6
         3aDKzElDJOWo3lXYQqv/h+fIb1UNt0qi1xnvA+FfmOsXsmV07UcaY2HBEtdrERZ6MMyu
         AWuPVc93qsP1T6Lx977BSqywZ/esRd1zBb0GDUmU2S7u55dL9/pyF70SIKH7pO3E4DIf
         4A5DRsYVs/LuJEh5xpRnRbms5YTLAHfgzrzQd7RxXDbPN740eUYjvTQYwfYEhKK8f8CQ
         gi6e4ggd2XnzRzbGuoMcvHMJsQNJyA3xOjv4X1FRJrMiw3jrrTyt+AvSd+gnRZ1gLJNB
         7nkw==
X-Forwarded-Encrypted: i=1; AJvYcCUcfI0VnyRq3FkJTwkVntFBo0ovykIsGKea57J4kzeb+YQ9TbsQxg9tb/yDNLxGwOjNW/Lfn3OiCFGF/Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwszqLFj1mpHKxwo5ibBB5yF9NBLdMgrubK3mWxg4XUowv5FQ6C
	+Y9ofgK44imDCiR3iNnIlJ6Fku6qvQHWz5CGqKRf8eGDVzE0ZfAhxuoNmvybsq5HXdTgoHm0RPe
	UWufXxxA6Zlj1pBJmxPB2RZC2ZBYz1EzKhzovdf6WXlX7x9eat9EPDeYlOOjF9Q==
X-Received: by 2002:a05:620a:28d2:b0:7ac:9b07:dbd3 with SMTP id af79cd13be357-7acaf53378cmr1041352885a.5.1726836283033;
        Fri, 20 Sep 2024 05:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGPjgwWDVf7c4pej8MrohxO1Rs0UK5CIECse5obYH6phbeEFFyOd025EGIcrgOUVrGbjolzw==
X-Received: by 2002:a05:620a:28d2:b0:7ac:9b07:dbd3 with SMTP id af79cd13be357-7acaf53378cmr1041349985a.5.1726836282665;
        Fri, 20 Sep 2024 05:44:42 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08d9098sm171843785a.111.2024.09.20.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:44:41 -0700 (PDT)
Date: Fri, 20 Sep 2024 08:44:39 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Message-ID: <Zu1uNyTWDgot8cQY@rhfedora>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <ZuxTjy7I-pZBcXa0@rhfedora>
 <PAXPR04MB845910C56EA61D3215DA5452886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB84591B0819F847D79548CFB0886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84591B0819F847D79548CFB0886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Fri, Sep 20, 2024 at 09:01:49AM +0000, Peng Fan wrote:
> > > Not sure you need 'tools: power: cpupower:' in the cover letter.
> > 
> > Will use "tools: power:" in v3.
> > >
> > > > pm: cpupower: bench: print config file path when open
> > > > cpufreq-bench.conf fails
> > >
> > > I do not think you need bench either.
> > 
> > Will drop "bench" in v3.

I do not think those alone are needed for a v3 since I was corrected on
the changelog; at least as far I am concerned.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


