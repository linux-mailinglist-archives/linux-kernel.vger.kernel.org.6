Return-Path: <linux-kernel+bounces-178906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82D8C5952
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1F51C21EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B21802AA;
	Tue, 14 May 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oSYLkKnE"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA817F370
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702740; cv=none; b=GspP5TikoCUcwsUynNg03YOJks64rB9gPWHndRIFgNm7t1mKiBffHnhml1AoU1ScEQaw9ATxG1Ya+rAeRX78YR1I2eFLi/TRpAm+BjGyqy1JDoDUbUwuG9mO6buFHDnGOjgZpXO5N1uh26OqMCvSoXYrBVPsC8pEFE8agb/1mpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702740; c=relaxed/simple;
	bh=hLYpzcxGm24wBNcj3TBbz1d4cmvEZCPvDGA2meO1iLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRj8y5xdEcX2sF84CdDgK/qw3rH7YkxbINEl8wbylH1q5do3ONtOT0hJ0C6lKmIAO9qGiUi9W029ZC1p1owueAaviQEangO9yj/63aDMjKJ3laKWHs1OVSH61HOH7oOu9CdTzmjUUdIhflynlL9U89ul6OzaTs6StitwxdUu8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oSYLkKnE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso4664628a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715702739; x=1716307539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hLYpzcxGm24wBNcj3TBbz1d4cmvEZCPvDGA2meO1iLY=;
        b=oSYLkKnEjs4owzHCt1bnwht/7oUeabeVWw0rRO17H/m0obHAEab0F5VHpWx5AUm0dw
         IrD8/SuWsZ2cq0FeR4mvawmKRMDEyfeTHKsMuhumy6AvuM/kwGUPgzSetRwaK4BuEOXf
         NndwDm6mdPhrXP1XWa5TQmGs9E1CWczp7zRzzuELLfT2vmpWZZNv+W85WUVb3UPEe9JJ
         4m7crweJ5MSQnaz8TFlT2vHS7Q61L0XrSHe62HToeByuH+arDCY2hnwTNw5j89OphKcQ
         nNtYsgouaE0et2lTeKkkUsKqElhydU9ixE4A2I9m3io7ytgcnGLphOrOoY/yy9cErTRB
         NT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702739; x=1716307539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLYpzcxGm24wBNcj3TBbz1d4cmvEZCPvDGA2meO1iLY=;
        b=tCiokaJgRugbyQ4cI42VKDHu3chuCF0SHTgMJkrt7BKEYWHfT3TM4ZO214A/6ExZXr
         th1leerCK1ik4PMujar4VswPeI9fMXBmCOosOJfi6HWmHML1sTPrj3hXHlC6ph2llhg2
         La+/+lg3pVDaaevLIyjJXbbQGyMemXTF/2vTnPoreQyItTIqaCOjXnVaICgfJdrBC89/
         GaqKletQYMMC/Wr36c+2bxC6GqpK4sSrFxxave9i+q6tM4mbfAVSJfVLUtiglPDkLK+i
         5AlL79gs+R2LkVOqlJ/oAynPWyz1/JGy3qpPCl0zf4kRIFKrQepP7VKDRSzgMT3IMvkn
         xi7g==
X-Forwarded-Encrypted: i=1; AJvYcCWvF7ttOpRdZ+4VuB9WL8yHZxtQt0F29i7s/kFwF7DK/co3imkHrc4mDhi9++dmWMrpjPmxonRJ2DwRh5BZD8vR4EzYNEdj8C5fVtky
X-Gm-Message-State: AOJu0YwcI3JcJDdXP5gax9BDY4kyChpm2PG4N2Lva3At0T7Jj0nq3k/U
	DXnFjhYqd8mbJmx6Cko6wd+T7G1XxC5W1AhPhxz5kCXe+CssWXCTZu0AEOKLA+lbJoYNspCQ6Kb
	I
X-Google-Smtp-Source: AGHT+IExT0Lpton62tmUoqhHHjwgEPqRSbd+czbDp3DyV4MKZCvZWeoGNi2mbvNDBuZ7uGZamR5c7Q==
X-Received: by 2002:a17:90a:51a2:b0:2b4:329e:e373 with SMTP id 98e67ed59e1d1-2b6cc45030bmr13858119a91.6.1715702737681;
        Tue, 14 May 2024 09:05:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886b669sm11734330a91.24.2024.05.14.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 09:05:37 -0700 (PDT)
Date: Tue, 14 May 2024 09:05:35 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, Ved Shanbhogue <ved@rivosinc.com>
Subject: Re: [RFC PATCH 6/7] riscv: kvm: add SBI FWFT support for
 SBI_FWFT_DOUBLE_TRAP_ENABLE
Message-ID: <ZkOLz0ANkESSv5qr@debug.ba.rivosinc.com>
References: <20240418142701.1493091-1-cleger@rivosinc.com>
 <20240418142701.1493091-7-cleger@rivosinc.com>
 <ZixSFLZYZaf8BKHP@debug.ba.rivosinc.com>
 <c8e4c44d-8125-417e-8c61-a1f6d438815e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8e4c44d-8125-417e-8c61-a1f6d438815e@rivosinc.com>

On Tue, May 14, 2024 at 11:43:15AM +0200, Clément Léger wrote:
>
>
>On 27/04/2024 03:17, Deepak Gupta wrote:
>> On Thu, Apr 18, 2024 at 04:26:45PM +0200, Clément Léger wrote:
>>> Add support in KVM SBI FWFT extension to allow VS-mode to request double
>>> trap enabling. Double traps can then be generated by VS-mode, allowing
>>> M-mode to redirect them to S-mode.
>>>
>>
>>> +
>>> +    if (value)
>>> +        csr_set(CSR_HENVCFG_DBLTRP, DBLTRP_DTE);
>>> +    else
>>> +        csr_clear(CSR_HENVCFG_DBLTRP, DBLTRP_DTE);
>>
>> I think vcpu->arch.cfg has `henvcfg` field. Can we reflect it there as
>> well so that current
>> `henvcfg` copy in vcpu arch specifci config is consistent? Otherwise
>> it'll be lost when vCPU
>> is scheduled out and later scheduled back in (on vcpu load)
>
>henvcfg is restored when loading the vpcu (kvm_arch_vcpu_load()) and
>saved when the CPU is put (kvm_arch_vcpu_put()). But I just saw that
>this change is included in the next patch. Should have been this one ,
>I'll fix that.
>
>
>>
>> Furthermore, lets not do feature specific alias names for CSR.
>>
>> Instead let's keep consistent 64bit image of henvcfg in vcpu->arch.cfg.
>>
>> And whenever it's time to pick up the setting, pick up logic either
>> perform the writes in
>> henvcfg. And if required it'll perform henvcfgh too (as
>> `kvm_arch_vcpu_load` already does)
>
>I don't have a strong opinion on that point so if you think it really is
>better, I'll switch to that.

Thanks.

>
>Thanks,
>
>Clément
>
>>
>>> +
>>> +    return SBI_SUCCESS;
>>> +}
>>> +
>>> +static int kvm_sbi_fwft_get_double_trap(struct kvm_vcpu *vcpu,
>>> +                    struct kvm_sbi_fwft_config *conf,
>>> +                    unsigned long *value)
>>> +{
>>> +    if (!riscv_double_trap_enabled())
>>> +        return SBI_ERR_NOT_SUPPORTED;
>>> +
>>> +    *value = (csr_read(CSR_HENVCFG_DBLTRP) & DBLTRP_DTE) != 0;
>>> +
>>> +    return SBI_SUCCESS;
>>> +}
>>> +
>>> static struct kvm_sbi_fwft_config *
>>> kvm_sbi_fwft_get_config(struct kvm_vcpu *vcpu, enum sbi_fwft_feature_t
>>> feature)
>>> {
>>> @@ -111,6 +147,11 @@ static const struct kvm_sbi_fwft_feature
>>> features[] = {
>>>         .id = SBI_FWFT_MISALIGNED_DELEG,
>>>         .set = kvm_sbi_fwft_set_misaligned_delegation,
>>>         .get = kvm_sbi_fwft_get_misaligned_delegation,
>>> +    },
>>> +    {
>>> +        .id = SBI_FWFT_DOUBLE_TRAP_ENABLE,
>>> +        .set = kvm_sbi_fwft_set_double_trap,
>>> +        .get = kvm_sbi_fwft_get_double_trap,
>>>     }
>>> };
>>>
>>> -- 
>>> 2.43.0
>>>
>>>

