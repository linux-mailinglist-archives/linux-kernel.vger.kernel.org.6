Return-Path: <linux-kernel+bounces-429401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63069E1B97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973EF283309
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840361E47C6;
	Tue,  3 Dec 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwHYLJkM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD78F6C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227349; cv=none; b=o7iGjCeinKW1yY1cUNYzLZekC57T86vvq3O5RSPs8YIjRrq4EMp6FzQL8mP/oxyRQjkdcJTUQddqhNestIn0+qjr6keWncIQIbEaKT7ci0V+XcZPCthmCZN2ndeFW11T0hVh70/8akjMcC2e7SQ1+z0V3UvqXBr0ibzIhbeShmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227349; c=relaxed/simple;
	bh=cYFvDCGsx9bEANm2Z/oDCpOTMA3AgsfZGUcgsiPXyvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TwnX1jC+rj87RoGQ38jSA6bca2fRz+0VaoU7i4/opQc3fGqDXItp3n9rWQVmYPwN9qMdEBM1Cy/W3BkCL6RbS62EgwmKQugks69qRr2//0f2FH9Bhq66tSq1GM9lFFOKPd2AjEEGwXR5Y4MSW2R2+7k0/wIM+cNjZ7YeHBDXa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwHYLJkM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733227346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uh3BjfKFpPpRrAA5lOBF7auSwsv3QwQnUXqCXfoS+DE=;
	b=AwHYLJkMfjyKtRecSdog9Yqw6oXntGJO4r2hkO5fEzRVWWtRy/AQGwW5VwSSxDkck5See6
	aan3x3JNx9otwZ52x6+iHXv3mc0JIkY7AKQLY3vVP0NXwz37U44CC8EnioluRKcXc6VnkM
	nzroO1chjwgl3lTsOl+g4grZjjDlJuw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-RkTg01XJMBGCNV3NOfzyRw-1; Tue, 03 Dec 2024 07:02:25 -0500
X-MC-Unique: RkTg01XJMBGCNV3NOfzyRw-1
X-Mimecast-MFC-AGG-ID: RkTg01XJMBGCNV3NOfzyRw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a467e970so38254375e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733227343; x=1733832143;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh3BjfKFpPpRrAA5lOBF7auSwsv3QwQnUXqCXfoS+DE=;
        b=PUYdMi6Sni4Txa4hKbgRHqiZwHF/nLEK5V0yuLF5frs04GDYe2s+JHiLTaWzfzyM61
         r8D+prJfpV8sJo+v4h9D62ygPIdeHbtoWzsXl7O0uXGrXF81WpseXRr5jfqQKXfJuS74
         z7yIujxOEMRiFaNNqheWCQZZ7JYtGTnDdtI5vxKn1NIiFU64456kHt7k+21Bh2bPwEQk
         L6e/58DJ6Y5fPAod6oNPW8iznYZ5Jfx6GnBWYDv76S++wQqGtGJFTMb0G5KLPUkDnMf8
         AMOQNNm2hgEdzSh16UTu9Mr0yBzYALj4hzn/O4t+Zgro8QmbZNyP4coSXlUKVC3yaOcg
         gyiA==
X-Gm-Message-State: AOJu0YxmR6IvCNpEOeLDduBUcw/hgEtHiX2iOyISwpYtL74NVbbRlAHv
	0LD5Gwc5D9e6WyGt/xPRp/YQ4w01mdLIasD5CNlf7Xukc//ZTmaKj2TegIEIZzvRR+unKd/xXYb
	wrLZnB3yUhw1ZYrBiZfNqoLi8OIpkJtvF536/aO+Pt+jmNcgLg0fj+BoF6/GDSQ==
X-Gm-Gg: ASbGncvZKsKMenla779SR1LP9DnR4AGOy6DmnxnNi2pgzb+EYNN2fLMMByPgxESQHfb
	2JRjdA97o93tyk8U9++XDVpUCWMxA/C8fjmZtRMlSbH9RZse1I+PDF/DMqw9jNGdBTAyVj51FEW
	OxluCwJ2HJ0HKb5RbfidTK9jQ/j5uKbTjQlJRo+xX62MFg9ewoPNvpaH3W2s9f19Hf1gtvw7fa5
	NsBJLR4PEK26L/ZboY+vr1MSOhTUlniXtgN4agKQUD91B8JRB1E/pDW4guJwAId6m6PvbkJHDLj
	9voZ1JahBvKXtHAbu88jWS5NMquAh5fEgTk=
X-Received: by 2002:a05:6000:2812:b0:385:f631:612 with SMTP id ffacd0b85a97d-385fd3f8f10mr1131486f8f.17.1733227342894;
        Tue, 03 Dec 2024 04:02:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8g1lgTk/qX3+5XRF05oGWihjt6rYlGQCZNRqXp6buxI1qfNSZLPtjGRwGY2p2+J1fktx0Eg==
X-Received: by 2002:a05:6000:2812:b0:385:f631:612 with SMTP id ffacd0b85a97d-385fd3f8f10mr1131463f8f.17.1733227342473;
        Tue, 03 Dec 2024 04:02:22 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e13e8eadsm11109928f8f.28.2024.12.03.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:02:21 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/3] objtool: Add noinstr validation for static
 branches/calls
In-Reply-To: <51fd13276df848dcb320bf7ff423f73364b06266.1732682344.git.jpoimboe@kernel.org>
References: <cover.1732682344.git.jpoimboe@kernel.org>
 <51fd13276df848dcb320bf7ff423f73364b06266.1732682344.git.jpoimboe@kernel.org>
Date: Tue, 03 Dec 2024 13:02:21 +0100
Message-ID: <xhsmhed2p560i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 26/11/24 20:47, Josh Poimboeuf wrote:
> @@ -3532,14 +3577,29 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
>       return false;
>  }
>
> +static char *static_call_name(struct symbol *func)
> +{
> +	return func->name + strlen("__SCT__");
> +}
> +
>  static int validate_call(struct objtool_file *file,
>                        struct instruction *insn,
>                        struct insn_state *state)
>  {
> -	if (state->noinstr && state->instr <= 0 &&
> -	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
> -		WARN_INSN(insn, "call to %s() leaves .noinstr.text section", call_dest_name(insn));
> -		return 1;
> +	if (state->noinstr && state->instr <= 0) {
> +		struct symbol *dest = insn_call_dest(insn);
> +

Interestingly only after I tried making __flush_tlb_all() noinstr did this
start causing a segfault due to a NULL dest. I added a NULL check here but
I wonder if I'm not just plastering over some other issue?

> +		if (dest->static_call_tramp) {
> +			if (!dest->noinstr_allowed) {
> +				WARN_INSN(insn, "%s: non-RO static call usage in noinstr",
> +					  static_call_name(dest));
> +			}
> +
> +		} else if (!noinstr_call_allowed(file, insn, dest)) {
> +			WARN_INSN(insn, "call to %s() leaves .noinstr.text section",
> +				  call_dest_name(insn));
> +			return 1;
> +		}
>       }
>
>       if (state->uaccess && !func_uaccess_safe(insn_call_dest(insn))) {


