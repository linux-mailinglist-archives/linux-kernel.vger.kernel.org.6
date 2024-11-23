Return-Path: <linux-kernel+bounces-418907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216B79D6716
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A585DB22852
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B8F7CF16;
	Sat, 23 Nov 2024 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+q2HpI3"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F9817
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732326292; cv=none; b=g+fp2djVSGbaExIrUVNDfAS3n59noYpJOhAkDcAYVAd/Yqr3M327CncSClBdiFViwXkIugQwSRCG2ivK9nqgNm2ncawqio4aWGUmIPPdoMkGD3RZaJ/ysTzxO7GYei2RcNAsngf1ufvQtuxQmkRdB3Lw5ADeXpNt+l/RPMWrN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732326292; c=relaxed/simple;
	bh=TJ0g2uv+fOikKVeaJE+ufAGsb288vXYEqQmALJOQXLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcroCZNeyfZ/QSDygo1zyiimUTPMdFLMjtIhzuctF8UIiYAETTevDsotenFAtmkLXM2Kb0zowPGqKIdvs0dcg60PmZHhPyZDxsTKN2X5FVzCNMVoitInC+Sxj/TA6XnLDnm1KXfiOzoRDvbfhpsYfHTd6LltfPpUblFKckXzoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+q2HpI3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so1900a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732326289; x=1732931089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S3VAkynSndmVHDi0F0L9SQm1sisxlAWh9z4fRkq2KhY=;
        b=l+q2HpI3rmv14EZhGlpRHtZZ5ocQkNsQDuln++6dvJjNb/HfbnfwDigtcrQA8nVkfV
         qRo2Ix4bP6GLPmlTk9dYdpdqsvecuq1XnzzPaUfI3l5pcyEBVAiwZD5p2F9Tr4BtqQA2
         9HGl0BiiMyOadlC/dlThphN9GVaAdHSDFTUqAXD2ZfVi8DH5nTEBOOwLUjcb2J2RM36h
         s7cjuzQVC2H+U+sw1UfKZIIHglvrby8iJvSfLOZXnNnJEqhYtF4xHoGHTnI5Ad+KAe2D
         ne2agVufHfdjfEUYsj8DhittcXQnRr8uqvhljnudGt0yIX0E0k/4p9/Xhoko4K0/sfGc
         9iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732326289; x=1732931089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3VAkynSndmVHDi0F0L9SQm1sisxlAWh9z4fRkq2KhY=;
        b=G53OArwI1P5emVqMkicZ63LBCsexiaRaSHoguqDkJLkunU91rQO/Ce1Jbly8fl29KF
         5GEWJKHlQuxWHttYHH1A26OyrhIO2BdUpS6mSGFudCOmh2tGyczvhN0lfMPo44GE6LQM
         v/ctWvvSj79CV0YHqNvxmb8dwztuKpHIktmUy4dHEhx1+Zc4nGnaRO9q8vTQZK0lHZAI
         HJF8NlOorpFvSAWnSlVS0SLr2fJuCkQKTSmJaAJ7os6cHxk/gG4goXqLioHnrvI5A/oE
         92HQRPNEMaur7MxWJji+HfkcJSGoR7ofRHCpP9EUEVMOo4IEbYqwjuQ8iKklCvF7yXQT
         BQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCVu5YoGdKZRbvCWC/FYdLnmpP7AsrarFg1VEnnD98d00R+xEC2hoPBv5Q3sln/9Kc+Tu5Rrbv1+Ie5i0Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThlBfKEKqOwGF+EDqh9X7PpiJWOUKJhU02HYVK6ZCe4BXimhf
	j2MypkzQduwHkc+BvM0PxB3CV7EgAnCs/ml+KcJRSxxjl81rJYvzwnKBTZAMVEAGmE2RzKTqfSA
	2UkoPvkOdpLABZEtOh/PUwntLkJngT3d/sFmX
X-Gm-Gg: ASbGncvFLb0uUA7H/8PqIzGumXqPy0dafyX8Pa8Nbhs2qiJ271s74oR0pH6y74nqMZK
	raJWZ+QC1AkdrflT4W1mfI/KFY+vc2P6+lXU2V4S/mactVcefNcr+iSMuxsBMqD4A
X-Google-Smtp-Source: AGHT+IGL77AC2bNXg1gDSicOAbEhb3ZzKW1ZO63HPbNunVMxHMFLSIMrlQMvQthUYrEvM5iHSpLMrwWh4Y5yA5ldlD0=
X-Received: by 2002:aa7:c249:0:b0:5cf:deaf:ac2 with SMTP id
 4fb4d7f45d1cf-5d035db0d11mr37256a12.2.1732326289218; Fri, 22 Nov 2024
 17:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-extended-modversions-v9-0-bc0403f054bf@google.com>
 <20241123-extended-modversions-v9-3-bc0403f054bf@google.com> <eac20e8d-d08c-4be7-a34f-b511798f0a57@infradead.org>
In-Reply-To: <eac20e8d-d08c-4be7-a34f-b511798f0a57@infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Fri, 22 Nov 2024 17:44:37 -0800
Message-ID: <CAGSQo02-o_T7LY4Ld3EyQRyWcuryzw1YSnt=fi6CBiN4NAmYDw@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] modules: Allow extended modversions without basic MODVERSIONS
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Jonathan Corbet <corbet@lwn.net>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >       depends on !COMPILE_TEST
> > +     selects BASIC_MODVERSIONS
>
> tested?  'selects' is not valid.
>

Apologies. Tested before making BASIC_MODVERSIONS default. I've fixed
this locally, and will re-test with the whole stack before resending.

