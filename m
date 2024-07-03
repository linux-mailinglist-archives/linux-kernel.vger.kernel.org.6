Return-Path: <linux-kernel+bounces-240016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843C9267ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB52B25729
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB718754E;
	Wed,  3 Jul 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvn23PIg"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE21862A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030509; cv=none; b=XoYuqj4PboPR4XxNoZMPUC2rCyXfqzubVBnzfNFdeEWURr1OowBEKckKB4ktU82BOpEfcbKMR0uaPXAb4LB7T3AiMNafGKuhM/6ah188WArKfvtePU5Yz49uJuy7h/t+C/wbUE8qHnH51jQgMP8X4WiIT/2F+OVSVozEobaaQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030509; c=relaxed/simple;
	bh=GVMiYd1YPD4ViR7bJefM84jIGSsmyyiLJmbByp0VRVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsWCqgYoCLGQOY1RR8jOK0PppkHLLDXeDP0NRT/s8jXQQemYg4GxgzDc6h/lFAb4HOaq2mqtQ2heGdW9zDEbcg+awvPLOe4m2qF50Zmn2YyunrD+j5G2MwdX4GdwV14Kk/+EWGPN8Ld7IyMqND63moJdYEjMFHFjIPBIP2Ajpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvn23PIg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7066a3229f4so3828779b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720030507; x=1720635307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUBh4HJFbwCunvYW2TT9Lv7hcZt9lFP+VL8eZ2hanxo=;
        b=Xvn23PIgl+71QfwPKKTzEHGpw8QMOL6o3pX7XVPFxZ+Slo4MTxLll/Y9TtRtIQEAx8
         zOljUPFhCPo3q9o8JRFD5W1dkCIrRYhAUAEj16UrLZOj//2AoOyLTtyuSIHZ1QO4/5TM
         EK0N1kGVC5s0eMZT90CleOCamBO/QjlpnsxhUkVq6cMltsZScZ+nsgk6DWWYvOD7+zCD
         UZxi/16PYR1yjlHP/hRWFC/cAIxfwECZ39dD6mcWmypUr3W6N5lmhKwHujGt9gzVVVKZ
         RIs0EFcvcNGFrSQuARuLt2jbRr1Pp7quZhz6EJdVWtOiCnUSPuF8LyVYoeDzMbDPGp9o
         Go+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030507; x=1720635307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUBh4HJFbwCunvYW2TT9Lv7hcZt9lFP+VL8eZ2hanxo=;
        b=ryoBovuiL7LPhrG2WG0AWYUUBoz0pmSclNNtaS75s+4LoWHL9m0ifuCX+jCulnJFJl
         bRwposXAE+qbvbm6y0UkCVGLxBve2l3dBbBLZnHv2j9vyl1hLxeYAkZh8WyN399pevuP
         BBIW7TBMH5xobaSejs9/V5cR8/2Ktc9gkFwWEr4xFj0Z5DKVGGpAzQXFTlWJcYc6XVif
         lwj44dw4zuz7btreHCmzbCj0pFJIn4QdapWheT6GIainUjWVmfAa+gWmgAiN5/UcPNP2
         kcXJrRPw7XkKtiz2hy7q430koM+NqMICITnvDpvk8VvBqkd5wJv+Wq/6q2YbOQ6zYDNO
         a1Lg==
X-Gm-Message-State: AOJu0YyprURwAmnaVEcY/OpbQU6Lo2ysqtwcEB2/RguI/VSCeIC++eCX
	aJSWl5mlpaZfsiRDa8UQ/YnEOCTLm6QMwEJREeiu1rCaPFkKFa61
X-Google-Smtp-Source: AGHT+IFgbyqvQQ39ZO1Uk1HtZc6612EMASxqn4YdKQqFKk20scgiATwbm2rhPqvtXhFMTrglELabwg==
X-Received: by 2002:a05:6a20:431b:b0:1be:d74c:dd5a with SMTP id adf61e73a8af0-1bef6101c9bmr13245143637.23.1720030506950;
        Wed, 03 Jul 2024 11:15:06 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c967df1e2bsm3128889a91.9.2024.07.03.11.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:15:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 08:15:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/ext: Add BPF functions for uclamp inc and dec
Message-ID: <ZoWVKQ7sD5uz66w5@slm.duckdns.org>
References: <cover.1719999165.git.hongyan.xia2@arm.com>
 <34f3e33aa236445d677ea2b48d2d556178c1ac34.1719999165.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f3e33aa236445d677ea2b48d2d556178c1ac34.1719999165.git.hongyan.xia2@arm.com>

Hello.

On Wed, Jul 03, 2024 at 11:07:48AM +0100, Hongyan Xia wrote:
> +__bpf_kfunc void scx_bpf_uclamp_rq_inc(s32 cpu, struct task_struct *p)
> +{
> +	uclamp_rq_inc(cpu_rq(cpu), p);
> +}
> +
> +__bpf_kfunc void scx_bpf_uclamp_rq_dec(s32 cpu, struct task_struct *p)
> +{
> +	uclamp_rq_dec(cpu_rq(cpu), p);
> +}

So, I don't think we can expose these functions directly to the BPF
scheduler. The BPF schedulers shouldn't be able to break system integrity no
matter what they do and with the above it'd be trivial to get the bucket
counters unbalanced, right?

Thanks.

-- 
tejun

