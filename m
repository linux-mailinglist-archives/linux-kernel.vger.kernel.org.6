Return-Path: <linux-kernel+bounces-267893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16509419B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F17B1C23714
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3E189538;
	Tue, 30 Jul 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns0/Z2DH"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B79188014;
	Tue, 30 Jul 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357310; cv=none; b=LVhWYlTOyp0ZZJjT/32IuxxwCyXK1LjfUo3tmMhS3fjL++XpjOwqqUujjFsFATT5+NddsUsUK0FhqWXXB3q5cQk3jDtKSEns5I6HVj0bwHkZN5qVtMyqzPIFx7bbMsVEVbU4p9P0Ny3AnxtyYMDpp2LrReWNe1LvnSrfNqa+9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357310; c=relaxed/simple;
	bh=qpwx5001siDU0s6OL/tG1xsE074fklT/oGpzD5zgkpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkDIQ8mJKs7Ii6DteJelmx4C0fvUluZz7s/DvD8Y0/Goc+qhnhABxOfpjxEqTVd24rN1gRyzDCvshPZW4AmDmqaRrisp+pjgzrqxOuaPvtQyBur6H+tICW51Bu0C7hXQGUi7HYqp2FaVorZZjoL3RwtctdABq1Hs92qta2VnMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ns0/Z2DH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a94478a4eso3716466b.1;
        Tue, 30 Jul 2024 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722357307; x=1722962107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGt4uBOUi8jDZlWojXnrBBKatTCqNqcHlJ4CdF8OBHI=;
        b=Ns0/Z2DHbRercklpKLvNOt+I0wwFNUhOHPqhzoS7VyFkM6s0GTW6Kf5K+E/RIsLLbw
         zXVwu5XWMRh4u8+FNRkxMB63f445TrP7SCGXL+DVlYMqw8ecKw0K2c9QRQSKboiSjSFL
         LVWji1oaPYP8IquNGQYv2k14JjbEvUK4irZEOY0jwn9z1S5zMJfMN2ajMyJBiKuHBxzm
         NoTRxKUfoqIfqU0seYqbU0wqvNmuNaXRjvvwQP6hfhAuZW+g6u4W6vVsrqiomjmNKONT
         OL62xCOJ0zbIhyXSPA6hgozyDh8RURe4NoUPvNAMqcIERhgpgqnko0853NerLgoi2wIU
         IhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357307; x=1722962107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGt4uBOUi8jDZlWojXnrBBKatTCqNqcHlJ4CdF8OBHI=;
        b=jOxVxC2wY14JCgMCIve5QFAZKaluU/7hT9yK2awkPwm8SCFl4fennq5NNlM6VNTvZP
         nNoeyUsv6gYtym1/3KTSxy0g0BPYQdUctS2CkiNZ76BihjJPLzXEJ7PDAr4W6dBbIHIw
         vZhEMpN9EP70B86b3BZljTB/uPoObL9eUBMNGvpBJUB2y7N5nhTITssIX1PTMgUY++M+
         Jq0o+a5MvHKu1jsWNxpJhtnNHLO53X9tr1dO+bEDF4S6md2Hg/jedx+Fk5amtlIwNorc
         X4Eb5T3JOaukKwxiiKhNdx5eDFSyCXJsW93qxQJV8xgytMZo4a3cJEgCCN/yhdFADHsZ
         Brhg==
X-Forwarded-Encrypted: i=1; AJvYcCUJIauPsO0PbPyfy5M19eA/ee2kIvHF2GUTxm6h1scxgCE6NSGv82o99Q5ueYWGLmII9u328KvrjJ4rhp6TJtEgxZQfIpjqY414BF4N+Vs=
X-Gm-Message-State: AOJu0Yz+0HKadhuJSSBFPHiPmuo6eYKR1jttTwIUL1I4UORZIR7AO//v
	jcR7QfXtDD5AzrVOR19itNZuYMYB1RzlvkFU0656mt2Ba0UnmNCCiNdyVs3h
X-Google-Smtp-Source: AGHT+IG+HFPbS7nERqEKywu745vcoB0gSCuNfJ9cQyWhtB3XRVyjU6U2KYUcbWp7LK5pWJpsWRXDzw==
X-Received: by 2002:a17:906:6187:b0:a72:5f3f:27a2 with SMTP id a640c23a62f3a-a7d85a426f1mr223777266b.26.1722357306450;
        Tue, 30 Jul 2024 09:35:06 -0700 (PDT)
Received: from [192.168.43.50] (212095005041.public.telering.at. [212.95.5.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad434a3sm661572866b.139.2024.07.30.09.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:35:06 -0700 (PDT)
Message-ID: <d85d50d4-3f52-4440-a57a-260d7943179e@gmail.com>
Date: Tue, 30 Jul 2024 18:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
 Sven Van Asbroeck <thesven73@gmail.com>,
 Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
 <fc3e956c-4f0d-4705-8429-2b7c50e335ce@gmail.com>
 <CANiq72=kAdq4TsCPvMWBwdzngeOst8g2cGzkk1DxM2yW=V4emQ@mail.gmail.com>
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <CANiq72=kAdq4TsCPvMWBwdzngeOst8g2cGzkk1DxM2yW=V4emQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30.07.24 6:00 PM, Miguel Ojeda wrote:
> On Mon, Jul 29, 2024 at 11:58 AM Christian Schrefl
> <chrisi.schrefl@gmail.com> wrote:
>>
>> This has been on the mailing list for quite some time with only a few responses.
> 
> Up to arm to take it -- if it helps, I tried the patch, including
> building, booting in QEMU, running the KUnit tests and loading the
> sample modules. Thus:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>

Did you apply it on 6.11-rc1?
 
> However, to keep our build Clippy-clean, it requires a a patch like:
> 
>     https://lore.kernel.org/rust-for-linux/20240730155702.1110144-1-ojeda@kernel.org/
> 
> which should ideally be applied together.

I think that I ran clippy, maybe that changed between 6.10 and 6.11. 
> I hope that helps!
> 
> (Nit: please avoid top-posting, see https://subspace.kernel.org/etiquette.html)

Sorry, I'm still getting used to using the mailing list.

Cheers,
Christian

