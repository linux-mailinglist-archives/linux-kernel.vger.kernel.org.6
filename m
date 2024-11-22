Return-Path: <linux-kernel+bounces-418628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2279C9D6399
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58F2282BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613E16E88D;
	Fri, 22 Nov 2024 17:54:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD80175A5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298087; cv=none; b=nip3+Q+ylLFsE1iv95fi+a2D3n1eEiO5bY6GRZSkN7Jsa8bqkp58ef0r3RiFeZiXInxu9d/zZNEAO56AbtM89ln2ax4tnV2qaoaU/HGehybMg86FMeGRxFJgxitlpSv2066mvUpGmUPDDEprJugIOP0O41DcSfppoI3KSFHNDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298087; c=relaxed/simple;
	bh=/mvdFdRNF+RklspwiMcb++DdVDzsmEG4GZMLnpSH9lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ/pdstME2dbq2h/MxFLVe1JSDQ4YcfalsBXIMIioFKGNyHVM7BCCaOEPakO3OH+Kos0OyFu0i4EfSBuJe2nChB2SyHKLgOggdjK3DaR085pGr36sc7WoSPcBbJ3c9HIxXby2+3TW4EcfUb7eJOyYjuBa9T9KKh1G+CGocBqZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A99AC4CECE;
	Fri, 22 Nov 2024 17:54:46 +0000 (UTC)
Date: Fri, 22 Nov 2024 09:54:45 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] objtool: Collect all annotations in objtool.h
Message-ID: <20241122175445.tx3edadmof76yegs@jpoimboe>
References: <20241122121016.372005127@infradead.org>
 <20241122121556.560621502@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122121556.560621502@infradead.org>

On Fri, Nov 22, 2024 at 01:10:25PM +0100, Peter Zijlstra wrote:
> +#ifndef __ASSEMBLY__
> +/*
> + * Annotate away the various 'relocation to !ENDBR` complaints; knowing that
> + * these relocations will never be used for indirect calls.
> + */
> +#define ANNOTATE_NOENDBR		ASM_ANNOTATE(ANNOTYPE_NOENDBR)
> +/*
> + * This should be used immediately before an indirect jump/call. It tells
> + * objtool the subsequent indirect jump/call is vouched safe for retpoline
> + * builds.
> + */
> +#define ANNOTATE_RETPOLINE_SAFE		ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
> +/*
> + * objtool annotation to ignore the alternatives and only consider the original
> + * instruction(s).
> + */
> +#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)

This is a good start, though it would be really nice to have them *all*
together:

  - move ANNOTATE_INTRA_FUNCTION_CALL down next to those ^

  - create ANNOTATE_INSTR_BEGIN and ANNOTATE_INSTR_END, and then do
    
      #define instrumentation_begin() ANNOTATE_INSTR_BEGIN

    to keep the existing syntax.  Then instrumentation.h is no longer
    needed.  The nice comment there can go above ANNOTATE_INSTR_BEGIN.

  - similarly, create ANNOTATE_UNRET_BEGIN and just do

      #define VALIDATE_UNRET_BEGIN ANNOTATE_UNRET_BEGIN
    
    since the VALIDATE_* syntax is more descriptive.

So basically even the macros with non-ANNOTATE naming still resolve to
ANNOTATE_FOO, with all the ANNOTATE_FOOs in one place, each with its own
nice comment.

BTW, is there a reason .discard.[un]reachable weren't converted over?

-- 
Josh

