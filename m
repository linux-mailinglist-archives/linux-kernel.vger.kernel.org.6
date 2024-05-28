Return-Path: <linux-kernel+bounces-191660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818398D124F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8E31C212AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D448101DE;
	Tue, 28 May 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnNvM5Cv"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DAF8825;
	Tue, 28 May 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716864938; cv=none; b=cp0nl8kCq/W8yT+q1jVX4ERPTREBKZLCFvA/JpGgvxQfLbe85yaRdDvj2bPtZSPoVbmJlwnrVvuCoE2PJh8ixe6AC6VEotSpFsesRWYJ+VHNhzMZ3NK1jnfOPRjNSClBTGh94dxrM59UAlTJcu1wKAkSXig5H6jfAMUX5MvkpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716864938; c=relaxed/simple;
	bh=AS2BusS1O3jXMe5bD4wvQx6BF1Nr6GwmUVuZwhkYfyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV6FGFuBpEFl5PPyXNYwC3LbPX2T2VBOWJq9GEwCNehKHPANcImwgOJqz+Ge0cy90j0jURFrmX9h7zkHyERyp9nftvEPfFW4CEgf0b1u6DeP59+UIvy2fM1nWd9JM64RVqvqfPtcRV9ZYwLkrXITikfvh0rVdIshmxl5id/G1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnNvM5Cv; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d11ed39dbbso230320b6e.2;
        Mon, 27 May 2024 19:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716864936; x=1717469736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt4MQknB4C9uVe1D84gDXA/m34wGlxcFhAUEtoR9Nos=;
        b=JnNvM5Cv0FOdB1UcSDQQaCImxEdmiCcSTpYAYqEIxMbhZ7MOWXuDPTUwaNIW40fbEf
         NmYjeu4RAiaGyCnw2uX5jlAKuHqGpbkts17JeU0XD/k5dQHt8cZJPx8jIGKwK05EeOqX
         x2YOfkoN4dER7Vx+3905A8iYSK05ebmmsoKW/dpCpJ6x4iYjcjbDgvmNRDKSVfKL9zbA
         fxW0307KHT1vCd7IDH3b+BcvLgdM+jRZYkByYfW2AV8aowifcnA0icOHPIpt81nG1Uzi
         2s7dzQkL55SZfww8ZS9rhlEWrJXeaITQQtKR0AcZ4VhgjerRltRZNRdWrORS90R/G4jo
         UwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716864936; x=1717469736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt4MQknB4C9uVe1D84gDXA/m34wGlxcFhAUEtoR9Nos=;
        b=sMK+FZD6cfR/lcU5tCj5TdJBu6H4YJ771wIxQp8kHGZDfuY6COGeQ0P9zrXwjyFMMu
         kVlqN5wIN/O9oeimIKUxK3lLfqnuBzM+17L2A27bIGolLPIz6GRWCEqAk+9aVBnVJst4
         WMRsXYDFIDqbf7BwigOlcCjZQPyIeKqu+XzHVUANsiea01IoEsiu+gH85GUPOmraSj4a
         yLgYDimberptaOm5xa5gBgVmBw7sHuQLQYJKsbxfrXNxSIPLAMZ2qaHf0d0XZnweoMA3
         g8OZ+Mbl5LR0C8tLqsjlQ9H5kpJIQUbwyKa2q2En1ABbCQJCWQLgnyQCzhKv8G5Q7sfO
         ruVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2s3Gz/W3P2kEhsCGHGXghQbNkWUi8ibjddKtkkiz/59bPmUowBTmbVr8XOZx3GMrKTmbAAjkqJLlMYjNVXVwFpBAdrrPKk67EUCjz//sT75QcD/5WiXXjb6ziX4IcdO+GpJ/kkze9iWasrnYtBI1q
X-Gm-Message-State: AOJu0Yw7L/R3wcu0QpKoBAqckcFr9jwyM1mLmDfaXoh08t4OBvhf3gSB
	cdLD6XfVOn4FlGTyX88XTlHHoV4DSmVSKxjH/Is9KsZCsOZUkK65
X-Google-Smtp-Source: AGHT+IGUBneRh5CQRkUfAwUKoFgIvU3H0iARFLXD9JIi0ji16SZjBjNxg6IyQ+QZtQ+lfypih0Gi6w==
X-Received: by 2002:a05:6808:1993:b0:3ce:e166:6688 with SMTP id 5614622812f47-3d1a745c6d2mr13031981b6e.37.1716864936432;
        Mon, 27 May 2024 19:55:36 -0700 (PDT)
Received: from archlinux ([240d:1a:13a:f00:f3a2:fbda:2824:ae0e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeadc5sm5517307b3a.119.2024.05.27.19.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 19:55:36 -0700 (PDT)
Date: Tue, 28 May 2024 11:55:33 +0900
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Fix stack trace entry generated by
 ftrace_pid_func()
Message-ID: <wic55fclchlbs64bvbdiqmwayob3psytdgxlb7vgkspyuh5ev3@umi7etrknhg2>
References: <20240527100916.5737-2-tatsuya.s2862@gmail.com>
 <20240527194914.2d25c4ec@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <20240527194914.2d25c4ec@rorschach.local.home>

On Mon, May 27, 2024 at 07:49:14PM GMT, Steven Rostedt wrote:
> On Mon, 27 May 2024 18:44:56 +0900
> Tatsuya S <tatsuya.s2862@gmail.com> wrote:
> 
> > On setting set_ftrace_pid, a extra entry generated by ftrace_pid_func()
> > is shown on stack trace(CONFIG_UNWINDER_FRAME_POINTER=y).
> > 
> >         [004] .....    68.459382: <stack trace>
> >  => 0xffffffffa00090af
> >  => ksys_read
> >  => __x64_sys_read
> >  => x64_sys_call
> >  => do_syscall_64
> >  => entry_SYSCALL_64_after_hwframe  
> > 
> > To resolve this issue, increment skip count
> > in function_stack_trace_call() if pids are set.
> 
> Just a note, this isn't a "fix" but simply an improvement in output.
> I'm happy to take this (after testing and more reviewing), but it will
> be for the next merge window, and with a different subject line.
> 
>   "ftrace: Hide one more entry in stack trace when ftrace_pid is enabled"
> 
> Or something like that.
> 
> Thanks,
> 
> -- Steve
I will send patch with new subject line.

Thank you.

Tatsuya

