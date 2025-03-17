Return-Path: <linux-kernel+bounces-564217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282DEA65075
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507991895F76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F723958A;
	Mon, 17 Mar 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayliy0J+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366DF7DA8C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217391; cv=none; b=K18ZNHIX5AmtSJCPuxRPQeSDDZYo+Qz2z3a+vJ/BJ8nkGTC1JY3S8l1fQYff0sxf7YRWmIEKdqVn+Dmpw/JK2jiX5y82evqDU7qoEZKAsW3AIpeVvT72Mt+ui6QOApQLVqDIKstcVerVejLxJuPtDKF97YfiTnpEqIHb9UIQzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217391; c=relaxed/simple;
	bh=RhriPyipoyJPGYANcBi4zQoUe2xApV+MOuv67b0Znu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmUGm6cJqi75MONoQTEuKMcDvC0sHNyBaUDsCLePrxRttI0PWLZnAjSVvChFFx2XyP6lDo5Gp8KGSAlaUhMDAk0PvqFkFFvKWULXjo0id3kkFL0rZDogtpgk8r8QiwKyE1Wo0psucK1+oC44vPSpzCnEgwZXZ4/yb/GIDHsR5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayliy0J+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so9768695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742217388; x=1742822188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wbsv/zovEDboMn6ow9U7mWqBWzoiCvGy1SzvsQKjwG4=;
        b=Ayliy0J+RRMQZPvTiHFluH8gj0FdLcQw/lluOUI9B+JwJQGZgtmQBobcHH8r2o1yNX
         5uBEr0cRJEGofcwb7EBh9csxjydNMwJaiqwkNDwxfwZ9extLYR6Mq0akLG32kn/65RAV
         uh8rkbZz/VAZ2ZypOTmZs9DNuCmWiqF+m8meRtiKAGiyLl1C+ULNmXxxnrTDuo8+ndvp
         /U6+V7jyP8hjHZtGJlWTKocCS+9EFf+jdBZlkD52eNuxu0HuMPkc5W8QsX0djjVPAzUV
         gLZmmurKmddNg5RD4c7rsGYsWTkZcieq5tO/ooz9RF86NjAO4OvYm0oucs9Oj5mT2acB
         9m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742217388; x=1742822188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wbsv/zovEDboMn6ow9U7mWqBWzoiCvGy1SzvsQKjwG4=;
        b=Qho6hsS3Lbeg/sj+nwHua5xyq6pLUkd+HVw3PE9X99cE9yqPEyIpz4yE9djSumOTqX
         7dsXqjH4aYxmO9bO9ZYtnde9v2sUz95ksOrauBsBHkJVkgqcal/JXZ/Tv2/5V0aeFYaK
         P/hybGqy4fMI5RrwmL4jnzVm54b4+Hyl+7fGJCl6YVRN0a3iT9yEvbb8D05jff0FxA8V
         05L3+hkOx5b2TbcXnUv1y2CGBaFqK6fFTu63O9gjYs/rwwMBcv0yTqVxYQY3JShToYzn
         TVB8enJ0MdkAxM++Jfrfe48dPJUqqyDFtfx3nU1Vyknt1OXptguLY6vCPeDfggnnOMoA
         eYiA==
X-Forwarded-Encrypted: i=1; AJvYcCW8W3jlm39VQOFYcO2YWg597VFfTBBCb2Lbt6qcv3/eOUjwKr6z+JdCDJ7a9N/2kCg2cNqx97P5z8pardg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxixfgF4Gg8wl/NUsm4RLHyhGTEQOOyyM1X/BCNE6pW6RpyKG5C
	rNoHpQMRQqbD4Xnu3oRALwH0yXxRJcq47eYxXnaxW/lf0zaZ3W5g
X-Gm-Gg: ASbGnct7EHPu1pQZxFDIao7AlFb+n+P0iV6YKKwa+QWMrePRlm1lJUtLQ/1++Y3gBmY
	ZEdgotAvAxZ2gJXBLnH1rbw49NajzmCkUcqebJbMmMxnHU9/F5xLEGz83yA/ppQPRiz8FzlV2ME
	XZ9ECVRcFBDRKtzcWOP6KrB6vCvK6Om5W9JDCG+t0bOPZ6W6H0b07e4DtficVl/0kUSWEwmlJ7h
	a9cJHM1pONZSYSHZZ3D1HW74rt4ddV0UNDtosCrXOq9bfsiVAgrgoXf1MgOEvAyN41EInlSNjgs
	sJjiWkZQsYqwfLaLs3p4y1X/sOeF0raArzjK1JRELNn5NmvKOWBnkuResCXeGhRIGGNBz5OnX+t
	rpx0Dtjc=
X-Google-Smtp-Source: AGHT+IFnt7uswyyQAnRHouP4yJaV/HyD+Ao0zoZ3pf4gd7hvcJ+W9iEzjHzjG9swW1GEGQKPuN0W8w==
X-Received: by 2002:a05:600c:4982:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-43d1f60a3e1mr112640105e9.28.1742217388198;
        Mon, 17 Mar 2025 06:16:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbcef5sm104115665e9.9.2025.03.17.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:16:27 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:16:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Herton R. Krzesinski" <herton@redhat.com>, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 olichtne@redhat.com, atomasov@redhat.com, aokuliar@redhat.com
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8
 bytes in copy_user_generic()
Message-ID: <20250317131623.2cc15ada@pumpkin>
In-Reply-To: <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
References: <20250314175309.2263997-1-herton@redhat.com>
	<20250314175309.2263997-2-herton@redhat.com>
	<CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 09:06:13 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 14 Mar 2025 at 07:53, Herton R. Krzesinski <herton@redhat.com> wrote:
> >
> > --- a/arch/x86/include/asm/uaccess_64.h
> > +++ b/arch/x86/include/asm/uaccess_64.h
> > @@ -130,7 +130,7 @@ copy_user_generic(void *to, const void *from, unsigned long len)
> >                 "2:\n"
> >                 _ASM_EXTABLE_UA(1b, 2b)
> >                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
> > -               : : "memory", "rax");
> > +               : : "memory", "rax", "rdx", "r8");  
> 
> Please don't penalize the caller with the extra clobbers.
> 
> Maybe it doesn't matter - these functions are marked always_inline,
> but they aren't inlined in very many places and maybe those places
> have registers to spare - but let's not penalize the FSRM case anyway.
> 
> And we do call it "rep_movs_alternative", so let's keep it close to
> "rep movs" semantics (yes, we already clobber %rax, but let's not make
> it worse).
> 
> As to the actual change to rep_movs - that should be done differently
> too. In particular, I doubt it makes any sense to try to align the
> destination for small writes or for the ERMS case when we use 'rep
> movsb', so I think this should all go into just the ".Llarge_movsq"
> case.

The Intel cpu (sandy bridge onwards) execute 'rep mosvb' twice as
fast if the destination is 32 byte aligned.
Potentially this is worth optimising for - but the cost of the extra
code may exceed the benefit.

> .. and then the patch can be further optimized to just do the first -
> possibly unaligned - destination word unconditionally, and then
> updating the addresses and counts to make the rest be aligned.

You can also something similar for any trailing bytes.
If you are feeling 'brave' copy the last 8 bytes first.

	David

