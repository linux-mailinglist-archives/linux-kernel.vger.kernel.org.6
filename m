Return-Path: <linux-kernel+bounces-286408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0410E951A94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCAC1F21F40
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E681AED3E;
	Wed, 14 Aug 2024 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CSW5WiCU"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEA1AD40B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637390; cv=none; b=GfLe6R9W3HYIbe2kmd4/eqCXuFbFIKZSm6ue6lcfYjLE8tsI8r/Qy21TKOqNnjzcTFbiSWvq+WaRtm/o2B1/7+dGVmUcLVotQUsw4Jz1wI34QqVL8A67QSqwLAYzemzyHkS9Mr+4UdrLCmfR9cFWWTB0aYeYeYjkJ7bty8xREdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637390; c=relaxed/simple;
	bh=tn4995DAyVsJ3De0XVz7+XmF9zO0iObunLUXxBhv6F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUmYFFXU17JROYxYiIAykG7kIh43M7XA7KAyLsKHzgj85TJXsS3l6PKTuVvXKNLZ6224+nOOZhlmNy811BkweJLo9DnBjbZDgG3GGJSadTNXbqnEDewPRxkFRn3ik7HjUgHA3Rk8S+fH6dKQ2DeDwFywJE5OvTzty+iygSGfzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CSW5WiCU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so748384466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723637385; x=1724242185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8+OgZPrbcfevzxKpS5z7cjOxcrGutO4dpVagSt8VMo=;
        b=CSW5WiCUYPohFVsyMc3HNlRN7wjSwqp/gKFHAoBKDA8RIl/OzVVucDZhv/U7SZwt6p
         kWQ+x8wk5Me8NxAm9pWci1aE3FTmoElnmMEa6Wbnu3Dc4ov+bTLlAfZTcrsg7oTXT6sD
         QFkaYZDqBoJaD06ANS10A/d1SXkaMMYYz/7Fb7kHJdWt7tku7+HmArKidmQok6owf3X6
         /SQFVvYYIK0BAuMutDVDzKWLQ1GtxKOwaBN+e60fqPDYBHnnm3+Xj7l7mBQ2P0DfmJ1Z
         yZRb1b9WjY9Hh/pL8pgO2dPOiFDqzNNvvb6Yoc2fFGWS2eYHKNBQd2R0GTGX3LLTUMzq
         sfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637385; x=1724242185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8+OgZPrbcfevzxKpS5z7cjOxcrGutO4dpVagSt8VMo=;
        b=inL5vG44L90NDtCfzUd0zDSnPE24J72ZI/JoRbnabnWTUh9SJxUFJPkapeVCcvt2mL
         wJZK7ZRSXx3ImGkMUlV5WVmUkAvxcq78r54Vp7PzZLZWMFObVQokr7GDL7oL+G6/mgf0
         Ruq9q1M6AOWEF4dtu6SNVHCESyXsx6tj6JtBq66w6ru6/f12zdMS9DRYy6w9UVku2612
         YjUbi3nycd5MHbsE+qNbajDg2HHBxAsRcmvAgjgVXaKoRLAM2QDOdkNIa2hEpjydhNmk
         mRBFOhGWoGHbeURUtUqRcrkgGTyQFeOwnM1jATZM1qmTNK2Zx9mvWNbF42BEpm9x3Snz
         yU1w==
X-Forwarded-Encrypted: i=1; AJvYcCVT+iJEqSutSg/OensABiTv+qVQx1x9k/Fid5O50C/D3p6NX7oVFDk2vQX/O424NmG61I4kJM0MM3HZKdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38vcdAjX8AuElKycpv19TACOZmhnoRy7sJmruNvtkcx93xIdI
	xFUpx9vxNUMBGXKkEaFkkwRp/N81tezmc2Bikn2n5W+46dl6SseftWSzBcD8QzE=
X-Google-Smtp-Source: AGHT+IF/AQc5OsMsDO36uU4URAWXHfYH7FJV3YMENI/3lH9Cf+i/PLRvceCxirD4CDWV6m/Rt52jZQ==
X-Received: by 2002:a17:907:efe2:b0:a77:dcda:1fe1 with SMTP id a640c23a62f3a-a8366c32199mr159835466b.25.1723637385039;
        Wed, 14 Aug 2024 05:09:45 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa69c3sm165813266b.55.2024.08.14.05.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:09:44 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:09:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	nathan@kernel.org, morbo@google.com, justinstitt@google.com,
	mcgrof@kernel.org, thunder.leizhen@huawei.com, kees@kernel.org,
	kernel-team@meta.com, mmaurer@google.com, samitolvanen@google.com,
	mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/2] Fix kallsyms with CONFIG_LTO_CLANG
Message-ID: <ZryehvKuUogvtYhW@pathway.suse.cz>
References: <20240807220513.3100483-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807220513.3100483-1-song@kernel.org>

On Wed 2024-08-07 15:05:11, Song Liu wrote:
> With CONFIG_LTO_CLANG, the compiler/linker adds .llvm.<hash> suffix to
> local symbols to avoid duplications. Existing scripts/kallsyms sorts
> symbols without .llvm.<hash> suffix. However, this causes quite some
> issues later on. Some users of kallsyms, such as livepatch, have to match
> symbols exactly.
> 
> Address this by sorting full symbols at build time, and let kallsyms
> lookup APIs to match the symbols exactly.

The changes look good from the livepatching POV. For both patches,
feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com>

I made a quick glance over the code changes. They look sane. But I did
not check them deep enough to provide a valuable Reviewed-by ;-)

Best Regards,
Petr

