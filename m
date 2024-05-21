Return-Path: <linux-kernel+bounces-185474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4D98CB54C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC2C1C21AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D414AD1A;
	Tue, 21 May 2024 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R+Zf/95d"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FD14A09F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326037; cv=none; b=DtOLM+ubVp2gP9rFGTxR5haiUzWJivgncYW3yNUivrtfgXSuIiQgnXwEs7xyLIH/vjfBd0O+7cTwkxrvqHK1F9VAGUvK5zlOsD/3dsaNS/zft/zFw7zoPeimn7cvRCDm4jB6ZCbCgeMt8eAfv6Vivt1efAUJQe6qBgfrlqhDVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326037; c=relaxed/simple;
	bh=i37TKc1fQUsg/MZXbDEDex5DUJTdLQ3Tj3BGogak9pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e49tGfiBEHjThvsNwqsQRBaUS55MImG2TJuzf2kKcuXybXbvT9Dp3keHoWeDTphw9dnZQYuydH+/+AqbBXwIz0u3Nar4OMVCHKvGVjUC4tyNht+d3gFWWL4UDzq9PK/40aQuw7sr/6NB9b4zzSeW6keuflfBbNm4j2lNRpKyxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R+Zf/95d; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f6bddf57f6so946147b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716326034; x=1716930834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FC4kUSh55rUz/GL+Wk6zz4yqmj0fvdXDk4Dif5NdqwE=;
        b=R+Zf/95dvP/0V0V+6tbrf9QgnWZKSdL0zWW00M1xhJUCrAiZ/JRddcXYBMNpmScwmk
         2kvJJlsFiaCT5Kwc10OuNPQk+BsJaO0UJL9bbrOUgR5sxxBlVnLRDMNA/6fPVyRzghqM
         QGltPOZ+jv8MXvuF8lFcojHP9tM4LfvuVuqDgroKetesuzwUrr54VtUS7NY2ToVLehn/
         tC43p+hzleHKaNA+OstEPPrfCcH939lEg7e+vJkMYNnNyn7pqJAB4MrNCOMjUqo4Hy9S
         9zEXNqX5SSHhqeWPNgp6Dk2rCgKMLc9N217sDFuPNhm05dp9FXquGjpt+O18PO/71PL3
         Rx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716326034; x=1716930834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FC4kUSh55rUz/GL+Wk6zz4yqmj0fvdXDk4Dif5NdqwE=;
        b=Wspfw5OSXDh8cvnEG9Sp7O01K027aPr+c0U6wCJH3o4EENEmrX5IjS8rr6yep5quEF
         mT+9ymyupdM3BdYiXP3ZytdAETSbMB2zEw5XsSH+RE2b+G44VkQbNFHF3E7oiYgh/0eN
         EeyylnlX49JUEY2CrI1fdkG/poAOwB2vw14plstgEXujE9sdJLD1545rSiXQpy885rB0
         /JVMLFSJISi0kMFEWK1qxGjrhUWRNqs8JiH62g1jKHuGBBOpfnpfNLRKaT1dYEMrugEA
         iWmNq26/mmZQ3oyP1I+zpVHkpjekn5yG3py9ADXHL5/PfN50EgP/CjEf1aXpSOnOeTKx
         8Okw==
X-Forwarded-Encrypted: i=1; AJvYcCWIiRbz5mKAbvrGxFv2ksnWV/99XW3oliqrlbqtkvR2srh/IxUifQ+ja2NxHrRKHeEcaBK84S7uUfZq6uavkRgXtRmFJnuD9ywy66Ar
X-Gm-Message-State: AOJu0Yywq7zsYN3FjXwHXOfO+2CaZo6FglTTF9ImfeGTvBDgZP8wFuhp
	RQXK7JjeyeGf5hFh+yz/h1RZ3u6nKb4OxY1XeomQIowzP8DT4l/oOkFX4F2J3Ac=
X-Google-Smtp-Source: AGHT+IExOxw4dQLOtq/6oMwBUTDL+aZgZxi9IpFxyzL92tIt1l3Fojcg/3lRIxum789QUlv64lDgPg==
X-Received: by 2002:a05:6a20:a10e:b0:1b0:1a02:4131 with SMTP id adf61e73a8af0-1b1f87f815dmr257815637.2.1716326034285;
        Tue, 21 May 2024 14:13:54 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b254cfsm21167196b3a.200.2024.05.21.14.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 14:13:53 -0700 (PDT)
Date: Tue, 21 May 2024 14:13:50 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org,
	Elliott Hughes <enh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: riscv: hwprobe: Clarify misaligned keys are
 values not bitmasks
Message-ID: <Zk0OjpW1nizPXHe+@ghost>
References: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com>
 <tencent_338DF690631BAE788C4CC858233E9FBAE006@qq.com>
 <CALs-HssGcNso6vTfbcsiWX1h_46jgDDRcEWcfZCTpxXYnubcng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HssGcNso6vTfbcsiWX1h_46jgDDRcEWcfZCTpxXYnubcng@mail.gmail.com>

On Tue, May 21, 2024 at 11:36:06AM -0700, Evan Green wrote:
> On Sat, May 18, 2024 at 9:00 AM Yangyu Chen <cyy@cyyself.name> wrote:
> >
> > The original documentation says hwprobe keys are bitmasks, but actually,
> > they are values. This patch clarifies this to avoid confusion.
> >
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> 
> Hm, we also have this problem in the code, since
> hwprobe_key_is_bitmask() returns true for KEY_CPUPERF_0. This results
> in wrong information being returned for queries using the WHICH_CPU
> flag. If usermode asked for the set of CPUs that was specifically SLOW
> or EMULATED, the returned cpuset would also include cpus that were
> FAST. I believe all other queries are okay.
> 
> The one-liner fix is to just not return true for that key in
> hwprobe_key_is_bitmask(). But that's technically user-visible: if some
> software relied on the buggy behavior of FAST cpus being swept up in
> the query for SLOW or EMULATED cpus, this change would expose that.
> The grownups-eat-their-vegetables thing to do would be to define a new
> key that returns this same value, but doesn't return true in
> hwprobe_key_is_bitmask(). What do people think?

I agree. A new key seems like the best option, keeping the old key for
backward compatibility. However, perhaps instead of the new key
returning the same value but not returning true in
hwprobe_key_is_bitmask() it could instead be a correct bitmask so people
would be able to have the feature of or-ing together the keys.

- Charlie

> 
> -Evan
> 
> > ---
> >  Documentation/arch/riscv/hwprobe.rst | 31 ++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > index 239be63f5089..4abfa3f9fe44 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -188,25 +188,30 @@ The following keys are defined:
> >         manual starting from commit 95cf1f9 ("Add changes requested by Ved
> >         during signoff")
> >
> > -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
> > +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A value that contains performance
> >    information about the selected set of processors.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> > -    scalar accesses is unknown.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_MASK`: The bitmask of the misaligned
> > +    access performance field in the value of key `RISCV_HWPROBE_KEY_CPUPERF_0`.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar accesses are
> > -    emulated via software, either in or below the kernel.  These accesses are
> > -    always extremely slow.
> > +    The following values (not bitmasks) in this field are defined:
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
> > -    slower than equivalent byte accesses.  Misaligned accesses may be supported
> > -    directly in hardware, or trapped and emulated by software.
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> > +      scalar accesses is unknown.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
> > -    faster than equivalent byte accesses.
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar accesses are
> > +      emulated via software, either in or below the kernel.  These accesses are
> > +      always extremely slow.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
> > -    are not supported at all and will generate a misaligned address fault.
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
> > +      slower than equivalent byte accesses.  Misaligned accesses may be supported
> > +      directly in hardware, or trapped and emulated by software.
> > +
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
> > +      faster than equivalent byte accesses.
> > +
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
> > +      are not supported at all and will generate a misaligned address fault.
> >
> >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
> >    represents the size of the Zicboz block in bytes.
> > --
> > 2.43.0
> >

