Return-Path: <linux-kernel+bounces-357085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F9996B53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D001C24A94
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A351990CF;
	Wed,  9 Oct 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcQrRB2O"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C4193417;
	Wed,  9 Oct 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478999; cv=none; b=RIjxD64XyufLTj5JgotP36jO84ZKbHiJfJfTB6g1+ouEQylGxQ6qJDa36EcvU3/M9MwLMwSl0L4iAm5JCfr6OXdBn2Z6NAn/XkLbI1HCYzl5rgPMZiSvCl4jhG+8di+R1GpbRljyPExSPuVeqaeDz8v2XdCon3UjtNlatDCa4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478999; c=relaxed/simple;
	bh=pTITtYbh1vHPemB/H2vf0QQMa+1oo+Y8VplzX09Cp24=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wst2DNRPmUzU74UvatBSMvPLRCTb3S6a9IcnIyhhtku/tSlq5eEESxA5hDWCDhZOhj4EU55LLbU30VJWx9THKi+JoZze+yLKbedcu6aCfvYToHVSzt/bHiX0vgPRquwu6IyD7pdfh3HsSccmzqpb2SrZzZKSPvexg5flpdyFuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcQrRB2O; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a843bef98so901248566b.2;
        Wed, 09 Oct 2024 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728478995; x=1729083795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mtQf4ZArKv/00DOm6rVLlFMLox9Vhsd1BVLsnJ5ceYE=;
        b=GcQrRB2O0qpCdlI0Ct0W1/UD/hk8gE++6A7WBltwJ9ILs4ohb5bkccEECUYE/g14w6
         /Zj3pshDoKjYWjew674zyLuCQHL6kIPAURbl3cFoqpBOdaBhXcNXYIP0bcY7WHBNCVrB
         dfZNFPNknJ/L3x5m2B0PIRm+wI1X1wrsit/heBWh/Hdtv7AXP0MHo1hYCGy7C/dotT2A
         dyOcx4bu0KUux2Zjkkq5+jvhuyllLN1flvi1+zLO8yY00bLzIXDUoZS5nZQeSR6ONPiE
         Rrfyv6WnqCZloRPSYgvtUH7wUJ5TQQy6dzCDeR7yoriUSPJP5tZHr4EW2e0V+RmB5w2V
         yGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478995; x=1729083795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtQf4ZArKv/00DOm6rVLlFMLox9Vhsd1BVLsnJ5ceYE=;
        b=BboBkJ1a1HO2TLvDhWJ/qSabs8/O0HyA3Hlrkm++fuQeVjsih6GDViSEMHZeNDjE23
         ZpfzLY7bPunfZSU2WEADvD7KjsVOcrjOz76RpQn9afxU4G0TNSQ41iXWSG7msbZfhXxt
         JBjJBOqyjo1k2kLFAa/TLnjXdXA6FIPVxDdn1pM9qOoqtQU4e691cnkEHYu6hlhlsncw
         8v093Gb437ODrc2Wc+KoeXeoWnQkSdw/WgcEle/1uhLCTZ7LNRwPqaPYlPfK3rzYzb9i
         zxb8OWF47ci1tkoi9GxA7xhcaY8p3t35q9q3kvN2FtdVjgP+159PkdhbDnXdXd+9Z25e
         8AaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN1GrmIQPN3iHuv8X9hi73qVTlwME0gb4J4wbEvInlOGLUlVRRcu0xz2US6nxxSfTAwdQ6hq+rT2t+aDyla/Y=@vger.kernel.org, AJvYcCVAuMWn5xjufCd2h94bmCfqzPw/ek7jrH8rPMOKEawwaYc+j77P62dRkk8LjPE4JtH/r764owC/SKYMoTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSXWffyfdB5VNtDqxqKP6LihuHNbwBZ+mPe5816fz+85gkI7sH
	n9eLgziM3PDOeKMUcMag8pwOYoCrMR+GGshEIJmeO045Bt82uivO
X-Google-Smtp-Source: AGHT+IEzxtfeqSq1TtGsNbZZpiHRzyb3RwbkvF4fwdAXFafpwR1+8irUWspffs+pxZG0vrqGmmPDWw==
X-Received: by 2002:a17:907:7289:b0:a99:5ad9:b672 with SMTP id a640c23a62f3a-a998d11f816mr166602566b.10.1728478993466;
        Wed, 09 Oct 2024 06:03:13 -0700 (PDT)
Received: from ?IPV6:2003:df:bf2f:2200:1a63:5a2f:b369:2dac? (p200300dfbf2f22001a635a2fb3692dac.dip0.t-ipconnect.de. [2003:df:bf2f:2200:1a63:5a2f:b369:2dac])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99446bd93asm537213166b.82.2024.10.09.06.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 06:03:12 -0700 (PDT)
Message-ID: <da18f77e-3ac3-4222-9ceb-72e2955472a7@gmail.com>
Date: Wed, 9 Oct 2024 15:03:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: transmute: Add implementation for FromBytes trait
To: Christian dos Santos de Lima <christiansantoslima21@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
References: <20241009014810.23279-1-christiansantoslima21@gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241009014810.23279-1-christiansantoslima21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 09.10.24 um 03:47 schrieb Christian dos Santos de Lima:
> Add implementation and documentation for FromBytes trait.
> 
> Add new feature block in order to allow using ToBytes
> and bound to from_bytes_mut function.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1119
> Signed-off-by: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
> ---
>   rust/kernel/lib.rs       |   2 +
>   rust/kernel/transmute.rs | 302 +++++++++++++++++++++++++++++++++++++--
>   2 files changed, 290 insertions(+), 14 deletions(-)
> 
...
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
...
> +unsafe impl FromBytes for u8 {
...
> +unsafe impl FromBytes for u16 {
...
> +unsafe impl FromBytes for u32 {
...
> +unsafe impl FromBytes for u64 {
...
> +unsafe impl FromBytes for usize {
...
> +unsafe impl FromBytes for i8 {
...
> +unsafe impl FromBytes for i16 {
...
> +unsafe impl FromBytes for i32 {
...
> +unsafe impl FromBytes for i64 {
...
> +unsafe impl FromBytes for isize {
...

Asahi Lina's device tree code which reads the device tree node's data 
as a byte slice and then has to convert it

https://github.com/Fabo/linux/blob/9e496b356ee8e25f9bee9258491aa6ae3a4f1ddf/rust/kernel/of.rs#L390

uses macros to avoid code dublication:

prop_int_type!(u8);
prop_int_type!(u16);
prop_int_type!(u32);
prop_int_type!(u64);
prop_int_type!(i8);
prop_int_type!(i16);
prop_int_type!(i32);
prop_int_type!(i64);

Would anything like this be possible here, as well? To avoid code 
dublication?

Best regards

Dirk




