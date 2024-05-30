Return-Path: <linux-kernel+bounces-195395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CAB8D4C20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F10A1F258A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F6817CA00;
	Thu, 30 May 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQLubvqU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70117C9ED
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073825; cv=none; b=UtHvYunYaOEB9QJpMJklUqBLgPy4AYN6sMKvDL4HUDZMoRnbTiOPXYRy70Zss3fApSBhtmNiYzoSxoI+8PlEW3Y8P5O0FhI5cePGsEsxPTWkLAhaZPAIfDjdNo8D8uU6s8teuIj+R6seG1e0g8pNp0tGap8WJc+ouONCEUMD44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073825; c=relaxed/simple;
	bh=YMGcqOtfPUuuo0aMHy8+IRM5k9KSKl5qDaFTBQs6RHU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lqhseXXBIJYQFyAVQLOIkJldXUJoabJqRFPwztYoQGmMYeKhrN61Ra34M4JWsjHJQ3eJDx8U0bkDTeOJ6Ukitq28FEspbLU9thDg1cRKamnj52xmfFdM6Z4lJ6tA4Lfmutjz3976mvL5hMUM13Yr5yuIKy4coXRXyQf5n5+TIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQLubvqU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717073822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie5cTxWDzvUrmyoDghxxyr8zLKBNnNTe7unZRSQk2Y8=;
	b=bQLubvqUpG2sfC7/F50KhoanJbXtTuK7tg5lNCu6/fsVw+Kwwvjx5BUIW6fPjvCF7inQcL
	yZ9aGwQyEpjfQvurZ2d79eYyzQ1TxsKKQ6NdFco0Ayqyp5UZXAJG7YvovKLE12g4uG0sH0
	g95RwW7xMOmQrpXWq1pOdziR7nKMC/4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-FMxwd0wEMVmmUdxLgIbElw-1; Thu, 30 May 2024 08:57:01 -0400
X-MC-Unique: FMxwd0wEMVmmUdxLgIbElw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-df789a425d3so1357017276.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717073820; x=1717678620;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie5cTxWDzvUrmyoDghxxyr8zLKBNnNTe7unZRSQk2Y8=;
        b=qHMV2TUDZl8UJYhyviVZewVOJKvpyR3tIS3+hpJkCLST1RmAXgg3MzivTBG3mVoBZy
         TS1MINTdlkCz/OiQyKH44ujqA/6srDEzXzhTSe8UF+WF5aHbAbOArTndtaEz7s9IC4zv
         IuL1Lg3kxZTCcfITVd2n2AiNboOUSdL8kY36Xy07m9ibBZhrmKptnTdDwDBeJZSlI7Xo
         L+NDTuWaT8DMNteIpIVsPBgMrdGMVg23yrM0HHdo+YUmdWud98b+5mYBIIuwGwWKOhcJ
         8XGPZJw5gEBjvyCxS0dQ30gzHO3/v5R4IZeFv2mqj25bAPfZ85pMbXy0FM39sCiCEYe1
         BUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcehzER/aw6mlVrv7PhZodIqHzMRB06nsA/nF8lpYIDHLYMkf5pVDVxlCL4Tj3gR7Pj2C50eFw3BtxfcMkbmfwzd9jxMfy+SdRYUoG
X-Gm-Message-State: AOJu0YwazncXdZq9F6OTKTTNELVQhV/4qnQLHNF42T1tDvIyEMuVbeQy
	Yw13CziRFvodEEBI0+m4L+cp0YEuzcHdufBOxrr+Ps7IctPQP9jyWAi33UbNuXb/iZ9yYDZCb0z
	GnxFVXz8ZiKXjjttlWjSJa4QBm+Fbtt8lc1SbrdS1Niz9J24I5gB+XuazDXHSkg==
X-Received: by 2002:a25:df09:0:b0:dfa:4a7c:b2d6 with SMTP id 3f1490d57ef6-dfa5a691bacmr2239081276.50.1717073820547;
        Thu, 30 May 2024 05:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9KZIOqNoQCsuXeSJgrcwqLo+LmsrradN5KC0DYO6sSQwd8uhaaGgvVxwa3u6znLX+lMGayg==
X-Received: by 2002:a25:df09:0:b0:dfa:4a7c:b2d6 with SMTP id 3f1490d57ef6-dfa5a691bacmr2239052276.50.1717073819927;
        Thu, 30 May 2024 05:56:59 -0700 (PDT)
Received: from rh (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd302cbsm552930185a.102.2024.05.30.05.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:56:59 -0700 (PDT)
Date: Thu, 30 May 2024 14:56:53 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
    Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 3/6] KVM: arm64: add emulation for CTR_EL0 register
In-Reply-To: <312fd3cf-2eb9-4a38-8c50-e3b7639c3cbc@redhat.com>
Message-ID: <c62a1fd5-54e6-4727-d457-1b2d19b0af35@redhat.com>
References: <20240514072252.5657-1-sebott@redhat.com> <20240514072252.5657-4-sebott@redhat.com> <312fd3cf-2eb9-4a38-8c50-e3b7639c3cbc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hej Eric,

On Wed, 29 May 2024, Eric Auger wrote:
> On 5/14/24 09:22, Sebastian Ott wrote:
>> +static int validate_clidr_el1(u64 clidr_el1, u64 ctr_el0)
>> +{
>> +	u64 idc = !CLIDR_LOC(clidr_el1) ||
>> +		  (!CLIDR_LOUIS(clidr_el1) && !CLIDR_LOUU(clidr_el1));
> This actually computes:
> CLIDR_EL1.LoC == 0b000 or (CLIDR_EL1.LoUIS == 0b000 &&
> CLIDR_EL1.LoUU == 0b000)
>
> refering to ARM ARM
> Terminology for Clean, Invalidate, and Clean and Invalidate instructions
>
> 1) If the LoC field value is 0x0, this means that no levels of cache
> need to cleaned or invalidated
> when cleaning or invalidating to the Point of Coherency.
>
> 2) If the LoUU field value is 0x0, this means that no levels of data
> cache need to be cleaned or
> invalidated when cleaning or invalidating to the Point of Unification.
>
> 3) If the LoUIS field value is 0x0, this means that no levels of data or
> unified cache need to
> cleaned or invalidated when cleaning or invalidating to the Point of
> Unification for the Inner Shareable shareability domain.
>
> so to me if above computation is true this means who have no level of
> cache to take care of, so although CTR_EL0.IDC = 0 would normally mean
> you must "Data cache clean to the Point of Unification" that is not
> needed in that case.
>
> But the spec does not really state that IDC=0 and
> no_level_of_cache_to_clean_inv are incompatible as far as I see

This is just existing code moved to a helper..

>> +	if ((clidr_el1 & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))> +		return -EINVAL;
>
> Isn't (clidr_el1 & CLIDR_EL1_RES0) already checked by
>
>        { SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
>          .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
>

Nope, that would only be the case when arm64_check_features()
is used (by having set_id_reg() for the .set_user callback).

>> +static int validate_cache_top(struct kvm_vcpu *vcpu, u64 ctr_el0)
> s/top/topology?

Hm, that name is already quiet long.

>> +{
>> +	const struct sys_reg_desc *clidr_el1;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	clidr_el1 = get_sys_reg_desc(SYS_CLIDR_EL1);
>> +	if (!clidr_el1)
>> +		return -ENOENT;
>> +
>> +	ret = validate_clidr_el1(__vcpu_sys_reg(vcpu, clidr_el1->reg), ctr_el0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!vcpu->arch.ccsidr)
>> +		return 0;
>> +
> worth to add a comment about what this does as this is not
> straighforward ;-)

Hm, "check for validity of the cache topology" - that's kinda the
functions name, so no added value. "Make sure the cache line size
per level obeys the minimum cache line setting" - would this help?
Can't think of smth else right now, sry. Suggestions?

>> +	for (i = 0; i < CSSELR_MAX; i++) {
>> +		if ((FIELD_GET(CCSIDR_EL1_LineSize, get_ccsidr(vcpu, i)) + 4)
> maybe use a local variable such as log2_cache_bytes
>> +		    < __get_min_cache_line_size(ctr_el0, i & CSSELR_EL1_InD))
> I don't get i & CSSELR_EL1_InD, please can you explain?

It flags the cache at this level as a data or instruction cache (see also
get_ccsidr()).

>> +static int set_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>> +		   u64 val)
>> +{
> don't you need to take the config_lock earlier as in set_id_reg()? isn't
> it racy versus has_ran_once?

I was about to write that this is not the case since that's an rcu
accessed pointer not guarded by the config lock but I confused this
with the vcpu_has_run_once() .... again :-(

I'm not a 100% sure we really need that but I'll just move the lock up -
it definitely doesn't hurt.

>> +	u64 ctr = vcpu->kvm->arch.ctr_el0;
>> +	u64 writable_mask = rd->val;
>> +	int ret;
>> +
>> +	if (val == ctr)
>> +		return 0;
>> +
>> +	if (kvm_vm_has_ran_once(vcpu->kvm))> +		return -EBUSY;> +
>> +	if ((ctr & ~writable_mask) != (val & ~writable_mask))
>> +		return -EINVAL;
>> +
>> +	if (((ctr & CTR_EL0_DIC_MASK) < (val & CTR_EL0_DIC_MASK)) ||
>> +	    ((ctr & CTR_EL0_IDC_MASK) < (val & CTR_EL0_IDC_MASK)) ||
>> +	    ((ctr & CTR_EL0_DminLine_MASK) < (val & CTR_EL0_DminLine_MASK)) ||
>> +	    ((ctr & CTR_EL0_IminLine_MASK) < (val & CTR_EL0_IminLine_MASK))) {
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&vcpu->kvm->arch.config_lock);
>> +	ret = validate_cache_top(vcpu, val);
>> +	if (ret) {
>> +		mutex_unlock(&vcpu->kvm->arch.config_lock);
>> +		return ret;
> nit use a goto out

Thanks,
Sebastian


