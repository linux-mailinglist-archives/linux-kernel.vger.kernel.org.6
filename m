Return-Path: <linux-kernel+bounces-286260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D69518CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A732845B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DD1AD9F9;
	Wed, 14 Aug 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtpMsxD9"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1913635F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631386; cv=none; b=JBh82MRl3LbgUliL5DGQfvIBSheaS/1BeDcVi1xSIIgUC2winJtCBdbFEi0AaXWRBVoLhW/MkxXsy5pf9DXqiepHuWomOuuySfBg3KHd+EJf/Vs2XOdy7OsF0s5a0Ze4iav1xrtGFCYDU6TX8/JQUqsMuMaciPDgwD2G0FnF2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631386; c=relaxed/simple;
	bh=H5FuCu3NqJRvNltn8juCtpVQnpUb7NyqPa8u2frEw7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtGTj0LMFO/pWHzgJhoFAYQ+AOobFY6xRuzx06Nt/YfSRDxxqweIpOAOWDzK4yQOeGM/AqtVQUAC+VrRq0AKRonNPijs9ztjc57fGjsxSun9S/SRCIqSQJVCbo/a4qpXyUdIfcV4lZ7uCgCymQLVGParo7dqqf4GKLK7cJPb8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtpMsxD9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426526d30aaso44421335e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723631383; x=1724236183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5FuCu3NqJRvNltn8juCtpVQnpUb7NyqPa8u2frEw7c=;
        b=gtpMsxD9MAq1PlITmBBBGNYInG+0YC2U9Pc8MoGvkzbHB9PcnQIybJ6e0RP+zUCTVW
         Mr2fAPkONjw62glc8r35/6zGQDJCiVgYJMeZs6vOHD2c34fERJJ3QZaLMrKDMef1SlA/
         4eh8utCZqPOMMEM6g7knAX+emnN4yRz3h4K/FcVvlemmN4XhfsZ2ACdYWNw0Qpau+PPs
         XefRs09WpUqHYlzcivDKUY6tHtwEvu2iO02M/WvQvOIFXyVnZdBQAJtE3854BH7iZ2IM
         Ms7VtJfFXXIU6J6l1mLGVevAhzxoReKkBd26o/YJknbPkH2tjeqgzctEyRSTPugYjZEW
         ftuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631383; x=1724236183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5FuCu3NqJRvNltn8juCtpVQnpUb7NyqPa8u2frEw7c=;
        b=sDYNvB0xFSuJ0b+QdPLQh4CHps5YbtiHR4tXPFyBCTvZ2HiRsLpCZvDAHerBIO9r6c
         qgUTb/9btxUZvouZjEfyg0GwSxkozoOLaqMYIR6ItSOLKTVrJ5cS3KSwZa85hxISsIAH
         TWzkxmGK5yJ6sIsw3brdZycCPpjAFhdFN+P8pVhaE6oKGTWChutdN2fuZw8YNWW/nCp9
         n3HYojNl6K2sxgQlqA+2znpyUo2z9BOjlsMj/30wH80lRSftP1u79RzY9u6fSqcihXYD
         DFWDJkNpw9/L03H+82Jyo4wjYGrlFOaM6ABlWCMUomyV9nU2fmJxwAbSfuMK5AsbDtpx
         uSgA==
X-Forwarded-Encrypted: i=1; AJvYcCWjStkfb2SiwM3+v47gC40zVc3TeYrYl2idhctclNmmz1ABIgq/eSbVNVAUclluDD+A8j96f1flKeDmbPfPhMM+oBH6jnnSDsOa9nFn
X-Gm-Message-State: AOJu0Yy40SiIlP6TS8oRa2o5BUSGMAm9aJ3VpkQC7yJAQ925eGEbI4O5
	RZqj2TZblHfjQVdFT2xynU+EJVIfNCo7seu1QzBn/BPe5nvEk9KE8LxM5N5ca+E=
X-Google-Smtp-Source: AGHT+IEIZ+M+9sJc4G+wlZV0MZMDBrsLYiiZSlN9aXdqGOAxtY4Ol5fV5IPg+RKTu+K6Iu0NsRkJCg==
X-Received: by 2002:a05:6000:180d:b0:360:7971:7e2c with SMTP id ffacd0b85a97d-3717782e636mr1708203f8f.54.1723631382490;
        Wed, 14 Aug 2024 03:29:42 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeef38sm12345885f8f.53.2024.08.14.03.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:29:42 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:29:40 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Florian Rommel <mail@florommel.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
	Stefan Saecherl <stefan.saecherl@fau.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kgdb-bugreport@lists.sourceforge.net, x86@kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH WIP] x86/kgdb: trampolines for shadowed instructions
Message-ID: <20240814102940.GB6016@aspen.lan>
References: <87wmkkpf5v.ffs@tglx>
 <20240814085141.171564-1-mail@florommel.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814085141.171564-1-mail@florommel.de>

On Wed, Aug 14, 2024 at 10:51:41AM +0200, Florian Rommel wrote:
> Experimental implementation of Thomas' trampoline idea.
> Link: https://lore.kernel.org/all/87wmkkpf5v.ffs@tglx/
>
> Every breakpoint gets a trampoline entry containing the original
> instruction (with a corrected displacement if necessary) and a jump
> back into the function to the logically subsequent instruction.
> With this, KGDB can skip a still present debug trap for a removed
> breakpoint by routing the control flow through the trampoline.
>
> In this experimental implementation, the actual removal of the debug
> trap instructions is completely disabled. So, all trap instructions
> planted by KGDB currently remain in the code, and KGDB will skip all
> these breakpoints through the trampolines when they are in the removed
> state. There is not yet a dedicated breakpoint state for the
> to-be-removed-but-still-present breakpoints.
>
> Inspect the trampolines via:
> (gdb) x/16i kgdb_trampoline_page
>
> Signed-off-by: Florian Rommel <mail@florommel.de>
> ---
> I have been experimenting a bit with Thomas' idea of the trampoline
> approach. It seems to work so far but of course has a lot of rough
> edges.

Interesting. Perhaps a dumb question but is this trampoline code doing
the same thing as the out-of-line single-step code in kprobes?


> I am stuck for now, as I am not sure about the best way to implement
> the safe context where KGDB finally removes the int3 instructions.

I think this would actually fit really nicely into the debug core code.

Firstly dbg_deactivate_sw_breakpoints() should strictly maintain
BP_ACTIVE and BP_SET states (e.g. if the kgdb_arch_remove_breakpoint()
fails then do not transition from BP_ACTIVE and BP_SET). There would be
a little bit of extra logic to clean things up here (each equality check
on BP_SET needs to be reviewed) but the resulting state tracking is more
correct.

Once we've done that we can add a new state BP_REMOVE_PENDING and
arrange for this to be set by dbg_remove_sw_break() if the breakpoint is
BP_ACTIVE. At this stage we can also arrange for
dbg_deactivate_sw_breakpoints() to handle BP_REMOVE_PENDING to
BP_REMOVE transitions by calling kgdb_arch_remove_breakpoint().

That's enough to eventuallyremove the int3 instructions but it relies
on entering the debug trap handler and there's no limit on how long
could take before that happens. For that reason I think the core should
also attempt to transition BP_REMOVE_PENDING breakpoints to BP_REMOVE
after kgdb_skipexception() returns true. That means if we keep trapping
on a disabled breakpoint eventually we will hit a window where the
text_mutex is free and clean things up.


Daniel.

