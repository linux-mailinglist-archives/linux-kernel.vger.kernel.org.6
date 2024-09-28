Return-Path: <linux-kernel+bounces-342570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A41989071
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3591F21FF4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF15142659;
	Sat, 28 Sep 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YwH2hECF"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1274E78276
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727541039; cv=none; b=n8XLxhJNn84cxl5cHeDRIJ9SeAhO4vrPmiaHc8Ct7rcpsXsVcKZxTObU8dgA8v9LW4EVoNO4qHZ4L/nuWNxPDfkelNCmM7KuoyUfpH30s5lgutr4dL6rwQusqniFTl846MMw+Kv1WWTwYDjSts+ydz19zBYMsVCG9xu969GgbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727541039; c=relaxed/simple;
	bh=9v5LeD/VBpgdLkqY4q80UQk5vs5hnLeoXnybcXxouKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtCviU6lYy4+c0qocwtXeGhAK/4oHhpzIPSZIl0MrdXYkxjpbvIIlLsCU6/fXHERP9YWcOnoYX8qrRQZvPhBUUw94yksSfgneQSwA+p6mfeDpqTM4qx3V4y21K83C1IxCjPQUmQP7R52bdTQ5SC66YE5PqjoQ35uc0NQa3wqHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YwH2hECF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c5c3a1f474so3526186a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727541035; x=1728145835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yRdR8JrFJlqZaxiC8ock0OkPKQarzgTETJ8XRVUeN7E=;
        b=YwH2hECFpdfS1PC5LYAKW4LaBzXuRoCWQ0xOV/xYyKA0ljs0RWlHC4Ezsv4/u4C76W
         KhSLVqCbhU4zbGdoXP7uC7zIHpRVXYvHRrBfgDcLFvqH07kzyzsiyrL1vD8XPxY/ASw3
         jpc2SfCLYbFhhEwwQ91xrVNtoOOHBW9nKxrdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727541035; x=1728145835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRdR8JrFJlqZaxiC8ock0OkPKQarzgTETJ8XRVUeN7E=;
        b=hr/Ibve6e8PRqYSfsgVoFeCEiE/M+zluqxwHMxqaofpcapzjKNGrb2fpR5qC+DctWN
         dkbGIcuzkISSrqrjBNy0PXBpJRQotuZt/lNBhmkpc4QXN2NehJd8puEm5gTTTXyYaiw2
         w2JHRhQwZs3MpQosrPyS/uc4P+VF6txcUkS3gUmVU9/qABpXh6gG4iWTOVJmyk9iLZMH
         c2IozQ7RvWnN8ClxvYZY7nEtKDd6zqSTQcanu67FoQTm2oABDqxlfq9xkYngrb5FKu4l
         XN1eELp4WTSXSEuRjGWLo+jGCnm7QyJwWMWHETbHWHlt1o8xoP1EnqDzBg+Zg7yuPZIW
         6ulA==
X-Gm-Message-State: AOJu0YzbUKep6wqVjLy77PluxC2INs1jyIhWg6r8+QAwGT2vFrr1dk3k
	f99injVMcqwtzbT+KFTk7/UBVm6rdFKBj1iyo9KaSjQdHOhawIghNy8LwVClZYjfUu8q2VZqW7l
	XkhRnfA==
X-Google-Smtp-Source: AGHT+IF1KYKqCg8UuyvcdcY+UKCnpSYvPpnL3FqJDi8fu8Dh3G3kpg88yP4J5wYZp3kIOnAcVvWfbQ==
X-Received: by 2002:a17:906:794d:b0:a7a:9ca6:527 with SMTP id a640c23a62f3a-a93c48f0dd1mr786752466b.8.1727541035190;
        Sat, 28 Sep 2024 09:30:35 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5a0dsm266402666b.76.2024.09.28.09.30.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 09:30:33 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a90188ae58eso378843966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 09:30:33 -0700 (PDT)
X-Received: by 2002:a17:906:da89:b0:a8d:3705:4115 with SMTP id
 a640c23a62f3a-a93c4948a64mr702847366b.32.1727541033332; Sat, 28 Sep 2024
 09:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928153302.92406-1-pbonzini@redhat.com>
In-Reply-To: <20240928153302.92406-1-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 28 Sep 2024 09:30:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiT0xehDuhtcut3PFeYnQW2H6Hx9O+1vkkFJHLKWT57Fw@mail.gmail.com>
Message-ID: <CAHk-=wiT0xehDuhtcut3PFeYnQW2H6Hx9O+1vkkFJHLKWT57Fw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/x86 changes for Linux 6.12
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Sept 2024 at 08:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Apologize for the late pull request; all the traveling made things a
> bit messy.  Also, we have a known regression here on ancient processors
> and will fix it next week.

Gaah. Don't leave it hanging like that. When somebody reports a
problem, I need to know if it's this known one.

I've pulled it, but you really need to add a pointer to "look, this is
the known one, we have a fix in the works"

             Linus

