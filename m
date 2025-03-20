Return-Path: <linux-kernel+bounces-570297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD2EA6AE75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591C9188EECB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA7622425C;
	Thu, 20 Mar 2025 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AJOYT1IB"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B0227B8E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498641; cv=none; b=cL9L8guaX1VmK/uou1AXXUDUxJEWlYnVpeCNYH3qpcIo7bwP0lEynd1S3rjTIrRDOkvFf6y8dVPb2gxTFAxXZe06+5GyFUsP2RKldqTJvbK0X7aLBq1H00WLPaOsIb1vd+bVdYWVHrcriwC+KgXpwNn4YlqBKPLExsdYueLcOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498641; c=relaxed/simple;
	bh=P9mYjmAcjQiP1DTnZmrZBhHcC1kT+7aMqdgEN+lGl20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCVW4h+lF1tMwkxoF+FEvWYbiheg6M2ksIkfsLD4Hwhw0EFskBkZZ2m4a5a2z2a+A2P4BZSYVEQNOFd8Ps61jAPWP7SFraZdqwFnZUu+4U+R/17oBP+H6vf6XrPigPDicG1bISWIKvp3UKEK/Q27TsGeB3awMQaFCmt0T3i6GuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AJOYT1IB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso268410766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742498637; x=1743103437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JCuc1S7s//oq9AwdwPmiGLhe02Yv7RYI39DMg8kRfvA=;
        b=AJOYT1IBpUxC/k6SXlPQxH6VMDS6nU/XD0IgxAdw5wfTWEPtBxIWA7/s8r5XE81F+v
         VIvfPJVG50n3HvJMzeuTGBwVDApforCveL0vdOLXigzl48T8sDdPb0Ei99e5k30mg3mc
         uGsoB67tA5JJkRR7F4f+MIXNXmlm3qFIRz+1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742498637; x=1743103437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCuc1S7s//oq9AwdwPmiGLhe02Yv7RYI39DMg8kRfvA=;
        b=d7QlsQnHsf2o9eDJg882JOM4iLP6XeOnQkr93Wvtkf10f74vOSrsxTZ0HaiL9FVF0W
         30m5sPLotYfbmhRgevBSP7W8Pwi9Sm8ioXtYzhmKa6LhghyDpFwM5lObAcOqsIjZBTJp
         MnwmoMEgufz13lBrwPiGXSMksoos1tY54KvVe3FoWtpm2ctMk5Z19eoqg8fYq+p6+eph
         Gjzwfm8/hOfJcUKD1whyi6IoDMl6Ch7GOIIgjJZvS8csfviS3OJSjSEQA5qgaGSJg/ul
         8ksjYLGVb1NoHqNyQPJduBb1u+0iIcHUU8SKyGM17eRISqvVbJbQIawSnauUC4mNbZGr
         gMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkQplyDCh3GbgbzAagcyMcHOBAH0F8kYXGiYBomPDRhWS5Hdm71dtno1KjHpY1uHZ7X9JpEVP8LuAPwOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyj5RTSB60GI00/UwJep+npB9xzzH/Uw3B8pqwpkBU1m4vwqo+
	AW/UIRzLDPyEkbEmi5+DfTOVUL2Qb4K7XzNFx35gVYc8Oe4zo0TGkMKOU/n7H5zB5AG8KnseZ/i
	/YLk=
X-Gm-Gg: ASbGnct4lmAppJWPkN0TJbW93VCz2swWGpBsm688sFRC4VmyLq3F1gO/thJhyCrWBlP
	ZzJx1gxA2rK4EiLTOm9CVPlJaT7nY9MSl9H9M9x/MY9Nf9cB26j5RKjJyBNo7Q6P2VzDBEFr8pp
	XnEiDr/3n8eJf3bJvlFJST96kKVW26I7LuwQxT5ZwJsH5XWGJTlsriC5y4ABlAZldQJoNnZ+Xjb
	6MureIXpUqI/O5rkyru9ELL0CHw6A3f2nmb6tXqsYfI+Hmd0qEzOLHH+oVyv7IuWTCKIM6ilP/W
	o0DM2/6lF1IfzWTlE0im+1PPtCHK2YOLGWUPf6QdgMEhrXNTeLSs2C41iNaFKXL6Xqkv4DgFsJA
	KxVbti16N8HXkxgEhRms=
X-Google-Smtp-Source: AGHT+IGVw/vMnbt3bgUp6z4rrzdIm28uRGK0b1uGvDgwHlyfm4o89Oqg1v/B6jPdlSV8Y4JjM4s8iA==
X-Received: by 2002:a17:907:c810:b0:ac3:446d:142 with SMTP id a640c23a62f3a-ac3f20d4d6amr50636866b.2.1742498636901;
        Thu, 20 Mar 2025 12:23:56 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef869f19sm25808466b.33.2025.03.20.12.23.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 12:23:55 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac345bd8e13so213750966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:23:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsjP8jjxCVYMmAoWih5MrSfZuzgdDxNL5gWOV7G68IDB227pT0er1rMoww85e5nt/yG27jqnxXk2kORKk=@vger.kernel.org
X-Received: by 2002:a17:907:9691:b0:abf:7a26:c486 with SMTP id
 a640c23a62f3a-ac3f2502fbamr36128966b.40.1742498634596; Thu, 20 Mar 2025
 12:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320190514.1961144-1-mjguzik@gmail.com>
In-Reply-To: <20250320190514.1961144-1-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Mar 2025 12:23:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
X-Gm-Features: AQ5f1Jpv-j6bhsRAc_k9kZ9NQM9DEqjC4Wh8sc3wuzx2WB8N7AumutQIQcdQCsE
Message-ID: <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: x86@kernel.org, hkrzesin@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com, 
	atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 12:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Sizes ranged <8,64> are copied 8 bytes at a time with a jump out to a
> 1 byte at a time loop to handle the tail.

I definitely do not mind this patch, but I think it doesn't go far enough.

It gets rid of the byte-at-a-time loop at the end, but only for the
short-copy case of 8-63 bytes.

The .Llarge_movsq ends up still doing

        testl %ecx,%ecx
        jne .Lcopy_user_tail
        RET

and while that is only triggered by the non-ERMS case, that's what
most older AMD CPU's will trigger, afaik.

So I think that if we do this, we should do it properly.

               Linus

