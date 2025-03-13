Return-Path: <linux-kernel+bounces-559916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 354B8A5FB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C3919C47A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90A0269D03;
	Thu, 13 Mar 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RrIcgm0G"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1626983E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881968; cv=none; b=mLU9Xr1WWi960Jmqp+Xcy4OVtNZ9PsUNLBlFQEeel1ypazvq/aRlY/2j4+d8LGIqx9CuYrzjg1Xnd/sm8gmZKfFu6e308X/eqInhYqKTipx1jmTUH1aqSSaQvBmcjZletE40Mgx7luJ4bXaj3TCoSlsXNoLutVVKhSdy8iFGoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881968; c=relaxed/simple;
	bh=9Qz1HoeN3eOou3Eoi4V3CxaJyhSdwyst6GwzX+KW2lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soAmWWvAM5n4S9D5WG51UU1cSWrTZKDfqQVjUTJDZ06e0ryHaZTIw+DHfjemeLHsHOnUHSHpstL/se0f/SGEwruVq1m8dAIj4oq8nYjzhNUbs9CZsSORYToUXg5JtC173er8A2MJxjCXu52+fK6OUm4XdcHNQpYPJzwcBd0Q42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RrIcgm0G; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so10641185e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741881963; x=1742486763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HZvPdaIqRtWzMsbUSWcLTIHwxLYbx+aQlE3dkPDF7Q=;
        b=RrIcgm0GAEoDkeid0sM0ynGRD/6cj50mS4il9bx/pzyblnCwK806eD0kv+c8fLNFyb
         jmSIdIYOfAsMRe32uOEx/YNmVaToedT4uFMX1Gaw0p+znMf7L6XAD8D2z55bCCz+0gD8
         9tsJkpgk0rWpNYFHtjC5ydrXFNnE9dSwdrOjDdR5UpMPE0uhj5pKfUFScZ6e1ktu9Ixb
         So+I262nCDnip4iyhyGHp4ojQJIlsVmivsMhnD06CwNJx2XYBUFsQRVzOhfdpKTifQW0
         RGDJ3aXudlvw1fGiJ5QIp++82KgNISagfIbv7PoTKc5tWnk6yJHAXZco63UYyMGfEKJJ
         QGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881963; x=1742486763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HZvPdaIqRtWzMsbUSWcLTIHwxLYbx+aQlE3dkPDF7Q=;
        b=dglLgMEp30U1MigZS+qvnC1FNeWL70iK4UV8k98vXekRdFQgW7Jvnha2qb8lb6BRS6
         8Rn8EC3vvih5Il0+LZ+pAUpHuS6MeoNDxEWbZJeCXHKWrfLPa9lFjsWiTKMt/chahJD1
         wKGHosu6M+9nmJA23XlQgtBLomHWbNSW4kVVQsFHxSgworXdl1reyUVKJD/HgoXW0Jce
         Llut+l1pr9sHJ7qBvCfdaMu55fgJFpSRavL8AwQvllJBjMWbe68H4MncNeBeZGFCGCVu
         Cb0qkoBivs3/DyD/BKkC5H5vfeSeihoixL+xHkS5+COEgTwXOh26HKL21kWwRM1wkxKL
         Kq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTIJ7cYaBijWiubJQjEedalYfVwcG3k19IrJGrLRXTcdkjArSmIduR9sO9rZPcIto1NsD77BFgW/ZPbsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBq3Y0xCLEje2yCbgxUamIHsehNRAw/RMneWOnMU6HSPJwjE7R
	MWvguB+Z3QQV7rw4rfKhETvXQFj7XZUvL1tHV+b0aJpdFKIXHmu9jy67e4bJarI=
X-Gm-Gg: ASbGncvGzYL/2fg3nG4kNArCyh+48lLvbNgpaOqr/mX6GXdpxgwUwKRBuGN62PpC8Yk
	hLu2yTj7SWQqpcwy+kQpkoQbLHW6wljWhwD+dOL3kbejHLPmVKKSFOtBxvweUNob+xlL+BJYK/l
	8eFC3rxWYswsyzTJ+y3MURTNWtKN+3jzdMzOT+sP9vMAGWdQZc79qeyPDtoXrCPebdCpTs4m5Mz
	6oxJ7xmfYDel4Q/1DemUIXtsG9qrqLqp/tha7i7eueZ977eVzfQ/oZtMFKWcrfbwp4qIuiShMGP
	/qGWY78OxK9JvXSNsBfdhig6zigO/urlkxH3LoRLeBN/Hn9nZZXhFQjkwg==
X-Google-Smtp-Source: AGHT+IEQgvgSedwxIKGl9SiZ4df69QimUI+L/qJr9u7Y58J1gpKQcf9TTsptlOEMUHLXVau4Wsbqng==
X-Received: by 2002:a05:600c:1f81:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-43d1d8cb061mr1985145e9.17.1741881963106;
        Thu, 13 Mar 2025 09:06:03 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74cdedsm60150725e9.11.2025.03.13.09.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:06:02 -0700 (PDT)
Date: Thu, 13 Mar 2025 17:06:00 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org, workflows@vger.kernel.org
Subject: Re: [PATCH v6 0/3] printf: convert self-test to KUnit
Message-ID: <Z9MCaPagUM7KC26x@pathway.suse.cz>
References: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>

On Fri 2025-03-07 17:08:55, Tamir Duberstein wrote:
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and scanf), the rest having been converted to KUnit.
> 
> I tested this using:
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf
> 
> I have also sent out a series converting scanf[0].
> 
> Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

For the entire patchset:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

