Return-Path: <linux-kernel+bounces-173451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB648C0095
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724DB1C240EF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA5B86AF4;
	Wed,  8 May 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFtY2cY4"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9A86AD6
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180688; cv=none; b=t+ZZGEKedSbU3ODX24nHOtNVz1iLuMw/LkZPnqm9c9Xxs6wIyX7CGhlCfidIrrZTa4JG7rg/DbaS3Bd1irhjwYNn+/bSdwoJvwWSu/1Xq2l/udl81yA98ynx5ZJdIIi+0HHxyzC3ldFUjL0afFwvG0q1ZHfL0PEi7o3lb5npHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180688; c=relaxed/simple;
	bh=BFo75onZvI2N70WEzRUssW0gemvLlk4fluFVMaEeEes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo+uDrLU01x1115WBKUiVHqu/vJznd5cqAGcEPQ6HM4CQLP/q6ZbhvYRdRgS+sNWi3FEfLYfHZjWRzZdIeKbOVvenRghK806/EqXUv226bw0r4dohwvvVQ8Yar3Qusl3445dxxXMW3UgtAZqkWr6flIX32ofUR54BjglRhjrXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFtY2cY4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59b097b202so898138066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715180685; x=1715785485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJrWu9Whp0wr1T9bbbciMuTI/AD/aYy1LnPMSROlLEk=;
        b=PFtY2cY4WY5+m6TysOFGwRr4nCucHf/2QIMF0l2CPjsDoeZzXi/vfAM+xyBo1qsCqL
         PVc242DEJ3saAmIsV2fleC77zm76FIbkPyv6wKq4H/LSHizUgnUrCC37jqx3X9k9zpbH
         pnncs7JTVA2etJ7Bagx/tLUcREXdrtAGjtaFCcb60cycKfVT7/wpswxNwxX6kPS0qepW
         JpEPQ5LP+zVXmNTKJkTPMTYx9iUPOa2X5At2RLgQqc6w6NXchZcyGU2HIK2I1d8xtsfM
         Gr49WBu1dpSTOST+Z9qx8pOdnlcxYGTi4ws2VI1rCWxFkhpYcRVIu5XHmDpoeXdcCCqL
         aBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715180685; x=1715785485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJrWu9Whp0wr1T9bbbciMuTI/AD/aYy1LnPMSROlLEk=;
        b=AIFvRIo+CCCfId8p3AjJgFP2rh3JdIjCzJEaaheTviE+UuGzT2SA/ATviUl/d8VZfU
         XQysnIPMJgkX6rbDh+JwvUXn8VJeJEejSR34QNqgo0TXwMnOB+iQVQ8w+hN+gjuj8DG8
         /KJHjU6/VbueCgnjgDoiWjfV+v4a6o64ejwt0vIXSnPR1JVjNTggQ0SgYw58jsgWtVaE
         fIJRJFmXhrG7OV5I/AvPwlHm/DTLM6T5FvwIR7uNsYV0a8jElvfjlb8jcs6loH1kyFGo
         5m3JtPyLvAgDu7RrNYq8u9CFdtzJOG/gf9wZ3sYIpYN6rG/W5IpeGsdTqx0rxAT3cTDV
         7uPA==
X-Forwarded-Encrypted: i=1; AJvYcCVEro9zbKZNm9OfbxAg8+OocJr1FKTv44pmA9zBYK6ZJxyU5t20ohNp1pIoB4QVgGKJWlYRjLYE9Qx0AM/LZC5pGdU8DM2tSYmr5uQK
X-Gm-Message-State: AOJu0YxYdsucZCaGS//xLxjH87f7IE2SJoXz5nqQAo3pgnXz/WPTsx0v
	4GC54HyFfPWmCEAkm81LRl2BP6RvXnA6wrQx9W9PyR8sorXZ85O+
X-Google-Smtp-Source: AGHT+IFx+82kU+y/X8A0C7QolVEnU4iqiQMFz3TejkjlEh5Tjdmtnr8bvuyHqrIAkEOIp1VVYsWh5g==
X-Received: by 2002:a50:f616:0:b0:572:93fa:d6fa with SMTP id 4fb4d7f45d1cf-5731d923f4emr2148830a12.0.1715180684954;
        Wed, 08 May 2024 08:04:44 -0700 (PDT)
Received: from andrea ([31.189.114.81])
        by smtp.gmail.com with ESMTPSA id es26-20020a056402381a00b00572e2879500sm5484449edb.53.2024.05.08.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:04:44 -0700 (PDT)
Date: Wed, 8 May 2024 17:04:40 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv/atomic.h: optimize ops with acquire/release
 ordering
Message-ID: <ZjuUiHp4Qc7EzuOz@andrea>
References: <20240505123340.38495-1-puranjay@kernel.org>
 <ZjgLAKlWC2HQzWfU@andrea>
 <mb61p4jb91zs1.fsf@kernel.org>
 <Zjqqu6RN1kRXw/WT@andrea>
 <mb61pttj8z9p9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61pttj8z9p9.fsf@kernel.org>

> From my understanding of the current version of the RV memory model:
> 
> .aq provides .aq -> all ordering
> .rl provides all -> .rl ordering
> and because this is RCsc variant of release consistency
> .rl -> .aq
> 
> which means
> 
> R/W
> amoswap.w.rl
> amoswap.w.aq
> R/W
> 
> Should act as a full fence? R/W -> rl -> aq -> R/W

Yes, hence the RCsc ("sc" for "sequential consistent") qualification.


> So, I will do the following now:
> 
> 1. Do some benchmarking on real hardware and find out how much overhead
>    these weak fences add.
> 2. Study the LKMM and the RVWMO for the next few weeks/months or however
>    much time it takes me to confidently reason about things written in
>    these two models.
> 3. Study the locking / related code of RISC-V to see what could break if
>    we change all these operations in accordance with "Code Porting and
>    Mapping Guidelines" of RISCV ISA.
> 4. I will use the herd7 models of LKMM and RVWMO and see if everything
>    works as expected after these changes.
> 
> 
> And If I am convinced after all this, I will send a patch to implement
> "Code Porting and Mapping Guidelines" + provide performance numbers from
> real hardware.
> 
> Thanks for the detailed explainations and especially regarding how the
> LKMM evolved.

Sounds good!  Thanks.

  Andrea

