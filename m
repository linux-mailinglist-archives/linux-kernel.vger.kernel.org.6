Return-Path: <linux-kernel+bounces-301997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB94695F869
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633C5282882
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B41991AF;
	Mon, 26 Aug 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OUmwdnOp"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB1198E9C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694126; cv=none; b=LW2Kwj9fX3Kj3cqleOAQPMQkuz7rmQlSp4HHr4dzZ89+MDkM8W7ujfPYrdlH3oEvRrrromSgBIzq7wQqwgOfAxH9DQX6xDZgkjWDFN/zu26wyFTno+IJyj+ATexb1uesAcp+APfTVsaoAyxcUu8NFc/vpH3dCxe+TZgzoDOhDTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694126; c=relaxed/simple;
	bh=QuSLEspvauRYDRZz063fX415QSr6sTsEnReWnJYDXVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pv2tBWDKJrMrbEOrY+t7G521YmR/UcHAinEvNnLYmqFetBPAAPWsV5pZO5fQ2ZXVZyWuZevxn5ZuFgm3pi+d6adtIDPiQSeTFwGGWrGJO2cwT2NX3bqRLQAPRKMoiHzXAQ+jhfr8SxeAuWMlGPJY6tmdETpVmoegv7g6gQtxTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OUmwdnOp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so5373775a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724694121; x=1725298921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiCSnJD3HP198YRuwR9nlOg90E6QQ9s3+l37OIn7TdU=;
        b=OUmwdnOpvRIWhkEmEAVhae0ZqGSgwqeyx6i6qmgV7GHgS1xbADzTRVPvgceJApGf3x
         zV6VD24l4MMAP9Bt2MOlgWr+Qj12uc5qs6ntTy/X2ASnAKtL/Cym4LNw3U50VmTQeO/i
         juLndVSyNOR5ONMpHc96US7Sw/pG260fBK0mkLsbdKiIvpc4rNN2hgwPEbzw/RqoJPGp
         K2pIRs0LjRIvcqg5hioX3Ad20YVVGMR3HJNaiUDk4e7+wso2WsNRuuRzIB4X4ikE+or+
         brky1YIWkYi/sMSX8D4bMwUiuq4/zWIfLJnI59tEaHzXBwzTZs0wuaV197pyP2SmWabv
         8e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724694121; x=1725298921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JiCSnJD3HP198YRuwR9nlOg90E6QQ9s3+l37OIn7TdU=;
        b=UP1wl+F67lCouyD9xo91TU7Dl2rYg5MXE1fWanVciKCcmFEwU1lroZ/VbyyDp2gZe0
         foxipkUBuv8X5hO8R443m7Q4eOoHWXqL192COpu7APGj/7EZLW06iSpw7iBWfKBbPTtl
         nRS4tnUFeLogtFuV7V9mWvqFuMCogehUx/Hp8NFvM8UsEec0viOIuj/4p9FxG00T/G4j
         LHzkLUppkYnh2GqdTkWG6bPOv4CLQ8eXJ/UwIpSIZfnHsbk3+nTo9HHAwsOZ/FfvdQiB
         zt3/+j28HLl5YtcrfeCV+mAYKPauRdKTSVZd8YWbbagaCoUjv8yhOcS1yJ/DfmtGRPMR
         wi1A==
X-Forwarded-Encrypted: i=1; AJvYcCVrnlkVeLnh6kt/KEDz2kzQNZQ+vO4pdio+5RWuBRiK7bpyQvbr0L5lWidG+AxhVHEmYFkb0zs9nDo3fgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfIsCGLZsmJqZaxM+JFI1XRI8SrEmAtQw0dDPhKmUzOgW+vw+
	eqouW7/aXBg/0VP1R+eVrZdmYzIN8BQvWwHvYuNjO1LRQLBC1R9eVvSF/BGxYIU=
X-Google-Smtp-Source: AGHT+IFr4go4JINnJLtcWs0BB1xC/SXPqe+y4XSFmlELq1W0LCxG/Dp4ZIa768YslVaqXV+TjwDVpA==
X-Received: by 2002:a05:6402:34c7:b0:5c0:ba90:6a9e with SMTP id 4fb4d7f45d1cf-5c0ba906ba4mr80529a12.38.1724694120916;
        Mon, 26 Aug 2024 10:42:00 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb213739sm9690a12.54.2024.08.26.10.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 10:42:00 -0700 (PDT)
Message-ID: <71505c05-b651-4740-b14a-a53084a16a61@suse.com>
Date: Mon, 26 Aug 2024 19:41:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] tools: Add gendwarfksyms
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
 <20240815173903.4172139-22-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240815173903.4172139-22-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 19:39, Sami Tolvanen wrote:
> Add a basic DWARF parser, which uses libdw to traverse the debugging
> information in an object file and looks for functions and variables.
> In follow-up patches, this will be expanded to produce symbol versions
> for CONFIG_MODVERSIONS from DWARF.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/module/Kconfig                 |   8 ++
>  scripts/Makefile                      |   1 +
>  scripts/gendwarfksyms/.gitignore      |   2 +
>  scripts/gendwarfksyms/Makefile        |   7 ++
>  scripts/gendwarfksyms/dwarf.c         |  87 +++++++++++++++
>  scripts/gendwarfksyms/gendwarfksyms.c | 146 ++++++++++++++++++++++++++
>  scripts/gendwarfksyms/gendwarfksyms.h |  78 ++++++++++++++
>  7 files changed, 329 insertions(+)
>  create mode 100644 scripts/gendwarfksyms/.gitignore
>  create mode 100644 scripts/gendwarfksyms/Makefile
>  create mode 100644 scripts/gendwarfksyms/dwarf.c
>  create mode 100644 scripts/gendwarfksyms/gendwarfksyms.c
>  create mode 100644 scripts/gendwarfksyms/gendwarfksyms.h
> 
> [...]
> +static int parse_options(int argc, const char **argv)
> +{
> +	for (int i = 1; i < argc; i++) {
> +		bool flag = false;
> +
> +		for (int j = 0; j < ARRAY_SIZE(options); j++) {
> +			if (strcmp(argv[i], options[j].arg))
> +				continue;
> +
> +			*options[j].flag = true;
> +
> +			if (options[j].param) {
> +				if (++i >= argc) {
> +					error("%s needs an argument",
> +					      options[j].arg);
> +					return -1;
> +				}
> +
> +				*options[j].param = argv[i];
> +			}
> +
> +			flag = true;
> +			break;
> +		}
> +
> +		if (!flag)
> +			object_files[object_count++] = argv[i];

I would rather add a check that this doesn't produce an out-of-bounds
access.

> [...]
> +int main(int argc, const char **argv)
> +{
> +	unsigned int n;
> +
> +	if (parse_options(argc, argv) < 0)
> +		return usage();
> +
> +	for (n = 0; n < object_count; n++) {
> +		Dwfl *dwfl;
> +		int fd;
> +
> +		fd = open(object_files[n], O_RDONLY);
> +		if (fd == -1) {
> +			error("open failed for '%s': %s", object_files[n],
> +			      strerror(errno));
> +			return -1;
> +		}
> +
> +		dwfl = dwfl_begin(&callbacks);
> +		if (!dwfl) {
> +			error("dwfl_begin failed for '%s': %s", object_files[n],
> +			      dwarf_errmsg(-1));
> +			return -1;
> +		}
> +
> +		if (!dwfl_report_offline(dwfl, object_files[n], object_files[n],
> +					 fd)) {
> +			error("dwfl_report_offline failed for '%s': %s",
> +			      object_files[n], dwarf_errmsg(-1));
> +			return -1;
> +		}
> +
> +		dwfl_report_end(dwfl, NULL, NULL);
> +
> +		if (dwfl_getmodules(dwfl, &process_modules, NULL, 0)) {
> +			error("dwfl_getmodules failed for '%s'",
> +			      object_files[n]);
> +			return -1;
> +		}

I see that libdwfl has also directly function dwfl_nextcu(). Would it
make sense to use it to simplify the code?

> +
> +		dwfl_end(dwfl);
> +		close(fd);

Isn't fd consumed by dwfl_report_offline() on success? I'm seeing EBADF
from this close() call.

> +	}
> +
> +	return 0;
> +}

-- 
Thanks,
Petr

