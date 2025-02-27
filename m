Return-Path: <linux-kernel+bounces-537317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB96DA48A69
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277A4188AE3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD26270EC8;
	Thu, 27 Feb 2025 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSr4jJsr"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79F1E51E0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691513; cv=none; b=oLW2XQMdEcHYqzWH0frKGDB6ieOpqHn+aq/wa1Gp3XSskHeREo1LbKHu2OXpxuPhjR15duGc2yUuJHkvmTBVPYqmI/BgbslnyZK5zK0w8bymIMaCpMPUTeHDd6r5zuCf3WZ1UC+5+DPD8VaWylhBd3eP5r06UjBu88a4OqbWBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691513; c=relaxed/simple;
	bh=lzJuj68IPYELNEwepv8cKovi68A07a9ryFLZ7YUT620=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaWxOENVMGTiZmoWR+Goevjm0R49VSlJuXxUjKNcmGlMkk2aNgDdAQPywsNABqV79I3GawXnCWS/yUBhw9i5lYMClf8MPbd6C4U66BszsmjToda0wdux5OIQTz7Vwxxq3IbWsvqFhMpGNi5uPIa6DH7cgi6YHjQCzW8Vo/Rk4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSr4jJsr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso2462918a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740691511; x=1741296311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPasBJtfA1A6r+ygxWij1B6VOAarT8bcVJ1UsJBCOVA=;
        b=YSr4jJsr8f6wYqWFiRV9qNusW9GB8PWYQ5IN2Ei6+3NEAcV/xNUyfZ5V5S/9neJUSp
         TjTkexNn7u8LfMK79w8CnYZH8pBQNvC//R5ZYg2PUvGxZUHswPJz3CaTRjX1PNtn4SWn
         WlocuQq+svWCNk1QU14FCUO90LACbM1RYN45+jcusYPFcnCS1eVQJtP7y+9wS3TimkiG
         Z9rQJn3WvFYy6tFUe+DNAfLiHXVe15NU51mwUPRNwdbv9sY+DULQ3V2lyVnGcu4n7sFB
         NIx1alDu0ex7/COJwyOLF09e/k38fX2ZVDvcaDMkUxX+RzFjXHP5dhb66Y9M8RAi3STL
         FZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691511; x=1741296311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPasBJtfA1A6r+ygxWij1B6VOAarT8bcVJ1UsJBCOVA=;
        b=X118k2M2ESTxDszir1pn3QAewJyxs3IgtsvbEHAj+irmXUvsgkEAPDGvFz48YYxPb2
         QC1Bb9fcVf8soyiqPrmK+JxFFYCtu8AlmDEXC42RAh72aWmS9jroxAvS/oqjuXq/aSlS
         +9IVYbYrSKa4LHJ5m08o0vNZSrow2gYwCxCCGD5OeTyy2x1B9MyhpCIr6XDFZyLElHBv
         Fn4OvDlw/tIgx5GgFd7yENZLjrTK7u0pYr8cC6J/Vp7IMNPL+bOXTJH+awT8WHOzesUI
         jHuQ+AJuUxi2lSZEsSZzuv7naKIyKh9w4l4maFHv5rQi5Ecc4lGshL6INP+p0vO58HiE
         w0xw==
X-Forwarded-Encrypted: i=1; AJvYcCX5E+dwTXD7zl+ICXXroPj0MgYeH2ZPrOsoboOjO9khAjTvBqoSoKPuEv4tvnN1aa1jY6MI1LWi7jcChbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxolCFkI8dvC+/PRfT142M8gTL1gb8wVlPzszrb1fm0q2+3PMLk
	O1V03iB5yrEp3TaE1/QZbkCLOUHG4nWHSoid8tgCkXjNq0gEVb2NLYBC3bnC
X-Gm-Gg: ASbGnctpcmuq0OjW4vJDNUiVJKgukwfE3cnkAwyXepIuiM52Fuiv5dpFi8P5gJ3t0ZY
	TyOZhQ1p3FwZ2japmG0Sv1G5sIAgAguGhAe24Z68ma2PPYCT6HmXgVvtewSS11tdTVasHLZ50wv
	Vtp9YazyX+gmeTEkD/SU3Po1sdf3acK0rCTcjHqF2HS9/hio8PURRZedbqaKV7+Bp7Iwk0PCuD4
	ITULNPCXHApOR//3dYDfp6NLJPkq5s29CMHKsAbCRgn3eR9QFLAupmCgoHb23AZJ4m0hKpbT3z9
	th6CLegosqg869r3nJ+Zkzq1PuEH7X+9UfePxD4K6z1Twcx1TNdESqjJuw==
X-Google-Smtp-Source: AGHT+IGBHq1s0yxlGfMCWYPgfiqJIRDa3hS7rAXHcG6G6Vcvw1+v3Kh3nPvhIl0+ny6yu9e75zJzBw==
X-Received: by 2002:a17:90b:3803:b0:2fa:20f4:d277 with SMTP id 98e67ed59e1d1-2febabf1a7emr1399582a91.24.1740691510953;
        Thu, 27 Feb 2025 13:25:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2e52:7:8e35:ae3c:1dad:1945])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a98d8sm4299464a91.8.2025.02.27.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:25:10 -0800 (PST)
Date: Thu, 27 Feb 2025 13:25:04 -0800
From: Kevin Krakauer <krakauer@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] selftests/net: have `gro.sh -t` return a correct
 exit code
Message-ID: <Z8DYMBlzcK5sFG-M@google.com>
References: <20250226192725.621969-1-krakauer@google.com>
 <20250226192725.621969-2-krakauer@google.com>
 <67c090bf9db73_37f929294ec@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c090bf9db73_37f929294ec@willemb.c.googlers.com.notmuch>

On Thu, Feb 27, 2025 at 11:20:15AM -0500, Willem de Bruijn wrote:
> > ---
> >  tools/testing/selftests/net/gro.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> > index 02c21ff4ca81..aabd6e5480b8 100755
> > --- a/tools/testing/selftests/net/gro.sh
> > +++ b/tools/testing/selftests/net/gro.sh
> > @@ -100,5 +100,6 @@ trap cleanup EXIT
> >  if [[ "${test}" == "all" ]]; then
> >    run_all_tests
> >  else
> > -  run_test "${proto}" "${test}"
> > +  exit_code=$(run_test "${proto}" "${test}")
> > +  exit $exit_code
> >  fi;
> 
> This is due to run_test ending with echo ${exit_code}, which itself
> always succeeds. Rather than the actual exit_code of the process it
> ran, right?
> 
> It looks a bit odd, but this is always how run_all_tests uses
> run_test.

Yep. I could change this to use exit codes and $? if that's desirable,
but IME using echo to return is fairly common.

