Return-Path: <linux-kernel+bounces-553544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55AAA58B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 05:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103B07A4C66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD41B6CE0;
	Mon, 10 Mar 2025 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2UFtLig+"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F71386C9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741581246; cv=none; b=qBj+g7T+UHUI0fz4r8UfdgBs/1J2SqagJOIGzRJlmZjP5o+IDqvDY5OQ4wvHzyOWd5ff8eu/KVlA7qtGblO292bSoK3OT7gr5WBdts7KT2rxc6YsRsALXnpKfy+5PMGu4MsF6ZaIkn7hna/vFs4zve3bioU+xw9yhBV19QZKHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741581246; c=relaxed/simple;
	bh=TWCm+CRWlgu32Y0M73b1SpXa9LjDCzu9iKJJhuYonhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZgqvPYAEMbUlojFXECHHfwSBmWXfeijOEafnoIjYa7jeR+IbDV2LI4a/gO6xwNY6fNy46EpcdJdLGCZOv/rAfjScMbH/SDXgTEYpcgCUy221fTQcAhycS71FVJfGYOtjbKMH+V7Vo+P1HjSesgpndCt/MAznwcY4rgc4iJA29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2UFtLig+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224019ad9edso85840565ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 21:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741581245; x=1742186045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=13ChRW79RLZKXPIzEEQT8n5qa9QFsChJtd4X7Rr3YO0=;
        b=2UFtLig+dSFHTn+YHlObETlejP901+y/OCOfhbTZhPoYq41cqrXHa958t1d1fMw+5L
         G4OTY/JoMR0fv0VjL/94DLUqnNbglmyGELsFWqqHutZlj3s6gYtoV9wxhyl5NCoxzqKz
         t1PRkHtd5H4NYL9naS4RKyTvd0laTp/oPzW0cLqDTSS6NY1WGUkMcrY5ITcUTU3QPSgW
         NKDim4ulDuSb3JntC7qD6V+4fuL/TFGx34gxZyEUPrGeMh9jSZzLlw3TQBqn8lutXkDb
         W0yXchjl27LRjtd0DMrgm19OFPzxIZNIoUxLG7xOcCbbo1BV4r1rKkUBNt3y8YNawscY
         SILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741581245; x=1742186045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13ChRW79RLZKXPIzEEQT8n5qa9QFsChJtd4X7Rr3YO0=;
        b=a9fjAbnpV+nKFOwTbx4pbgsA60KhxGkIDtb7ihHHaf7YdW5mXiFgJ/f8bi0LQlKPYL
         b956/HZ5tf7L/cldX9Dk9G4BEnxs+5yXbjmDrO2HNHvDEmgC3XKuxY3nMttSP91ZT9u2
         NGLExYweiPg3J32Kh6Ct2Qsl06JMbVbAvjC4GHz9pOIdWeWfn8MDcNEWRf544WFWAxb+
         rjmx6RmkEFDhymGr3qalXIrvX8Tb0gzszunesiAOwD3g4TI+hHVDWNxwcDd531xngJEp
         0wIBRUwYlMsHl0fidG/A1+1ZdWwvIk/fxxWGByr9Z4cr6K3gh23DBc9ygop9ZsIitt4F
         3gKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHf1YEPZMryHT+U/89WaJvELGq1qJsQKEJkYM59/R/ROISLX3WsiDahh3PT7TRquvy2ZyEuUjgXrAU5ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MsspN6bafnWbCk8bGAtns16NWDxti+jZfce1l7VRKmriLt99
	/k2po1m/tgM3RR7QBrQjrTmKBpFhmwPIIlWPv/TEkEkD8kO7DFATRANFvQoXz14=
X-Gm-Gg: ASbGnctuMJm/Kec01xB0Tb6dbejScZOmYe9Cuq9UyXj7nPxsOvG7kZf9kxHCTfEUa9M
	44Geb7FsJiAu1zcCMnd2+SxPN6MXCcmY5/exfZVayHjsIxhJsyUZZVg0QA61Oi70hVg9qsxKRNb
	DIcux2LfXZ6k4ZJ7206GedYOPBGcG24JgFXpfkXc0BLuOTbptidNcNZVaeT58leRTreqbSCBBV+
	KC6y3v/koHWxcfzPh17MszS8hkNvUZ9jBXY/a+6A19lY2ymBXVBSU/vA4hx8ofLQrbX2eleHNT1
	Y78Ho/LbVm6wP+larFQJH1ro2Q+4hzak+RbBuqU=
X-Google-Smtp-Source: AGHT+IG23e6e0NfcQWHHui1UgTUeATKpxeYS9TWIFzolvcIGQw0afq6BAO5/9cuUmkmceElelfdLBg==
X-Received: by 2002:a17:902:ea0c:b0:21f:b483:2ad5 with SMTP id d9443c01a7336-2242888b35dmr161699375ad.20.1741581244773;
        Sun, 09 Mar 2025 21:34:04 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:677:c5f4:a978:3253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f999sm67389125ad.141.2025.03.09.21.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 21:34:03 -0700 (PDT)
Date: Sun, 9 Mar 2025 21:34:00 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v5 4/4] entry: Inline syscall_exit_to_user_mode()
Message-ID: <Z85ruFUoBQM60Vd8@ghost>
References: <20250305-riscv_optimize_entry-v5-0-6507b5dff3ce@rivosinc.com>
 <20250305-riscv_optimize_entry-v5-4-6507b5dff3ce@rivosinc.com>
 <87senn3dh1.ffs@tglx>
 <Z8zb-L8bFMh_YHxO@ghost>
 <87jz8y3953.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz8y3953.ffs@tglx>

On Sun, Mar 09, 2025 at 09:23:20AM +0100, Thomas Gleixner wrote:
> On Sat, Mar 08 2025 at 16:08, Charlie Jenkins wrote:
> > On Sat, Mar 08, 2025 at 01:37:30PM +0100, Thomas Gleixner wrote:
> >> On Wed, Mar 05 2025 at 16:43, Charlie Jenkins wrote:
> >> > Architectures using the generic entry code can be optimized by having
> >> > syscall_exit_to_user_mode inlined.
> >> 
> >> That's a pretty handwavy claim. What's the actual benefit in numbers?
> >
> > I put the numbers in the cover letter! Here is the data I gathered:
> 
> They should be in the change log as the cover letter is not part of what
> ends up in git.

Yes good point. I will add this data here in the next version of the patch.

- Charlie


