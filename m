Return-Path: <linux-kernel+bounces-180107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79F8C6A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7138D1F2357C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1A156253;
	Wed, 15 May 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IiIT5gZQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853A43144
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789145; cv=none; b=AytSZw8Tm251Kg1RNY6E7oLI+WnUzw84XuxbyGlmDo0C+HwUGP/T0fq2U4x9rdxnmaLsx5Jxtd6j4qBQzFpfV3W7Taleo93ul+D3kFtRy/EvLnhZ/OxkCXLd4LfM4c1onlrDelyYqqwv+zD8SjYQeDug2zAVhG0x9M0eBZxA5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789145; c=relaxed/simple;
	bh=hJHrdHj0cikWqaVWvyi6gHT8PuTbJVo4o4T87OWEoW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ub2PkuMTthvON8iIioFjmVqCx3k2xqfqqt3NbF1YoSYk3IZZT4MZPK8zC78DmcovCaLWPtLZ8K38PNfjuK4J6fsVtjs/WWH8N201FePfwLlr6+1O/Lxj9i/bh0bvFPZuJK6NRI9gpj597c/4j3VezwID7MAq7uRqeIJCIUFxqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IiIT5gZQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a609dd3fso256980166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715789142; x=1716393942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2ehF00UkFVYae8eoKheTBkPEUp/ENYAZ+/DySjcSWU=;
        b=IiIT5gZQcqzKMHpc/5W2YcOOu4OfnKolvmspj74yxAWqNITkfbkalSasme1ro4Y04/
         XpW7WdYlyE51aHYUmCcNtloejCVXx/NJLDaWYO0Ja/fGofbf0QzrZlCp1xvk52trxioP
         sDmCwmUj60J2pm5tTtb6kow47ES9pMVF005Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715789142; x=1716393942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2ehF00UkFVYae8eoKheTBkPEUp/ENYAZ+/DySjcSWU=;
        b=Vo6lKeykpWx1oqqDoYcq78O++KjcYLQYTLluNGQhbrXc2AQbZt3MrACG2z34bRAsiX
         rvgSaZ83ffeW2XaUKqxXwu36FgMOdzMInQ7ACRxaPFKf6jsVDAuYWQUgWFX/Jy/ae7HG
         bBZN4rmAUPH7eW67NEDhnFQ2vTDSXjG3emYaJwVSFHRw5J4LFhyfn/j2OOGyhaZBEOc9
         gIW4FKPAL5AUepuF7xrH+CGWTKO3Rdftwn7j+XquzhPhw4/Dnp1sTZBVbX/3rEyAfGdK
         Hp1DhJWC3UaWSamTuOuGLLFvHR03t1ousupqogV5KMBscxEJtKY7HQ8LHYknD/lm5gYR
         QFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8wKoCAKWIltiPZUXMrc8NncylhGYQzxlhlLmoCwAbRdYcIdqK2s4V25COoCivBI6qf0VV7nuGNQYcMn2QXdQ6i1rDiHANvZGF/ngg
X-Gm-Message-State: AOJu0Yy5+Pv4LgdbFuybSLqReDuY6cqeP4gkvOYf2DOQDAYqwjxYcUzF
	5oKDgmu5JbJpWBfDakhKaJejFrlwjZOJasthXxEl9iOH+AD+k52Qj+pMF8sNStSYV9PBJoyZ2qp
	BBbBXPw==
X-Google-Smtp-Source: AGHT+IFAxvk5vDMDyx53gZuTXNocRJyu6JPOeCDOGPmqIurAqlrRjsvYQuL37DctI1wL7R54NzSy3g==
X-Received: by 2002:a17:906:eb07:b0:a5c:dd2c:d95b with SMTP id a640c23a62f3a-a5cdd2cdbafmr64814466b.25.1715789142186;
        Wed, 15 May 2024 09:05:42 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea6557sm9258182a12.13.2024.05.15.09.05.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 09:05:41 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a352bbd9so261952466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:05:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgCxC1kHtKDdYnk2FVCMaIE3XidhD5TzPxTQSHwZUOH2KhYtV8gi0xuMXIV6vzpbWtv/7Ekex43HtRcfmmk+BaXvYbw8YJh0Tvsd3w
X-Received: by 2002:a17:907:25c1:b0:a59:9eee:b1cb with SMTP id
 a640c23a62f3a-a5a2d30be86mr1715412166b.35.1715789140754; Wed, 15 May 2024
 09:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHsCLoBsCdv2TiaQB+2TUR+wm2EPkaPHxF=g9Ofki7AQ@mail.gmail.com>
 <20240515091727.22034-1-laoar.shao@gmail.com>
In-Reply-To: <20240515091727.22034-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 09:05:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcnsjRvJ3d_Pm6HZ+0Pf_er4Zt2T04E1TSCDywECSJJQ@mail.gmail.com>
Message-ID: <CAHk-=wgcnsjRvJ3d_Pm6HZ+0Pf_er4Zt2T04E1TSCDywECSJJQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
To: Yafang Shao <laoar.shao@gmail.com>, kernel test robot <oliver.sang@intel.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	longman@redhat.com, viro@zeniv.linux.org.uk, walters@verbum.org, 
	wangkai86@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Oliver,
 is there any chance you could run this through the test robot
performance suite? The original full patch at

    https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail.com/

and it would be interesting if the test robot could see if the patch
makes any difference on any other loads?

Thanks,
                     Linus

On Wed, 15 May 2024 at 02:17, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Our applications, built on Elasticsearch[0], frequently create and delete
> files. These applications operate within containers, some with a memory
> limit exceeding 100GB. Over prolonged periods, the accumulation of negative
> dentries within these containers can amount to tens of gigabytes.
>
> Upon container exit, directories are deleted. However, due to the numerous
> associated dentries, this process can be time-consuming. Our users have
> expressed frustration with this prolonged exit duration, which constitutes
> our first issue.

