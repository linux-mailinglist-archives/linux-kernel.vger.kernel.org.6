Return-Path: <linux-kernel+bounces-253339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E41931FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6DE8B21508
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0B15E9B;
	Tue, 16 Jul 2024 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfxiQq/e"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467317550
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721104704; cv=none; b=cGAXmUNU6UDCO3GmXdjoRjiPUFh1WWDr0JRYA1soWtbp729DhOFyuaGbmwBe7d3lWJTDJbHswQ6DNo+ni7H0ym+OuDm657hTIjunHwInT+rO6oJ8Fxsr2ZE6nkq3ClIG9ipuAlRY3lwdTwwvxdsxWfZ0lwBkP9JlltUPAec5WlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721104704; c=relaxed/simple;
	bh=ztt71uxgqQGaS1jupaXZbcJdohblC5lD4CiMmk2sDXA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=J+SaWBdLY0jpZeefoCB+MUhie173WT+rGiTzk8vEZZYioGnlPeXy53GnbKCLBsflhNfob74kuSHiZcuSR4BMvoUHTXEAR6/MKAE5rg1ytqNvsCinWT7qAIEWIEfGtE5j1fYC7kQs3Mtx82I0BFtlvBUxfDmTlcvohO5UL37FOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JfxiQq/e; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-708bf659898so1454547a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721104702; x=1721709502; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6RYJet4RQukgf9/gOwGFhMgYHqkPIZETJ4In2JBN77A=;
        b=JfxiQq/ePZfOIHDc/unxOh7oIYbjtOkstFIgL+5EHn7neaF1S6EbbaDllOwV6wderG
         TMTaAWOqEhfat/dErD0DJEcOKE2tS57ydymXQCO9ri+MZ6IfQE9DTx8lEZrkbByGLIXL
         +m4UDDNSrq/lOKrz/xBAdQNs1bNK+gItI9SnDGT5IvTmsFLlYEOnBc2zBm3QFkeu0IAz
         7fKQGz+Ak1RRV6Zh7J5e4Ku6DlLcabeBjOYTN8HqtVQ0DDPu+YKodJ1ZE6nqifcRkXCf
         hpuRon3hGGal5pFbCsEXPBCjfMGMlG9q3qnYF/CgIdhEJ6yjseUbQhkiLU/FaeR1qiYD
         K4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721104702; x=1721709502;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RYJet4RQukgf9/gOwGFhMgYHqkPIZETJ4In2JBN77A=;
        b=H6o1czTbUGkSlu04+NBikA9wGQ18rdGHd1C1WPAumtQainy84i+qZDXzwxIK59kAio
         50R3HYImYEF2+UsgvVOD1h90vncC2YYs52jzrDws/vhHUyW4ilwmsiFuH1sKDUpCPscf
         YRYF0CAsZ8+3VEY60KWfKFkYLNuEqMfG4uda9Q0wE5ZA1LYsUnax9AL/8A+T8aINJhXr
         vaPP3bKbTIgbeWIrgW5bhie1X+WEeZaFr+riNjhstKhNHvqRRb+r9MNonlE1t6WOmsqd
         j1aTDAa+Yn1EKtt14tvhzvzzRJ8XOQTrfbHwHwyfTUQvvDTUxoaFY9CwYaiIV/aom27F
         ZnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaX5C1kgNOlN00razZL1pc/t2rRILTFrG+AOtPGOYUApjzORZsvumL4kvFxc1lDKoK9OOLJEzJihJuu5/HICmL45cAdxJqufZ6miFx
X-Gm-Message-State: AOJu0YzMLMprEdJ/NsTgVECVd/MwZ0k63rUMPvYUEFlbmj2TcVzDpGoJ
	3LicpMhPtkyEe+dGInexL7L53VLPnRgXOAR/AJBjNAH4hmT73xve62T/adaniEo=
X-Google-Smtp-Source: AGHT+IFuTBiSX/I/b8/1CrzFpy+eoFfX+Oe4M7y7ZGQlYD/Samet5CuV1ME9BquFP8D6J9TkXx2HIw==
X-Received: by 2002:a05:6830:6d16:b0:708:d84d:f628 with SMTP id 46e09a7af769-708d99bc4cbmr1446194a34.31.1721104701772;
        Mon, 15 Jul 2024 21:38:21 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:2914:689d:ed52:527])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7ff8csm5250315b3a.135.2024.07.15.21.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 21:38:21 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: broonie@kernel.org
Cc: Szabolcs.Nagy@arm.com,bp@alien8.de,brauner@kernel.org,bristot@redhat.com,bsegall@google.com,catalin.marinas@arm.com,dave.hansen@linux.intel.com,david@redhat.com,debug@rivosinc.com,dietmar.eggemann@arm.com,fweimer@redhat.com,hjl.tools@gmail.com,hpa@zytor.com,jannh@google.com,juri.lelli@redhat.com,kees@kernel.org,linux-api@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mgorman@suse.de,mingo@redhat.com,peterz@infradead.org,rick.p.edgecombe@intel.com,rostedt@goodmis.org,shuah@kernel.org,tglx@linutronix.de,vincent.guittot@linaro.org,vschneid@redhat.com,will@kernel.org,x86@kernel.org
Subject: Re: [PATCH RFT v6 3/9] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
In-Reply-To: <20240623-clone3-shadow-stack-v6-3-9ee7783b1fb9@kernel.org>
Date: Tue, 16 Jul 2024 01:38:18 -0300
Message-ID: <87ttgqt0hx.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello,

> diff --git a/mm/Kconfig b/mm/Kconfig
> index b4cb45255a54..45416916dec1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1249,6 +1249,12 @@ config IOMMU_MM_DATA
>  config EXECMEM
>  	bool
>  
> +config ARCH_HAS_USER_SHADOW_STACK
> +	bool
> +	help
> +	  The architecture has hardware support for userspace shadow call
> +          stacks (eg, x87 CET, arm64 GCS or RISC-V Zicfiss).

s/x87/x86/ ?

-- 
Thiago

