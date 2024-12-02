Return-Path: <linux-kernel+bounces-427970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E09E0824
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2CD285646
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC2F17B433;
	Mon,  2 Dec 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="foiYXTCb"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0B17332C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156069; cv=none; b=kX9SIva0MSXXJHdYWxIDgSKuSqzoaVH9yS/IF8e0MqrbFBFGnRoQZW4ROEyXLPVCF+8thuHdl/SwxrRp8QdlRTntynjwszmu+0QekKv6YIYW/vd19M1XhsL/ecETnnhhlN88eF51EicgMtdDNFWSdLkLHHLbwriasSc3bF0XTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156069; c=relaxed/simple;
	bh=OwIXuOkl98ecBMfXkAdimvKCgH93U2DB6vsnaTQrIw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFv8UsgSSS7JImtaxAN86ukzXzLSx1Di3P6Y/LX4J9MxYPHich76fsdnU/5JAwSJBdd0HIn/c13cecqT1TTXIfN1Y47v3BWDkdpRmhVoFu0ijoTqDwGfL2WfoJN54aj5zpV6Omj8wyDbIglBk9PDmXkrGp9z8bzxdPqXqUpc35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=foiYXTCb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434aa472617so37806855e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733156066; x=1733760866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkqtF7gf3rzskqYkgv0SBovnNKd2qwXos1/as7nPpuk=;
        b=foiYXTCb5ubz5C1P3skEksMF9LdXPe0Kee+UfgBu7IEZBRzEiI53KnK1sXdqfSewho
         E3PYpFf3M8sM0Mgjr5v3wSkDmb/n/qjqHmkb3WRNN0G2O8JZsNq//1xxu0xbXwvHYuaN
         m3qQx7scKoI+DRZ5xcuxLTDfdLANkIgEfAloJE6WPnV30UAK0PA+aIYBtRd4kQZuKzIq
         fe41ql8JZgefHy4jGp03muOGGtlMjRAqmKu5IxSE+XpW9Pw5VIs2UfNiAJCd5xXnTrl4
         eJjUgH0Fclbx6zUUaXUvuAQ41g0hAxD9UomxC4vN3D5Ky6AIoExAm4tXFzI14vTqE54/
         0yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156066; x=1733760866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkqtF7gf3rzskqYkgv0SBovnNKd2qwXos1/as7nPpuk=;
        b=M2fzxB+xzGN71bTmzHGgHYXvcKvVmuoXCzwWJH1QD5SI1v2rNRLOJChUHCcLs0wI/g
         Pht7nIuNybRG2Y05DbhPt2vYwjysXWkUhi944ibxkJZKRgw7ATVNkFfp4NqiJ98GQcFG
         eJfO14OSzgEuAfP1+47x4kX0+9yd2YXCRbtKknGzM3Ns3+KfEfAGI79POEWGvoju27Bv
         Ks3LJmmlFOt9ROxOQ4S+shaG26eiZh5ld6unmQPUadBk3CciA644/1XzG1S8eQOmPX0I
         a2t34frc9UlMHyY7bQRs52uXGJLs0ej47ohpJLBVfTKqTdX+NRuLR2abfEbs7UpnVzoN
         6Gjg==
X-Forwarded-Encrypted: i=1; AJvYcCXvhG6DCoQFIkGfIs3/aDdsYeqAY3xtnjwxRPNWvgbsc7qtq865TBeU9F59UDwbKDULwfbrOrYzEUIPgks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPugVtEjN5ppoi23CYXgTeaG6nj9pEMdbo7JL1mCyNZ2HG3+3Z
	iBguCc05B5ik8x/qOVtcvK8g8AlykS3fl7XfV4pYKa0odZCPGR3wx5Y9JL7qcpE=
X-Gm-Gg: ASbGnctw4r0wXv6hlBwG1qDyFsAU8L0weqV7yoFqKwxvNS+KQ/1JBi80c3ToiYlllsp
	ovV87xSRpY1KGeuQSwS6OWo4lNrVUdrRjdrzaMcWqMPMjw6wohByP5i8bgLgxCyUwcRrbw85Orl
	p2p9tAj26/Ox/wLAOJxjJeEpFOYUuZw4un+UsAHcl2nFqQRrMNyh1Aq0jjtPS+qPgw3hU668xSK
	lY1W64T2ovz8YLs/XK+nPV60vHtybdQV/DA47m047KCVCTgX9MFmg==
X-Google-Smtp-Source: AGHT+IFYutETRRcXML+QIddm9XhVvanLL6JGdMr2H3NcnNfxeBujp0ZUmjFwG3N6uzej8qITOTWbNA==
X-Received: by 2002:a05:600c:5253:b0:434:9e1d:7629 with SMTP id 5b1f17b1804b1-434a9e07911mr188863885e9.33.1733156065599;
        Mon, 02 Dec 2024 08:14:25 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa781200sm187506945e9.25.2024.12.02.08.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 08:14:25 -0800 (PST)
Message-ID: <409987f4-d124-48f7-b49c-dd61a4798bef@suse.com>
Date: Mon, 2 Dec 2024 17:14:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/18] gendwarfksyms: Limit structure expansion
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241121204220.2378181-20-samitolvanen@google.com>
 <20241121204220.2378181-29-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241121204220.2378181-29-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 21:42, Sami Tolvanen wrote:
> Expand each structure type only once per exported symbol. This
> is necessary to support self-referential structures, which would
> otherwise result in infinite recursion, and it's sufficient for
> catching ABI changes.
> 
> Types defined in .c files are opaque to external users and thus
> cannot affect the ABI. Consider type definitions in .c files to
> be declarations to prevent opaque types from changing symbol
> versions.

Thanks for adding support for skipping types defined in .c files. That
is a useful feature that genksyms has.

I was also recently thinking that it would be great if genksyms could
skip definitions that are in internal header files, for example,
kernel/events/internal.h. Perhaps something that could be added in the
future..

I've noted one nit below, but the patch looks sensible to me, feel free
to use:
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

> @@ -79,6 +80,55 @@ static bool match_export_symbol(struct state *state, Dwarf_Die *die)
>  	return !!state->sym;
>  }
>  
> +/* DW_AT_decl_file -> struct srcfile */
> +static struct cache srcfile_cache;
> +
> +static bool is_definition_private(Dwarf_Die *die)
> +{
> +	Dwarf_Word filenum;
> +	Dwarf_Files *files;
> +	Dwarf_Die cudie;
> +	const char *s;
> +	int res;
> +
> +	/*
> +	 * Definitions in .c files cannot change the public ABI,
> +	 * so consider them private.
> +	 */
> +	if (!get_udata_attr(die, DW_AT_decl_file, &filenum))
> +		return false;
> +
> +	res = cache_get(&srcfile_cache, filenum);
> +	if (res >= 0)
> +		return !!res;
> +
> +	if (!dwarf_cu_die(die->cu, &cudie, NULL, NULL, NULL, NULL, NULL, NULL))
> +		error("dwarf_cu_die failed: '%s'", dwarf_errmsg(-1));
> +
> +	if (dwarf_getsrcfiles(&cudie, &files, NULL))
> +		error("dwarf_getsrcfiles failed: '%s'", dwarf_errmsg(-1));
> +
> +	s = dwarf_filesrc(files, filenum, NULL, NULL);
> +	if (!s)
> +		error("dwarf_filesrc failed: '%s'", dwarf_errmsg(-1));
> +
> +	s = strrchr(s, '.');
> +	res = s && !strcmp(s, ".c");
> +	cache_set(&srcfile_cache, filenum, res);
> +
> +	return !!res;
> +}
> +
> +static bool is_declaration(Dwarf_Die *die)
> +{
> +	bool value;
> +
> +	if (get_flag_attr(die, DW_AT_declaration, &value) && value)
> +		return true;
> +
> +	return is_definition_private(die);
> +}

Nit: When I read the is_declaration() function in isolation, it is not
clear to me what determining if a definition is private has to do with
the type being a declaration. I think this and related logic in
__process_structure_type() would be easier to follow if the return value
of is_declaration() was negated and the function renamed, for example,
to is_kabi_definition().

-- 
Thanks,
Petr

