Return-Path: <linux-kernel+bounces-433714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B39E5C11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA2528F99F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E1F22257F;
	Thu,  5 Dec 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AuU1ZM0b"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F521D588
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417393; cv=none; b=XOd13dgJNxMb2wN01OVyEfm/6b239td6ZSTRFAYmWVVgavFhxZpoP73ZNYzuSHeNtUZH5OpZFsM9TztSt3/5Hej0o08jqZq5Mz8LddTCNDWbzRN/kqMdoBzOvkKxPDsJ3Jna4XRrVDJ8STnpkxleHv4KNvxNIJOPfZxj5WtITOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417393; c=relaxed/simple;
	bh=wvcGp5YJl0HfkWrsMAG+o9ANiEZLKm9ke1EVz3mOeN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQyNcRNputjP0F+jF8fYPT2dThZfwKV00252nMtu3vnEIapUxb0g2GJYFSAXh9lidDUfMRGzntiMHeaKSNy5iD6cEZRdl1M8+yAo4DdCH7hGipZ2u/0LEbvUkxlmdzAu5JwFLEc9bQ5fI33pxaCEAs5OCfeyZiO/PczGvkU2HsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AuU1ZM0b; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215666ea06aso19091995ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733417392; x=1734022192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LW3nVyGBjPmC7MmiF6/pZIPadVScmOhCq1HNc7aFXXo=;
        b=AuU1ZM0b0J/sYQQgQCEcYMRSsVyhrBE/+pwK5QjC65P1TL+imiGyaHj81OV/5kYmlQ
         EDJ9avlF2lS0+NVQAwickYbOq4xApZCe6YDHAN4F8FgyBUWAgvvY73nXbYHLKAivDKpp
         tXNeocWW5MwlXo8kjmV2E7v/epv7QclfqphLy0BPPB/A0rIskskiDAJOpvef9zBlmYm3
         DsSYbvsCkoJRjvHclOFBZK6QQyXCg3xPwIcw3/e/sxveYiSDvA1hJOXZ7TlBd91rVdMq
         6ZiLjEfmEBVRZWk7zra2lp8bkFtTV8+gqY6/La+MxyN8eT39hLBHN65tcJVgh3LKNV+s
         HMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417392; x=1734022192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LW3nVyGBjPmC7MmiF6/pZIPadVScmOhCq1HNc7aFXXo=;
        b=QST1aM7wF9Biztiwrgl8HbaiR7e9bmfhCSEJdEOOnR2fRVaCn/3I23GUasTcNdO7ha
         /Dchu0CxUWvCmogcL19q6SLaZdcHXiD//8kCw/kPIa1u2UkcTmVbckp9feSHYtiNjvm9
         yKWpevETo1gSsfblWxtF3DEK5wzeyi4bZ3UyYIV3w0zJ3Dcba82DbmV6l6xKu1V+cKt7
         LN+vKvUim46lMpX80Nzt7DzUDhHTDpTIes5OTXX3pjfYkoKMRGGxFsXpphJxvCG1vBtA
         BCYW9UcHbQKudPGSS+hUO3JoDboaqsVR5o1Vj7BJ46HeaUPJz32ez04arPouumG2n+fL
         0Epw==
X-Forwarded-Encrypted: i=1; AJvYcCX0wv14RfY6rm8OmWZGc48ZiatjCztAt9MQpruVw7PdPbKDFvs4ESUrunye4DFvNQWOHBvnCgGle8c70VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7N6oaaP/K8KfnqQ/eeAP/NjRjEvOnLYkeRJah2xrIur5ZiWu
	JrMWCaFdMg73vIRyLXnRDR4FkwAxX7+RqxFqa6XWxlNttgnPBCmVAR2wWBesGQ==
X-Gm-Gg: ASbGncvGxnbqhzy4SLIVTdhRhTdBn3kpUjQMTVySCT7K6bBY5plYfGwNB0begb/4czO
	GnKl0HH7AKJboeUMjKcmvnb8d6WHdVwS1o+OMsYjXz56m2qNRgdWCGof6mfHO9/80B3+pjcErpB
	wGHEltAeLVXkHD9tHvy/uc4RLIUxIyFFD596CMmhXEVacwyGVQKlkqJ+TEWWcMYgezIrPH+FYXj
	lOjUX5RHMw4qrQozRBmGZAAhqL5XqbEPHFP9bW1HqYJaEPEzCwZaw==
X-Google-Smtp-Source: AGHT+IHnNtX3tMSLvvzcJDM8mmCSzkinGh0IAdf8rfXDHhivEiWh9ktaKhpLNJyQ3rzbGBSrdnX5wg==
X-Received: by 2002:a17:902:d2cc:b0:215:9d48:46f9 with SMTP id d9443c01a7336-215f3ce4f10mr59397415ad.21.1733417391540;
        Thu, 05 Dec 2024 08:49:51 -0800 (PST)
Received: from google.com ([2620:15c:2d3:205:a344:96ad:4260:dcb0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f26ff2sm14609405ad.227.2024.12.05.08.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:49:50 -0800 (PST)
Date: Thu, 5 Dec 2024 08:49:41 -0800
From: Nick Desaulniers <ndesaulniers@google.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	cferris@google.com, android-llvm-dev@google.com
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
Message-ID: <Z1HZpe3WE5As8UAz@google.com>
References: <cover.1730238285.git.gustavoars@kernel.org>
 <9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
 <20241109100213.262a2fa0@kernel.org>
 <d4f0830f-d384-487a-8442-ca0c603d502b@embeddedor.com>
 <55d62419-3a0c-4f26-a260-06cf2dc44ec1@embeddedor.com>
 <202411151215.B56D49E36@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202411151215.B56D49E36@keescook>

On Fri, Nov 15, 2024 at 12:38:55PM -0800, Kees Cook wrote:
> On Tue, Nov 12, 2024 at 07:08:32PM -0600, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 11/11/24 16:22, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 09/11/24 12:02, Jakub Kicinski wrote:
> > > > On Tue, 29 Oct 2024 15:55:35 -0600 Gustavo A. R. Silva wrote:
> > > > > Use the `__struct_group()` helper to create a new tagged
> > > > > `struct ethtool_link_settings_hdr`. This structure groups together
> > > > > all the members of the flexible `struct ethtool_link_settings`
> > > > > except the flexible array. As a result, the array is effectively
> > > > > separated from the rest of the members without modifying the memory
> > > > > layout of the flexible structure.
> > > > > 
> > > > > This new tagged struct will be used to fix problematic declarations
> > > > > of middle-flex-arrays in composite structs[1].
> > > > 
> > > > Possibly a very noob question, but I'm updating a C++ library with
> > > > new headers and I think this makes it no longer compile.
> > > > 
> > > > $ cat > /tmp/t.cpp<<EOF
> > > > extern "C" {
> > > > #include "include/uapi/linux/ethtool.h"
> > > > }
> > > > int func() { return 0; }
> > > > EOF
> > > > 
> > > > $ g++ /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
> > > > In file included from /usr/include/linux/posix_types.h:5,
> > > >                   from /usr/include/linux/types.h:9,
> > > >                   from ../linux/include/uapi/linux/ethtool.h:18,
> > > >                   from /tmp/t.cpp:2:
> > > > ../linux/include/uapi/linux/ethtool.h:2515:24: error: ‘struct
> > > > ethtool_link_settings::<unnamed union>::ethtool_link_settings_hdr’
> > > > invalid; an anonymous union may only have public non-static data
> > > > members [-fpermissive]
> > > >   2515 |         __struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
> > > >        |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > 
> > 
> > This seems to work with Clang:
> > 
> > $ clang++-18 -fms-extensions /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
> > 
> > However, `-fms-extensions` doesn't seem to work for this case with GCC:
> > 
> > https://godbolt.org/z/1shsPhz3s
> 
> Hm, we can't break UAPI even for C++, so even if we had compiler options
> that would make it work, it's really unfriendly to userspace to make all
> the projects there suddenly start needing to use it.
> 
> I think this means we just can't use tagged struct groups in UAPI. :(
> 
> I have what I think is a much simpler solution. Sending it now...

What was the follow up?

cferris@ is reporting something similar for linux/uapi/linux/pkt_cls.h in the
structure tc_u32_sel definition, found while updating the kernel headers in
Android. Maybe that file/definition needs the same follow up?

~Nick

