Return-Path: <linux-kernel+bounces-190054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7114A8CF8DC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6921C20DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CABED53C;
	Mon, 27 May 2024 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjMKekyt"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9842E15E88;
	Mon, 27 May 2024 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716788853; cv=none; b=tlIF6JwbBNcV67Um/hQRCxuHGeTNy/1JXok5WhLciXw6f0WLiiFOA4MyrEOiVWp6bsl9VHXASRMFF7Id8MMmMUqrsBR6ZZn49oFedwFcG0tEaxrL8Gzy3lgvqWJAnanmVACKN0hV2L4j+O2Xme1BmXTgbAOZz6vkLftpcokSXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716788853; c=relaxed/simple;
	bh=UZnhecmeXbbrEoLxOHcMOXns2/3idVK9mkljAg66e2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx8kg1djYz7yE2l6BkFbniemUF1CZgfCsFgh6Y4vRBo4Ku8JnOEPdpSKHjeqVrSXves1nKFAESxP1qPH+2d3ZptEhwzorPxTQNOCM54jHo6IEstjMzXETv8TXVxycK4RRg0L74Qqw5zXtwosl9Dv4wYID9DQlBXy4bj4EvLkoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjMKekyt; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62a2424ecdaso11464747b3.1;
        Sun, 26 May 2024 22:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716788850; x=1717393650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wuQsWqcRb/ut6pFdVAgGVxlrs/eLie+IuFi3YLeBQ8=;
        b=cjMKekyt12uTaRLfvnWyIez13l2FqX3kXSAn7HpuqYpvNPiIm0NS1oa49BK9rxv6Bd
         8GuI5NymFg94WHDferlyKWl+RmCKRSR4tDbMdghkPzxn3kmDD0za03FTC7ECzwtwOUGF
         1NZbKXzsPA77XiorwGVV8XdjANWNjIKXygTrQRFx5oTG8Fw0gtnxw7YF/820kj1XzAM4
         qQ7ZqkDCavTrBU4puHl7BlSrAyew1/aDCb3PI0m2SFh29Qu7rEpdmLGyIDuVxLyU9AVE
         ILKIgZok6Aj+RQrPA4dlF1V4/97Bv3JIDRI419iKwUvKyLaQsWC9J8eCDcIHErxXggY5
         /nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716788850; x=1717393650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wuQsWqcRb/ut6pFdVAgGVxlrs/eLie+IuFi3YLeBQ8=;
        b=HiEdVUsYtSEgOXVk+pEWPzYyhH64fiQIEDGFfAO2KvuYlaIMtrNBH53ZwGtYrVOy+m
         KXsFtvYTdOQkplvN7PLU0IKQlEmepNRDDXnqlf8uularhNhhjfDrsCnIQ8eTfoB0fSTS
         wV1YEjyJbVXntjD4cySkS8kp86sGsJiDcnEK12lgbb+QAMrwmbuUXQyvcI63U/+wMFzy
         rKFktnF7l8F0sS0glXJMZ71LN8ScsmE6iKavm0Lg1XYYQvtbnM1Himz0aE4fmh/Y/rJ4
         acpU14790YZ4xzRf0Jv+OIO9AXrTxexnT4dIOOjwO0bnJ3+8gxrsqETAqnLNph7dzUsG
         wKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDzfxZwn29QyYr6o3u0ge1Y2kSVg+TjMjaPcyNkVtf+9I8Sxjyz0jDr5DHLkq7FCwDXx5XM7LxLPgWM7DYZZaAtMrMgAY5rlc42VlwrdAN7F/sQy8eBiKB7qHcL9nI0xFhoebxsF/jl/AlUbj+uiWr
X-Gm-Message-State: AOJu0Ywph1v3zoijy3dF55ZE2eEtfRDswVgCMrNNXONpmQCfhXO2YEHD
	ISsELV9XxxqU5uE1jmmCfveerP1KEMv7dANZMM3IjpS27XTqMpsQbsIxwi/3m1E=
X-Google-Smtp-Source: AGHT+IG9cacgoozF1UpjTLhNDVVFVyz7WvORWObuiGEhegriyTd329fQxfglvwuvyjJltbUxGRoHhg==
X-Received: by 2002:a05:690c:fcb:b0:61a:cc3c:ae69 with SMTP id 00721157ae682-62a08da023dmr102303487b3.18.1716788849758;
        Sun, 26 May 2024 22:47:29 -0700 (PDT)
Received: from archlinux ([240d:1a:13a:f00:f3a2:fbda:2824:ae0e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682227f1c82sm4482817a12.47.2024.05.26.22.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 22:47:29 -0700 (PDT)
Date: Mon, 27 May 2024 14:47:26 +0900
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	tatsuya.s2862@gmail.com
Subject: Re: [PATCH] ftrace: Fix stack trace entry generated by
 ftrace_pid_func()
Message-ID: <qnjsb2h5osocwjyi6vilkohe4qzc5iwjabfhdr5iuzwyhbhdoq@tw6ymc6xyyfb>
References: <20240526112658.46740-1-tatsuya.s2862@gmail.com>
 <202405262232.L4XH8q6O-lkp@intel.com>
 <20240527081719.a3f5b4c270d54a0453e3464f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <20240527081719.a3f5b4c270d54a0453e3464f@kernel.org>

On Mon, May 27, 2024 at 08:17:19AM GMT, Masami Hiramatsu wrote:
> On Sun, 26 May 2024 22:51:53 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Tatsuya,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on rostedt-trace/for-next v6.9 next-20240523]
> > [cannot apply to rostedt-trace/for-next-urgent]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Tatsuya-S/ftrace-Fix-stack-trace-entry-generated-by-ftrace_pid_func/20240526-193149
> > base:   linus/master
> > patch link:    https://lore.kernel.org/r/20240526112658.46740-1-tatsuya.s2862%40gmail.com
> > patch subject: [PATCH] ftrace: Fix stack trace entry generated by ftrace_pid_func()
> > config: x86_64-buildonly-randconfig-002-20240526 (https://download.01.org/0day-ci/archive/20240526/202405262232.L4XH8q6O-lkp@intel.com/config)
> > compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240526/202405262232.L4XH8q6O-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202405262232.L4XH8q6O-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> kernel/trace/ftrace.c:102:6: warning: no previous prototype for function 'ftrace_pids_enabled' [-Wmissing-prototypes]
> >      102 | bool ftrace_pids_enabled(struct ftrace_ops *ops)
> >          |      ^
> >    kernel/trace/ftrace.c:102:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >      102 | bool ftrace_pids_enabled(struct ftrace_ops *ops)
> >          | ^
> >          | static 
> >    1 warning generated.
> 
> This is because the prototype in linux/ftrace.h is placed in the 
> #ifdef CONFIG_DYNAMIC_FTRACE block. The prototype needs to be moved
> outside of the block.
> 
> Thank you,
> 
> > 
> > 
> > vim +/ftrace_pids_enabled +102 kernel/trace/ftrace.c
> > 
> >    101	
> >  > 102	bool ftrace_pids_enabled(struct ftrace_ops *ops)
> >    103	{
> >    104		struct trace_array *tr;
> >    105	
> >    106		if (!(ops->flags & FTRACE_OPS_FL_PID) || !ops->private)
> >    107			return false;
> >    108	
> >    109		tr = ops->private;
> >    110	
> >    111		return tr->function_pids != NULL || tr->function_no_pids != NULL;
> >    112	}
> >    113	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

I understand. Thank you.

