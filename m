Return-Path: <linux-kernel+bounces-269239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36AD942FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B021C213EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EA91B0113;
	Wed, 31 Jul 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RHfq1sSf"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59211AC44A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430946; cv=none; b=pA1u6Dd7DsPHdQ5ctuRY/eBfMVNTFJuxEwQ4Cl0rtJMActlNeri3/al9xrT6ARBj1mpRaPaB53o+c711nsA7n5SECdf12KCyMurxB1mc7jj9PvPJWp7SrZ35GWlvfDtUHrSEdl6AxGVX+X5yvAH+BFCoDxCq1ztlhA7j6dk3z7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430946; c=relaxed/simple;
	bh=Oc/Jyw/3l7deURsx6ObtrQRzh4lRxYVwTUMPci4xYCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI3EpKFpvwNyUNrhVSV5SQEyI/mnJVRowxNeYvhzPlwFYWFXKKRcjdEW/Oq/QHQH/6yafqoeUQ2Yc5/I780VP0qaTIvJUk9Md1ZgzsKphBJOhxm4yzBpzER/57C5htj9xEysiKhWMHDak+JkxTgzRDg5TvwQdcJtNgyvOgywRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RHfq1sSf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so237952766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722430943; x=1723035743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4BG3zNMbEJddgXJUjT4WgeflBAopL+8wuEX/aqqwoo=;
        b=RHfq1sSfn5gzOiu/LAufCcf2eUf9jPYGgwLQxpKbVS+MleAC+zAoGmciFO7yitdtuS
         8SiH0rs4qsnYBS5wrZHrKivlb1zYgceeniEpcs4IBOum7XAmwvhanOGYCUV7lWYLqzLn
         CzRAt8jcNOSm9NUn8uc8f3m9TUNY6b4oR+nQ3gC0QpRPSzBUuDJyQw3ekxA9ZLbuzJfm
         NLmtVB2zeOIVH34cgRbRQJ86jyZJ50BmkYD728MeCO8+TQ/BeqWiD0VT7KGtggNawkX4
         Czrr5pkrU2tde9ih9naGZ09Mr6m41svjiIPYwglCvb3ezlQoL11VWyhXdnzRsDXLrY85
         bOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722430943; x=1723035743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4BG3zNMbEJddgXJUjT4WgeflBAopL+8wuEX/aqqwoo=;
        b=idk8RxgKkhtPXRrEBbcOucw5Qh+pmFh0mGJsaXSR3Mc7iie55L0iJg/PdMMoXzffVE
         YwVM8FVLEbVwLSLA9ndLuQ1ew4+8AwZ8mhK2hknHPmsajdUeY6kOaUcn4D4VZgafzGmi
         EwWIdJ4tH/Uw0FEpc6OuLhOL2kNl0J29syFgb1s7p11BbudnvD0o+mv3atDhk5DTgTYt
         96OtAteFDsMwm1+4+utvXIbH7Ly5I8TeCwCBGMHJD+qWGsduLdo9E0Z6XUiwG0iFVc+q
         0uaWohcgGTm/kyjdx49MeXL2DlR0irL5qOiejnIHlT4A3ctGahwq3S0aiZXIXjZ9PQAX
         pXeA==
X-Gm-Message-State: AOJu0YxvKDBFnO7K6w2F8gmQuZwQF6RZeXKJauCu9kFxF9qlkhWotyMK
	VcBNdiDE+QuOAoctDOBZMusuihPhIOaZ/3y0gHyfc18GNQWDUUfgE/Izp/5UF3g=
X-Google-Smtp-Source: AGHT+IF0fgoz2Gx9ngVoTxdE7ITgBxCT7yFBbjFXW4blK/j6htLAn+5mcOYFNvkvjg/C1yVczMqIZA==
X-Received: by 2002:a17:907:3f1e:b0:a7a:bb54:c852 with SMTP id a640c23a62f3a-a7d401863e0mr1018612766b.61.1722430942870;
        Wed, 31 Jul 2024 06:02:22 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236eesm763733666b.22.2024.07.31.06.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 06:02:22 -0700 (PDT)
Message-ID: <5f3b4573-daa3-47b4-a7d5-b3e05fc5b79e@suse.com>
Date: Wed, 31 Jul 2024 16:02:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Rework mce_setup()
To: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com
References: <20240730182958.4117158-1-yazen.ghannam@amd.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240730182958.4117158-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30.07.24 г. 21:29 ч., Yazen Ghannam wrote:
> Hi all,
> 
> This revision drops the topology export idea from v2. It seemed to add
> more complexity than just doing a local search.
> 
> Thanks,
> Yazen
> 
> Link:
> https://lkml.kernel.org/r/20240624212008.663832-1-yazen.ghannam@amd.com
> 
> Yazen Ghannam (3):
>    x86/mce: Rename mce_setup() to mce_prep_record()
>    x86/mce: Define mce_prep_record() helpers for common and per-CPU
>      fields
>    x86/mce: Use mce_prep_record() helpers for
>      apei_smca_report_x86_error()
> 
>   arch/x86/include/asm/mce.h         |  2 +-
>   arch/x86/kernel/cpu/mce/amd.c      |  2 +-
>   arch/x86/kernel/cpu/mce/apei.c     | 18 +++++++-------
>   arch/x86/kernel/cpu/mce/core.c     | 38 ++++++++++++++++++++----------
>   arch/x86/kernel/cpu/mce/internal.h |  2 ++
>   5 files changed, 38 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 1cd27e88888d54de5fefbeb0b44c26194ffa83ce


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

