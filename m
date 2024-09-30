Return-Path: <linux-kernel+bounces-344473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B0E98AA24
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF3A1F241FB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F91195FF0;
	Mon, 30 Sep 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czbSTrIl"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45419925B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714602; cv=none; b=rIgzT+Fk2aWkAjS5KV7LeERDsTlZN9dqhXKi5RhuyRoG9AA8mflEdkKX7KVj8pm4j3TwNsqy/PASUwjx/Jgl3vHfQR7qfCmWOZQ39jEnvtJT7kT8pq/qujk5iUKoMsGxPhulqK7um2lAeKJWaPnWYuAEyJfsH0nQvNZGn0PpN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714602; c=relaxed/simple;
	bh=m1qbC/AvOhyEZrrIYOj0Qe2mKQAxepoFR3RJr+Hnc1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO/WKqcADN7Ss00bxj2QWlDH9Tsqs2vI3SVkJnocX43NXR3pbJTEIzT7XQVx2WHoKp7L9iOreVRu8OyxQnACxEdM8XspwkSj98PJktG1Gsty2qRLxfuIwYCKbuHNd0vjVypas0XOMXUje+FMs1Lq8Lq/dKUoqlZzOR87rnndm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czbSTrIl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53991d05416so1868445e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727714599; x=1728319399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsoudYHBDIwk3hP9Mb6c9UkWLKNWFBMDDV5+BgCAESM=;
        b=czbSTrIlnQV2NCl9rwoX6PisfWTnfnijXLOSGHntrYUJEjdBUkM1J7bAa9kyZpjdpp
         pAKf3llg5mnL97G7Pk2cQpSzZnpjcATQVBNfjLK0hPhO8sChnZ6aqJaGe0wUyTmFPyg1
         devZpz5NKNM4hdhc6YkYPuMYt0Qn9SpqZM+VO1rG/HCS4E7GC6dfmZpV+4Lcqdoj5lH6
         96CqECtPebV6HGvIi7RJfiBDfHVOyAnuof0H+6wCi+fK15ZcVw8Lc3TRZp4y8MNwsrT+
         p5wZwqtaYAR1vjDhVZKhyxqr0jh/DM19tK5BPvH7uO8K6IVolesnvWdD18HPG4hdrWue
         YE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714599; x=1728319399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsoudYHBDIwk3hP9Mb6c9UkWLKNWFBMDDV5+BgCAESM=;
        b=CJZWXVF+UbG3tb3aqr6H/heKHHSr6odPewo/WOh8bftLsEUTO7/QmUPFHqjKRp83VX
         JVxyX8+CGHmJ7WDnYd9PITWx0cwKCSy898/1Xcr8rtaAqEU4Ap22peZz8cpy7i/5tkv+
         11kF/noyfQ5nGt9NLW+FCDRAd7J4chzgck2b0nOiG4wiPjLKKbyny9N/Imxhno+b6t4X
         hly9VUohP6IPSMGAvAF80pt+onZoGGNdoNCdQFrpY7VDw7DRa81Qlm3XMsslbKaSHAhT
         krtyY6VCYmDAbUQbutVFhP6RZgrGPgSN1aeOtZ3wu9dSbdOcU39doN8hweJxS9QyIWiA
         0SHg==
X-Forwarded-Encrypted: i=1; AJvYcCUA1upcYkb2zi6griZ+QhLKH09vc7O5CLYvNa94Kxs4jfKHUlDHUuY98ZfaNJEZ7R3oAN4cYMQBhrolBiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/O476p3HBhOd6LgEtqMRdoLe3U2deOcDWE82H0ISEoohgJuOf
	WnO5OTqH5/GoolnosO5ERXZlj3xU3esWCmea9Qay9+MTB48u3SiF5KaU1cRS8DCH5ifTDzVtgAy
	HCIOonXizqrpZacbDIFOn03gIq44=
X-Google-Smtp-Source: AGHT+IF6Xrru1T/j53oS5NZzW+QOHch4IQf+2m2ycID4Y0g28m9qHaOvjNjOZGialOxJF3OMgvO+U9/ed6rY6XF788U=
X-Received: by 2002:a05:6512:238f:b0:538:9e36:7b6a with SMTP id
 2adb3069b0e04-5389fc4b91bmr8949797e87.32.1727714598379; Mon, 30 Sep 2024
 09:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927194856.096003183@infradead.org> <20240927194925.069013308@infradead.org>
 <CAADnVQ+BASJ7kcW4Kz_NsXM0U1+GrMHNVBOro8aO0-OyEry4Ww@mail.gmail.com>
 <20240930083026.GG5594@noisy.programming.kicks-ass.net> <20240930093302.GB33184@noisy.programming.kicks-ass.net>
In-Reply-To: <20240930093302.GB33184@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 09:43:06 -0700
Message-ID: <CAADnVQLbZRJyoF8yBZV3nnm8yQVeevQW0=stYv0HXBmZpY2BJw@mail.gmail.com>
Subject: Re: [PATCH 07/14] x86/ibt: Clean up is_endbr()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, X86 ML <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, alyssa.milburn@intel.com, 
	scott.d.constable@intel.com, Joao Moreira <joao@overdrivepizza.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:33=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
>
> Which then leads to me rewriting the proposed patch as...

...

> +__noendbr bool is_endbr(u32 *val)
> +{
> +       u32 endbr;
> +
> +       __get_kernel_nofault(&endbr, val, u32, Efault);
> +       return __is_endbr(endbr);
> +
> +Efault:
> +       return false;
> +}

That looks much better.

Acked-by: Alexei Starovoitov <ast@kernel.org>

