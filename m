Return-Path: <linux-kernel+bounces-259329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85154939446
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4132328211A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D552170822;
	Mon, 22 Jul 2024 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K0XBWbgv"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD041BF54
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676773; cv=none; b=bKfEwiO1nhySB3aSOgrGCTUPxWuF4/J1nZFUgCiiUe3Q1REVAayd8Rvem5KPmd0Njl4WqX8AvRwcIs7JgD2deq33FOnKQkmDHiFVWUfvWJ0wN83JzdShfhfwAoKk0fbaXqRy57lRJjIZIRmAMz/QM9VC101cw1AwD5eTioFhxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676773; c=relaxed/simple;
	bh=ZHXGTSwjVMsqoGS5cCvxLJxsPBQrXnXA/3OvJY1GrVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3VoKpLVhMx1HhwbMgWHJHVuGz0qm4a3piBszsv/SsRv3p0hoDvjZK0yKxU31bGsNU7Ok87RFyzd8KUo3gezjp09cTkkaRVmJ5a9dFaMDh7TygdGTigiBAM+RgMhXVK38XepL2+pyK7f29SxZdSG3K98GsiUSvp/9LMEleaRfFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K0XBWbgv; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79efbc9328bso273179785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721676771; x=1722281571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TL88S/2Tbb1ImSXlSTv6BMkVNu83Hjf3x7A/KXZiFo=;
        b=K0XBWbgvGmrHaQqeNSDo2wdY9UvCfkujUp7ruJS9hdeMlFl3P5faXNaAh+bbBgUqv2
         XWEekWBBAnEVjHcdeveTLmKR5LO2K5Mt7IgS4Uh6eMtSJv1R5yx2cKtCCVQNeBGurGUd
         pdJWVaLUxtV1Lh94Gbt+mLvhz6tkvtR4Plb5iKePisdjsCsFAsKQso7hQrpSaiBFt2sK
         4yn3OErDjkyU5T+A/xwLhGwKk66E+bzIlRjLyBwyig/SU7TG/EWiqxQI5s1hO/hyO8f2
         7PYDWGjdv7WmlzmjJwPvaYEr32OdyLKa9UQuGJVMWbvnlVtzereurEXq4c+jYmChusw3
         Yapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721676771; x=1722281571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TL88S/2Tbb1ImSXlSTv6BMkVNu83Hjf3x7A/KXZiFo=;
        b=n6iq+akmP4EBRDLR7nplJkL/xRPmAEtcXfD10UlrRiHArRRFHPM3GeiD/Dru/1SAOq
         qXCCYpZs405HiWkE2iLV3qaFWrsmD24BFCvbRTmZAN2qQHacd1Dy24Wm1eRRxkpt4bFR
         5709LDhJnPtU2iB5Qb5QmYDsA2bMTzF2RWHFsrOtpUSXgqkky/Z9ULGjlmA25kNI46cg
         bwPCFjMnHmWsIt06wAdxVF8zWukwF6ceHcc1njBzJ1pt/TqChmTCikEfojL/apmbpcDj
         EYWzmtwZu7TFUNUaEPwiIYlp1W+CjcXTL6x2vlBKl0wBDc88XsciUSy1YpZcitBOiEqc
         YSNA==
X-Forwarded-Encrypted: i=1; AJvYcCVfr1sU2XSblBRj9j+yQO6095fCv0Bhp+bqyCGWxBAfoKqGhObH2BMMhUblHSLfxGlafyWmnoqLPwsJoQxgfE347stZymlQdqd1gwvw
X-Gm-Message-State: AOJu0YxQCKfyTKtdaFKa5oFKzi3W4itZgpwlxJx40wW+x8QlONG+qoNh
	XDZ1A+0nJHzjHrJelRI4/JnWWkRwAzHy/byZqLVLmqxMgpRmK8VRgHKlZDOHeBk=
X-Google-Smtp-Source: AGHT+IFOObX/nJmFXIoaFCVc8Ij671uAJbT39NfWw6nz7bPjAvrV2JBAYXMpeMyh3BtxLMq5kWzdVA==
X-Received: by 2002:a05:620a:2901:b0:79f:178f:99d9 with SMTP id af79cd13be357-7a1c06ad2f8mr104351785a.5.1721676771041;
        Mon, 22 Jul 2024 12:32:51 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198ffe9f8sm392206185a.62.2024.07.22.12.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 12:32:50 -0700 (PDT)
Date: Mon, 22 Jul 2024 14:32:49 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yu Chien Peter Lin <peterlin@andestech.com>
Subject: Re: [PATCH v3 0/4] riscv: Separate vendor extensions from standard
 extensions
Message-ID: <20240722-0c2488245ce33131693c6d34@orel>
References: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>

On Fri, Jul 19, 2024 at 09:15:17AM GMT, Charlie Jenkins wrote:
> All extensions, both standard and vendor, live in one struct
> "riscv_isa_ext". There is currently one vendor extension, xandespmu, but
> it is likely that more vendor extensions will be added to the kernel in
> the future. As more vendor extensions (and standard extensions) are
> added, riscv_isa_ext will become more bloated with a mix of vendor and
> standard extensions.

But the mix doesn't hurt and with everything in one place it makes it easy
to know where to look.

> 
> This also allows each vendor to be conditionally enabled through
> Kconfig.

We can do that anyway by adding an extension menu for each vendor. If we
don't want a vendor's extensions bloating the array then we just need
some #ifdefs, e.g.

@@ -405,7 +405,9 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
        __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
        __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
        __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+#ifdef RISCV_ISA_VENDOR_EXT_ANDES
        __RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
+#endif
 };


So, I'm not convinced we want the additional complexity of vendor
extension arrays, but maybe I'm missing something.

Thanks,
drew

