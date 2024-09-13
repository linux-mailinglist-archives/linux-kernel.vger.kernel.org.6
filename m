Return-Path: <linux-kernel+bounces-328567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B49785DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C13528B460
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF66BB5B;
	Fri, 13 Sep 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwCkt2Wu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B66F077
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245331; cv=none; b=pgtFGfBFtEf1isqYjG65HBpBKejourH8BkCuOIT7ZtyrWF9keR5/6uAq9kAljYpfjnpZ2g+wKozeKkm21DjmTEEQetPXDqQFjtsWUBuCGdM74DYlmthwvrnIZHF8btlCUhQy+w34blkvAk/O2gnHHBMGN/7EAucUUWjWNOizalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245331; c=relaxed/simple;
	bh=g+9WJ1ZXHQDkBth9rUa5BTms3cYhZcfpjLiOxYbR0kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkNSZLBeQvXxHSLAhLJO/glKe1iYk5sK1ObljtVS3OKyCbivOyckAJuRrsMQSmuxGO/ZUNkhYJi+bomFI9zDbi3LfqCbwxb82qYjKsjUeeSiQdroMtx6RSlyjLCx6/dJUZefQR8OFKYDt9lSC61JZ+KzaHgrpsDZnoFSlkRwdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwCkt2Wu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726245329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kDxK8mYG6+G6vlDOXCZbx04chuhu3gLUGaNlsKs/16o=;
	b=ZwCkt2WuIz25Cf5xXjyl2pweOAdJ9itZ9zZi3C4Rsfo8533KG1xmHRe6D7wT7NfKPAgbcb
	ZnXnybvZVurBNtV47TZ22arUX3/o5zU5AVcIbfghIj8x4t+n393E9opGLRLovuTBKz6r3i
	RYD8GhgaRis/Gf0jBCYlMs6v/hTUmgQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-valFor-RMlmyvxGfnHO86Q-1; Fri, 13 Sep 2024 12:35:27 -0400
X-MC-Unique: valFor-RMlmyvxGfnHO86Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a9b86db6cdso412021285a.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726245327; x=1726850127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDxK8mYG6+G6vlDOXCZbx04chuhu3gLUGaNlsKs/16o=;
        b=JSKwHsx+FzNYKiMIeX6v70dQRAAp2sz/u/IJpNsc5x/QOPWXGTgxI4SkgJJH2KQP7d
         NzlBzAAP8qD44USEkFPa3hNFtTc02EoYgaONApDZbxms5SBoiEhiT6ZqSbxPZVosJRAq
         hg8VxRGoUOonZQmn21GMzGL16kLNpJxg6zKXa1+A9qHmW3YHQVt1pFfhozbXbxCGhmUi
         xh5EzXj4Rp1zL1CkC71TbABl+MPuZCfqgrHsqKq31Tcu63YfIlJrBuxmTHjjgd6J+3dG
         RU+shCz1k3uPSyUawohbarTGaqKd50TnMgo+4WNriAblDybQmsW7BDh9hyYIt2Ibp6TI
         3QDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmKgVvqqeo+5umaX6LagbMZ4hRwv8svZM5B1KgafgjUYdlUV4BP/Uv8FulcIM1ftk98oYlYRllu7wfQew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNSHooVkr/kS6B+uSfkeAdfyo28ShZtCVkcu5NUvwNdhaJc1x8
	csIwUZ9zKi+XJkVmkhxDvS6yAEK7z35M6t20qTeoo/opDk7wrUMv22tEuI8ovCavAMkiGEdsnm7
	EsS+vmg8aWbhbckZFOB0OAB518yoO0iwMK93+gBsWYKEyEvhAEoGsUYZ4RHr+Lw==
X-Received: by 2002:a05:620a:4105:b0:7a9:c203:7c2f with SMTP id af79cd13be357-7a9e5eea55amr1057643285a.4.1726245327249;
        Fri, 13 Sep 2024 09:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUA4jq/HTwpUoDP/NCE+TdCvRhLcB988bjHCTl7We+QqORja2JYbRSce87B0DnDzhAzLv9IQ==
X-Received: by 2002:a05:620a:4105:b0:7a9:c203:7c2f with SMTP id af79cd13be357-7a9e5eea55amr1057640185a.4.1726245326926;
        Fri, 13 Sep 2024 09:35:26 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7995e50sm679514285a.63.2024.09.13.09.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 09:35:26 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:35:24 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Min-Hua Chen <minhuadotchen@gmail.com>
Cc: skhan@linuxfoundation.org, jkacur@redhat.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	shuah@kernel.org, trenn@suse.com
Subject: Re: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
Message-ID: <ZuRpzN2OKHQ75GZW@rhfedora>
References: <b64402ad-4c0d-4f5f-939b-4be1a7855e4a@linuxfoundation.org>
 <20240912225519.119392-1-minhuadotchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912225519.119392-1-minhuadotchen@gmail.com>

On Fri, Sep 13, 2024 at 06:55:19AM +0800, Min-Hua Chen wrote:
> AFAIK,
> raw_pylibcpupower.i is not a generated file, it is a interface file
> for swig.

That is correct. You can do more advanced things to help SWIG handle
different languages, but so far with the script I wrote for libcpupower
simply copying the definition files as worked for me for the .i file.

See:
https://www.swig.org/Doc4.2/Preprocessor.html#Preprocessor

> The *.i file extension is also used for pre-processor output
> (single target build) and all *.i files are removed by 'make mrproper',
> including raw_pylibcpupower.i (should not be removed).

That would explain it. Not just 'make mrproper', but 'make clean'
in the root removes the file as well. 'make clean' in the tools
directory does not affect it.

From 'man gcc':

       file.i
           C source code that should not be preprocessed.

> >
> >> I have reviewed and tested and this. I am good with it being a stopgap.
> >
> >I am okay with the stopgap, but I do want i explore other solutions.

Reviewing the documentation a better solution would be to rename it to .swg

'''
5.1.1 Input format

As input, SWIG expects a file containing ISO C/C++ declarations and special
SWIG directives. More often than not, this is a special SWIG interface file
which is usually denoted with a special .i or .swg suffix.
'''

https://www.swig.org/Doc4.2/SWIG.html

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


