Return-Path: <linux-kernel+bounces-576268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13038A70D14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D9F189D4D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54BF26A0D5;
	Tue, 25 Mar 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQhYK1hd"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74C426A0BD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942427; cv=none; b=l8Jc9AxahTMx4fO3qknduTLGmXe/xY6JHKb7kEcsPJLIfKStzpSqCgkova/cRjt6l0HWIDgfQPit7WFDuSd7DZqxkjyEre1wE8sNB//gr0+3kC+H7TfVTiaZMGa/XtB/cj4E/bFnzPeQzXF081PXnhgMcfs6jGrsdD5/84tvtcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942427; c=relaxed/simple;
	bh=pQ4UoyDlpkHuiZgOcYbiP4Xig7yGzQ3Q2/+D3ehiXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmucd1QU/yesErwkkPzpiT71mk6EVq4MvlX1mZ5bWBIoSXNgyXfazDM2PoP7VMsaouHgAcui6rhPq5vq1AtQJBbad5dqG5/gR54adrqDmG5vWbXJKUylp02zsAeepjNpcVzW9b1y5cAPYBA6kfhi5OaIrVYAndqbBrv2OVcx+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GQhYK1hd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso11280647a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742942425; x=1743547225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ0mQOw62tpJtHtq3bDP+LhjKb7VU3twZUif4e7fNdo=;
        b=GQhYK1hdsQPc38IdJ6AIvyattcUJJLw0K6nefnDPT46rZvc/BQs5h3hF377S31XDhK
         3KxXg8htAQA1HPmJufoEETmGqsFahje/CjWGlEbF4b/fDpuKuDmG1pbmxk6XsG0vP9Bb
         CU5VaaihLJgMKAFvhoL9BnTJAawhZOR5+Kd5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742942425; x=1743547225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ0mQOw62tpJtHtq3bDP+LhjKb7VU3twZUif4e7fNdo=;
        b=qeAhwbe7KL4xNMISiz2vDY3jqrnxoeLntc+3+RzRe1as8qrF8kEMoFTdRkezHbLDnP
         6pETF23Cs/LjWB1lZKPJbJtyG/cNkbkrcr7Ry8aLYWQeItlnl5ksdJg05n5PvyHd3iWk
         YhFIxPhayXxpgvt6C9qEmtcQ6iIudh7wqg9PdkZzO1rgmf7E+V3jSGSuu4zrpOznl25A
         IfyjIOptJ1ZAvQXlV5/atVqiXkOGTanJXVM3ZZTBfb60JgV9VUr+rifUy5wyiTNJ8t9J
         owusvlRwh/eA4KUs+j9RCntYXDA/fnaOn5KNEnpppvM9SCtM5l87zIV619wlh/vwjzwa
         G0zA==
X-Forwarded-Encrypted: i=1; AJvYcCW8nY35vWLvfMXTcfky/JcUt/ji1/ONcNJXk2x8rjgSoQgqb3pYYPmS0hfMcAUf/Mj67JpthpTVteOpv4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzClgJsoT9nJ3DOoC78PRyNIRzD3qU3ca4TNpzie/oF53KGUqHI
	NURnzCBBbNMo+Lvyejxry7BNF1ngHSs9YXfB7dwz1UWOfcMDWKrpK2W2OoLXrpynI4xNNfRZ9RI
	=
X-Gm-Gg: ASbGncuVoJ7HWoT2WOWl+VKkjDfa8n/wbZ/pJkv0tC51myIZ82OtDqozKnWCVsh7EeX
	lywyfw/jUv2ej2d633YZPHyxdqW1FwPnZDSRQ5BAw6tck8s+mTKexmlQDK2qNoMEUWhTYScQL91
	roptmO2zLxmtmBNkD8B7vFSb2iiJPpcF7hlA0PTfsaLdroESCDhvlA23SCZ2pyMtj4KLIYhm47P
	2HdvJFojk+NC1OcNHfijZPyvr6QMYp5Z9Arf3RteLx9TqqfUyLljllG8WuNUtmdcdmLLlyrjNLI
	2Df9oyiUuF64OHo4J2mcTRDjo1+po109uHJ7EMiPTXw9cdslYg9BiUkAChlmASVuExcrMBhHoUa
	+kzRHd74=
X-Google-Smtp-Source: AGHT+IFnMbdSPWJg/PZpthIfsM4Byyr22hmvQEezyxPZc4t6JJRig3bNhZIvvWZylXPImyBG3wYAXA==
X-Received: by 2002:a17:90b:4d07:b0:2ff:69d4:6fe2 with SMTP id 98e67ed59e1d1-3030fe9c932mr32753804a91.16.1742942424766;
        Tue, 25 Mar 2025 15:40:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b885:47c3:6268:77fb])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301bf61b525sm14937020a91.35.2025.03.25.15.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:40:24 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:40:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: Kees Cook <kees@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Allison Randal <allison@lohutok.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Add __nonstring annotations for
 unterminated strings
Message-ID: <Z-Mw1gvbkBQ1fZ7y@google.com>
References: <20250310222332.work.202-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310222332.work.202-kees@kernel.org>

On Mon, Mar 10, 2025 at 03:23:32PM -0700, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Francesco Dolcini <francesco@dolcini.it>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

This code is kinda weird, because only 2 bytes actually end up used, and
yet we explicitly initialize it with 3 non-NUL bytes.

This solutions seems fine though, as it is indeed not a C string and
does not desire nor rely on a NUL byte:

Acked-by: Brian Norris <briannorris@chromium.org>

Looks like Johannes already applied it anyway.

