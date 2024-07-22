Return-Path: <linux-kernel+bounces-259358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6748B9394B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988361C2163A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2383770D;
	Mon, 22 Jul 2024 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jzzY8/3h"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3F2E646
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721679834; cv=none; b=A40aWVzX8JdhCwgslB1MgYfa5ShjoGQVNWG6w/0umITblzxL/lHE+lSgzf0oCFulbeGRY9J3JV8cgSIrSqKXvvFJchDm/Cq7UugoAE+MCqvODI1SdS6seikgpOuR4vg1MtEn+3rYkLerlFYpkOJ7C7GtMnGxmk5zQhyk8Cts5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721679834; c=relaxed/simple;
	bh=0gxkWYQYVImohwWJvmsaMy8XwQWnmNs9Chmr+P6zujU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH+M9uDfb/uzRufcpVMG/L5fF0nf0YSdlkY8kCLY9UFVOmpLyq7GU7v97opYbiQcqhqUaFa3py/XO0Ph0h+ViysB9ZOkFgKXjEUcsqhnJCDP/JZbwKyM+kkFg8w/CFbAWL68hrxk8b4gZmCenJgEsNxiKrPDgx6APwr7LLP5YtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jzzY8/3h; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc587361b6so35652825ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721679831; x=1722284631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vscSuJli/qMDZQkgqyASUQ/eXIf5VrS/DxNRtVVokMQ=;
        b=jzzY8/3hSWeJfPGkkSAyCs79IdBsv7U3SGglFMhLLY4nWsumpM9oQ9UBA/XpwfN/um
         3ypETIu7zoP3Z9/3rE42xxKjytWD2eP42czxdParZrqTjCu0r9yCD54KxsSW2OKj8ZsD
         d5gjRc2TyTCFxJUiQ48wmnNQbvddrt1QQsWhSDspLfri4YH94tf+ADdLe57neei6fHT4
         2MBCQclW9am7TV3+1bqL0bv3aGOWsezpjKJKeV+Nzb8/wpN7GF0QBbt28WIGVMTWEgc3
         V+WEhOYv1aKS5gkKfSB5W3efFbPvrNs0INb5GOo/GWPY0kHhXaeWsvCjCOdQcR3MMISX
         9sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721679831; x=1722284631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vscSuJli/qMDZQkgqyASUQ/eXIf5VrS/DxNRtVVokMQ=;
        b=oQOGPHTuU6GHBY1oltM87s4NSb+z8lDfrXo9ys97oUsahQPbChyaVw90P0hMV+ja9W
         R6PVMKe+Rd3laMIIWdr2GFjmgQyrRGOXGwFONerQ1qMuF1Hb/RLT3FvLzHrF7Zl5cH7V
         NOqwBkZbpL2JRJa7wPjnCZSCS6n6xsE65IXMuZLR01J/EHD06Ndyzqs7OitygPinz5O8
         LWNEUKPLgHKCHdzwtPwu2szA8ihBwqCqqxkEHd972h+90sZ/RpqNpCf8rW/Rgfp6TGfx
         1c+LCbkAXsx6NBdYPctXIMbDWRbRunIY+DaAwz0Bq4EWVE/Pm/awkds/qpi6YTE6pKE0
         lsDA==
X-Forwarded-Encrypted: i=1; AJvYcCVmfzOCPaD2oxEg6zOSFkrtsNryl9HHtaoavscCsfJUKcyKvZ7lSuZp92ze8z03WRFgdQkIE0kDF4rv08wilrDRJguo+bBhlhuyqcIZ
X-Gm-Message-State: AOJu0YxK2NScn7Ni9DCtPWJvd8WvQWf4VGcfWhTCFPbdQDP5kKcXGxnz
	rFe7Wx5zGPzz9qS6c2kpMFBGlS9ukazLd4dAyU4jg+3WW0/X5gSPWcq0IYe3dC8=
X-Google-Smtp-Source: AGHT+IFu4KWg20WGwAtWgw+9RqpxdpwxYEZkFpTn/48CXCAEpuRBJHwGOerPWAQCjhEprtXFyI0Q9A==
X-Received: by 2002:a17:903:22c9:b0:1fd:6f24:efb2 with SMTP id d9443c01a7336-1fd7459a2b6mr52786735ad.19.1721679831554;
        Mon, 22 Jul 2024 13:23:51 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2ab34dsm59204435ad.110.2024.07.22.13.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 13:23:50 -0700 (PDT)
Date: Mon, 22 Jul 2024 13:23:48 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Yu Chien Peter Lin <peterlin@andestech.com>
Subject: Re: [PATCH v3 0/4] riscv: Separate vendor extensions from standard
 extensions
Message-ID: <Zp6/1CzztAOT51yU@ghost>
References: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
 <20240722-0c2488245ce33131693c6d34@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-0c2488245ce33131693c6d34@orel>

On Mon, Jul 22, 2024 at 02:32:49PM -0500, Andrew Jones wrote:
> On Fri, Jul 19, 2024 at 09:15:17AM GMT, Charlie Jenkins wrote:
> > All extensions, both standard and vendor, live in one struct
> > "riscv_isa_ext". There is currently one vendor extension, xandespmu, but
> > it is likely that more vendor extensions will be added to the kernel in
> > the future. As more vendor extensions (and standard extensions) are
> > added, riscv_isa_ext will become more bloated with a mix of vendor and
> > standard extensions.
> 
> But the mix doesn't hurt and with everything in one place it makes it easy
> to know where to look.
> 
> > 
> > This also allows each vendor to be conditionally enabled through
> > Kconfig.
> 
> We can do that anyway by adding an extension menu for each vendor. If we
> don't want a vendor's extensions bloating the array then we just need
> some #ifdefs, e.g.
> 
> @@ -405,7 +405,9 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>         __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>         __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +#ifdef RISCV_ISA_VENDOR_EXT_ANDES
>         __RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
> +#endif
>  };
> 
> 
> So, I'm not convinced we want the additional complexity of vendor
> extension arrays, but maybe I'm missing something.
> 
> Thanks,
> drew

Vendor extensions are non-standard behavior, so this is largely an
organizational effort. A benefit this provides is to delegate
maintainership of vendor extensions to the vendor. Additionally, this
separation of vendor extensions prevents changes to vendor extensions
from affecting standard extensions and vice versa. 

Another motivation for this is that I expect vendor extensions to be
temporary fixes in a lot of cases. A good example is xtheadvector where
a previous version of the ratified vector spec was implemented. Another
case is vendors creating vendor extensions while waiting for RVI
ratification. This will cause these eventually-to-be-deprecated
extensions to pollute the namespace and require shuffling around of the
standard isa lists. When it's an internal structure it is less relevant,
but it is a bigger risk when it comes to hwprobe. Allowing these kinds
of vendor extensions into hwprobe runs the risk of causing a sparse key
space. We may end up with many dead bits for deprecated vendor
extensions that will never be able to be removed to maintain backward
compatibility. Having the vendor extensions split across vendors
streamlines the hwprobe implementation.

- Charlie


