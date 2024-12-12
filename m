Return-Path: <linux-kernel+bounces-443047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C89EE63D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147541884DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E097211700;
	Thu, 12 Dec 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/MCG2jc"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE420E6EE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005007; cv=none; b=gB/fsznKgoGbmfGTl1gx+h1C9gUdjZcLMAYNwz65Qt3SUY9kNQn4aO8biBsnjF3U9N7WMmWeLYcpBoXj6W8wIxP/Kv3613BasRXW64FHBBjvCABOFpKDGJB9893pkfmAtqX7OCzBuARw88qX8+mdtpHsLXHvfomUrcPed0QYCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005007; c=relaxed/simple;
	bh=I+z2aQXNKSdPchEqBKGJf7iKnf+uosut8H0/YAEK+Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5/oozNFi7HSUSwqUlWBbcgbC/kad2IefDzoqHV0srgQITsnKWVVGoYpSmE0YUUSqlz3hb7f/UO+znYVh0ABRJS7ZVWeapePjmqlxu2ziF2p/7Won0ro4h92GDlOSRY7m0EtpndP/5Ly8VKGbvEK0xim0I2dBQGzGMPZ+X7S47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/MCG2jc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728e3826211so406253b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734005005; x=1734609805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8H1kLpsEkPiWWDJb8eSdKBuUSJU8siXOVQvVNi/wbZk=;
        b=c/MCG2jcw/nToiIZaYyev+SuNcSfkHoe10r8MtLEeUwt5WVfAoLq/nTlGZlxp8Ozld
         YlUTG9oXrHQBg3LfsXcSNA5uEEk7ab+MT95+tqobzn2ua4pNUBGswMmXPEZYyUciXGh3
         LNZeQxUf7T55eOL6nTMA51bKOIv2A3koza9Y3gy4YcltLbEmAt4B23Ge2I9pdgOQoBhJ
         D/3HuB4KIsTJ2pjAfH9nbwJ7TbUtIjpA0iv2swFPxHn9TzW2PSWvMtEKJhXiM2sTKZBT
         vTkBgNBJwnsHaTRqFFrOdVrPbekUF/seFYCzHyCjccaPYhbtYVopf5ac34ibyxhrI3Bh
         tqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734005005; x=1734609805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H1kLpsEkPiWWDJb8eSdKBuUSJU8siXOVQvVNi/wbZk=;
        b=EW2HX4t0XbA36eH/7k2BL9YsHGWGawGJ7nAsqjoBxd4aKWVLpe9GJcvgCp2uplu0oI
         lnXvFScNUsbEyrGIJlKWROMV2chJWAPkkjU2EnRRiMZzeTF1FuG1i3F62fv1E2Gy7v3r
         qXnm4qKm5+ByWNUvWkmUSgiMKnV4O9oQtF0XAw77s9ojH/lfp//W7X9OS68pZekfnE5S
         PiETBUL/TOY9gFvoSi2KWfTzj/3XI1D+XGxrZRTO+2GqzoXKp1Fjb7SHlLjXsh3VE5S9
         hGFpsz2ow2hIbTGHiiGcj02jR2gHjZ7qS4dIC8Bkacr2QOm8QARD5J0lzA14wqCduk52
         dfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXniDwNedi/zIg5bnGguuITm4/K1OyDvyfSiECdKMblOdpDn7wuox6YuNsTJnyBSr2p4O6BSCErbTwO58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjk7dyI5F6lr/5zmHP0U/NVNe6TrfkeJAkLa8MMVVZ1IR1L5JI
	lpfcio5PKIL4dG+1H0glBst4QMNp1tTa7R+UA+eWAuYrzYJCgJv0fppBWVMMjvXcsA7EdduIT+f
	M82KYjhlXevCg3N9g9RbVkZKfblASOQNHTNIpNw==
X-Gm-Gg: ASbGncvxgn3KhOVykOgTFfOWJaeD7+Ko8tfj9wLMPjQ45cbhl9DkZiqT/RDnqxXzgkK
	Uk7AESllys1o0XK/lU/wUhe2Gcssh1IuEh7wfhww=
X-Google-Smtp-Source: AGHT+IE+Kg8u9Lbn6QLKaDT/b3zDFNcKPhMdlgmxpI6xjlm9dAXphccBXriO7tXjnrHdrxfQu2FMYv1+/OPRV9wJcBA=
X-Received: by 2002:a05:6a21:78a4:b0:1e0:ce11:b0ce with SMTP id
 adf61e73a8af0-1e1cebde749mr4535655637.35.1734005005188; Thu, 12 Dec 2024
 04:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127134256.2254851-1-mike.leach@linaro.org>
 <20241127134256.2254851-9-mike.leach@linaro.org> <9cb1ef5e-eb61-4177-a039-4049850196a5@linaro.org>
In-Reply-To: <9cb1ef5e-eb61-4177-a039-4049850196a5@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 12 Dec 2024 12:03:13 +0000
Message-ID: <CAJ9a7VhG0Mxo=66JpGkPYDBLwo_fmv6BbLx2jPLeDd76f2gfCQ@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] coresight: tools: Add configuration table test tools
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, Suzuki K Poulose <Suzuki.Poulose@arm.com>, 
	Leo Yan <leo.yan@arm.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi James

On Tue, 3 Dec 2024 at 14:25, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 27/11/2024 1:42 pm, Mike Leach wrote:
> > Add an example config table generator to test loading configuration
> > tables.
> >
> > Provides a table buffer writer function that can be re-used in other
> > userspace programs.
> >
> > Table write format matches that expected by the corresponding reader
> > in the configfs driver code.
> >
> > Generates tables and outputs in form of binary files.
> >
> > Add a config table file reader and printer. Takes in config table files
> > and prints the contents. Uses table reader source from kernel driver.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   MAINTAINERS                                   |   1 +
> >   .../coresight/coresight-config-table.h        |   5 +
>
> Hi Mike,
>
> Isn't there some convention about maintaining a copy of kernel headers
> in the tools? Especially as you wouldn't rebuild the tools after
> updating the kernel headers so breakages might go unnoticed.
>

Not sure - perf keeps a copy and has a check script on build to ensure
the copy matches the kernel version.
Keeping two copies of the same thing always strikes me as poor
practice, so I went for copying over.

Both methods risk breakages when something in the kernel changes.

> [...]
>
> > +
> > +/*
> > + * sets of presets leaves strobing window constant while varying period to allow
> > + * experimentation with mark / space ratios for various workloads
> > + */
> > +static u64 afdo_set_a_presets[AFDO_NR_PRESETS][AFDO_NR_PARAM_SUM] = {
> > +     { 2000, 100 },
> > +     { 2000, 1000 },
> > +     { 2000, 5000 },
> > +     { 2000, 10000 },
> > +     { 4000, 100 },
>
> The comment above here looks like its for example1, this one does vary
> the window size.
>
> Probably only example2 is enough, I assumed they were different but
> example2 is basically the same as example1 with an extra preset list. We
> could comment that the second preset list is optional and delete
> example1. Saves people reading more and wondering what the difference is.
>

Yes - perhaps both examples were not necessary - but the point was you
can have two configs in a single loadable table.

> I tried to make an example that doesn't use an existing feature by
> reacreating afdo from scratch which I thought would be a good example.
> It's pasted at the end. I had to copy paste the ETMv4 macros and
> constants though, I couldn't include them in the userspace generator
> because of this error:
>

The updated ETM config set that is to follow addresses this issue -
the macros are split off into a separate file  (and adds in a whole
lot of validation - ensuring a configuration cannot specify and
allocate more resources than are available.)
This is also the reason that the examples provided were very simple.
More complex ones are to follow!

This set was focused on loading tables so that the next patchsets
dealing with resource validating ETM configs and CTI configs had an
easy to use test platform.


>    coresight-config.h:10:10: fatal error: linux/coresight.h: No such
> file
>    or directory
>     10 | #include <linux/coresight.h>
>
> I also got this error when loading it:
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000008
>
> cscfg_reset_feat (drivers/hwtracing/coresight/coresight-config.c:64
> coresight-config.c:124) coresight
> cscfg_load_config_sets
> (drivers/hwtracing/coresight/coresight-syscfg.c:217
> coresight-syscfg.c:262 coresight-syscfg.c:492 coresight-syscfg.c:610)
> coresight
> cscfg_dyn_load_cfg_table
> (drivers/hwtracing/coresight/coresight-syscfg-configfs.c:294) coresight
> cscfg_cfg_load_table_write
> (drivers/hwtracing/coresight/coresight-syscfg-configfs.c:799) coresight
> configfs_release_bin_file (fs/configfs/file.c:415)
> __fput (fs/file_table.c:432)
> __fput_sync (fs/file_table.c:517)
> __arm64_sys_close (fs/open.c:1568 fs/open.c:1550 fs/open.c:1550)
> invoke_syscall (arch/arm64/kernel/syscall.c:?
> arch/arm64/kernel/syscall.c:49)
> el0_svc_common (include/linux/thread_info.h:127
> arch/arm64/kernel/syscall.c:140)
> do_el0_svc (arch/arm64/kernel/syscall.c:152)
>

I'll go back to my tests to check I was testing what I thought I was -
and didn't accidentally change something after testing and before
sending the patchset.

>
> So I'm wondering if we can do the same thing by setting values via
> individual files rather than one binary blob which would avoid some of
> these issues. From what I understand the feature params can already be
> set directly this way via
> /sys/kernel/config/cs-syscfg/features/strobing/params/period/value
>


> We'd have to add a way to add new configs with a mkdir, then the same
> things can be configured without needing an additional tool. Links
> between features and configs can be done with symlinks which is also
> mentioned in the configfs docs.
>
> Something like this would be a bit like the current version:
>
>   # ls /config/cs-syscfg
>   configurations
>   features
>
>   # mkdir /config/cs-syscfg/features/my_config
>   # ls /config/cs-syscfg/features/my_config
>   description
>   matches
>   regs_desc
>   params
>
>   # mkdir /config/cs-syscfg/features/my_config/regs_desc/TRCRSCTLRn0
>   # ls /config/cs-syscfg/features/my_config/TRCRSCTLRn0
>   type
>   offset
>   val
>   mask
>

This is precisely what I wanted to avoid. Doing it this way is both
time consuming for the user and ends up reproducing most of the sysfs
files in configfs.

Parameters are there to allow a limited amount of relevent runtime
adjustment. Parameter values may also only populate part of a hw
register depending on use case.

The resource approach allows us to define certain bitfields e.g.
Branch broadcast - as user configurable - but omit anything users are
not allowed to meddle with.

The table load is atomic - it is validated and succeeds or fails
completely. The load mechanism prevents the new configuration from
becoming visible until it is loaded. The configfs per file method has
an issue in deciding when the configuration is "complete". If you look
in the configfs docs/source there was at one time  a  "commit"
methodology proposed, but this never came to fruition.

Table load  re-uses the same mechanisms as the built-in and loadable
module methods for adding configurations, but without the need for
re-compiling the kernel / compiling against a specific kernel -
meaning loadable tables are dependent only on the hardware available,
not the kernel version. Adding a per file option means that the new
configurations would be different from the current load methods
upstream - and appear differently in configfs.

> But another way could be to enumerate all possible regs for each device.
> This would remove the need to have all the #defines in whatever tool is
> making the config (avoiding the #include issue from above):
>
>   # mkdir /config/cs-syscfg/features/my_config
>   # ls /config/cs-syscfg/features/my_config/regs_desc
>
>   regs_desc is initially empty, but specify what device it's for to make
>   all the properties appear (or the mkdir could be done in an etmv4
>   folder):
>
>   # echo "SRC_ETM4" > matches
>   # ls /config/cs-syscfg/features/my_config/regs_desc
>   TRCRSCTLRn0
>   TRCRSCTLRn1
>   TRCRSCTLRn2
>   ... etc ...
>
>   Now type and offset don't need to be set:
>
>   # ls /config/cs-syscfg/features/my_config/regs_desc/TRCRSCTLRn0
>   val
>   mask
>   save
>
> Don't we already have the full list of parameters in
> etm4_cfg_map_reg_offset(), so we can expose this to users via configfs
> directly rather than needing any tooling. And doesn't any new device
> that's supported by the config mechanism need to know about all its
> parameters, so it wouldn't remove any flexibility?
>

Mike


>



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

