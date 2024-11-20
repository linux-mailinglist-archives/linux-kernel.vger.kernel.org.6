Return-Path: <linux-kernel+bounces-416407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4DA9D4455
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4553E282431
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67EF1BDA8A;
	Wed, 20 Nov 2024 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkcRHLPP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB219CC20
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144337; cv=none; b=b55FfbqmCL5uaLCRM+pIQZnpOA7Ywauuaabe045kiUwuR1YwKwKWLoPh37p4WZFg5JbHhdun6EEy3SkT6Ugj7vI5WIRUoWRZ+5XCyvAa3MwBcK+8GpytKvq3wb/8AK0qJMa9GA9uVHfuScm0Oeb3MVzbw/2VZ/IYtypGSVZ2T3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144337; c=relaxed/simple;
	bh=x8HjiroxpsIYhVfoexyBukF6/dMPHY3yTGvhwTLtPGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwUwsfKBMBnBXmjVu93HNG0TFRAlYNw3yGS3q3nuFn4DomfX/6XcLgZgGPBX2fXEsf1q2F57H3mnihcg3XFhZZ1RaRMPmTxr+cR41wRPrEzDWsmbTZUlgHMvf4pmVaGw00ofjOgtzBp2MFtYvmROTcrzqRLwugHg2lxXr8OTHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkcRHLPP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21238b669c5so55315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732144335; x=1732749135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8HjiroxpsIYhVfoexyBukF6/dMPHY3yTGvhwTLtPGQ=;
        b=qkcRHLPP8S8S7w4JmZ7ARV5u8q1ncE2PvDvoAhBduj+1UvkBS6sry9vp6hapUld/EI
         241wBtNXi9zg1YymLCIjS5LOyaSdEPQl2S1Tnn8HQhrLUg36n7K646vJ16/d8txrLeOk
         25oG34zHOduCyvgfQWSw9zgtcim2fO2R3qhyE/LiEaCFzoMp41tCD2EWKq0OfGgU3jnS
         Xo44JsvoyKzR/SQrShRhSsekaA9O8QbDWbQT/iJMrtC29TeNMnsjws7fOU1yQ2H0bK0o
         M4C8n3bYw8ZV68WQxsd2Eq2TAr2tgbVPqWzm9aZ5F6CKw2SavHOUzDdUFeiordS0FVrW
         oNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144335; x=1732749135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8HjiroxpsIYhVfoexyBukF6/dMPHY3yTGvhwTLtPGQ=;
        b=xHFU+UsVtitm4vzKlYSa7TEEzdNLYTIA8u0jBT21NehkRXVkb17GXKDfTj82ixSGXK
         38Z2DBpecGRDkro0c35pfecAcNj8Bzag796xZRaz6m63Ak3VtnKgYiepP48RPGRsExjN
         ZxYLDdScjll+kfmJ/9bmiLZCJMmOBEv34BzNbm3xY3WcU8D8rt3bP10ExmM7uMtYYPnl
         kl7hZURF3gucGBeTrK5lmjQjDmVoB63ANNAIEcFL6UtXp5nkCtVMXKmFqG438gHnl4iE
         4e5GVcfAYuWs+fPH+8PDWMFqPZ/U0i3kg63wwyQvb2szE3N/YwqMrIhbPXTfpBULoTWY
         8owQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyBMJJ2/0bVO3vw9/2oqYN+fjWDag8G+N7vqf4RuQMXgYQe6D2Lab+0HOc5qoB9WoP5W+JAdfwtUfR3qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nCrwhQvmJw1fyxHJR5dfvmY0dlqBIV9FSbBWyVpk3dfixqYC
	ue+J+knGnKIhagXaK7Lr5yQaFsnMBgCxWK16MEywD2OZNLzNpL/AD46bGtPlBqEKXAmTXT2RYRs
	63vHsOzDAL0EFrWXa8YmMRZv9MWhiZx762Zex
X-Gm-Gg: ASbGncs+0z7m7yHBU224SnskO2mCUTR0G7Tl09oYBI0tmAoi8/y/IeLdkzQGSSMCpks
	Tosery+O19x8c+u7SI3pXgUXHHrSNktArVxrIFaziZwbJOfGlkh/v9k/1t8g=
X-Google-Smtp-Source: AGHT+IHllzdMFCX/RYl2KtmCvSHbJhx7iEOYFL56BaE8loYLrfNGhRx1//aKyRIuYiDsLRGb0J/wKReDd2pe3MAnsZw=
X-Received: by 2002:a17:903:985:b0:20c:bb35:dafe with SMTP id
 d9443c01a7336-2128428b639mr1047155ad.0.1732144335092; Wed, 20 Nov 2024
 15:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110152906.1747545-1-axboe@kernel.dk> <ZzI97bky3Rwzw18C@casper.infradead.org>
 <CAOUHufZX=fxTiKj20cft_Cq+6Q2Wo6tfq0HWucqsA3wCizteTg@mail.gmail.com>
 <ZzJ7obt4cLfFU-i2@casper.infradead.org> <CAOUHufadwDtw8rL76yay9m=KowPJQv67kx3hpEQ-KEYhxpdagw@mail.gmail.com>
In-Reply-To: <CAOUHufadwDtw8rL76yay9m=KowPJQv67kx3hpEQ-KEYhxpdagw@mail.gmail.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 20 Nov 2024 15:11:58 -0800
Message-ID: <CAJj2-QFworodFR0CE7FryJdKnv=2AEGbvJF=txZhdDPmFvaYsQ@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/15] Uncached buffered IO
To: Yu Zhao <yuzhao@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:08=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> I was under the impression that our engineers took care of that. But
> apparently it's still pending:
> https://lore.kernel.org/linux-man/20230320222057.1976956-1-talumbau@googl=
e.com/
>
> Will find someone else to follow up on that.
>

Following up on this thread. Alejandro applied the manpage change for NOREU=
SE.

https://lore.kernel.org/linux-man/20241120104714.kobevbrggqo7urun@devuan/

