Return-Path: <linux-kernel+bounces-185139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0758CB110
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0653B1C20AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CA143C5B;
	Tue, 21 May 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bcIXzonQ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85638143890
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304401; cv=none; b=FdCn72F6r1HFy3dpt41+zSQJmN+uFHDJq8sx7NhzVAV2DheqcoSQAO9wtP56eHVa6PbnZja60THM0eJ+vw28KPXNA/cPTlC8qMpApzn7eoIfajAObwlzccVWaqZn0c5owPSV2BrYFBMumhC5fchgPOln1PnT3P8rQOax0r8fLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304401; c=relaxed/simple;
	bh=8bE5fmp7cBc38Xs4Y+ED2s5xVGd7IlXH9uf9nvvaQhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLhFOWe5JLLtuG3Y9VV/ShrUCipcKbdlLpiRIDCLsktCFb7DaxwxffzykBF4E845NM06ll6IX61uJK4KjMlQ7Gttd2173bkzE4yP8nbsXucIP4frHjYxUhwRTDYbC4fowPqWaseVq0b2lroJDdOEWI9eQPYl8xK5aMyWEehnFdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bcIXzonQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso10012343a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716304398; x=1716909198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/hhHlpDkBPz/Bdt9MnJbXdgG7b5bZizGlH9JPpsLwE=;
        b=bcIXzonQKb3WEE/D9qMpTf/N0USA9axXXB1fqqpf2S/9vW+FzFRJI9mxnv+ZPBlQw2
         v9Mn25t3ZkDP+S1wpWsTWqe7FmetEoUHW3cnBD9SLt6GxnKaSkCyfJA4bRWAKdIAzzD9
         garHflK/rLSsAF+saLjXCvdmNQQipEb0EUuBt8S5kQYRVSZN1inzJRhXoqexHsmuBn13
         hvyapSlLyuDIvQD6YeSnFVtidHTx0IUWTIoRYrIL/xHVFM9g1mFT+mkvTkaEaFi+Pxw4
         q0dxjVwFgrrl6RGhYrCi191P/jmRY5W7Ub+aEtFYbZvQuxovgIX+uqY/TTnI/OWgHbsS
         +g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716304398; x=1716909198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/hhHlpDkBPz/Bdt9MnJbXdgG7b5bZizGlH9JPpsLwE=;
        b=iuNtUN2OpJNE2oQf0xoCZa90+3t+XGuMHRaEpSFJe3zG8MB7ja4pzgbybJJfTPI7C3
         BDWl9cZ3loJkj8JzEBax8RdudgYv41d7C/koAU0WTCOL6+pLwRb7KeucWQh7oT/SViJ6
         gYOnaKjUzDUt1F8JVfJaQtwd/HGL+YluFYvopI8EDw2I8M4ZDo1r/Pd5GkS5pcVijqrg
         GCDo26TB+lH4thga4YO3cSPsSo906umQ9GFsfvXAQci+d82kyHZ4H8vgOLOD7itq1pwR
         g0iXOZTfy94V0bKW74j8co2iqmlr6yPI3k5BCQ1cvLQ53aBSKWE59IGSYKwGZ0pAy+Gu
         BZ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC73IK2UvmnZCtOXDRf7QsMvgn/2dD2ogyFosvaPbpxZPzTIVtNQx9seOOPctfpwfSqs6NMUC8bANqtp0mCHRbYIqjaOBOaB8DW+UC
X-Gm-Message-State: AOJu0Yx8/8jW/0Sjew0hmftLbhabvtJirNI812aFSJN76VDUPPy7eKod
	wxbGzPnp+w3/9308PRk4u/bfz2RtDSAHQPPdTbZG1I3PTy99bS4ibVs6y9MpTXg=
X-Google-Smtp-Source: AGHT+IFjeDGfQSIgCYQjE52LyJ/4I80QnU4E68af0RwtcyO1ZjGJhj2y9H0kZHSyfcbPTVxSygxfmw==
X-Received: by 2002:a50:8ac7:0:b0:572:4e6b:c31 with SMTP id 4fb4d7f45d1cf-5734d67ecc8mr20016557a12.34.1716304397844;
        Tue, 21 May 2024 08:13:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfbd3sm17295650a12.44.2024.05.21.08.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:13:17 -0700 (PDT)
Date: Tue, 21 May 2024 17:13:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH printk v5 30/30] lockdep: Mark emergency sections in
 lockdep splats
Message-ID: <Zky6CwR-Rycp0trp@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-31-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-31-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:39, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> lock debugging output are generated. In an emergency
> section the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console
> output is triggered when exiting the emergency section.
> This allows the full message block to be stored as
> quickly as possible in the ringbuffer.
> 
> Note that debug_show_all_locks() and
> lockdep_print_held_locks() rely on their callers to
> enter the emergency section. This is because these
> functions can also be called in non-emergency
> situations (such as sysrq).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

