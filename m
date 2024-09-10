Return-Path: <linux-kernel+bounces-323540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FDB973F05
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DF01F21A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82CF1AED43;
	Tue, 10 Sep 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Id7aDcAY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F31A3BB8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988528; cv=none; b=GzEiZijbe2225wTdl9IDHQQAAFHqXldUZ4cEpu+qgcktg3xc9mJkL3WbGCb51GGUXl6VK3c3dL61jwuVTX9Xa6x4xOwcGMArw6g8w9U4lbwsWZUrnTPJFII4BYZd3N0PFCkLhNDXXO0Usm/KST3ycBRim0YIQviAUBk1pOGRcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988528; c=relaxed/simple;
	bh=XFPw4yEHmK4Uj+n0pqWuMAmjYZ3OQyW2kdeqzb+wy1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkIBZroW8DtpcgyGoao0oZE44l1eHDdS90u6goeWUnyaG3MsQw8Wi2SxsnsbWsCXzosHojHdR+J+ABbartaD5Bco1kF81EYdNiH8HYwx5cNL68UyRRbB1QEWBNShnaMenRrvTIrFexwUpvEz4QyMRoGUrC8nYuS63x3t1oPgxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Id7aDcAY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725988520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=USNHgAWTu7Xz/dUY/5bkNTj1kC3g7jbwqT+OELqU7Dc=;
	b=Id7aDcAYgQ8h5KPhb6GqtSX9Z/t8EPQilr+ucDhkU5AVhmH5saKFuOAne9bGxkKKfbSnBQ
	oUnLsTiETRKUbCjNDuukBufnIH/hXEss47tvUhIyWC5K5vGXnpqqIjBCXTR3/cF0W4iAsT
	6lOaiIstFavQD8N/ZZKHHVutjaYshHI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-m7SRgha1P4W_lk2JkEZFYg-1; Tue, 10 Sep 2024 13:15:17 -0400
X-MC-Unique: m7SRgha1P4W_lk2JkEZFYg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb22d396cso25343545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988516; x=1726593316;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USNHgAWTu7Xz/dUY/5bkNTj1kC3g7jbwqT+OELqU7Dc=;
        b=ZYHoXkq95eR1guRPDB0zD905elk+NnNKS9A7BL3KtzwmmPGLzjaVtMm/6vWA7dlCku
         IicnnfCZn+ApwJfBU/7zbZrb9/rY7V1s6tXKzFrElaFH7IIKJRPuSqI3uzCNp9SKZprs
         S7WxhFLFkl4tpQProLuVPqgciwBe/+nl3m1nog5ORsXDxLAXnO+gM+ejxLmiDpNTERGG
         MKgvM8AICoJeZeAzWVtPo4KhQsGvQHpogRdlTvtBUKRQ+M6ITkr6IWkBFCatn5nb1FSo
         rNKvin6KKPDep2IabmeI3y5n+q/vrwCsK/c9dtD9tDP/c1xfNXeaSkGnGzKL+JyOo3ph
         1zzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUA+DfbPKPB//PUuVnKggiSfAULSLtWzjfc4Ju46uohxu0vDD3hpwuAbKu/7ssTCjMNPgV0EQ3BQwfAMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwISjkx0bpd7Bf1hQZ6BB7mjHHGpBxHrjyn0+pV2N59DzL9pMfF
	vbl0lxJbt/pggnopsBTJvL7aKA7J3xtViEtqkkyEXr+jtj7+qBJw9CTo9ILvfPVR3GTKn43aYwq
	AILJyEvJncRy5p3NaPLhQNYZhcPJg/+oiEhdinRrkBXhXLJUV06ssTOCCmPPSdA==
X-Received: by 2002:a05:600c:358a:b0:42c:ba1f:5482 with SMTP id 5b1f17b1804b1-42cba1f598fmr45156705e9.35.1725988515944;
        Tue, 10 Sep 2024 10:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECXXwCUHaWoTl/1CJaefS9Qy2T+MFosNsOAumT3kcXW2Zq1atmXfCBm7JIbbwUJ75y4Z2WHw==
X-Received: by 2002:a05:600c:358a:b0:42c:ba1f:5482 with SMTP id 5b1f17b1804b1-42cba1f598fmr45156495e9.35.1725988515441;
        Tue, 10 Sep 2024 10:15:15 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42caeb81ac0sm120131165e9.34.2024.09.10.10.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:15:13 -0700 (PDT)
Message-ID: <b3a46758-b0ac-4136-934b-ec38fc845eeb@redhat.com>
Date: Tue, 10 Sep 2024 19:15:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] KVM: TDX: Initialize KVM supported capabilities
 when module setup
To: Tony Lindgren <tony.lindgren@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org, kai.huang@intel.com, isaku.yamahata@gmail.com,
 xiaoyao.li@intel.com, linux-kernel@vger.kernel.org
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-11-rick.p.edgecombe@intel.com>
 <b8ed694f-3ab1-453c-b14b-25113defbdb6@suse.com>
 <Zs_-YqQ-9MUAEubx@tlindgre-MOBL1>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Zs_-YqQ-9MUAEubx@tlindgre-MOBL1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 06:51, Tony Lindgren wrote:
>> nit: Since there are other similarly named functions that come later how
>> about rename this to init_kvm_tdx_caps, so that it's clear that the
>> functions that are executed ones are prefixed with "init_" and those that
>> will be executed on every TDV boot up can be named prefixed with "setup_"
> We can call setup_kvm_tdx_caps() from from tdx_get_kvm_supported_cpuid(),
> and drop the struct kvm_tdx_caps. So then the setup_kvm_tdx_caps() should
> be OK.

I don't understand this suggestion since tdx_get_capabilities() also 
needs kvm_tdx_caps.  I think the code is okay as it is with just the 
rename that Nik suggested (there are already some setup_*() functions in 
KVM but for example setup_vmcs_config() is called from hardware_setup()).

Paolo


