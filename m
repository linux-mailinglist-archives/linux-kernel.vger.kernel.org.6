Return-Path: <linux-kernel+bounces-304948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0143B962733
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB061F2458C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FF117C9B8;
	Wed, 28 Aug 2024 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VyER4sID"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9416C865
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848534; cv=none; b=RwoBiww9QZ8i6zVb0wkjAd8A9aNMFZCDWJCtFJzXM1H9vK3dXVAHI0U6OtdTTVSutMIsViAQBOiVvn7jdUcltJJ7ZCZvKsSjGRuDnjQCWmEYunNqQM8bsPktk01WmWDnnYvxaW+McD3N2+kvM8tsGw6JcIhcjLeHS8Kx4YuLuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848534; c=relaxed/simple;
	bh=aEKzrBbYi9Ry+ohyfsBeblxLDxy0FJBfs72+PMvk3CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szvzGoQIzOnHHCYiR5Fb1tXO+hrqeSstam3aDtDg08mw0Evx+hXr2qPEdNNthIqKn9Z2nIKSLNmAaNY/JjpjWmR8f9tUwmlyntrAJQBfu8wivsC8RBYFeaKJS1Hb/rorBGLHU2U+xH2HOLVrlyaGTnNrHbWmRahRzS2KojRyIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VyER4sID; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso73491445e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724848530; x=1725453330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUt4fS45inpztmNIGJYo+GUFk/1UM7umsW/0Hcne0yc=;
        b=VyER4sID8XPVvDMTajQC6Q8MjpdhvmAnngg57GeINNiTY8jixM2Z1ENhwCdMRLhy8E
         2VPyOFxzF9ouqkYQAO0IjgLgulIx7jd93vVdUOEzm9YuqTrjoHVoNgaxVkRKjLPGFUnF
         1pPV0cyOU8RVXiSFexmocPQiT1AZd82dt+M88yUY1eGseyeQaTVDfiUSVi38BpJoGqx9
         48H4AWbs3w5IreBuIa6IvlQE+NXrPG3a3EInA6yKEvtxW4Eq9G7BWoEjdKCvS77sPwZ1
         9ivY0c6d7I6R/js7DMAYp/QLD64yMfXymA4BopiH3rBKGv0GDdOXkqY13sHFI5GLIQe2
         HFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724848530; x=1725453330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUt4fS45inpztmNIGJYo+GUFk/1UM7umsW/0Hcne0yc=;
        b=QjrGez4jYXnuc7cbwAbFcbl0Otvx8szRbOzJSYd+h1WEB4Rtt2kGrH4npWwLZQv5dh
         2BVAwkBK8SX3H+b3d7l9PTvMZBK/ntuxIYnPL6oUCmoEFSPewmPBDdm3KzYP8QmeZSxo
         v7S0ljhMY5g/4Q8hsG7KXcYNIL3G0KTCtgAD6fVExy6iQ5m9V2NLXlFAeBqgOfSqnHn2
         tCSzxypAA534nQpjrAu9F22ApFK0tHUremRsFete740gfgB1Y/+VNeeOG0dQvRsGZ0F7
         FpmrCUcpxS/VnDXjb+y2IEuJNikV2ZeW3PSmycapKIXz2uATqjwU453EFZFe5PTRmrxL
         XMzg==
X-Forwarded-Encrypted: i=1; AJvYcCWsYO8cwfbOjh7eqAtNL97ca0YMqcc3Q3N5MQqETW7oaBX0no8ZMT6dMYFMRx6iPaYaXPaJ1ZQ3NCYA5aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLxnB/JSlpmOl8XVOwUQ3LDRSjacjFeDGLLAQZnf5r03URswA
	SwpbzPuf/hjQQ5PeJ+vqJR33oyrwNz22umgYzcnkBOi+D7mYRIWQHdkMuVCOnEs=
X-Google-Smtp-Source: AGHT+IHtoo2WUu3BieUUp3gLp4qf08YKUh5yOQZnaKr6LG3FzOM6CjSzhHpc5du36ZYPkM90Gk3FgQ==
X-Received: by 2002:a5d:46cf:0:b0:371:8e85:c58e with SMTP id ffacd0b85a97d-37311863a3cmr13842070f8f.33.1724848530075;
        Wed, 28 Aug 2024 05:35:30 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cc55sm241658566b.64.2024.08.28.05.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 05:35:29 -0700 (PDT)
Message-ID: <95db3178-a2ce-421e-8024-afd7fa3359a3@suse.com>
Date: Wed, 28 Aug 2024 14:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] gendwarfksyms: Add symbol list handling
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-23-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240815173903.4172139-23-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 19:39, Sami Tolvanen wrote:
> diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
> index 65a29d0bd8f4..71cfab0553da 100644
> --- a/scripts/gendwarfksyms/dwarf.c
> +++ b/scripts/gendwarfksyms/dwarf.c
> @@ -5,6 +5,48 @@
> [...]
> +
> +static bool is_export_symbol(struct state *state, Dwarf_Die *die)
> +{
> +	Dwarf_Die *source = die;
> +	Dwarf_Die origin;
> +
> +	state->sym = NULL;
> +
> +	/* If the DIE has an abstract origin, use it for type information. */
> +	if (get_ref_die_attr(die, DW_AT_abstract_origin, &origin))
> +		source = &origin;
> +
> +	state->sym = symbol_get(get_name(die));
> +
> +	/* Look up using the origin name if there are no matches. */
> +	if (!state->sym && source != die)
> +		state->sym = symbol_get(get_name(source));
> +
> +	state->die = *source;
> +	return !!state->sym;
> +}

Sorry, I don't want to comment much on function names.. but I realized
the name of is_export_symbol() isn't really great. The "is_" prefix
strongly indicates that it is only a query function, yet it changes the
state. It makes its caller process_exported_symbols() hard to understand
on the first read.

-- 
Thanks
Petr

