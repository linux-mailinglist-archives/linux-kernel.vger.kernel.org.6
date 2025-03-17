Return-Path: <linux-kernel+bounces-563779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D5A64842
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A96F1895E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560222B8A2;
	Mon, 17 Mar 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gz6xstM0"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD3226D1F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205218; cv=none; b=GW5ZDRgWMx45PvgZ6IcpZKDim8O9fleUg2OGm8M8F3TyXb2kkwL4G7/yc+/4SBLN4/Ei+gzaoVHCXvGcYPoQ599BhwWLEpZFt++MOOd2NohfPboqfRIulFuU9cTojs5dDAadkVbtJt54tTeUCEM1/IYFGyqLdurA2fitncFUw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205218; c=relaxed/simple;
	bh=kFwvhri15B+bhiEF5YIaJiH0jlNBqSJbir6+O9c34hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8pdbeYE9U+AUIFMoAsYxrR8IqX1cIkAlvlSjdMcvd7rlhjvjZK5Psgx4JNbl0Ia+B/8tQMAaFy9kOfe7bOV0TBshvqaJ+J9sFlttdqRs9ijjPnjMBEnNZoyG0wSGDBUDDOSM/dIou/Db1ANBzFkU73Zlw9WxjhoXjtY4szErZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gz6xstM0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso71645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742205215; x=1742810015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba+wJcLPvxNpkRxHx8/4AjdW+xhwFCgiAYOR4VStFIA=;
        b=gz6xstM0smxQlqpYve9AgZQavRoyeSBz2GRrLeAptU60urPUgw8ZcLIolfAGL7a5R4
         jZtA71GSS8yO2+DwNSIcDFwbjk6L7Bq+23o6Ev/2/AMWKTOwjp7mTslWPorZNU/kRstR
         ikkbyopv3Ay1iDRRfK3ehGeCQzaH5kMvRAed+5mvc30Zfx53bvK9vtTIpwIenf+5vJ6F
         83MB9RxeK108cCed3tgBWPRtry+YkUmIx46Fdwm+Ci0Gl4TCnQUEG8ypp/Mqwag4oOqE
         VshsXdAe2ltPnOqgA5vTsGTyEJCj/jDRqps4Aw+bYITKk6x9dFAf9SQLRbuOKQQD1MHC
         ay1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742205215; x=1742810015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba+wJcLPvxNpkRxHx8/4AjdW+xhwFCgiAYOR4VStFIA=;
        b=OvVL3teSOC5JlSNeHPjRNVgQ0p6FpXOIxqDlQ3/v1sA/FonghBCvEk3sWGG30HC/9w
         Bk8SpMzLrHWO/is8O6nuGF5/7KzgnBdqrSsRgrXBCt7UuJDed0AKeI4KSGB9kuu/z/Xd
         4mMbKij4FdscdIvVSwQ55mUjbZnegdTvTORRkXMJE7MWnrHphqz6w2iAea7CxCs60HHy
         w2I0yvuZuY6CGKXf3I+5ys85MiMPhLEaAQ0PnIMrJCYYhV2XvLL3d/NONkmjgvee/jDk
         izyWEpHD4GuQ+krIxrvZOSac7xkmR/pKP40RdhjTWieXD4EmBRGtd6HTfEMkQJ2QzKD/
         47vA==
X-Forwarded-Encrypted: i=1; AJvYcCUJQtUx6sbiWJ4LJgoBym5twZVTFTwZfulijOo7ZNt7j0WOooO6MS/eJtb+6bs0/i8JRKqrw7vP60d+CEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxous/JmOSJYBGj5xPnX5ELgE5GXt9ZH49hO1/skJZ0agedUNU
	6tij6xexKia8cJU1/y3rExeMoWfQzkAuD5iolGaKzlXaX6GgyVMqd+y2svWOeQ==
X-Gm-Gg: ASbGncvzY3AlAwKyvGeApovRswa59+TrJqBcb0eIdQl1tV/qWs/tPTXyNEFckoFsyNR
	DKmUEwHRZVA2WqUStonff5deqHaAe31iwaYjrsTBxtMDMT10je/2JMa2EdgwRopjQp6VXsIqrhc
	gM0BeK47KcR50gghYmvA7NMHvvLCh/9GLee8033r7ulTR0L3M0EwxHOYrA2QP3nQiCrJYNTeoL9
	KMNt/5M7k1j9j6SsaQoDCcdRFagfDilFP1bsVsS9za6gHDuXRVQg34XTAc7w7U45+vNLL97NvX+
	Bt4q/bC6tJRIsrGKi4xeB9qtuF0S+BurQwyHWbdlHHEnmcQLhYgBSrVyJGwYwCpM781af1YNtg+
	np2Dxv95ydQ0ajyX2KA==
X-Google-Smtp-Source: AGHT+IHsePywOjLpEvEKRsofLcHv+YvfFOwwLWj3d0NuKaMBNbcxeEz5q2YCN7wOB/08IIBW2VOu7g==
X-Received: by 2002:a05:600c:6d07:b0:43b:b106:bb1c with SMTP id 5b1f17b1804b1-43d2518e332mr2401985e9.0.1742205215055;
        Mon, 17 Mar 2025 02:53:35 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbcf95sm99218355e9.14.2025.03.17.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:53:34 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:53:30 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 12/13] objtool: Create backup on error and print args
Message-ID: <Z9fxGnRq041ZNLdw@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <7571e30636359b3e173ce6e122419452bb31882f.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7571e30636359b3e173ce6e122419452bb31882f.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:10PM -0700, Josh Poimboeuf wrote:
> Recreating objtool errors can be a manual process.  Kbuild removes the
> object, so it has to be compiled or linked again before running objtool.
> Then the objtool args need to be reversed engineered.
> 
> Make that all easier by automatically making a backup of the object file
> on error, and print a modified version of the args which can be used to
> recreate.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>  		unlink(opts.output);
> +		goto err_msg;
> +	}
> +
> +	/*
> +	 * Make a backup before kbuild deletes the file so the error
> +	 * can be recreated without recompiling or relinking.
> +	 */
> +	backup = malloc(strlen(objname) + strlen(ORIG_SUFFIX) + 1);
> +	if (!backup) {
> +		perror("malloc");
> +		return 1;
> +	}
> +
> +	strcpy(backup, objname);
> +	strcat(backup, ORIG_SUFFIX);
> +	if (copy_file(objname, backup))
> +		return 1;
> +

I think there should be a comment here like

/*
 * Dump a command line with the original filename replaced with the
 * backup filename.
 */

With the context from the comment above it's obvious enough _why_
the code would do this, but it still takes a few unnecessary brain
cycles to figure out _that_ it's doing that.

Or alternatively just print "command line to reproduce:" before the
modfified argv or whatever.

