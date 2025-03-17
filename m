Return-Path: <linux-kernel+bounces-564931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1ADA65D49
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7D7173B93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA921E5B77;
	Mon, 17 Mar 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsr9KBvX"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151B1D89FA;
	Mon, 17 Mar 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237523; cv=none; b=US8IGPKmpABBHceLQ35oRezIFikFFGYjKJW1l8Cr2NnX3ksuwWH1E8xc6SYGgbErX4Rge9LFUE3KeC9GZwISJs5oH/fHRaOlnjvyNAQc9d9c3hpLvsSVLkPD3uzHtUVIO5YUoiMYI4OeiYu5jpohOvLUGpcbZON29JN+8kzIgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237523; c=relaxed/simple;
	bh=Wg2MnKTnhKly0wHBDH0v1yjZPcwO2/sURBDBD4Ujzzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkT+CuCTALf3txpf5lZ3yeEVdmBImLhVDqiTh99crMfDQ16bt8Q6Gr6GPK2AFS2f0tyf4Q9zs8D0I/cf5bIEnDCJ8boA1LBjhpU1U6v3aKClpsIt/b5hlsmjZl0FjZEXzt013772b7lu/MBaXmsA6EXOgROSGC8yJqv6btki+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hsr9KBvX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30c091b54aaso44370981fa.3;
        Mon, 17 Mar 2025 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237519; x=1742842319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkDPZzkLzIOYkUqZhOny1EDRvgrh4Eeg1KqEx4AgrNY=;
        b=Hsr9KBvXF6XJaymgLTAbIRM2RIyCu9j2PWtDFnFbhHJ1VRrKma0tXujDGKkQMvceYm
         H1py1DGTdqqHE4f1z1A6jakMycjXa2Yl1DNTyq8KCMZ1AbFc/9Ko+F5KgmAlJFoBMpD2
         o8Gms8D9hK4hZjNKwkVmhoo02sYjjkCCcdO5cO9rq3fgEoxmB6QkSh9eTu+FcKzmj5DC
         ajm6fna9tg2NRyGPr4FHMKUM1Mj3EH/xuWID3Ns1YbGDWRtPlrkH4n+6htTDVY39Os2b
         SDQiJyW3mcxGHKXbpjTwhB5vKsxEKkAzCyPVfInQ+oLDPZbpj6hT82loZCyI3D+g7vSU
         hfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237519; x=1742842319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkDPZzkLzIOYkUqZhOny1EDRvgrh4Eeg1KqEx4AgrNY=;
        b=e0nlvgieCDj+wa4M76IpDf23N1D7T4kzcW87a5jg+QNM43phdzv/EHSCm381yR84X+
         jPgxEo5jiDs2Ldj+HkZdjHioM3GuusdSiXEtkezwf8adVFR8T5B+qEVyczujkE4uYDoq
         tAQ6yAANWUTikLLR955klT+oaxgMvC4baFMxMQ2n5oCE6DKsxuZJCXAqqS0eqfgcNuk1
         3iWSMIQQTHVKR3F6DQixDeGFYNjYBneTkX/uaZHIlg0Qszyxar0UaN1cUQ1rKPmK59ED
         UYCdli6FcMWAdNLBRdFnDKsG2Lm54LppmCKB3QZurfKQ65EMkK/vw6yr8tfAWBve0c0i
         5dpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUdIxGrF7azCY3GHF1Kd99Y4DMGNSmouPhGGObglvGfaJcOtoF34pfCgk57i/BD3ozLE7UqRHQobSM1wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3QAtFNph2b2EMFyvbKgEZabzu/ZSncGX1kOKdJKVRvCIzzbj6
	d7s/okReib/g1C9/tACu1rPx41mJ0Ow8uv8pVOUK6v6pneaNFU/q
X-Gm-Gg: ASbGncvGYWssRTDYq13+lqgjO9/bllAJgC3W4ZjCG8OGv/fn8/iI0FANZFJixao+zRu
	WmBFvdgC683k/4BJfp4AIYCsBKqxyV6XIr7CtUNwoPQKCnk6A0ek58aqivSacgnN9kkuBjOJDLV
	/ZoTd5pmf3vzgqr/kLWyGL2UHydGL/XVg/uAGrs1jsLyUSsuq6m/Wu0WefHNUGOCoX/qzQSrhdf
	nLTSQIFMplKNAaW0RuJZt6MnJloy1yJjzgqM7TFVMXp+KwS+Mfcg2fMDutqhdJQK+XRkNpDh2eG
	BwdZFAJr02pj38yVP9QTHX6v34KJZKAeOyjwsR6tu0inCAATEttvDSAViLBb/6BrN3SxpqR6Cjs
	iS0peIJvbGRklFj/MpWKsnw==
X-Google-Smtp-Source: AGHT+IGhFAz/32DEqSkaVGzak/mdI4abDJ2a5/Fq/9391vxM2WM/qYuPtsbwDak0wY/6j9h0ejxofw==
X-Received: by 2002:a2e:a548:0:b0:30b:badf:75fd with SMTP id 38308e7fff4ca-30c9752f015mr10834551fa.1.1742237519033;
        Mon, 17 Mar 2025 11:51:59 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f117b8fsm16853841fa.63.2025.03.17.11.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 11:51:57 -0700 (PDT)
Message-ID: <0bff87e4-30cf-497d-8c50-a3469b4ec535@gmail.com>
Date: Mon, 17 Mar 2025 20:51:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
To: Benno Lossin <benno.lossin@proton.me>, Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
 <Z9B9CNRatBtyAO8Q@boqun-archlinux> <D8DRCM2FOEBN.3IVEVKW9A65AL@proton.me>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <D8DRCM2FOEBN.3IVEVKW9A65AL@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/03/2025 23:34, Benno Lossin wrote:
> On Tue Mar 11, 2025 at 7:12 PM CET, Boqun Feng wrote:
>> On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
>> [...]
>>> +    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
>>> +    /// validated beforehand.
>>> +    ///
>>> +    /// Public but hidden since it should only be used from [`dma_read`] macro.
>>> +    #[doc(hidden)]
>>> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
>>> +        // SAFETY: By the safety requirements field is valid.
>>> +        unsafe { field.read_volatile() }
>>
>> I agree with Andreas that we should document the exception of usage on
>> {read,write}_volatile() here. How about:
>>
>> When dealing with a potential race from a hardware or code outside
>> kernel (e.g. user-space program), we need that read and write on a valid
>> memory are not UBs. Currently {read,write}_volatile() are used for this,
> 
> I would use the singular `UB` here and below.
> 
>> and the rationale behind is that they should generate the same code as
>> READ_ONCE() and WRITE_ONCE() which kernel already relies on to avoid UBs
> 
> s/kernel/the kernel/
> 
>> on data races. Note that the usage of {read,write}_volatile() is limited
>> to this particular case, they cannot be used to emit the UBs caused by
> 
> s/emit/prevent/
> 
>> racing between two kernel functions nor do they provide atomicity.
>>
>> Thoughts? One problem is that I don't know where to put this document
>> :-( Any suggestion?
> 
> I am a bit out of the loop on this one, but why not put into the safety
> comment? I.e. explicitly state that this is *not* sound as per the usual
> rules and it is a special exception?
> 

Thanks for this! I've incorporated the comments in v15

/Abdiel


